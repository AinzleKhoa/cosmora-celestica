<%--
    Document   : product-add
    Created on : Jun 12, 2025, 10:55:00 PM
    Author     : HoangSang
--%>

<%@page import="shop.model.Category"%>
<%@page import="shop.model.Brand"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/bootstrap-reboot.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/bootstrap-grid.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/magnific-popup.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/nouislider.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/paymentfont.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/main.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <link rel="icon" type="image/png" href="<%= request.getContextPath()%>/assets/icon/logo.png" sizes="32x32">
        <link rel="apple-touch-icon" href="<%= request.getContextPath()%>/assets/icon/logo.png">

        <meta name="description" content="Cosmora Celestica - Selling games and gaming accessories website">
        <meta name="keywords" content="">
        <title>Create New Product - Cosmora Celestica</title>

    </head>

    <body>
        <header class="header">
            <div class="header__wrap">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="header__content">
                                <a href="index.html" class="header__logo">
                                    <img src="<%= request.getContextPath()%>/assets/img/logo.png" alt=""></a>
                                <div class="admin-dropdown" onclick="toggleDropdown()">
                                    <div class="admin-profile">
                                        <img src="<%= request.getContextPath()%>/assets/img/user.svg" alt="Avatar" class="admin-avatar">
                                        <div>
                                            <p class="admin-name">Jiue Anderson</p>
                                            <span class="admin-role">Manager</span>
                                        </div>
                                    </div>
                                    <div class="admin-menu" id="adminDropdown">
                                        <div class="admin-user">
                                            <span class="admin-role">Manager</span>
                                            <p class="admin-name">Jiue Anderson</p>
                                        </div>
                                        <ul class="admin-links">
                                            <li>
                                                <a href="#">Dashboard</a>
                                            </li>
                                            <li>
                                                <a href="#">My Profile</a>
                                            </li>
                                            <li>
                                                <a href="#">Settings</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <button class="admin-sidebar-toggle" onclick="$('.admin-sidebar').toggleClass('open')">☰ Menu</button>
        <aside class="admin-sidebar">
            <div class="admin-sidebar__logo">Dashboard</div>
            <ul class="admin-sidebar__nav">
                <li class="admin-sidebar__item">
                    <a href="<%= request.getContextPath()%>/products?action=list" class="admin-sidebar__link active">
                        <i class="fas fa-box"></i> Manage Products</a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="#" class="admin-sidebar__link">
                        <i class="fas fa-briefcase"></i> Manage Staffs</a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="#" class="admin-sidebar__link">
                        <i class="fas fa-users"></i> Manage Customers</a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="#" class="admin-sidebar__link">
                        <i class="fas fa-clipboard-list"></i> Manage Orders</a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="#" class="admin-sidebar__link">
                        <i class="fas fa-tag"></i> Manage Vouchers</a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="#" class="admin-sidebar__link">
                        <i class="fas fa-percent"></i> Manage Discounts</a>
                </li>
            </ul>
        </aside>

        <main class="admin-main">
            <div class="table-header d-flex justify-content-between align-items-center">
                <h2 class="table-title">Create New Product</h2>
                <a href="<%= request.getContextPath()%>/products?action=list" class="admin-manage-back">
                    <i class="fas fa-arrow-left mr-1"></i> Back to Product List</a>
            </div>

            <form action="<%= request.getContextPath()%>/products?action=add" method="post" enctype="multipart/form-data">
                
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
            // ==================================================================
            // SỬA LỖI 2: Cập nhật Javascript để gán giá trị cho trường ẩn
            // ==================================================================
            function handleProductTypeChange() {
                const productTypeSelect = document.getElementById('categoryId');
                const selectedOption = productTypeSelect.options[productTypeSelect.selectedIndex];
                const selectedType = selectedOption ? selectedOption.dataset.normalizedName : '';
                
                // Cập nhật giá trị của trường ẩn
                document.getElementById('productType').value = selectedType;

                const allFieldIds = ['gameFields', 'accessoryFields', 'headphoneFields', 'keyboardFields', 'mouseFields', 'controllerFields'];
                allFieldIds.forEach(id => {
                    const element = document.getElementById(id);
                    if (element)
                        element.style.display = 'none';
                });
                
                if (!selectedType) return;

                const brandSelect = document.querySelector('select[name="brandId"]');

                if (selectedType === 'game') {
                    document.getElementById('gameFields').style.display = 'block';
                    // Game không cần Brand, nên bỏ yêu cầu bắt buộc
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
                    // Phụ kiện cần Brand, đặt là bắt buộc
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
                // Gọi hàm khi tải trang để đảm bảo trạng thái form đúng
                handleProductTypeChange();
            });

            function toggleDropdown() {
                document.getElementById("adminDropdown").classList.toggle("show");
            }
        </script>
    </body>
</html>