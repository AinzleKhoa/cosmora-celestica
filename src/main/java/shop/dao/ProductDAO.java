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

    private int getNextId(Connection conn, String tableName, String idColumnName) throws SQLException {
        String sql = "SELECT ISNULL(MAX(" + idColumnName + "), 0) FROM " + tableName;
        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
        }
        return 1;
    }

    public void addFullGameProduct(Product product, GameDetails gameDetails, List<String> imageUrls, String[] platformIds, String[] osIds, String[] newKeys) throws SQLException {
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);

            int gameDetailsId = getNextId(conn, "game_details", "game_details_id");
            String sqlGameDetails = "INSERT INTO game_details (game_details_id, developer, genre, release_date) VALUES (?, ?, ?, ?)";
            try ( PreparedStatement ps = conn.prepareStatement(sqlGameDetails)) {
                ps.setInt(1, gameDetailsId);
                ps.setString(2, gameDetails.getDeveloper());
                ps.setString(3, gameDetails.getGenre());
                ps.setDate(4, gameDetails.getReleaseDate());
                ps.executeUpdate();
            }

            int productId = getNextId(conn, "product", "product_id");
            String sqlProduct = "INSERT INTO product (product_id, name, description, price, quantity, category_id, brand_id, game_details_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try ( PreparedStatement ps = conn.prepareStatement(sqlProduct)) {
                ps.setInt(1, productId);
                ps.setString(2, product.getName());
                ps.setString(3, product.getDescription());
                ps.setBigDecimal(4, product.getPrice());
                ps.setInt(5, product.getQuantity());
                ps.setInt(6, product.getCategoryId());
                ps.setNull(7, Types.INTEGER);
                ps.setInt(8, gameDetailsId);
                ps.executeUpdate();
            }

            if (imageUrls != null && !imageUrls.isEmpty()) {
                int nextImageId = getNextId(conn, "image", "image_id");
                String sqlImages = "INSERT INTO image (image_id, product_id, image_URL) VALUES (?, ?, ?)";
                try ( PreparedStatement ps = conn.prepareStatement(sqlImages)) {
                    for (String imageUrl : imageUrls) {
                        ps.setInt(1, nextImageId++);
                        ps.setInt(2, productId);
                        ps.setString(3, imageUrl);
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }

            if (platformIds != null && platformIds.length > 0) {
                int nextPlatformId = getNextId(conn, "store_platform", "platform_id");
                String sqlPlatform = "INSERT INTO store_platform (platform_id, game_details_id, store_OS_name) VALUES (?, ?, ?)";
                try ( PreparedStatement ps = conn.prepareStatement(sqlPlatform)) {
                    for (String pId : platformIds) {
                        ps.setInt(1, nextPlatformId++);
                        ps.setInt(2, gameDetailsId);
                        ps.setString(3, "Platform " + pId);
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }

            if (osIds != null && osIds.length > 0) {
                int nextOsId = getNextId(conn, "operating_system", "os_id");
                String sqlOs = "INSERT INTO operating_system (os_id, game_details_id, os_name) VALUES (?, ?, ?)";
                try ( PreparedStatement ps = conn.prepareStatement(sqlOs)) {
                    for (String oId : osIds) {
                        ps.setInt(1, nextOsId++);
                        ps.setInt(2, gameDetailsId);
                        ps.setString(3, "OS " + oId);
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }

            int nextKeyId = getNextId(conn, "game_key", "game_key_id");
            String sqlKey = "INSERT INTO game_key (game_key_id, game_details_id, key_code) VALUES (?, ?, ?)";
            try ( PreparedStatement ps = conn.prepareStatement(sqlKey)) {
                for (String key : newKeys) {
                    if (key != null && !key.trim().isEmpty()) {
                        ps.setInt(1, nextKeyId++);
                        ps.setInt(2, gameDetailsId);
                        ps.setString(3, key.trim());
                        ps.addBatch();
                    }
                }
                ps.executeBatch();
            }

            conn.commit();
        } catch (Exception e) {
            if (conn != null) {
                conn.rollback();
            }
            throw new SQLException("Lỗi khi thêm sản phẩm game.", e);
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

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

    public void updateProduct(Product product, GameDetails gameDetails, List<ProductAttribute> attributes,
            List<String> newImageUrls, String[] platformIds, String[] osIds, String[] newKeys) throws SQLException {

        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);

            String sqlUpdateProduct = "UPDATE product SET name=?, description=?, price=?, quantity=?, sale_price=?, category_id=?, brand_id=?, updated_at=GETDATE() WHERE product_id=?";
            try ( PreparedStatement ps = conn.prepareStatement(sqlUpdateProduct)) {
                ps.setString(1, product.getName());
                ps.setString(2, product.getDescription());
                ps.setBigDecimal(3, product.getPrice());
                ps.setInt(4, product.getQuantity());
                ps.setBigDecimal(5, product.getSalePrice());
                ps.setInt(6, product.getCategoryId());
                if (product.getBrandId() != null) {
                    ps.setInt(7, product.getBrandId());
                } else {
                    ps.setNull(7, Types.INTEGER);
                }
                ps.setInt(8, product.getProductId());
                ps.executeUpdate();
            }

            Integer gameDetailsId = product.getGameDetailsId();

            if (gameDetailsId != null && gameDetails != null) {
                String sqlUpdateGame = "UPDATE game_details SET developer=?, genre=?, release_date=? WHERE game_details_id=?";
                try ( PreparedStatement ps = conn.prepareStatement(sqlUpdateGame)) {
                    ps.setString(1, gameDetails.getDeveloper());
                    ps.setString(2, gameDetails.getGenre());
                    if (gameDetails.getReleaseDate() != null) {
                        ps.setDate(3, gameDetails.getReleaseDate());
                    } else {
                        ps.setNull(3, Types.DATE);
                    }
                    ps.setInt(4, gameDetailsId);
                    ps.executeUpdate();
                }

                String sqlDeletePlatform = "DELETE FROM store_platform WHERE game_details_id = ?";
                try ( PreparedStatement ps = conn.prepareStatement(sqlDeletePlatform)) {
                    ps.setInt(1, gameDetailsId);
                    ps.executeUpdate();
                }
                if (platformIds != null) {
                    int nextPlatformId = getNextId(conn, "store_platform", "platform_id");
                    String sqlInsertPlatform = "INSERT INTO store_platform (platform_id, game_details_id, store_OS_name) VALUES (?, ?, ?)";
                    try ( PreparedStatement ps = conn.prepareStatement(sqlInsertPlatform)) {
                        for (String pId : platformIds) {
                            ps.setInt(1, nextPlatformId++);
                            ps.setInt(2, gameDetailsId);
                            ps.setString(3, "Platform-" + pId);
                            ps.addBatch();
                        }
                        ps.executeBatch();
                    }
                }

                String sqlDeleteOs = "DELETE FROM operating_system WHERE game_details_id = ?";
                try ( PreparedStatement ps = conn.prepareStatement(sqlDeleteOs)) {
                    ps.setInt(1, gameDetailsId);
                    ps.executeUpdate();
                }
                if (osIds != null) {
                    int nextOsId = getNextId(conn, "operating_system", "os_id");
                    String sqlInsertOs = "INSERT INTO operating_system (os_id, game_details_id, os_name) VALUES (?, ?, ?)";
                    try ( PreparedStatement ps = conn.prepareStatement(sqlInsertOs)) {
                        for (String oId : osIds) {
                            ps.setInt(1, nextOsId++);
                            ps.setInt(2, gameDetailsId);
                            ps.setString(3, "OS-" + oId);
                            ps.addBatch();
                        }
                        ps.executeBatch();
                    }
                }

                if (newKeys != null && newKeys.length > 0) {
                    int nextKeyId = getNextId(conn, "game_key", "game_key_id");
                    String sqlKey = "INSERT INTO game_key (game_key_id, game_details_id, key_code) VALUES (?, ?, ?)";
                    try ( PreparedStatement ps = conn.prepareStatement(sqlKey)) {
                        for (String key : newKeys) {
                            if (key != null && !key.trim().isEmpty()) {
                                ps.setInt(1, nextKeyId++);
                                ps.setInt(2, gameDetailsId);
                                ps.setString(3, key.trim());
                                ps.addBatch();
                            }
                        }
                        ps.executeBatch();
                    }
                }
            } else {
                String sqlDeleteAttrs = "DELETE FROM product_attribute WHERE product_id = ?";
                try ( PreparedStatement psDelete = conn.prepareStatement(sqlDeleteAttrs)) {
                    psDelete.setInt(1, product.getProductId());
                    psDelete.executeUpdate();
                }

                if (attributes != null && !attributes.isEmpty()) {
                    String sqlInsertAttr = "INSERT INTO product_attribute (product_id, attribute_id, value) VALUES (?, ?, ?)";
                    String sqlFindAttrId = "SELECT attribute_id FROM attribute WHERE name = ?";

                    try ( PreparedStatement psInsert = conn.prepareStatement(sqlInsertAttr)) {
                        for (ProductAttribute pa : attributes) {
                            int attributeId = -1;

                            try ( PreparedStatement psFind = conn.prepareStatement(sqlFindAttrId)) {
                                psFind.setString(1, pa.getAttributeName());
                                try ( ResultSet rs = psFind.executeQuery()) {
                                    if (rs.next()) {
                                        attributeId = rs.getInt("attribute_id");
                                    }
                                }
                            }

                            if (attributeId != -1) {
                                psInsert.setInt(1, product.getProductId());
                                psInsert.setInt(2, attributeId);
                                psInsert.setString(3, pa.getValue());
                                psInsert.addBatch();
                            }
                        }
                        psInsert.executeBatch();
                    }
                }

            }

            if (newImageUrls != null) {
                String sqlDeleteImages = "DELETE FROM image WHERE product_id = ?";
                try ( PreparedStatement ps = conn.prepareStatement(sqlDeleteImages)) {
                    ps.setInt(1, product.getProductId());
                    ps.executeUpdate();
                }
                if (!newImageUrls.isEmpty()) {
                    int nextImageId = getNextId(conn, "image", "image_id");
                    String sqlInsertImage = "INSERT INTO image (image_id, product_id, image_URL) VALUES (?, ?, ?)";
                    try ( PreparedStatement ps = conn.prepareStatement(sqlInsertImage)) {
                        for (String url : newImageUrls) {
                            ps.setInt(1, nextImageId++);
                            ps.setInt(2, product.getProductId());
                            ps.setString(3, url);
                            ps.addBatch();
                        }
                        ps.executeBatch();
                    }
                }
            }
            conn.commit();
        } catch (Exception e) {
            if (conn != null) {
                conn.rollback();
            }
            throw new SQLException("Lỗi khi cập nhật sản phẩm.", e);
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public Product getProductById(int productId) {
        Product product = null;
        GameDetails details = null;
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
                            product.setGameDetailsId((Integer) rs.getObject("game_details_id"));

                            details = mapResultSetToGameDetails(rs);
                            product.setGameDetails(details);
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
