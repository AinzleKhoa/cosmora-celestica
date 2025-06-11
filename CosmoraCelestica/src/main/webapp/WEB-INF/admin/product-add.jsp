<%-- 
    Document   : product-add
    Created on : Jun 10, 2025, 5:22:08 PM
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

    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap-reboot.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/nouislider.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/paymentfont.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/main.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/assets/icon/logo.png" sizes="32x32">
    <link rel="apple-touch-icon" href="<%= request.getContextPath() %>/assets/icon/logo.png">

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
                                <img src="<%= request.getContextPath() %>/assets/img/logo.png" alt="">
                            </a>

                            <div class="admin-dropdown" onclick="toggleDropdown()">
                                <div class="admin-profile">
                                    <img src="<%= request.getContextPath() %>/assets/img/user.svg" alt="Avatar" class="admin-avatar">
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
                                        <li><a href="#">Dashboard</a></li>
                                        <li><a href="#">My Profile</a></li>
                                        <li><a href="#">Settings</a></li>
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
                <a href="<%= request.getContextPath() %>/products?action=list" class="admin-sidebar__link active">
                    <i class="fas fa-box"></i> Manage Products
                </a>
            </li>
            <li class="admin-sidebar__item">
                <a href="#" class="admin-sidebar__link">
                    <i class="fas fa-briefcase"></i> Manage Staffs
                </a>
            </li>
            <li class="admin-sidebar__item">
                <a href="#" class="admin-sidebar__link">
                    <i class="fas fa-users"></i> Manage Customers
                </a>
            </li>
            <li class="admin-sidebar__item">
                <a href="#" class="admin-sidebar__link">
                    <i class="fas fa-clipboard-list"></i> Manage Orders
                </a>
            </li>
            <li class="admin-sidebar__item">
                <a href="#" class="admin-sidebar__link">
                    <i class="fas fa-tag"></i> Manage Vouchers
                </a>
            </li>
            <li class="admin-sidebar__item">
                <a href="#" class="admin-sidebar__link">
                    <i class="fas fa-percent"></i> Manage Discounts
                </a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <div class="table-header">
            <h2 class="table-title">Create New Product</h2>
        </div>

        <form class="admin-manage-wrapper container py-4" action="<%= request.getContextPath() %>/products?action=add" method="post" enctype="multipart/form-data">
            <div class="mb-4">
                <a href="<%= request.getContextPath() %>/products?action=list" class="admin-manage-back">
                    <i class="fas fa-arrow-left mr-1"></i> Back
                </a>
            </div>
            
            <%-- HIỂN THỊ THÔNG BÁO --%>
            <%
                String successMessage = (String) request.getAttribute("successMessage");
                if (successMessage != null && !successMessage.isEmpty()) {
            %>
                <div class="alert alert-success" role="alert"><%= successMessage %></div>
            <%
                }
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
                <div class="alert alert-danger" role="alert"><%= errorMessage %></div>
            <%
                }
            %>

            <div class="mb-4">
                <label for="productType" class="form-label admin-manage-label">Product Type</label>
                <select class="form-select admin-manage-input" id="productType" name="productType" onchange="handleProductTypeChange()">
                    <option value="game">Game</option>
                    <option value="mouse">Mouse</option>
                    <option value="keyboard">Keyboard</option>
                    <option value="headphone">Headphone</option>
                    <option value="controller">Controller</option>
                </select>
            </div>

            <fieldset class="mb-4 admin-manage-fieldset">
                <legend class="admin-manage-subtitle">General Information</legend>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Product Name</label>
                        <input type="text" class="form-control admin-manage-input" name="name" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Price</label>
                        <input type="number" step="0.01" class="form-control admin-manage-input" name="price" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label admin-manage-label">Description</label>
                        <textarea class="form-control admin-manage-input" name="description" rows="3"></textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Quantity</label>
                        <input type="number" class="form-control admin-manage-input" name="quantity" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Product Image</label>
                        <input type="file" class="form-control admin-manage-input" name="productImageFile" accept="image/*">
                    </div>
                    <div class="col-md-6">
                         <label class="form-label admin-manage-label">Category</label>
                         <select class="form-select admin-manage-input" name="categoryId" required>
                             <option value="">-- Select Category --</option>
                                <%
                                    List<Category> categories = (List<Category>) request.getAttribute("categoriesList");
                                    if (categories != null) {
                                        for (Category category : categories) {
                                %>
                                            <option value="<%= category.getCategoryId() %>"><%= category.getName() %></option>
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
                                    List<Brand> brands = (List<Brand>) request.getAttribute("brandsList");
                                    if (brands != null) {
                                        for (Brand brand : brands) {
                                %>
                                            <option value="<%= brand.getBrandId() %>"><%= brand.getBrandName()%></option>
                                <%
                                        }
                                    }
                                %>
                         </select>
                     </div>
                </div>
            </fieldset>

            <div id="gameFields">
                <fieldset class="mb-4 admin-manage-fieldset">
                    <legend class="admin-manage-subtitle">Game Details</legend>
                    <div class="row g-3">
                        <div class="col-md-6"><label class="form-label admin-manage-label">Developer</label><input type="text" name="developer" class="form-control admin-manage-input"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Publisher</label><input type="text" name="publisher" class="form-control admin-manage-input"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Release Date</label><input type="date" name="releaseDate" class="form-control admin-manage-input"></div>
                    </div>
                </fieldset>
            </div>

            <div id="accessoryFields">
                 <fieldset class="mb-4 admin-manage-fieldset">
                    <legend class="admin-manage-subtitle">Accessory Details</legend>
                    <div class="row g-3">
                        <div class="col-md-6"><label class="form-label admin-manage-label">Warranty (months)</label><input type="number" name="warrantyMonths" class="form-control admin-manage-input"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Weight (grams)</label><input type="number" step="0.01" name="weightGrams" class="form-control admin-manage-input"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Connection Type</label><input type="text" name="connectionType" class="form-control admin-manage-input"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Usage Time (hours)</label><input type="number" step="0.1" name="usageTimeHours" class="form-control admin-manage-input"></div>
                    </div>
                 </fieldset>
            </div>
            
            <div id="headphoneFields">
                <fieldset class="mb-4 admin-manage-fieldset"><legend class="admin-manage-subtitle">Headphone Specifics</legend>
                    <div class="row g-3">
                        <div class="col-md-6"><label class="form-label admin-manage-label">Headphone Type</label><input type="text" name="headphoneType" class="form-control admin-manage-input"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Material</label><input type="text" name="headphoneMaterial" class="form-control admin-manage-input"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Battery Capacity (mAh)</label><input type="number" name="headphoneBattery" class="form-control admin-manage-input"></div>
                        <div class="col-md-6"><label class="form-label admin-manage-label">Features</label><textarea name="headphoneFeatures" class="form-control admin-manage-input"></textarea></div>
                    </div>
                </fieldset>
            </div>
            <div id="keyboardFields">
                <fieldset class="mb-4 admin-manage-fieldset"><legend class="admin-manage-subtitle">Keyboard Specifics</legend>
                    <div class="row g-3">
                        <div class="col-md-4"><label class="form-label admin-manage-label">Size</label><input type="text" name="keyboardSize" class="form-control admin-manage-input"></div>
                        <div class="col-md-4"><label class="form-label admin-manage-label">Material</label><input type="text" name="keyboardMaterial" class="form-control admin-manage-input"></div>
                        <div class="col-md-4"><label class="form-label admin-manage-label">Keyboard Type</label><input type="text" name="keyboardType" class="form-control admin-manage-input"></div>
                    </div>
                </fieldset>
            </div>
            <div id="mouseFields">
                 <fieldset class="mb-4 admin-manage-fieldset"><legend class="admin-manage-subtitle">Mouse Specifics</legend>
                     <div class="row g-3"><div class="col-12"><label class="form-label admin-manage-label">Mouse Type</label><input type="text" name="mouseType" class="form-control admin-manage-input"></div></div>
                 </fieldset>
            </div>
            <div id="controllerFields">
                <fieldset class="mb-4 admin-manage-fieldset"><legend class="admin-manage-subtitle">Controller Specifics</legend>
                    <div class="row g-3">
                        <div class="col-md-4"><label class="form-label admin-manage-label">Material</label><input type="text" name="controllerMaterial" class="form-control admin-manage-input"></div>
                        <div class="col-md-4"><label class="form-label admin-manage-label">Battery Capacity (mAh)</label><input type="number" name="controllerBattery" class="form-control admin-manage-input"></div>
                        <div class="col-md-4"><label class="form-label admin-manage-label">Charging Time (hours)</label><input type="number" step="0.1" name="controllerChargingTime" class="form-control admin-manage-input"></div>
                    </div>
                </fieldset>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-4">
                <a href="<%= request.getContextPath() %>/products?action=list" class="admin-manage-back">
                    <i class="fas fa-arrow-left mr-1"></i> Back
                </a>
                <div>
                    <button type="reset" class="btn admin-manage-reset mr-2">
                        <i class="fas fa-xmark mr-1"></i> Reset
                    </button>
                    <button type="submit" class="btn admin-manage-button">
                        <i class="fas fa-plus mr-1"></i> Create Product
                    </button>
                </div>
            </div>
        </form>
    </main>

    <script src="<%= request.getContextPath() %>/assets/js/jquery-3.5.1.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/owl.carousel.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/jquery.magnific-popup.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/wNumb.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/nouislider.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/jquery.mousewheel.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/jquery.mCustomScrollbar.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/main.js"></script>
    
    <script>
        function handleProductTypeChange() {
            const productType = document.getElementById('productType').value;
            const allFieldIds = ['gameFields', 'accessoryFields', 'headphoneFields', 'keyboardFields', 'mouseFields', 'controllerFields'];

            allFieldIds.forEach(id => {
                document.getElementById(id).style.display = 'none';
            });

            if (productType === 'game') {
                document.getElementById('gameFields').style.display = 'block';
            } else if (['headphone', 'keyboard', 'mouse', 'controller'].includes(productType)) {
                document.getElementById('accessoryFields').style.display = 'block';
                if (productType === 'headphone') {
                    document.getElementById('headphoneFields').style.display = 'block';
                } else if (productType === 'keyboard') {
                    document.getElementById('keyboardFields').style.display = 'block';
                } else if (productType === 'mouse') {
                    document.getElementById('mouseFields').style.display = 'block';
                } else if (productType === 'controller') {
                    document.getElementById('controllerFields').style.display = 'block';
                }
            }
        }

        window.onload = handleProductTypeChange;
    </script>
</body>

</html>