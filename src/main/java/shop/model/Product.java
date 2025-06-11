/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.model;
import java.math.BigDecimal;
import java.time.LocalDateTime;
/**
 *
 * @author PC
 */
public class Product {
    private int productId;
    private String name;
    private String description;
    private BigDecimal price;
    private int quantity;
    private BigDecimal salePrice;
    private int categoryId;
    private int brandId;
    private int gameDetailsId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Product(int productId, String name, String description, BigDecimal price, int quantity, BigDecimal salePrice, int categoryId, int brandId, int gameDetailsId, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.salePrice = salePrice;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.gameDetailsId = gameDetailsId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Product() {
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getGameDetailsId() {
        return gameDetailsId;
    }

    public void setGameDetailsId(int gameDetailsId) {
        this.gameDetailsId = gameDetailsId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    
    
    
}
