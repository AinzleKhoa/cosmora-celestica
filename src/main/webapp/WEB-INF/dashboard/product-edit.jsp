<%--
    Document   : product-edit.jsp
    Created on : Jun 10, 2025 ,10:55:00 PM
    Author     : HoangSang
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.model.Product"%>
<%@page import="shop.model.Category"%>
<%@page import="shop.model.Brand"%>
<%@page import="shop.model.GameDetails"%>
<%@page import="shop.model.GameKey"%>
<%@page import="shop.model.StorePlatform"%>
<%@page import="shop.model.OperatingSystem"%>
<%@page import="shop.model.ProductAttribute"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/bootstrap-grid.min.css">
<link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/product-style.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<%
    Product product = (Product) request.getAttribute("product");
    List<Category> categories = (List<Category>) request.getAttribute("categoriesList");
    List<Brand> brands = (List<Brand>) request.getAttribute("brandsList");
    Map<String, String> attributeMap = (Map<String, String>) request.getAttribute("attributeMap");

    GameDetails gameDetails = (GameDetails) request.getAttribute("gameDetails");
    List<GameKey> gameKeys = (List<GameKey>) request.getAttribute("gameKeys");
    List<StorePlatform> allPlatforms = (List<StorePlatform>) request.getAttribute("allPlatforms");
    List<OperatingSystem> allOS = (List<OperatingSystem>) request.getAttribute("allOS");
    Set<Integer> selectedPlatformIds = (Set<Integer>) request.getAttribute("selectedPlatformIds");
    Set<Integer> selectedOsIds = (Set<Integer>) request.getAttribute("selectedOsIds");
%>

