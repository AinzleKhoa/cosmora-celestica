/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Legacy JS code
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
$(document).ready(function () {
    "use strict"; // start of use strict

    /*==============================
     Bg
     ==============================*/
    $('.section__ad--bg').each(function () {
        if ($(this).attr("data-bg")) {
            $(this).css({
                'background': 'url(' + $(this).data('bg') + ')',
                'background-position': 'center top 80px',
                'background-repeat': 'no-repeat',
                'background-size': 'auto 1000px'
            });
        }
    });

    $('.section__details--bg').each(function () {
        if ($(this).attr("data-bg")) {
            $(this).css({
                'background': 'url(' + $(this).data('bg') + ')',
                'background-position': 'center top 60px',
                'background-repeat': 'no-repeat',
                'background-size': 'auto 1000px'
            });
        }
    });

    $('.section--head').each(function () {
        if ($(this).attr("data-bg")) {
            $(this).css({
                'background': 'url(' + $(this).data('bg') + ')',
                'background-position': 'center top 140px',
                'background-repeat': 'no-repeat',
                'background-size': 'cover'
            });
        }
    });

    $('.section--full-bg').each(function () {
        if ($(this).attr("data-bg")) {
            $(this).css({
                'background': 'url(' + $(this).data('bg') + ')',
                'background-position': 'center center',
                'background-repeat': 'no-repeat',
                'background-size': 'cover'
            });
        }
    });

    /*==============================
     Section carousel
     ==============================*/
    $('.section__carousel--ad').owlCarousel({
        mouseDrag: true,
        touchDrag: true,
        dots: false,
        loop: true,
        autoplay: true,
        smartSpeed: 1600,
        margin: 30,
        autoHeight: true,
        items: 1
    });

    $('.section__carousel--catalog').owlCarousel({
        mouseDrag: true,
        touchDrag: true,
        dots: false,
        loop: true,
        autoplay: true,
        smartSpeed: 700,
        margin: 20,
        autoHeight: true,
        autoWidth: true,
        responsive: {
            0: {
                items: 2,
            },
            576: {
                items: 3,
            },
            768: {
                items: 3,
                margin: 30,
                autoWidth: false,
            },
            992: {
                items: 4,
                margin: 30,
                autoWidth: false,
            },
            1200: {
                items: 5,
                margin: 30,
                autoWidth: false,
                mouseDrag: false,
                touchDrag: false,
            },
        }
    });

    $('.section__nav--prev, .details__nav--prev').on('click', function () {
        var carouselId = $(this).attr('data-nav');
        $(carouselId).trigger('prev.owl.carousel');
    });
    $('.section__nav--next, .details__nav--next').on('click', function () {
        var carouselId = $(this).attr('data-nav');
        $(carouselId).trigger('next.owl.carousel');
    });

    /*==============================
     Details
     ==============================*/
    $('.details__thumb').on('click', function () {
        const preview = $(this).data('preview');
        $('#mainPreview').attr('src', preview);

        $('.details__thumb').removeClass('active');
        $(this).addClass('active');
    });

    const descToggle = document.getElementById('descToggle');
    const descContent = document.getElementById('descContent');

    if (descToggle && descContent) {
        descToggle.addEventListener('click', () => {
            const expanded = descContent.classList.toggle('expanded');
            descToggle.textContent = expanded ? 'Read less' : 'Read more';
        });
    }

    /*==============================
     Admin
     ==============================*/
    $('.admin-dropdown').on('click', function (e) {
        $('#adminDropdown').toggleClass('show');
        e.stopPropagation();
    });

    $(document).on('click', function (e) {
        if (!$(e.target).closest('.admin-dropdown').length) {
            $('#adminDropdown').removeClass('show');
        }
    });
    /*==============================
     Modal
     ==============================*/

    $('.open-modal').magnificPopup({
        fixedContentPos: true,
        fixedBgPos: true,
        overflowY: 'auto',
        type: 'inline',
        preloader: false,
        focus: '#username',
        modal: false,
        removalDelay: 300,
        mainClass: 'my-mfp-zoom-in',
        callbacks: {
            open: function () {
                if ($(window).width() > 1200) {
                    $('.header').css('margin-left', "-" + (getScrollBarWidth() / 2) + "px");
                }
            },
            close: function () {
                if ($(window).width() > 1200) {
                    $('.header').css('margin-left', 0);
                }
            }
        }
    });

    $('.modal__close').on('click', function (e) {
        e.preventDefault();
        $.magnificPopup.close();
    });

    function getScrollBarWidth() {
        var $outer = $('<div>').css({visibility: 'hidden', width: 100, overflow: 'scroll'}).appendTo('body'),
                widthWithScroll = $('<div>').css({width: '100%'}).appendTo($outer).outerWidth();
        $outer.remove();
        return 100 - widthWithScroll;
    }
    ;

    /*==============================
     Admin
     ==============================*/
    $('input[name="images[]"]').on('change', function (e) {
        const previewContainer = $('#imagePreviewContainer');
        previewContainer.empty();

        Array.from(e.target.files).forEach(file => {
            const reader = new FileReader();
            reader.onload = function (e) {
                const img = $('<img>', {
                    src: e.target.result,
                    alt: file.name,
                    css: {
                        maxWidth: '120px',
                        borderRadius: '6px',
                        marginRight: '10px',
                        marginBottom: '10px',
                        boxShadow: '0 2px 6px rgba(0,0,0,0.2)'
                    }
                });
                previewContainer.append(img);
            };
            reader.readAsDataURL(file);
        });
    });
});

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 New JS code
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
document.addEventListener('DOMContentLoaded', function () {
    const contextPath = window.location.pathname.split('/')[1]; // Get the context path dynamically
    function showLoadingMessage(show) {
        const loadingMessage = document.getElementById("loadingMessage");
        if (show) {
            loadingMessage.style.display = 'block';
        } else {
            loadingMessage.style.display = 'none';
        }
    }

    /*==============================
     Login
     ==============================*/
    const loginForm = document.getElementById("loginForm");

    if (loginForm) {
        loginForm.addEventListener("submit", function (event) {
            event.preventDefault();

            clearMessages();

            // Get the values when the form is submitted
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();

            const errorMessage = isValidLogin(email, password);
            if (errorMessage) {
                showError(errorMessage);
                return;
            }

            showLoadingMessage(true);

            // Use AJAX via fetch
            fetch(`/${contextPath}/login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams(new FormData(this)).toString()
            })
                    .then(res => res.json())  // Parse response as JSON
                    .then(data => {
                        if (data.success) {
                            showLoadingMessage(false);
                            showSuccess(data.message);
                            window.location.href = data.redirectUrl;
                        } else {
                            showLoadingMessage(false);
                            showError(data.message);
                        }
                    })
                    .catch(() => {
                        showLoadingMessage(false);
                        showError("An error occurred. Please try again.");
                    });
        });
    }

    function isValidLogin(email, password) {
        // Validate Email
        const emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|googlemail\.com)$/;
        if (!emailRegex.test(email)) {
            return "Please enter a valid Google email address (gmail.com or googlemail.com).";
        }
        // Validate Password
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        if (password.length < 8) {
            return "Password must be at least 8 characters long.";
        } else if (!passwordRegex.test(password)) {
            return "Password must contain at least 1 letter and 1 number.";
        }
    }

    /*==============================
     Register
     ==============================*/
    const registerForm = document.getElementById("registerForm");

    if (registerForm) {
        registerForm.addEventListener("submit", function (event) {
            event.preventDefault();

            clearMessages();
            // Get the values when the form is submitted
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            const confirmPassword = document.getElementById('confirmPassword').value.trim();

            const errorMessage = isValidRegister(username, email, password, confirmPassword);
            if (errorMessage) {
                showError(errorMessage);
                return;
            }

            showLoadingMessage(true);

            // Use AJAX via fetch
            fetch(`/${contextPath}/register`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams(new FormData(this)).toString()
            })
                    .then(res => res.json())  // Parse response as JSON
                    .then(data => {
                        if (data.success) {
                            showLoadingMessage(false);
                            showSuccess(data.message);
                            window.location.href = data.redirectUrl;
                        } else {
                            showLoadingMessage(false);
                            showError(data.message);
                        }
                    })
                    .catch(() => {
                        showLoadingMessage(false);
                        showError("An error occurred. Please try again.");
                    });
        });
    }

    function isValidRegister(username, email, password, confirmPassword) {
        const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
        if (!username || !usernameRegex.test(username)) {
            return "Username must be 3-20 characters long and can only contain letters, numbers, and underscores.";
        }
        // Validate Email
        const emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|googlemail\.com)$/;
        if (!emailRegex.test(email)) {
            return "Please enter a valid Google email address (gmail.com or googlemail.com).";
        }
        // Validate Password
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        if (password.length < 8) {
            return "Password must be at least 8 characters long.";
        } else if (!passwordRegex.test(password)) {
            return "Password must contain at least 1 letter and 1 number.";
        }
        // Validate confirmPassword
        if (password !== confirmPassword) {
            return "Passwords do not match.";
        }
    }

    /*==============================
     Send OTP + Verify OTP
     ==============================*/
    let countdown = 30;
    let countdownInterval;

    const sendOtpForgotBtn = document.getElementById('sendOtpForgotBtn');
    const verifyOtpForgotBtn = document.getElementById('verifyOtpForgotBtn');
    const emailForgotInput = document.getElementById('emailForgotInput');
    const otpForgotInput = document.getElementById('otpForgotInput');
    const cooldownText = document.getElementById('cooldownText');

// Only add event listeners if the buttons exist on the page
    if (sendOtpForgotBtn) {
        sendOtpForgotBtn.addEventListener('click', function () {
            const email = emailForgotInput.value.trim();

            clearMessages();

            const errorMessage = isValidEmail(email);
            if (errorMessage) {
                showError(errorMessage);
                return;
            }

            showLoadingMessage(true);

            this.disabled = true;

            sendOtpToBackend(email);

            startCountdown();
        });
    }

    if (verifyOtpForgotBtn) {
        verifyOtpForgotBtn.addEventListener('click', function () {
            const email = emailForgotInput.value.trim();
            const otp = otpForgotInput.value.trim();

            clearMessages();

            const errorMessage = validateFormForgotPassword(email, otp);
            if (errorMessage) {
                showError(errorMessage);
                return;
            }

            showLoadingMessage(true);

            sendOtpForVerification(email, otp);
        });
    }

    function validateFormForgotPassword(email, otp) {
        const emailError = isValidEmail(email);
        if (emailError)
            return emailError;

        const otpError = isValidOtp(otp);
        if (otpError)
            return otpError;

        return null;
    }

    function isValidEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!email) {
            emailForgotInput.focus();
            return "Please enter your email.";
        }

        if (!emailRegex.test(email)) {
            emailForgotInput.focus();
            return "Please enter a valid email address (example@gmail.com).";
        }
        return null;
    }

    function isValidOtp(otp) {
        const otpRegex = /^[0-9]+$/;
        if (!otp) {
            otpForgotInput.focus();
            return "Please enter your otp.";
        }
        if (!otpRegex.test(otp) || otp.length !== 6) {
            otpForgotInput.focus();
            return "Please enter a valid otp (6-digit).";
        }
    }

    function sendOtpToBackend(email) {
        fetch(`/${contextPath}/forgot-password`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'email=' + encodeURIComponent(email) + '&action=sendOtp'
        })
                .then(res => res.json())  // Parse response as JSON
                .then(data => {
                    if (data.success) {
                        showLoadingMessage(false);
                        showSuccess(data.message);
                    } else {
                        showLoadingMessage(false);
                        showError(data.message);
                        sendOtpForgotBtn.disabled = false;
                        clearInterval(countdownInterval);
                        cooldownText.textContent = '';
                    }
                })
                .catch(() => {
                    showLoadingMessage(false);
                    showError("An error occurred. Please try again.");
                    sendOtpForgotBtn.disabled = false;
                    clearInterval(countdownInterval);
                    cooldownText.textContent = '';
                });
    }

    function sendOtpForVerification(email, otp) {
        fetch(`/${contextPath}/forgot-password`, {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'email=' + encodeURIComponent(email) +
                    '&otp=' + encodeURIComponent(otp) +
                    '&action=verifyOtp'
        })
                .then(res => res.json())  // Parse response as JSON
                .then(data => {
                    if (data.success) {
                        showLoadingMessage(false);
                        showSuccess(data.message);
                        window.location.href = data.redirectUrl;
                    } else {
                        showLoadingMessage(false);
                        showError(data.message);
                    }
                })
                .catch(() => {
                    showLoadingMessage(false);
                    showError("An error occurred. Please try again.");
                });
    }

    function startCountdown() {
        countdown = 30;
        cooldownText.textContent = `You can resend OTP in ${countdown}s`;

        countdownInterval = setInterval(() => {
            countdown--;
            if (countdown <= 0) {
                clearInterval(countdownInterval);
                cooldownText.textContent = '';
                sendOtpForgotBtn.disabled = false;
                sendOtpForgotBtn.textContent = 'Resend OTP';
            } else {
                cooldownText.textContent = `You can resend OTP in ${countdown}s`;
            }
        }, 1000);
    }

    function showSuccess(message) {
        document.getElementById('successMessage').innerHTML = `<p>${message}</p>`;
    }

    function showError(message) {
        document.getElementById('errorMessage').innerHTML = `<p>${message}</p>`;
    }

    function clearMessages() {
        document.getElementById('successMessage').innerHTML = '';
        document.getElementById('errorMessage').innerHTML = '';
    }
});