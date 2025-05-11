package warehouse.controller;

import warehouse.model.ASN;
import warehouse.model.DeliveryOrder;
import warehouse.service.ASNService;
import warehouse.service.OrderService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private ASNService asnService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.asnService = new ASNService();
        this.orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get recent ASNs (last 5)
            System.out.println("DEBUG: Fetching ASNs...");
            List<ASN> recentASNs = asnService.getRecentASNs(5);
            System.out.println("DEBUG: Found " + recentASNs.size() + " ASNs");
            recentASNs.forEach(asn -> System.out.println(
                    "ASN ID: " + asn.getAsnId() +
                            " Supplier: " + asn.getSupplierName()
            ));
            System.out.println("Fetched " + recentASNs.size() + " ASNs"); // Debug line

            request.setAttribute("recentASNs", recentASNs);
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading ASN data");
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
        }
    }
}