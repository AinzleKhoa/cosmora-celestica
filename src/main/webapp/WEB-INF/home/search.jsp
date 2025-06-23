<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="shop.model.Product"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>

<%@include file="/WEB-INF/include/home-header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/product-list.css">

<section class="section section--bg section__ad--bg section--first" data-bg="<%= request.getContextPath()%>/assets/img/bg3.png">
    <div class="owl-carousel section__carousel--ad" id="carousel00">
        <a href="#" class="advertisement__card-link" target="_blank"><div class="advertisement__card card"><div class="advertisement__image-wrapper"><img src="<%= request.getContextPath()%>/assets/img/advertisement/ad1.png" alt="Advertisement 1" class="advertisement__image" /></div></div></a>
        <a href="#" class="advertisement__card-link" target="_blank"><div class="advertisement__card card"><div class="advertisement__image-wrapper"><img src="<%= request.getContextPath()%>/assets/img/advertisement/ad2.png" alt="Advertisement 2" class="advertisement__image" /></div></div></a>
    </div>
</section>

<section class="custom-section">
    <div class="container">

        <!-- Search Form -->
        <div class="row">
            <div class="col-12"> <form action="<%= request.getContextPath()%>/home" method="get">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" class="search-input" placeholder="Enter voucher name..." value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : ""%>">
                    <button class="search-btn">Search</button>                    
                </form></div>
            <div class="col-12 mt-3 text-center">
                <h2>Category:</h2>
                <button class="btn custom-category-btn" onclick="location.href = '<%= request.getContextPath()%>/home?action=filter&keyword=game'">Game</button>
                <button class="btn custom-category-btn" onclick="location.href = '<%= request.getContextPath()%>/home?action=filter&keyword=headset'">Headset</button>
                <button class="btn custom-category-btn" onclick="location.href = '<%= request.getContextPath()%>/home?action=filter&keyword=keyboard'">KeyBoard</button>
                <button class="btn custom-category-btn" onclick="location.href = '<%= request.getContextPath()%>/home?action=filter&keyword=mouse'">Mouse</button>
                <button class="btn custom-category-btn" onclick="location.href = '<%= request.getContextPath()%>/home?action=filter&keyword=controller'">Controller</button>
            </div>
        </div>

        <!-- Title -->
        <div class="row mt-5">
            <div class="col-12">
                <h2 class="section__title">All Products</h2>
            </div>
        </div>

        <!-- Product Grid -->
        <div class="row">
            <%
                List<Product> productList = (List<Product>) request.getAttribute("productList");
                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(Locale.US);
                if (productList != null && !productList.isEmpty()) {
                    for (Product product : productList) {
            %>
            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                <div class="card card--catalog card--uniform h-100">
                    <a href="<%= request.getContextPath()%>/home?action=details&productId=<%= product.getProductId()%>" class="card__cover">
                        <img src="<%= request.getContextPath()%>/assets/img/<%= (product.getImageUrls() != null && !product.getImageUrls().isEmpty() ? product.getImageUrls().get(0) : "default-product.png")%>" alt="<%= product.getName()%>" />
                        <span class="card__new">NEW</span>
                    </a>
                    <div class="card__title">
                        <h3 class="card__brand"><%= (product.getBrandName() != null && !product.getBrandName().isEmpty() ? product.getBrandName() : "N/A")%></h3>
                        <h3><a href="<%= request.getContextPath()%>/home?action=details&productId=<%= product.getProductId()%>"><%= product.getName()%></a></h3>
                        <span>
                            <% if (product.getSalePrice() != null && product.getSalePrice().compareTo(BigDecimal.ZERO) > 0) {%>
                            <%= currencyFormatter.format(product.getSalePrice())%> <s><%= currencyFormatter.format(product.getPrice())%></s>
                                <% } else {%>
                                <%= currencyFormatter.format(product.getPrice())%>
                                <% } %>
                        </span>
                    </div>
                    <div class="card__actions">
                        <button class="card__buy" type="button">Buy</button>
                        <button class="card__addtocart" type="button">Add to Cart</button>
                    </div>
                </div>
            </div>
            <% }
            } else { %>
            <div class="row mt-5">
                <div class="col-12 text-center">
                    <p>No products available.</p>
                </div>
            </div>
            <% }%>
        </div>
    </div>
</section>

<%@include file="/WEB-INF/include/home-footer.jsp" %>
