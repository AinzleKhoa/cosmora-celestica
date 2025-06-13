$(document).ready(function () {
    "use strict"; // start of use strict

    /*==============================
     Scroll
     ==============================*/
    var mainHeader = $('.header');
    var scrolling = false,
            previousTop = 0,
            currentTop = 0,
            scrollDelta = 10,
            scrollOffset = 140;

    var scrolling = false;
    $(window).on('scroll', function () {
        if (!scrolling) {
            scrolling = true;
            (!window.requestAnimationFrame)
                    ? setTimeout(autoHideHeader, 250)
                    : requestAnimationFrame(autoHideHeader);
        }
    });
    $(window).trigger('scroll');

    function autoHideHeader() {
        var currentTop = $(window).scrollTop();
        checkSimpleNavigation(currentTop);
        previousTop = currentTop;
        scrolling = false;
    }

    function checkSimpleNavigation(currentTop) {
        if (previousTop - currentTop > scrollDelta) {
            mainHeader.removeClass('header--scroll');
        } else if (currentTop - previousTop > scrollDelta && currentTop > scrollOffset) {
            mainHeader.addClass('header--scroll');
        }
    }

    function disableScrolling() {
        var x = window.scrollX;
        var y = window.scrollY;
        window.onscroll = function () {
            window.scrollTo(x, y);
        };
    }

    function enableScrolling() {
        window.onscroll = function () { };
    }

    /*==============================
     Header
     ==============================*/
    $('.header__menu').on('click', function () {
        $('.header__menu').toggleClass('header__menu--active');
        $('.header__nav').toggleClass('header__nav--active');

        if ($('.header__nav').hasClass('header__nav--active')) {
            disableScrolling();
        } else {
            enableScrolling();
        }
    });

    /*==============================
     Multi level dropdowns
     ==============================*/
    $("ul.dropdown-menu [data-toggle='dropdown']").on("click", function (event) {
        event.preventDefault();
        event.stopPropagation();

        $(this).siblings().toggleClass("show");
    });

    $(document).on('click', function (e) {
        $('.dropdown-menu').removeClass('show');
    });

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

    $('.section__carousel--accessories').owlCarousel({
        mouseDrag: true,
        touchDrag: true,
        dots: false,
        loop: true,
        autoplay: true,
        smartSpeed: 700,
        margin: 30,
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

    $('.section__carousel--big').owlCarousel({
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
                items: 1,
                margin: 30,
                autoWidth: false,
            },
            1200: {
                items: 2,
                margin: 30,
                autoWidth: false,
                mouseDrag: false,
                touchDrag: false,
            },
        }
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
     Partners
     ==============================*/
    $('.partners').owlCarousel({
        mouseDrag: false,
        touchDrag: false,
        dots: false,
        loop: true,
        autoplay: true,
        autoplayTimeout: 5000,
        autoplayHoverPause: true,
        smartSpeed: 700,
        margin: 20,
        responsive: {
            0: {
                items: 2,
            },
            576: {
                items: 2,
                margin: 30,
            },
            768: {
                items: 3,
                margin: 30,
            },
            992: {
                items: 4,
                margin: 30,
            },
            1200: {
                items: 6,
                margin: 30,
            },
        }
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
    $('.post__video, .details__trailer, .open-map').magnificPopup({
        disableOn: 0,
        fixedContentPos: true,
        type: 'iframe',
        preloader: false,
        removalDelay: 300,
        mainClass: 'mfp-fade',
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

    $('.details__carousel a').magnificPopup({
        fixedContentPos: true,
        type: 'image',
        closeOnContentClick: true,
        closeBtnInside: false,
        removalDelay: 300,
        mainClass: 'mfp-fade',
        image: {
            verticalFit: true
        },
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
     Scroll bar
     ==============================*/
    $('.details__text').mCustomScrollbar({
        axis: "y",
        scrollbarPosition: "outside",
        theme: "custom-bar"
    });

    $('.header__nav-menu--scroll').mCustomScrollbar({
        axis: "y",
        scrollbarPosition: "outside",
        theme: "custom-bar2"
    });

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

    /*==============================
     Range sliders
     ==============================*/
    function initializeSlider() {
        if ($('#filter__range').length) {
            var firstSlider = document.getElementById('filter__range');
            noUiSlider.create(firstSlider, {
                range: {
                    'min': 9,
                    'max': 99
                },
                step: 1,
                connect: true,
                start: [18, 56],
                format: wNumb({
                    decimals: 0,
                    prefix: '$'
                })
            });
            var firstValues = [
                document.getElementById('filter__range-start'),
                document.getElementById('filter__range-end')
            ];
            firstSlider.noUiSlider.on('update', function (values, handle) {
                firstValues[handle].innerHTML = values[handle];
            });
        } else {
            return false;
        }
        return false;
    }
    $(window).on('load', initializeSlider());
});

function validateForm(event, formType) {
    let errors = [];

    // Get form inputs
    const username = document.getElementById('username') ? document.getElementById('username').value : null; // for registration
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword') ? document.getElementById('confirmPassword').value : null; // for registration

    // Validate username (only for registration)
    if (formType === 'register' || formType === 'login') {
        const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
        if (!username || !usernameRegex.test(username)) {
            errors.push("Username must be 3-20 characters long and can only contain letters, numbers, and underscores.");
        }
    }

    // Validate email
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailRegex.test(email)) {
        errors.push("Please enter a valid email address.");
    }

    if (formType === 'register' || formType === 'login') {
        // Validate password (both for login and registration)
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        if (password.length < 8) {
            errors.push("Password must be at least 8 characters long.");
        } else if (!passwordRegex.test(password)) {
            errors.push("Password must contain at least 1 letter and 1 number.");
        }
    }

    // Validate confirm password (only for registration)
    if ((formType === 'register' || formType === 'login') && password !== confirmPassword) {
        errors.push("Passwords do not match.");
    }

    // If there are errors, show them on the page
    if (errors.length > 0) {
        // Prevent form submission
        event.preventDefault();

        // Display errors
        const errorContainer = document.getElementById('errorMessages');
        errorContainer.innerHTML = "";  // Clear previous errors
        errors.forEach(function (error) {
            const errorMessage = document.createElement('p');
            errorMessage.classList.add('error-message');
            errorMessage.textContent = error;
            errorContainer.appendChild(errorMessage);
        });

        return false;
    }

    // If all checks pass
    return true; // This allows the form to submit
}

document.addEventListener('DOMContentLoaded', function () {
    let countdown = 30;
    let countdownInterval;
    let otpSent = false;

    const sendBtn = document.getElementById('sendOtpBtn');
    const verifyBtn = document.getElementById('verifyOtpBtn');
    const emailInput = document.getElementById('emailInput');
    const otpInput = document.getElementById('otpInput');
    const cooldownText = document.getElementById('cooldownText');

    sendBtn.addEventListener('click', function () {
        const email = emailInput.value.trim();

        clearMessages();

        const errorMessage = isValidEmail(email);
        if (errorMessage) {
            showError(errorMessage);
            return;
        }

        this.disabled = true;

        sendOtpToBackend(email);

        startCountdown();
    });

    verifyBtn.addEventListener('click', function () {
        const email = emailInput.value.trim();
        const otp = otpInput.value.trim();

        clearMessages();

        const errorMessage = validateForm(email, otp);
        if (errorMessage) {
            showError(errorMessage);
            return;
        }

        sendOtpForVerification(email, otp);
    });

    function validateForm(email, otp) {
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
            emailInput.focus();
            return "Please enter your email.";
        }

        if (!emailRegex.test(email)) {
            emailInput.focus();
            return "Please enter a valid email address (example@gmail.com).";
        }
        return null;
    }

    function isValidOtp(otp) {
        const otpRegex = /^[0-9]+$/;
        if (!otp) {
            otpInput.focus();
            return "Please enter your otp.";
        }
        if (!otpRegex.test(otp) || otp.length !== 6) {
            otpInput.focus();
            return "Please enter a valid otp (6-digit).";
        }
    }

    function sendOtpToBackend(email) {
        fetch('./forgot-password', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'email=' + encodeURIComponent(email) + '&action=sendOtp'
        })
                .then(res => res.json())  // Parse response as JSON
                .then(data => {
                    if (data.success) {
                        showSuccess(data.message);
                        otpSent = true; // Mark OTP as sent
                    } else {
                        showError(data.message);
                        sendBtn.disabled = false;
                        clearInterval(countdownInterval);
                        cooldownText.textContent = ''; 
                    }
                })
                .catch(() => {
                    showError("An error occurred. Please try again.");
                    sendBtn.disabled = false;
                    clearInterval(countdownInterval);
                    cooldownText.textContent = '';
                });
    }

    function sendOtpForVerification(email, otp) {
        fetch('./forgot-password', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'email=' + encodeURIComponent(email) +
                    '&otp=' + encodeURIComponent(otp) +
                    '&action=verifyOtp'
        })
                .then(res => res.json())  // Parse response as JSON
                .then(data => {
                    if (data.success) {
                        showSuccess(data.message);
                    } else {
                        showError(data.message);
                    }
                })
                .catch(() => {
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
                sendBtn.disabled = false;
                sendBtn.textContent = 'Resend OTP';
            } else {
                cooldownText.textContent = `You can resend OTP in ${countdown}s`;
            }
        }, 1000);
    }

    function showSuccess(message) {
        document.getElementById('successMessage').innerHTML = `<p>${message}</p>`;
    }

    function showError(message) {
        document.getElementById('errorMessages').innerHTML = `<p>${message}</p>`;
    }

    function clearMessages() {
        document.getElementById('successMessage').innerHTML = '';
        document.getElementById('errorMessages').innerHTML = '';
    }
});
