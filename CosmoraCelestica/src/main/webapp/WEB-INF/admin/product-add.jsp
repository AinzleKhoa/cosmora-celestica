<%--
    Document   : product-edit
    Created on : Jun 12, 2025
    Author     : HoangSang
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.model.Product"%>
<%@page import="shop.model.Category"%>
<%@page import="shop.model.Brand"%>
<%@page import="shop.model.GameDetails"%>
<%@page import="shop.model.ProductAttribute"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/bootstrap-reboot.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/bootstrap-grid.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/main.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <title>Edit Product - Cosmora Celestica</title>
    </head>
    <body>
        <%
            Product product = (Product) request.getAttribute("product");
            List<Category> categories = (List<Category>) request.getAttribute("categoriesList");
            List<Brand> brands = (List<Brand>) request.getAttribute("brandsList");
            List<String> imageUrls = (product != null && product.getImageUrls() != null) ? product.getImageUrls() : new ArrayList<>();
        %>

        <main class="admin-main">
            <div class="table-header d-flex justify-content-between align-items-center">
                 <h2 class="table-title">Edit Product: <%= (product != null) ? product.getName() : ""%></h2>
                <a href="<%= request.getContextPath()%>/products?action=list" class="admin-manage-back">
                    <i class="fas fa-arrow-left mr-1"></i> Back to Product List</a>
            </div>

            <% if (product != null) {%>
            <form action="<%= request.getContextPath()%>/products?action=update" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productId" value="<%= product.getProductId()%>">
                <input type="hidden" id="productType" name="productType" value="">

                <%-- Thông tin chung --%>
                <div class="form-card">
                    <h3 class="form-card__title">General Information</h3>
                    <div class="row g-4">
                        <div class="col-12"><label class="form-label admin-manage-label">Product Name</label><input type="text" class="form-control admin-manage-input" name="name" value="<%= product.getName()%>" required></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Price ($)</label><input type="number" step="0.01" class="form-control admin-manage-input" name="price" value="<%= product.getPrice()%>" required></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Sale Price ($)</label><input type="number" step="0.01" class="form-control admin-manage-input" name="salePrice" value="<%= product.getSalePrice() != null ? product.getSalePrice() : "" %>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Quantity</label><input type="number" class="form-control admin-manage-input" name="quantity" value="<%= product.getQuantity()%>" required></div>
                         <div class="col-12"><label class="form-label admin-manage-label">Description</label><textarea class="form-control admin-manage-input" name="description" rows="4"><%= product.getDescription()%></textarea></div>
                    </div>
                </div>

                <%-- Hình ảnh sản phẩm --%>
                <div class="form-card">
                    <h3 class="form-card__title">Product Images</h3>
                    <p class="form-card__text">Để thay thế ảnh, hãy nhấn vào và chọn tệp mới. Để xóa ảnh, nhấn vào nút (×).</p>
                    <div class="row g-3">
                        <% for (int i = 0; i < 6; i++) {
                                String existingImageUrl = (i < imageUrls.size()) ? imageUrls.get(i) : "";
                        %>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label admin-manage-label mb-2">Image Slot <%= i + 1 %></label>
                            <label class="image-uploader" for="newImageFile_<%= i %>" id="uploader_<%= i %>">
                                <div class="image-uploader__content" style="<%= !existingImageUrl.isEmpty() ? "display: none;" : "display: block;" %>"><i class="fas fa-cloud-upload-alt image-uploader__icon"></i><p>Click to upload</p></div>
                                <img src="<%= !existingImageUrl.isEmpty() ? request.getContextPath() + "/" + existingImageUrl : "" %>" alt="Preview <%= i + 1 %>" id="preview_<%= i %>" class="image-preview" style="<%= !existingImageUrl.isEmpty() ? "display: block;" : "display: none;" %>">
                                <input type="hidden" name="existingImageUrls" id="existingImageUrl_<%= i %>" value="<%= existingImageUrl %>">
                                <input type="file" class="form-control-file" name="newImageFiles" id="newImageFile_<%= i %>" accept="image/*" onchange="handleFileSelect(<%= i %>)">
                                <button type="button" class="remove-image-btn" id="removeBtn_<%= i %>" style="<%= !existingImageUrl.isEmpty() ? "display: flex;" : "display: none;" %>" onclick="handleRemoveImage(event, <%= i %>)">&times;</button>
                            </label>
                        </div>
                        <% } %>
                    </div>
                </div>

                <%-- Các trường thông tin chi tiết (sẽ được JS hiển thị) --%>
                <%-- ... bạn có thể dán các khối div#gameFields, div#accessoryFields, ... vào đây ... --%>
                
                <div class="d-flex justify-content-end align-items-center mt-4">
                    <button type="submit" class="btn admin-manage-button"><i class="fas fa-save mr-1"></i> Save Changes</button>
                </div>
            </form>
            <% } else { %>
                <div class="alert alert-danger">Product not found.</div>
            <% } %>
        </main>
        
        <script>
            function handleFileSelect(index) {
                const input = document.getElementById('newImageFile_' + index);
                const hiddenInput = document.getElementById('existingImageUrl_' + index);
                const preview = document.getElementById('preview_' + index);
                const uploaderContent = document.getElementById('uploader_' + index).querySelector('.image-uploader__content');
                const removeBtn = document.getElementById('removeBtn_' + index);
                if (input.files && input.files[0]) {
                    hiddenInput.value = ''; // Báo hiệu ảnh cũ đã bị thay thế
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                        uploaderContent.style.display = 'none';
                        removeBtn.style.display = 'flex';
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }

            function handleRemoveImage(event, index) {
                event.preventDefault();
                event.stopPropagation();
                document.getElementById('newImageFile_' + index).value = ''; 
                document.getElementById('existingImageUrl_' + index).value = ''; // Báo hiệu ảnh cũ đã bị xóa
                document.getElementById('preview_' + index).src = '';
                document.getElementById('preview_' + index).style.display = 'none';
                document.getElementById('removeBtn_' + index).style.display = 'none';
                document.getElementById('uploader_' + index).querySelector('.image-uploader__content').style.display = 'block';
            }
        </script>
    </body>
</html>