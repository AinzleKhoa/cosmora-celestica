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
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import shop.dao.VouchersDAO;
import shop.model.Voucher;

/**
 *
 * @author PC
 */
@WebServlet(name = "VoucherServlet", urlPatterns = {"/voucher"})
public class VoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String view = request.getParameter("view");
        String keyword = request.getParameter("search");
        VouchersDAO vD = new VouchersDAO();
        if (view == null || view.isEmpty() || view.equals("list")) {

            try {
                ArrayList<Voucher> voucherslist = vD.getList();

                request.setAttribute("voucherslist", voucherslist);
                request.getRequestDispatcher("/WEB-INF/admin/voucher-list.jsp").forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(VoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (view.equals("edit")) {
            VouchersDAO voucherDao = new VouchersDAO();
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                Voucher voucher = voucherDao.getOne(id);
                request.setAttribute("voucher", voucher);
                request.setAttribute("id", id);
                request.getRequestDispatcher("/WEB-INF/admin/voucher-edit.jsp").forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(VoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (view.equals("create")) {
            try {
                request.getRequestDispatcher("/WEB-INF/admin/voucher-create.jsp").forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(VoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (view.equals("search")) {
            try {
                ArrayList<Voucher> voucherslist;

                if (keyword != null && !keyword.trim().isEmpty()) {
                    voucherslist = vD.searchVoucherByCode(keyword);

                    if (voucherslist.isEmpty()) {
                        request.setAttribute("message", "No voucher codes matched your search.");
                    }
                } else {
                    voucherslist = vD.getList();
                }

                request.setAttribute("voucherslist", voucherslist);
                request.setAttribute("keyword", keyword); // để hiển thị lại trong ô input nếu cần
                request.getRequestDispatcher("/WEB-INF/admin/voucher-list.jsp").forward(request, response);

            } catch (Exception ex) {
                Logger.getLogger(VoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        VouchersDAO vD = new VouchersDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("code");
        BigDecimal value = new BigDecimal(request.getParameter("value"));
        int usageLimit = Integer.parseInt(request.getParameter("usage_limit"));
        LocalDate startDate = LocalDate.parse(request.getParameter("start_date"));
        LocalDate endDate = LocalDate.parse(request.getParameter("end_date"));
        int active = Integer.parseInt(request.getParameter("active"));
        String description = request.getParameter("description");
        BigDecimal minOrderValue = new BigDecimal(request.getParameter("min_order_value"));

        if (action != null) {
            switch (action) {
                case "edit":
                     try {
                    Voucher voucher = new Voucher(id, code, value, usageLimit, startDate, endDate, active, description, minOrderValue);

                    if (!vD.isDuplicateCodeForOtherVoucher(code, id)) {
                        if (vD.editVoucherCode(voucher) != 0) {
                            request.setAttribute("id", voucher.getVoucherId());
                            response.sendRedirect(request.getContextPath() + "/voucher?view=list");

                        } else {
                            request.setAttribute("message", "Failed to update voucher!");
                            request.setAttribute("voucher", voucher);
                            request.getRequestDispatcher("/WEB-INF/admin/voucher-edit.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("message", "Voucher code already exists!");
                        request.setAttribute("voucher", voucher);
                        request.getRequestDispatcher("/WEB-INF/admin/voucher-edit.jsp").forward(request, response);

                    }

                } catch (Exception ex) {
                    Logger.getLogger(VoucherServlet.class
                            .getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("error", "Invalid data error!");
                    request.getRequestDispatcher("/WEB-INF/admin/dashboard-voucher-edit.jsp").forward(request, response);
                }
                break;
                case "create":
                     try {
                    Voucher voucher = new Voucher(code, value, usageLimit, startDate, endDate, active, description, minOrderValue);

                    if (!vD.isDuplicateCodeForOtherVoucherOfTheCreate(code)) {
                        if (vD.createVoucherCode(voucher) != 0) {
                            request.getSession().setAttribute("message", "Voucher created successfully!");
                            response.sendRedirect(request.getContextPath() + "/voucher?view=list");

                        } else {
                            request.setAttribute("message", "Failed to create voucher!");
                            request.getRequestDispatcher("/WEB-INF/admin/voucher-create.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("message", "Voucher code already exists!");
                        request.getRequestDispatcher("/WEB-INF/admin/voucher-create.jsp").forward(request, response);

                    }

                } catch (Exception ex) {
                    Logger.getLogger(VoucherServlet.class
                            .getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("message", "Invalid data error!");
                    request.getRequestDispatcher("/WEB-INF/admin/voucher-create.jsp").forward(request, response);
                }
                break;

            }
        }
    }
}
