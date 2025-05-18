package warehouse.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import warehouse.util.DatabaseUtil;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> inventoryList = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection()) {
            // Query to get ASN items with Putaway Complete status and their locations
            String sql = "SELECT ai.product_id, pl.quantity, pl.location " +
                    "FROM asn_data ad " +
                    "JOIN asn_items ai ON ad.asn_id = ai.asn_id " +
                    "LEFT JOIN product_location pl ON ai.product_id = pl.product_id " +
                    "WHERE ad.status = 'Putaway Complete'";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("product_id", rs.getInt("product_id"));
                    item.put("quantity", rs.getInt("quantity"));

                    // Format location string (convert from "A-R1-S1" to "Zone A, Rack R1, Shelf S1")
                    String location = rs.getString("location");
                    if (location != null) {
                        String[] parts = location.split("-");
                        if (parts.length == 3) {
                            location = String.format("Zone %s, Rack %s, Shelf %s",
                                    parts[0], parts[1], parts[2]);
                        }
                    } else {
                        location = "Not assigned";
                    }

                    item.put("location", location);
                    inventoryList.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle error appropriately
        }

        request.setAttribute("inventoryList", inventoryList);
        request.getRequestDispatcher("/jsp/inventory.jsp").forward(request, response);
    }
}