<%@page import="shop.model.Product"%>
<%@page import="shop.model.OrderDetail"%>
<%@page import="shop.dao.OrderDashboardDAO"%>
<%@page import="shop.model.Customer"%>
<%@page import="shop.model.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Order Detail - Cosmora Celestica</title>

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
        <button class="admin-sidebar-toggle" onclick="$('.admin-sidebar').toggleClass('open')">☰ Menu</button>

        <aside class="admin-sidebar">
            <div class="admin-sidebar__logo">Dashboard</div>
            <ul class="admin-sidebar__nav">
                <li class="admin-sidebar__item">
                    <a href="admin-products.html" class="admin-sidebar__link">
                        <i class="fas fa-box"></i> Manage Products
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-staff.html" class="admin-sidebar__link">
                        <i class="fas fa-briefcase"></i> Manage Staffs
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-customer.html" class="admin-sidebar__link">
                        <i class="fas fa-users"></i> Manage Customers
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-order.html" class="admin-sidebar__link active">
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
                <h2 class="table-title">Order Detail</h2>
            </div>

            <%
                Customer customer = (Customer) request.getAttribute("customer");
                Order order = (Order) request.getAttribute("order");
            %>

            <section class="admin-table-wrapper">
                <div class="table-responsive shadow-sm rounded overflow-hidden">
                    <table class="table table-dark table-bordered table-hover align-middle mb-0">
                        <thead class="table-light text-dark">
                            <tr>
                                <th>ID</th>
                                <th>Customer Name</th>
                                <th>Email</th>
                                <th>Order Date</th>
                                <th>Total Amount</th>
                                <th>Status</th>
                                <th>Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><%= request.getParameter("order_id") %></td>
                                <td><%= customer.getFullName() %></td>
                                <td><%= customer.getEmail() %></td>
                                <td><%= order.getOrderDate() %></td>
                                <td><%= order.getTotalAmount() %></td>
                                <td><span class="badge-status"><%= order.getStatus() %></span></td>
                                <td><span class="badge-staff"><%= order.getShippingAddress() %></span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <div class="table-header">
                <h2 class="table-title">Product in order</h2>
            </div>

            <section class="admin-table-wrapper">
                <div class="table-responsive shadow-sm rounded overflow-hidden">
                    <table class="table table-dark table-bordered table-hover align-middle mb-0">
                        <thead class="table-light text-dark">
                            <tr>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                ArrayList<OrderDetail> orderDetails = (ArrayList) request.getAttribute("orderdetail");
                Product product = new Product();
                OrderDashboardDAO OD = new OrderDashboardDAO();
                for (OrderDetail orderdetail : orderDetails) {
                        
                    product = OD.getProductInOrder(orderdetail.getProductId());
                            %>
                            <tr>
                                <td><%= orderdetail.getOrderId() %></td>
                                <td><%= product.getName() %></td>
                                <td><%= orderdetail.getQuantity() %></td>
                                <td><%= orderdetail.getPrice() %></td>
                            </tr>
                            <%  } %>
                        </tbody>
                    </table>
                </div>
            </section>
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