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
public class PickingServlet extends HttpServlet {
    private OrderService orderService = new OrderService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get and validate orderId
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Order ID parameter is missing");
            }

            // Remove any non-numeric characters (in case it's "ORD-123")
            orderIdStr = orderIdStr.replaceAll("[^0-9]", "");

            int orderId = Integer.parseInt(orderIdStr);

//            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            System.out.println("Received update request for order: " + orderId + ", status: " + status);

            // Convert UI status to database statuses
            String orderStatus;
            String itemStatus;

            switch (status) {
                case "In Progress":
                    orderStatus = "Picking";
                    itemStatus = "Picked"; // Items are being picked
                    break;
                case "Completed":
                    orderStatus = "Packed";  // Order is packed and ready for shipping
                    itemStatus = "Packed";   // All items are picked
                    break;
                default: // "Not Started"
                    orderStatus = "Created";
                    itemStatus = "Requested";
            }

            System.out.println("Received orderId: " + orderIdStr);
            System.out.println("Received status: " + request.getParameter("status"));

            System.out.println("Updating order status to: " + orderStatus);
            System.out.println("Updating items status to: " + itemStatus);

            // First update the items status
            boolean itemsUpdated = orderService.updateOrderItemsStatus(orderId, itemStatus);

            // Then update the main order status
            boolean orderUpdated = orderService.updateOrderStatus(orderId, orderStatus);

            boolean success = itemsUpdated && orderUpdated;

            response.setContentType("application/json");
            response.getWriter().write(String.format(
                    "{\"success\":%b, \"message\":\"%s\"}",
                    success,
                    success ? "Status updated successfully" : "Failed to update status"
            ));
        } catch (NumberFormatException e) {
            System.err.println("Invalid order ID format");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false, \"message\":\"Invalid order ID\"}");
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false, \"message\":\"Database error: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false, \"message\":\"Unexpected error: " + e.getMessage() + "\"}");
        }
    }
}