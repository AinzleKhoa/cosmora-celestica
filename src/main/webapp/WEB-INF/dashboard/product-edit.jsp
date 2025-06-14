<%--
    Document   : product-edit
    Created on : Jun 12, 2025, 10:55:00 PM
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
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>
<%
    Product product = (Product) request.getAttribute("product");
    List<Category> categories = (List<Category>) request.getAttribute("categoriesList");
    List<Brand> brands = (List<Brand>) request.getAttribute("brandsList");

    Map<String, String> attributeMap = new HashMap<>();
    if (product != null && product.getAttributes() != null) {
        for (ProductAttribute attr : product.getAttributes()) {
            attributeMap.put(attr.getAttributeName(), attr.getValue());
        }
    }

    List<String> imageUrls = new ArrayList<>();

    if (product != null && product.getImageUrls() != null) {
        imageUrls = product.getImageUrls();
    }
    GameDetails gameDetails = (product != null && product.getGameDetails() != null) ? product.getGameDetails() : new GameDetails();
%>



<main class="main">
    <div class="table-header d-flex justify-content-between align-items-center">
        <h2 class="table-title">Edit Product: <%= (product != null) ? product.getName() : ""%></h2>
        <a href="<%= request.getContextPath()%>/manage-products?action=list" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-2"></i> Back</a>
    </div>

    <% if (product != null) {%>
    <form action="<%= request.getContextPath()%>/manage-products?action=update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="<%= product.getProductId()%>">
        <input type="hidden" id="productType" name="productType" value="">

        <%-- Thông tin chung --%>
        <div class="form-card">
            <h3 class="form-card__title">General Information</h3>
            <div class="row g-4">
                <div class="col-md-12"><label class="form-label admin-manage-label">Product Name</label><input type="text" class="form-control admin-manage-input" name="name" value="<%= product.getName()%>" required></div>
                <div class="col-md-6"><label class="form-label admin-manage-label">Price ($)</label><input type="number" step="0.01" class="form-control admin-manage-input" name="price" value="<%= product.getPrice()%>" required></div>
                <div class="col-md-6"><label class="form-label admin-manage-label">Quantity</label><input type="number" class="form-control admin-manage-input" name="quantity" value="<%= product.getQuantity()%>" required></div>
                <div class="col-12"><label class="form-label admin-manage-label">Description</label><textarea class="form-control admin-manage-input" name="description" rows="4"><%= product.getDescription()%></textarea></div>
            </div>
        </div>

        <div class="form-card">
            <h3 class="form-card__title">Product Images (Upload to replace existing images)</h3>
            <div class="row g-3">
                <% for (int i = 1; i <= 6; i++) {
                        String existingImageUrl = (i - 1 < imageUrls.size()) ? imageUrls.get(i - 1) : null;
                %>
                <div class="col-md-4 col-sm-6">
                    <label class="form-label admin-manage-label mb-2">Image <%= i%></label>
                    <label class="image-uploader" for="productImage<%= i%>" id="uploader<%= i%>">
                        <div class="image-uploader__content" style="<%= (existingImageUrl != null) ? "display: none;" : "display: block;"%>">
                            <i class="fas fa-cloud-upload-alt image-uploader__icon"></i><p>Click to upload</p>
                        </div>
                        <img src="<%= (existingImageUrl != null) ? request.getContextPath() + "/" + existingImageUrl : ""%>" alt="Preview <%= i%>" id="preview<%= i%>" class="image-preview" style="<%= (existingImageUrl != null) ? "display: block;" : "display: none;"%>">
                        <input type="file" class="form-control-file" id="productImage<%= i%>" name="productImages" accept="image/*">
                        <button type="button" class="remove-image-btn" id="removeBtn<%= i%>" style="<%= (existingImageUrl != null) ? "display: flex;" : "display: none;"%>">&times;</button>
                    </label>
                </div>
                <% }%>
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
                                        }%>
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
                <div class="form-card"><h3 class="form-card__title">Game Details</h3>
                    <div class="row g-4">
                        <div class="col-md-6"><label class="form-label admin-manage-label">Developer</label><input type="text" name="developer" class="form-control admin-manage-input" value="<%= gameDetails.getDeveloper() != null ? gameDetails.getDeveloper() : ""%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Genre</label><input type="text" name="genre" class="form-control admin-manage-input" value="<%= gameDetails.getGenre() != null ? gameDetails.getGenre() : ""%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Release Date</label><input type="date" name="releaseDate" class="form-control admin-manage-input" value="<%= gameDetails.getReleaseDate() != null ? gameDetails.getReleaseDate() : ""%>"></div>
                    </div>
                </div>
            </div>

            <div id="accessoryFields" style="display: none;">
                <div class="form-card"><h3 class="form-card__title">Accessory Details</h3>
                    <div class="row g-4">
                        <div class="col-md-6"><label class="form-label admin-manage-label">Warranty (months)</label><input type="number" name="warrantyMonths" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Warranty", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Weight (grams)</label><input type="number" step="0.01" name="weightGrams" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Weight", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Connection Type</label><input type="text" name="connectionType" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Connection Type", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Usage Time (hours)</label><input type="number" step="0.1" name="usageTimeHours" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Usage Time", "")%>"></div>
                    </div>
                </div>
            </div>

            <div id="headphoneFields" style="display: none;">
                <div class="form-card"><h3 class="form-card__title">Headphone Specifics</h3>
                    <div class="row g-4">
                        <div class="col-md-6"><label class="form-label admin-manage-label">Headphone Type</label><input type="text" name="headphoneType" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Headphone Type", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Material</label><input type="text" name="headphoneMaterial" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Material", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Battery Capacity (mAh)</label><input type="number" name="headphoneBattery" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Battery Capacity", "")%>"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Features</label><textarea name="headphoneFeatures" class="form-control admin-manage-input"><%= attributeMap.getOrDefault("Features", "")%></textarea></div>
                    </div>
                </div>
            </div>

            <div id="keyboardFields" style="display: none;">
                <div class="form-card"><h3 class="form-card__title">Keyboard Specifics</h3>
                    <div class="row g-4">
                        <div class="col-md-4"><label class="form-label admin-manage-label">Size</label><input type="text" name="keyboardSize" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Size", "")%>"></div>
                        <div class="col-md-4"><label class="form-label admin-manage-label">Material</label><input type="text" name="keyboardMaterial" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Material", "")%>"></div>
                        <div class="col-md-4"><label class="form-label admin-manage-label">Keyboard Type</label><input type="text" name="keyboardType" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Keyboard Type", "")%>"></div>
                    </div>
                </div>
            </div>

            <div id="mouseFields" style="display: none;">
                <div class="form-card"><h3 class="form-card__title">Mouse Specifics</h3>
                    <div class="row g-4">
                        <div class="col-12"><label class="form-label admin-manage-label">Mouse Type</label><input type="text" name="mouseType" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Mouse Type", "")%>"></div>
                    </div>
                </div>
            </div>

            <div id="controllerFields" style="display: none;">
                <div class="form-card"><h3 class="form-card__title">Controller Specifics</h3>
                    <div class="row g-4">
                        <div class="col-md-4"><label class="form-label admin-manage-label">Material</label><input type="text" name="controllerMaterial" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Material", "")%>"></div>
                        <div class="col-md-4"><label class="form-label admin-manage-label">Battery Capacity (mAh)</label><input type="number" name="controllerBattery" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Battery Capacity", "")%>"></div>
                        <div class="col-md-4"><label class="form-label admin-manage-label">Charging Time (hours)</label><input type="number" step="0.1" name="controllerChargingTime" class="form-control admin-manage-input" value="<%= attributeMap.getOrDefault("Charging Time", "")%>"></div>
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

