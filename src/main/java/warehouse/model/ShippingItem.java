package warehouse.model;

public class ShippingItem {

    private String orderId;
    private String destination;
    private String itemsShipped;
    private String carrier;
    private String tracking;
    private String shippedDate;
    private String expectedArrival;
    private String status;

    // Getter and Setter for orderId
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    // Getter and Setter for destination
    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    // Getter and Setter for itemsShipped
    public String getItemsShipped() {
        return itemsShipped;
    }

    public void setItemsShipped(String itemsShipped) {
        this.itemsShipped = itemsShipped;
    }

    // Getter and Setter for carrier
    public String getCarrier() {
        return carrier;
    }

    public void setCarrier(String carrier) {
        this.carrier = carrier;
    }

    // Getter and Setter for tracking
    public String getTracking() {
        return tracking;
    }

    public void setTracking(String tracking) {
        this.tracking = tracking;
    }

    // Getter and Setter for shippedDate
    public String getShippedDate() {
        return shippedDate;
    }

    public void setShippedDate(String shippedDate) {
        this.shippedDate = shippedDate;
    }

    // Getter and Setter for expectedArrival
    public String getExpectedArrival() {
        return expectedArrival;
    }

    public void setExpectedArrival(String expectedArrival) {
        this.expectedArrival = expectedArrival;
    }

    // Getter and Setter for status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
