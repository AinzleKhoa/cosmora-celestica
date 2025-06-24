<%--
    Document   : product-list
    Created on : Jun 10, 2025, 10:55:00 PM
    Author     : HoangSang
--%>

<%@page import="java.util.List"%>
<%@page import="shop.model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>

<%
    String contextPath = request.getContextPath();
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");
    int rowNumber = (Integer) request.getAttribute("startRowNumber");
    List<Product> productList = (List<Product>) request.getAttribute("productList");

    String pageUrl = (String) request.getAttribute("pageUrl");
    String previousPageUrl = (String) request.getAttribute("previousPageUrl");
    String nextPageUrl = (String) request.getAttribute("nextPageUrl");
%>
<link rel="stylesheet" href="<%= contextPath%>/assets/css/product-style.css">
<style>
    .pagination-container {
        display: flex;
        justify-content: center;
        margin-top: 1.5rem;
    }
    .pagination {
        padding-left: 0;
        list-style: none;
        border-radius: .25rem;
        display: flex;
    }
    .page-item .page-link {
        position: relative;
        display: block;
        padding: .5rem .75rem;
        margin-left: -1px;
        line-height: 1.25;
        color: #007bff;
        background-color: #fff;
        border: 1px solid #dee2e6;
    }
    .page-item.active .page-link {
        z-index: 1;
        color: #fff;
        background-color: #007bff;
        border-color: #007bff;
    }
    .page-item.disabled .page-link {
        color: #6c757d;
        pointer-events: none;
        cursor: auto;
        background-color: #fff;
        border-color: #dee2e6;
    }
    .page-item:first-child .page-link {
        margin-left: 0;
        border-top-left-radius: .25rem;
        border-bottom-left-radius: .25rem;
    }
    .page-item:last-child .page-link {
        border-top-right-radius: .25rem;
        border-bottom-right-radius: .25rem;
    }
</style>

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
                    <% if (productList != null && !productList.isEmpty()) {
                            for (Product p : productList) {
                    %>
                    <tr>
                        <td><%= rowNumber++%></td> 
                        <td>
                            <% if (p.getImageUrls() != null && !p.getImageUrls().isEmpty()) {%>
                            <img src="<%= contextPath%>/assets/img/<%= p.getImageUrls().get(0)%>" alt="<%= p.getName()%>" class="table-product-img">
                            <% } else { %>
                            <span>No Image</span>
                            <% }%>
                        </td>
                        <td><%= p.getName()%></td>
                        <td>$<%= p.getPrice()%></td>
                        <td>
                            <% if (p.getSalePrice() != null) {%>
                            $<%= p.getSalePrice()%>
                            <% } else { %>
                            N/A
                            <% }%>
                        </td>
                        <td><%= p.getCategoryName() != null ? p.getCategoryName() : "N/A"%></td>
                        <td>
                            <div class="table-actions-center">
                                <a class="btn-action btn-details" href="manage-products?action=details&id=<%= p.getProductId()%>">Details</a>
                                <a class="btn-action btn-edit" href="manage-products?action=update&id=<%= p.getProductId()%>">Edit</a>
                                <a class="btn-action btn-delete" href="manage-products?action=delete&id=<%= p.getProductId()%>">Delete</a>
                            </div>
                        </td>
                    </tr>
                    <%      }
                    } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center">No products found.</td>
                    </tr>
                    <%  } %>
                </tbody>
            </table>
        </div>

        <% if (totalPages > 1) {%>
        <div class="pagination-container">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item <%= (currentPage <= 1) ? "disabled" : ""%>">
                        <a class="page-link" href="<%= previousPageUrl%>" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <% for (int i = 1; i <= totalPages; i++) {%>
                    <li class="page-item <%= (i == currentPage) ? "active" : ""%>">
                        <a class="page-link" href="<%= pageUrl + i%>"><%= i%></a>
                    </li>
                    <% }%>

                    <li class="page-item <%= (currentPage >= totalPages) ? "disabled" : ""%>">
                        <a class="page-link" href="<%= nextPageUrl%>" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <% }%>
    </section>
</main>

<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>