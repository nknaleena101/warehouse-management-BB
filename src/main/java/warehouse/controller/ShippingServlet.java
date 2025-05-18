package warehouse.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.List;
import warehouse.model.ShippingItem;
import warehouse.dao.ShippingItemDao;

@WebServlet("/shipping")
public class ShippingServlet extends HttpServlet {

    private ShippingItemDao shippingItemDao;

    @Override
    public void init() {
        shippingItemDao = new ShippingItemDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        List<ShippingItem> shippingItems;
        try {
            shippingItems = shippingItemDao.getAllShippingItems();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        request.setAttribute("shippingItems", shippingItems);
        request.getRequestDispatcher("/jsp/shipping.jsp").forward(request, response);
    }
}