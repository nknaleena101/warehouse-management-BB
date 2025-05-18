package warehouse.dao;

import warehouse.model.ShippingItem;
import warehouse.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShippingItemDao {
    public List<ShippingItem> getAllShippingItems() throws SQLException {
        List<ShippingItem> items = new ArrayList<>();
        String sql = "SELECT d.order_id, d.destination, d.order_date, d.status, o.product_id, o.quantity,o.status as ost, s.shipping_id, s.carrier, s.tracking_number, s.expected_arrival, s.shipped_at FROM delivery_orders d JOIN order_items o ON d.order_id = o.order_id JOIN shipping_info s ON d.order_id = s.order_id WHERE d.status = 'Shipped'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ShippingItem item = new ShippingItem();
                item.setOrderId(rs.getString("order_id")+"-"+ rs.getString("product_id"));
                item.setDestination(rs.getString("destination"));
                item.setItemsShipped(rs.getString("order_date"));
                item.setCarrier(rs.getString("carrier"));
                item.setTracking(rs.getString("tracking_number"));
                item.setShippedDate(rs.getString("shipped_at"));
                item.setExpectedArrival(rs.getString("expected_arrival"));
                item.setStatus(rs.getString("ost"));

                items.add(item);
            }
        }
        return items;
    }
}