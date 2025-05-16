package warehouse.dao;

import warehouse.model.Location;
import warehouse.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

        String sql = "select * from locations";
        try(Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.executeQuery(sql);

            ResultSet rs = stmt.getResultSet();
            while (rs.next()) {
                Location location = new Location();
                location.setLocationId(rs.getInt("location_id"));
                location.setRack(rs.getString("rack"));
                location.setZone(rs.getString("zone"));
                location.setShelf(rs.getString("shelf"));
                locations.add(location);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return  locations;
    }
//
//    private Location mapLocation(ResultSet rs) throws SQLException {
//        Location location = new Location();
//        location.setLocationId(rs.getInt("location_id"));
//        location.setLocationCode(rs.getString("location_code"));
//        location.setZone(rs.getString("zone"));
//        location.setAisle(rs.getString("aisle"));
//        location.setRack(rs.getString("rack"));
//        location.setShelf(rs.getString("shelf"));
//        location.setCapacity(rs.getInt("capacity"));
//        location.setCurrentQuantity(rs.getInt("current_quantity"));
//        location.setStatus(rs.getString("status"));
//        return location;
//    }

}