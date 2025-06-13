<%-- 
    Document   : staff-list
    Created on : Jun 11, 2025, 11:52:31 PM
    Author     : VICTUS
--%>

<%@page import="java.util.List"%>
<%@page import="shop.model.Staff"%>
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
        <meta name="keywords" content="">
        <title>Cosmora Celestica ? Games and Accessories</title>

    </head>

    <body>
        <!-- header -->
        <header class="header">
            <div class="header__wrap">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="header__content">
                                <a href="${pageContext.servletContext.contextPath}/WEB-INF/view.jsp" class="header__logo">
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
        <button class="admin-sidebar-toggle" onclick="$('.admin-sidebar').toggleClass('open')">?
            Menu</button>

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
                <h2 class="table-title">Manage Staffs</h2>
            </div>

            <section class="admin-header">
                <div class="admin-header-top">
                    <a class="btn-admin-add" href="${pageContext.servletContext.contextPath}/staffmanagement?view=create">+ Add New Staff</a>
                    <div class="search-filter-wrapper">
                        <input type="text" class="search-input" placeholder="Enter staff name...">
                        <button class="search-btn">Search</button>
                    </div>
                </div>
                <div class="main-filter">
                    <span><i class="fas fa-filter fas-filter-icon"></i>Filter By:</span>
                    <select class="admin-filter-select">
                        <option value="ascending">A-Z</option>
                        <option value="descending">Z-A</option>
                    </select>
                    <select class="admin-filter-select">
                        <option value="all">All Dates</option>
                        <option value="last30">Last 30 Days</option>
                        <option value="lastYear">Last Year</option>
                    </select>
                    <select class="admin-filter-select">
                        <option value="all">All Statuses</option>
                        <option value="active">Active</option>
                        <option value="suspended">Suspended</option>
                    </select>
                </div>
            </section>

            <section class="admin-table-wrapper">
                <div class="table-responsive shadow-sm rounded overflow-hidden">
                    <table class="table table-dark table-bordered table-hover align-middle mb-0">
                        <thead class="table-light text-dark">
                            <tr>
                                <th>ID</th>
                                <th>Image Staff</th>
                                <th>Full Name</th>
                                
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th style="text-align: center;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Staff> staffs = (List<Staff>) request.getAttribute("s");
                                if (staffs == null || staffs.isEmpty()) {
                            %>
                            <tr>
                                <td colspan="8" class="text-center text-danger">No Staff Found</td>
                            </tr>
                            <%
                            } else {
                                for (Staff s : staffs) {
                            %>
                            <tr>
                                <td><%= s.getId()%></td>
                                <td><%= s.getAvatarUrl()%></td>
                                <td><img src="/assets/img/staff/<%= s.getAvatarUrl()%>" alt="Avatar" style="width: 50px; height: 50px; border-radius: 50%;"></td>
                               
                                <td><%= s.getEmail()%></td>
                                <td><%= s.getRole()%></td>
                                <td><span class="badge-status">Active</span></td>
                                <td>
                                    <div class="table-actions-center">
                                        <a class="btn-action btn-details" href="staff-details?id=<%= s.getId()%>">Details</a>
                                        <a class="btn-action btn-edit" href="staff-edit?id=<%= s.getId()%>">Edit</a>
                                        <a class="btn-action btn-delete" href="staff-delete?id=<%= s.getId()%>">Delete</a>
                                        <a class="btn-action btn-history" href="staff-activitylog?id=<%= s.getId()%>">Activity Log</a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>

            </section>

            <!-- Pagination -->
            <nav class="admin-pagination">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <a class="page-link" href="#">«</a>
                    </li>
                    <li class="page-item active">
                        <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">»</a>
                    </li>
                </ul>
            </nav>
        </main>

        <!-- JS -->
        <script src="js/jquery-3.5.1.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/wNumb.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.mousewheel.min.js"></script>
        <script src="js/jquery.mCustomScrollbar.min.js"></script>
        <script src="js/main.js"></script>
    </body>

</html>
