package warehouse.dao;

import warehouse.model.ASN;
import warehouse.model.ASNItem;
import warehouse.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ASNDao {
    public void createASN(ASN asn) throws SQLException {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Insert ASN header
            String asnSql = "INSERT INTO asn_data (supplier_name, expected_delivery_date, status) VALUES (?, ?, ?)";
            try (PreparedStatement asnStmt = conn.prepareStatement(asnSql, Statement.RETURN_GENERATED_KEYS)) {
                asnStmt.setString(1, asn.getSupplierName());
                asnStmt.setDate(2, new java.sql.Date(asn.getExpectedDeliveryDate().getTime()));
                asnStmt.setString(3, asn.getStatus());

                int affectedRows = asnStmt.executeUpdate();

                if (affectedRows == 0) {
                    throw new SQLException("Creating ASN failed, no rows affected.");
                }

                // Get generated ASN ID
                try (ResultSet generatedKeys = asnStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int asnId = generatedKeys.getInt(1);
                        asn.setAsnId(asnId);

                        // 2. Insert ASN items if they exist
                        if (asn.getItems() != null && !asn.getItems().isEmpty()) {
                            insertASNItems(conn, asnId, asn.getItems());
                        }
                    } else {
                        throw new SQLException("Creating ASN failed, no ID obtained.");
                    }
                }
            }
            conn.commit(); // Commit transaction
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    private void insertASNItems(Connection conn, int asnId, List<ASNItem> items) throws SQLException {
        String itemSql = "INSERT INTO asn_items (asn_id, product_id, quantity) VALUES (?, ?, ?)";
        try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
            for (ASNItem item : items) {
                itemStmt.setInt(1, asnId);
                itemStmt.setInt(2, item.getProductId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();
        }
    }

    public List<ASN> getAllASNs() throws SQLException {
        List<ASN> asnList = new ArrayList<>();
        String sql = "SELECT * FROM asn_data ORDER BY created_at DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ASN asn = new ASN(
                        rs.getInt("asn_id"),
                        rs.getString("supplier_name"),
                        rs.getDate("expected_delivery_date"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                );

                // Load items for each ASN
                asn.setItems(getItemsForASN(asn.getAsnId()));
                asnList.add(asn);
            }
        }
        return asnList;
    }

    public List<ASNItem> getItemsForASN(int asnId) throws SQLException {
        List<ASNItem> items = new ArrayList<>();
        String sql = "SELECT * FROM asn_items WHERE asn_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, asnId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ASNItem item = new ASNItem(
                            rs.getInt("item_id"),
                            rs.getInt("asn_id"),
                            rs.getInt("product_id"),
                            rs.getInt("quantity")
                    );
                    items.add(item);
                }
            }
        }
        return items;
    }

    // Additional utility method to get pending ASNs
    public List<ASN> getPendingASNs() throws SQLException {
        List<ASN> asnList = new ArrayList<>();
        String sql = "SELECT * FROM asn_data WHERE status = 'Expected' ORDER BY expected_delivery_date ASC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ASN asn = new ASN(
                        rs.getInt("asn_id"),
                        rs.getString("supplier_name"),
                        rs.getDate("expected_delivery_date"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                );
                asnList.add(asn);
            }
        }
        return asnList;
    }
    public void updateASNStatus(int asnId, String status) throws SQLException {
        String sql = "UPDATE asn_data SET status = ? WHERE asn_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, asnId);
            stmt.executeUpdate();
        }
    }

    public void recordInspectionDetails(int asnId, String inspectorName, String notes, boolean passed)
            throws SQLException {
        String sql = "INSERT INTO inspections (asn_id, inspector_name, notes, passed, inspection_date) " +
                "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, asnId);
            stmt.setString(2, inspectorName);
            stmt.setString(3, notes);
            stmt.setBoolean(4, passed);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating inspection failed, no rows affected.");
            }
        }
    }
    // Add this method to ASNDao
    public List<ASN> getASNsByStatus(String status) throws SQLException {
        List<ASN> asnList = new ArrayList<>();
        String sql = "SELECT * FROM asn_data WHERE status = ? ORDER BY expected_delivery_date";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ASN asn = new ASN(
                            rs.getInt("asn_id"),
                            rs.getString("supplier_name"),
                            rs.getDate("expected_delivery_date"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at")
                    );
                    asnList.add(asn);
                }
            }
        }
        return asnList;
    }
}