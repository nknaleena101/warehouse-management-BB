package warehouse.service;

import warehouse.model.DeliveryOrder;
import warehouse.model.OrderItem;
import warehouse.dao.OrderDao;
import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private OrderDao orderDao;

    public OrderService() {
        this.orderDao = new OrderDao();
    }

    public List<DeliveryOrder> getRecentOrders(int count) throws SQLException {
        return orderDao.getRecentOrders(count);
    }

    public int createOrder(DeliveryOrder order, List<OrderItem> items) throws SQLException {
        return orderDao.createOrder(order, items);
    }

    public List<Integer> getAvailableProducts() throws SQLException {
        return orderDao.getAvailableProducts();
    }

    public List<OrderItem> getOrderItems(int orderId) throws SQLException {
        return orderDao.getOrderItems(orderId);
    }

    // Add to OrderService.java
    public boolean updateOrderItemsStatus(int orderId, String status) throws SQLException {
        return orderDao.updateOrderItemsStatus(orderId, status);
    }

    public List<DeliveryOrder> getOrdersForPicking() throws SQLException {
        return orderDao.getOrdersForPicking();
    }

    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        return orderDao.updateOrderStatus(orderId, status);
    }
}