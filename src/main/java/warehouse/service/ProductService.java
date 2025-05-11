package warehouse.service;

import warehouse.dao.ProductDao;
import warehouse.model.Product;

import java.sql.SQLException;
import java.util.List;

public class ProductService {
    private ProductDao productDao;

    public ProductService() {
        this.productDao = new ProductDao();
    }

    public List<Product> getAllProducts() throws SQLException {
        return productDao.getAllProducts();
    }
}