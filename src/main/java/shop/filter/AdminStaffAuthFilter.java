/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import shop.util.SessionUtil;

/**
 *
 * @author Le Anh Khoa - CE190449
 */
//@WebFilter(filterName = "AdminStaffAuthFilter", urlPatterns = {"/manage-products", "/manage-staffs", "/manage-customers", "/manage-orders", "/manage-vouchers", "/manage-discounts"})
public class AdminStaffAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        // Kiem tra session co hop le hay khong (dang nhap chua)
        HttpServletRequest req = (HttpServletRequest) request;

        if (SessionUtil.isCustomerLoggedIn(req)) {
            chain.doFilter(req, response);
            System.out.println("Staff/Admin has logged in!");
        } else {
            ((HttpServletResponse) response).sendRedirect(req.getContextPath() + "/404");
            System.out.println("Staff/Admin not logged in! Redirecting to 404");
        }
    }
}
