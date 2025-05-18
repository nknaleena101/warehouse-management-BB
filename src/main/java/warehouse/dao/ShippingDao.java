package warehouse.dao;

import warehouse.model.ShippingItem;
import warehouse.util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShippingDao {

    // Get all packed orders for dropdown
    public List<ShippingItem> getPackedOrders() throws SQLException {
        List<ShippingItem> orders = new ArrayList<>();
        String sql = "SELECT DISTINCT d.order_id, d.destination " +
                "FROM delivery_orders d " +
                "JOIN order_items o ON d.order_id = o.order_id " +
                "WHERE o.status = 'Packed' AND d.status != 'Shipped'";

        System.out.println("Executing SQL: " + sql);

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("Query executed, processing results...");
            int count = 0;

            while (rs.next()) {
                ShippingItem item = new ShippingItem();
                item.setOrderId(rs.getInt("order_id"));
                item.setDestination(rs.getString("destination"));
                orders.add(item);
                count++;

                System.out.println("Found order: ID=" + item.getOrderId() +
                        ", Destination=" + item.getDestination());
            }

            System.out.println("Total packed orders found: " + count);
        }
        return orders;
    }

    // Process shipping
    public boolean processShipping(ShippingItem shippingItem) throws SQLException {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Insert shipping info
            String shippingSql = "INSERT INTO shipping_info (order_id, carrier, tracking_number, expected_arrival, shipped_at) " +
                    "VALUES (?, ?, ?, ?, NOW())";
            try (PreparedStatement shippingStmt = conn.prepareStatement(shippingSql, Statement.RETURN_GENERATED_KEYS)) {
                shippingStmt.setInt(1, shippingItem.getOrderId());
                shippingStmt.setString(2, shippingItem.getCarrier());
                shippingStmt.setString(3, shippingItem.getTrackingNumber());
                shippingStmt.setDate(4, new java.sql.Date(shippingItem.getExpectedArrival().getTime()));
                shippingStmt.executeUpdate();
            }

            // 2. Update order status to Shipped
            String orderSql = "UPDATE delivery_orders SET status = 'Shipped' WHERE order_id = ?";
            try (PreparedStatement orderStmt = conn.prepareStatement(orderSql)) {
                orderStmt.setInt(1, shippingItem.getOrderId());
                orderStmt.executeUpdate();
            }

            // 3. Update inventory (subtract quantities)
            String inventorySql = "UPDATE products p " +
                    "JOIN order_items o ON p.id = o.product_id " +
                    "SET p.quantity = p.quantity - o.quantity " +
                    "WHERE o.order_id = ? AND o.status = 'Packed'";
            try (PreparedStatement inventoryStmt = conn.prepareStatement(inventorySql)) {
                inventoryStmt.setInt(1, shippingItem.getOrderId());
                inventoryStmt.executeUpdate();
            }

            // 4. Update order items status
            String itemsSql = "UPDATE order_items SET status = 'Packed' WHERE order_id = ?";
            try (PreparedStatement itemsStmt = conn.prepareStatement(itemsSql)) {
                itemsStmt.setInt(1, shippingItem.getOrderId());
                itemsStmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
}