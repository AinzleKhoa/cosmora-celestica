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

    public int generateNewProductId() throws SQLException {
        String sql = "SELECT ISNULL(MAX(product_id), 0) FROM product";
        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) + 1;
            } else {
                return 1;
            }
        }
    }

    private int generateNewImageId(Connection conn) throws SQLException {
        String sql = "SELECT ISNULL(MAX(image_id), 0) FROM image";
        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1;
        }
    }

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();

        String sql = "SELECT "
                + "    p.product_id, p.name, p.price, p.quantity, "
                + "    c.name AS category_name, "
                + "    b.brand_name, "
                + "    (SELECT TOP 1 i.image_URL FROM image i WHERE i.product_id = p.product_id ORDER BY i.image_id) AS image_url "
                + "FROM "
                + "    product p "
                + "LEFT JOIN "
                + "    category c ON p.category_id = c.category_id "
                + "LEFT JOIN "
                + "    brand b ON p.brand_id = b.brand_id "
                + "ORDER BY "
                + "    p.product_id";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setCategoryName(rs.getString("category_name"));
                product.setBrandName(rs.getString("brand_name"));

                String singleImageUrl = rs.getString("image_url");
                List<String> imageUrls = new ArrayList<>();
                if (singleImageUrl != null && !singleImageUrl.isEmpty()) {
                    imageUrls.add(singleImageUrl);
                }
                product.setImageUrls(imageUrls);
                productList.add(product);
            }
        } catch (SQLException e) {
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

    public void addGameProduct(Product product, GameDetails details, List<String> imageUrls) throws SQLException {

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

            addProductAndImages(conn, product, imageUrls);

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

    public void addAccessoryProduct(Product product, List<ProductAttribute> attributes, List<String> imageUrls) throws SQLException {
        try {
            conn.setAutoCommit(false);
            addProductAndImages(conn, product, imageUrls);

            if (attributes != null && !attributes.isEmpty()) {
                String sqlAttr = "INSERT INTO product_attribute (product_id, attribute_id, value) VALUES (?, ?, ?)";
                AttributeDAO attributeDAO = new AttributeDAO();
                try ( PreparedStatement psAttr = conn.prepareStatement(sqlAttr)) {
                    for (ProductAttribute pa : attributes) {
                        if (pa != null && pa.getValue() != null && !pa.getValue().isEmpty()) {
                            int attributeId = attributeDAO.getAttributeIdByName(pa.getAttributeName());
                            if (attributeId > 0) {
                                psAttr.setInt(1, product.getProductId());
                                psAttr.setInt(2, attributeId);
                                psAttr.setString(3, pa.getValue());
                                psAttr.addBatch();
                            }
                        }
                    }
                    psAttr.executeBatch();
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
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    private void addProductAndImages(Connection conn, Product product, List<String> imageUrls) throws SQLException {
        int newProductId = generateNewProductId();
        product.setProductId(newProductId);

        String sqlProduct = "INSERT INTO product (product_id, name, description, price, quantity, sale_price, category_id, brand_id, game_details_id, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";

        try ( PreparedStatement psProduct = conn.prepareStatement(sqlProduct)) {
            psProduct.setInt(1, product.getProductId());
            psProduct.setString(2, product.getName());
            psProduct.setString(3, product.getDescription());
            psProduct.setBigDecimal(4, product.getPrice());
            psProduct.setInt(5, product.getQuantity());

            if (product.getSalePrice() != null) {
                psProduct.setBigDecimal(6, product.getSalePrice());
            } else {
                psProduct.setNull(6, Types.DECIMAL);
            }
            psProduct.setInt(7, product.getCategoryId());

            if (product.getBrandId() != null) {
                psProduct.setInt(8, product.getBrandId());
            } else {
                psProduct.setNull(8, Types.INTEGER);
            }

            if (product.getGameDetailsId() != null) {
                psProduct.setInt(9, product.getGameDetailsId());
            } else {
                psProduct.setNull(9, Types.INTEGER);
            }
            psProduct.executeUpdate();
        }

        if (imageUrls != null && !imageUrls.isEmpty()) {
            String sqlImage = "INSERT INTO image (image_id, product_id, image_URL) VALUES (?, ?, ?)";
            try ( PreparedStatement psImage = conn.prepareStatement(sqlImage)) {

                int nextImageId = generateNewImageId(conn);

                for (String imageUrl : imageUrls) {
                    if (imageUrl != null && !imageUrl.isEmpty()) {
                        psImage.setInt(1, nextImageId);
                        psImage.setInt(2, product.getProductId());
                        psImage.setString(3, imageUrl);
                        psImage.addBatch();
                        nextImageId++;
                    }
                }
                psImage.executeBatch();
            }
        }
    }

    public boolean updateProduct(Product product, GameDetails gameDetails, List<ProductAttribute> attributes, List<String> newImageUrls) throws SQLException {

        try {

            conn.setAutoCommit(false);

            String productSql = "UPDATE product SET name = ?, description = ?, price = ?, quantity = ?, "
                    + "sale_price = ?, category_id = ?, brand_id = ?, updated_at = GETDATE() "
                    + "WHERE product_id = ?";
            try ( PreparedStatement ps = conn.prepareStatement(productSql)) {
                ps.setString(1, product.getName());
                ps.setString(2, product.getDescription());
                ps.setBigDecimal(3, product.getPrice());
                ps.setInt(4, product.getQuantity());
                ps.setBigDecimal(5, product.getSalePrice());
                ps.setInt(6, product.getCategoryId());
                ps.setInt(7, product.getBrandId());
                ps.setInt(8, product.getProductId());
                ps.executeUpdate();
            }

            if (product.getGameDetailsId() != null && gameDetails != null) {
                String gameSql = "UPDATE game_details SET developer = ?, genre = ?, release_date = ? WHERE game_details_id = ?";
                try ( PreparedStatement ps = conn.prepareStatement(gameSql)) {
                    ps.setString(1, gameDetails.getDeveloper());
                    ps.setString(2, gameDetails.getGenre());
                    ps.setDate(3, new java.sql.Date(gameDetails.getReleaseDate().getTime()));
                    ps.setInt(4, product.getGameDetailsId());
                    ps.executeUpdate();
                }
            }

            String deleteAttrSql = "DELETE FROM product_attribute WHERE product_id = ?";
            try ( PreparedStatement ps = conn.prepareStatement(deleteAttrSql)) {
                ps.setInt(1, product.getProductId());
                ps.executeUpdate();
            }

            if (attributes != null && !attributes.isEmpty()) {
                String insertAttrSql = "INSERT INTO product_attribute (product_id, attribute_id, value) VALUES (?, ?, ?)";
                AttributeDAO attributeDAO = new AttributeDAO(); // Giả định bạn có AttributeDAO
                try ( PreparedStatement psAttr = conn.prepareStatement(insertAttrSql)) {
                    for (ProductAttribute pa : attributes) {
                        int attributeId = attributeDAO.getAttributeIdByName(pa.getAttributeName());
                        if (attributeId > 0) {
                            psAttr.setInt(1, product.getProductId());
                            psAttr.setInt(2, attributeId);
                            psAttr.setString(3, pa.getValue());
                            psAttr.addBatch();
                        }
                    }
                    psAttr.executeBatch();
                }
            }

            if (newImageUrls != null) {
                String deleteImgSql = "DELETE FROM image WHERE product_id = ?";
                try ( PreparedStatement ps = conn.prepareStatement(deleteImgSql)) {
                    ps.setInt(1, product.getProductId());
                    ps.executeUpdate();
                }

                if (!newImageUrls.isEmpty()) {
                    String insertImageSql = "INSERT INTO image (image_id, product_id, image_URL) VALUES (?, ?, ?)";
                    try ( PreparedStatement psImage = conn.prepareStatement(insertImageSql)) {
                        int nextImageId = generateNewImageId(conn);
                        for (String imageUrl : newImageUrls) {
                            if (imageUrl != null && !imageUrl.isEmpty()) {
                                psImage.setInt(1, nextImageId++);
                                psImage.setInt(2, product.getProductId());
                                psImage.setString(3, imageUrl);
                                psImage.addBatch();
                            }
                        }
                        psImage.executeBatch();
                    }
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
            }
        }
    }

    public Product getProductById(int productId) {
        Product product = null;

        String productSql = "SELECT p.*, c.name AS category_name, b.brand_name, gd.developer, gd.genre, gd.release_date "
                + "FROM product p "
                + "LEFT JOIN category c ON p.category_id = c.category_id "
                + "LEFT JOIN brand b ON p.brand_id = b.brand_id "
                + "LEFT JOIN game_details gd ON p.game_details_id = gd.game_details_id "
                + "WHERE p.product_id = ?";

        String imagesSql = "SELECT image_URL FROM image WHERE product_id = ? ORDER BY image_id";

        String attributeSql = "SELECT a.name AS attribute_name, pa.value "
                + "FROM product_attribute pa "
                + "JOIN attribute a ON pa.attribute_id = a.attribute_id "
                + "WHERE pa.product_id = ?";

        try {
            try ( PreparedStatement psProduct = conn.prepareStatement(productSql)) {
                psProduct.setInt(1, productId);
                try ( ResultSet rs = psProduct.executeQuery()) {
                    if (rs.next()) {
                        product = mapResultSetToProduct(rs);
                        if (rs.getObject("game_details_id") != null) {
                            product.setGameDetails(mapResultSetToGameDetails(rs));
                        }
                    }
                }
            }

            if (product != null) {
                List<String> imageUrls = new ArrayList<>();
                try ( PreparedStatement psImages = conn.prepareStatement(imagesSql)) {
                    psImages.setInt(1, productId);
                    try ( ResultSet rsImages = psImages.executeQuery()) {
                        while (rsImages.next()) {
                            imageUrls.add(rsImages.getString("image_URL"));
                        }
                    }
                }

                product.setImageUrls(imageUrls);

                List<ProductAttribute> attributes = new ArrayList<>();
                try ( PreparedStatement psAttr = conn.prepareStatement(attributeSql)) {
                    psAttr.setInt(1, productId);
                    try ( ResultSet rsAttr = psAttr.executeQuery()) {
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
        product.setCategoryId(rs.getInt("category_id"));
        product.setBrandId(rs.getInt("brand_id"));
        product.setCategoryName(rs.getString("category_name"));
        product.setBrandName(rs.getString("brand_name"));
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
