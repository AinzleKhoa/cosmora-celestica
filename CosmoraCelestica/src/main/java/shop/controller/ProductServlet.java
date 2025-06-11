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
import java.util.List;
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
    private static final String UPLOAD_DIRECTORY = "uploads";

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
                    String productType = request.getParameter("productType");
                    String name = request.getParameter("name");
                    BigDecimal price = new BigDecimal(request.getParameter("price"));
                    String description = request.getParameter("description");
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    int brandId = Integer.parseInt(request.getParameter("brandId"));

                    Part filePart = request.getPart("productImageFile");
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String imageUrl = "";
                    if (fileName != null && !fileName.isEmpty()) {
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdir();
                        }
                        filePart.write(uploadPath + File.separator + fileName);
                        imageUrl = UPLOAD_DIRECTORY + "/" + fileName;
                    }

                    Product product = new Product();
                    product.setName(name);
                    product.setDescription(description);
                    product.setPrice(price);
                    product.setQuantity(quantity);
                    product.setCategoryId(categoryId);
                    product.setBrandId(brandId);

                    ProductDAO productDAO = new ProductDAO();

                    if ("game".equals(productType)) {
                        GameDetails gameDetails = new GameDetails();
                        gameDetails.setDeveloper(request.getParameter("developer"));
                        gameDetails.setGenre(request.getParameter("publisher"));
                        gameDetails.setReleaseDate(Date.valueOf(request.getParameter("releaseDate")));
                        productDAO.addGameProduct(product, gameDetails, imageUrl);
                    } else {
                        List<ProductAttribute> attributes = createAttributeListFromRequest(request, productType);
                        productDAO.addAccessoryProduct(product, attributes, imageUrl);
                    }

                    response.sendRedirect(request.getContextPath() + "/products?action=list&add_success=true");
                    break;
                }
                case "update": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    String name = request.getParameter("name");
                    BigDecimal price = new BigDecimal(request.getParameter("price"));
                    String description = request.getParameter("description");
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    int brandId = Integer.parseInt(request.getParameter("brandId"));

                    Product product = new Product();
                    product.setProductId(productId);
                    product.setName(name);
                    product.setDescription(description);
                    product.setPrice(price);
                    product.setQuantity(quantity);
                    product.setCategoryId(categoryId);
                    product.setBrandId(brandId);

                    Part filePart = request.getPart("productImageFile");
                    String newImageUrl = null;
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        if (fileName != null && !fileName.isEmpty()) {
                            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                            File uploadDir = new File(uploadPath);
                            if (!uploadDir.exists()) {
                                uploadDir.mkdir();
                            }
                            filePart.write(uploadPath + File.separator + fileName);
                            newImageUrl = UPLOAD_DIRECTORY + "/" + fileName;
                        }
                    }

                    ProductDAO productDAO = new ProductDAO();
                    productDAO.updateProduct(product, newImageUrl);

                    response.sendRedirect(request.getContextPath() + "/products?update_success=true");
                    break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private List<ProductAttribute> createAttributeListFromRequest(HttpServletRequest request, String productType) {
        List<ProductAttribute> attributes = new ArrayList<>();
        attributes.add(createAttribute("warranty_months", request.getParameter("warrantyMonths")));
        attributes.add(createAttribute("weight_grams", request.getParameter("weightGrams")));
        attributes.add(createAttribute("connection_type", request.getParameter("connectionType")));
        attributes.add(createAttribute("usage_time_hours", request.getParameter("usageTimeHours")));
        switch (productType) {
            case "headphone":
                attributes.add(createAttribute("headphone_type", request.getParameter("headphoneType")));
                attributes.add(createAttribute("material", request.getParameter("headphoneMaterial")));
                attributes.add(createAttribute("battery_capacity_mah", request.getParameter("headphoneBattery")));
                attributes.add(createAttribute("features", request.getParameter("headphoneFeatures")));
                break;
            case "keyboard":
                attributes.add(createAttribute("size", request.getParameter("keyboardSize")));
                attributes.add(createAttribute("material", request.getParameter("keyboardMaterial")));
                attributes.add(createAttribute("keyboard_type", request.getParameter("keyboardType")));
                break;
            case "mouse":
                attributes.add(createAttribute("mouse_type", request.getParameter("mouseType")));
                break;
            case "controller":
                attributes.add(createAttribute("material", request.getParameter("controllerMaterial")));
                attributes.add(createAttribute("battery_capacity_mah", request.getParameter("controllerBattery")));
                attributes.add(createAttribute("ChargingTimeHours", request.getParameter("controllerChargingTime")));
                break;
        }
        return attributes;
    }

    private ProductAttribute createAttribute(String attributeName, String value) {
        if (value != null && !value.trim().isEmpty()) {
            ProductAttribute pa = new ProductAttribute();
            pa.setAttributeName(attributeName);
            pa.setValue(value);
            return pa;
        }
        return null;
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
