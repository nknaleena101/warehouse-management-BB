package warehouse.model;

public class ASNItem {
    private int itemId;
    private int asnId;
    private int productId;
    private int quantity;

    public ASNItem() {
    }

    public ASNItem(int itemId, int asnId, int productId, int quantity) {
        this.itemId = itemId;
        this.asnId = asnId;
        this.productId = productId;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getAsnId() {
        return asnId;
    }

    public void setAsnId(int asnId) {
        this.asnId = asnId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
