<%-- 
    Document   : reset-password
    Created on : Jun 13, 2025, 10:30:24 AM
    Author     : Le Anh Khoa - CE190449
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/home-header.jsp" %>
<!-- sign in -->
<div class="sign section--full-bg" data-bg="${pageContext.servletContext.contextPath}/assets/img/bg3.png">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="sign__content">
                    <form action="${pageContext.servletContext.contextPath}/reset-password" method="POST" class="sign__form" onsubmit="return validateForm(event, 'login')">
                        <a href="${pageContext.servletContext.contextPath}/home" class="sign__logo">
                            <img src="${pageContext.servletContext.contextPath}/assets/img/logo.png" alt="">
                        </a>

                        <!-- Success Message Container -->
                        <div id="successMessage" style="color: green; margin-bottom: 15px;">
                            <c:if test="${not empty successMessage}">
                                <p>${successMessage}</p>
                            </c:if>
                        </div>

                        <!-- Error Message Container -->
                        <div id="errorMessages" style="color: red; margin-bottom: 15px;">
                            <c:if test="${not empty requestScope.errorMessage}">
                                <p>${requestScope.errorMessage}</p>
                            </c:if>
                        </div>

                        <span class="sign__currentEmail">
                            <span>Email: </span>${sessionScope.currentForgotCustomer.email}
                        </span>
                        
                        <div class="sign__group">
                            <input type="password" class="sign__input" name="password" placeholder="New Password"
                                   autocomplete="new-password">
                        </div>

                        <div class="sign__group">
                            <input type="password" class="sign__input" name="password" placeholder="Confirm New Password"
                                   autocomplete="new-password">
                        </div>

                        <button class="sign__btn" type="submit">Submit</button>
                    </form>
                    <!-- end authorization form -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end sign in -->
<%@include file="/WEB-INF/include/home-footer.jsp" %>