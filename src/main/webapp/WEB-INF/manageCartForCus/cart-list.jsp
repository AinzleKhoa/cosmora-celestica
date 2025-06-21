<%@include file="../include/home-header.jsp" %>

<!DOCTYPE html>
<html lang="en">



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
                            <li class="breadcrumb__item"><a href="index.jsp">Home</a></li>
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
                                        <th>Quantity</th>

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
                                        <td><div class ="quantity" >
                                            <button style="color: white"  type="button">+</button>
                                            <span class="cart__price">1</span>
                                            <button style="color: white" type="button"> - </button>
                                            </div>
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