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

    public void recordPutaway(int productId, int quantity, String location) throws SQLException {
        // Check if product already exists in location
        String checkSql = "Select quantity from product_location where product_id = ? and location = ?";
        String updateSql = "UPDATE product_location SET quantity = quantity + ? WHERE product_id = ? AND location = ?";
        String insertSql = "INSERT INTO product_location (product_id, location, quantity) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection()) {
            // Check existing quantity
            int existingQuantity = 0;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, productId);
                checkStmt.setString(2, location);
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
                    updateStmt.setString(3, location);
                    updateStmt.executeUpdate();
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, productId);
                    insertStmt.setString(2, location);
                    insertStmt.setInt(3, quantity);
                    insertStmt.executeUpdate();
                }
            }
        }
    }

}