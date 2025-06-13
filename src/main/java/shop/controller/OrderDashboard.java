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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import shop.dao.OrderDashboardDAO;
import shop.model.Customer;
import shop.model.Order;
import shop.model.OrderDetail;
import shop.model.Product;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "OrderDashboard", urlPatterns = {"/orderdashboard"})
public class OrderDashboard extends HttpServlet {

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
            out.println("<title>Servlet OrderDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDashboard at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String view = request.getParameter("view");
        if (view == null || view.isEmpty() || view.equals("list")) {
            OrderDashboardDAO OD = new OrderDashboardDAO();
            try {
                ArrayList<Order> orderlist = OD.getallOrder();

                request.setAttribute("orderlist", orderlist);
                request.getRequestDispatcher("/WEB-INF/view/dashboar-order-list.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(OrderDashboard.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (view.equals("detail")) {
            OrderDashboardDAO OD = new OrderDashboardDAO();
            String cus_id = request.getParameter("customer_id");
            String o_id = request.getParameter("order_id");
            int customer_id = Integer.parseInt(cus_id);
            int order_id = Integer.parseInt(o_id);
            try {
                Customer customer = OD.getCustomerById(customer_id);
                ArrayList<OrderDetail> orderDetails = OD.getOrderDetail(order_id);
                Order order = OD.getOneOrder(order_id);
                request.setAttribute("order", order);
                request.setAttribute("customer", customer);
                request.setAttribute("orderdetail", orderDetails);
                request.getRequestDispatcher("/WEB-INF/view/dashboard-order-detail.jsp").forward(request, response);

            } catch (SQLException ex) {
                Logger.getLogger(OrderDashboard.class.getName()).log(Level.SEVERE, null, ex);
            }

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
        response.setContentType("text/plain");
        String action = request.getParameter("action");
        if (action.equals("update")) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            OrderDashboardDAO OD = new OrderDashboardDAO();
            try {
                if (OD.updateOrderStatus(status, orderId) == 1) {
                    response.sendRedirect(request.getContextPath() + "/orderdashboard");

                }

            } catch (SQLException ex) {
                Logger.getLogger(OrderDashboard.class.getName()).log(Level.SEVERE, null, ex);

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
