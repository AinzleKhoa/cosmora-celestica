<%-- 
    Document   : customer-order-history
    Created on : Jun 16, 2025, 10:49:47 AM
    Author     : CE190449 - Le Anh Khoa
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>
<c:set var="thisCustomer" value="${requestScope.thisCustomer}"/>
<main class="admin-main">
    <div class="table-header">
        <h2 class="table-title">Customer Order History</h2>
    </div>

    <div class="admin-manage-wrapper container py-4">
        <div class="mb-4">
            <a href="${pageContext.servletContext.contextPath}/manage-customers" class="admin-manage-back mb-5">
                <i class="fas fa-arrow-left mr-1"></i> Back
            </a>
        </div>
        <c:choose>
            <c:when test="${empty thisCustomer}">
                <p class="sign__empty">This Id does not exists.</p>
            </c:when>
            <c:otherwise>
                <!-- General Information -->
                <table class="table table-dark table-bordered table-hover align-middle mb-0">
                    <thead class="table-light text-dark">
                        <tr>
                            <th>ID</th>
                            <th>CustomerID</th>
                            <th>Order Date</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orderlist}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td>${order.customerId}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy" /></td>
                        <td>${order.totalAmount}</td>
                        <td>
                            <form action="manage-orders" method="post">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="orderId" value="${order.orderId}" />
                                <select name="status" class="admin-filter-select" onchange="this.form.submit()">
                                    <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="Confirmed" ${order.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                    <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                    <option value="Delivered" ${order.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                </select>
                            </form>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <!-- Back Link -->
                    <a href="${pageContext.servletContext.contextPath}/manage-customers" class="admin-manage-back">
                        <i class="fas fa-arrow-left mr-1"></i> Back
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>