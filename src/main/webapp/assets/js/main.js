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
            clearMessages();

            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();

            showLoadingMessage(true);

            const errorMessage = isValidLogin(email, password);
            if (errorMessage) {
                showLoadingMessage(false);
                event.preventDefault(); // Prevent submission
                showError(errorMessage);
                return;
            }
            // Form submits normally after this
        });
    }

    const loginDashboardForm = document.getElementById("loginDashboardForm");

    if (loginDashboardForm) {
        loginDashboardForm.addEventListener("submit", function (event) {
            clearMessages();

            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();

            showLoadingMessage(true);

            const errorMessage = isValidLogin(email, password);
            if (errorMessage) {
                showLoadingMessage(false);
                event.preventDefault(); // Prevent submission
                showError(errorMessage);
                return;
            }
            // Form submits normally after this
        });
    }

    function isValidLogin(email, password) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|googlemail\.com)$/;
        if (!emailRegex.test(email)) {
            return "Please enter a valid Google email address (gmail.com or googlemail.com).";
        }

        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        if (password.length < 8) {
            return "Password must be at least 8 characters long.";
        } else if (!passwordRegex.test(password)) {
            return "Password must contain at least 1 letter and 1 number.";
        }

        return null;
    }

    /*==============================
     Register
     ==============================*/
    const registerForm = document.getElementById("registerForm");

    if (registerForm) {
        registerForm.addEventListener("submit", function (event) {
            clearMessages();

            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            const confirmPassword = document.getElementById('confirmPassword').value.trim();
            const firstName = document.getElementById('firstName').value.trim();
            const lastName = document.getElementById('lastName').value.trim();

            showLoadingMessage(true);

            const errorMessage = isValidRegister(username, email, password, confirmPassword, firstName, lastName);
            if (errorMessage) {
                showLoadingMessage(false);
                event.preventDefault(); // prevent form from submitting if invalid
                showError(errorMessage);
                return;
            }
        });
    }

    function isValidRegister(username, email, password, confirmPassword, firstName, lastName) {
        const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
        if (!username || !usernameRegex.test(username)) {
            return "Username must be 3-20 characters long and can only contain letters, numbers, and underscores.";
        }

        const emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|googlemail\.com)$/;
        if (!emailRegex.test(email)) {
            return "Please enter a valid Google email address (gmail.com or googlemail.com).";
        }

        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        if (password.length < 8) {
            return "Password must be at least 8 characters long.";
        } else if (!passwordRegex.test(password)) {
            return "Password must contain at least 1 letter and 1 number.";
        }

        if (password !== confirmPassword) {
            return "Passwords do not match.";
        }

        const nameRegex = /^[a-zA-Z]+$/; // Allow only alphabetic characters
        if (!firstName || !lastName) {
            return "First Name and Last Name cannot be empty.";
        }
        if (!nameRegex.test(firstName) || !nameRegex.test(lastName)) {
            return "First Name and Last Name can only contain letters.";
        }

        return null;
    }

    /*==============================
     Reset Password
     ==============================*/
    const resetPasswordForm = document.getElementById("resetPasswordForm");

    if (resetPasswordForm) {
        resetPasswordForm.addEventListener("submit", function (event) {
            clearMessages();

            const password = document.getElementById('password').value.trim();
            const confirmPassword = document.getElementById('confirmPassword').value.trim();

            showLoadingMessage(true);

            const errorMessage = isValidResetForm(password, confirmPassword);
            if (errorMessage) {
                showLoadingMessage(false);
                event.preventDefault(); // Block form submission
                showError(errorMessage);
                return;
            }

            // Allow traditional POST to go through
        });
    }

    function isValidResetForm(password, confirmPassword) {
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;

        if (password.length < 8) {
            return "Password must be at least 8 characters long.";
        } else if (!passwordRegex.test(password)) {
            return "Password must contain at least 1 letter and 1 number.";
        }

        if (password !== confirmPassword) {
            return "Passwords do not match.";
        }

        return null;
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

            showLoadingMessage(true);

            const errorMessage = isValidEmail(email);
            if (errorMessage) {
                showLoadingMessage(false);
                showError(errorMessage);
                return;
            }

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

            showLoadingMessage(true);

            const errorMessage = validateFormForgotPassword(email, otp);
            if (errorMessage) {
                showLoadingMessage(false);
                showError(errorMessage);
                return;
            }

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
                    showLoadingMessage(false);
                    if (data.success) {
                        showSuccess(data.message);
                    } else {
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
                    showLoadingMessage(false);
                    if (data.success) {
                        showSuccess(data.message);
                        window.location.href = data.redirectUrl;
                    } else {
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