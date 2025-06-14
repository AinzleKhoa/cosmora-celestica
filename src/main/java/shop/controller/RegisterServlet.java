/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package shop.controller;

import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import shop.dao.CustomerDAO;
import shop.util.PasswordUtils;
import shop.model.Customer;

/**
 *
 * @author CE190449 - Le Anh Khoa
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JsonObject jsonResponse = new JsonObject();

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String avatarUrl = request.getContextPath() + "/assets/img/avatar/avatar1.png";

        CustomerDAO cDAO = new CustomerDAO();
        String hashedPassword = PasswordUtils.hashPassword(password);

        // If email already exists
        if (!cDAO.isEmailExists(email)) {
            // If username already exists
            if (!cDAO.isUsernameExists(username)) {
                // Register , insert customer if all is through
                if (cDAO.createCustomer(new Customer(username, email, hashedPassword, avatarUrl)) > 0) {
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("message", "Registration successful! Please log in.");
                    jsonResponse.addProperty("redirectUrl", request.getContextPath() + "/login");
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Something went wrong. Please try again.");
                }
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "The username already exists. Please try again.");
            }
        } else {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "The email already exists. Please try again.");
        }
        response.getWriter().write(jsonResponse.toString());
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
