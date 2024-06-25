<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="product.aspx.cs" Inherits="product" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/product.css" rel="stylesheet" />
    <style>
        .service-block.active {
            background: #002e9e;
            color: #ffffff;
        }

            .service-block.active h5 a {
                color: #ffffff;
            }
    </style>
    <div class="page_header">
        <div class="page_header_content">
            <%--<img src="images/product.jpg" />--%>
                    <asp:Image ID="Img_Banner" runat="server" Style="width: 100%" />

        </div>
    </div>
    <div class="subheader bg-cover d-none">
        <%--<img src="images/health-care.jpg" style="width: 100%">--%>
    </div>
    <!-- Services Section -->
    <section class="home-services-section pt-5">
        <div class="container-fluid">
            <div class="blocks-column">
                <div class="inner-column">
                    <div id="div_category" runat="server" class="row row-cols-sm-3 row-cols-md-4 row-cols-lg-6 align-items-center">
                        <!-- Service Block -->
                        
                        <%--<div class="col p-0 mb-3">
                            <div class="service-block active">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/1.png" alt="" />
                                    </div>
                                    <h5><a href="#">Healthcare</a></h5>
                                </div>
                            </div>
                        </div>
                        <div class="col p-0 mb-3">
                            <div class="service-block">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/2.png" alt="" />
                                    </div>
                                    <h5><a href="#">Personalcare</a></h5>
                                </div>
                            </div>
                        </div>
                        <div class="col p-0 mb-3">
                            <div class="service-block">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/3.png" alt="" />
                                    </div>
                                    <h5><a href="#">Wellness</a></h5>
                                </div>
                            </div>
                        </div>
                        <div class="col p-0 mb-3">
                            <div class="service-block">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/4.png" alt="" />
                                    </div>
                                    <h5><a href="#">FMCG</a></h5>
                                </div>
                            </div>
                        </div>
                        <div class="col p-0 mb-3">
                            <div class="service-block">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/5.png" alt="" />
                                    </div>
                                    <h5><a href="service-details.html">Skincare</a></h5>
                                </div>
                            </div>
                        </div>
                        <div class="col p-0 mb-3">
                            <div class="service-block">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/5.png" alt="" />
                                    </div>
                                    <h5><a href="service-details.html">Beautycare</a></h5>
                                </div>
                            </div>
                        </div>
                        <div class="col p-0 mb-3">
                            <div class="service-block">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/5.png" alt="" />
                                    </div>
                                    <h5><a href="service-details.html">Beutycare</a></h5>
                                </div>
                            </div>
                        </div>
                        <div class="col p-0 mb-3">
                            <div class="service-block">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/5.png" alt="" />
                                    </div>
                                    <h5><a href="service-details.html">Beutycare</a></h5>
                                </div>
                            </div>
                        </div>--%>



                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Services Section -->
    <div class="container">
        <div id="columns">
        <div id="div_Product" runat="server" class=" row">
            </div>
            <%--<div class="col-md-4">
                <figure>
                    <div class="image-container">
                        <div class="first">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="discount">Item: 301120 gms
                                </span>
                                <span class="wishlist"><i class="fa fa-heart-o"></i></span>
                            </div>
                        </div>
                        <img src="Productimage/746d0fb84d-3ec8-4879-bf6c-d5ff5e9a6d12.png">
                    </div>
                    <figcaption>Be-Fair Cream</figcaption>
                    <span class="price">MRP 149.00/-</span>
                    <p>Phytoactive Nurturing Complexion And Radiance For Men</p>
                    <a class="button" href="#">Buy Now</a>
                </figure>
            </div>
            <div class="col-md-4">
                <figure>
                    <div class="image-container">
                        <div class="first">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="discount">Item: 301120 gms
                                </span>
                                <span class="wishlist"><i class="fa fa-heart-o"></i></span>
                            </div>
                        </div>
                        <img src="Productimage/754b756301-8875-46a2-b912-b4341a351e5d.png">
                    </div>
                    <figcaption>Be-Fair Cream</figcaption>
                    <span class="price">MRP 149.00/-</span>
                    <p>Phytoactive Nurturing Complexion And Radiance For Men</p>
                    <a class="button" href="#">Buy Now</a>
                </figure>
            </div>
            <div class="col-md-4">
                <figure>
                    <div class="image-container">
                        <div class="first">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="discount">Item: 301120 gms
                                </span>
                                <span class="wishlist"><i class="fa fa-heart-o"></i></span>
                            </div>
                        </div>
                        <img src="Productimage/754b756301-8875-46a2-b912-b4341a351e5d.png">
                    </div>
                    <figcaption>Be-Fair Cream</figcaption>
                    <span class="price">MRP 149.00/-</span>
                    <p>Phytoactive Nurturing Complexion And Radiance For Men</p>
                    <a class="button" href="#">Buy Now</a>
                </figure>
            </div>
            <div class="col-md-4">
                <figure>
                    <div class="image-container">
                        <div class="first">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="discount">Item: 301120 gms
                                </span>
                                <span class="wishlist"><i class="fa fa-heart-o"></i></span>
                            </div>
                        </div>
                        <img src="Productimage/0d107984-91b1-400e-b48a-5337e5f5ec93.png">
                    </div>
                    <figcaption>Be-Fair Cream</figcaption>
                    <span class="price">MRP 149.00/-</span>
                    <p>Phytoactive Nurturing Complexion And Radiance For Men</p>
                    <a class="button" href="#">Buy Now</a>
                </figure>
            </div>--%>

        </div>
       <%-- <div class="section section-padding pt-0">
            <div class="container">
                <div class="product-tab-wrapper">
                    <ul id="div_category" runat="server" class="nav nav-tabs border-0 row"></ul>
                    <div class="tab-content mt-0">
                        <div class="tab-pane fade show active">
                            <div id="div_Product" runat="server" class="row"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
        <div class="col-md-4" style="display: none;">
            <a href="Cart" class="cart fa fa-3x fa-shopping-cart" style="display: block;"></a>
            <span class="cart-data">0</span>
        </div>
    </div>
    <!-- Product-tab-box End -->
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

        function GetCount() {
            $.ajax({
                type: "POST",
                url: URL + '/GetCount',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#lbl_MasterCart').text(data.d);
                    $('.cart-data').text(data.d);
                    BindMasterCartTable();
                },
                error: function (response) { }
            });
        }

        function BindMasterCartTable() {
            $.ajax({
                type: "POST",
                url: URL + '/GetCartData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#div_Master_Cart').empty();
                    var NetAmt = 0;
                    var tbl = "";
                    for (var i = 0; i < data.d.length; i++) {
                        NetAmt = NetAmt + parseFloat(data.d[i].totalamt);

                        tbl += '<li class="cart-item">';
                        tbl += '<div class="img"> <img src="../ProductImage/' + data.d[i].image + '" alt="img"> </div>';
                        tbl += '<div class="content">';
                        tbl += '<h5><a href="#">' + data.d[i].pname + '</a></h5>';
                        tbl += '<p>' + data.d[i].qty + ' x ' + data.d[i].DPAmt.toFixed(4) + '</p>';
                        tbl += '</div>';
                        tbl += '</li>';
                    }
                    $('#div_Master_Cart').append(tbl);
                    if (data.d.length == 0) {
                        $('#lbl_MasterTotal').text(parseFloat(0.00));
                        return false;
                    }
                    if (data.d.length > 0) {
                        $('#lbl_MasterTotal').text(parseFloat(NetAmt.toFixed(2)));
                    }
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    return false;
                }
            });
        }
    </script>
</asp:Content>
