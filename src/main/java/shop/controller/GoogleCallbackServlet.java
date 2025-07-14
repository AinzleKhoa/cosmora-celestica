/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package shop.controller;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.Instant;
import shop.dao.CustomerDAO;
import shop.model.Customer;

/**
 *
 * @author CE190449 - Le Anh Khoa
 */
@WebServlet(name = "GoogleCallbackServlet", urlPatterns = {"/oauth2callback"})
public class GoogleCallbackServlet extends HttpServlet {

    private static final String CLIENT_ID = "269154426187-nkt8qnsov2rjis59n8ji48lfuop0e4on.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/CosmoraCelestica/oauth2callback";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                new NetHttpTransport(),
                JacksonFactory.getDefaultInstance(),
                "https://oauth2.googleapis.com/token",
                CLIENT_ID,
                CLIENT_SECRET,
                code,
                REDIRECT_URI
        ).execute();

        GoogleIdToken idToken = tokenResponse.parseIdToken();
        GoogleIdToken.Payload payload = idToken.getPayload();

        // Get info from Google
        String name = (String) payload.get("name");
        String email = payload.getEmail();
        String googleId = payload.getSubject(); // Unique ID for the user from Google

        CustomerDAO cDAO = new CustomerDAO();
        Customer customer = cDAO.getAccountByEmail(email);

        if (customer != null) {
            if (!customer.isIsDeactivated()) {
                if (customer.getGoogleId() == null) {
                    System.out.println(googleId);
                    customer.setGoogleId(googleId);
                    cDAO.updateCustomer(customer); // Save linked Google ID
                } else if (!customer.getGoogleId().equals(googleId)) { // Rare exception
                    request.setAttribute("message", "Google ID mismatch. Please contact support.");
                    request.getRequestDispatcher("/WEB-INF/home/login.jsp").forward(request, response);
                }
            } else {
                request.getSession().setAttribute("message", "Your account is locked. Please contact us for more information.");
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } else {
            // New Google user
            customer = new Customer();
            customer.setFullName(name);
            customer.setUsername(name);
            customer.setEmail(email);
            customer.setPasswordHash("GOOGLE_OAUTH_USER");
            customer.setAvatarUri(request.getContextPath() + "/assets/img/avatar/avatar1.png");
            customer.setGoogleId(googleId);
            customer.setEmailVerified(true);
            customer.setCreatedAt(Timestamp.from(Instant.now()));
            customer.setUpdatedAt(Timestamp.from(Instant.now()));
            cDAO.createCustomer(customer);
            HttpSession session = request.getSession();
            session.setAttribute("currentCustomer", customer);

            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
