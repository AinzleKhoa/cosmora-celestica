<%@page import="shop.model.Voucher"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include file="/WEB-INF/include/dashboard-header.jsp" %>
        <meta charset="UTF-8">
        <title>Delete Voucher</title>
    </head>
    <body>

        <button class="admin-sidebar-toggle" onclick="$('.admin-sidebar').toggleClass('open')">? Menu</button>

        <aside class="admin-sidebar">
            <%-- Sidebar content --%>
        </aside>

        <%
            Voucher voucher = (Voucher) request.getAttribute("voucher");
        %>

        <main class="admin-main">
            <div class="table-header">
                <h2 class="table-title">Delete Voucher</h2>
                <%
                    if (voucher == null) {
                %>
                <div style="border: 1px solid red; background-color: #ffe6e6; color: red; padding: 15px; border-radius: 5px;">
                    <strong>Error:</strong> Voucher not found.
                </div>
                <a href="<%= request.getContextPath()%>/manage-vouchers" class="btn btn-secondary mt-3">
                     Back to Voucher List
                </a>
                <%
                } else {
                %>
            </div>

            <div class="mb-4 p-3 border rounded bg-light">
                   <p><strong>Are you sure delete?</strong> </p>
                <p><strong>Code:</strong> <%= voucher.getCode()%></p>
                <p><strong>Value:</strong> <%= voucher.getValue()%></p>
            </div>

            <form method="post" action="<%= request.getContextPath()%>/manage-vouchers">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="<%= voucher.getVoucherId()%>">

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="<%= request.getContextPath()%>/manage-vouchers" class="admin-manage-back">
                        <i class="fas fa-arrow-left mr-1"></i> Back
                    </a>

                    <div>
                        <button type="submit" class="btn admin-manage-button">
                            <i class="fas fa-pen-to-square mr-1"></i> Delete
                        </button>
                    </div>
                </div>
            </form>

            <%
                }
            %>
        </main>

        <%@include file="/WEB-INF/include/dashboard-footer.jsp" %>
    </body>
</html>
