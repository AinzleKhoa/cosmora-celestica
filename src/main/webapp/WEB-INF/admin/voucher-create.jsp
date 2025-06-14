<%@page import="shop.model.Voucher"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include file="/WEB-INF/include/dashboard-header.jsp" %>
        <meta charset="UTF-8">
        <title>Create Voucher</title>
    </head>
    <body>

        <button class="admin-sidebar-toggle" onclick="$('.admin-sidebar').toggleClass('open')">? Menu</button>

        <aside class="admin-sidebar">
            <%-- Sidebar content--%>
        </aside>

        <main class="admin-main">
            <div class="table-header">
                <h2 class="table-title">Create Voucher</h2>
            </div>

            <form method="post" action="<%= request.getContextPath()%>/voucher">
                <input type="hidden" name="action" value="create" >
                <div class="admin-manage-type voucher-details">
                    <fieldset class="mb-4 admin-manage-fieldset">                  
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Code</label>
                                <input type="text" class="form-control admin-manage-input" name="code" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Value</label>
                                <input type="number" class="form-control admin-manage-input" name="value" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Usage Limit</label>
                                <input type="number" class="form-control admin-manage-input" name="usage_limit" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Minimum Order Value</label>
                                <input type="number" class="form-control admin-manage-input" name="min_order_value" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">Start Date</label>
                                <input type="date" class="form-control admin-manage-input" name="start_date" id="start_date" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label admin-manage-label">End Date</label>
                                <input type="date" class="form-control admin-manage-input" name="end_date" id="end_date" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label admin-manage-label">Description</label>
                                <textarea class="form-control admin-manage-input" name="description" required></textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label admin-manage-label">Active</label>
                                <select class="form-control admin-manage-input" name="active" required>
                                    <option value="1">Active</option>
                                    <option value="0">Inactive</option>
                                    <option value="2">Not yet started</option>
                                </select>
                            </div>
                        </div>
                    </fieldset>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="<%= request.getContextPath()%>/voucher" class="admin-manage-back">
                        <i class="fas fa-arrow-left mr-1"></i> Back
                    </a>

                    <div>
                        <button type="submit" class="btn admin-manage-button">
                            <i class="fas fa-plus mr-1"></i> Create
                        </button>
                    </div>
                </div>
            </form>

            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <div style="border: 1px solid red; background-color: #ffe6e6; color: red; padding: 10px; margin-top: 15px; border-radius: 5px;">
                <strong>Error:</strong> <%= error %>
            </div>
            <% } %>

            <script>
                function validateDateRange(changedField) {
                    const startInput = document.getElementById("start_date");
                    const endInput = document.getElementById("end_date");
                    const startDate = new Date(startInput.value);
                    const endDate = new Date(endInput.value);

                    if (startInput.value && endInput.value) {
                        if (startDate > endDate) {
                            alert("Start date must be earlier than end date.");
                            if (changedField === "start") {
                                startInput.value = "";
                                startInput.focus();
                            } else {
                                endInput.value = "";
                                endInput.focus();
                            }
                        }
                    }
                }

                window.addEventListener("DOMContentLoaded", () => {
                    document.getElementById("start_date").addEventListener("change", function () {
                        validateDateRange("start");
                    });
                    document.getElementById("end_date").addEventListener("change", function () {
                        validateDateRange("end");
                    });
                });
            </script>
        </main>

        <%@include file="/WEB-INF/include/dashboard-footer.jsp" %>
    </body>
</html>
