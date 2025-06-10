<%-- 
    Document   : login
    Created on : Jun 10, 2025, 4:14:46 PM
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
                    <form action="${pageContext.servletContext.contextPath}/login" method="POST" class="sign__form" onsubmit="return validateForm(event, 'login')">
                        <a href="${pageContext.servletContext.contextPath}/home" class="sign__logo">
                            <img src="${pageContext.servletContext.contextPath}/assets/img/logo.png" alt="">
                        </a>

                        <!-- Error Message Container -->
                        <div id="errorMessages" style="color: red; margin-bottom: 20px;">
                            <c:if test="${not empty requestScope.errorMessage}">
                                <p>${requestScope.errorMessage}</p>
                            </c:if>
                        </div>

                        <div class="sign__group">
                            <input type="email" class="sign__input" placeholder="Email" autocomplete="username">
                        </div>

                        <div class="sign__group">
                            <input type="password" class="sign__input" placeholder="Password"
                                   autocomplete="new-password">
                        </div>

                        <div class="sign__group sign__group--checkbox">
                            <input id="remember" name="remember" type="checkbox" checked="checked">
                                <label for="remember">Remember Me</label>
                        </div>

                        <button class="sign__btn" type="submit">Sign in</button>

                        <span class="sign__delimiter">or</span>

                        <div class="sign__social">
                            <a class="gl" href="#"><svg xmlns='http://www.w3.org/2000/svg' class='ionicon'
                                                        viewBox='0 0 512 512'>
                                    <path
                                        d='M473.16 221.48l-2.26-9.59H262.46v88.22H387c-12.93 61.4-72.93 93.72-121.94 93.72-35.66 0-73.25-15-98.13-39.11a140.08 140.08 0 01-41.8-98.88c0-37.16 16.7-74.33 41-98.78s61-38.13 97.49-38.13c41.79 0 71.74 22.19 82.94 32.31l62.69-62.36C390.86 72.72 340.34 32 261.6 32c-60.75 0-119 23.27-161.58 65.71C58 139.5 36.25 199.93 36.25 256s20.58 113.48 61.3 155.6c43.51 44.92 105.13 68.4 168.58 68.4 57.73 0 112.45-22.62 151.45-63.66 38.34-40.4 58.17-96.3 58.17-154.9 0-24.67-2.48-39.32-2.59-39.96z' />
                                </svg></a>
                        </div>

                        <span class="sign__text">Don't have an account? <a href="${pageContext.servletContext.contextPath}/register">Register!</a></span>

                        <span class="sign__text"><a href="${pageContext.servletContext.contextPath}/forgot-password">Forgot password?</a></span>
                    </form>
                    <!-- end authorization form -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end sign in -->
<%@include file="/WEB-INF/include/home-footer.jsp" %>