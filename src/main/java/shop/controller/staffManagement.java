/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package shop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Properties;
import shop.dao.StaffDAO;
import shop.model.Staff;

/**
 *
 * @author VICTUS
 */
@WebServlet(name = "staffManagement", urlPatterns = {"/staffmanagement"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class staffManagement extends HttpServlet {

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
            out.println("<title>Servlet staffManagement</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet staffManagement at " + request.getContextPath() + "</h1>");
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
            StaffDAO sDAO = new StaffDAO();
            ArrayList<Staff> sList = sDAO.getList();
            request.setAttribute("s", sList);
            request.getRequestDispatcher("/WEB-INF/view/staff-list.jsp").forward(request, response);

        } else if (view.equals("create")) {
            request.getRequestDispatcher("/WEB-INF/view/create-staff.jsp").forward(request, response);

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
    response.setContentType("text/html;charset=UTF-8");
    String act = request.getParameter("action");

    if (act != null) {
        StaffDAO sDAO = new StaffDAO();
        switch (act) {
            case "create":
                try (PrintWriter out = response.getWriter()) {
                    String username = request.getParameter("username");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String phone = request.getParameter("phone");
                    String role = request.getParameter("role");
                    String dobStr = request.getParameter("date_of_birth");

                    Date dateOfBirth = null;
                    if (dobStr != null && !dobStr.isEmpty()) {
                        dateOfBirth = Date.valueOf(dobStr);
                    }

                    Part img = request.getPart("avatar_url");
                    String filename = Paths.get(img.getSubmittedFileName()).getFileName().toString();

                   
                    String realPath = request.getServletContext().getRealPath("/img/staff");


                    

                    if (realPath == null) {
                        out.println("<h2>Error: No valid upload path found.</h2>");
                        return;
                    }

                    // Tạo thư mục nếu chưa tồn tại
                    File uploadDir = new File(realPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    // Ghi file
                    File fileToSave = new File(uploadDir, filename);
                    img.write(fileToSave.getAbsolutePath());

                    // Lưu thông tin vào DB (chỉ lưu tên file)
                    Staff staff = new Staff(username, email, password, phone, role, dateOfBirth, filename);
                    int isCreated = sDAO.create(staff);

                    if (isCreated == 1) {
                        response.sendRedirect(request.getContextPath() + "/staffmanagement");
                    } else {
                        out.println("<h2>Error: Can't add staff into database.</h2>");
                    }

                } catch (Exception e) {
                    response.getWriter().println("<h2>Upload failed!</h2>");
                    e.printStackTrace(response.getWriter());
                }
                break;
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
