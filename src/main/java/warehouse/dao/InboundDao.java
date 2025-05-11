package warehouse.dao;

import warehouse.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

public class InboundDao {
    public void recordReceipt(int asnId) throws SQLException {
        String sql = "INSERT INTO inbound_log (asn_id, receipt_date) VALUES (?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, asnId);
            stmt.setTimestamp(2, new Timestamp(new Date().getTime()));
            stmt.executeUpdate();
        }
    }

    public void recordInspection(int asnId, String inspectorName, String notes, boolean passed)
            throws SQLException {
        String sql = "INSERT INTO inspections (asn_id, inspector_name, notes, passed, inspection_date) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, asnId);
            stmt.setString(2, inspectorName);
            stmt.setString(3, notes);
            stmt.setBoolean(4, passed);
            stmt.setTimestamp(5, new Timestamp(new Date().getTime()));
            stmt.executeUpdate();
        }
    }

    public void recordPutaway(int productId, int quantity, int locationId) throws SQLException {
        // Check if product already exists in location
        String checkSql = "SELECT quantity FROM product_location WHERE product_id = ? AND location_id = ?";
        String updateSql = "UPDATE product_location SET quantity = quantity + ? WHERE product_id = ? AND location_id = ?";
        String insertSql = "INSERT INTO product_location (product_id, location_id, quantity) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection()) {
            // Check existing quantity
            int existingQuantity = 0;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, productId);
                checkStmt.setInt(2, locationId);
                java.sql.ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    existingQuantity = rs.getInt(1);
                }
            }

            // Update or insert
            if (existingQuantity > 0) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, quantity);
                    updateStmt.setInt(2, productId);
                    updateStmt.setInt(3, locationId);
                    updateStmt.executeUpdate();
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, productId);
                    insertStmt.setInt(2, locationId);
                    insertStmt.setInt(3, quantity);
                    insertStmt.executeUpdate();
                }
            }

            // Update location status
            updateLocationStatus(conn, locationId);
        }
    }

    private void updateLocationStatus(Connection conn, int locationId) throws SQLException {
        String sql = "UPDATE locations SET current_quantity = " +
                "(SELECT SUM(quantity) FROM product_location WHERE location_id = ?), " +
                "status = CASE " +
                "WHEN current_quantity >= capacity THEN 'Full' " +
                "WHEN current_quantity > 0 THEN 'Available' " +
                "ELSE 'Empty' END " +
                "WHERE location_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, locationId);
            stmt.setInt(2, locationId);
            stmt.executeUpdate();
        }
    }
}