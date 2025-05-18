package warehouse.dao;

import warehouse.model.ShippingItem;
import warehouse.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShippingItemDao {
    public List<ShippingItem> getAllShippingItems() throws SQLException {
        List<ShippingItem> items = new ArrayList<>();
        String sql = "SELECT d.order_id, d.destination, d.order_date, " +
                "s.carrier, s.tracking_number, s.expected_arrival, " +
                "s.shipped_at, o.status as item_status, " +
                "o.product_id, o.quantity " +
                "FROM delivery_orders d " +
                "JOIN order_items o ON d.order_id = o.order_id " +
                "LEFT JOIN shipping_info s ON d.order_id = s.order_id " +
                "WHERE d.status = 'Shipped' " +
                "ORDER BY d.order_id, s.shipped_at";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ShippingItem item = new ShippingItem();
                item.setOrderId(rs.getInt("order_id"));
                item.setDestination(rs.getString("destination"));
                item.setOrderDate(rs.getDate("order_date"));
                item.setCarrier(rs.getString("carrier"));
                item.setTrackingNumber(rs.getString("tracking_number"));
                item.setExpectedArrival(rs.getDate("expected_arrival"));
                item.setShippedAt(rs.getTimestamp("shipped_at"));
                item.setStatus(rs.getString("item_status"));
                item.setProductId(rs.getInt("product_id")); // Add this to your model
                item.setQuantity(rs.getInt("quantity"));

                items.add(item);
            }
        }
        return items;
    }
}