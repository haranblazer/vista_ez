<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators" id="div_Slidercount" runat="server"></ol>
        <!-- Wrapper for slides -->
        <div class="carousel-inner" id="DivSlider" runat="server"></div>
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="fa fa-chevron-left"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="fa fa-chevron-right"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <!--  Top Banner Area Start -->
    <div class="banner-area ptb-90">
        <div class="container-fluid">
            <div id="div_banner_top" runat="server" class="row">
                <!--  Single Banner Area Start -->
                <%--  <div class="col-lg-4 col-md-4 mb-sm-30" >
                   
                    <div class="single-banner zoom">
                        <a href="#">
                            <img src="images/poster-1.jpg">
                        </a>
                    </div>
                </div>
                <!--  Single Banner Area End -->
                <!--  Single Banner Area Start -->
                <div class="col-lg-4 col-md-4 mb-sm-30" >
                    
                    <div class="single-banner zoom">
                        <a href="#">
                            <img src="images/poster-2.jpg">
                        </a>
                    </div>
                </div>
                <!--  Single Banner Area End -->
                <!--  Single Banner Area Start -->
                <div class="col-lg-4 col-md-4" >
                   
                    <div class="single-banner zoom">
                        <a href="#">
                            <img src="images/poster-3.jpg">
                        </a>
                    </div>
                </div>--%>
                <!--  Single Banner Area End -->
            </div>
        </div>
    </div>
    <!--  Top Banner Area End -->
    <!--  Deal Product Start Here -->
    <div class="deal-pro bg-image-18" <%=banner1 %>>
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="offset-lg-6 col-lg-6">
                    <div class="main-deal-pro">
                        <div id="div_OfferName" runat="server" class="deal-header">
                            <%--<h2>daily deals</h2>
                            <p>Special discounts on all products.</p>--%>
                        </div>

                        <div id="div_DailyDeals_Product" runat="server" class="daily-deal-active owl-carousel owl-loaded owl-drag pt-2">
                            <%-- <div ></div>--%>
                            <%-- <div class="single-makal-product">
                                <div class="pro-img">
                                    <a href="#">
                                        <img src="images/product/product.jpg" alt="product-img">
                                    </a>
                                    <span class="sticker-new">new</span>
                                    <span class="sticker-sale">-5%</span>
                                    <div class="quick-view-pro">
                                        <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                                    </div>
                                </div>
                                <div class="pro-content">
                                    <h4 class="pro-title"><a href="p?Swiss-Beauty-Ultra-Blush">Swiss Beauty Ultra Blush</a> </h4>
                                    <span class="product-item_code text-white">Item Code: 978867</span><span class="product-qty text-white">6 Caps </span>
                                    <div class="pro-actions">
                                        <div class="actions-secondary"><span class="price">MRP. 400.00</span> </div>
                                        <div class="actions-primary"><a href="javascript:void(0)" onclick="AddToCart(2)" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a> </div>
                                    </div>
                                </div>
                            </div>
                            <div class="single-makal-product">
                                <div class="pro-img">
                                    <a href="#">
                                        <img src="images/product/product.jpg" alt="product-img">
                                    </a>
                                    <span class="sticker-new">new</span>
                                    <span class="sticker-sale">-5%</span>
                                    <div class="quick-view-pro">
                                        <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                                    </div>
                                </div>

                                <div class="pro-content">
                                    <h4 class="pro-title"><a href="p?Swiss-Beauty-Ultra-Blush">Swiss Beauty Ultra Blush</a> </h4>
                                    <span class="product-item_code text-white">Item Code: 978867</span><span class="product-qty text-white">6 Caps </span>
                                    <div class="pro-actions">
                                        <div class="actions-secondary"><span class="price">MRP. 400.00</span> </div>
                                        <div class="actions-primary"><a href="javascript:void(0)" onclick="AddToCart(2)" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a> </div>
                                    </div>
                                </div>
                            </div>--%>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--  Deal Product End Here -->
    <!-- New Arrival Products Start Here -->
    <div class="new-arrival no-border-style ptb-50 ptb-xxs-20">
        <div class="container-fluid">
            <!-- Section Title Start -->
            <div class="section-title text-center">
                <h2>new arrivals</h2>
                <p>Add new arrivals to your weekly lineup!</p>
            </div>
            <!-- Section Title End -->
            <div id="div_NewArrivals_Product" runat="server" class="our-pro-active owl-carousel owl-loaded owl-drag">
                <%-- <div id="div_NewArrivals_Product" runat="server">--%>
                <%-- <div class="single-makal-product">
                    <div class="pro-img">
                        <a href="#">
                            <img src="images/product/product.jpg" alt="product-img">
                        </a>
                        <span class="sticker-new">new</span>
                        <span class="sticker-sale">-5%</span>
                        <div class="quick-view-pro">
                            <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                        </div>
                    </div>
                    <div class="pro-content">
                        <h4 class="pro-title"><a href="p?Swiss-Beauty-Ultra-Blush">Swiss Beauty Ultra Blush</a> </h4>
                        <span class="product-item_code">Item Code: 978867</span><span class="product-qty">6 Caps </span>
                        <div class="pro-actions">
                            <div class="actions-secondary"><span class="price">MRP. 400.00</span> </div>
                            <div class="actions-primary"><a href="javascript:void(0)" onclick="AddToCart(2)" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a> </div>
                        </div>
                    </div>
                </div>
                <div class="single-makal-product">
                    <div class="pro-img">
                        <a href="#">
                            <img src="images/product/product.jpg" alt="product-img">
                        </a>
                        <span class="sticker-new">new</span>
                        <span class="sticker-sale">-5%</span>
                        <div class="quick-view-pro">
                            <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                        </div>
                    </div>
                    <div class="pro-content">
                        <h4 class="pro-title"><a href="p?Swiss-Beauty-Ultra-Blush">Swiss Beauty Ultra Blush</a> </h4>
                        <span class="product-item_code">Item Code: 978867</span><span class="product-qty">6 Caps </span>
                        <div class="pro-actions">
                            <div class="actions-secondary"><span class="price">MRP. 400.00</span> </div>
                            <div class="actions-primary"><a href="javascript:void(0)" onclick="AddToCart(2)" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a> </div>
                        </div>
                    </div>
                </div>
                <div class="single-makal-product">
                    <div class="pro-img">
                        <a href="#">
                            <img src="images/product/product.jpg" alt="product-img">
                        </a>
                        <span class="sticker-new">new</span>
                        <span class="sticker-sale">-5%</span>
                        <div class="quick-view-pro">
                            <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                        </div>
                    </div>
                    <div class="pro-content">
                        <h4 class="pro-title"><a href="p?Swiss-Beauty-Ultra-Blush">Swiss Beauty Ultra Blush</a> </h4>
                        <span class="product-item_code">Item Code: 978867</span><span class="product-qty">6 Caps </span>
                        <div class="pro-actions">
                            <div class="actions-secondary"><span class="price">MRP. 400.00</span> </div>
                            <div class="actions-primary"><a href="javascript:void(0)" onclick="AddToCart(2)" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a> </div>
                        </div>
                    </div>
                </div>
                <div class="single-makal-product">

                    <div class="pro-img">
                        <a href="#">
                            <img src="images/product/product.jpg" alt="product-img">
                        </a>
                        <span class="sticker-new">new</span>
                        <span class="sticker-sale">-5%</span>
                        <div class="quick-view-pro">
                            <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                        </div>
                    </div>
                    <div class="pro-content">
                        <h4 class="pro-title"><a href="p?Swiss-Beauty-Ultra-Blush">Swiss Beauty Ultra Blush</a> </h4>
                        <span class="product-item_code">Item Code: 978867</span><span class="product-qty">6 Caps </span>
                        <div class="pro-actions">
                            <div class="actions-secondary"><span class="price">MRP. 400.00</span> </div>
                            <div class="actions-primary"><a href="javascript:void(0)" onclick="AddToCart(2)" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a> </div>
                        </div>
                    </div>
                </div>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
    <!-- New Arrival Products End Here -->
    <div class="new-arrival no-border-style ptb-50 ptb-xxs-20">
        <div class="container">
            <!-- Section Title Start -->
            <div class="section-title text-center">
                <h2>Our Brands</h2>
            </div>
            <div class="row justify-content-center" id="div_brandlogo" runat="server">
                <%--<div class='col-3'>
                    <img src='images/brand_logo/blossom_biapers.jpg' width='100%'></div>
                <div class='col-3'>
                    <img src='images/brand_logo/keep_moving.jpg' width='100%'></div>
                <div class='col-3'>
                    <img src='images/brand_logo/kira_&_kira.jpg' width='100%'></div>
                <div class='col-3'>
                    <img src='images/brand_logo/shine_bull.jpg' width='100%'></div>
                <div class='col-3'>
                    <img src='images/brand_logo/sachveda.jpg' width='100%'></div>
                <div class='col-3'>
                    <img src='images/brand_logo/kremlin.jpg' width='100%'></div>--%>
            </div>
        </div>
    </div>
    <!-- Our Best Seller Product Start Here -->
    <div class="our-product pt-90 d-none">
        <div class="container-fluid">
            <!-- Section Title Start -->
            <div class="section-title text-center">
                <h2>Our Best Sellers</h2>
                <p>
                    The collection of our products and top interresting products.
                </p>
            </div>
            <!-- Section Title End -->
            <div class="our-pro-active owl-carousel owl-loaded owl-drag"> </div>
        </div>
    </div>
    <!-- Our Best Seller Product End Here -->
    <!-- Testmonial Start Here -->
    <div class="testmonial patternbg ptb-90 ptb-xxs-20" <%=banner2%>
        <%-- style="background: url(../images/pattern.jpg); background-attachment: fixed; background-size: cover; background-position: center center;">--%>
        <div class="container-fluid">
            <!-- Section Title Start -->
            <div class="section-title text-center cl-testmonial">
                <h2>Ez Partners Testimonial</h2>
                <p>what they say</p>
            </div>
            <!-- Section Title End -->
            <section id="testim" class="testim">
                <div class="wrap">
                    <span id="right-arrow" class="arrow right fa fa-chevron-right"></span>
                    <span id="left-arrow" class="arrow left fa fa-chevron-left "></span>

                    <div id="div_testimonials" runat="server">
                        <%-- <ul id="testim-dots" class="dots">
                        <li class="dot active"></li>
                        <li class="dot"></li>
                        <li class="dot"></li>
                        <li class="dot"></li>
                        <li class="dot"></li>
                    </ul>
                    <div id="testim-content" class="cont">

                        <div class="active">
                            <div class="img">
                                <img src="https://images.unsplash.com/photo-1625241152315-4a698f74ceb7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80" alt="">
                            </div>
                            <h2>R. A. Rao</h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
                        </div>

                        <div>
                            <div class="img">
                                <img src="https://images.unsplash.com/photo-1621787279751-2baabc22d976?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80" alt="">
                            </div>
                            <h2>Aman Singh</h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
                        </div>

                        <div>
                            <div class="img">
                                <img src="https://images.unsplash.com/photo-1562783530-df27356a200d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80" alt="">
                            </div>
                            <h2>Sara Chakraborty</h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
                        </div>

                        <div>
                            <div class="img">
                                <img src="https://images.unsplash.com/photo-1660314019032-268d70002b7f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80" alt="">
                            </div>
                            <h2>Aryan Sidana</h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
                        </div>

                        <div>
                            <div class="img">
                                <img src="https://images.unsplash.com/photo-1583058905141-deef2de746bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=588&q=80" alt="">
                            </div>
                            <h2>Aadriti Jha</h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
                        </div>

                    </div> --%>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <!-- Testmonial End Here -->
    <!-- Best Low Fat  Start -->
    <div class="section section-padding d-none" id="offer">
        <div class="container">
            <br class="d-sm-none" />
            <br class="d-sm-none" />
            <h5 class="custom-secondary">Current Month Offers</h5>
            <div class="row">
                <div class="col-lg-12">
                    <div class="featured-slider-wrapper">
                        <div class="section-title-wrap section-header flex-header title-sm">
                            <div class="acr-arrows primary-arrows">
                                <i class="slider-prev fa fa-chevron-left slick-arrow"></i><i class="slider-next fa fa-chevron-right slick-arrow"></i>
                            </div>
                        </div>
                        <div class="featured-slider" id="div_Sliderfooter" runat="server">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Best Low Fat  End -->
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="position: absolute; right: 5px; top: 5px;">
                    <span aria-hidden="true">×</span>
                </button>
                <div id="div_Popup_img" runat="server"></div>
                <%--<img src="https://toptimenet.com/images/PopupImage/WhatsApp%20Image%202022-05-07%20at%2010.34.50%20AM.jpeg" /> --%>
            </div>
        </div>
    </div>



    <script src="datepick/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
        var URL = "Service.aspx";
        $(function () {
            GetCount();
        });


        function AddToCart(Batchid) {
            $.ajax({
                type: "POST",
                url: URL + '/AddProduct',
                data: '{Batchid: "' + Batchid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    GetCount();
                },
                error: function (response) { }
            });
        }


        function AddToWishList(Batchid) {

            $.ajax({
                type: "POST",
                url: URL + '/Addwishlist',
                data: '{Batchid: "' + Batchid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == 'LOGOUT') {
                        window.location = "login.aspx?wl=1";
                    }
                    if (data.d == '1') {
                        GetCountWishList();
                    }
                },
                error: function (response) { }
            });
        }
    </script>




    <asp:HiddenField ID="hnd_Popup" runat="server" Value="" />
    <script type="text/javascript">
        $(function () {
            if ($('#<%=hnd_Popup.ClientID%>').val() == "1") {
                $('#exampleModal').modal('show');
            }
        });
    </script>
    <style>
        @media (min-width: 576px) {
            .modal-dialog {
                max-width: 650px;
                margin: 1.75rem auto;
            }
        }
    </style>
    <script src="js/testim.js" type="text/javascript"></script>
</asp:Content>
