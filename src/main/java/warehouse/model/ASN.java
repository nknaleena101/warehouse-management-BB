package warehouse.model;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public class ASN {
    private int asnId;
    private String supplierName;
    private Date expectedDeliveryDate;
    private String status;
    private Date createdAt;
    private List<ASNItem> items;

    // Default constructor
    public ASN() {
    }

    // Constructor without items (for simpler cases)
    public ASN(int asnId, String supplierName, Date expectedDeliveryDate, String status, Date createdAt) {
        this.asnId = asnId;
        this.supplierName = supplierName;
        this.expectedDeliveryDate = expectedDeliveryDate;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Full constructor with items
    public ASN(int asnId, String supplierName, Date expectedDeliveryDate, String status, Date createdAt, List<ASNItem> items) {
        this.asnId = asnId;
        this.supplierName = supplierName;
        this.expectedDeliveryDate = expectedDeliveryDate;
        this.status = status;
        this.createdAt = createdAt;
        this.items = items;
    }

    // Getters and setters remain the same
    public int getAsnId() {
        return asnId;
    }

    public void setAsnId(int asnId) {
        this.asnId = asnId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public Date getExpectedDeliveryDate() {
        return expectedDeliveryDate;
    }

    public void setExpectedDeliveryDate(Date expectedDeliveryDate) {
        this.expectedDeliveryDate = expectedDeliveryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public List<ASNItem> getItems() {
        return items;
    }

    public void setItems(List<ASNItem> items) {
        this.items = items;
    }
}