<script>
    function handleProductTypeChange() {
        const select = document.getElementById('categoryId');
        const selectedOption = select.options[select.selectedIndex];
        const type = selectedOption ? selectedOption.dataset.normalizedName : '';

        document.getElementById('productType').value = type;

        ['gameFields', 'accessoryFields', 'headphoneFields', 'keyboardFields', 'mouseFields', 'controllerFields'].forEach(id => {
            document.getElementById(id).style.display = 'none';
        });

        const brandContainer = document.getElementById('brandFieldContainer');

        if (type === 'game') {
            document.getElementById('gameFields').style.display = 'block';
            brandContainer.style.display = 'block';
        } else if (type) {
            document.getElementById('accessoryFields').style.display = 'block';
            brandContainer.style.display = 'block';

            const specificFields = document.getElementById(type + 'Fields');
            if (specificFields) {
                specificFields.style.display = 'block';
            }
        } else {
            brandContainer.style.display = 'block';
        }
    }

    function setupImageUploader(index) {
        const input = document.getElementById('productImage' + index);
        const uploader = document.getElementById('uploader' + index);
        if (!input || !uploader)
            return;

        const preview = document.getElementById('preview' + index);
        const removeBtn = document.getElementById('removeBtn' + index);
        const uploaderContent = uploader.querySelector('.image-uploader__content');

        input.addEventListener('change', function (event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    removeBtn.style.display = 'flex';
                    uploaderContent.style.display = 'none';
                };
                reader.readAsDataURL(file);
            }
        });

        removeBtn.addEventListener('click', function (event) {
            event.preventDefault();
            event.stopPropagation();
            input.value = '';
            preview.src = '';
            preview.style.display = 'none';
            removeBtn.style.display = 'none';
            uploaderContent.style.display = 'block';
        });
    }

    document.addEventListener('DOMContentLoaded', function () {

        handleProductTypeChange();

        for (let i = 1; i <= 6; i++) {
            setupImageUploader(i);
        }
    });
</script>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>