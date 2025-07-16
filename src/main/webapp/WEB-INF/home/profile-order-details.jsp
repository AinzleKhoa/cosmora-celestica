<%@page import="shop.model.OrderDetails"%>
<%@page import="shop.model.Order"%>
<%@page import="java.util.ArrayList"%>
<%@include file="../include/home-header.jsp" %>

<!-- page title -->
<section id="top-background" class="section--first " data-bg="${pageContext.servletContext.contextPath}/assets/img/bg3.png">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section__wrap">
                    <!-- section title -->
                    <h2 class="section__title">Order Details</h2>
                    <!-- end section title -->

                    <!-- breadcrumb -->
                    <ul class="breadcrumb">
                        <li class="breadcrumb__item"><a href="${pageContext.servletContext.contextPath}/home">Home</a></li>
                        <li class="breadcrumb__item"><a href="${pageContext.servletContext.contextPath}/profile">Profile</a></li>
                        <li class="breadcrumb__item"><a href="${pageContext.servletContext.contextPath}/profile">Order History</a></li>
                        <li class="breadcrumb__item breadcrumb__item--active">Order Details</li>
                    </ul>
                    <!-- end breadcrumb -->
                </div>
            </div>
        </div>
    </div>
</section>

<main class="orderdetailforcus" style="padding: 10px 80px" id="main-background" data-bg="<%= request.getContextPath()%>/assets/img/main-background.png">
    <div class="table-header" style="margin-top: 60px">
        <h2 class="table-title">Order Details</h2>
    </div>

    <%        Order order = (Order) request.getAttribute("order");
    %>

    <section class="admin-table-wrapper">
        <div class="table-responsive shadow-sm rounded overflow-hidden">
            <table class="table table-dark table-bordered table-hover align-middle mb-0">
                <thead class="table-light text-dark">
                    <tr>
                        <th>ID</th>
                        <th>Customer Name</th>
                        <th>Email</th>
                        <th>Order Date</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Address</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= request.getParameter("order_id")%></td>
                        <td><%= order.getCustomerName()%></td>
                        <td><%= order.getCustomerEmail()%></td>
                        <td><%= order.getOrderDate()%></td>
                        <td><%= order.getTotalAmount()%></td>
                        <td><span class="badge-status"><%= order.getStatus()%></span></td>
                        <td><span class="badge-staff"><%= order.getShippingAddress()%></span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>

    <div class="table-header">
        <h2 class="table-title">Product in order</h2>
    </div>

    <section class="admin-table-wrapper">
        <div class="table-responsive shadow-sm rounded overflow-hidden">
            <table class="table table-dark table-bordered table-hover align-middle mb-0">
                <thead class="table-light text-dark">
                    <tr>
                        <th>Product Image</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>XXX</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ArrayList<OrderDetails> orderDetails = (ArrayList) request.getAttribute("orderdetails");
                        for (OrderDetails orderdetails : orderDetails) {

                    %>
                    <tr>
                        <td><div class="cart__img">
                                <img src="<%= request.getContextPath()%>/assets/img/<%= orderdetails.getImageURL()%>" alt="">
                            </div></td>
                        <td><%= orderdetails.getProductName()%></td>
                        <td><%= orderdetails.getCategoryName()%></td>
                        <td><%= orderdetails.getQuantity()%></td>
                        <td><%= orderdetails.getPrice()%></td>
                        <% if (orderdetails.getGameKey() != null && !orderdetails.getGameKey().isEmpty() && orderdetails.getGameKey() != "") {
                        %>                            
                        <td><%= orderdetails.getGameKey()%></td>

                        <%}
                        %>

                    </tr>
                    <%  }%>
                </tbody>
            </table>
        </div>
    </section>
    <a href="javascript:history.back()" class="admin-manage-back">
        <i class="fas fa-arrow-left mr-1"></i> Back
    </a>
</main>

<!-- Facebook Button -->
<a href="https://www.facebook.com/YourPage" 
   style="position: fixed;
   bottom: 20px;
   right: 20px;
   background-color: #4267B2;
   color: white;
   padding: 15px 20px;
   border-radius: 50%;
   font-size: 24px;
   display: flex;
   align-items: center;
   justify-content: center;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
   transition: background-color 0.3s, transform 0.3s;
   text-decoration: none;
   cursor: pointer;
   z-index: 100;">
    <i class="fab fa-facebook-f" style="font-size: 24px;"></i>
</a>

<!-- Phone Button -->
<a href="tel:+1234567890" 
   id="phoneButton"
   style="position: fixed;
   bottom: 80px;
   right: 20px;
   background-color: #34b7f1;
   color: white;
   padding: 15px;
   border-radius: 50%;
   font-size: 24px;
   display: flex;
   align-items: center;
   justify-content: center;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
   transition: background-color 0.3s, transform 0.3s;
   text-decoration: none;
   cursor: pointer;
   z-index: 100;">
    <i class="fas fa-phone-alt"></i>
    <span id="phoneText" style="display: none;
          position: absolute;
          top: -30px;
          left: 0%;
          transform: translateX(-50%);
          background-color: #34b7f1;
          color: white;
          padding: 5px 10px;
          border-radius: 5px;
          font-size: 14px;">+1234567890</span>
</a>

<script>
    // Hover effect to show phone number
    document.querySelector('a[href="tel:+1234567890"]').addEventListener('mouseover', function () {
        document.getElementById('phoneText').style.display = 'block';
    });

    document.querySelector('a[href="tel:+1234567890"]').addEventListener('mouseout', function () {
        document.getElementById('phoneText').style.display = 'none';
    });

    // Click-to-copy phone number functionality
    document.getElementById('phoneButton').addEventListener('click', function (e) {
        e.preventDefault(); // Prevent the default action (making a call)

        // Create a temporary input element to copy the phone number
        const tempInput = document.createElement('input');
        tempInput.value = "+1234567890"; // Phone number to copy
        document.body.appendChild(tempInput);
        tempInput.select();
        tempInput.setSelectionRange(0, 99999); // For mobile devices

        // Copy the text to the clipboard
        document.execCommand('copy');

        // Remove the temporary input element
        document.body.removeChild(tempInput);

        // Display a message or change button style to indicate success
        alert('Phone number copied to clipboard!');
    });
</script>
<%@include file="../include/home-footer.jsp" %>