package warehouse.dao;

import warehouse.model.DeliveryOrder;
import warehouse.util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    public List<DeliveryOrder> getRecentOrders(int count) throws SQLException {
        List<DeliveryOrder> orders = new ArrayList<>();
        String sql = "SELECT * FROM delivery_orders ORDER BY order_date DESC LIMIT ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, count);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    orders.add(new DeliveryOrder(
                            rs.getInt("order_id"),
                            rs.getString("destination"),
                            rs.getDate("order_date"),
                            rs.getString("status")
                    ));
                }
            }
        }
        return orders;
    }
}