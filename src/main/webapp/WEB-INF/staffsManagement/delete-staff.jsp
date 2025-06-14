<%-- 
    Document   : delete-staff
    Created on : Jun 14, 2025, 5:54:24 PM
    Author     : VICTUS
--%>

<%@page import="shop.model.Staff"%>
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
	<link rel="icon" type="image/png" href="icon/logo.png" sizes="32x32">
	<link rel="apple-touch-icon" href="icon/logo.png">

	<meta name="description" content="Cosmora Celestica - Selling games and gaming accessories website">
	<meta name="keywords" content="">
	<title>Cosmora Celestica – Games and Accessories</title>

</head>

<body>
	<!-- header -->
	<header class="header">
		<div class="header__wrap">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="header__content">
							<a href="index.html" class="header__logo">
								<img src="img/logo.png" alt="">
							</a>

							<div class="admin-dropdown" onclick="toggleDropdown()">
								<div class="admin-profile">
									<img src="img/user.svg" alt="Avatar" class="admin-avatar">
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
	<button class="admin-sidebar-toggle" onclick="$('.admin-sidebar').toggleClass('open')">☰
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
			<h2 class="table-title">Delete Staff</h2>
		</div>

		<div class="admin-manage-wrapper container py-4">
			<div class="mb-4">
				<a href="./admin-staff.html" class="admin-manage-back mb-5">
					<i class="fas fa-arrow-left mr-1"></i> Back
				</a>
			</div>

			<!-- Summary -->
                       <%
                      Staff s = (Staff) request.getAttribute("s");
                       
                       %>
			<div class="admin-manage-fieldset mb-4">
				<p class="mb-2"><strong>Full Name:</strong><%=s.getUserName()  %></p>
				
				<p class="mb-2"><strong>Email:</strong> <%=s.getEmail()  %></p>
				<p class="mb-2"><strong>Role:</strong> <%=s.getRole()  %></p>
				<br>
				<p class="mb-2 text-warning"><i class="fas fa-triangle-exclamation mr-1"></i> This action cannot be
					undone.</p>
			</div>

			<!-- Delete Buttons -->
			<div class="d-flex justify-content-between align-items-center mt-4">
				<!-- Back Link -->
				<a href="${pageContext.servletContext.contextPath}/staffsmanagement?view=list" class="admin-manage-back">
					<i class="fas fa-arrow-left mr-1"></i> Back
				</a>

				<!-- Action Buttons -->
                                <form action="${pageContext.servletContext.contextPath}/staffsmanagement" method="POST">
                                     <input type="hidden" name="action" value="delete" />
                                     <input type="hidden" name="id" value="<%=s.getId() %>" />
                                    
                                    <div>
				
					<button type="submit" class="btn admin-manage-button-delete">
						<i class="fas fa-trash mr-1"></i> Delete
					</button>
				</div>
                                    
                                </form>
			</div>

		</div>
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
