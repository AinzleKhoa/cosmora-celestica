<%-- 
    Document   : delete-staff
    Created on : Jun 14, 2025, 5:54:24 PM
    Author     : VICTUS
--%>

<%@page import="shop.model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
      <body>
       
        <div style="margin-left: 250px">
            <div class="container mt-5">
                <div class="card shadow-lg p-4">
                    <h2 class="text-danger text-center">Delete Product</h2>
                    <hr>
                    <%
                            Staff s = (Staff) request.getAttribute("s");%>
                    <p class="text-center">Are you sure you want to delete Staff <b class="text-primary"><%=s.getUserName()%></b> with ID <b class="text-danger"><%=s.getId()%></b>?</p>
                    <form method="POST" action="${pageContext.servletContext.contextPath}/staffsmanagement" class="text-center">
                        <input type="hidden" name="Action" value="delete" />
                        <input type="hidden" name="id" value="${param.id}" />
                        <a href="${pageContext.servletContext.contextPath}/staffsmanagement?view=list" class="btn btn-secondary me-2">Back</a>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
