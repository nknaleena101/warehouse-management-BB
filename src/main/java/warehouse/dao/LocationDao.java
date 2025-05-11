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
    public Location getLocationByCode(String locationCode) throws SQLException {
        String sql = "SELECT * FROM locations WHERE location_code = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, locationCode);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapLocation(rs);
                }
            }
        }
        return null;
    }

    public List<Location> getAvailableLocations() throws SQLException {
        List<Location> locations = new ArrayList<>();
        String sql = "SELECT * FROM locations WHERE status = 'Available' OR status = 'Empty'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                locations.add(mapLocation(rs));
            }
        }
        return locations;
    }

    private Location mapLocation(ResultSet rs) throws SQLException {
        Location location = new Location();
        location.setLocationId(rs.getInt("location_id"));
        location.setLocationCode(rs.getString("location_code"));
        location.setZone(rs.getString("zone"));
        location.setAisle(rs.getString("aisle"));
        location.setRack(rs.getString("rack"));
        location.setShelf(rs.getString("shelf"));
        location.setCapacity(rs.getInt("capacity"));
        location.setCurrentQuantity(rs.getInt("current_quantity"));
        location.setStatus(rs.getString("status"));
        return location;
    }
}