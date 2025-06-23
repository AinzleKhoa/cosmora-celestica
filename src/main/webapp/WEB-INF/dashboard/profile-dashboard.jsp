<%-- 
    Document   : profile-dashboard
    Created on : Jun 23, 2025, 7:42:22 AM
    Author     : CE190449 - Le Anh Khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/include/dashboard-header.jsp" %>
<style>
    .avatar-display-container {
        margin-bottom: 15px;
        text-align: center;
        margin-left: 100px;
    }

    .avatar-display {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #007bff;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .avatar-display:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
    }

    .change-avatar-btn {
        font-size: 16px;
        padding: 10px 20px;
        background-color: #007bff;
        border-color: #007bff;
        color: white;
        border-radius: 5px;
        transition: background-color 0.3s ease, transform 0.3s ease;
        display: block;
        margin-top: 10px;
        width: 100%;
    }

    .change-avatar-btn:hover {
        background-color: #0056b3;
        border-color: #004085;
        transform: scale(1.05);
    }

    .avatar-input {
        display: none;
    }

    .avatar-modal {
        display: none;
        padding: 10px;
        background-color: #004085;
        border-radius: 8px;
        transition: opacity 0.3s ease, transform 0.3s ease;
        opacity: 0;
        transform: translateY(-20px);
    }

    .avatar-modal.show {
        display: block;
        opacity: 1;
        transform: translateY(0);
    }

    .avatar-modal .modal-dialog {
        max-width: 700px;
        margin: 0 auto;
    }

    .avatar-selection-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
        gap: 15px;
        justify-items: center;
    }

    .avatar-item {
        text-align: center;
        border-radius: 8px;
        padding: 10px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .avatar-item:hover {
        transform: scale(1.1);
    }

    .avatar-option {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 50%;
        transition: transform 0.3s ease;
    }

    .avatar-option:hover {
        transform: scale(1.2);
    }

    #openAvatarModalBtn {
        font-size: 16px;
        padding: 8px 12px;
        background-color: #007bff;
        border-color: #007bff;
        color: white;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    #openAvatarModalBtn:hover {
        background-color: #0056b3;
        border-color: #004085;
    }

    .modal-body {
        padding: 20px;
        max-height: 60vh;
        overflow-y: auto;
    }

    .modal-header {
        color: #00c8ff;
        border-bottom: 1px solid #00c8ff;
    }

    .modal-title {
        font-size: 20px;
        font-weight: bold;
    }

    .modal-footer {
        padding: 10px;
    }

    .closeBtnModal {
        color: white;
    }

    .closeBtnModal:hover {
        color: #007bff;
    }

    .modal-backdrop {
        background-color: rgba(0, 0, 0, 0.5);
    }

    /* Add focus effect to the select dropdown */
    .form__input:focus {
        border-color: #007bff;
        background-color: #333;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }

    /* Style for the dropdown options */
    .form__input option {
        background-color: #1a1a1a;
        color: #fff;
    }

    /* Styling for the selected option */
    .form__input option:checked {
        background-color: #007bff;
        color: #fff;
    }

    /* Style for the date input icon */
    .form__input[type="date"]::-webkit-calendar-picker-indicator {
        background-color: #007bff;
        border-radius: 5px;
        padding: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    /* Hover effect for the date picker icon */
    .form__input[type="date"]::-webkit-calendar-picker-indicator:hover {
        background-color: #0056b3;
    }

    /* For Firefox */
    .form__input[type="date"]::-moz-calendar-picker-indicator {
        background-color: #007bff;
        border-radius: 5px;
        padding: 5px;
        cursor: pointer;
    }

    .form__input[type="date"]::-moz-calendar-picker-indicator:hover {
        background-color: #0056b3;
    }
</style>
<c:choose>
    <c:when test="${not empty requestScope.updateFailed and not empty requestScope.thisCustomer}">
        <c:set var="user" value="${requestScope.thisCustomer}" />
    </c:when>
    <c:otherwise>
        <c:set var="user" value="${sessionScope.currentCustomer}" />
    </c:otherwise>
</c:choose>

<!-- page title -->
<section class="section section--first section--last section--head" data-bg="${pageContext.servletContext.contextPath}/assets/img/bg3.png">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section__wrap">
                    <!-- section title -->
                    <h2 class="section__title">Profile</h2>
                    <!-- end section title -->

                    <!-- breadcrumb -->
                    <ul class="breadcrumb">
                        <li class="breadcrumb__item"><a href="${pageContext.servletContext.contextPath}/home">Home</a></li>
                        <li class="breadcrumb__item breadcrumb__item--active">Profile</li>
                    </ul>
                    <!-- end breadcrumb -->
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end page title -->

<!-- section -->
<section class="section section--last">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="profile">
                    <div class="profile__user">
                        <div class="profile__avatar">
                            <img src="${user.avatarUrl}" alt="">
                        </div>
                        <div class="profile__meta">
                            <h3>${user.username}</h3>
                            <span>Id: ${user.customerId}</span>
                        </div>
                    </div>

                    <ul class="nav nav-tabs profile__tabs" id="profile__tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#tab-1" role="tab"
                               aria-controls="tab-1" aria-selected="true">Profile Information</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tab-2" role="tab" aria-controls="tab-2"
                               aria-selected="false">Security Settings</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tab-3" role="tab"
                               aria-controls="tab-3" aria-selected="true">Order History</a>
                        </li>

                    </ul>

                    <a href="${pageContext.servletContext.contextPath}/logout" class="profile__logout" type="button">
                        <svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'>
                        <path
                            d='M304 336v40a40 40 0 01-40 40H104a40 40 0 01-40-40V136a40 40 0 0140-40h152c22.09 0 48 17.91 48 40v40M368 336l80-80-80-80M176 256h256'
                            fill='none' stroke-linecap='round' stroke-linejoin='round' stroke-width='32' />
                        </svg>
                        <span>Logout</span>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">

        <!-- Message Container -->
        <div id="message" style="color: yellow; margin-bottom: 15px;">
            <p id="messageText">
                <c:if test="${not empty message}">
                    ${message}
                </c:if>
            </p>
        </div>


        <!-- content tabs -->
        <div class="tab-content">

            <div class="tab-pane fade show active" id="tab-1" role="tabpanel">
                <div class="row">
                    <!-- details form -->
                    <div class="col-12 col-lg-7">
                        <form action="${pageContext.servletContext.contextPath}/profile" method="POST" id="profileCommonUpdate" class="form">
                            <input type="hidden" name="action" value="updateProfile"/>
                            <input type="hidden" name="id" value="${user.customerId}"/>
                            <div class="row">
                                <div class="col-12">
                                    <h4 class="form__title">Profile details</h4>
                                </div>

                                <div class="col-12 d-flex justify-content-center mb-5">
                                    <!-- Avatar URL input and display -->
                                    <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                        <label class="form__label" for="avatarUrl">Avatar</label>
                                        <input type="hidden" id="avatarUrl" name="avatarUrl" class="form__input avatar-input" value="${user.avatarUrl}" readonly>
                                        <div class="avatar-display-container">
                                            <img id="avatarDisplayImg" src="${user.avatarUrl}" 
                                                 class="avatar-display" alt="Avatar Display">
                                        </div>
                                        <button type="button" class="btn btn-primary change-avatar-btn" id="openAvatarModalBtn">Change Avatar</button>
                                    </div>
                                </div>

                                <!-- Username -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="username">Username</label>
                                    <input id="username" type="text" name="username" class="form__input"
                                           value="${user.username}" placeholder="${user.username}" required>
                                </div>

                                <!-- Email -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="email">Email</label>
                                    <input id="email" type="email" name="email" class="form__input"
                                           value="${user.email}" placeholder="${user.email}" disabled>
                                    <input id="email" type="hidden" name="email" class="form__input"
                                           value="${user.email}" placeholder="${user.email}">
                                </div>

                                <!-- Full Name -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="fullName">Full Name</label>
                                    <input id="fullName" type="text" name="fullName" class="form__input"
                                           value="${user.fullName}" placeholder="${user.fullName}" required>
                                </div>

                                <!-- Phone -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="phone">Phone Number</label>
                                    <input id="phone" type="text" name="phone" class="form__input"
                                           value="${user.phone}" placeholder="${user.phone}">
                                </div>

                                <!-- Gender -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="gender">Gender</label>
                                    <select id="gender" name="gender" class="form__input">
                                        <option value="" ${user.gender == null ? 'selected' : ''}>None Specify</option>
                                        <option value="other" ${user.gender == 'other' ? 'selected' : ''}>Other</option>
                                        <option value="male" ${user.gender == 'male' ? 'selected' : ''}>Male</option>
                                        <option value="female" ${user.gender == 'female' ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>

                                <!-- Address -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="address">Address</label>
                                    <input id="address" type="text" name="address" class="form__input"
                                           value="${user.address}" placeholder="${user.address}">
                                </div>

                                <!-- Date of Birth -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="dateOfBirth">Date of Birth</label>
                                    <input id="dateOfBirth" type="date" name="dateOfBirth" class="form__input"
                                           value="${user.dateOfBirth}">
                                </div>

                                <div class="col-12 mt-5">
                                    <p class="profile__info"><strong>Account Created At:</strong> 
                                        <fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy HH:mm" />
                                    </p>
                                    <p class="profile__info"><strong>Last Updated At:</strong> 
                                        <fmt:formatDate value="${user.updatedAt}" pattern="dd MMM yyyy HH:mm" />
                                    </p>
                                    <p class="profile__info"><strong>Email Verified:</strong> 
                                        <c:choose>
                                            <c:when test="${user.emailVerified}">Yes</c:when>
                                            <c:otherwise>No</c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>

                                <!-- Save Button -->
                                <div class="col-12">
                                    <button class="form__btn" type="submit">Save</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- end details form -->
                    <div class="col-12 col-lg-4">
                        <!-- Avatar selection modal (initially hidden) -->
                        <div class="modal avatar-modal" id="avatarModal" tabindex="-1" role="dialog" aria-labelledby="avatarModalLabel" aria-hidden="true">
                            <div class="modal-dialog avatar-modal-dialog" role="document"> <!-- Fixed modal width -->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="avatarModalLabel">Select an Avatar</h5>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Avatar grid container -->
                                        <div class="avatar-selection-container">
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar1.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar1.png" alt="Avatar 1">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar2.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar2.png" alt="Avatar 2">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar3.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar3.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar4.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar4.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar5.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar5.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar6.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar6.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar7.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar7.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar8.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar8.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar9.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar9.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar10.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar10.png" alt="Avatar 3">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn closeBtnModal" id="closeBtnModal" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="tab-2" role="tabpanel">
                <div class="row">
                    <!-- details form -->
                    <div class="col-12 col-lg-7">
                        <form action="${pageContext.servletContext.contextPath}/profile" method="POST" id="resetPasswordForm" class="form">
                            <input type="hidden" name="action" value="updatePassword"/>
                            <input type="hidden" name="id" value="${user.customerId}"/>
                            <div class="row">
                                <div class="col-12">
                                    <h4 class="form__title">Change password</h4>
                                </div>

                                <!-- New Password -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="newpass">New Password</label>
                                    <input id="newpass" type="password" name="newpass" class="form__input" required>
                                </div>

                                <!-- Confirm New Password -->
                                <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                    <label class="form__label" for="confirmpass">Confirm New Password</label>
                                    <input id="confirmpass" type="password" name="confirmnewpass" class="form__input" required>
                                </div>

                                <div class="col-12">
                                    <h4 class="form__title">Your old Password is required to update profile</h4>
                                </div>

                                <!-- Old Password -->
                                <div class="col-12">
                                    <label class="form__label" for="oldpass">Old Password</label>
                                    <input id="oldpass" type="password" name="oldpass" class="form__input" required>
                                </div>

                                <!-- Save Button -->
                                <div class="col-12">
                                    <button class="form__btn" type="submit">Save</button>
                                </div>

                                <div class="col-12 mt-5">
                                    <span class="sign__text"><a href="${pageContext.servletContext.contextPath}/forgot-password">Forgot password?</a></span>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- end details form -->
                    <div class="col-12 col-lg-4">
                        <!-- Avatar selection modal (initially hidden) -->
                        <div class="modal avatar-modal" id="avatarModal" tabindex="-1" role="dialog" aria-labelledby="avatarModalLabel" aria-hidden="true">
                            <div class="modal-dialog avatar-modal-dialog" role="document"> <!-- Fixed modal width -->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="avatarModalLabel">Select an Avatar</h5>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Avatar grid container -->
                                        <div class="avatar-selection-container">
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar1.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar1.png" alt="Avatar 1">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar2.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar2.png" alt="Avatar 2">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar3.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar3.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar4.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar4.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar5.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar5.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar6.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar6.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar7.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar7.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar8.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar8.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar9.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar9.png" alt="Avatar 3">
                                            </div>
                                            <div class="avatar-item">
                                                <img src="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar10.png" 
                                                     class="img-thumbnail avatar-option" data-avatar-url="${pageContext.servletContext.contextPath}/assets/img/avatar/avatar10.png" alt="Avatar 3">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn closeBtnModal" id="closeBtnModal" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="tab-3" role="tabpanel">
                <div class="row">
                    <div class="col-12">
                        <div class="table-responsive table-responsive--border">
                            <table class="profile__table">
                                <thead>
                                    <tr>
                                        <th>№</th>
                                        <th>Product</th>
                                        <th>Title</th>
                                        <th>Category</th>
                                        <th>Date</th>
                                        <th>Total Price</th>
                                        <th>Status</th>
                                        <th></th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <tr>
                                        <td><a href="#modal-info" class="open-modal">8451</a></td>
                                        <td>
                                            <div class="profile__img">
                                                <img src="${pageContext.servletContext.contextPath}/game/game1.png" alt="">
                                            </div>
                                        </td>
                                        <td>Desperados III Digital Deluxe Edition</td>
                                        <td>Game</td>
                                        <td>Aug 22, 2021</td>
                                        <td><span class="profile__price">$49.00</span></td>
                                        <td><span class="profile__status">Not confirmed</span></td>
                                        <td><button class="profile__delete" type="button"><svg
                                                    xmlns='http://www.w3.org/2000/svg' width='512' height='512'
                                                    viewBox='0 0 512 512'>
                                                <line x1='368' y1='368' x2='144' y2='144'
                                                      style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                                <line x1='368' y1='144' x2='144' y2='368'
                                                      style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px' />
                                                </svg></button></td>
                                    </tr>
                                    <tr>
                                        <td><a href="#modal-info" class="open-modal">8452</a></td>
                                        <td>
                                            <div class="profile__img">
                                                <img src="img/accessories/headset1.png" alt="">
                                            </div>
                                        </td>
                                        <td>Tai nghe Razer Kraken V4 X - Minecraft Edition</td>
                                        <td>Headset</td>
                                        <td>Aug 22, 2022</td>
                                        <td><span class="profile__price">$29.00</span></td>
                                        <td><span
                                                class="profile__status profile__status--confirmed">Confirmed</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><a href="#modal-info" class="open-modal">8452</a></td>
                                        <td>
                                            <div class="profile__img">
                                                <img src="img/keyboard/keyboard1.png" alt="">
                                            </div>
                                        </td>
                                        <td>Bàn Phím Có Dây Gaming Rapoo V50S</td>
                                        <td>Keyboard</td>
                                        <td>Aug 22, 2022</td>
                                        <td><span class="profile__price">$19.00</span></td>
                                        <td><span class="profile__status profile__status--cenceled">Canceled</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- paginator -->
                    <div class="col-12">
                        <div class="paginator">
                            <div class="paginator__counter">
                                3 from 9
                            </div>

                            <ul class="paginator__wrap">
                                <li class="paginator__item paginator__item--prev">
                                    <a href="#">
                                        <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512'
                                             viewBox='0 0 512 512'>
                                        <polyline points='244 400 100 256 244 112'
                                                  style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px' />
                                        <line x1='120' y1='256' x2='412' y2='256'
                                              style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px' />
                                        </svg>
                                    </a>
                                </li>
                                <li class="paginator__item paginator__item--active"><a href="#">1</a></li>
                                <li class="paginator__item"><a href="#">2</a></li>
                                <li class="paginator__item"><a href="#">3</a></li>
                                <li class="paginator__item paginator__item--next">
                                    <a href="#">
                                        <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512'
                                             viewBox='0 0 512 512'>
                                        <polyline points='268 112 412 256 268 400'
                                                  style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px' />
                                        <line x1='392' y1='256' x2='100' y2='256'
                                              style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px' />
                                        </svg>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- end paginator -->
                </div>
            </div>


        </div>
        <!-- end content tabs -->
    </div>
</section>
<!-- end section -->

<script>
    // Toggle the avatar selection modal when the "Change Avatar" button is clicked
    document.getElementById("openAvatarModalBtn").addEventListener("click", function () {
        const modal = document.getElementById("avatarModal");
        modal.classList.toggle("show");
    });

    // Close modal if clicked outside of the modal content
    document.querySelector('.closeBtnModal').addEventListener("click", function () {
        const modal = document.getElementById("avatarModal");
        modal.classList.remove("show");
    });

    // Handle avatar selection
    const avatarOptions = document.querySelectorAll('.avatar-option');
    avatarOptions.forEach(option => {
        option.addEventListener('click', function () {
            const selectedAvatarUrl = this.getAttribute('data-avatar-url');

            // Update the avatar display image
            document.getElementById('avatarDisplayImg').src = selectedAvatarUrl;

            // Update the hidden input value
            document.getElementById('avatarUrl').value = selectedAvatarUrl;

            const modal = document.getElementById("avatarModal");
            modal.classList.remove("show");
        });
    });

    document.getElementById('profileCommonUpdate').addEventListener('submit', function (e) {
        const username = this.querySelector('[name="username"]').value.trim();
        const email = this.querySelector('[name="email"]').value.trim();
        const fullName = this.querySelector('[name="fullName"]').value.trim();
        const phone = this.querySelector('[name="phone"]').value.trim();

        // Username - required
        if (username === '') {
            alert('Username is required.');
            e.preventDefault();
            return;
        }
        if (/\s/.test(username)) { // Check for any whitespace character
            alert('Username must not contain spaces.');
            e.preventDefault();
            return;
        }

        // Email - required + valid format
        const emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|googlemail\.com)$/;
        if (email === '') {
            alert('Email is required.');
            e.preventDefault();
            return;
        } else if (!emailRegex.test(email)) {
            alert('Please enter a valid email address.');
            e.preventDefault();
            return;
        }

        // Full Name - optional but must be 2–50 chars, no multiple spaces
        if (fullName !== '') {
            // Check for length
            if (fullName.length < 2 || fullName.length > 50) {
                alert('Full name must be between 2 and 50 characters.');
                e.preventDefault();
                return;
            }
            // Check for multiple consecutive spaces
            if (/ {2,}/.test(fullName)) {
                alert('Full name must not contain multiple consecutive spaces.');
                e.preventDefault();
                return;
            }
        }

        // Phone - optional but must be digits and 9–15 chars if provided
        const phoneRegex = /^[0-9]{9,15}$/;
        if (phone !== '' && !phoneRegex.test(phone)) {
            alert('Phone number must contain 9 to 15 digits only.');
            e.preventDefault();
            return;
        }

        // No validation for address
    });

    // ============================
    // SECURITY PASSWORD RESET
    // ============================

    document.getElementById('resetPasswordForm').addEventListener('submit', function (e) {

        const password = this.querySelector('[name="newpass"]').value.trim();
        const confirmPassword = this.querySelector('[name="confirmnewpass"]').value.trim();
        const oldPassword = this.querySelector('[name="oldpass"]').value.trim();

        // Old Password - required
        if (oldPassword === '') {
            alert('Current password is required.');
            e.preventDefault();
            return;
        }

        // New Password - required + must be at least 8 chars and contain letter + number
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;

        if (password.length < 8) {
            alert('New password must be at least 8 characters long.');
            e.preventDefault();
            return;
        } else if (!passwordRegex.test(password)) {
            alert('New password must contain at least 1 letter and 1 number.');
            e.preventDefault();
            return;
        }

        // Confirm New Password - must match new password
        if (password !== confirmPassword) {
            alert('New passwords do not match.');
            e.preventDefault();
            return;
        }

        // Optional: show message while submitting
        // showMessage('Processing...');
    });

</script>
<%@include file="/WEB-INF/include/dashboard-footer.jsp" %>