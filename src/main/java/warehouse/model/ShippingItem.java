package warehouse.model;

import java.util.Date;

public class ShippingItem {
    private int orderId;
    private String destination;
    private Date orderDate;
    private String carrier;
    private String trackingNumber;
    private Date expectedArrival;
    private Date shippedAt;
    private String status;
    private int productId;  // New field
    private int quantity;

    // Getters and Setters (add the new one)
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getCarrier() {
        return carrier;
    }

    public void setCarrier(String carrier) {
        this.carrier = carrier;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public Date getExpectedArrival() {
        return expectedArrival;
    }

    public void setExpectedArrival(Date expectedArrival) {
        this.expectedArrival = expectedArrival;
    }

    public Date getShippedAt() {
        return shippedAt;
    }

    public void setShippedAt(Date shippedAt) {
        this.shippedAt = shippedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}