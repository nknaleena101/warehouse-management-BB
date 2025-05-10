package warehouse.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3406/swift_link_wms";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    public static void initializeDatabase() {
        String createTablesSQL =
                "CREATE TABLE IF NOT EXISTS asn_data (" +
                        "    asn_id INT AUTO_INCREMENT PRIMARY KEY," +
                        "    supplier_name VARCHAR(100) NOT NULL," +
                        "    expected_delivery_date DATE NOT NULL," +
                        "    status ENUM('Expected', 'Received') DEFAULT 'Expected'," +
                        "    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                        ");" +

                        "CREATE TABLE IF NOT EXISTS asn_items (" +
                        "    item_id INT AUTO_INCREMENT PRIMARY KEY," +
                        "    asn_id INT NOT NULL," +
                        "    product_id INT NOT NULL," +
                        "    quantity INT NOT NULL," +
                        "    FOREIGN KEY (asn_id) REFERENCES asn_data(asn_id)" +
                        ");";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(createTablesSQL);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
