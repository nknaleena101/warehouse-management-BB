package warehouse.service;

import warehouse.dao.ShippingItemDao;
import warehouse.model.ShippingItem;

import java.sql.SQLException;
import java.util.List;

public class ShippingService {
    public ShippingItemDao shippingItemDao;

    public ShippingService() {
        this.shippingItemDao = new ShippingItemDao();
    }

    public List<ShippingItem> getAllShippingItems() throws SQLException {
        return shippingItemDao.getAllShippingItems();
    }
}
