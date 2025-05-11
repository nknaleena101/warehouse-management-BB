package warehouse.controller;

import warehouse.model.ASN;
import warehouse.model.ASNItem;
import warehouse.service.ASNService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ASNServlet", urlPatterns = {"/asn", "/asn/create"})
public class ASNServlet extends HttpServlet {
    private ASNService asnService;

    @Override
    public void init() {
        asnService = new ASNService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the ASN creation form
        request.getRequestDispatcher("/jsp/asnForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get form parameters
        String supplierName = request.getParameter("supplierName");
        String deliveryDateStr = request.getParameter("expectedDeliveryDate");

        // 2. Initialize date variable
        Date deliveryDate = null;
        try {
            // Parse the date string into a Date object
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            deliveryDate = sdf.parse(deliveryDateStr);
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD.");
            request.getRequestDispatcher("/jsp/asnForm.jsp").forward(request, response);
            return; // Exit the method if date parsing fails
        }

        // 3. Collect items
        List<ASNItem> items = new ArrayList<>();
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");

        if (productIds != null && quantities != null && productIds.length == quantities.length) {
            for (int i = 0; i < productIds.length; i++) {
                try {
                    ASNItem item = new ASNItem();
                    item.setProductId(Integer.parseInt(productIds[i]));
                    item.setQuantity(Integer.parseInt(quantities[i]));
                    items.add(item);
                } catch (NumberFormatException e) {
                    // Handle invalid numbers
                    request.setAttribute("error", "Invalid product ID or quantity");
                    request.getRequestDispatcher("/jsp/asnForm.jsp").forward(request, response);
                    return;
                }
            }
        }

        // 4. Create and save ASN
        ASN asn = new ASN();
        asn.setSupplierName(supplierName);
        asn.setExpectedDeliveryDate(deliveryDate); // Now properly initialized
        asn.setStatus("Expected");
        asn.setItems(items);

        try {
            asnService.createASN(asn);
            response.sendRedirect(request.getContextPath() + "/asn/list");
        } catch (Exception e) {
            request.setAttribute("error", "Failed to create ASN: " + e.getMessage());
            request.getRequestDispatcher("/jsp/asnForm.jsp").forward(request, response);
        }
    }
}