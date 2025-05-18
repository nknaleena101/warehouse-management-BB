package warehouse.dao;

import warehouse.model.DeliveryOrder;
import warehouse.model.OrderItem;
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

    public int createOrder(DeliveryOrder order, List<OrderItem> items) throws SQLException {
        Connection conn = null;
        PreparedStatement orderStmt = null;
        PreparedStatement itemStmt = null;
        ResultSet generatedKeys = null;
        int orderId = 0;

        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Insert into delivery_orders
            String orderSql = "INSERT INTO delivery_orders (destination, order_date, status) VALUES (?, ?, ?)";
            orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setString(1, order.getDestination());
            orderStmt.setDate(2, new java.sql.Date(order.getOrderDate().getTime()));
            orderStmt.setString(3, order.getStatus());

            int affectedRows = orderStmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            // Get the generated order ID
            generatedKeys = orderStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }

            // Insert order items
            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, status) VALUES (?, ?, ?, ?)";
            itemStmt = conn.prepareStatement(itemSql);

            for (OrderItem item : items) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getProductId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setString(4, item.getStatus());
                itemStmt.addBatch();
            }

            itemStmt.executeBatch();

            conn.commit(); // Commit transaction
            return orderId;
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback(); // Rollback on error
            }
            throw e;
        } finally {
            if (generatedKeys != null) generatedKeys.close();
            if (orderStmt != null) orderStmt.close();
            if (itemStmt != null) itemStmt.close();
            if (conn != null) conn.close();
        }
    }

    public List<Integer> getAvailableProducts() throws SQLException {
        List<Integer> productIds = new ArrayList<>();
        String sql = "SELECT DISTINCT ai.product_id " +
                "FROM asn_data ad " +
                "JOIN asn_items ai ON ad.asn_id = ai.asn_id " +
                "WHERE ad.status = 'Putaway Complete'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                productIds.add(rs.getInt("product_id"));
            }
        }
        return productIds;
    }

    public List<OrderItem> getOrderItems(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(new OrderItem(
                            rs.getInt("order_item_id"),
                            rs.getInt("order_id"),
                            rs.getInt("product_id"),
                            rs.getInt("quantity"),
                            rs.getString("status")
                    ));
                }
            }
        }
        return items;
    }

    public boolean updateOrderItemsStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE order_items SET status = ? WHERE order_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public List<DeliveryOrder> getOrdersForPicking() throws SQLException {
        List<DeliveryOrder> orders = new ArrayList<>();
        String sql = "SELECT o.* FROM delivery_orders o " +
                "WHERE o.status IN ('Created', 'Picking') " +
                "ORDER BY o.order_date";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                DeliveryOrder order = new DeliveryOrder(
                        rs.getInt("order_id"),
                        rs.getString("destination"),
                        rs.getDate("order_date"),
                        rs.getString("status")
                );

                // Get items for this order
                List<OrderItem> items = getOrderItems(order.getOrderId());
                order.setItems(items);

                // Determine picking status based on items
                String pickingStatus = "Not Started";
                if (!items.isEmpty()) {
                    boolean allPicked = items.stream().allMatch(i -> "Picked".equals(i.getStatus()));
                    boolean anyPicking = items.stream().anyMatch(i -> "Picking".equals(i.getStatus()));

                    if (allPicked) {
                        pickingStatus = "Completed";
                    } else if (anyPicking) {
                        pickingStatus = "In Progress";
                    }
                }
                order.setPickingStatus(pickingStatus);

                orders.add(order);
            }
        }
        return orders;
    }

    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE delivery_orders SET status = ? WHERE order_id = ?";
        System.out.println("SU" + status +" "+ orderId);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }
}