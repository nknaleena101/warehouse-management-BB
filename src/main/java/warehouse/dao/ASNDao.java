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

                asnStmt.executeUpdate();

                // Get generated ASN ID
                try (ResultSet generatedKeys = asnStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int asnId = generatedKeys.getInt(1);
                        asn.setAsnId(asnId);

                        // 2. Insert ASN items
                        String itemSql = "INSERT INTO asn_items (asn_id, product_id, quantity) VALUES (?, ?, ?)";
                        try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
                            for (ASNItem item : asn.getItems()) {
                                itemStmt.setInt(1, asnId);
                                itemStmt.setInt(2, item.getProductId());
                                itemStmt.setInt(3, item.getQuantity());
                                itemStmt.addBatch();
                            }
                            itemStmt.executeBatch();
                        }
                    }
                }
            }
            conn.commit(); // Commit transaction
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.setAutoCommit(true);
        }
    }

    public List<ASN> getAllASNs() throws SQLException {
        List<ASN> asnList = new ArrayList<>();
        String sql = "SELECT * FROM asn_data ORDER BY created_at DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

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

    public List<ASNItem> getItemsForASN(int asnId) throws SQLException {
        List<ASNItem> items = new ArrayList<>();
        String sql = "SELECT * FROM asn_items WHERE asn_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, asnId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ASNItem item = new ASNItem();
                    item.setItemId(rs.getInt("item_id"));
                    item.setAsnId(rs.getInt("asn_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    items.add(item);
                }
            }
        }
        System.out.println("[DEBUG] Loaded " + items.size() + " items for ASN " + asnId);
        return items;
    }
}
