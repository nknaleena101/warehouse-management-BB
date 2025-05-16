package warehouse.model;

import java.util.Date;
import java.util.List;

public class DeliveryOrder {
    private int orderId;
    private String destination;
    private Date orderDate;
    private String status;
    private List<OrderItem> items;

    // Constructors
    public DeliveryOrder() {}

    public DeliveryOrder(int orderId, String destination, Date orderDate, String status) {
        this.orderId = orderId;
        this.destination = destination;
        this.orderDate = orderDate;
        this.status = status;
    }

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
}