<%-- 
    Document   : dashboar-order-list
    Created on : Jun 11, 2025, 1:27:27 PM
    Author     : ADMIN
--%>

<%@page import="shop.dao.OrderDAO"%>
<%@page import="shop.model.Customer"%>
<%@page import="shop.model.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>

<main class="admin-main">

    <div class="table-header">
        <h2 class="table-title">Manage Orders</h2>
    </div>

    <section class="admin-header">
        <div class="admin-header-top">
            <form action="<%= request.getContextPath()%>/manage-orders" method="POST" style="display: flex; margin-left: auto;" class="search-filter-wrapper">
                <input type="hidden" name="action" value="search" />
                <input type="text" name="customer_name" class="search-input" placeholder="Enter customer name...">
                <button type="submit" class="search-btn">Search</button>
            </form>
        </div>
   
    </section>



    <section class="admin-table-wrapper">
        <div class="table-responsive shadow-sm rounded overflow-hidden">
            <table class="table table-dark table-bordered table-hover align-middle mb-0">
                <thead class="table-light text-dark">
                    <tr>
                        <th>ID</th>
                        <th>Customer Name</th>
                        <th>Order Date</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th style="text-align: center;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ArrayList<Order> orderlist = (ArrayList) request.getAttribute("orderlist");
                        for (Order order : orderlist) {


                    %>
                    <tr>
                        <td><%= order.getOrderId()%></td>
                        <td><%= order.getCustomerName()%></td>
                        <td><%= order.getOrderDate() %></td>
                        <td><%= order.getTotalAmount()%></td>
                        <td>
                            <form action="manage-orders" method="post">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="orderId" value="<%= order.getOrderId()%>" />
                                <select name="status" class="admin-filter-select" onchange="this.form.submit()">
                                    <option value="Pending" <%= order.getStatus().equals("Pending") ? "selected" : ""%>>Pending</option>
                                    <option value="Confirmed" <%= order.getStatus().equals("Confirmed") ? "selected" : ""%>>Confirmed</option>
                                    <option value="Shipped" <%= order.getStatus().equals("Shipped") ? "selected" : ""%>>Shipped</option>
                                    <option value="Delivered" <%= order.getStatus().equals("Delivered") ? "selected" : ""%>>Delivered</option>
                                </select>
                            </form>



                        </td>
                        <td>
                            <div class="table-actions-center">
                                <button class="btn-action btn-details"
                                        onclick="location.href = '<%= request.getContextPath()%>/manage-orders?view=details&customer_id=<%= order.getCustomerId()%>&order_id=<%= order.getOrderId()%>'">
                                    Details
                                </button>
                                <button class="btn-action btn-history">Customer Details</button>
                            </div>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </section>

    <!-- Pagination -->
    <nav class="admin-pagination">
        <ul class="pagination">
            <li class="page-item disabled">
                <a class="page-link" href="#">«</a>
            </li>
            <li class="page-item active">
                <a class="page-link" href="#">1</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">2</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">3</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">»</a>
            </li>
        </ul>
    </nav>
</main>

<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>