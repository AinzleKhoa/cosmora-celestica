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
            showHomePage(request, response);
        } else if (action.equals("details")) {
            showProductDetails(request, response);
        } else {
            showHomePage(request, response);
        }
    }
    
    private void showHomePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();       
        List<Product> accessoryList = productDAO.getAccessoryProducts();
        List<Product> gameList = productDAO.getGameProducts();
        request.setAttribute("gameList", gameList);
        request.setAttribute("accessoryList", accessoryList);
        request.getRequestDispatcher("/WEB-INF/home/home.jsp")
               .forward(request, response);
    }
    
    private void showProductDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));        
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);         
            request.setAttribute("product", product);           
            request.getRequestDispatcher("/WEB-INF/home/product-details.jsp").forward(request, response);     
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
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