function initOwlCarousel(selector, options = {}) {
    const {
        loop = true,
        margin = 20,
        nav = true,
        autoplay = true,
        autoplayTimeout = 3000,
        autoplayHoverPause = true,
        responsiveItems = { 0: 1, 600: 2, 1000: 4 }
    } = options;

    $(selector).owlCarousel({
        loop,
        margin,
        nav,
        navText: [
            "<span class='custom-owl-prev'>&#10094;</span>",
            "<span class='custom-owl-next'>&#10095;</span>"
        ],
        autoplay,
        autoplayTimeout,
        autoplayHoverPause,
        items: responsiveItems[0] || 1,
        responsive: Object.keys(responsiveItems).reduce((acc, key) => {
            acc[key] = { items: responsiveItems[key] };
            return acc;
        }, {})
    });
}
/*---------------------------------------
  Initialize the hero background image with overlay             
-----------------------------------------*/
function initBackground(headerId, fixed = true) {
    const header = document.getElementById(headerId);
    if (!header) {
        console.error(`Header element with id "${headerId}" not found`);
        return;
    }

    const bg = header.getAttribute('data-bg');
    if (!bg) {
        console.error(`No background image URL found in data-bg attribute on element "${headerId}"`);
        return;
    }

    const gradient = `linear-gradient(to top, rgba(0, 0, 0, 0.8) 0%, rgba(0, 0, 0, 0.4) 40%, rgba(0, 0, 0, 0) 100%), url('${bg}')`;

    header.style.background = gradient;
    header.style.backgroundSize = "cover";
    header.style.backgroundPosition = "center";
    header.style.backgroundRepeat = "no-repeat";
    header.style.backgroundAttachment = fixed ? "fixed" : "scroll";
    header.style.zIndex = "1";
}

/*---------------------------------------
 Scroll to top when clicking certain links
-----------------------------------------*/
function scrollToTop(e) {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

/*---------------------------------------
 Copy text from contact card
-----------------------------------------*/
function copyText(event) {
    event.stopPropagation();
    event.preventDefault();

    const copyText = document.getElementById('copy-text').innerText;
    navigator.clipboard.writeText(copyText)
        .then(() => alert("Text copied to clipboard!"))
        .catch(err => console.error("Copy failed:", err));
}

/*---------------------------------------
 Setup Bootstrap ScrollSpy
-----------------------------------------*/
function initScrollSpy() {
    new bootstrap.ScrollSpy(document.body, {
        target: '#navbarNav',
        offset: 70
    });
}

/*---------------------------------------
 Preloader with minimum time logic
-----------------------------------------*/
function hidePreloader(minTime = 1000) {
    const preloader = document.querySelector(".preloader");
    const elapsed = Date.now() - window._pageStart;
    const delay = Math.max(0, minTime - elapsed);

    setTimeout(() => {
        preloader.style.opacity = "0";
        preloader.style.pointerEvents = "none";
        setTimeout(() => {
            preloader.style.display = "none";
        }, 500); // match fade-out time
    }, delay);
}

const scrollBtn = document.getElementById('scrollTopBtn');

window.addEventListener('scroll', () => {
    if (window.scrollY > 300) {  // Show after 300px scroll
        scrollBtn.style.display = 'block';
    } else {
        scrollBtn.style.display = 'none';
    }
});

scrollBtn.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth',
    });
});

/*---------------------------------------
// Main initializer function
-----------------------------------------*/
function initPage() {
    AOS.init();
    initBackground('main-background', true);  // fixed background
    initBackground('banner', false);           // scroll background
    initScrollSpy();
    hidePreloader(1000);
    // Advertisement (single item)
    initOwlCarousel('.featured-advertisement__carousel', {
        responsiveItems: { 0: 1 },
        autoplayTimeout: 5000
    });
    // Games (1, 2, 4 items)
    initOwlCarousel('.featured-games__carousel', {
        responsiveItems: { 0: 2, 600: 2, 1000: 3 }
    });
    // Accessories (1, 2, 3 items)
    initOwlCarousel('.featured-accessories__carousel', {
        responsiveItems: { 0: 2, 600: 2, 1000: 3 }
    });
}

// Track initial page load time
window._pageStart = Date.now();

// Wait until full page load
window.onload = initPage;
