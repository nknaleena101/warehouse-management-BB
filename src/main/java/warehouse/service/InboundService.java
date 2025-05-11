package warehouse.service;

import warehouse.dao.ASNDao;
import warehouse.dao.InboundDao;
import warehouse.dao.LocationDao;
import warehouse.dao.ProductDao;
import warehouse.model.ASN;
import warehouse.model.ASNItem;
import warehouse.model.Location;

import java.sql.SQLException;
import java.util.List;

public class InboundService {
    private final ASNDao asnDao;
    private final InboundDao inboundDao;
    private final LocationDao locationDao;
    private final ProductDao productDao;

    public InboundService() {
        this.asnDao = new ASNDao();
        this.inboundDao = new InboundDao();
        this.locationDao = new LocationDao();
        this.productDao = new ProductDao();
    }

    public void receiveGoods(int asnId) throws SQLException {
        // Update ASN status to "Received"
        asnDao.updateASNStatus(asnId, "Received");

        // Record receipt in inbound log
        inboundDao.recordReceipt(asnId);
    }

    public void recordInspection(int asnId, String inspectorName, String notes, boolean passed)
            throws SQLException {
        // Update ASN status based on inspection result
        String status = passed ? "Inspected" : "Inspection Failed";
        asnDao.updateASNStatus(asnId, status);

        // Record inspection details
        inboundDao.recordInspection(asnId, inspectorName, notes, passed);
    }

    public void completePutaway(int asnId, String locationCode) throws SQLException {
        // Get ASN items
        List<ASNItem> items = asnDao.getItemsForASN(asnId);

        // Get location
        Location location = locationDao.getLocationByCode(locationCode);
        if (location == null) {
            throw new SQLException("Location not found: " + locationCode);
        }

        // Update inventory for each item
        for (ASNItem item : items) {
            inboundDao.recordPutaway(item.getProductId(), item.getQuantity(), location.getLocationId());
        }

        // Update ASN status to "Putaway Complete"
        asnDao.updateASNStatus(asnId, "Putaway Complete");
    }

    public List<Location> getAvailableLocations() throws SQLException {
        return locationDao.getAvailableLocations();
    }
}