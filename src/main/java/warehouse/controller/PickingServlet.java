package warehouse.controller;

import warehouse.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/orders/picking")
class PickingServlet extends HttpServlet {
    private OrderService orderService = new OrderService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            System.out.println("Received update request for order: " + orderId + ", status: " + status);
            System.out.println("PickingServlet reached!");
            System.out.println("Order ID: " + request.getParameter("orderId"));
            System.out.println("Status: " + request.getParameter("status"));

            // Convert UI status to database status
            String dbStatus;
            switch (status) {
                case "In Progress":
                    dbStatus = "Picking";
                    break;
                case "Completed":
                    dbStatus = "Packed";
                    break;
                default:
                    dbStatus = "Requested";
            }

            System.out.println("Updating to DB status: " + dbStatus);

            boolean success = orderService.updateOrderItemsStatus(orderId, dbStatus);

            if (success) {
                System.out.println("Update successful");
                // Also update the main order status if needed
                if ("Picked".equals(dbStatus)) {
                    orderService.updateOrderStatus(orderId, "Picking");
                }
            } else {
                System.out.println("Update failed - no rows affected");
            }

            response.setContentType("application/json");
            response.getWriter().write(String.format(
                    "{\"success\":%b, \"message\":\"%s\"}",
                    success,
                    success ? "Status updated" : "No items found to update"
            ));
        } catch (NumberFormatException e) {
            System.err.println("Invalid order ID format");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false, \"message\":\"Invalid order ID\"}");
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false, \"message\":\"Database error\"}");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false, \"message\":\"Unexpected error\"}");
        }
    }
}
