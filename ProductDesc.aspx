<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="productdesc.aspx.cs" Inherits="product_detail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/product_style.css?v=0.1" rel="stylesheet" />
    <style>
        .added-to-cart {
            background: #228704 !important;
            border: .3px solid #000;
    color: #fff;
    font-size: 16px;
    font-family: inherit;
    font-weight: inherit;
    font-style: inherit;
    line-height: 1em;
    height: auto;
    margin: 0;
    text-decoration: none !important;
    cursor: pointer;
    padding: 1.2em 25px;
    vertical-align: middle;
    text-align: center;
    border-radius: 3px;
    transition: background-color .1s, color .1s, border-color .1s, opacity .1s;
    display: inline-block;
    font-family: Futura, sans-serif;
    font-weight: 400;
    font-style: normal;
    letter-spacing: .08em;
    text-transform: uppercase;
    -webkit-tap-highlight-color: transparent;
        }
    </style>
    <div class="testmonial header_cat ptb-90 d-none">
        <div class="container">
            <div class="text-center">
                <h2 id="lbl_CategoryTitle" runat="server"></h2>
                <div class="bread-crumb">
                    <span id="lbl_CategoryTitle2" runat="server"></span>
                </div>
            </div>
        </div>
    </div>


    <div class="container-fluid">

        <div class="row border-bottom">
            <div class="col-md-6 p-0">
                <div class="watchBackground col-md-6">

                    <div id="div_Wishlist" runat="server"><i class="fa fa-heart-o"></i></div>
                    <img id="img_Main" runat="server" src="" alt="" class="product" style="display: none;" />

                    <div id='carousel-custom' class='carousel slide' data-ride='true'>
                        <div class='carousel-outer'>
                            <div class='carousel-inner' id="div_MultiBigImg" runat="server">
                            </div>
                            <!-- sag sol -->
                            <a class='left carousel-control' href='#carousel-custom' data-slide='prev'>
                                <span class='fa fa-chevron-left'></span>
                            </a>
                            <a class='right carousel-control' href='#carousel-custom' data-slide='next'>
                                <span class='fa fa-chevron-right'></span>
                            </a>
                        </div>

                        <!-- thumb -->

                        <ol class='carousel-indicators mCustomScrollbar meartlab' id="div_MultiProdScrollImg" runat="server"></ol>
                    </div>

                </div>
            </div>
            <div class="col-md-6 p-0">
                <div class="info">
                    <div class="watchName">

                        <div>
                            <h1 class="big">
                                <asp:Literal ID="lbl_ProdName" runat="server"></asp:Literal>
                            </h1>
                            <span class="new"><span id="div_PackSize" runat="server"></span></span>
                        </div>
                        <h2 class="small">
                            <asp:Literal ID="lbl_ProdName2" runat="server"></asp:Literal>
                        </h2>
                        <div>
                            <div class="clearfix"></div>
                            Item Code : <span class="new"><span id="lbl_ItemCode" runat="server"></span></span>
                        </div>
                    </div>
                    <div class="buy-price">
                        <div class="price">
                            <h1 class="d-none">
                                <s>Rs.
                                    <asp:Literal ID="lbl_CrossMRP" runat="server"></asp:Literal></s>
                            </h1>

                            <h1>Rs.
                                <asp:Literal ID="lbl_MRP" runat="server"></asp:Literal>
                                <br />
                                <small>*inclusive of taxes</small>
                            </h1>
                        </div>
                    </div>
                    <div id="div_gif" runat="server" class="benefits__list"></div>
                    <br>
                    <div class="productDescription not-in-quickbuy">
                        <div class="product-description rte cf">
                            <span id="lbl_Desc_Eng" runat="server"></span>
                        </div>
                    </div>

                    <span id="div_Add_Link" runat="server"></span>

                    <div id="dic_Size_Disp" runat="server" visible="false" class="product-size mtb-30 clearfix">
                        <label>Size</label>
                        <asp:DropDownList ID="ddl_SZId" runat="server" CssClass="form-control" onchange="BindColor()">
                        </asp:DropDownList>
                    </div>
                    <div id="dic_Color_Disp" runat="server" visible="false" class="color clearfix mtb-30">
                        <label>color</label>
                        <div id="div_ColorBind" runat="server"></div>
                    </div>

                    <br />
                    <span id="div_AddBtn" runat="server"></span>
                    <%--Manufacture Details--%>
                    <div runat="server" id="div_PT2"></div>
                    <div runat="server" id="div_PT3"></div>
                    <div runat="server" id="div_PT4"></div>
                    <div runat="server" id="div_PT5"></div>
                    <div runat="server" id="div_ProdDetails">
                        <%--  <div class="nm product-detail-accordion">
                        <div class="cc-accordion cc-initialized" data-allow-multi-open="true">
                            <details class="cc-accordion-item">
                                <summary class="cc-accordion-item__title">Product Details</summary>
                                <div class="cc-accordion-item__panel">
                                    <div class="cc-accordion-item__content rte cf">
                                        <p></p>
                                        <p>Good for - addressing visible aspects of skin aging, firming, pore refining, healing, repair and to maintain healthy-looking skin</p>
                                       
                                    </div>
                                </div>
                            </details>
                        </div>
                    </div>--%>
                    </div>

                    <%--  <div class="nm product-detail-accordion not-in-quickbuy">
                        <div class="cc-accordion cc-initialized" data-allow-multi-open="true">
                            <details class="cc-accordion-item">
                                <summary class="cc-accordion-item__title">Ingredients &amp; Facts</summary>
                                <div class="cc-accordion-item__panel">
                                    <div class="cc-accordion-item__content rte cf">
                                        <p><b>Full of List </b>- The Most Advanced Peptide Complex, Methyl-Glucoside-6-Phosphate, Copper Tripeptides, Antioxidant Gallic Acid,  17 Amino Acids, Probiotic Yeast, Silanetrol delivered Hyaluronic Acid, Biotechnology-derived Guava leaves from Jeju Island</p>
                                    </div>
                                </div>
                            </details>
                        </div>
                    </div>--%>

                    <div id="div_DescriptionTab" style="display: none;" runat="server"></div>

                </div>
            </div>
        </div>

        <div class="row border-bottom d-none">
            <div class="col-md-12">
                <div class="marque-slider-pro item slick-initialized slick-slider">
                    <marquee scrollamount="15">
                        <p id="div_TitleScroll" runat="server"></p>
                    </marquee>
                </div>
            </div>
        </div>

    </div>


    <div class="container-fluid d-none">
        <div class="row border-top">
            <div class="col-md-12">
                <div class="panel ptb-40">
                    <div class="subtitle align-center">
                        <h2>KEY INGREDIENTS</h2>
                        <p id="div_INGREDIENTS_Title" runat="server"></p>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid d-none">
        <div class="border-top">
            <div class="ingredients_blocks row" id="div_KEY_INGREDIENTS" runat="server"></div>
        </div>
    </div>
    <div class="container-fluid mt-10">
        <div class="row">
            <div class="col-md-12">
                <asp:Image ID="img_EffectResultImg" runat="server" ImageUrl="#" Width="100%" />
            </div>
        </div>
    </div>

    <!-- Related Products Start -->
    <div class="section section-padding pt-0 products" style="display: none;">
        <div class="container">
            <div class="section-title-wrap section-header flex-header" style="padding: 10px 0;">
                <div class="section-title-text">
                    <h2 class="title" style="color: #fe6a00;">Related Products</h2>
                </div>
                <div class="acr-arrows primary-arrows">
                    <i class="slider-prev fa fa-chevron-left slick-arrow"></i><i class="slider-next fa fa-chevron-right slick-arrow"></i>
                </div>
            </div>
            <div id="div_RelatedProduct" runat="server" class="products-slider"></div>
        </div>
    </div>
    <!-- Related Products End -->

    <!-- Related Products Start -->
    <div class="section section-padding pt-0 products" style="display: none;">
        <div class="container">
            <div class="section-title-wrap section-header flex-header" style="padding: 10px 0;">
                <div class="section-title-text">
                    <h2 class="title" style="color: #fe6a00;">Trending Products</h2>
                </div>
                <div class="acr-arrows primary-arrows">
                    <i class="slider-prev fa fa-chevron-left slick-arrow"></i><i class="slider-next fa fa-chevron-right slick-arrow"></i>
                </div>
            </div>
            <div id="div_TrendingProduct" runat="server" class="products-slider"></div>
        </div>
    </div>
    <!-- Related Products End -->

    <asp:HiddenField ID="hnd_CLRId" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_PId" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_Batchid" runat="server" Value="0" />
    <script src="datepick/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
        var URL = "Service.aspx";
        $(function () {
            GetCount();
            BindSizeColor();
        });


        function SelectColor(CLRId) {
            $('#<%=hnd_CLRId.ClientID%>').val(CLRId);
            BindSizeColor();
        }


        function BindSizeColor() {

            let SZId = $('#<%=ddl_SZId.ClientID%>').val();
            let CLRId = $('#<%=hnd_CLRId.ClientID%>').val();
            SZId = parseInt((SZId == '' || SZId == null || isNaN(parseInt(SZId))) ? 0 : SZId);
            CLRId = parseInt((CLRId == '' || CLRId == null || isNaN(parseInt(CLRId))) ? 0 : CLRId);

            if (SZId > 0 || CLRId > 0) {
                let PId = $('#<%=hnd_PId.ClientID%>').val();
                 $.ajax({
                     type: "POST",
                     url: 'productdesc.aspx/BindSizeColor',
                     data: '{PId: "' + PId + '", SZId: "' + SZId + '", CLRId: "' + CLRId + '"}',
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (data) {
                         $('#<%=lbl_MRP.ClientID%>').text(data.d.MRP);
                        $('#<%=hnd_Batchid.ClientID%>').val(data.d.Batchid);
                        if (parseInt(data.d.balqty) <= 0) {
                            $('#<%=div_AddBtn.ClientID%>').InnerHtml = "<a href='javascript:void(0)' class='btn-submit disabled'><i class='fa fa-shopping-cart'></i>Out of Stock</a>";
                        }
                        else {
                            $('#<%=div_AddBtn.ClientID%>').InnerHtml = "<a href='javascript:void(0)' onclick='AddToCart()' class='btn add_to_cart btn-block'>Add to Cart</a>";
                        }

                        let MultiBigImg = "", MultiProdScrollImg = "";
                        let count = 1;
                        if (data.d.ImageName != "") {
                            let ImageMain = data.d.ImageName.split("~");
                            for (var i = 0; i < ImageMain.length; i++) {
                                let ImageSub = ImageMain[i].split("^");
                                if (ImageSub.length > 0) {
                                    if (ImageSub[0] == "1") {
                                        MultiBigImg += "<div class='item active'> <img src='Productimage/" + ImageSub[1] + "'/>  </div> ";
                                        MultiProdScrollImg += "<li data-target='#carousel-custom' data-slide-to='0' class='active'> <img src='Productimage/" + ImageSub[1] + "' alt='' /></li>";
                                    }
                                    else {
                                        MultiBigImg += "<div class='item'> <img src='Productimage/" + ImageSub[1] + "' /> </div>";
                                        MultiProdScrollImg += "<li data-target='#carousel-custom' data-slide-to='" + count + "'> <img src='Productimage/" + ImageSub[1] + "' alt='' /> </li>";
                                        count = count + 1;
                                    }
                                }
                            }
                        }
                        else {
                            if (MultiBigImg == "") {
                                MultiBigImg += "<div class='item active'> <img src='Productimage/no-image.jpg'/>  </div> ";
                                MultiProdScrollImg += "<li data-target='#carousel-custom' data-slide-to='0' class='active'> <img src='Productimage/no-image.jpg' alt='' /></li>";
                            }
                        }

                        $('#<%=div_MultiBigImg.ClientID%>').html(MultiBigImg);
                        $('#<%=div_MultiProdScrollImg.ClientID%>').html(MultiProdScrollImg);
                    },
                    error: function (data) { }
                });

            }
        }
        <%--function BindSizeColor() {
          
            let SZId = $('#<%=ddl_SZId.ClientID%>').val();
            let CLRId = $('#<%=hnd_CLRId.ClientID%>').val();
            SZId = parseInt((SZId == '' || SZId == null || isNaN(parseInt(SZId))) ? 0 : SZId);
            CLRId = parseInt((CLRId == '' || CLRId == null || isNaN(parseInt(CLRId))) ? 0 : CLRId);

            let PId = $('#<%=hnd_PId.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: 'productdesc.aspx/BindSizeColor',
                data: '{PId: "' + PId + '", SZId: "' + SZId + '", CLRId: "' + CLRId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#<%=lbl_MRP.ClientID%>').val(data.d.MRP);
                    $('#<%=hnd_Batchid.ClientID%>').val(data.d.Batchid);
                    if (parseInt(data.d.balqty) <= 0) {
                        $('#<%=div_AddBtn.ClientID%>').InnerHtml = "<a href='javascript:void(0)' class='btn-submit disabled'><i class='fa fa-shopping-cart'></i>Out of Stock</a>";
                    }
                    else {
                        $('#<%=div_AddBtn.ClientID%>').InnerHtml = "<a href='javascript:void(0)' onclick='AddToCart()' class='btn add_to_cart btn-block'>Add to Cart</a>";
                    }
                },
                error: function (data) { }
            });

        }--%>


        function BindColor() {

            let SZId = $('#<%=ddl_SZId.ClientID%>').val();
            SZId = parseInt((SZId == '' || SZId == null || isNaN(parseInt(SZId))) ? 0 : SZId);

            let PId = $('#<%=hnd_PId.ClientID%>').val();
           // $("#<%=div_ColorBind.ClientID %>").empty().append($("<option></option>").val(0).html('No Size'));
            $.ajax({
                type: "POST",
                url: 'productdesc.aspx/BindColor',
                data: '{PId: "' + PId + '", SZId: "' + SZId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        let Count = 0;
                        let StrColor = "";
                        $.each(data.d, function () {
                            if (Count == 0) {
                                $('#<%=hnd_CLRId.ClientID%>').val(this['Value']);
                                StrColor += "<input name='1' value='" + this['Value'] + "' onclick='SelectColor(" + this['Value'] + ")' type='radio' class='strong-aggree' style='background:" + this['Text'] + ";' checked />";
                            }
                            else {
                                StrColor += "<input name='1' value='" + this['Value'] + "' onclick='SelectColor(" + this['Value'] + ")' type='radio' class='strong-aggree' style='background:" + this['Text'] + ";' />";
                            }
                            Count = 1;
                        });
                        $('#<%=div_ColorBind.ClientID%>').html(StrColor);
                        if (Count == 1) { BindSizeColor(); }
                    }
                },
                error: function (data) { }
            });
        }

       <%-- function BindColor() {
          
            let SZId = $('#<%=ddl_SZId.ClientID%>').val();
            SZId = parseInt((SZId == '' || SZId == null || isNaN(parseInt(SZId))) ? 0 : SZId);  

            let PId = $('#<%=hnd_PId.ClientID%>').val(); 
           // $("#<%=div_ColorBind.ClientID %>").empty().append($("<option></option>").val(0).html('No Size'));
            $.ajax({
                type: "POST",
                url: 'productdesc.aspx/BindColor',
                data: '{PId: "' + PId + '", SZId: "' + SZId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        let Count = 0;
                        let StrColor = "";
                        $.each(data.d, function () {
                            if (Count == 0) {
                                $('#<%=hnd_CLRId.ClientID%>').val(this['Value']);
                                StrColor += "<input name='1' value='" + this['Value'] + "' onclick='SelectColor(" + this['Value'] + ")' type='radio' class='strong-aggree' style='background:" + this['Text'] + ";' checked />";
                            }
                            else {
                                StrColor += "<input name='1' value='" + this['Value'] + "' onclick='SelectColor(" + this['Value'] + ")' type='radio' class='strong-aggree' style='background:" + this['Text'] + ";' />";
                            }
                            Count = 1;
                        });
                        $('#<%=div_ColorBind.ClientID%>').html(StrColor);
                        if (Count == 1) { BindSizeColor(); }
                    }
                },
                error: function (data) { }
            });
        }--%>





        function AddToCart() {
            var batchid = $('#<%=hnd_Batchid.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: URL + '/AddProduct',
                data: '{Batchid: "' + batchid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#AddCart_' + batchid).text('Added to Cart');
                    $('#AddCart_' + batchid).removeClass('add-to-cart');
                    $('#AddCart_' + batchid).addClass('added-to-cart');

                    ShowSuccess();
                    HideSuccess();
                    GetCount();
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
                    /// BindMasterCartTable();
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


        function GetCountWishList() {
            $.ajax({
                type: "POST",
                url: URL + '/GetCountWishList',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) { $('#lbl_MasterWishList').text(data.d); },
                error: function (response) { }
            });
        }



        //function BindMasterCartTable() {
        //    $.ajax({
        //        type: "POST",
        //        url: URL + '/GetCartData',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (data) {
        //            $('#div_Master_Cart').empty();
        //            var NetAmt = 0;
        //            var tbl = "";
        //            for (var i = 0; i < data.d.length; i++) {
        //                NetAmt = NetAmt + parseFloat(data.d[i].totalamt);

        //                tbl += '<li class="cart-item">';
        //                tbl += '<div class="img"> <img src="../ProductImage/' + data.d[i].image + '" alt="img"> </div>';
        //                tbl += '<div class="content">';
        //                tbl += '<h5><a href="javascript:void(0)>' + data.d[i].pname + '</a></h5>';
        //                tbl += '<p>' + data.d[i].qty + ' x ' + data.d[i].DPAmt.toFixed(4) + '</p>';
        //                tbl += '</div>';
        //                tbl += '</li>'; 
        //            }
        //            $('#div_Master_Cart').append(tbl);
        //            if (data.d.length == 0) {
        //                $('#lbl_MasterTotal').text(parseFloat(0.00));
        //                return false;
        //            }
        //            if (data.d.length > 0) {
        //                $('#lbl_MasterTotal').text(parseFloat(NetAmt.toFixed(2)));
        //            }
        //        },
        //        error: function (data) {
        //            alert("Server error. Time out.!!");
        //            return false;
        //        }
        //    });
        //}






        function Eng_Hin() {
            if ($('#lbl_Eng_Hin').text() == "हिन्दी") {
                $('#div_Desc_Eng').hide();
                $('#div_Desc_Hin').show();
                $('#lbl_Eng_Hin').text("Eng");
            }
            else {
                $('#div_Desc_Eng').show();
                $('#div_Desc_Hin').hide();
                $('#lbl_Eng_Hin').text('हिन्दी');
            }
        }



        $(".js-GetImage a").click(function (element) {
            var srcElement = $(this);
        });


    </script>



    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <style>
        .strong-aggree {
            border-radius: 50%;
            border: 1px solid #d3c9c9;
            cursor: pointer;
            font: inherit;
            height: 2em;
            outline: none;
            width: 2em;
            -moz-appearance: none;
            -webkit-appearance: none;
        }

            .strong-aggree:checked:after {
                -webkit-transition: background .15s, box-shadow .1s;
                transition: background .15s, box-shadow .1s;
                position: absolute;
                content: "\f00c";
                color: #e1d8d8;
                -moz-osx-font-smoothing: grayscale;
                font: normal normal normal 20px/1 FontAwesome;
                text-rendering: auto;
                -moz-osx-font-smoothing: grayscale;
                padding: 6px;
            }

        video {
            width: 100%;
            height: 100%;
            min-height: 0px;
        }

        .fade:not(.show) {
            opacity: 1;
            background: #7c79798f;
        }

        .carousel-inner {
            position: relative;
            width: 100%;
            /* min-height: 400px;*/
        }

        .carousel-control.right {
            right: 0;
            left: auto;
            background-image: none !important;
            background-repeat: repeat-x;
            top: 50%;
            height: 0px;
        }

        .carousel-control.left {
            left: 0;
            right: auto;
            background-image: none !important;
            background-repeat: repeat-x;
            top: 50%;
            height: 0px;
        }

        .carousel-control {
            color: #000;
        }

        #carousel-example-generic {
            margin: 20px auto;
            width: 100%;
        }

        #carousel-custom {
            margin: 5px;
            /*width: 400px;*/
        }

            #carousel-custom .carousel-indicators {
                margin: 10px 0 0;
                overflow: auto;
                position: static;
                text-align: left;
                white-space: nowrap;
                width: 100%;
                overflow: hidden;
            }

                #carousel-custom .carousel-indicators li {
                    background-color: transparent;
                    -webkit-border-radius: 0;
                    border-radius: 0;
                    display: inline-block;
                    height: auto;
                    margin: 0 !important;
                    width: auto;
                }

                    #carousel-custom .carousel-indicators li img {
                        display: block;
                        opacity: 0.5;
                    }

                    #carousel-custom .carousel-indicators li.active img {
                        opacity: 1;
                    }

                    #carousel-custom .carousel-indicators li:hover img {
                        opacity: 0.75;
                    }

            #carousel-custom .carousel-outer {
                position: relative;
            }

        .carousel-indicators li img {
            height: 66px !important;
            width: 52px !important
        }

        .price h2 {
            line-height: 1;
            color: #a7a4a4;
            font-size: 24px;
            font-weight: 500;
            margin-left: 5px;
        }

        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            color: #000000;
            background-color: #eff3ff;
            border-color: #dee2e6 #dee2e6 #fff;
        }

        .watchBackground {
            width: 80%;
        }

        .slide::before {
            background: rgb(255 255 255 / 0%) none repeat scroll 0 0;
        }

        @media(max-width: 749px) {
            .watchBackground {
                width: 100%;
            }
        }

        .btn-submit:hover {
            background-color: #002c99;
            color: #fff;
        }

        .service-block.active {
            background: #ff0041;
            color: #ffffff;
        }

        .service-block h5 a {
            position: relative;
            /* color: #ffffff;*/
        }

        .service-block.active a {
            color: white;
        }

        .product li {
            display: inline-block;
            margin-left: 10px;
        }

        ol, ul {
            padding-left: 0rem;
        }

        .carousel-inner > .item > a > img, .carousel-inner > .item > img {
            line-height: 1;
            width: 100%;
        }

        .product-description {
            max-height: 325px;
            overflow-y: scroll;
            flex-flow: nowrap;
            margin-bottom: 0px !important;
            text-align: justify;
        }
    </style>

</asp:Content>
