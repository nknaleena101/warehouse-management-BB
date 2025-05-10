package warehouse.dao;

import warehouse.model.ASN;
import warehouse.model.ASNItem;
import warehouse.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ASNDao {
    public void createASN(ASN asn) throws SQLException {
        String sql = "INSERT INTO asn_data (supplier_name, expected_delivery_date, status) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, asn.getSupplierName());
            stmt.setDate(2, new java.sql.Date(asn.getExpectedDeliveryDate().getTime()));
            stmt.setString(3, asn.getStatus());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating ASN failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    asn.setAsnId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating ASN failed, no ID obtained.");
                }
            }
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
                    items.add(new ASNItem(
                            rs.getInt("item_id"),
                            rs.getInt("asn_id"),
                            rs.getInt("product_id"),
                            rs.getInt("quantity")
                    ));
                }
            }
        }
        return items;
    }
}
