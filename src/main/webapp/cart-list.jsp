<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- CSS -->
           <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-reboot.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-grid.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/nouislider.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/paymentfont.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/main.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <!-- Favicons -->
        <link rel="icon" type="image/png" href="icon/favicon-32x32.png" sizes="32x32">
        <link rel="apple-touch-icon" href="icon/favicon-32x32.png">

        <meta name="description" content="Digital marketplace HTML Template by Dmitry Volkov">
        <meta name="keywords" content="">
        <meta name="author" content="Dmitry Volkov">
        <title>GoGame ? Digital marketplace HTML Template</title>

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

                                <a href="index.html" class="header__logo">
                                    <img src="img/logo.png" alt="">
                                </a>

                                <ul class="header__nav">
                                    <li class="header__nav-item">
                                        <a class="header__nav-link" href="index.html">Home</a>
                                    </li>
                                    <li class="header__nav-item">
                                        <a class="header__nav-link" href="category-game.html">Games</a>
                                    </li>
                                    <li class="header__nav-item">
                                        <a class="header__nav-link" href="#" role="button" id="dropdownMenu1"
                                           data-toggle="dropdown" aria-haspopup="true"
                                           aria-expanded="false">Accessories<svg xmlns='http://www.w3.org/2000/svg'
                                                                              viewBox='0 0 512 512'>
                                            <path fill='none' stroke-linecap='round' stroke-linejoin='round'
                                                  stroke-width='48' d='M112 184l144 144 144-144' />
                                            </svg></a>

                                        <ul class="dropdown-menu header__nav-menu" aria-labelledby="dropdownMenu1">
                                            <li><a href="category-accessory.html">Headsets</a></li>
                                            <li><a href="category-accessory.html">Keyboard</a></li>
                                            <li><a href="category-accessory.html">Mouse</a></li>
                                            <li><a href="category-accessory.html">Controller</a></li>
                                        </ul>
                                    </li>
                                </ul>

                                <div class="header__actions">
                                    <a href="login.html" class="header__login">
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

            <div class="header__wrap">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="header__content">
                                <form action="#" class="header__form">
                                    <input type="text" class="header__input" placeholder="I'm searching for...">
                                    <button class="header__btn" type="button">
                                        <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512'
                                             viewBox='0 0 512 512'>
                                        <path
                                            d='M221.09,64A157.09,157.09,0,1,0,378.18,221.09,157.1,157.1,0,0,0,221.09,64Z'
                                            style='fill:none;stroke-miterlimit:10;stroke-width:32px' />
                                        <line x1='338.29' y1='338.29' x2='448' y2='448'
                                              style='fill:none;stroke-linecap:round;stroke-miterlimit:10;stroke-width:32px' />
                                        </svg>
                                    </button>
                                </form>

                                <div class="header__actions header__actions--2">
                                    <a href="checkout.html" class="header__link">
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- end header -->

        <!-- page title -->
        <section class="section section--first section--last section--head" data-bg="img/bg3.png">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section__wrap">
                            <!-- section title -->
                            <h2 class="section__title">Checkout</h2>
                            <!-- end section title -->

                            <!-- breadcrumb -->
                            <ul class="breadcrumb">
                                <li class="breadcrumb__item"><a href="index.html">Home</a></li>
                                <li class="breadcrumb__item breadcrumb__item--active">Checkout</li>
                            </ul>
                            <!-- end breadcrumb -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end page title -->

        <!-- section -->
        <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-12 col-lg-8">
                        <!-- cart -->
                        <!-- Thêm ?o?n JavaScript x? lý t?ng giá -->
<script>
    function updateTotalPrice() {
        let total = 0;
        document.querySelectorAll('.product-check:checked').forEach(cb => {
            total += parseFloat(cb.dataset.price);
        });
        document.getElementById("totalAmount").textContent = "$" + total.toFixed(2);
    }
</script>

<div class="cart">
    <div class="table-responsive">
        <table class="cart__table">
            <thead>
                <tr>
                    <th>?</th>
                    <th>Product</th>
                    <th>Title</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th></th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td>
                        <input type="checkbox" class="product-check" data-price="19.99" onclick="updateTotalPrice()">
                    </td>
                    <td>
                        <div class="cart__img">
                            <img src="img/cards/8.jpg" alt="">
                        </div>
                    </td>
                    <td><a href="#">Baldur's Gate: Enhanced Edition</a></td>
                    <td>Game</td>
                    <td><span class="cart__price">$19.99</span></td>
                    <td>
                        <button class="cart__delete" type="button">
                            <!-- icon delete -->
                        </button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" class="product-check" data-price="7.99" onclick="updateTotalPrice()">
                    </td>
                    <td>
                        <div class="cart__img">
                            <img src="img/accessories/headset1.png" alt="">
                        </div>
                    </td>
                    <td><a href="#">Dandara: Trials of Fear Edition</a></td>
                    <td>Headset</td>
                    <td><span class="cart__price">$7.99</span></td>
                    <td>
                        <button class="cart__delete" type="button">
                            <!-- icon delete -->
                        </button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" class="product-check" data-price="7.99" onclick="updateTotalPrice()">
                    </td>
                    <td>
                        <div class="cart__img">
                            <img src="img/controller/controller1.png" alt="">
                        </div>
                    </td>
                    <td><a href="#">Dandara: Trials of Fear Edition</a></td>
                    <td>Controller</td>
                    <td><span class="cart__price">$7.99</span></td>
                    <td>
                        <button class="cart__delete" type="button">
                            <!-- icon delete -->
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="cart__info">
        <div class="cart__total">
            <p>Total:</p>
            <span id="totalAmount">$0.00</span>
        </div>

        <div class="cart__systems">
            <i class="pf pf-visa"></i>
            <i class="pf pf-mastercard"></i>
            <i class="pf pf-paypal"></i>
        </div>
    </div>

    <button type="button" class="form__btn">Proceed to checkout</button>
</div>

                        <!-- end cart -->
                    </div>

          
                </div>
            </div>
        </div>
        <!-- end section -->

        <!-- footer -->
        <footer class="footer">
            <div class="container">
                <div class="row">

                    <div class="col-12">
                        <div class="footer__wrap">
                            <a class="footer__logo" href="index.html">
                                <img src="img/logo.png" alt="">
                            </a>

                            <span class="footer__copyright">© GG.template, 2020?2021 <br> Create by <a
                                    href="https://themeforest.net/user/dmitryvolkov/portfolio" target="_blank">Dmitry
                                    Volkov</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- end footer -->

        <!-- JS -->
        <script src="js/jquery-3.5.1.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/wNumb.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.mousewheel.min.js"></script>
        <script src="js/jquery.mCustomScrollbar.min.js"></script>
        <script src="js/main.js"></script>
    </body>

</html>