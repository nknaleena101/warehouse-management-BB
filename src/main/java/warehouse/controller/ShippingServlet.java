package warehouse.controller;

import warehouse.dao.ShippingDao;
import warehouse.dao.ShippingItemDao;
import warehouse.model.ShippingItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/shipping")
public class ShippingServlet extends HttpServlet {
    private ShippingItemDao shippingItemDao;
    private ShippingDao shippingDao;

    @Override
    public void init() {
        shippingItemDao = new ShippingItemDao();
        shippingDao = new ShippingDao();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<ShippingItem> packedOrders = shippingDao.getPackedOrders();
            request.setAttribute("packedOrders", packedOrders);
            List<ShippingItem> shippingItems = shippingItemDao.getAllShippingItems();
            request.setAttribute("shippingItems", shippingItems);
            request.getRequestDispatcher("/jsp/shipping.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving shipping data", e);
        }
    }
}