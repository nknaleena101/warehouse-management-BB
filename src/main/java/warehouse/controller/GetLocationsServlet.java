package warehouse.controller;

import warehouse.dao.LocationDao;
import warehouse.model.Location;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;

@WebServlet("/getLocations")
public class GetLocationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<Location> locations = LocationDao.getAllLocations();
        String jsonResponse = new Gson().toJson(locations);

        // Only send the JSON response
        response.getWriter().write(jsonResponse);
    }
}