<%-- 
    Document   : customer-delete
    Created on : Jun 15, 2025, 11:36:54 PM
    Author     : CE190449 - Le Anh Khoa
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>
<c:set var="thisCustomer" value="${requestScope.thisCustomer}"/>
<main class="admin-main">
    <div class="table-header">
        <h2 class="table-title">Delete Customer</h2>
    </div>

    <div class="admin-manage-wrapper container py-4">
        <div class="mb-4">
            <a href="${pageContext.servletContext.contextPath}/manage-customers" class="admin-manage-back mb-5">
                <i class="fas fa-arrow-left mr-1"></i> Back
            </a>
        </div>
        <!-- Summary -->
        <div class="admin-manage-fieldset mb-4">
            <p class="mb-2"><strong>Full Name:</strong> ${thisCustomer.fullName}</p>
            <p class="mb-2"><strong>Username:</strong> ${thisCustomer.username}</p>
            <p class="mb-2"><strong>Email:</strong> ${thisCustomer.email}</p>
            <p class="mb-2"><strong>Phone:</strong> ${thisCustomer.phone}</p>
            <p class="mb-2"><strong>Gender:</strong> 
                <c:choose>
                    <c:when test="${thisCustomer.gender == '0'}">Male</c:when>
                    <c:when test="${thisCustomer.gender == '1'}">Female</c:when>
                    <c:when test="${thisCustomer.gender == '2'}">Other</c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
            </p>
            <p class="mb-2"><strong>Address:</strong> ${thisCustomer.address}</p>
            <p class="mb-2"><strong>Status:</strong> 
                <c:choose>
                    <c:when test="${thisCustomer.isDeactivated}">Suspended</c:when>
                    <c:otherwise>Active</c:otherwise>
                </c:choose>
            </p>
            <br>
            <p class="mb-2 text-warning"><i class="fas fa-triangle-exclamation mr-1"></i> This action cannot be
                undone.</p>
        </div>

        <!-- Delete Buttons -->
        <div class="d-flex justify-content-between align-items-center mt-4">
            <!-- Back Link -->
            <a href="${pageContext.servletContext.contextPath}/manage-customers" class="admin-manage-back mb-5">
                <i class="fas fa-arrow-left mr-1"></i> Back
            </a>
            <!-- Action Buttons -->
            <div class="d-flex justify-content-end">
                <form action="${pageContext.servletContext.contextPath}/manage-customers" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" value="${thisCustomer.customerId}"/>
                    <button type="submit" class="btn admin-manage-button-delete">
                        <i class="fas fa-trash mr-1"></i> Delete
                    </button>
                </form>
            </div>
        </div>
    </div>
</main>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>