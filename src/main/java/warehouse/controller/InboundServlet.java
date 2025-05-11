package warehouse.controller;

import warehouse.model.ASN;
import warehouse.service.ASNService;
import warehouse.service.InboundService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "InboundServlet", urlPatterns = {"/inbound", "/inbound/receive"
//        "/inbound/inspect"
        , "/inbound/putaway"})
public class InboundServlet extends HttpServlet {
    private ASNService asnService;
    private InboundService inboundService;

    @Override
    public void init() {
        asnService = new ASNService();
        inboundService = new InboundService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get pending ASNs (status = 'Expected')
            List<ASN> pendingASNs = asnService.getASNsByStatus("Expected");
            request.setAttribute("pendingASNs", pendingASNs);

            // Get all products for ASN creation
            request.setAttribute("products", asnService.getAllProducts());

            request.getRequestDispatcher("/jsp/inbound.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading inbound page: " + e.getMessage());
            request.getRequestDispatcher("/jsp/inbound.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        try {
            switch (path) {
                case "/inbound/receive":
                    handleReceiveGoods(request, response);
                    break;
                case "/inbound/inspect":
                    handleInspection(request, response);
                    break;
                case "/inbound/putaway":
                    handlePutaway(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error processing request: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void handleReceiveGoods(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int asnId = Integer.parseInt(request.getParameter("asnId"));
        inboundService.receiveGoods(asnId);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    private void handleInspection(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Parse JSON from request body
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            sb.append(line);
        }
        String json = sb.toString();

        // In a real application, you'd use a JSON library like Jackson
        // This is simplified for demonstration
        int asnId = Integer.parseInt(extractValue(json, "asnId"));
        String inspectorName = extractValue(json, "inspectorName");
        String notes = extractValue(json, "notes");
        boolean passed = Boolean.parseBoolean(extractValue(json, "passed"));

        inboundService.recordInspection(asnId, inspectorName, notes, passed);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    private void handlePutaway(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Parse JSON from request body
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            sb.append(line);
        }
        String json = sb.toString();

        int asnId = Integer.parseInt(extractValue(json, "asnId"));
        String location = extractValue(json, "location");

        inboundService.completePutaway(asnId, location);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    // Helper method to extract values from simple JSON
    private String extractValue(String json, String key) {
        String searchKey = "\"" + key + "\":";
        int startIndex = json.indexOf(searchKey) + searchKey.length();
        int endIndex = json.indexOf(",", startIndex);
        if (endIndex == -1) {
            endIndex = json.indexOf("}", startIndex);
        }
        String value = json.substring(startIndex, endIndex).trim();
        if (value.startsWith("\"") && value.endsWith("\"")) {
            value = value.substring(1, value.length() - 1);
        }
        return value;
    }
}