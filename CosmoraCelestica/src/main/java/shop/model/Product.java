/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author HoangSang
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
    private Integer gameDetailsId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String categoryName;
    private String brandName;
    private String imageUrl;
    private GameDetails gameDetails;
    private List<ProductAttribute> attributes;

    public List<ProductAttribute> getAttributes() {
        return attributes;
    }

    public void setAttributes(List<ProductAttribute> attributes) {
        this.attributes = attributes;
    }

    public GameDetails getGameDetails() {
        return gameDetails;
    }

    public void setGameDetails(GameDetails gameDetails) {
        this.gameDetails = gameDetails;
    }

    public Product() {
    }

    public Product(int productId, String name, String description, BigDecimal price, int quantity, BigDecimal salePrice, int categoryId, int brandId, Integer gameDetailsId, Timestamp createdAt, Timestamp updatedAt, String categoryName, String brandName, String imageUrl) {
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
        this.categoryName = categoryName;
        this.brandName = brandName;
        this.imageUrl = imageUrl;
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

    public Integer getGameDetailsId() {
        return gameDetailsId;
    }

    public void setGameDetailsId(Integer gameDetailsId) {
        this.gameDetailsId = gameDetailsId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

}
