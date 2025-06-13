<%@page import="java.util.ArrayList"%>
<%@page import="shop.model.Voucher"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- CSS -->

        <%@include file="/WEB-INF/include/dashboard-header.jsp" %>
        <!-- Favicons -->


    </head>

    <body>

        <button class="admin-sidebar-toggle" onclick="$('.admin-sidebar').toggleClass('open')">?
            Menu</button>

        <aside class="admin-sidebar">
            <div class="admin-sidebar__logo">Dashboard</div>
            <ul class="admin-sidebar__nav">
                <li class="admin-sidebar__item">
                    <a href="admin-products.html" class="admin-sidebar__link">
                        <i class="fas fa-box"></i> Manage Products
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-staff.html" class="admin-sidebar__link">
                        <i class="fas fa-briefcase"></i> Manage Staffs
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-customer.html" class="admin-sidebar__link">
                        <i class="fas fa-users"></i> Manage Customers
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-order.html" class="admin-sidebar__link">
                        <i class="fas fa-clipboard-list"></i> Manage Orders
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-voucher.html" class="admin-sidebar__link active">
                        <i class="fas fa-tag"></i> Manage Vouchers
                    </a>
                </li>
                <li class="admin-sidebar__item">
                    <a href="admin-discount.html" class="admin-sidebar__link">
                        <i class="fas fa-percent"></i> Manage Discounts
                    </a>
                </li>
            </ul>
        </aside>

        <main class="admin-main">

            <div class="table-header">
                <h2 class="table-title">Manage Vouchers</h2>
            </div>

            <section class="admin-header">
                <div class="admin-header-top">
                    <button class="btn-admin-add">+ Add New Voucher</button>
                    <div class="search-filter-wrapper">
                        <input type="text" class="search-input" placeholder="Enter voucher name...">
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
                </div>
            </section>

            <section class="admin-table-wrapper">
                <div class="table-responsive shadow-sm rounded overflow-hidden">
                    <table class="table table-dark table-bordered table-hover align-middle mb-0">
                        <thead class="table-light text-dark">

                            <tr>
                                <th>ID</th>
                                <th>Code</th>
                                <th>Discount (%)</th>
                                <th>Usage</th>
                                <th>Valid From</th>
                                <th>Valid Until</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th style="text-align: center;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ArrayList<Voucher> voucherlist = (ArrayList) request.getAttribute("voucherslist");

                                for (Voucher voucher : voucherlist) {


                            %>
                            <tr>
                                <td><%= voucher.getVoucherId()%></td>
                                <td> <%= voucher.getCode()%></td>
                                <td><%= voucher.getValue()%></td>
                                <td><%= voucher.getUsageLimit()%></td>
                                <td><%= voucher.getStartDate()%></td>
                                <td><%= voucher.getEndDate()%></td>
                                <td><%= voucher.getDescription()%></td>
                                <td>
                                    <%

                                        if (voucher.getActive() == 1) {
                                    %>
                                    Active
                                    <%
                                    } else if (voucher.getActive() == 0) {
                                    %>
                                    Expired
                                    <%
                                    } else if (voucher.getActive() == 2) {
                                    %>
                                    Not yet started
                                    <%
                                    } else {
                                    %>
                                    Unknown
                                    <%
                                        }
                                    %>
                                </td> 
                                <td> <div class="table-actions-center">
                                        <button class="btn-action btn-details">Details</button>
                                        <button class="btn-action btn-edit"
                                                onclick="location.href = '<%= request.getContextPath()%>/voucher?view=edit&id=<%= voucher.getVoucherId()%>'">
                                            Edit
                                        </button>
                                        <button class="btn-action btn-delete">Delete</button>
                                    </div> </td> ><%}%>



                            </tr>
                        </tbody>

                    </table>

                </div>
            </section>
        </main>

        <!-- Edit Staff Modal -->
        <div class="modal fade" id="editStaffModal" tabindex="-1" aria-labelledby="editStaffLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header border-bottom-0">
                        <h5 class="modal-title" id="editStaffLabel">Edit Staff Info</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editStaffForm">
                            <div class="mb-3">
                                <label for="editFullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="editFullName" name="fullName" required>
                            </div>
                            <div class="mb-3">
                                <label for="editUsername" class="form-label">Username</label>
                                <input type="text" class="form-control" id="editUsername" name="username" required>
                            </div>
                            <div class="mb-3">
                                <label for="editEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="editEmail" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="editRole" class="form-label">Role</label>
                                <select class="form-select" id="editRole" name="role">
                                    <option value="Admin">Admin</option>
                                    <option value="Moderator">Moderator</option>
                                    <option value="Staff">Staff</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer border-top-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" form="editStaffForm" class="btn btn-primary">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- JS -->
        <script src="js/jquery-3.5.1.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/wNumb.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.mousewheel.min.js"></script>
        <script src="js/jquery.mCustomScrollbar.min.js"></script>
        <script src="js/main.js"></script>
    </body>

</html>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>