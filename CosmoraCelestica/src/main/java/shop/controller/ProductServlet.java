/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package shop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import shop.dao.BrandDAO;
import shop.dao.CategoryDAO;
import shop.dao.ProductDAO;
import shop.model.GameDetails;
import shop.model.Product;
import shop.model.ProductAttribute;

/**
 *
 * @author HoangSang
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIRECTORY = "assets/img";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "add": {
                    CategoryDAO categoryDAO = new CategoryDAO();
                    BrandDAO brandDAO = new BrandDAO();
                    request.setAttribute("categoriesList", categoryDAO.getAllCategories());
                    request.setAttribute("brandsList", brandDAO.getAllBrands());
                    request.getRequestDispatcher("/WEB-INF/admin/product-add.jsp").forward(request, response);
                    break;
                }
                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductDAO productDAO = new ProductDAO();
                    Product existingProduct = productDAO.getProductById(id);

                    if (existingProduct == null) {
                        response.sendRedirect(request.getContextPath() + "/products?action=list");
                        return;
                    }

                    CategoryDAO categoryDAO = new CategoryDAO();
                    BrandDAO brandDAO = new BrandDAO();

                    request.setAttribute("product", existingProduct);
                    request.setAttribute("categoriesList", categoryDAO.getAllCategories());
                    request.setAttribute("brandsList", brandDAO.getAllBrands());

                    request.getRequestDispatcher("/WEB-INF/admin/product-edit.jsp").forward(request, response);
                    break;
                }
                case "details": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductDAO productDAO = new ProductDAO();
                    Product product = productDAO.getProductById(id);

                    if (product == null) {
                        response.sendRedirect(request.getContextPath() + "/products?action=list");
                        return;
                    }
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/WEB-INF/admin/product-details.jsp").forward(request, response);
                    break;
                }
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductDAO productDAO = new ProductDAO();
                    productDAO.deleteProduct(id);
                    response.sendRedirect(request.getContextPath() + "/products?action=list");
                    break;
                }
                default: {
                    ProductDAO productDAO = new ProductDAO();
                    request.setAttribute("productList", productDAO.getAllProducts());
                    request.getRequestDispatcher("/WEB-INF/admin/product-list.jsp").forward(request, response);
                    break;
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/products?action=list");
            return;
        }

        try {
            switch (action) {
                case "add": {
                    // Lấy productType từ trường ẩn đã thêm
                    String productType = request.getParameter("productType");

                    // Kiểm tra null để tránh lỗi
                    if (productType == null || productType.isEmpty()) {
                        request.setAttribute("errorMessage", "Error: Product type is missing. Please select a product type.");
                        // Tải lại các danh sách cần thiết cho form
                        CategoryDAO categoryDAO = new CategoryDAO();
                        BrandDAO brandDAO = new BrandDAO();
                        request.setAttribute("categoriesList", categoryDAO.getAllCategories());
                        request.setAttribute("brandsList", brandDAO.getAllBrands());
                        request.getRequestDispatcher("/WEB-INF/admin/product-add.jsp").forward(request, response);
                        return;
                    }

                    String name = request.getParameter("name");
                    BigDecimal price = new BigDecimal(request.getParameter("price"));
                    String description = request.getParameter("description");
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

                    String brandIdStr = request.getParameter("brandId");
                    Integer brandId = null;
                    if (brandIdStr != null && !brandIdStr.isEmpty()) {
                        brandId = Integer.parseInt(brandIdStr);
                    }

                    List<String> imageUrls = new ArrayList<>();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }

                    Collection<Part> fileParts = request.getParts();
                    for (Part filePart : fileParts) {
                        if ("productImages".equals(filePart.getName()) && filePart.getSize() > 0) {
                            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                            if (fileName != null && !fileName.isEmpty()) {
                                filePart.write(uploadPath + File.separator + fileName);
                                imageUrls.add(UPLOAD_DIRECTORY + "/" + fileName);
                            }
                        }
                    }

                    Product product = new Product();
                    product.setName(name);
                    product.setDescription(description);
                    product.setPrice(price);
                    product.setQuantity(quantity);
                    product.setCategoryId(categoryId);
                    if (brandId != null) {
                        product.setBrandId(brandId);
                    }

                    ProductDAO productDAO = new ProductDAO();

                    try {
                        if ("game".equals(productType)) {
                            GameDetails gameDetails = new GameDetails();
                            gameDetails.setDeveloper(request.getParameter("developer"));
                            gameDetails.setGenre(request.getParameter("genre"));
                            gameDetails.setReleaseDate(Date.valueOf(request.getParameter("releaseDate")));
                            productDAO.addGameProduct(product, gameDetails, imageUrls);
                        } else { // Xử lý cho tất cả các loại phụ kiện
                            // Gọi phương thức đã được sửa lỗi
                            List<ProductAttribute> attributes = createAttributeListFromRequest(request);
                            productDAO.addAccessoryProduct(product, attributes, imageUrls);
                        }

                        response.sendRedirect(request.getContextPath() + "/products?action=list&add_success=true");

                    } catch (SQLException e) {
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Error adding product to database: " + e.getMessage());
                        // Tải lại các danh sách cần thiết cho form
                        CategoryDAO categoryDAO = new CategoryDAO();
                        BrandDAO brandDAO = new BrandDAO();
                        request.setAttribute("categoriesList", categoryDAO.getAllCategories());
                        request.setAttribute("brandsList", brandDAO.getAllBrands());
                        request.getRequestDispatcher("/WEB-INF/admin/product-add.jsp").forward(request, response);
                    }
                    break;
                }
                // File: shop/controller/ProductServlet.java
// Bên trong phương thức doPost( ... )

// ...
                case "update": {
                    try {
                        // --- 1. Lấy thông tin chung của sản phẩm ---
                        int productId = Integer.parseInt(request.getParameter("productId"));
                        String name = request.getParameter("name");
                        BigDecimal price = new BigDecimal(request.getParameter("price"));
                        String salePriceStr = request.getParameter("salePrice"); // Lấy giá sale, có thể rỗng
                        String description = request.getParameter("description");
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

                        // Lấy brandId (có thể không có với Game)
                        String brandIdStr = request.getParameter("brandId");
                        Integer brandId = (brandIdStr != null && !brandIdStr.isEmpty()) ? Integer.parseInt(brandIdStr) : null;

                        // Lấy productType để biết cần lấy thêm thông tin gì
                        String productType = request.getParameter("productType");

                        // --- 2. Tạo đối tượng Product và gán thông tin chung ---
                        Product product = new Product();
                        product.setProductId(productId);
                        product.setName(name);
                        product.setDescription(description);
                        product.setPrice(price);
                        product.setQuantity(quantity);
                        product.setCategoryId(categoryId);
                        if (brandId != null) {
                            product.setBrandId(brandId);
                        }
                        // Xử lý giá sale
                        if (salePriceStr != null && !salePriceStr.trim().isEmpty()) {
                            product.setSalePrice(new BigDecimal(salePriceStr));
                        }

                        // --- 3. Xử lý nhiều hình ảnh được tải lên ---
                        List<String> newImageUrls = new ArrayList<>();
                        boolean imagesUploaded = false; // Cờ để kiểm tra xem có ảnh mới nào được tải lên không

                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        for (Part part : request.getParts()) {
                            if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                                imagesUploaded = true; // Đánh dấu là có ảnh mới
                                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                                if (fileName != null && !fileName.isEmpty()) {
                                    part.write(uploadPath + File.separator + fileName);
                                    newImageUrls.add(UPLOAD_DIRECTORY + "/" + fileName);
                                }
                            }
                        }

                        // --- 4. Thu thập thông tin riêng (Game Details hoặc Attributes) ---
                        GameDetails gameDetails = null;
                        List<ProductAttribute> attributes = null;

                        if ("game".equalsIgnoreCase(productType)) {
                            // Lấy game_details_id từ sản phẩm gốc để cập nhật đúng dòng
                            ProductDAO tempDao = new ProductDAO();
                            Product existingProduct = tempDao.getProductById(productId);
                            if (existingProduct != null && existingProduct.getGameDetails() != null) {
                                gameDetails = new GameDetails();
                                gameDetails.setDeveloper(request.getParameter("developer"));
                                gameDetails.setGenre(request.getParameter("genre"));
                                gameDetails.setReleaseDate(Date.valueOf(request.getParameter("releaseDate")));
                                // Gán lại game_details_id để DAO biết cần UPDATE dòng nào
                                product.setGameDetailsId(existingProduct.getGameDetailsId());
                            }
                        } else {
                            // Sử dụng lại hàm helper để lấy các thuộc tính của phụ kiện
                            attributes = createAttributeListFromRequest(request);
                        }

                        // --- 5. Gọi hàm DAO mới để cập nhật ---
                        ProductDAO productDAO = new ProductDAO();
                        // Nếu không có ảnh mới nào được tải lên, truyền null để DAO không thay đổi ảnh cũ.
                        // Ngược lại, truyền danh sách ảnh mới (dù rỗng hay có phần tử) để DAO xóa cũ và thêm mới.
                        productDAO.updateProduct(product, gameDetails, attributes, imagesUploaded ? newImageUrls : null);

                        // --- 6. Chuyển hướng về trang danh sách ---
                        response.sendRedirect(request.getContextPath() + "/products?action=list&update_success=true");

                    } catch (SQLException e) {
                        // Xử lý lỗi SQL
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Database update failed: " + e.getMessage());
                        // Có thể forward lại trang edit với thông báo lỗi
                        request.getRequestDispatcher("/WEB-INF/admin/product-edit.jsp").forward(request, response);
                    } catch (Exception e) {
                        // Xử lý các lỗi khác
                        e.printStackTrace();
                        throw new ServletException(e);
                    }
                    break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

//    private List<ProductAttribute> createAttributeListFromRequest(HttpServletRequest request, String productType) {
//        List<ProductAttribute> attributes = new ArrayList<>();
//        attributes.add(createAttribute("warranty_months", request.getParameter("warrantyMonths")));
//        attributes.add(createAttribute("weight_grams", request.getParameter("weightGrams")));
//        attributes.add(createAttribute("connection_type", request.getParameter("connectionType")));
//        attributes.add(createAttribute("usage_time_hours", request.getParameter("usageTimeHours")));
//        switch (productType) {
//            case "headphone":
//                attributes.add(createAttribute("headphone_type", request.getParameter("headphoneType")));
//                attributes.add(createAttribute("material", request.getParameter("headphoneMaterial")));
//                attributes.add(createAttribute("battery_capacity_mah", request.getParameter("headphoneBattery")));
//                attributes.add(createAttribute("features", request.getParameter("headphoneFeatures")));
//                break;
//            case "keyboard":
//                attributes.add(createAttribute("size", request.getParameter("keyboardSize")));
//                attributes.add(createAttribute("material", request.getParameter("keyboardMaterial")));
//                attributes.add(createAttribute("keyboard_type", request.getParameter("keyboardType")));
//                break;
//            case "mouse":
//                attributes.add(createAttribute("mouse_type", request.getParameter("mouseType")));
//                break;
//            case "controller":
//                attributes.add(createAttribute("material", request.getParameter("controllerMaterial")));
//                attributes.add(createAttribute("battery_capacity_mah", request.getParameter("controllerBattery")));
//                attributes.add(createAttribute("ChargingTimeHours", request.getParameter("controllerChargingTime")));
//                break;
//        }
//        return attributes;
//    }
//
//    private ProductAttribute createAttribute(String attributeName, String value) {
//        if (value != null && !value.trim().isEmpty()) {
//            ProductAttribute pa = new ProductAttribute();
//            pa.setAttributeName(attributeName);
//            pa.setValue(value);
//            return pa;
//        }
//        return null;
//    }
    /**
     * Phương thức trợ giúp để thêm thuộc tính vào danh sách nếu giá trị tồn
     * tại.
     *
     * @param attributes Danh sách thuộc tính
     * @param request Đối tượng request
     * @param attrName Tên thuộc tính trong DB (ví dụ: "Warranty")
     * @param paramName Tên tham số từ form (ví dụ: "warrantyMonths")
     */
    private void addAttributeIfPresent(List<ProductAttribute> attributes, HttpServletRequest request, String attrName, String paramName) {
        String value = request.getParameter(paramName);
        if (value != null && !value.trim().isEmpty()) {
            ProductAttribute pa = new ProductAttribute();
            pa.setAttributeName(attrName);
            pa.setValue(value);
            attributes.add(pa);
        }
    }

    /**
     * Tái cấu trúc lại phương thức để thu thập thuộc tính từ request một cách
     * rõ ràng.
     *
     * @param request đối tượng HttpServletRequest
     * @return Danh sách các đối tượng ProductAttribute
     */
    private List<ProductAttribute> createAttributeListFromRequest(HttpServletRequest request) {
        List<ProductAttribute> attributes = new ArrayList<>();
        String productType = request.getParameter("productType");

        // 1. Thêm các thuộc tính chung cho tất cả phụ kiện
        addAttributeIfPresent(attributes, request, "Warranty", "warrantyMonths");
        addAttributeIfPresent(attributes, request, "Weight", "weightGrams");
        addAttributeIfPresent(attributes, request, "Connection Type", "connectionType");
        addAttributeIfPresent(attributes, request, "Usage Time", "usageTimeHours");

        // 2. Thêm các thuộc tính cụ thể dựa vào loại sản phẩm
        if (productType != null) {
            switch (productType) {
                case "headphone":
                    addAttributeIfPresent(attributes, request, "Headphone Type", "headphoneType");
                    addAttributeIfPresent(attributes, request, "Material", "headphoneMaterial");
                    addAttributeIfPresent(attributes, request, "Battery Capacity", "headphoneBattery");
                    addAttributeIfPresent(attributes, request, "Features", "headphoneFeatures");
                    break;
                case "keyboard":
                    addAttributeIfPresent(attributes, request, "Size", "keyboardSize");
                    addAttributeIfPresent(attributes, request, "Material", "keyboardMaterial");
                    addAttributeIfPresent(attributes, request, "Keyboard Type", "keyboardType");
                    break;
                case "mouse":
                    addAttributeIfPresent(attributes, request, "Mouse Type", "mouseType");
                    break;
                case "controller":
                    addAttributeIfPresent(attributes, request, "Material", "controllerMaterial");
                    addAttributeIfPresent(attributes, request, "Battery Capacity", "controllerBattery");
                    addAttributeIfPresent(attributes, request, "Charging Time", "controllerChargingTime");
                    break;
            }
        }
        return attributes;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
