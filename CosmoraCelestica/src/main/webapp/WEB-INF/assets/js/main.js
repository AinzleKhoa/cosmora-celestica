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
		window.onscroll = function () { window.scrollTo(x, y); };
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
		var $outer = $('<div>').css({ visibility: 'hidden', width: 100, overflow: 'scroll' }).appendTo('body'),
			widthWithScroll = $('<div>').css({ width: '100%' }).appendTo($outer).outerWidth();
		$outer.remove();
		return 100 - widthWithScroll;
	};

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