/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import shop.db.DBContext;
import shop.model.GameDetails;
import shop.model.Product;
import shop.model.ProductAttribute;

/**
 *
 * @author HoangSang
 */
public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();

        String sql = "SELECT p.product_id, p.name, p.price, p.quantity, c.name AS category_name, b.brand_name, "
                + "(SELECT TOP 1 i.image_URL FROM image i WHERE i.product_id = p.product_id) AS image_url "
                + "FROM product p "
                + "LEFT JOIN category c ON p.category_id = c.category_id "
                + "LEFT JOIN brand b ON p.brand_id = b.brand_id "
                + "ORDER BY p.product_id";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            if (conn == null) {
                return productList;
            }

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setCategoryName(rs.getString("category_name"));
                product.setBrandName(rs.getString("brand_name"));
                product.setImageUrl(rs.getString("image_url"));
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }

    public void deleteProduct(int productId) throws SQLException {

        try {
            conn.setAutoCommit(false);

            String deleteAttributesSQL = "DELETE FROM product_attribute WHERE product_id = ?";
            try ( PreparedStatement ps = conn.prepareStatement(deleteAttributesSQL)) {
                ps.setInt(1, productId);
                ps.executeUpdate();
            }

            String deleteImagesSQL = "DELETE FROM image WHERE product_id = ?";
            try ( PreparedStatement ps = conn.prepareStatement(deleteImagesSQL)) {
                ps.setInt(1, productId);
                ps.executeUpdate();
            }

            String deleteProductSQL = "DELETE FROM product WHERE product_id = ?";
            try ( PreparedStatement ps = conn.prepareStatement(deleteProductSQL)) {
                ps.setInt(1, productId);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("Deleting product failed, no rows affected.");
                }
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    public void addGameProduct(Product product, GameDetails details, String imageUrl) throws SQLException {

        try {

            conn.setAutoCommit(false); 

            String sqlDetails = "INSERT INTO game_details (developer, genre, release_date) VALUES (?, ?, ?)";
            try ( PreparedStatement psDetails = conn.prepareStatement(sqlDetails, Statement.RETURN_GENERATED_KEYS)) {
                psDetails.setString(1, details.getDeveloper());
                psDetails.setString(2, details.getGenre());
                psDetails.setDate(3, details.getReleaseDate());
                psDetails.executeUpdate();

                try ( ResultSet generatedKeys = psDetails.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        product.setGameDetailsId(generatedKeys.getInt(1));
                    } else {
                        throw new SQLException("Creating game details failed, no ID obtained.");
                    }
                }
            }

            addProductAndImage(conn, product, imageUrl);

            conn.commit(); 
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public void addAccessoryProduct(Product product, List<ProductAttribute> attributes, String imageUrl) throws SQLException {

        try {
            conn.setAutoCommit(false);

            int productId = addProductAndImage(conn, product, imageUrl);

            String sqlAttr = "INSERT INTO product_attribute (product_id, attribute_id, value) VALUES (?, ?, ?)";
            AttributeDAO attributeDAO = new AttributeDAO();
            try ( PreparedStatement psAttr = conn.prepareStatement(sqlAttr)) {
                for (ProductAttribute pa : attributes) {
                    if (pa != null) {
                        int attributeId = attributeDAO.getAttributeIdByName(pa.getAttributeName());
                        psAttr.setInt(1, productId);
                        psAttr.setInt(2, attributeId);
                        psAttr.setString(3, pa.getValue());
                        psAttr.addBatch();
                    }
                }
                psAttr.executeBatch();
            }

            conn.commit(); 
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    private int addProductAndImage(Connection conn, Product product, String imageUrl) throws SQLException {
        int productId;
        String sqlProduct = "INSERT INTO product (name, description, price, quantity, sale_price, category_id, brand_id, game_details_id, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try ( PreparedStatement psProduct = conn.prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS)) {
            psProduct.setString(1, product.getName());
            psProduct.setString(2, product.getDescription());
            psProduct.setBigDecimal(3, product.getPrice());
            psProduct.setInt(4, product.getQuantity());
            psProduct.setBigDecimal(5, product.getSalePrice());
            psProduct.setInt(6, product.getCategoryId());
            psProduct.setInt(7, product.getBrandId());
            if (product.getGameDetailsId() != null) {
                psProduct.setInt(8, product.getGameDetailsId());
            } else {
                psProduct.setNull(8, Types.INTEGER);
            }
            psProduct.executeUpdate();

            try ( ResultSet generatedKeys = psProduct.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    productId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating product failed, no ID obtained.");
                }
            }
        }

        if (imageUrl != null && !imageUrl.isEmpty()) {
            String sqlImage = "INSERT INTO image (product_id, image_URL) VALUES (?, ?)";
            try ( PreparedStatement psImage = conn.prepareStatement(sqlImage)) {
                psImage.setInt(1, productId);
                psImage.setString(2, imageUrl);
                psImage.executeUpdate();
            }
        }

        return productId;
    }

    public boolean updateProduct(Product product, String newImageUrl) throws SQLException {
        boolean success = false;

        String updateProductSQL = "UPDATE product SET name = ?, description = ?, price = ?, quantity = ?, "
                + "category_id = ?, brand_id = ?, updated_at = GETDATE() "
                + "WHERE product_id = ?";

        String deleteImageSQL = "DELETE FROM image WHERE product_id = ?";
        String insertImageSQL = "INSERT INTO image (product_id, image_URL) VALUES (?, ?)";

        try {
            conn.setAutoCommit(false); 

            try ( PreparedStatement psProduct = conn.prepareStatement(updateProductSQL)) {
                psProduct.setString(1, product.getName());
                psProduct.setString(2, product.getDescription());
                psProduct.setBigDecimal(3, product.getPrice());
                psProduct.setInt(4, product.getQuantity());
                psProduct.setInt(5, product.getCategoryId());
                psProduct.setInt(6, product.getBrandId());
                psProduct.setInt(7, product.getProductId());
                psProduct.executeUpdate();
            }

            if (newImageUrl != null && !newImageUrl.isEmpty()) {
                // Xóa ảnh cũ
                try ( PreparedStatement psDelete = conn.prepareStatement(deleteImageSQL)) {
                    psDelete.setInt(1, product.getProductId());
                    psDelete.executeUpdate();
                }
                try ( PreparedStatement psInsert = conn.prepareStatement(insertImageSQL)) {
                    psInsert.setInt(1, product.getProductId());
                    psInsert.setString(2, newImageUrl);
                    psInsert.executeUpdate();
                }
            }

            conn.commit(); 
            success = true;

        } catch (Exception e) {
            if (conn != null) {
                conn.rollback(); 
            }
            e.printStackTrace();

        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);

                conn.close();
            }
        }

        return success;
    }
   
    
    
    public Product getProductById(int productId) {
    Product product = null;

    String productSql = "SELECT p.*, c.name AS category_name, b.brand_name, gd.developer, gd.genre, gd.release_date, "
                      + "(SELECT TOP 1 i.image_URL FROM image i WHERE i.product_id = p.product_id ORDER BY i.image_id) AS image_url "
                      + "FROM product p "
                      + "LEFT JOIN category c ON p.category_id = c.category_id "
                      + "LEFT JOIN brand b ON p.brand_id = b.brand_id "
                      + "LEFT JOIN game_details gd ON p.game_details_id = gd.game_details_id "
                      + "WHERE p.product_id = ?";

    String attributeSql = "SELECT a.name AS attribute_name, pa.value "
                        + "FROM product_attribute pa "
                        + "JOIN attribute a ON pa.attribute_id = a.attribute_id "
                        + "WHERE pa.product_id = ?";

    try  {
        
        try (PreparedStatement psProduct = conn.prepareStatement(productSql)) {
            psProduct.setInt(1, productId);
            try (ResultSet rs = psProduct.executeQuery()) {
                if (rs.next()) {
                    product = mapResultSetToProduct(rs);
                    if (rs.getObject("game_details_id") != null) {
                        product.setGameDetails(mapResultSetToGameDetails(rs));
                    }
                }
            }
        }

        if (product != null) {
            List<ProductAttribute> attributes = new ArrayList<>();
            try (PreparedStatement psAttr = conn.prepareStatement(attributeSql)) {
                psAttr.setInt(1, productId);
                try (ResultSet rsAttr = psAttr.executeQuery()) {
                    while (rsAttr.next()) {
                        ProductAttribute attr = new ProductAttribute();
                        attr.setAttributeName(rsAttr.getString("attribute_name"));
                        attr.setValue(rsAttr.getString("value"));
                        attributes.add(attr);
                    }
                }
            }
            product.setAttributes(attributes);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return product;
}

private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
    Product product = new Product();
    product.setProductId(rs.getInt("product_id"));
    product.setName(rs.getString("name"));
    product.setDescription(rs.getString("description"));
    product.setPrice(rs.getBigDecimal("price"));
    product.setQuantity(rs.getInt("quantity"));
    product.setSalePrice(rs.getBigDecimal("sale_price"));
    product.setCategoryName(rs.getString("category_name"));
    product.setBrandName(rs.getString("brand_name"));
    product.setImageUrl(rs.getString("image_url"));
    product.setCreatedAt(rs.getTimestamp("created_at"));
    product.setUpdatedAt(rs.getTimestamp("updated_at"));
    return product;
}

private GameDetails mapResultSetToGameDetails(ResultSet rs) throws SQLException {
    GameDetails details = new GameDetails();
    details.setGameDetailsId(rs.getInt("game_details_id"));
    details.setDeveloper(rs.getString("developer"));
    details.setGenre(rs.getString("genre"));
    details.setReleaseDate(rs.getDate("release_date"));
    return details;
}
}
