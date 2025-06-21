<%-- 
    Document   : details-staff
    Created on : Jun 18, 2025, 2:16:50 PM
    Author     : VICTUS
--%>

<%@page import="java.util.List"%>
<%@page import="shop.model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>

<main class="admin-main">
    <div class="table-header">
        <h2 class="table-title">Edit Staff</h2>
    </div>

    <div class="admin-manage-wrapper container py-4">


        <!-- General Information -->



            <fieldset class="mb-4 admin-manage-fieldset">
                <legend class="admin-manage-subtitle">Staff Information</legend>
                <%
                    Staff s = (Staff) request.getAttribute("s");
                    if (s == null) {
                %>
                <tr>
                    <td colspan="8" class="text-center text-danger">No Staff Found</td>
                </tr>
                <%
                } else {

                %>
                <input type="hidden" name="id" value="<%=s.getId()%>" />

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Username</label>
                        <input type="text" class="form-control admin-manage-input" value="<%=s.getUsername()%> " name="username" id="username" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Email</label>
                        <input type="email" class="form-control admin-manage-input" value="<%=s.getEmail()%>" name="email" id="email" required>

                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Password</label>
                        <input type="text" class="form-control admin-manage-input" name="password" id="password" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Phone</label>
                        <input type="text" class="form-control admin-manage-input" value="<%=s.getPhone()%>" name="phone" id="phone">

                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Role</label>
                        <input type="text" class="form-control admin-manage-input" name="role" value="staff" readonly required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Avatar Image</label>
                        <img src="<%= s.getAvatarUrl()%>" 
                             alt="Avatar" 
                             style="width: 150px; height: 140px; border: 50px;">
                        <input type="file" class="form-control admin-manage-input"  value="<%=s.getAvatarUrl()%>"name="avatar_url" accept=".png">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label admin-manage-label">Date of Birth</label>
                        <input type="date" class="form-control admin-manage-input" value="<%=s.getDateOfBirth()%>" name="date_of_birth">

                    </div>
                </div>
                <%}%>
            </fieldset>

            <div class="d-flex justify-content-between align-items-center mt-4">
                <a href="${pageContext.servletContext.contextPath}/manage-staffs?view=list" class="admin-manage-back">
                    <i class="fas fa-arrow-left mr-1"></i> Back
                </a>

       
            </div>
       
    </div>
</main>

<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>
