/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Le Anh Khoa - CE190449
 */
public class SessionUtil {

    public static boolean isCustomerLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false); // Get session without creating a new one
        return session != null && session.getAttribute("currentCustomer") != null; // Return true if session exists and user is set
    }
}
