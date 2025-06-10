<%-- 
    Document   : header
    Created on : Feb 15, 2025, 9:46:24 AM
    Author     : Ainzle
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="user" value="${sessionScope.currentUser}"/>
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

                            <a href="${pageContext.servletContext.contextPath}/home" class="header__logo">
                                <img src="${pageContext.servletContext.contextPath}/assets/img/logo.png" alt="">
                            </a>

                            <ul class="header__nav">
                                <li class="header__nav-item">
                                    <a class="header__nav-link" href="${pageContext.servletContext.contextPath}/home">Home</a>
                                </li>								
                                <li class="header__nav-item">
                                    <a class="header__nav-link" href="${pageContext.servletContext.contextPath}/catalog">Catalog</a>
                                </li>
                            </ul>

                            <div class="header__actions">
                                <div class="header__lang">
                                    <c:choose>
                                        <c:when test="${not empty user}">
                                            <!-- Nếu user là admin, hiển thị thêm nút Admin Panel -->
                                            <c:if test="${user.role eq 'admin'}">
                                                <a href="${pageContext.servletContext.contextPath}/admin/games" class="header__link">
                                                    <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'>
                                                        <path d='M32 128h448v304a16 16 0 01-16 16H48a16 16 0 01-16-16V128z' fill='none' stroke='currentColor' stroke-linejoin='round' stroke-width='32'/>
                                                        <rect x='96' y='32' width='320' height='64' rx='8' ry='8' fill='none' stroke='currentColor' stroke-linejoin='round' stroke-width='32'/>
                                                        <line x1='112' y1='224' x2='400' y2='224' stroke='currentColor' stroke-linecap='round' stroke-linejoin='round' stroke-width='32'/>
                                                        <line x1='112' y1='320' x2='400' y2='320' stroke='currentColor' stroke-linecap='round' stroke-linejoin='round' stroke-width='32'/>
                                                    </svg>
                                                    <span>Admin Panel</span>
                                                </a>
                                            </c:if>
                                            <a href="${pageContext.servletContext.contextPath}/CheckoutServlet" class="header__link">
                                                <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><circle cx='176' cy='416' r='16' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><circle cx='400' cy='416' r='16' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><polyline points='48 80 112 80 160 352 416 352' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><path d='M160,288H409.44a8,8,0,0,0,7.85-6.43l28.8-144a8,8,0,0,0-7.85-9.57H128' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/></svg>
                                                <span id="cart-total-price">$${totalPrice}</span>
                                                <span id="cart-count">(${cartCount})</span>
                                            </a>
                                            <a href="${pageContext.servletContext.contextPath}/profile" class="header__login" 
                                               style="border: none;">
                                                <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><path d='M192,176V136a40,40,0,0,1,40-40H392a40,40,0,0,1,40,40V376a40,40,0,0,1-40,40H240c-22.09,0-48-17.91-48-40V336' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><polyline points='288 336 368 256 288 176' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><line x1='80' y1='256' x2='352' y2='256' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/></svg>
                                                <span>Welcome, ${user.username}</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.servletContext.contextPath}/login" class="header__login">
                                                <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><path d='M192,176V136a40,40,0,0,1,40-40H392a40,40,0,0,1,40,40V376a40,40,0,0,1-40,40H240c-22.09,0-48-17.91-48-40V336' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><polyline points='288 336 368 256 288 176' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><line x1='80' y1='256' x2='352' y2='256' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/></svg>
                                                <span>Sign in</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </header>
                <!-- end header -->