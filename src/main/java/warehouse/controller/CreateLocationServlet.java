package warehouse.controller;

import warehouse.dao.LocationDao;
import warehouse.model.Location;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/createLocation")
public class CreateLocationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form data
            String zone = request.getParameter("zone");
            int rack = Integer.parseInt(request.getParameter("rack"));
            int shelf = Integer.parseInt(request.getParameter("shelf"));

            // Create Location object
            Location location = new Location();
            location.setZone(zone);
            location.setRack("R" + rack); // Format as R1, R2, etc.
            location.setShelf("S" + shelf); // Format as S1, S2, etc.

            // Save to database (we'll need to update LocationDao)
            boolean success = LocationDao.createLocation(location);

            if (success) {
                response.sendRedirect("inventory?success=Location created successfully");
            } else {
                response.sendRedirect("inventory?error=Failed to create location");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("inventory?error=Error creating location: " + e.getMessage());
        }
    }
}