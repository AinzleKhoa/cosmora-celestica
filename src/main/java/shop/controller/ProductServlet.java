/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
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
import shop.model.GameKey;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        try {
            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "update":
                    showUpdateForm(request, response);
                    break;
                case "details":
                    showProductDetails(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "search":
                    searchProducts(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error in doGet", e);
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
                case "add":
                    handleAddProduct(request, response);
                    break;
                case "update":
                    handleUpdateProduct(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã có lỗi xảy ra trong quá trình xử lý: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/dashboard/product-list.jsp").forward(request, response);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        request.setAttribute("productList", productDAO.getAllProducts());
        request.getRequestDispatcher("/WEB-INF/dashboard/product-list.jsp").forward(request, response);
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        String query = request.getParameter("query");
        List<Product> productList;
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
        request.getRequestDispatcher("/WEB-INF/dashboard/product-list.jsp").forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        productDAO.deleteProduct(id);
        response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        request.setAttribute("categoriesList", new CategoryDAO().getAllCategories());
        request.setAttribute("brandsList", new BrandDAO().getAllBrands());
        request.setAttribute("allPlatforms", new StorePlatformDAO().getAllPlatforms());
        request.setAttribute("allOS", new OperatingSystemDAO().getAllOperatingSystems());
        request.getRequestDispatcher("/WEB-INF/dashboard/product-add.jsp").forward(request, response);
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        Product existingProduct = productDAO.getProductById(id);

        if (existingProduct == null) {
            response.sendRedirect("manage-products?action=list");
            return;
        }

        request.setAttribute("product", existingProduct);
        request.setAttribute("categoriesList", new CategoryDAO().getAllCategories());
        request.setAttribute("brandsList", new BrandDAO().getAllBrands());
        request.setAttribute("allPlatforms", new StorePlatformDAO().getAllPlatforms());
        request.setAttribute("allOS", new OperatingSystemDAO().getAllOperatingSystems());
        request.setAttribute("gameDetails", existingProduct.getGameDetails());

        if (existingProduct.getGameDetailsId() != null && existingProduct.getGameDetailsId() > 0) {
            int gameDetailsId = existingProduct.getGameDetailsId();
            GameKeyDAO gameKeyDAO = new GameKeyDAO();
            StorePlatformDAO platformDAO = new StorePlatformDAO();
            OperatingSystemDAO osDAO = new OperatingSystemDAO();

            request.setAttribute("gameKeys", gameKeyDAO.findByGameDetailsId(gameDetailsId));

            List<StorePlatform> selectedPlatforms = platformDAO.findByGameDetailsId(gameDetailsId);
            Set<Integer> selectedPlatformIds = new HashSet<>();
            for (StorePlatform p : selectedPlatforms) {
                int masterId = platformDAO.getMasterStorePlatformIdByName(p.getStoreOSName());
                if (masterId != -1) {
                    selectedPlatformIds.add(masterId);
                }
            }
            request.setAttribute("selectedPlatformIds", selectedPlatformIds);

            List<OperatingSystem> selectedOS = osDAO.findByGameDetailsId(gameDetailsId);
            Set<Integer> selectedOsIds = new HashSet<>();
            for (OperatingSystem os : selectedOS) {
                int masterId = osDAO.getMasterOsIdByName(os.getOsName());
                if (masterId != -1) {
                    selectedOsIds.add(masterId);
                }
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

    private void showProductDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(id);

        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
            return;
        }

        if ("Game".equalsIgnoreCase(product.getCategoryName()) && product.getGameDetailsId() != null && product.getGameDetailsId() > 0) {
            int gameDetailsId = product.getGameDetailsId();
            request.setAttribute("gameKeys", new GameKeyDAO().findByGameDetailsId(gameDetailsId));

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

        Locale localeVN = new Locale("vi", "VN");
        request.setAttribute("currencyFormatter", NumberFormat.getCurrencyInstance(localeVN));
        request.setAttribute("timestampFormatter", new SimpleDateFormat("dd/MM/yyyy HH:mm:ss"));
        request.setAttribute("dateFormatter", new SimpleDateFormat("dd/MM/yyyy"));
        request.setAttribute("product", product);
        request.getRequestDispatcher("/WEB-INF/dashboard/product-details.jsp").forward(request, response);
    }

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String productType = request.getParameter("productType");
        String name = request.getParameter("name");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        List<String> imageUrls = uploadAndGetImageUrls(request.getParts());

        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setCategoryId(categoryId);

        ProductDAO productDAO = new ProductDAO();

        if ("game".equals(productType)) {
            GameDetails gameDetails = new GameDetails();
            gameDetails.setDeveloper(request.getParameter("developer"));
            gameDetails.setGenre(request.getParameter("genre"));
            gameDetails.setReleaseDate(Date.valueOf(request.getParameter("releaseDate")));

            String[] platformIds = request.getParameterValues("platformIds");
            String[] osIds = request.getParameterValues("osIds");
            String newKeysRaw = request.getParameter("gameKeys");
            String[] newKeys = (newKeysRaw != null && !newKeysRaw.trim().isEmpty())
                    ? newKeysRaw.split("\\r?\\n") : new String[0];

            productDAO.addFullGameProduct(product, gameDetails, imageUrls, platformIds, osIds, newKeys);
        } else {
            String brandIdStr = request.getParameter("brandId");
            product.setBrandId((brandIdStr != null && !brandIdStr.isEmpty()) ? Integer.parseInt(brandIdStr) : null);

            List<ProductAttribute> attributes = createAttributeListFromRequest(request);
            productDAO.addAccessoryProduct(product, attributes, imageUrls);
        }
        response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
    }

    private void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String productType = request.getParameter("productType");

        List<String> newImageUrls = null;
        boolean imagesWereUploaded = false;
        for (Part part : request.getParts()) {
            if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                imagesWereUploaded = true;
                break;
            }
        }
        if (imagesWereUploaded) {
            newImageUrls = uploadAndGetImageUrls(request.getParts());
        }

        Product product = new Product();
        product.setProductId(productId);
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setCategoryId(categoryId);

        GameDetails gameDetails = null;
        List<ProductAttribute> attributes = null;
        String[] platformIds = null;
        String[] osIds = null;
        String[] newKeys = null;

        if ("game".equalsIgnoreCase(productType)) {
            product.setBrandId(null); 
            int gameDetailsId = Integer.parseInt(request.getParameter("gameDetailsId"));
            product.setGameDetailsId(gameDetailsId);

            gameDetails = new GameDetails();
            gameDetails.setGameDetailsId(gameDetailsId);
            gameDetails.setDeveloper(request.getParameter("developer"));
            gameDetails.setGenre(request.getParameter("genre"));
            String releaseDateStr = request.getParameter("releaseDate");
            if (releaseDateStr != null && !releaseDateStr.isEmpty()) {
                gameDetails.setReleaseDate(Date.valueOf(releaseDateStr));
            }
            platformIds = request.getParameterValues("platformIds");
            osIds = request.getParameterValues("osIds");
            String newKeysRaw = request.getParameter("newGameKeys");
            if (newKeysRaw != null && !newKeysRaw.trim().isEmpty()) {
                newKeys = newKeysRaw.split("\\r?\\n");
            }
        } else {
            String brandIdStr = request.getParameter("brandId");
            product.setBrandId((brandIdStr != null && !brandIdStr.isEmpty()) ? Integer.parseInt(brandIdStr) : null);
            attributes = createAttributeListFromRequest(request);
        }

        new ProductDAO().updateProduct(product, gameDetails, attributes, newImageUrls, platformIds, osIds, newKeys);
        response.sendRedirect(request.getContextPath() + "/manage-products?action=list");
    }

    private List<String> uploadAndGetImageUrls(Collection<Part> parts) throws IOException {
        List<String> imageUrls = new ArrayList<>();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        for (Part filePart : parts) {
            if ("productImages".equals(filePart.getName()) && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (fileName != null && !fileName.isEmpty()) {
                    filePart.write(uploadPath + File.separator + fileName);
                    imageUrls.add(fileName);
                }
            }
        }
        return imageUrls;
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

    private void addAttributeIfPresent(List<ProductAttribute> attributes, HttpServletRequest request, String attrName, String paramName) {
        String value = request.getParameter(paramName);
        if (value != null && !value.trim().isEmpty()) {
            ProductAttribute pa = new ProductAttribute();
            pa.setAttributeName(attrName);
            pa.setValue(value);
            attributes.add(pa);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles all product management actions.";
    }
}
