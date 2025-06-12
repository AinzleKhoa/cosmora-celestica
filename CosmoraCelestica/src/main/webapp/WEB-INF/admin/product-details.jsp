<%-- 
    Document   : product-details
    Created on : 10 thg 6, 2025
    Author     : HoangSang
--%>
<%@page import="shop.model.ProductAttribute"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="shop.model.Product"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>



<%
    Product product = (Product) request.getAttribute("product");
    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(localeVN);
    SimpleDateFormat timestampFormatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/main.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/assets/icon/logo.png" sizes="32x32">
    
    <title>Product Details - <% if (product != null) { out.print(product.getName()); } else { out.print("Not Found"); } %></title>
</head>
<body>


    <main class="admin-main">
        <div class="table-header">
            <h2 class="table-title">Product Details</h2>
        </div>

        <div class="admin-manage-wrapper container py-4">
            <div class="mb-4">
                <a href="<%= request.getContextPath() %>/products?action=list" class="admin-manage-back mb-5">
                    <i class="fas fa-arrow-left mr-1"></i> Back to Product List
                </a>
            </div>

            <% if (product != null) { %>
                <div class="row g-4">
                    <div class="col-lg-4">
                        <img src="<%= request.getContextPath() %>/assets/img/<%= (product.getImageUrls() != null && !product.getImageUrls().isEmpty()) ? product.getImageUrls() : "assets/img/default-product.png" %>" 
                             alt="<%= product.getName() %>" class="img-fluid rounded shadow-sm">
                    </div>

                    <div class="col-lg-8">
                        <h3 class="admin-manage-subtitle"><%= product.getName() %></h3>
                        <p class="text-muted">ID: <%= product.getProductId() %></p>
                        
                        <h4 class="admin-manage-subtitle mt-4">General Information</h4>
                        <table class="table table-bordered mt-3">
                            <tbody>
                                <tr><th style="width: 30%;">Price</th><td><%= currencyFormatter.format(product.getPrice()) %></td></tr>
                                <tr>
                                    <th>Sale Price</th>
                                    <td>
                                        <% if (product.getSalePrice() != null && product.getSalePrice().compareTo(java.math.BigDecimal.ZERO) > 0) { %>
                                            <strong class="text-danger"><%= currencyFormatter.format(product.getSalePrice()) %></strong>
                                        <% } else { %>
                                            <span class="text-muted">N/A</span>
                                        <% } %>
                                    </td>
                                </tr>
                                <tr><th>Quantity in Stock</th><td><%= product.getQuantity() %></td></tr>

                                <tr><th>Category</th><td><%= product.getCategoryName() %></td></tr>
                                <tr><th>Brand</th><td><%= product.getBrandName() %></td></tr>
                                <tr><th>Date Created</th><td><%= product.getCreatedAt() != null ? timestampFormatter.format(product.getCreatedAt()) : "N/A" %></td></tr>
                                <tr><th>Last Updated</th><td><%= product.getUpdatedAt() != null ? timestampFormatter.format(product.getUpdatedAt()) : "N/A" %></td></tr>
                                <tr><th>Description</th><td style="white-space: pre-wrap;"><%= product.getDescription() %></td></tr>
                            </tbody>
                        </table>

                        <%-- 1. Nếu là GAME, hiển thị Game Details --%>
                        <% if ("Game".equalsIgnoreCase(product.getCategoryName()) && product.getGameDetails() != null) { %>
                            <h4 class="admin-manage-subtitle mt-4">Game Specifications</h4>
                            <table class="table table-bordered mt-3">
                                <tbody>
                                    <tr><th style="width: 30%;">Developer</th><td><%= product.getGameDetails().getDeveloper() %></td></tr>
                                    <tr><th>Genre</th><td><%= product.getGameDetails().getGenre() %></td></tr>
                                    <tr><th>Release Date</th><td><%= dateFormatter.format(product.getGameDetails().getReleaseDate()) %></td></tr>
                                </tbody>
                            </table>
                        <% } %>

                        <%-- 2. Nếu là PHỤ KIỆN (có attributes), hiển thị danh sách thuộc tính --%>
                        <% 
                           List<ProductAttribute> attributes = product.getAttributes();
                           if (attributes != null && !attributes.isEmpty()) {
                        %>
                            <h4 class="admin-manage-subtitle mt-4"><%= product.getCategoryName() %> Specifications</h4>
                            <table class="table table-bordered mt-3">
                                <tbody>
                                    <% for (ProductAttribute attr : attributes) { %>
                                        <tr>
                                            <th style="width: 30%; text-transform: capitalize;"><%= attr.getAttributeName().replace('_', ' ') %></th>
                                            <td><%= attr.getValue() %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } %>

                        <div class="mt-4">
                            <a href="<%= request.getContextPath() %>/products?action=update&id=<%= product.getProductId() %>" class="btn admin-manage-button" style="background-color: #ffc107; border-color: #ffc107;">
                                <i class="fas fa-edit mr-1"></i> Edit
                            </a>
                            <a href="<%= request.getContextPath() %>products?action=delete&id=<%= product.getProductId() %>" class="btn admin-manage-reset" onclick="return confirm('Are you sure you want to delete this product?');">
                                <i class="fas fa-trash mr-1"></i> Delete
                            </a>
                        </div>
                    </div>
                </div>
            <% } else { %>
                <div class="alert alert-warning text-center">
                    <h3>Product Not Found</h3>
                    <p>The product you are looking for does not exist or may have been deleted.</p>
                </div>
            <% } %>
        </div>
    </main>
</body>
</html>