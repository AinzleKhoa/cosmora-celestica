<%-- 
    Document   : customer-list
    Created on : Jun 14, 2025, 12:30:33 PM
    Author     : Le Anh Khoa - CE190449
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>
	<main class="admin-main">

		<div class="table-header">
			<h2 class="table-title">Manage Customers</h2>
		</div>

		<section class="admin-header">
			<div class="admin-header-top">
				<div class="search-filter-wrapper" style="display: flex; margin-left: auto;">
					<input type="text" class="search-input" placeholder="Enter customer name...">
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
							<th>Fullname</th>
							<th>Username</th>
							<th>Email</th>
							<th>Status</th>
							<th style="text-align: center;">Action</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>Hayden</td>
							<td>Hayden</td>
							<td>work409@gmail.com</td>
							<td><span class="badge-status">Active</span></td>
							<td>
								<div class="table-actions-center">
									<a class="btn-action btn-details" href="./admin-customer-details.html">Details</a>
									<a class="btn-action btn-edit" href="./admin-customer-edit.html">Edit</a>
									<a class="btn-action btn-delete" href="./admin-customer-delete.html">Delete</a>
									<a class="btn-action btn-history" href="./admin-customer-orderhistory.html">Order
										History</a>
								</div>
							</td>
						</tr>
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
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>