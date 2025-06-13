<%-- 
    Document   : forgot-password
    Created on : Jun 10, 2025, 9:14:11 PM
    Author     : CE190449 - Le Anh Khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/home-header.jsp" %>
<!-- sign in -->
<div class="sign section--full-bg" data-bg="${pageContext.servletContext.contextPath}/assets/img/bg3.png">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="sign__content">
                    <!-- authorization form -->
                    <div class="sign__form">
                        <a href="/home" class="sign__logo">
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

                        <!-- Send OTP Form -->
                        <form id="sendOtpForm" class="sign__group">
                            <div class="sign__group sign__group--otp">
                                <input type="email" class="sign__input" placeholder="Email" name="email" id="emailInput" value="${currentForgotEmail}" required>
                                <button type="button" id="sendOtpBtn" class="send-otp-link">Send OTP</button>
                            </div>
                            <p id="cooldownText" style="text-align: right; font-size: 12px; color: #999;"></p>


                            <div class="sign__group" id="otpSection">
                                <input type="text" class="sign__input" name="otp" id="otpInput" placeholder="Enter OTP" required>
                                <button type="button" id="verifyOtpBtn" class="sign__btn">Verify OTP</button>
                            </div>
                        </form>
                        <span class="sign__text">We will send a password to your Email</span>
                        <a type="button" href="${pageContext.servletContext.contextPath}/login" class="sign__goback">Go Back</a>
                        <!-- end authorization form -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end sign in -->
    <%@include file="/WEB-INF/include/home-footer.jsp" %>