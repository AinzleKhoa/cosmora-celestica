<%--
    Document   : product-add
    Created on : Jun 12, 2025, 10:55:00 PM
    Author     : HoangSang
--%>

<%@page import="shop.model.Category"%>
<%@page import="shop.model.Brand"%>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>

<main class="main">
    <div class="table-header d-flex justify-content-between align-items-center">
        <h2 class="table-title">Create New Product</h2>
        <a href="<%= request.getContextPath()%>/manage-products?action=list" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-2"></i> Back</a>
    </div>

    <form action="<%= request.getContextPath()%>/manage-products?action=add" method="post" enctype="multipart/form-data">

        <input type="hidden" id="productType" name="productType" value="">

        <%-- NOTIFICATION MESSAGES --%>
        <%
            String successMessage = (String) request.getAttribute("successMessage");
            if (successMessage != null && !successMessage.isEmpty()) {%>
        <div class="alert alert-success" role="alert"><%= successMessage%></div>
        <% }
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {%>
        <div class="alert alert-danger" role="alert"><%= errorMessage%></div>
        <% }
        %>

        <div class="form-card">
            <h3 class="form-card__title">Product Type</h3>
            <label for="categoryId" class="form-label admin-manage-label">Select the type of product you are creating</label>
            <select class="form-select admin-manage-input" id="categoryId" name="categoryId" required onchange="handleProductTypeChange()">
                <option value="">-- Choose a Product Type --</option>
                <%
                    List<Category> categoriesList = (List<Category>) request.getAttribute("categoriesList");
                    if (categoriesList != null) {
                        for (Category cat : categoriesList) {
                            String normalizedName = cat.getName().toLowerCase().replaceAll("\\s+", "").replace("chuột", "mouse").replace("bànphím", "keyboard").replace("tainghe", "headphone").replace("taycầm(controller)", "controller").replace("game", "game");
                %>
                <option value="<%= cat.getCategoryId()%>" data-normalized-name="<%= normalizedName%>"><%= cat.getName()%></option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="form-card">
            <h3 class="form-card__title">General Information</h3>
            <div class="row g-4">
                <div class="col-md-12">
                    <label class="form-label admin-manage-label">Product Name</label>
                    <input type="text" class="form-control admin-manage-input" name="name" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label admin-manage-label">Price ($)</label>
                    <input type="number" step="0.01" class="form-control admin-manage-input" name="price" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label admin-manage-label">Quantity</label>
                    <input type="number" class="form-control admin-manage-input" name="quantity" required>
                </div>
                <div class="col-12">
                    <label class="form-label admin-manage-label">Description</label>
                    <textarea class="form-control admin-manage-input" name="description" rows="4"></textarea>
                </div>
            </div>
        </div>

        <div class="form-card">
            <h3 class="form-card__title">Product Images (Up to 6 images)</h3>
            <div class="row g-3">
                <% for (int i = 1; i <= 6; i++) {%>
                <div class="col-md-4 col-sm-6">
                    <label class="form-label admin-manage-label mb-2">Image <%= i%></label>
                    <label class="image-uploader" for="productImage<%= i%>" id="uploader<%= i%>">
                        <div class="image-uploader__content">
                            <i class="fas fa-cloud-upload-alt image-uploader__icon"></i>
                            <p>Click to upload</p>
                        </div>
                        <img src="" alt="Preview <%= i%>" id="preview<%= i%>" class="image-preview" style="display: none;">
                        <input type="file" class="form-control-file" id="productImage<%= i%>" name="productImages" accept="image/*">
                        <button type="button" class="remove-image-btn" id="removeBtn<%= i%>" style="display: none;">&times;</button>
                    </label>
                </div>
                <% }%>
            </div>
        </div>

        <div id="dynamicFieldsContainer">
            <div id="gameFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Game Details</h3>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Developer</label>
                            <input type="text" name="developer" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Genre</label>
                            <input type="text" name="genre" class="form-control admin-manage-input" placeholder="e.g., Action, RPG">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Release Date</label>
                            <input type="date" name="releaseDate" class="form-control admin-manage-input">
                        </div>
                    </div>
                </div>
                <div class="form-card">
                    <h3 class="form-card__title">Game Activation & System</h3>
                    <div class="row g-4"><div class="col-12">
                            <label class="form-label admin-manage-label">Store Platform</label>
                            <div class="checkbox-group">
                                <div>
                                    <input type="checkbox" id="platform_steam" name="platforms" value="Steam">
                                    <label for="platform_steam">Steam</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="platform_epic" name="platforms" value="Epic Games Store">
                                    <label for="platform_epic">Epic Games Store</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="platform_gog" name="platforms" value="GOG">
                                    <label for="platform_gog">GOG</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="platform_ubisoft" name="platforms" value="Ubisoft Connect">
                                    <label for="platform_ubisoft">Ubisoft Connect</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="platform_ea" name="platforms" value="EA App">
                                    <label for="platform_ea">EA App</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="platform_battle" name="platforms" value="Battle.net">
                                    <label for="platform_battle">Battle.net</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="platform_other" name="platforms" value="Other">
                                    <label for="platform_other">Other</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label admin-manage-label">Supported OS</label>
                            <div class="checkbox-group">
                                <div>
                                    <input type="checkbox" id="os_windows" name="operatingSystems" value="Windows">
                                    <label for="os_windows">Windows</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="os_macos" name="operatingSystems" value="macOS">
                                    <label for="os_macos">macOS</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="os_linux" name="operatingSystems" value="Linux">
                                    <label for="os_linux">Linux</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <label for="gameKeys" class="form-label admin-manage-label">Game Keys (one key per line)</label>
                            <textarea id="gameKeys" name="gameKeys" class="form-control admin-manage-input" rows="8"></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div id="accessoryFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Accessory Details</h3>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Warranty (months)</label>
                            <input type="number" name="warrantyMonths" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Weight (grams)</label>
                            <input type="number" step="0.01" name="weightGrams" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Connection Type</label>
                            <input type="text" name="connectionType" class="form-control admin-manage-input" placeholder="e.g., Wireless, USB-C">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Usage Time (hours)</label>
                            <input type="number" step="0.1" name="usageTimeHours" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label admin-manage-label">Brand</label>
                            <select class="form-select admin-manage-input" name="brandId">
                                <option value="">-- Select Brand --</option>
                                <%
                                    List<Brand> brands = (List<Brand>) request.getAttribute("brandsList");
                                    if (brands != null) {
                                        for (Brand brand : brands) {%><option value="<%= brand.getBrandId()%>"><%= brand.getBrandName()%></option><% }
                                            }
                                %>
                            </select>
                        </div>
                    </div>
                </div>

            </div>

            <div id="headphoneFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Headphone Specifics</h3>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Headphone Type</label>
                            <input type="text" name="headphoneType" class="form-control admin-manage-input" placeholder="e.g., Over-ear, In-ear">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Material</label>
                            <input type="text" name="headphoneMaterial" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Battery Capacity (mAh)</label>
                            <input type="number" name="headphoneBattery" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label admin-manage-label">Features</label>
                            <textarea name="headphoneFeatures" class="form-control admin-manage-input" placeholder="e.g., Noise Cancelling"></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div id="keyboardFields" style="display: none;">
                <div class="form-card"><h3 class="form-card__title">Keyboard Specifics</h3>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Size</label>
                            <input type="text" name="keyboardSize" class="form-control admin-manage-input" placeholder="e.g., Full-size, TKL">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Material</label>
                            <input type="text" name="keyboardMaterial" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Keyboard Type</label>
                            <input type="text" name="keyboardType" class="form-control admin-manage-input" placeholder="e.g., Mechanical, Membrane">
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
                            <input type="text" name="mouseType" class="form-control admin-manage-input" placeholder="e.g., Gaming, Ergonomic">
                        </div>
                    </div>
                </div>
            </div>

            <div id="controllerFields" style="display: none;">
                <div class="form-card">
                    <h3 class="form-card__title">Controller Specifics</h3>
                    <div class="row g-4"><div class="col-md-4">
                            <label class="form-label admin-manage-label">Material</label>
                            <input type="text" name="controllerMaterial" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Battery Capacity (mAh)</label>
                            <input type="number" name="controllerBattery" class="form-control admin-manage-input">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label admin-manage-label">Charging Time (hours)</label>
                            <input type="number" step="0.1" name="controllerChargingTime" class="form-control admin-manage-input">
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="d-flex justify-content-end align-items-center mt-4">
            <button type="reset" class="btn admin-manage-reset mr-3"><i class="fas fa-xmark mr-1"></i> Reset Form</button>
            <button type="submit" class="btn admin-manage-button"><i class="fas fa-plus mr-1"></i> Create Product</button>
        </div>
    </form>
</main>

<script src="<%= request.getContextPath()%>/assets/js/jquery-3.5.1.min.js"></script>
<script src="<%= request.getContextPath()%>/assets/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath()%>/assets/js/owl.carousel.min.js"></script>
<script src="<%= request.getContextPath()%>/assets/js/jquery.magnific-popup.min.js"></script>
<script src="<%= request.getContextPath()%>/assets/js/wNumb.js"></script>
<script src="<%= request.getContextPath()%>/assets/js/nouislider.min.js"></script>
<script src="<%= request.getContextPath()%>/assets/js/jquery.mousewheel.min.js"></script>
<script src="<%= request.getContextPath()%>/assets/js/jquery.mCustomScrollbar.min.js"></script>
<script src="<%= request.getContextPath()%>/assets/js/main.js"></script>

<script>
                function handleProductTypeChange() {
                    const productTypeSelect = document.getElementById('categoryId');
                    const selectedOption = productTypeSelect.options[productTypeSelect.selectedIndex];
                    const selectedType = selectedOption ? selectedOption.dataset.normalizedName : '';

                    document.getElementById('productType').value = selectedType;

                    const allFieldIds = ['gameFields', 'accessoryFields', 'headphoneFields', 'keyboardFields', 'mouseFields', 'controllerFields'];
                    allFieldIds.forEach(id => {
                        const element = document.getElementById(id);
                        if (element)
                            element.style.display = 'none';
                    });

                    if (!selectedType)
                        return;

                    const brandSelect = document.querySelector('select[name="brandId"]');

                    if (selectedType === 'game') {
                        document.getElementById('gameFields').style.display = 'block';

                        if (brandSelect) {
                            brandSelect.required = false;
                        }
                    } else {
                        const accessoryFields = document.getElementById('accessoryFields');
                        if (accessoryFields)
                            accessoryFields.style.display = 'block';

                        const specificFieldId = selectedType + 'Fields';
                        const specificFields = document.getElementById(specificFieldId);
                        if (specificFields) {
                            specificFields.style.display = 'block';
                        }

                        if (brandSelect) {
                            brandSelect.required = true;
                        }
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
                            }
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
                    for (let i = 1; i <= 6; i++) {
                        setupImageUploader(i);
                    }

                    handleProductTypeChange();
                });

                function toggleDropdown() {
                    document.getElementById("adminDropdown").classList.toggle("show");
                }
</script>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>
