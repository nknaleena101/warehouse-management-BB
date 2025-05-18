package warehouse.controller;

import warehouse.model.ASN;
import warehouse.model.ASNItem;
import warehouse.model.Product;
import warehouse.service.ASNService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

@WebServlet(name = "ASNServlet", urlPatterns = {"/asn", "/asn/create", "/asn/list"})
public class ASNServlet extends HttpServlet {
    private ASNService asnService;

    @Override
    public void init() {
        asnService = new ASNService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<ASN> asnList = asnService.getAllASNs();

            request.setAttribute("asnList", asnList);

            request.getRequestDispatcher("/jsp/asnList.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error fetching ASNs: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error loading ASNs: " + e.getMessage());
            request.getRequestDispatcher("/jsp/asnList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");

        try {
            if (request.getServletPath().equals("/asn/create")) {
                ASN asn = parseASNFromRequest(request);

                if (!validateASN(asn)) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Invalid ASN data");
                    return;
                }

                boolean created = asnService.createASN(asn);
                if (created) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("ASN created successfully");
                    response.sendRedirect(request.getContextPath() +"/dashboard");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Failed to create ASN");
                }
            }
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(e.getMessage());
        } catch (ParseException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid date format: " + e.getMessage());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error processing request: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private ASN parseASNFromRequest(HttpServletRequest request) throws ParseException, NumberFormatException {
        // Debug: Print all received parameters
        System.out.println("Received parameters:");
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            System.out.println(paramName + ": " + request.getParameter(paramName));
        }

        String supplierName = request.getParameter("supplierName");
        String deliveryDateStr = request.getParameter("expectedDeliveryDate");
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");

        // Validate required fields
        if (supplierName == null || supplierName.trim().isEmpty()) {
            throw new IllegalArgumentException("Supplier name is required");
        }

        if (deliveryDateStr == null || deliveryDateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Expected delivery date is required");
        }

        // Parse delivery date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date deliveryDate;
        try {
            deliveryDate = sdf.parse(deliveryDateStr);
        } catch (ParseException e) {
            throw new ParseException("Invalid date format. Please use yyyy-MM-dd", e.getErrorOffset());
        }

        // Parse items
        List<ASNItem> items = new ArrayList<>();
        if (productIds != null && quantities != null && productIds.length == quantities.length) {
            for (int i = 0; i < productIds.length; i++) {
                ASNItem item = new ASNItem();
                item.setProductId(Integer.parseInt(productIds[i]));
                item.setQuantity(Integer.parseInt(quantities[i]));
                items.add(item);
            }
        }

        // Create ASN object
        ASN asn = new ASN();
        asn.setSupplierName(supplierName);
        asn.setExpectedDeliveryDate(deliveryDate);
        asn.setStatus("Expected");
        asn.setItems(items);

        return asn;
    }

    private boolean validateASN(ASN asn) {
        if (asn.getSupplierName() == null || asn.getSupplierName().trim().isEmpty()) {
            return false;
        }
        if (asn.getExpectedDeliveryDate() == null) {
            return false;
        }
        if (asn.getItems() == null || asn.getItems().isEmpty()) {
            return false;
        }
        for (ASNItem item : asn.getItems()) {
            if (item.getProductId() <= 0 || item.getQuantity() <= 0) {
                return false;
            }
        }
        return true;
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {
        try {
            // Reload products for the form
            List<Product> products = asnService.getAllProducts();
            request.setAttribute("products", products);
        } catch (Exception e) {
            // If we can't reload products, just continue with the error
        }

        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/jsp/asnForm.jsp").forward(request, response);
    }
}