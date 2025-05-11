package warehouse.model;

public class Product {
    private int id;
    private String sku;
    private String name;
    private String description;
    // other fields as needed


    public Product(int id, String sku, String name, String description) {
        this.id = id;
        this.sku = sku;
        this.name = name;
        this.description = description;
    }

    public Product() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}