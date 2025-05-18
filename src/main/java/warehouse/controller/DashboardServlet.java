package warehouse.controller;

import warehouse.model.ASN;
import warehouse.model.DeliveryOrder;
import warehouse.service.ASNService;
import warehouse.service.OrderService;
import warehouse.service.StatsService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private ASNService asnService;
    private OrderService orderService;
    private StatsService statsService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.asnService = new ASNService();
        this.orderService = new OrderService();
        this.statsService = new StatsService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get recent ASNs (last 5)
            List<ASN> recentASNs = asnService.getRecentASNs(5);
            System.out.println("ASNs found: " + recentASNs.size());

            // Get recent Delivery Orders (last 5)
            List<DeliveryOrder> recentOrders = orderService.getRecentOrders(5);
            System.out.println("Orders found: " + recentOrders.size());

            // Get statistics
            int totalProducts = statsService.getTotalProductsCount();
            int pendingOrders = statsService.getPendingOrdersCount();
            int shippedOrders = statsService.getShippedOrdersCount();
            int expectedOrders = statsService.getExpectedOrdersCount();

            request.setAttribute("recentASNs", recentASNs);
            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("shippedOrders", shippedOrders);
            request.setAttribute("expectedOrders", expectedOrders);

            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
        }
    }
}