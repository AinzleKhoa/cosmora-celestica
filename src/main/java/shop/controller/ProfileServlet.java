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
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import shop.dao.CustomerDAO;
import shop.dao.OrderDAO;
import shop.dao.ProductDAO;
import shop.model.Customer;
import shop.model.Order;
import shop.model.OrderDetails;

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
        HttpSession session = request.getSession();
        Customer temp = (Customer) session.getAttribute("currentCustomer");
        OrderDAO OD = new OrderDAO();
        try {
            ArrayList<Order> order = OD.getOrderById(temp.getCustomerId());
            request.setAttribute("order", order);
            request.getRequestDispatcher("/WEB-INF/home/profile.jsp")
                    .forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

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
        } else if (action.equals("details")) {
            OrderDAO OD = new OrderDAO();
            int orderid = Integer.parseInt(request.getParameter("order_id"));

            try {
                ArrayList<OrderDetails> orderDetails = OD.getOrderDetailForCus(orderid);
                Order order = OD.getOneOrder(orderid);
                request.setAttribute("order", order);
                request.setAttribute("orderdetails", orderDetails);
                request.getRequestDispatcher("/WEB-INF/home/profile-order-details.jsp").forward(request, response);

            } catch (SQLException ex) {
                Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (action.equals("review")) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int value = 0;
            String ratingStr = request.getParameter("rating");
            if (ratingStr == null || ratingStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            value=Integer.parseInt(ratingStr);

            HttpSession session = request.getSession();
            Customer temp = (Customer) session.getAttribute("currentCustomer");
            OrderDAO OD = new OrderDAO();
            ProductDAO PD = new ProductDAO();
            try {
                int[] productId = OD.getProIdByOrderId(orderId);
                if (PD.writeReviewIntoDb(productId, temp.getCustomerId(), value) != 0) {
                    response.sendRedirect(request.getContextPath() + "/profile");

                }
            } catch (SQLException ex) {
                Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
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
