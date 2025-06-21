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
import shop.dao.CartDAO;
import shop.dao.CustomerDAO;
import shop.model.Cart;

/**
 *
 * @author VICTUS
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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

//            StaffDAO sDAO = new StaffDAO();
//            ArrayList<Staff> sList = sDAO.getList(page);
//            request.setAttribute("s", sList);
//
//            request.setAttribute("s", sList);
            request.getRequestDispatcher("/WEB-INF/manageCartForCus/cart-list.jsp").forward(request, response);

        } else if (view.equals("create")) {
            request.getRequestDispatcher("/WEB-INF/dashboard/staff-create.jsp").forward(request, response);

        } else if (view.equals("edit")) {
//            try {
//                String idParam = request.getParameter("id");
//
//                int id = Integer.parseInt(idParam);
//                StaffDAO sDAO = new StaffDAO();
//                Staff oneStaff = sDAO.getOneById(id);
//
//                if (oneStaff == null) {
//                    response.sendRedirect("/WEB-INF/dashboard/staff-list.jsp");
//                    return;
//                }
//
//                request.setAttribute("s", oneStaff);
//                request.getRequestDispatcher("/WEB-INF/dashboard/staff-edit.jsp").forward(request, response);
//
//            } catch (NumberFormatException e) {
//                System.err.println("Lỗi định dạng ID: " + e.getMessage());
//                response.sendRedirect("/WEB-INF/dashboard/staff-list.jsp");
//            } catch (Exception e) {
//                System.err.println("Lỗi không mong muốn: " + e.getMessage());
//                response.sendRedirect("/WEB-INF/dashboard/staff-list.jsp");
//            }
        } else if (view.equals("delete")) {
//            String idParam = request.getParameter("id");
//
//            if (idParam == null || idParam.trim().isEmpty() || !idParam.matches("\\d+")) {
//                response.sendRedirect("/WEB-INF/dashboard/staff-list.jsp");
//                return;
//            }
//
//            int id = Integer.parseInt(idParam);
//            StaffDAO sDAO = new StaffDAO();
//            Staff oneStaff = sDAO.getOneById(id);
//
//            if (oneStaff == null) {
//                response.sendRedirect("/WEB-INF/dashboard/staff-list.jsp");
//                return;
//            }
//
//            request.setAttribute("s", oneStaff);
//
//            request.getRequestDispatcher("/WEB-INF/dashboard/staff-delete.jsp").forward(request, response);

        } else if (view.equals("details")) {
//            try {
//                String idParam = request.getParameter("id");
//
//                int id = Integer.parseInt(idParam);
//                StaffDAO sDAO = new StaffDAO();
//                Staff oneStaff = sDAO.getOneById(id);
//
//                if (oneStaff == null) {
//                    response.sendRedirect("/WEB-INF/dashboard/staff-list.jsp");
//                    return;
//                }
//
//                request.setAttribute("s", oneStaff);
//                request.getRequestDispatcher("/WEB-INF/dashboard/details-staff.jsp").forward(request, response);
//
//            } catch (NumberFormatException e) {
//                System.err.println("Lỗi định dạng ID: " + e.getMessage());
//                response.sendRedirect("/WEB-INF/dashboard/staff-list.jsp");
//            } catch (Exception e) {
//                System.err.println("Lỗi không mong muốn: " + e.getMessage());
//                response.sendRedirect("/WEB-INF/dashboard/staff-list.jsp");
//            }
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
        String act = request.getParameter("action");

        if (act != null) {

            switch (act) {
                case "add":
                try ( PrintWriter out = response.getWriter()) {
                    String username = request.getParameter("username");
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));

                    CustomerDAO cDAO = new CustomerDAO();
                    int customerId = cDAO.GetIdByName(username);

                    // 2. Kiểm tra sản phẩm đã tồn tại trong giỏ chưa
                    CartDAO cartDAO = new CartDAO();
                    Cart existingCart = cartDAO.findCartItem(customerId, productId);

                    if (existingCart != null) {
                        // Nếu đã có -> Cập nhật số lượng
                        existingCart.setQuantity(existingCart.getQuantity() + quantity);
                        cartDAO.updateCart(existingCart);
                    } else {
                        // Nếu chưa có -> Thêm mới
                        Cart newCart = new Cart();
                        newCart.setCustomerId(customerId);
                        newCart.setProductId(productId);
                        newCart.setQuantity(quantity);
                        cartDAO.insertCart(newCart);
                    }

                    // 3. Chuyển hướng về trang sản phẩm hoặc giỏ hàng
                     response.sendRedirect(request.getContextPath() + "/cart");
                }

                break;

//                case "edit":
//     try ( PrintWriter out = response.getWriter()) {
//
//                    String idParam = request.getParameter("id");
//                    int id = Integer.parseInt(idParam);
//
//                    String username = request.getParameter("username");
//                    String email = request.getParameter("email");
//                    String password = request.getParameter("password");
//                    String phone = request.getParameter("phone");
//                    String role = request.getParameter("role");
//                    String dobStr = request.getParameter("date_of_birth");
//
//                    Date dateOfBirth = null;
//                    if (dobStr != null && !dobStr.isEmpty()) {
//                        dateOfBirth = Date.valueOf(dobStr);
//                    }
//
//                    // Lấy staff hiện tại để giữ avatar cũ nếu cần
//                    Staff oldStaff = sDAO.getOneById(id);
//
//                    Part img = request.getPart("avatar_url");
//                    String filename = Paths.get(img.getSubmittedFileName()).getFileName().toString();
//                    String avatarUrl;
//
//                    String realPath = request.getServletContext().getRealPath("/assets/img/avatar");
//                    File uploadDir = new File(realPath);
//                    if (!uploadDir.exists()) {
//                        uploadDir.mkdirs();
//                    }
//
//                    // Nếu có file mới, ghi đè và dùng tên mới
//                    if (filename != null && !filename.isEmpty()) {
//                        File fileToSave = new File(uploadDir, filename);
//                        img.write(fileToSave.getAbsolutePath());
//
//                        avatarUrl = "/CosmoraCelestica/assets/img/avatar/" + filename;
//                    } else {
//                        // Nếu không chọn ảnh mới, dùng lại avatar cũ
//                        avatarUrl = oldStaff.getAvatarUrl();
//                    }
//
//                    String hashedPassword = PasswordUtils.hashPassword(password);
//
//                    // Tạo object Staff
//                    Staff updatedStaff = new Staff(id, username, email, hashedPassword, phone, role, dateOfBirth, avatarUrl);
//
//                    int isUpdate = sDAO.update(updatedStaff);
//                    if (isUpdate == 1) {
//                        response.sendRedirect(request.getContextPath() + "/manage-staffs");
//                    } else {
//                        out.println("<h2>Error: Can't update staff in database.</h2>");
//                    }
//
//                } catch (Exception e) {
//                    response.getWriter().println("<h2>Upload failed!</h2>");
//                    e.printStackTrace(response.getWriter());
//                }
//                break;
//
//                case "delete":
//                    String idParam = request.getParameter("id");
//                    int id = Integer.parseInt(idParam);
//
//                    if (sDAO.delete(id) == 1) {
//                        response.sendRedirect(request.getContextPath() + "/manage-staffs");
//                    }
//                    break;
//
//                case "search":
//
//                    String keyWord = request.getParameter("keyWord");
//
//                    ArrayList<Staff> sList;
//                    try {
//                        sList = sDAO.searchByName(keyWord);
//                        request.setAttribute("s", sList);
//
//                        request.getRequestDispatcher("/WEB-INF/dashboard/staff-list.jsp").forward(request, response);
//                    } catch (SQLException ex) {
//                        Logger.getLogger(StaffServlet.class.getName()).log(Level.SEVERE, null, ex);
//                    }
//
//                    break;
//
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
