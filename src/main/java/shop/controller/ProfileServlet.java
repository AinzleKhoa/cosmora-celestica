/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package shop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import shop.dao.CustomerDAO;
import shop.model.Customer;

/**
 *
 * @author CE190449 - Le Anh Khoa
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

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
        request.getRequestDispatcher("/WEB-INF/home/profile.jsp")
                .forward(request, response);
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
        String action = request.getParameter("action");
        if (action.equals("updateProfile")) {
            int id = Integer.parseInt(request.getParameter("id"));

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String fullName = firstName + " " + lastName;
            String username = request.getParameter("username");
            String email = request.getParameter("email");

            String phone = request.getParameter("phone");
            int gender = Integer.parseInt(request.getParameter("gender"));
            String address = request.getParameter("address");
            String avatarUrl = request.getParameter("avatarUrl");
            String dateOfBirthParameter = request.getParameter("dateOfBirth");
            if (dateOfBirthParameter != null && !dateOfBirthParameter.isEmpty()) {
                Date dateOfBirth = Date.valueOf(dateOfBirthParameter);
            }

            CustomerDAO cDAO = new CustomerDAO();
            Customer customer = cDAO.getAccountById(id);

            if (customer != null) {
                
            }
        }
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
