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
import jakarta.servlet.http.HttpSession;
import shop.dao.CustomerDAO;
import shop.filter.PasswordUtils;
import shop.model.Customer;

/**
 *
 * @author CE190449 - Le Anh Khoa
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

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
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
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
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        CustomerDAO cDAO = new CustomerDAO();
        Customer customer = cDAO.login(email, password);

        if (customer != null) {
            response.sendRedirect(request.getContextPath() + "/home");

            if (!customer.isIsDeactivated()) {
                boolean isPasswordMatched = PasswordUtils.checkPassword(password, customer.getPasswordHash());

                if (isPasswordMatched) {
                    session = request.getSession(true);
                    session.setAttribute("currentCustomer", customer);
                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    request.setAttribute("errorMessage", "Email or password is incorrect. Try again.");
                    request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                }

            } else {
                request.setAttribute("errorMessage", "Your account is locked. Contacts us for more informations");
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("errorMessage", "Something went wrong. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
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
