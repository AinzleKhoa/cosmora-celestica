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
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
            List<Product> productList;
            switch (action) {
                case "add": {
                    CategoryDAO categoryDAO = new CategoryDAO();
                    BrandDAO brandDAO = new BrandDAO();
                    ProductDAO productDAO = new ProductDAO();
                    request.setAttribute("productList", productDAO.getAllProducts());
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

                    // ================= LOGIC ĐƯỢC CHUYỂN VÀO ĐÂY =================
                    // 1. Chuẩn bị attributeMap từ List<ProductAttribute>
                    Map<String, String> attributeMap = new HashMap<>();
                    if (existingProduct.getAttributes() != null) {
                        for (ProductAttribute attr : existingProduct.getAttributes()) {
                            attributeMap.put(attr.getAttributeName(), attr.getValue());
                        }
                    }

                    // 2. Chuẩn bị gameDetails để tránh null trong JSP
                    GameDetails gameDetails = existingProduct.getGameDetails();
                    if (gameDetails == null) {
                        gameDetails = new GameDetails(); // Tạo đối tượng rỗng nếu không có
                    }
                    // ================= KẾT THÚC LOGIC CHUYỂN VÀO =================

                    // Gửi tất cả dữ liệu đã được chuẩn bị sang JSP
                    request.setAttribute("product", existingProduct);
                    request.setAttribute("categoriesList", categoryDAO.getAllCategories());
                    request.setAttribute("brandsList", brandDAO.getAllBrands());
                    request.setAttribute("attributeMap", attributeMap); // Gửi map đã tạo
                    request.setAttribute("gameDetails", gameDetails);   // Gửi đối tượng không bao giờ null

                    request.getRequestDispatcher("/WEB-INF/admin/product-edit.jsp").forward(request, response);
                    break;
                }
                case "details": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductDAO productDAO = new ProductDAO();
                    Product product = productDAO.getProductById(id);
                    Locale localeVN = new Locale("vi", "VN");
                    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(localeVN);
                    SimpleDateFormat timestampFormatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                    SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");

                    request.setAttribute("currencyFormatter", currencyFormatter);
                    request.setAttribute("timestampFormatter", timestampFormatter);
                    request.setAttribute("dateFormatter", dateFormatter);
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
                case "search": {
                    ProductDAO productDAO = new ProductDAO();
                    String query = request.getParameter("query");
                    if (query != null && !query.trim().isEmpty()) {
                        String lowerCaseQuery = query.toLowerCase();
                        List<Product> allProducts = productDAO.getAllProducts();
                        productList = new ArrayList<>();
                        for (Product p : allProducts) {
                            if (p.getName() != null && p.getName().toLowerCase().contains(lowerCaseQuery)) {
                                productList.add(p);
                            }
                        }

                    } else {
                        productList = productDAO.getAllProducts();
                    }
                    request.setAttribute("productList", productList);
                    request.getRequestDispatcher("/WEB-INF/admin/product-list.jsp").forward(request, response);
                    break;
                }
                default: {
                    ProductDAO productDAO = new ProductDAO();
                    request.setAttribute("productList", productDAO.getAllProducts());

                    request.getRequestDispatcher("/WEB-INF/admin/product-list.jsp").forward(request, response);

                    Locale locale = new Locale("vi", "VN");
                    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);
                    request.setAttribute("currencyFormatter", currencyFormatter);
                    request.getRequestDispatcher("/WEB-INF/dashboard/product-list.jsp").forward(request, response);

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
                    String productType = request.getParameter("productType");
                    if (productType == null || productType.isEmpty()) {
                        request.setAttribute("errorMessage", "Error: Product type is missing. Please select a product type.");
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
                                imageUrls.add(fileName);
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
                        } else {
                            List<ProductAttribute> attributes = createAttributeListFromRequest(request);
                            productDAO.addAccessoryProduct(product, attributes, imageUrls);
                        }
                        response.sendRedirect(request.getContextPath() + "/products?action=list&add_success=true");
                    } catch (SQLException e) {
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Error adding product to database: " + e.getMessage());
                        CategoryDAO categoryDAO = new CategoryDAO();
                        BrandDAO brandDAO = new BrandDAO();
                        request.setAttribute("categoriesList", categoryDAO.getAllCategories());
                        request.setAttribute("brandsList", brandDAO.getAllBrands());
                        request.getRequestDispatcher("/WEB-INF/admin/product-add.jsp").forward(request, response);
                    }
                    break;
                }

                case "update": {
                    try {
                        int productId = Integer.parseInt(request.getParameter("productId"));
                        String name = request.getParameter("name");
                        BigDecimal price = new BigDecimal(request.getParameter("price"));
                        String salePriceStr = request.getParameter("salePrice");
                        String description = request.getParameter("description");
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                        String brandIdStr = request.getParameter("brandId");
                        Integer brandId = (brandIdStr != null && !brandIdStr.isEmpty()) ? Integer.parseInt(brandIdStr) : null;
                        String productType = request.getParameter("productType");

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
                        if (salePriceStr != null && !salePriceStr.trim().isEmpty()) {
                            product.setSalePrice(new BigDecimal(salePriceStr));
                        }

                        List<String> newImageUrls = new ArrayList<>();
                        boolean imagesUploaded = false;

                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        for (Part part : request.getParts()) {
                            if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                                imagesUploaded = true;
                                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                                if (fileName != null && !fileName.isEmpty()) {
                                    part.write(uploadPath + File.separator + fileName);
                                    newImageUrls.add(UPLOAD_DIRECTORY + "/" + fileName);
                                }
                            }
                        }

                        GameDetails gameDetails = null;
                        List<ProductAttribute> attributes = null;

                        if ("game".equalsIgnoreCase(productType)) {
                            ProductDAO tempDao = new ProductDAO();
                            Product existingProduct = tempDao.getProductById(productId);
                            if (existingProduct != null && existingProduct.getGameDetails() != null) {
                                gameDetails = new GameDetails();
                                gameDetails.setDeveloper(request.getParameter("developer"));
                                gameDetails.setGenre(request.getParameter("genre"));
                                gameDetails.setReleaseDate(Date.valueOf(request.getParameter("releaseDate")));
                                product.setGameDetailsId(existingProduct.getGameDetailsId());
                            }
                        } else {
                            attributes = createAttributeListFromRequest(request);
                        }
                        ProductDAO productDAO = new ProductDAO();
                        productDAO.updateProduct(product, gameDetails, attributes, imagesUploaded ? newImageUrls : null);

                        response.sendRedirect(request.getContextPath() + "/products?action=list&update_success=true");

                    } catch (SQLException e) {
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Database update failed: " + e.getMessage());
                        request.getRequestDispatcher("/WEB-INF/admin/product-edit.jsp").forward(request, response);
                    } catch (Exception e) {
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

    private void addAttributeIfPresent(List<ProductAttribute> attributes, HttpServletRequest request, String attrName, String paramName) {
        String value = request.getParameter(paramName);
        if (value != null && !value.trim().isEmpty()) {
            ProductAttribute pa = new ProductAttribute();
            pa.setAttributeName(attrName);
            pa.setValue(value);
            attributes.add(pa);
        }
    }

    private List<ProductAttribute> createAttributeListFromRequest(HttpServletRequest request) {
        List<ProductAttribute> attributes = new ArrayList<>();
        String productType = request.getParameter("productType");
        addAttributeIfPresent(attributes, request, "Warranty", "warrantyMonths");
        addAttributeIfPresent(attributes, request, "Weight", "weightGrams");
        addAttributeIfPresent(attributes, request, "Connection Type", "connectionType");
        addAttributeIfPresent(attributes, request, "Usage Time", "usageTimeHours");

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
