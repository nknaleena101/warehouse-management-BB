package warehouse.controller;

import warehouse.dao.ShippingDao;
import warehouse.model.ShippingItem;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/shipping-process")
public class ShippingProcessServlet extends HttpServlet {
    private ShippingDao shippingDao;

    @Override
    public void init() {
        shippingDao = new ShippingDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<ShippingItem> packedOrders = shippingDao.getPackedOrders();
            request.setAttribute("packedOrders", packedOrders);

            // Debug output
            System.out.println("Number of packed orders found: " + packedOrders.size());
            packedOrders.forEach(order ->
                    System.out.println("Order ID: " + order.getOrderId() + ", Destination: " + order.getDestination()));

            request.getRequestDispatcher("/jsp/shipping.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading packed orders", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ShippingItem shippingItem = new ShippingItem();
            shippingItem.setOrderId(Integer.parseInt(request.getParameter("orderId")));
            shippingItem.setCarrier(request.getParameter("carrier"));
            shippingItem.setTrackingNumber(request.getParameter("trackingNumber"));

            // Parse date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date expectedArrival = dateFormat.parse(request.getParameter("expectedArrival"));
            shippingItem.setExpectedArrival(expectedArrival);

            // Process shipping
            boolean success = shippingDao.processShipping(shippingItem);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/shipping?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/shipping?error=true");
            }
        } catch (ParseException e) {
            throw new ServletException("Invalid date format", e);
        } catch (Exception e) {
            throw new ServletException("Error processing shipping", e);
        }
    }
}