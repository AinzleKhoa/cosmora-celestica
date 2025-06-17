<%-- 
    Document   : product-details
    Created on : Jun 17, 2025, 11:10:00 PM
    Author     : HoangSang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="shop.model.Product, shop.model.GameDetails, shop.model.ProductAttribute, java.util.List, java.text.NumberFormat, java.util.Locale, java.math.BigDecimal, java.text.SimpleDateFormat" %>

<%@include file="/WEB-INF/include/home-header.jsp" %>

<link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/product-list.css">
<%
    Product product = (Product) request.getAttribute("product");
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(Locale.US);
%>

<style>
    
</style>

<section class="section details-section">
    <div class="container">
        <% if (product != null) { %>
        <div class="row">
            <div class="col-lg-6 product-gallery">
                <%
                    List<String> imageUrls = product.getImageUrls();
                    if (imageUrls != null && !imageUrls.isEmpty()) {
                %>
                <div class="main-image-container mb-3">
                    <img src="<%= request.getContextPath()%>/assets/img/<%= imageUrls.get(0)%>" alt="<%= product.getName()%>" id="mainProductImage">
                </div>

                <% if (imageUrls.size() > 1) { %>
                <div class="thumbnail-scroller">
                    <div class="thumbnail-container" id="thumbnailContainer">
                        <% for (int i = 0; i < imageUrls.size(); i++) {%>
                        <img src="<%= request.getContextPath()%>/assets/img/<%= imageUrls.get(i)%>"
                             class="thumb <%= (i == 0) ? "active" : ""%>"
                             onclick="changeMainImage(this)">
                        <% } %>
                    </div>
                    <button class="scroll-arrow left" onclick="scrollGallery(-1)"><i class="fas fa-chevron-left"></i></button>
                    <button class="scroll-arrow right" onclick="scrollGallery(1)"><i class="fas fa-chevron-right"></i></button>
                </div>
                <% } %>
                <% } else {%>
                <div class="main-image-container mb-3">
                    <img src="<%= request.getContextPath()%>/assets/img/default-product.png" alt="No Image" id="mainProductImage">
                </div>
                <% }%>
            </div>

            <div class="col-lg-6 product-info mt-4 mt-lg-0">
                <div class="product-brand"><%= (product.getBrandName() != null ? product.getBrandName() : "N/A")%></div>
                <h1 class="product-title"><%= product.getName()%></h1>
                <div class="product-price">
                    <% if (product.getSalePrice() != null && product.getSalePrice().compareTo(BigDecimal.ZERO) > 0) {%>
                    <%= currencyFormatter.format(product.getSalePrice())%> <span class="old-price"><s><%= currencyFormatter.format(product.getPrice())%></s></span>
                            <% } else {%>
                            <%= currencyFormatter.format(product.getPrice())%>
                            <% }%>
                </div>

                <form action="cart" method="POST" class="mt-4">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="<%= product.getProductId()%>">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn btn-cart">Add to Cart</button>
                    <button type="button" class="btn btn-buy ms-2">Buy Now</button>
                </form>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <div class="info-section">
                    <h3 class="info-section-title">Specifications</h3>
                    <dl class="row">
                        <dt class="col-sm-3">Category</dt><dd class="col-sm-9"><%= product.getCategoryName()%></dd>
                        <dt class="col-sm-3">In Stock</dt><dd class="col-sm-9"><%= product.getQuantity()%></dd>           
                        <% if (product.getGameDetails() != null) {
                                GameDetails details = product.getGameDetails();%>
                        <dt class="col-sm-3">Developer</dt><dd class="col-sm-9"><%= details.getDeveloper()%></dd>
                        <dt class="col-sm-3">Genre</dt><dd class="col-sm-9"><%= details.getGenre()%></dd>
                        <dt class="col-sm-3">Release Date</dt><dd class="col-sm-9"><%= new SimpleDateFormat("dd MMM, yyyy").format(details.getReleaseDate())%></dd>
                        <% } %>
                        <% if (product.getAttributes() != null && !product.getAttributes().isEmpty()) {%>
                        <dt class="col-sm-3">Brand</dt><dd class="col-sm-9"><%= product.getBrandName()%></dd>
                        <% for (ProductAttribute attr : product.getAttributes()) {%>
                        <dt class="col-sm-3"><%= attr.getAttributeName()%></dt><dd class="col-sm-9"><%= attr.getValue()%></dd>
                            <% }
                                }%>
                    </dl>
                </div>

                <div class="info-section">
                    <h3 class="info-section-title">Description</h3>
                    <p><%= product.getDescription()%></p>
                </div>
            </div>
        </div>

        <% } else {%>
        <div class="text-center py-5">
            <h1>Product Not Found</h1>
            <p class="lead">The product you are looking for does not exist or has been removed.</p>
            <a href="<%= request.getContextPath()%>/home" class="btn btn-primary">Back to Homepage</a>
        </div>
        <% }%>
    </div>
</section>
<script src="<%= request.getContextPath()%>/assets/js/products/details-product.js"></script>

<%@include file="/WEB-INF/include/home-footer.jsp" %>