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
            return 1; // Fallback for a completely empty table
        }
    }

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();

        // Câu lệnh SQL sử dụng subquery để lấy ảnh đại diện.
        // TOP 1 và ORDER BY đảm bảo luôn lấy được ảnh đầu tiên một cách nhất quán.
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

        // Sử dụng try-with-resources để quản lý tài nguyên (PreparedStatement, ResultSet) tự động
        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();

                // Đọc dữ liệu từ ResultSet và gán vào đối tượng Product
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setCategoryName(rs.getString("category_name"));
                product.setBrandName(rs.getString("brand_name"));

                // "Gói" URL ảnh duy nhất lấy được từ DB vào một List<String>
                String singleImageUrl = rs.getString("image_url");
                List<String> imageUrls = new ArrayList<>();
                if (singleImageUrl != null && !singleImageUrl.isEmpty()) {
                    imageUrls.add(singleImageUrl);
                }
                // Gán danh sách chứa 1 ảnh này vào Product Model
                product.setImageUrls(imageUrls);

                // Thêm sản phẩm hoàn chỉnh vào danh sách kết quả
                productList.add(product);
            }
        } catch (SQLException e) {
            // Ghi lại lỗi ra console để gỡ rối khi có sự cố
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
                AttributeDAO attributeDAO = new AttributeDAO(); // Assuming you have this DAO
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

    /**
     * Phương thức này đã được sửa lại để tạo image_id duy nhất trên toàn bảng.
     */
    private void addProductAndImages(Connection conn, Product product, List<String> imageUrls) throws SQLException {
        // 1. Tạo ID mới cho sản phẩm và gán vào đối tượng product
        int newProductId = generateNewProductId();
        product.setProductId(newProductId);

        // 2. Chuẩn bị và thực thi câu lệnh INSERT cho bảng `product`
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

        // ==================================================================
        // FIX 2: Sửa lại logic chèn ảnh để sử dụng ID duy nhất
        // ==================================================================
        if (imageUrls != null && !imageUrls.isEmpty()) {
            String sqlImage = "INSERT INTO image (image_id, product_id, image_URL) VALUES (?, ?, ?)";
            try ( PreparedStatement psImage = conn.prepareStatement(sqlImage)) {

                // Lấy ID ảnh hợp lệ tiếp theo TRƯỚC khi lặp
                int nextImageId = generateNewImageId(conn);

                for (String imageUrl : imageUrls) {
                    if (imageUrl != null && !imageUrl.isEmpty()) {
                        // Gán các tham số
                        psImage.setInt(1, nextImageId); // Cột 1: Dùng ID duy nhất
                        psImage.setInt(2, product.getProductId());   // Cột 2: product_id
                        psImage.setString(3, imageUrl);              // Cột 3: image_URL
                        psImage.addBatch();

                        // Tăng ID cho ảnh tiếp theo
                        nextImageId++;
                    }
                }
                psImage.executeBatch();
            }
        }
    }

    public boolean updateProduct(Product product, GameDetails gameDetails, List<ProductAttribute> attributes, List<String> newImageUrls) throws SQLException {

        // Giả định 'conn' là kết nối được quản lý bởi lớp DBContext cha.
        // Toàn bộ logic được gói trong một transaction.
        try {
            // 1. Bắt đầu transaction
            conn.setAutoCommit(false);

            // 2. Cập nhật bảng `product`
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

            // 3. Cập nhật bảng `game_details` (nếu là game và có thông tin)
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

            // 4. Cập nhật bảng `product_attribute` (xóa cũ, chèn mới)
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

            // 5. Cập nhật bảng `image` (chỉ khi có danh sách ảnh mới được cung cấp)
            if (newImageUrls != null) {
                // Luôn xóa tất cả ảnh cũ để đồng bộ
                String deleteImgSql = "DELETE FROM image WHERE product_id = ?";
                try ( PreparedStatement ps = conn.prepareStatement(deleteImgSql)) {
                    ps.setInt(1, product.getProductId());
                    ps.executeUpdate();
                }

                // Nếu danh sách ảnh mới không rỗng, chèn chúng vào
                if (!newImageUrls.isEmpty()) {
                    String insertImageSql = "INSERT INTO image (image_id, product_id, image_URL) VALUES (?, ?, ?)";
                    try ( PreparedStatement psImage = conn.prepareStatement(insertImageSql)) {
                        int nextImageId = generateNewImageId(conn); // Tái sử dụng hàm tạo ID ảnh
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

            // 6. Hoàn tất transaction
            conn.commit();
            return true;

        } catch (SQLException e) {
            // Nếu có lỗi, rollback lại tất cả các thay đổi
            if (conn != null) {
                conn.rollback();
            }
            e.printStackTrace();
            return false; // Trả về false để báo hiệu thất bại
        } finally {
            // Đảm bảo auto-commit được bật lại, và KHÔNG đóng kết nối ở đây
            if (conn != null) {
                conn.setAutoCommit(true);
            }
        }
    }

    public Product getProductById(int productId) {
        Product product = null;

        // Câu lệnh SQL chính, đã loại bỏ subquery lấy ảnh để tối ưu
        String productSql = "SELECT p.*, c.name AS category_name, b.brand_name, gd.developer, gd.genre, gd.release_date "
                + "FROM product p "
                + "LEFT JOIN category c ON p.category_id = c.category_id "
                + "LEFT JOIN brand b ON p.brand_id = b.brand_id "
                + "LEFT JOIN game_details gd ON p.game_details_id = gd.game_details_id "
                + "WHERE p.product_id = ?";

        // Câu lệnh SQL mới để lấy TẤT CẢ URL ảnh cho sản phẩm
        String imagesSql = "SELECT image_URL FROM image WHERE product_id = ? ORDER BY image_id";

        // Câu lệnh SQL để lấy thuộc tính (giữ nguyên)
        String attributeSql = "SELECT a.name AS attribute_name, pa.value "
                + "FROM product_attribute pa "
                + "JOIN attribute a ON pa.attribute_id = a.attribute_id "
                + "WHERE pa.product_id = ?";

        try {
            // 1. Lấy thông tin sản phẩm chính
            try ( PreparedStatement psProduct = conn.prepareStatement(productSql)) {
                psProduct.setInt(1, productId);
                try ( ResultSet rs = psProduct.executeQuery()) {
                    if (rs.next()) {
                        // mapResultSetToProduct sẽ không còn setImageUrl nữa
                        product = mapResultSetToProduct(rs);
                        if (rs.getObject("game_details_id") != null) {
                            product.setGameDetails(mapResultSetToGameDetails(rs));
                        }
                    }
                }
            }

            // 2. Nếu tìm thấy sản phẩm, lấy danh sách ảnh và thuộc tính
            if (product != null) {
                // Lấy danh sách URL ảnh
                List<String> imageUrls = new ArrayList<>();
                try ( PreparedStatement psImages = conn.prepareStatement(imagesSql)) {
                    psImages.setInt(1, productId);
                    try ( ResultSet rsImages = psImages.executeQuery()) {
                        while (rsImages.next()) {
                            imageUrls.add(rsImages.getString("image_URL"));
                        }
                    }
                }
                // Set danh sách ảnh vào model product
                product.setImageUrls(imageUrls);

                // Lấy danh sách thuộc tính
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

    // Tìm phương thức mapResultSetToProduct trong ProductDAO.java và sửa lại
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setQuantity(rs.getInt("quantity"));
        product.setSalePrice(rs.getBigDecimal("sale_price"));
        product.setCategoryId(rs.getInt("category_id")); // Thêm dòng này để lấy categoryId
        product.setBrandId(rs.getInt("brand_id")); // Thêm dòng này để lấy brandId
        product.setCategoryName(rs.getString("category_name"));
        product.setBrandName(rs.getString("brand_name"));
        // product.setImageUrl(rs.getString("image_url")); // <-- XÓA HOẶC VÔ HIỆU HÓA DÒNG NÀY
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
