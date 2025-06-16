<%@page import="java.util.List"%>
<%@page import="shop.model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>

        <main class="admin-main">
            <div class="table-header">
                <h2 class="table-title">Edit Staff</h2>
            </div>

            <div class="admin-manage-wrapper container py-4">
                <div class="mb-4">
                    <a href="${pageContext.servletContext.contextPath}/manage-staffs?view=list" class="admin-manage-back mb-5">
                        <i class="fas fa-arrow-left mr-1"></i> Back
                    </a>
                </div>

                <!-- General Information -->
                <form action="${pageContext.servletContext.contextPath}/manage-staffs" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="edit" />
                    

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
                                <label class="form-label admin-manage-label">Full Name</label>
                                <input type="text" class="form-control admin-manage-input" value="<%=s.getUserName()%> " name="username" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Email</label>
                                <input type="email" class="form-control admin-manage-input" value="<%=s.getEmail()%>" name="email" required>

                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Password</label>
                                <input type="password" class="form-control admin-manage-input" value="<%=s.getPassword()%>" name="password" required>

                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Phone</label>
                                <input type="text" class="form-control admin-manage-input" value="<%=s.getPhone()%>" name="phone">

                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Role</label>
                                <input type="text" class="form-control admin-manage-input" name="role" value="Staff" readonly required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Avatar Image</label>
                                <img src="<%= request.getContextPath() + "/img/staff/" + s.getAvatarUrl()%>" 
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

                        <div>

                            <button type="submit" class="btn admin-manage-button">
                                <i class="fas fa-plus mr-1"></i> Edit
                            </button>

                        </div>
                    </div>
                </form>
            </div>
        </main>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>