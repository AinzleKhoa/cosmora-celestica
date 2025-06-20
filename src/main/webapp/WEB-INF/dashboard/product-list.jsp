<%--
    Document   : product-list
    Created on : Jun 10, 2025, 10:55:00 PM
    Author     : HoangSang
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="shop.model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>

<% String contextPath = request.getContextPath();%>
<link rel="stylesheet" href="<%= contextPath%>/assets/css/bootstrap-reboot.min.css">
<link rel="stylesheet" href="<%= contextPath%>/assets/css/bootstrap-grid.min.css">
<link rel="stylesheet" href="<%= contextPath%>/assets/css/owl.carousel.min.css">
<link rel="stylesheet" href="<%= contextPath%>/assets/css/magnific-popup.css">
<link rel="stylesheet" href="<%= contextPath%>/assets/css/nouislider.min.css">
<link rel="stylesheet" href="<%= contextPath%>/assets/css/jquery.mCustomScrollbar.min.css">
<link rel="stylesheet" href="<%= contextPath%>/assets/css/paymentfont.min.css">
<link rel="stylesheet" href="<%= contextPath%>/assets/css/main.css">
<link rel="stylesheet" href="<%= contextPath%>/assets/css/product-style.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">


<main class="admin-main">
    <div class="table-header">
        <h2 class="table-title">Manage Products</h2>
    </div>

    <section class="admin-header">
        <div class="admin-header-top">
            <a class="btn-admin-add" href="manage-products?action=add">+ Add New Product</a>
            <div class="search-filter-wrapper">
                <form action="manage-products" method="get" class="search-form">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="query" class="search-input" placeholder="Enter product name..." value="${param.query != null ? param.query : ''}">
                    <button type="submit" class="search-btn">Search</button>
                </form>
                <a href="manage-products?action=list" class="clear-search-btn">
                    <i class="fas fa-times"></i> Clear
                </a>
            </div>
        </div>              
    </section>

    <section class="admin-table-wrapper">
        <div class="table-responsive shadow-sm rounded overflow-hidden">
            <table class="table table-dark table-bordered table-hover align-middle mb-0">
                <thead class="table-light text-dark">
                    <tr>
                        <th>No.</th>
                        <th>Product Image</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Sale Price</th>
                        <th>Category</th>
                        <th style="text-align: center;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Product> productList = (List<Product>) request.getAttribute("productList");
                        int rowNumber = 1;
                        if (productList != null && !productList.isEmpty()) {

                            for (Product p : productList) {
                    %>
                    <tr>
                        <td><%= rowNumber++%></td> 
                        <td>
                            <% if (p.getImageUrls() != null && !p.getImageUrls().isEmpty()) { %>
                            <% String imageUrl = p.getImageUrls().get(0);%>
                            <img src="<%= contextPath%>/assets/img/<%= imageUrl%>" alt="<%= p.getName()%>" class="table-product-img">
                            <% } else { %>
                            <span>No Image</span>
                            <% }%>
                        </td>
                        <td><%= p.getName()%></td>
                        <td><%= p.getPrice()%></td>
                        <td>
                            <% if (p.getSalePrice() != null) {%>
                            <%= p.getSalePrice()%>
                            <% } else { %>
                            N/A
                            <% }%>
                        </td>
                        <td><%= p.getCategoryName() != null ? p.getCategoryName() : "N/A"%></td>
                        <td>
                            <div class="table-actions-center">
                                <a class="btn-action btn-details" href="manage-products?action=details&id=<%= p.getProductId()%>">Details</a>
                                <a class="btn-action btn-edit" href="manage-products?action=update&id=<%= p.getProductId()%>">Edit</a>
                                <a class="btn-action btn-delete" href="manage-products?action=delete&id=<%= p.getProductId()%>" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center">No products found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
      
    </section>

</main>

<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>