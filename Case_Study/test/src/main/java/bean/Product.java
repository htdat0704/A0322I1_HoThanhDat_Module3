package bean;

public class Product {
    private int id;
    private String name;
    private double price;
    private int quantity;
    private String color;
    private String description;
    private int idCategory;

    public Product() {
    }

    public Product(String name, double price, int quantity, String color, String description, int idCategory) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.color = color;
        this.description = description;
        this.idCategory = idCategory;
    }

    public Product(int id, String name, double price, int quantity, String color, String description, int idCategory) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.color = color;
        this.description = description;
        this.idCategory = idCategory;
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getIdCategory() {
        return idCategory;
    }

    public void setIdCategory(int idCategory) {
        this.idCategory = idCategory;
    }
}
