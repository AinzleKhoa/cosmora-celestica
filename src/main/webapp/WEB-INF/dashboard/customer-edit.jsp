<%-- 
    Document   : customer-edit
    Created on : Jun 15, 2025, 9:21:54 AM
    Author     : Le Anh Khoa - CE190449
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>
<c:set var="thisCustomer" value="${requestScope.thisCustomer}"/>
<main class="admin-main">
    <div class="table-header">
        <h2 class="table-title">Edit Customer</h2>
    </div>

    <div class="admin-manage-wrapper container py-4">
        <div class="mb-4">
            <a href="${pageContext.servletContext.contextPath}/manage-customers" class="admin-manage-back mb-5">
                <i class="fas fa-arrow-left mr-1"></i> Back
            </a>
        </div>

        <!-- General Information -->
        <fieldset class="mb-4 admin-manage-fieldset">
            <legend class="admin-manage-subtitle">Customer Information</legend>
            <div class="row g-3">
                <!-- If offensive or misleading (e.g., hate speech, impersonation) -->
                <div class="col-md-6">
                    <label class="form-label admin-manage-label">Username</label>
                    <input type="text" class="form-control admin-manage-input" name="username" value="${thisCustomer.username}" required>
                </div>
                <!-- 	If it contains abusive text or spam patterns; or to anonymize -->
                <div class="col-md-6">
                    <label class="form-label admin-manage-label">Email</label>
                    <input type="email" class="form-control admin-manage-input" name="email" value="${thisCustomer.email}" required>
                </div>
                <!-- If it includes slurs, fake names, or inappropriate language -->
                <div class="col-md-6">
                    <label class="form-label admin-manage-label">Full Name</label>
                    <input type="text" class="form-control admin-manage-input" name="full_name" value="${thisCustomer.fullName}" required>
                </div>
                <!-- To blank or anonymize if it’s spammy or fake -->
                <div class="col-md-6">
                    <label class="form-label admin-manage-label">Phone</label>
                    <input type="text" class="form-control admin-manage-input" value="${thisCustomer.phone}" name="phone">
                </div>
                <!-- 	If it contains abusive content or was misused -->
                <div class="col-md-6">
                    <label class="form-label admin-manage-label">Address</label>
                    <input type="text" class="form-control admin-manage-input" value="${thisCustomer.address}" name="address">
                </div>
            </div>
        </fieldset>

        <div class="d-flex justify-content-between align-items-center mt-4">
            <!-- Back Link -->
            <a href="${pageContext.servletContext.contextPath}/manage-customers" class="admin-manage-back">
                <i class="fas fa-arrow-left mr-1"></i> Back
            </a>

            <!-- Action Buttons -->
            <div>
                <button type="reset" class="btn admin-manage-reset mr-2">
                    <i class="fas fa-xmark mr-1"></i> Reset
                </button>
                <button type="submit" class="btn admin-manage-button">
                    <i class="fas fa-pen-to-square mr-1"></i> Edit
                </button>
            </div>
        </div>
    </div>
</main>

<script>
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('avatarPreview').src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>
