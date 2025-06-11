<%-- 
    Document   : product-edit
    Created on : Jun 10, 2025, 6:28:14 PM
    Author     : HoangSang
--%>

<%@page import="java.util.List"%>
<%@page import="shop.model.Product"%>
<%@page import="shop.model.Category"%>
<%@page import="shop.model.Brand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap-reboot.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/main.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <title>Edit Product - Cosmora Celestica</title>
</head>
<body>
    <%-- Lấy các đối tượng đã được servlet gửi qua --%>
    <%
        Product product = (Product) request.getAttribute("product");
        List<Category> categories = (List<Category>) request.getAttribute("categoriesList");
        List<Brand> brands = (List<Brand>) request.getAttribute("brandsList");
    %>

    <header class="header"> ... </header>
    <aside class="admin-sidebar"> ... </aside>

    <main class="admin-main">
        <div class="table-header">
            <h2 class="table-title">Edit Product</h2>
        </div>
        
        <% if (product != null) { %>
        <form class="admin-manage-wrapper container py-4" action="<%= request.getContextPath() %>/products?action=update" method="post" enctype="multipart/form-data">
            
            <input type="hidden" name="productId" value="<%= product.getProductId() %>">

            <div class="mb-4">
                <a href="<%= request.getContextPath() %>/products?action=list" class="admin-manage-back mb-5">
                    <i class="fas fa-arrow-left mr-1"></i> Back
                </a>
            </div>

            <fieldset class="mb-4 admin-manage-fieldset">
                <legend class="admin-manage-subtitle">General Information</legend>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Product Name</label>
                        <input type="text" class="form-control admin-manage-input" name="name" value="<%= product.getName() %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Price</label>
                        <input type="number" step="0.01" class="form-control admin-manage-input" name="price" value="<%= product.getPrice() %>" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label admin-manage-label">Description</label>
                        <textarea class="form-control admin-manage-input" name="description" rows="3"><%= product.getDescription() %></textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Quantity</label>
                        <input type="number" class="form-control admin-manage-input" name="quantity" value="<%= product.getQuantity() %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Change Product Image (optional)</label>
                        <input type="file" class="form-control admin-manage-input" name="productImageFile" accept="image/*">
                    </div>
                    <div class="col-md-6">
                         <label class="form-label admin-manage-label">Category</label>
                         <select class="form-select admin-manage-input" name="categoryId" required>
                             <option value="">-- Select Category --</option>
                                <%
                                    if (categories != null) {
                                        for (Category category : categories) {
                                            String selected = (product.getCategoryId() == category.getCategoryId()) ? "selected" : "";
                                %>
                                            <option value="<%= category.getCategoryId() %>" <%= selected %>><%= category.getName() %></option>
                                <%
                                        }
                                    }
                                %>
                         </select>
                     </div>
                     <div class="col-md-6">
                         <label class="form-label admin-manage-label">Brand</label>
                         <select class="form-select admin-manage-input" name="brandId" required>
                             <option value="">-- Select Brand --</option>
                                <%
                                    if (brands != null) {
                                        for (Brand brand : brands) {
                                            String selected = (product.getBrandId() == brand.getBrandId()) ? "selected" : "";
                                %>
                                            <option value="<%= brand.getBrandId() %>" <%= selected %>><%= brand.getBrandName()%></option>
                                <%
                                        }
                                    }
                                %>
                         </select>
                     </div>
                </div>
            </fieldset>

            <div class="d-flex justify-content-between align-items-center mt-4">
                <a href="<%= request.getContextPath() %>/products?action=list" class="admin-manage-back">
                    <i class="fas fa-arrow-left mr-1"></i> Cancel
                </a>
                <div>
                    <button type="submit" class="btn admin-manage-button">
                        <i class="fas fa-save mr-1"></i> Save Changes
                    </button>
                </div>
            </div>
        </form>
        <% } else { %>
            <div class="alert alert-danger">Product not found or an error occurred.</div>
        <% } %>
    </main>

    <script src="<%= request.getContextPath() %>/assets/js/jquery-3.5.1.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/main.js"></script>
</body>
</html>
