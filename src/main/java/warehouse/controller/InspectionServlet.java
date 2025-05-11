package warehouse.controller;

import org.json.JSONException;
import org.json.JSONObject;
import warehouse.service.ASNService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/inbound/inspect")
public class InspectionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            // Read JSON request
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            JSONObject json = new JSONObject(sb.toString());
            int asnId = json.getInt("asnId");
            String inspectorName = json.getString("inspectorName");
            String notes = json.optString("notes", "");
            boolean passed = json.getBoolean("passed");

            // Validate input
            if (inspectorName == null || inspectorName.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("error", "Inspector name is required");
                out.write(jsonResponse.toString());
                return;
            }

            // Process inspection
            ASNService asnService = new ASNService();
            asnService.recordInspection(asnId, inspectorName, notes, passed);

            // Return success
            response.setStatus(HttpServletResponse.SC_OK);
            jsonResponse.put("status", "success");
            out.write(jsonResponse.toString());

        } catch (JSONException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse.put("error", "Invalid request format");
            out.write(jsonResponse.toString());
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("error", "Database error: " + e.getMessage());
            out.write(jsonResponse.toString());
            e.printStackTrace();
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("error", e.getMessage());
            out.write(jsonResponse.toString());
            e.printStackTrace();
        }
    }
}
