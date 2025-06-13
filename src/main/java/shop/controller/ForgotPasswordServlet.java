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
        String action = request.getParameter("action");

        if (action != null && action.equals("sendOtp")) {
            String email = request.getParameter("email");

            CustomerDAO cDAO = new CustomerDAO();
            Customer customer = cDAO.getAccountByEmail(email);

            if (customer != null) {
                // Check if the account is not deactivated
                if (!customer.isIsDeactivated()) {
                    String otp = SecurityTokenUtils.generateOTP(6);
                    Timestamp expiry = Timestamp.from(Instant.now().plus(5, ChronoUnit.MINUTES));

                    // Attempt to store OTP in the database
                    if (cDAO.storeOtpForEmail(email, otp, expiry) > 0) {
                        String to = email;
                        String subject = "Your Cosmora Celestica OTP Code";
                        String content = "Your OTP is: " + otp + "\nIt will expire in 5 minutes.";

                        // Try sending the OTP email
                        if (EmailUtils.sendEmail(to, subject, content)) {
                            response.setContentType("application/json");
                            response.getWriter().write("{\"success\": true, \"message\": \"OTP sent successfully!\"}");
                        } else {
                            // If sending OTP email fails
                            response.setContentType("application/json");
                            response.getWriter().write("{\"success\": false, \"message\": \"Failed to send OTP to the email.\"}");
                        }
                    } else {
                        // If storing the OTP in the database fails
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": false, \"message\": \"Failed to store OTP.\"}");
                    }
                } else {
                    // If the account is deactivated
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": false, \"message\": \"Your account is locked. Please contact us for more information.\"}");
                }
            } else {
                // If the email doesn't exist
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Email does not exist.\"}");
            }
        } else {
            String email = request.getParameter("email");
            String otp = request.getParameter("otp");

            CustomerDAO cDAO = new CustomerDAO();
            Customer customer = cDAO.getAccountByEmail(email);

            if (customer != null) {
                // Check if the account is not deactivated
                if (!customer.isIsDeactivated()) {
                    // Check if the OTP matches
                    if (cDAO.checkOtpForEmail(email, otp)) {
                        response.setContentType("application/json");
                        HttpSession session = request.getSession();
                        session.setAttribute("currentForgotCustomer", customer);
                        response.getWriter().write("{\"success\": true, \"message\": \"OTP verified successfully! Redirecting...\", \"redirectUrl\": \"" + request.getContextPath() + "/reset-password\"}");
                    } else {
                        // If OTP is incorrect
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": false, \"message\": \"The OTP is incorrect or has expired. Please try again.\"}");
                    }
                } else {
                    // If the account is deactivated
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": false, \"message\": \"Your account is locked. Please contact us for more information.\"}");
                }
            } else {
                // If the email doesn't exist
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Email does not exist.\"}");
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
