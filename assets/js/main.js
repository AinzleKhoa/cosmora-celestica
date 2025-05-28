$(document).ready(function () {
    "use strict";

    /*==============================
     Header Menu Toggle
     ==============================*/
    $('.header__menu').on('click', function () {
        $('.header__menu').toggleClass('header__menu--active');
        $('.header__nav').toggleClass('header__nav--active');
        $('.header__nav').hasClass('header__nav--active') ? disableScrolling() : enableScrolling();
    });

    /*==============================
     Multi-Level Dropdowns
     ==============================*/
    $("ul.dropdown-menu [data-toggle='dropdown']").on("click", function (event) {
        event.preventDefault();
        event.stopPropagation();
        $(this).siblings().toggleClass("show");
    });

    $(document).on('click', function () {
        $('.dropdown-menu').removeClass('show');
    });

    /*==============================
     Background Image Handling
     ==============================*/
    function setBackground(selector, size, position) {
        $(selector).each(function () {
            if ($(this).attr("data-bg")) {
                $(this).css({
                    'background': 'url(' + $(this).data('bg') + ')',
                    'background-position': position,
                    'background-repeat': 'no-repeat',
                    'background-size': size
                });
            }
        });
    }

    setBackground('.section--bg', 'auto 950px', 'center top 120px');
    setBackground('.section--bg--details', 'auto 900px', 'center center');
    setBackground('.section--head', 'cover', 'center bottom -120px');
    setBackground('.section--full-bg', 'cover', 'center center');

    /*==============================
     Section Carousels (Owl Carousel)
     ==============================*/
    function initOwlCarousel(selector) {
        $(selector).each(function () {
            var carouselId = "#" + $(this).attr("id");
            $(carouselId).owlCarousel({
                mouseDrag: true,
                touchDrag: true,
                dots: false,
                loop: true,
                autoplay: true,
                autoHeight: true,
                autoWidth: true,
                margin: 20,
                autoplayTimeout: 4000,
                autoplayHoverPause: true,
                smartSpeed: 700,
                responsive: {
                    0: {items: 2},
                    576: {items: 3},
                    768: {items: 1, margin: 30, autoWidth: false},
                    1200: {items: 2, margin: 30, autoWidth: false}
                }
            });
        });
    }

    initOwlCarousel(".owl-carousel-home");
    initOwlCarousel(".owl-carousel-gamedetails");

    $('.section__nav--prev, .details__nav--prev').on('click', function () {
        $($(this).attr('data-nav')).trigger('prev.owl.carousel');
    });

    $('.section__nav--next, .details__nav--next').on('click', function () {
        $($(this).attr('data-nav')).trigger('next.owl.carousel');
    });

    /*==============================
     Game Details Carousel
     ==============================*/
    $('.details__carousel').owlCarousel({
        mouseDrag: true,
        touchDrag: true,
        dots: false,
        loop: true,
        autoplay: false,
        smartSpeed: 700,
        margin: 20,
        autoHeight: true,
        autoWidth: true,
        responsive: {
            0: {items: 2},
            576: {items: 3},
            768: {autoWidth: false, items: 4},
            992: {autoWidth: false, items: 5},
            1200: {autoWidth: false, items: 6}
        }
    });

    /*==============================
     Utility Functions
     ==============================*/
    function disableScrolling() {
        var x = window.scrollX;
        var y = window.scrollY;
        window.onscroll = function () {
            window.scrollTo(x, y);
        };
    }

    function enableScrolling() {
        window.onscroll = function () {};
    }
});