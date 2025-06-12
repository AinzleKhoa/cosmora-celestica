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
import java.sql.Timestamp;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import shop.dao.CustomerDAO;
import shop.model.Customer;
import shop.util.EmailUtils;
import shop.util.PasswordUtils;
import shop.util.SecurityTokenUtils;

/**
 *
 * @author CE190449 - Le Anh Khoa
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

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
        HttpSession session = request.getSession(false); // Get the current session (if it exists)

        if (session != null) {
            // Retrieve the success message from the session
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                // Add the message to the request to be displayed on the login page
                request.setAttribute("successMessage", successMessage);
                // Remove the message from the session after it has been used
                session.removeAttribute("successMessage");
            }
            // Retrieve the email message from the session
            String currentForgotEmail = (String) session.getAttribute("currentForgotEmail");
            if (currentForgotEmail != null) {
                // Add the message to the request to be displayed on the login page
                request.setAttribute("currentForgotEmail", currentForgotEmail);
                // Remove the message from the session after it has been used
                session.removeAttribute("currentForgotEmail");
            }
        }

        request.getRequestDispatcher("/WEB-INF/view/forgot-password.jsp")
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
        String email = request.getParameter("email");

        CustomerDAO cDAO = new CustomerDAO();
        Customer customer = cDAO.getAccountByEmail(email);

        if (customer != null) {
            if (!customer.isIsDeactivated()) {
                String otp = SecurityTokenUtils.generateOTP(6);
                Timestamp expiry = Timestamp.from(Instant.now().plus(5, ChronoUnit.MINUTES));

                if (cDAO.storeOtpForEmail(email, otp, expiry) > 0) {
                    String to = email;
                    String subject = "Your Cosmora Celestica OTP Code";
                    String content = "Your OTP is: " + otp + "\nIt will expire in 5 minutes.";
                    if (EmailUtils.sendEmail(to, subject, content)) {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": true, \"message\": \"OTP sent successfully!\"}");
                    } else {
                        // If 
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": false, \"message\": \"Failed to send OTP to email.\"}");
                    }
                } else {
                    // If 
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": false, \"message\": \"storing OTP unsuccessfully.\"}");
                }
            } else {
                // If account is deactivated, set error message and forward
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Your account is locked. Contacts us for more informations.\"}");
            }
        } else {
            // If email doesn't exist, set error message and forward
            request.setAttribute("errorMessage", "Email doesn't exist.");
            request.getRequestDispatcher("/WEB-INF/view/forgot-password.jsp").forward(request, response);
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
