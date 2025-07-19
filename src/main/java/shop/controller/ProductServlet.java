package shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import shop.dao.BrandDAO;
import shop.dao.CategoryDAO;
import shop.dao.GameKeyDAO;
import shop.dao.OperatingSystemDAO;
import shop.dao.ProductDAO;
import shop.dao.StorePlatformDAO;
import shop.model.GameDetails;
import shop.model.OperatingSystem;
import shop.model.Product;
import shop.model.ProductAttribute;
import shop.model.StorePlatform;

/**
 *
 * @author HoangSang
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
@WebServlet(name = "ProductServlet", urlPatterns = {"/manage-products"})
public class ProductServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "assets/img";
    private static final int PRODUCTS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Mặc định là hiển thị danh sách
        }
        try {
            switch (action) {
                case "add": {
                    // Chuẩn bị dữ liệu cho form thêm sản phẩm
                    request.setAttribute("categoriesList", new CategoryDAO().getAllCategories());
                    request.setAttribute("brandsList", new BrandDAO().getAllBrands());
                    request.setAttribute("allPlatforms", new StorePlatformDAO().getAllPlatforms());
                    request.setAttribute("allOS", new OperatingSystemDAO().getAllOperatingSystems());
                    request.getRequestDispatcher("/WEB-INF/dashboard/product-add.jsp").forward(request, response);
                    break;
                }
                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductDAO productDAO = new ProductDAO();
                    Product existingProduct = productDAO.getProductById(id);

                    if (existingProduct == null) {
                        // Nếu không tìm thấy sản phẩm, chuyển hướng về danh sách
                        response.sendRedirect("manage-products?action=list");
                        return;
                    }

                    // Đặt các thuộc tính cần thiết cho form chỉnh sửa
                    request.setAttribute("product", existingProduct);
                    request.setAttribute("categoriesList", new CategoryDAO().getAllCategories());
                    request.setAttribute("brandsList", new BrandDAO().getAllBrands());
                    request.setAttribute("allPlatforms", new StorePlatformDAO().getAllPlatforms());
                    request.setAttribute("allOS", new OperatingSystemDAO().getAllOperatingSystems());
                    request.setAttribute("gameDetails", existingProduct.getGameDetails());

                    // Xử lý thông tin riêng cho game (nếu là game)
                    if (existingProduct.getGameDetailsId() != null && existingProduct.getGameDetailsId() > 0) {
                        int gameDetailsId = existingProduct.getGameDetailsId();
                        request.setAttribute("gameKeys", new GameKeyDAO().findByGameDetailsId(gameDetailsId));

                        // Lấy và đánh dấu các nền tảng đã chọn
                        List<StorePlatform> selectedPlatforms = new StorePlatformDAO().findByGameDetailsId(gameDetailsId);
                        Set<Integer> selectedPlatformIds = new HashSet<>();
                        for (StorePlatform p : selectedPlatforms) {
                            int masterId = new StorePlatformDAO().getMasterStorePlatformIdByName(p.getStoreOSName());
                            if (masterId != -1) {
                                selectedPlatformIds.add(masterId);
                            }
                        }
                        request.setAttribute("selectedPlatformIds", selectedPlatformIds);

                        // Lấy và đánh dấu các hệ điều hành đã chọn
                        List<OperatingSystem> selectedOS = new OperatingSystemDAO().findByGameDetailsId(gameDetailsId);
                        Set<Integer> selectedOsIds = new HashSet<>();
                        for (OperatingSystem os : selectedOS) {
                            int masterId = new OperatingSystemDAO().getMasterOsIdByName(os.getOsName());
                            if (masterId != -1) {
                                selectedOsIds.add(masterId);
                            }
                        }
                        request.setAttribute("selectedOsIds", selectedOsIds);
                    }

                    // Chuyển đổi danh sách thuộc tính thành Map để dễ dàng truy cập trong JSP
                    Map<String, String> attributeMap = new HashMap<>();
                    if (existingProduct.getAttributes() != null) {
                        for (ProductAttribute attr : existingProduct.getAttributes()) {
                            attributeMap.put(attr.getAttributeName(), attr.getValue());
                        }
                    }
                    request.setAttribute("attributeMap", attributeMap);

                    request.getRequestDispatcher("/WEB-INF/dashboard/product-edit.jsp").forward(request, response);
                    break;
                }
                case "details": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductDAO productDAO = new ProductDAO();
                    Product product = productDAO.getProductById(id);

                    // Kiểm tra xem sản phẩm có tồn tại không
                    if (product == null) {
                        response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
                        return;
                    }

                    // Lấy số sao trung bình cho sản phẩm
                    double stars = productDAO.getAverageStarsForProduct(product.getProductId());
                    product.setAverageStars(stars);

                    // Xử lý thông tin chi tiết game nếu là sản phẩm game
                    if ("Game".equalsIgnoreCase(product.getCategoryName()) && product.getGameDetailsId() != null && product.getGameDetailsId() > 0) {
                        int gameDetailsId = product.getGameDetailsId();
                        request.setAttribute("gameKeys", new GameKeyDAO().findByGameDetailsId(gameDetailsId));

                        // Lấy các nền tảng duy nhất
                        StorePlatformDAO platformDAO = new StorePlatformDAO();
                        List<StorePlatform> rawPlatforms = platformDAO.findByGameDetailsId(gameDetailsId);
                        Set<String> seenPlatformNames = new HashSet<>();
                        List<StorePlatform> distinctPlatforms = new ArrayList<>();
                        for (StorePlatform p : rawPlatforms) {
                            if (seenPlatformNames.add(p.getStoreOSName())) {
                                distinctPlatforms.add(p);
                            }
                        }
                        request.setAttribute("platforms", distinctPlatforms);

                        // Lấy các hệ điều hành duy nhất
                        OperatingSystemDAO osDAO = new OperatingSystemDAO();
                        List<OperatingSystem> rawOs = osDAO.findByGameDetailsId(gameDetailsId);
                        Set<String> seenOsNames = new HashSet<>();
                        List<OperatingSystem> distinctOs = new ArrayList<>();
                        for (OperatingSystem os : rawOs) {
                            if (seenOsNames.add(os.getOsName())) {
                                distinctOs.add(os);
                            }
                        }
                        request.setAttribute("operatingSystems", distinctOs);
                    }

                    // Định dạng số và ngày giờ
                    Locale localeVN = new Locale("vi", "VN");
                    request.setAttribute("currencyFormatter", NumberFormat.getCurrencyInstance(localeVN));
                    request.setAttribute("timestampFormatter", new SimpleDateFormat("dd/MM/yyyy HH:mm:ss"));
                    request.setAttribute("dateFormatter", new SimpleDateFormat("dd/MM/yyyy"));

                    // Gửi dữ liệu tới JSP
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/WEB-INF/dashboard/product-details.jsp").forward(request, response);
                    break;
                }
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductDAO productDAO = new ProductDAO();
                    Product productToDelete = productDAO.getProductById(id);
                    request.setAttribute("delete", productToDelete);
                    if (productToDelete != null) {
                        boolean isSold = productDAO.isProductSold(id);
                        request.setAttribute("isSold", isSold);
                    }
                    request.getRequestDispatcher("/WEB-INF/dashboard/product-delete.jsp").forward(request, response);
                    break;
                }
                default: { // Mặc định là action "list" hoặc khi action không hợp lệ
                    ProductDAO productDAO = new ProductDAO();
                    List<Product> fullProductList;
                    String searchQuery = request.getParameter("query");

                    if ("search".equals(action) && searchQuery != null && !searchQuery.trim().isEmpty()) {
                        fullProductList = productDAO.searchProductsByName(searchQuery); // Sử dụng DAO searchProductsByName
                    } else {
                        fullProductList = productDAO.getAllProducts();
                    }

                    // Xử lý phân trang
                    int page = 1;
                    try {
                        String pageStr = request.getParameter("page");
                        if (pageStr != null && !pageStr.isEmpty()) {
                            page = Integer.parseInt(pageStr);
                        }
                    } catch (NumberFormatException e) {
                        // Bỏ qua, page vẫn là 1
                    }

                    int totalProducts = fullProductList.size();
                    int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);
                    if (totalPages == 0) { // Đảm bảo có ít nhất 1 trang nếu không có sản phẩm nào
                        totalPages = 1;
                    }
                    if (page < 1) { // Đảm bảo trang không nhỏ hơn 1
                        page = 1;
                    }
                    if (page > totalPages) { // Đảm bảo trang không vượt quá tổng số trang
                        page = totalPages;
                    }

                    int start = (page - 1) * PRODUCTS_PER_PAGE;
                    int end = Math.min(start + PRODUCTS_PER_PAGE, totalProducts);
                    List<Product> pagedProducts = new ArrayList<>();
                    if (start < end) { // Đảm bảo có sản phẩm để lấy subList
                        pagedProducts = fullProductList.subList(start, end);
                    }

                    // Xây dựng URL phân trang
                    String pageUrl;
                    if ("search".equals(action) && searchQuery != null && !searchQuery.isEmpty()) {
                        pageUrl = "manage-products?action=search&query=" + URLEncoder.encode(searchQuery, StandardCharsets.UTF_8.toString()) + "&page=";
                    } else {
                        pageUrl = "manage-products?action=list&page=";
                    }
                    String previousPageUrl = (page > 1) ? pageUrl + (page - 1) : "#";
                    String nextPageUrl = (page < totalPages) ? pageUrl + (page + 1) : "#";

                    request.setAttribute("productList", pagedProducts);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("startRowNumber", start + 1);
                    request.setAttribute("pageUrl", pageUrl);
                    request.setAttribute("previousPageUrl", previousPageUrl);
                    request.setAttribute("nextPageUrl", nextPageUrl);
                    request.setAttribute("currentQuery", searchQuery); // Giữ lại query cho tìm kiếm

                    request.getRequestDispatcher("/WEB-INF/dashboard/product-list.jsp").forward(request, response);
                    break;
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in doGet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Database error in doGet", e);
        } catch (NumberFormatException e) {
            System.err.println("Invalid number format in doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID or page number format.");
        } catch (Exception e) {
            System.err.println("An unexpected error occurred in doGet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An unexpected error occurred", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
            return;
        }

        try {
            switch (action) {
                case "add": {
                    try {
                        // --- 1. Lấy thông tin sản phẩm chung & Xác thực ---
                        String name = request.getParameter("name");
                        String priceStr = request.getParameter("price");
                        String description = request.getParameter("description");
                        String categoryIdStr = request.getParameter("categoryId");
                        String productType = request.getParameter("productType");

                        // Kiểm tra dữ liệu bắt buộc
                        if (name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()
                                || categoryIdStr == null || categoryIdStr.trim().isEmpty() || productType == null || productType.trim().isEmpty()) {
                            throw new IllegalArgumentException("Vui lòng điền đầy đủ các thông tin bắt buộc: Tên, Giá, Loại sản phẩm.");
                        }

                        BigDecimal price = new BigDecimal(priceStr);
                        int categoryId = Integer.parseInt(categoryIdStr);

                        // Validate rằng giá phải là số dương
                        if (price.compareTo(BigDecimal.ZERO) <= 0) {
                            throw new IllegalArgumentException("Giá phải là một giá trị dương.");
                        }

                        // --- 2. Xử lý tải ảnh lên ---
                        List<String> imageUrls = new ArrayList<>();
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs(); // Tạo thư mục nếu nó không tồn tại
                        }

                        for (Part filePart : request.getParts()) {
                            if ("productImages".equals(filePart.getName()) && filePart.getSize() > 0) {
                                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                                if (fileName != null && !fileName.isEmpty()) {
                                    filePart.write(uploadPath + File.separator + fileName);
                                    imageUrls.add(fileName);
                                }
                            }
                        }
                        
                        // Đảm bảo có ít nhất một ảnh cho sản phẩm mới
                        if (imageUrls.isEmpty()) {
                             throw new IllegalArgumentException("Sản phẩm phải có ít nhất một hình ảnh.");
                        }

                        // --- 3. Thu thập thuộc tính (tùy chỉnh và tiền định nghĩa) ---
                        // Sử dụng Map để khử trùng lặp các thuộc tính theo tên
                        Map<String, ProductAttribute> uniqueAttributes = new HashMap<>();

                        // a) Thu thập "Thuộc tính tùy chỉnh" do người dùng định nghĩa
                        String[] customNames = request.getParameterValues("customAttributeNames");
                        String[] customValues = request.getParameterValues("customAttributeValues");
                        if (customNames != null && customValues != null) {
                            for (int i = 0; i < customNames.length; i++) {
                                String attrName = customNames[i];
                                String attrValue = customValues[i];
                                if (attrName != null && !attrName.trim().isEmpty() && attrValue != null && !attrValue.trim().isEmpty()) {
                                    // Chuyển tên thuộc tính về chữ thường để đảm bảo tính duy nhất không phân biệt chữ hoa/chữ thường
                                    uniqueAttributes.put(attrName.trim().toLowerCase(), new ProductAttribute(attrName.trim(), attrValue.trim()));
                                }
                            }
                        }

                        // --- 4. Tạo và điền dữ liệu vào đối tượng Product ---
                        Product product = new Product();
                        product.setName(name);
                        product.setDescription(description);
                        product.setPrice(price);
                        product.setCategoryId(categoryId);
                        product.setActiveProduct(1); // Mặc định sản phẩm mới là active

                        ProductDAO productDAO = new ProductDAO();

                        // --- 5. Logic phân nhánh dựa trên loại sản phẩm ---
                        if ("game".equalsIgnoreCase(productType)) {
                            product.setQuantity(1); // Số lượng game thường là 1 sản phẩm chính, số lượng key là riêng
                            product.setBrandId(null); // Game không có brandId

                            GameDetails gameDetails = new GameDetails();
                            gameDetails.setDeveloper(request.getParameter("developer"));
                            gameDetails.setGenre(request.getParameter("genre"));
                            String releaseDateStr = request.getParameter("releaseDate");
                            if (releaseDateStr == null || releaseDateStr.trim().isEmpty()) {
                                throw new IllegalArgumentException("Ngày phát hành là bắt buộc cho Game.");
                            }
                            gameDetails.setReleaseDate(Date.valueOf(releaseDateStr));

                            String[] platformIds = request.getParameterValues("platformIds");
                            String[] osIds = request.getParameterValues("osIds");
                            String newKeysRaw = request.getParameter("gameKeys");
                            String[] newKeys = (newKeysRaw != null && !newKeysRaw.trim().isEmpty()) ? newKeysRaw.split("\\r?\\n") : new String[0];

                            // Chuyển uniqueAttributes Map thành List
                            List<ProductAttribute> finalAttributes = new ArrayList<>(uniqueAttributes.values());
                            productDAO.addFullGameProduct(product, gameDetails, imageUrls, platformIds, osIds, newKeys, finalAttributes);

                        } else { // Đây là phụ kiện (Mouse, Keyboard, v.v.)
                            String quantityStr = request.getParameter("quantity");
                            if (quantityStr == null || quantityStr.trim().isEmpty()) {
                                throw new IllegalArgumentException("Số lượng là bắt buộc cho Phụ kiện.");
                            }
                            int quantity = Integer.parseInt(quantityStr);

                            if (quantity <= 0) {
                                throw new IllegalArgumentException("Số lượng phải là một số dương cho phụ kiện.");
                            }
                            product.setQuantity(quantity);

                            String brandIdStr = request.getParameter("brandId");
                            product.setBrandId((brandIdStr != null && !brandIdStr.isEmpty()) ? Integer.parseInt(brandIdStr) : null);

                            // b) Thu thập các thuộc tính phụ kiện tiền định nghĩa và thêm chúng vào uniqueAttributes Map
                            String[] attrNames = {"Warranty", "Weight", "Connection Type", "Usage Time", "Headphone Type", "Material", "Battery Capacity", "Features", "Size", "Keyboard Type", "Mouse Type", "Charging Time"};
                            String[] paramNames = {"warrantyMonths", "weightGrams", "connectionType", "usageTimeHours", "headphoneType", "headphoneMaterial", "headphoneBattery", "headphoneFeatures", "keyboardSize", "keyboardType", "mouseType", "controllerChargingTime"};

                            for (int i = 0; i < paramNames.length; i++) {
                                String value = request.getParameter(paramNames[i]);
                                if (value != null && !value.trim().isEmpty()) {
                                    uniqueAttributes.put(attrNames[i].trim().toLowerCase(), new ProductAttribute(attrNames[i], value));
                                }
                            }

                            // Chuyển uniqueAttributes Map thành List
                            List<ProductAttribute> finalAttributes = new ArrayList<>(uniqueAttributes.values());
                            productDAO.addAccessoryProduct(product, finalAttributes, imageUrls);
                        }

                        // --- 6. Chuyển hướng thành công ---
                        response.sendRedirect(request.getContextPath() + "/manage-products?action=list");

                    } catch (IllegalArgumentException e) {
                        System.err.println("Validation Error: " + e.getMessage());
                        request.setAttribute("errorMessage", e.getMessage());
                        request.setAttribute("categoriesList", new CategoryDAO().getAllCategories());
                        request.setAttribute("brandsList", new BrandDAO().getAllBrands());
                        request.setAttribute("allPlatforms", new StorePlatformDAO().getAllPlatforms());
                        request.setAttribute("allOS", new OperatingSystemDAO().getAllOperatingSystems());
                        request.getRequestDispatcher("/WEB-INF/dashboard/product-add.jsp").forward(request, response);
                    } catch (Exception e) {
                        System.err.println("Error adding product: " + e.getMessage());
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tạo sản phẩm: " + e.getMessage());
                        request.setAttribute("categoriesList", new CategoryDAO().getAllCategories());
                        request.setAttribute("brandsList", new BrandDAO().getAllBrands());
                        request.setAttribute("allPlatforms", new StorePlatformDAO().getAllPlatforms());
                        request.setAttribute("allOS", new OperatingSystemDAO().getAllOperatingSystems());
                        request.getRequestDispatcher("/WEB-INF/dashboard/product-add.jsp").forward(request, response);
                    }
                    break;
                }
                case "update": {
                    try {
                        int productId = Integer.parseInt(request.getParameter("productId"));
                        String name = request.getParameter("name");
                        String priceStr = request.getParameter("price");
                        String description = request.getParameter("description");
                        String categoryIdStr = request.getParameter("categoryId");
                        String productType = request.getParameter("productType");

                        if (name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()
                                || categoryIdStr == null || categoryIdStr.trim().isEmpty() || productType == null || productType.trim().isEmpty()) {
                            throw new IllegalArgumentException("Vui lòng điền đầy đủ các thông tin bắt buộc.");
                        }

                        BigDecimal price = new BigDecimal(priceStr);
                        if (price.compareTo(BigDecimal.ZERO) <= 0) {
                            throw new IllegalArgumentException("Giá phải lớn hơn 0!");
                        }
                        int categoryId = Integer.parseInt(categoryIdStr);

                        List<String> finalImageUrls = new ArrayList<>();
                        String[] originalImageViews = request.getParameterValues("originalImageViews");
                        if (originalImageViews != null) {
                            for (String imageUrl : originalImageViews) {
                                if (imageUrl != null && !imageUrl.isEmpty()) {
                                    finalImageUrls.add(imageUrl);
                                }
                            }
                        }

                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        for (Part filePart : request.getParts()) {
                            if ("productImages".equals(filePart.getName()) && filePart.getSize() > 0) {
                                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                                if (fileName != null && !fileName.isEmpty()) {
                                    filePart.write(uploadPath + File.separator + fileName);
                                    finalImageUrls.add(fileName);
                                }
                            }
                        }
                        
                        if (finalImageUrls.isEmpty()) {
                            throw new IllegalArgumentException("Sản phẩm phải có ít nhất một hình ảnh.");
                        }

                        Product product = new Product();
                        product.setProductId(productId);
                        product.setName(name);
                        product.setDescription(description);
                        product.setPrice(price);
                        product.setCategoryId(categoryId);
                        product.setActiveProduct(1);

                        GameDetails gameDetails = null;
                        // Sử dụng Map để khử trùng lặp thuộc tính cho quá trình cập nhật
                        Map<String, ProductAttribute> uniqueAttributes = new HashMap<>();
                        String[] platformIds = null;
                        String[] osIds = null;
                        String[] newKeys = null;

                        if ("game".equalsIgnoreCase(productType)) {
                            product.setQuantity(1);
                            product.setBrandId(null);

                            int gameDetailsId = 0;
                            String gameDetailsIdStr = request.getParameter("gameDetailsId");
                            if (gameDetailsIdStr != null && !gameDetailsIdStr.isEmpty()) {
                                gameDetailsId = Integer.parseInt(gameDetailsIdStr);
                            }
                            if (gameDetailsId > 0) {
                                product.setGameDetailsId(gameDetailsId);
                            }

                            gameDetails = new GameDetails();
                            gameDetails.setGameDetailsId(gameDetailsId);
                            gameDetails.setDeveloper(request.getParameter("developer"));
                            gameDetails.setGenre(request.getParameter("genre"));
                            String releaseDateStr = request.getParameter("releaseDate");
                            if (releaseDateStr == null || releaseDateStr.trim().isEmpty()) {
                                throw new IllegalArgumentException("Ngày phát hành là bắt buộc cho Game.");
                            }
                            gameDetails.setReleaseDate(Date.valueOf(releaseDateStr));

                            platformIds = request.getParameterValues("platformIds");
                            osIds = request.getParameterValues("osIds");
                            String newKeysRaw = request.getParameter("newGameKeys");
                            if (newKeysRaw != null && !newKeysRaw.trim().isEmpty()) {
                                newKeys = newKeysRaw.split("\\r?\\n");
                            }

                        } else { // Accessory
                            String quantityStr = request.getParameter("quantity");
                            if (quantityStr == null || quantityStr.trim().isEmpty()) {
                                throw new IllegalArgumentException("Số lượng là bắt buộc cho Phụ kiện.");
                            }
                            int quantity = Integer.parseInt(quantityStr);
                            if (quantity <= 0) {
                                throw new IllegalArgumentException("Số lượng phải lớn hơn 0!");
                            }
                            product.setQuantity(quantity);
                            product.setGameDetailsId(null);

                            String brandIdStr = request.getParameter("brandId");
                            product.setBrandId((brandIdStr != null && !brandIdStr.isEmpty()) ? Integer.parseInt(brandIdStr) : null);

                            String[] attrNames = {"Warranty", "Weight", "Connection Type", "Usage Time", "Headphone Type", "Material", "Battery Capacity", "Features", "Size", "Keyboard Type", "Mouse Type", "Charging Time"};
                            String[] paramNames = {"warrantyMonths", "weightGrams", "connectionType", "usageTimeHours", "headphoneType", "headphoneMaterial", "headphoneBattery", "headphoneFeatures", "keyboardSize", "keyboardType", "mouseType", "controllerChargingTime"};

                            for (int i = 0; i < attrNames.length; i++) {
                                String value = request.getParameter(paramNames[i]);
                                if (value != null && !value.trim().isEmpty()) {
                                    uniqueAttributes.put(attrNames[i].trim().toLowerCase(), new ProductAttribute(attrNames[i], value));
                                }
                            }

                            String[] customNames = request.getParameterValues("customAttributeNames");
                            String[] customValues = request.getParameterValues("customAttributeValues");
                            if (customNames != null && customValues != null) {
                                for (int i = 0; i < customNames.length; i++) {
                                    String attrName = customNames[i];
                                    String attrValue = customValues[i];
                                    if (attrName != null && !attrName.trim().isEmpty() && attrValue != null && !attrValue.trim().isEmpty()) {
                                        uniqueAttributes.put(attrName.trim().toLowerCase(), new ProductAttribute(attrName.trim(), attrValue.trim()));
                                    }
                                }
                            }
                        }
                        
                        // Chuyển uniqueAttributes Map thành List
                        List<ProductAttribute> finalAttributes = new ArrayList<>(uniqueAttributes.values());
                        new ProductDAO().updateProduct(product, gameDetails, finalAttributes, finalImageUrls, platformIds, osIds, newKeys);
                        response.sendRedirect(request.getContextPath() + "/manage-products?action=list");

                    } catch (IllegalArgumentException e) {
                        System.err.println("Validation Error during update: " + e.getMessage());
                        request.setAttribute("errorMessage", e.getMessage());
                        int id = Integer.parseInt(request.getParameter("productId"));
                        ProductDAO productDAO = new ProductDAO();
                        Product existingProduct = productDAO.getProductById(id);
                        request.setAttribute("product", existingProduct);
                        request.setAttribute("categoriesList", new CategoryDAO().getAllCategories());
                        request.setAttribute("brandsList", new BrandDAO().getAllBrands());
                        request.setAttribute("allPlatforms", new StorePlatformDAO().getAllPlatforms());
                        request.setAttribute("allOS", new OperatingSystemDAO().getAllOperatingSystems());
                        request.setAttribute("gameDetails", existingProduct.getGameDetails());
                        if (existingProduct.getGameDetailsId() != null && existingProduct.getGameDetailsId() > 0) {
                            int gameDetailsId = existingProduct.getGameDetailsId();
                            request.setAttribute("gameKeys", new GameKeyDAO().findByGameDetailsId(gameDetailsId));
                            List<StorePlatform> selectedPlatforms = new StorePlatformDAO().findByGameDetailsId(gameDetailsId);
                            Set<Integer> selectedPlatformIds = new HashSet<>();
                            for (StorePlatform p : selectedPlatforms) {
                                int masterId = new StorePlatformDAO().getMasterStorePlatformIdByName(p.getStoreOSName());
                                if (masterId != -1) selectedPlatformIds.add(masterId);
                            }
                            request.setAttribute("selectedPlatformIds", selectedPlatformIds);
                            List<OperatingSystem> selectedOS = new OperatingSystemDAO().findByGameDetailsId(gameDetailsId);
                            Set<Integer> selectedOsIds = new HashSet<>();
                            for (OperatingSystem os : selectedOS) {
                                int masterId = new OperatingSystemDAO().getMasterOsIdByName(os.getOsName());
                                if (masterId != -1) selectedOsIds.add(masterId);
                            }
                            request.setAttribute("selectedOsIds", selectedOsIds);
                        }
                        Map<String, String> attributeMap = new HashMap<>();
                        if (existingProduct.getAttributes() != null) {
                            for (ProductAttribute attr : existingProduct.getAttributes()) {
                                attributeMap.put(attr.getAttributeName(), attr.getValue());
                            }
                        }
                        request.setAttribute("attributeMap", attributeMap);
                        request.getRequestDispatcher("/WEB-INF/dashboard/product-edit.jsp").forward(request, response);
                    } catch (Exception e) {
                        System.err.println("Error updating product: " + e.getMessage());
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Đã xảy ra lỗi khi cập nhật sản phẩm: " + e.getMessage());
                        int id = Integer.parseInt(request.getParameter("productId"));
                        ProductDAO productDAO = new ProductDAO();
                        Product existingProduct = productDAO.getProductById(id);
                        request.setAttribute("product", existingProduct);
                        request.setAttribute("categoriesList", new CategoryDAO().getAllCategories());
                        request.setAttribute("brandsList", new BrandDAO().getAllBrands());
                        request.setAttribute("allPlatforms", new StorePlatformDAO().getAllPlatforms());
                        request.setAttribute("allOS", new OperatingSystemDAO().getAllOperatingSystems());
                        request.setAttribute("gameDetails", existingProduct.getGameDetails());
                        if (existingProduct.getGameDetailsId() != null && existingProduct.getGameDetailsId() > 0) {
                            int gameDetailsId = existingProduct.getGameDetailsId();
                            request.setAttribute("gameKeys", new GameKeyDAO().findByGameDetailsId(gameDetailsId));
                            List<StorePlatform> selectedPlatforms = new StorePlatformDAO().findByGameDetailsId(gameDetailsId);
                            Set<Integer> selectedPlatformIds = new HashSet<>();
                            for (StorePlatform p : selectedPlatforms) {
                                int masterId = new StorePlatformDAO().getMasterStorePlatformIdByName(p.getStoreOSName());
                                if (masterId != -1) selectedPlatformIds.add(masterId);
                            }
                            request.setAttribute("selectedPlatformIds", selectedPlatformIds);
                            List<OperatingSystem> selectedOS = new OperatingSystemDAO().findByGameDetailsId(gameDetailsId);
                            Set<Integer> selectedOsIds = new HashSet<>();
                            for (OperatingSystem os : selectedOS) {
                                int masterId = new OperatingSystemDAO().getMasterOsIdByName(os.getOsName());
                                if (masterId != -1) selectedOsIds.add(masterId);
                            }
                            request.setAttribute("selectedOsIds", selectedOsIds);
                        }
                        Map<String, String> attributeMap = new HashMap<>();
                        if (existingProduct.getAttributes() != null) {
                            for (ProductAttribute attr : existingProduct.getAttributes()) {
                                attributeMap.put(attr.getAttributeName(), attr.getValue());
                            }
                        }
                        request.setAttribute("attributeMap", attributeMap);
                        request.getRequestDispatcher("/WEB-INF/dashboard/product-edit.jsp").forward(request, response);
                    }
                    break;
                }
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductDAO productDAO = new ProductDAO();
                    productDAO.deleteProduct(id);
                    response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
                    break;
                }
                case "updateVisibility": {
                    int productId = Integer.parseInt(request.getParameter("id"));
                    int newStatus = Integer.parseInt(request.getParameter("newStatus"));
                    String page = request.getParameter("page");

                    ProductDAO productDAO = new ProductDAO();
                    productDAO.updateProductVisibility(productId, newStatus);

                    String redirectUrl = request.getContextPath() + "/manage-products?action=list";
                    if (page != null && !page.isEmpty()) {
                        redirectUrl += "&page=" + page;
                    }

                    response.sendRedirect(redirectUrl);
                    break;
                }
                default:
                    response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
                    break;
            }
        } catch (Exception e) {
            System.err.println("An unexpected error occurred in doPost (main catch): " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/dashboard/product-list.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles all product management actions.";
    }
}