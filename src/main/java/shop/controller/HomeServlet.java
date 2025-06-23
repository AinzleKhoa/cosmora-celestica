package shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import shop.dao.ProductDAO;
import shop.model.Product;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        ProductDAO productDAO = new ProductDAO();

        try {
            switch (action) {
                case "details": {
                    try {
                        int productId = Integer.parseInt(request.getParameter("productId"));
                        Product product = productDAO.getProductById(productId);

                        if (product != null) {
                            double averageStars = productDAO.getAverageStarsForProduct(productId);
                            product.setAverageStars(averageStars);
                        }

                        request.setAttribute("product", product);
                        request.getRequestDispatcher("/WEB-INF/home/product-details.jsp").forward(request, response);
                    } catch (NumberFormatException e) {
                        response.sendRedirect("home");
                    }
                    break;
                }
                default: {
                    List<Product> accessoryList = productDAO.getAccessoryProducts();

                    for (Product product : accessoryList) {
                        double stars = productDAO.getAverageStarsForProduct(product.getProductId());
                        product.setAverageStars(stars);
                    }

                    List<Product> gameList = productDAO.getGameProducts();

                    for (Product product : gameList) {
                        double stars = productDAO.getAverageStarsForProduct(product.getProductId());
                        product.setAverageStars(stars);
                    }
  
                    request.setAttribute("gameList", gameList);
                    request.setAttribute("accessoryList", accessoryList);

                    request.getRequestDispatcher("/WEB-INF/home/home.jsp")
                            .forward(request, response);
                    break;
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error in HomeServlet: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Home Servlet that handles routing for homepage and product details.";
    }
}
