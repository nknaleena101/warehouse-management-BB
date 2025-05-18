package warehouse.controller;

import warehouse.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/orders/packing")
class PackingServlet extends HttpServlet {
    private OrderService orderService = new OrderService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            // Update order status to Packed
            boolean success = orderService.updateOrderItemsStatus(orderId, "Packed");

            response.setContentType("application/json");
            response.getWriter().write(String.format(
                    "{\"success\":%b, \"message\":\"%s\"}",
                    success,
                    success ? "Order packed successfully" : "Failed to pack order"
            ));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false, \"message\":\"Error processing request\"}");
        }
    }
}
