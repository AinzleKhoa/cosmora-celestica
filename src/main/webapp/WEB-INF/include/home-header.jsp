<%-- 
    Document   : home-header
    Created on : Jun 10, 2025, 10:20:25 AM
    Author     : Ainzle
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
    <!-- header -->
    <header class="header">
        <div class="header__wrap">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="header__content">
                            <button class="header__menu" type="button">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>

                            <a href="/home" class="header__logo">
                                <img src="${pageContext.servletContext.contextPath}/assets/img/logo.png" alt="">
                            </a>

                            <ul class="header__nav">
                            </ul>

                            <div class="header__actions">
                                <a href="/checkout" class="header__link">
                                    <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512'
                                        viewBox='0 0 512 512'>
                                        <circle cx='176' cy='416' r='16'
                                            style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                        <circle cx='400' cy='416' r='16'
                                            style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                        <polyline points='48 80 112 80 160 352 416 352'
                                            style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                        <path d='M160,288H409.44a8,8,0,0,0,7.85-6.43l28.8-144a8,8,0,0,0-7.85-9.57H128'
                                            style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                    </svg>
                                    <span>$00.00</span>
                                </a>
                                <a href="/login" class="header__login">
                                    <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512'
                                        viewBox='0 0 512 512'>
                                        <path
                                            d='M192,176V136a40,40,0,0,1,40-40H392a40,40,0,0,1,40,40V376a40,40,0,0,1-40,40H240c-22.09,0-48-17.91-48-40V336'
                                            style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                        <polyline points='288 336 368 256 288 176'
                                            style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                        <line x1='80' y1='256' x2='352' y2='256'
                                            style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                    </svg>
                                    <span>Login</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- end header -->
