package warehouse.service;

import warehouse.model.DeliveryOrder;
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
}