<main class="main main_2 container my-5">
    <div class="table-header d-flex justify-content-between align-items-center">
        <h2 class="table-title">Edit Product: <%= (product != null) ? product.getName() : ""%></h2>
        <a href="<%= request.getContextPath()%>/manage-products?action=list" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-2"></i> Back</a>
    </div>

    <c:if test="${not empty requestScope.errorMessage}">
        <div class="alert alert-danger" role="alert">${requestScope.errorMessage}</div>
    </c:if>

    <% if (product != null) {%>
    <form action="<%= request.getContextPath()%>/manage-products?action=update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="<%= product.getProductId()%>">
        <input type="hidden" name="gameDetailsId" value="<%= (gameDetails != null && gameDetails.getGameDetailsId() > 0) ? gameDetails.getGameDetailsId() : ""%>">
        <input type="hidden" id="productType" name="productType" value="">

        <div class="form-card">
            <h3 class="form-card__title">General Information</h3>
            <div class="row g-4">
                <div class="col-md-12"><label class="form-label admin-manage-label">Product Name</label><input type="text" class="form-control admin-manage-input" name="name" value="<%= product.getName()%>" required></div>
                <div class="col-md-6"><label class="form-label admin-manage-label">Price (VND)</label><input type="number"  class="form-control admin-manage-input" name="price" value="<%= product.getPrice()%>" required></div>
                <div class="col-md-6"><label class="form-label admin-manage-label">Quantity</label><input type="number" class="form-control admin-manage-input" name="quantity" value="<%= product.getQuantity()%>" required></div>
                <div class="col-12"><label class="form-label admin-manage-label">Description</label><textarea class="form-control admin-manage-input" name="description" rows="4"><%= product.getDescription()%></textarea></div>
            </div>
        </div>

        <div class="form-card">
            <h3 class="form-card__title">Product Images (Upload to replace existing images)</h3>
            <div class="row g-3">
                <%
                    List<String> imageUrls = product.getImageUrls();
                    if (imageUrls == null) {
                        imageUrls = new ArrayList<>();
                    }
                    for (int i = 0; i < 6; i++) {
                        String existingImageUrl = (i < imageUrls.size()) ? imageUrls.get(i) : null;
                %>
                <div class="col-md-4 col-sm-6">
                    <label class="form-label admin-manage-label mb-2">Image <%= i + 1%></label>
                    <label class="image-uploader" for="productImage<%= i%>" id="uploader<%= i%>">
                        <div class="image-uploader__content" style="<%= (existingImageUrl != null) ? "display: none;" : "display: flex;"%>">
                            <i class="fas fa-cloud-upload-alt image-uploader__icon"></i>
                            <p>Click to upload</p>
                        </div>
                        <img src="<%= (existingImageUrl != null) ? request.getContextPath() + "/assets/img/" + existingImageUrl : ""%>"
                             alt="Preview <%= i + 1%>"
                             id="preview<%= i%>"
                             class="image-preview"
                             style="<%= (existingImageUrl != null) ? "display: block;" : "display: none;"%>">
                        <input type="file" class="form-control-file" id="productImage<%= i%>" name="productImages" accept="image/*">
                        <button type="button" class="remove-image-btn" id="removeBtn<%= i%>" style="<%= (existingImageUrl != null) ? "display: flex;" : "display: none;"%>">&times;</button>
                    </label>
                </div>
                <% } %>
            </div>
        </div>

        <div id="dynamicFieldsContainer">
            <div class="form-card">
                <h3 class="form-card__title">Category & Brand</h3>
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Product Type / Category</label>
                        <select class="form-select admin-manage-input" id="categoryId" name="categoryId" required onchange="handleProductTypeChange()">
                            <option value="">-- Choose a Product Type --</option>
                            <% if (categories != null) {
                                    for (Category cat : categories) {
                                        String normalizedName = cat.getName().toLowerCase().replaceAll("\\s+", "");
                                        boolean isSelected = product.getCategoryId() == cat.getCategoryId();
                            %>
                            <option value="<%= cat.getCategoryId()%>" data-normalized-name="<%= normalizedName%>" <%= isSelected ? "selected" : ""%>><%= cat.getName()%></option>
                            <% }
                                } %>
                        </select>
                    </div>
                    <div class="col-md-6" id="brandFieldContainer">
                        <label class="form-label admin-manage-label">Brand</label>
                        <select class="form-select admin-manage-input" name="brandId">
                            <option value="">-- Select Brand --</option>
                            <% if (brands != null) {
                                    for (Brand brand : brands) {
                                        Integer productBrandId = product.getBrandId();
                                        boolean isSelected = productBrandId != null && productBrandId.equals(brand.getBrandId());
                            %>
                            <option value="<%= brand.getBrandId()%>" <%= isSelected ? "selected" : ""%>><%= brand.getBrandName()%></option>
                            <% }
                                }%>
                        </select>
                    </div>
                </div>
            </div>

            <div id="gameFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Game Details</h3>
                    <div class="row g-4">
                        <div class="col-md-6"><label class="form-label admin-manage-label">Developer</label><input type="text" name="developer" class="form-control admin-manage-input" value="<%= (gameDetails != null && gameDetails.getDeveloper() != null) ? gameDetails.getDeveloper() : ""%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Genre</label><input type="text" name="genre" class="form-control admin-manage-input" value="<%= (gameDetails != null && gameDetails.getGenre() != null) ? gameDetails.getGenre() : ""%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Release Date</label><input type="date" name="releaseDate" class="form-control admin-manage-input" value="<%= (gameDetails != null && gameDetails.getReleaseDate() != null) ? gameDetails.getReleaseDate() : ""%>"></div>
                    </div>
                </div>

                <div class="form-card">
                    <h3 class="form-card__title">Platforms & System Requirements</h3>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Store Platforms (Cửa hàng)</label>
                            <div class="checkbox-grid">
                                <% if (allPlatforms != null && !allPlatforms.isEmpty()) {
                                        for (StorePlatform platform : allPlatforms) {
                                            boolean isChecked = selectedPlatformIds != null && selectedPlatformIds.contains(platform.getPlatformId());
                                %>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="platformIds" value="<%= platform.getPlatformId()%>" id="platform_<%= platform.getPlatformId()%>" <%= isChecked ? "checked" : ""%>>
                                    <label class="form-check-label" for="platform_<%= platform.getPlatformId()%>"><%= platform.getStoreOSName()%></label>
                                </div>
                                <% }
                                    } else { %>
                                <p class="text-muted">No platforms available in database.</p>
                                <% } %>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Operating Systems (Hệ điều hành)</label>
                            <div class="checkbox-grid">
                                <% if (allOS != null && !allOS.isEmpty()) {
                                        for (OperatingSystem os : allOS) {
                                            boolean isChecked = selectedOsIds != null && selectedOsIds.contains(os.getOsId());
                                %>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="osIds" value="<%= os.getOsId()%>" id="os_<%= os.getOsId()%>" <%= isChecked ? "checked" : ""%>>
                                    <label class="form-check-label" for="os_<%= os.getOsId()%>"><%= os.getOsName()%></label>
                                </div>
                                <% }
                                    } else { %>
                                <p class="text-muted">No OS available in database.</p>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-card">
                    <h3 class="form-card__title">Game Keys</h3>
                    <div class="p-3">
                        <label class="form-label admin-manage-label">Existing Keys (<%= (gameKeys != null ? gameKeys.size() : 0) %>)</label>
                        <% if (gameKeys != null && !gameKeys.isEmpty()) { %>
                        <ul class="game-key-list">
                            <% for (GameKey key : gameKeys) {%>
                            <li><%= key.getKeyCode()%></li>
                            <% } %>
                        </ul>
                        <% } else { %>
                        <p class="text-muted">No keys found for this game.</p>
                        <% }%>
                        
                        <div class="mt-3">
                            <label class="form-label admin-manage-label">Add New Keys (one per line)</label>
                            <textarea class="form-control admin-manage-input" name="newGameKeys" rows="5" placeholder="Enter new keys here, one key per line..."></textarea>
                        </div>
                    </div>
                    </div>
            </div>

            <div id="accessoryFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Accessory Details</h3>
                    <div class="row g-4">
                        <div class="col-md-6"><label class="form-label admin-manage-label">Warranty (months)</label><input type="number" name="warrantyMonths" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Warranty", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Weight (grams)</label><input type="number" step="0.01" name="weightGrams" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Weight", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Connection Type</label><input type="text" name="connectionType" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Connection Type", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Usage Time (hours)</label><input type="number" step="0.1" name="usageTimeHours" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Usage Time", "")%>"></div>
                    </div>
                </div>
            </div>

            <div id="headphoneFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Headphone Specifics</h3>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Headphone Type</label>
                            <input type="text" name="headphoneType" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Headphone Type", "")%>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Material</label>
                            <input type="text" name="headphoneMaterial" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Material", "")%>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Battery Capacity (mAh)</label>
                            <input type="number" name="headphoneBattery" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Battery Capacity", "")%>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Features</label>
                            <textarea name="headphoneFeatures" class="form-control admin-manage-input"><%= attributeMap.getOrDefault("Features", "")%></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div id="keyboardFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Keyboard Specifics</h3>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Size</label>
                            <input type="text" name="keyboardSize" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Size", "")%>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Material</label>
                            <input type="text" name="keyboardMaterial" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Material", "")%>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Keyboard Type</label>
                            <input type="text" name="keyboardType" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Keyboard Type", "")%>">
                        </div>
                    </div>
                </div>
            </div>

            <div id="mouseFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Mouse Specifics</h3>
                    <div class="row g-4">
                        <div class="col-12">
                            <label class="form-label admin-manage-label">Mouse Type</label>
                            <input type="text" name="mouseType" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Mouse Type", "")%>">
                        </div>
                    </div>
                </div>
            </div>

            <div id="controllerFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Controller Specifics</h3>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Material</label>
                            <input type="text" name="controllerMaterial" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Material", "")%>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Battery Capacity (mAh)</label>
                            <input type="number" name="controllerBattery" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Battery Capacity", "")%>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Charging Time (hours)</label>
                            <input type="number" step="0.1" name="controllerChargingTime" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Charging Time", "")%>">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-end align-items-center mt-4">
            <button type="submit" class="btn admin-manage-button">
                <i class="fas fa-save mr-1"></i> Save Changes
            </button>
        </div>
    </form>
    <% } else {%>
    <div class="alert alert-danger">Product not found or an error occurred.</div>
    <% }%>
</main>

<script src="<%= request.getContextPath()%>/assets/js/products/edit-product.js"></script>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>