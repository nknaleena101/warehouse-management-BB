package warehouse.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/wms";
    private static final String USER = "root";
    private static final String PASSWORD = "55555";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

//    public static void initializeDatabase() {
//        String createTablesSQL =
//                "CREATE TABLE IF NOT EXISTS asn_data (" +
//                        "    asn_id INT AUTO_INCREMENT PRIMARY KEY," +
//                        "    supplier_name VARCHAR(100) NOT NULL," +
//                        "    expected_delivery_date DATE NOT NULL," +
//                        "    status ENUM('Expected', 'Received', 'Inspected', 'Inspection Failed', 'Putaway Complete') DEFAULT 'Expected'," +
//                        "    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
//                        ");" +
//
//                        "CREATE TABLE IF NOT EXISTS asn_items (" +
//                        "    item_id INT AUTO_INCREMENT PRIMARY KEY," +
//                        "    asn_id INT NOT NULL," +
//                        "    product_id INT NOT NULL," +
//                        "    quantity INT NOT NULL," +
//                        "    FOREIGN KEY (asn_id) REFERENCES asn_data(asn_id)" +
//                        ");" +
//
//                        "CREATE TABLE IF NOT EXISTS inbound_log (" +
//                        "    log_id INT AUTO_INCREMENT PRIMARY KEY," +
//                        "    asn_id INT NOT NULL," +
//                        "    receipt_date TIMESTAMP NOT NULL," +
//                        "    FOREIGN KEY (asn_id) REFERENCES asn_data(asn_id)" +
//                        ");" +
//
//                        "CREATE TABLE IF NOT EXISTS inspections (" +
//                        "    inspection_id INT AUTO_INCREMENT PRIMARY KEY," +
//                        "    asn_id INT NOT NULL," +
//                        "    inspector_name VARCHAR(100) NOT NULL," +
//                        "    notes TEXT," +
//                        "    passed BOOLEAN NOT NULL," +
//                        "    inspection_date TIMESTAMP NOT NULL," +
//                        "    FOREIGN KEY (asn_id) REFERENCES asn_data(asn_id)" +
//                        ");" +
//
//                        "CREATE TABLE IF NOT EXISTS locations (" +
//                        "    location_id INT AUTO_INCREMENT PRIMARY KEY," +
//                        "    location_code VARCHAR(20) NOT NULL UNIQUE," +
//                        "    zone VARCHAR(10) NOT NULL," +
//                        "    aisle VARCHAR(10) NOT NULL," +
//                        "    rack VARCHAR(10) NOT NULL," +
//                        "    shelf VARCHAR(10) NOT NULL," +
//                        "    capacity INT NOT NULL," +
//                        "    current_quantity INT DEFAULT 0," +
//                        "    status ENUM('Empty', 'Available', 'Full') DEFAULT 'Empty'" +
//                        ");" +
//
//                        "CREATE TABLE IF NOT EXISTS product_location (" +
//                        "    location_id INT NOT NULL," +
//                        "    product_id INT NOT NULL," +
//                        "    quantity INT NOT NULL," +
//                        "    PRIMARY KEY (location_id, product_id)," +
//                        "    FOREIGN KEY (location_id) REFERENCES locations(location_id)" +
//                        ");";
//
//        try (Connection conn = getConnection();
//             Statement stmt = conn.createStatement()) {
//            stmt.execute(createTablesSQL);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}