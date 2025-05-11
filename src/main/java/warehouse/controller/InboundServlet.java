package warehouse.controller;

import warehouse.model.ASN;
import warehouse.model.Product;
import warehouse.service.ASNService;
import warehouse.service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/inbound")
public class InboundServlet extends HttpServlet {
    private ASNService asnService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.asnService = new ASNService();
        this.productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get pending ASNs (status = Expected)
            List<ASN> pendingAsns = asnService.getASNsByStatus("Expected");

            // Get products for ASN creation form
            List<Product> products = productService.getAllProducts();

            request.setAttribute("pendingAsns", pendingAsns);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/jsp/inbound.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading inbound page: " + e.getMessage());
            request.getRequestDispatcher("/jsp/inbound.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle form submissions for ASN creation, receipt confirmation, etc.
        // Implementation would go here
    }
}