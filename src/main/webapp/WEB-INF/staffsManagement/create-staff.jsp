<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- CSS -->
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-reboot.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-grid.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/nouislider.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/paymentfont.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/main.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <!-- Favicons -->
        <link rel="icon" type="image/png" href="${pageContext.servletContext.contextPath}/assets/icon/logo.png" sizes="32x32">
        <link rel="apple-touch-icon" href="${pageContext.servletContext.contextPath}/assets/icon/logo.png">

        <meta name="description" content="Cosmora Celestica - Selling games and gaming accessories website">
        <title>Cosmora Celestica - Games and Accessories</title>
    </head>

    <body>
        <!-- header -->
        <header class="header">
            <div class="header__wrap">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="header__content">
                                <a href="${pageContext.servletContext.contextPath}/index.jsp" class="header__logo">
                                    <img src="${pageContext.servletContext.contextPath}/assets/img/logo.png" alt="">
                                </a>

                                <div class="admin-dropdown" onclick="toggleDropdown()">
                                    <div class="admin-profile">
                                        <img src="${pageContext.servletContext.contextPath}/assets/img/user.svg" alt="Avatar" class="admin-avatar">
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
        <!-- end header -->

        <button class="admin-sidebar-toggle" onclick="$('.admin-sidebar').toggleClass('open')">? Menu</button>

        <aside class="admin-sidebar">
            <div class="admin-sidebar__logo">Dashboard</div>
            <ul class="admin-sidebar__nav">
                <li class="admin-sidebar__item">
                    <a href="admin-products.html" class="admin-sidebar__link">
                        <i class="fas fa-box"></i> Manage Products
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-staff.html" class="admin-sidebar__link active">
                        <i class="fas fa-briefcase"></i> Manage Staffs
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-customer.html" class="admin-sidebar__link">
                        <i class="fas fa-users"></i> Manage Customers
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-order.html" class="admin-sidebar__link">
                        <i class="fas fa-clipboard-list"></i> Manage Orders
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-voucher.html" class="admin-sidebar__link">
                        <i class="fas fa-tag"></i> Manage Vouchers
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-discount.html" class="admin-sidebar__link">
                        <i class="fas fa-percent"></i> Manage Discounts
                    </a>
                </li>
            </ul>
        </aside>

        <main class="admin-main">
            <div class="table-header">
                <h2 class="table-title">Create New Staff</h2>
            </div>

            <div class="admin-manage-wrapper container py-4">
            


                <!-- General Information -->
                
                <form action="${pageContext.servletContext.contextPath}/staffsmanagement" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="create" />
                    <fieldset class="mb-4 admin-manage-fieldset">
                        <legend class="admin-manage-subtitle">Staff Information</legend>
                    

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Full Name</label>
                                <input type="text" class="form-control admin-manage-input" name="username" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Email</label>
                                <input type="email" class="form-control admin-manage-input" name="email" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Password</label>
                                <input type="password" class="form-control admin-manage-input" name="password" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Phone</label>
                                <input type="text" class="form-control admin-manage-input" name="phone">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Role</label>
                                <input type="text" class="form-control admin-manage-input" name="role" value="Staff" readonly required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Avatar Image</label>
                                <input type="file" class="form-control admin-manage-input" name="avatar_url" accept=".png">
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Date of Birth</label>
                                <input type="date" class="form-control admin-manage-input" name="date_of_birth">
                            </div>
                        </div>
                    </fieldset>

                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <a href="${pageContext.servletContext.contextPath}/staffsmanagement?view=list" class="admin-manage-back">
                            <i class="fas fa-arrow-left mr-1"></i> Back
                        </a>

                        <div>
                            <button type="reset" class="btn admin-manage-reset mr-2">
                                <i class="fas fa-xmark mr-1"></i> Reset
                            </button>
                            <button type="submit" class="btn admin-manage-button">
                                <i class="fas fa-plus mr-1"></i> Create
                            </button>

                        </div>
                    </div>
                </form>
            </div>
        </main>

        <!-- JS -->
        <script src="${pageContext.servletContext.contextPath}/assets/js/jquery-3.5.1.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/owl.carousel.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/jquery.magnific-popup.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/wNumb.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/nouislider.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/jquery.mousewheel.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/jquery.mCustomScrollbar.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/main.js"></script>
    </body>

</html>
