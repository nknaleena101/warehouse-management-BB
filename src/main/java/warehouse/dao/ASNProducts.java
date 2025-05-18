package warehouse.dao;

import warehouse.model.ASNItem;
import warehouse.model.Product;
import warehouse.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ASNProducts {
    public static List<ASNItem> getAllProducts() throws SQLException {
        List<ASNItem> ASNProducts = new ArrayList<>();
        String sql = "SELECT * FROM asn_items";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ASNItem product = new ASNItem(
                        rs.getInt("item_id"),
                        rs.getInt("asn_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity")
                );
                ASNProducts.add(product);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return ASNProducts;
    }
}