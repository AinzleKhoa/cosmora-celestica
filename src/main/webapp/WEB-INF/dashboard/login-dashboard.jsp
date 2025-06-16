<%-- 
    Document   : login-dashboard
    Created on : Jun 16, 2025, 7:18:07 PM
    Author     : CE190449 - Le Anh Khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- CSS -->
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-reboot.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-grid.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/nouislider.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/paymentfont.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/main.css">

        <!-- Favicons -->
        <link rel="icon" type="image/png" href="${pageContext.servletContext.contextPath}/assets/icon/logo.png" sizes="32x32">
        <link rel="apple-touch-icon" href="${pageContext.servletContext.contextPath}/assets/icon/logo.png">

        <meta name="description" content="Cosmora Celestica - Selling games and gaming accessories website">
        <meta name="keywords" content="">
        <title>Cosmora Celestica – Games and Accessories</title>

    </head>

    <body>
        <!-- sign in -->
        <div class="sign section--full-bg" data-bg="${pageContext.servletContext.contextPath}/assets/img/bg3.png">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="sign__content">
                            <!-- authorization form -->
                            <form action="${pageContext.servletContext.contextPath}/login-dashboard" method="POST" id="loginDashboardForm" class="sign__form">
                                <a href="${pageContext.servletContext.contextPath}/home" class="sign__logo">
                                    <img src="${pageContext.servletContext.contextPath}/assets/img/logo.png" alt="">
                                </a>
                                <h2 style="    font-size: 2rem;
                                    font-weight: bold;
                                    color: #00B0FF;
                                    text-align: center;
                                    margin-bottom: 20px;
                                    text-transform: uppercase;
                                    letter-spacing: 1px;">
                                    Dashboard
                                </h2>
                                <div id="loadingMessage">Processing...</div>

                                <!-- Success Message Container -->
                                <div id="successMessage" style="color: green; margin-bottom: 15px;">
                                    <c:if test="${not empty successMessage}">
                                        <p>${successMessage}</p>
                                    </c:if>
                                </div>

                                <!-- Error Message Container -->
                                <div id="errorMessage" style="color: red; margin-bottom: 15px;">
                                    <c:if test="${not empty requestScope.errorMessage}">
                                        <p>${requestScope.errorMessage}</p>
                                    </c:if>
                                </div>

                                <div class="sign__group">
                                    <input type="email" class="sign__input" placeholder="Email" name="email" id="email" value="${requestScope.email}" autocomplete="username">
                                </div>

                                <div class="sign__group">
                                    <input type="password" class="sign__input" name="password" id="password" value="${requestScope.password}" placeholder="Password"
                                           autocomplete="new-password">
                                </div>

                                <button class="sign__btn" type="submit">Sign in</button>

                                <a type="button" href="${pageContext.servletContext.contextPath}/home" class="sign__goback">Go Back</a>
                            </form>
                            <!-- end authorization form -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end sign in -->
        <!-- JS -->
        <script src="${pageContext.servletContext.contextPath}/assets/js/jquery-3.5.1.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/owl.carousel.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/jquery.magnific-popup.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/wNumb.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/nouislider.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/jquery.mousewheel.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/jquery.mCustomScrollbar.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/assets/js/main.js"></script>
    </body>

</html>
