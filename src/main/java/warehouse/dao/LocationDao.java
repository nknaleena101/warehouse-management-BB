package warehouse.dao;

import warehouse.model.Location;
import warehouse.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LocationDao {

    private static Location getLocationById(int id) {
        Location location = null;

        String sql = "SELECT * FROM location WHERE id = ?";
        try(
                Connection conn = DatabaseUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
        ){
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                location = new Location();
                location.setZone(rs.getString("zone"));
                location.setShelf(rs.getString("shelf"));
                location.setRack(rs.getString("rack"));
                location.setLocationId(rs.getInt("location_id"));
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        return  location;
    }

    public static List<Location> getAllLocations() {
        List<Location> locations = new ArrayList<>();
        String sql = "SELECT * FROM locations";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Location location = new Location();
                location.setLocationId(rs.getInt("location_id"));
                location.setZone(rs.getString("zone"));
                location.setRack(rs.getString("rack"));
                location.setShelf(rs.getString("shelf"));
                locations.add(location);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getAllLocations: " + e.getMessage());
            e.printStackTrace();
        }
        return locations;
    }

    public static boolean createLocation(Location location) {
        String sql = "INSERT INTO locations (location_id, zone, rack, shelf) VALUES (NULL, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, location.getZone());
            ps.setString(2, location.getRack());
            ps.setString(3, location.getShelf());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        location.setLocationId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static String testConnection() {
        try (Connection conn = DatabaseUtil.getConnection()) {
            return "Connection successful to: " + conn.getMetaData().getURL();
        } catch (SQLException e) {
            return "Connection failed: " + e.getMessage();
        }
    }

}