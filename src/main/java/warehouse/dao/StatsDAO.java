package warehouse.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import warehouse.util.DatabaseUtil;

public class StatsDAO {

    public int getTotalProductsCount() throws Exception {
        String sql = "SELECT SUM(ai.quantity) as total " +
                "FROM asn_items ai " +
                "JOIN asn_data ad ON ai.asn_id = ad.asn_id " +
                "WHERE ad.status = 'Putaway Complete'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        }
    }

    public int getPendingOrdersCount() throws Exception {
        String sql = "SELECT COUNT(*) as count FROM delivery_orders WHERE status != 'Shipped'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("count");
            }
            return 0;
        }
    }

    public int getShippedOrdersCount() throws Exception {
        String sql = "SELECT COUNT(*) as count FROM delivery_orders WHERE status = 'Shipped'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("count");
            }
            return 0;
        }
    }

    public int getExpectedOrdersCount() throws Exception {
        String sql = "SELECT COUNT(*) as count FROM asn_data WHERE status = 'Expected'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("count");
            }
            return 0;
        }
    }
}