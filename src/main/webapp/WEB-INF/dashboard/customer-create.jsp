<%-- 
    Document   : customer-create
    Created on : Jun 15, 2025, 9:21:54 AM
    Author     : Le Anh Khoa - CE190449
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>
<main class="admin-main">

    <div class="table-header">
        <h2 class="table-title">Manage Customers</h2>
    </div>

    <c:choose>
        <c:when test="${empty requestScope.paginatedCustomerList}">
            <p class="sign__empty">The list is empty</p>
        </c:when>
        <c:otherwise>
            <section class="admin-header">
                <div class="admin-header-top">
                    <div class="search-filter-wrapper" style="display: flex; margin-left: auto;">
                        <input type="text" class="search-input" placeholder="Enter customer name...">
                        <button class="search-btn">Search</button>
                    </div>
                </div>
            </section>

            <section class="admin-table-wrapper">
                <div class="table-responsive shadow-sm rounded overflow-hidden">
                    <table class="table table-dark table-bordered table-hover align-middle mb-0">
                        <thead class="table-light text-dark">
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>Fullname</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Email Verified</th>
                                <th style="text-align: center;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="customer" items="${requestScope.paginatedCustomerList}">
                            <tr>
                                <td><img src="${customer.avatarUrl}" alt="Avatar" class="avatar-img"></td>
                                <td>${customer.customerId}</td>
                                <td>${customer.fullName}</td>
                                <td>${customer.username}</td>
                                <td>${customer.email}</td>
                                <td>                            
                                    <span class="badge-status ${customer.isDeactivated ? 'badge-suspend' : 'badge-active'}">
                                        ${customer.isDeactivated ? 'Suspended' : 'Active'}
                                    </span>
                                </td>
                                <td>                            
                                    <span class="badge-status ${customer.emailVerified ? 'badge-suspend' : 'badge-active'}">
                                        ${customer.emailVerified ? 'No' : 'Yes'}
                                    </span>
                                </td>
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
                        </c:forEach>
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
        </c:otherwise>
    </c:choose>
</main>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>
