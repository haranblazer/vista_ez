<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="product.aspx.cs" Inherits="product" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list">
                <li class="breadcrumb-item"><a href="default">Home</a></li>
                <li class="breadcrumb-item"><a href="#" id="lbl_CategoryTitle" runat="server"></a></li>
                <li class="breadcrumb-item active"><span id="lbl_CategoryTitle2" runat="server"></span></li>
            </ol>
        </div>
    </div>

    <div class="main-shop-page ptb-10">
        <div class="container-fluid">
            <!-- Row End -->
            <div class="row">
                <!-- Product Categorie List Start -->
                <div class="col-lg-3 ">

                    <%--<div class="category-menu">
                                    <div class="category-heading">
                                        <h2 class="categories-toggle"><span>All Categories</span></h2>
                                    </div>
                                    <div  class="category-menu-list" style="">
                                        <ul>
                                            <li class="right-menu"><a href="#" class="active"><i class="expand menu-expand"></i>Home Audio</a>
                                                <ul class="cat-mega-menu">
                                                    <li class="right-menu cat-mega-title">
                                                        <a href="#"><i class="expand menu-expand"></i>Habitant Morbi</a>
                                                        <ul >
                                                            <li><a href="shop-left-sidebar.html">Habitant Morbi</a></li>
                                                            <li><a href="shop-left-sidebar.html">Office chair</a></li>
                                                            <li><a href="shop-left-sidebar.html">Purus Lacus</a></li>
                                                            <li><a href="shop-left-sidebar.html">Sagittis Blandit</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="right-menu cat-mega-title">
                                                        <a href="#"><i class="expand menu-expand"></i>Camera &amp; Photo</a>
                                                        <ul >
                                                            <li><a href="shop-left-sidebar.html">Magna Pellentesq</a></li>
                                                            <li><a href="shop-left-sidebar.html">Molestie Tortor</a></li>
                                                            <li><a href="shop-left-sidebar.html">Vehicula Element</a></li>
                                                            <li><a href="shop-left-sidebar.html">Volutpat Diam</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="right-menu cat-mega-title">
                                                        <a href="#"><i class="expand menu-expand"></i>Digital SLRs</a>
                                                        <ul style="display: none;">
                                                            <li><a href="shop-left-sidebar.html">Bibendum Cursus</a></li>
                                                            <li><a href="shop-left-sidebar.html">Dignissim Turpis</a></li>
                                                            <li><a href="shop-left-sidebar.html">Dining room</a></li>
                                                            <li><a href="shop-left-sidebar.html">Egestas Ultricies</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li class="right-menu"><a href="#"><i class="expand menu-expand"></i>Security Cameras</a>
                                                <ul class="cat-mega-menu cat-mega-menu-2" >
                                                    <li class="right-menu cat-mega-title">
                                                        <a href="#"><i class="expand menu-expand"></i>Cameras</a>
                                                        <ul style="display: none;">
                                                            <li><a href="shop-left-sidebar.html">Cords and Cables</a></li>
                                                            <li><a href="shop-left-sidebar.html">gps accessories</a></li>
                                                            <li><a href="shop-left-sidebar.html">Microphones</a></li>
                                                            <li><a href="shop-left-sidebar.html">Wireless Transmitters</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="right-menu cat-mega-title">
                                                        <a href="#"><i class="expand menu-expand"></i>Audio</a>
                                                        <ul style="display: none;">
                                                            <li><a href="shop-left-sidebar.html">Other Accessories</a></li>
                                                            <li><a href="shop-left-sidebar.html">Portable Audio</a></li>
                                                            <li><a href="shop-left-sidebar.html">Satellite Radio</a></li>
                                                            <li><a href="shop-left-sidebar.html">Visual Accessories</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="right-menu cat-mega-title">
                                                        <a href="#"><i class="expand menu-expand"></i>Cell Phones</a>
                                                        <ul style="display: none;">
                                                            <li><a href="shop-left-sidebar.html">Xail</a></li>
                                                            <li><a href="shop-left-sidebar.html">Chamcham Galaxy</a></li>
                                                            <li><a href="shop-left-sidebar.html">SIM Cards</a></li>
                                                            <li><a href="shop-left-sidebar.html">Prepaid Cell Phones</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="right-menu cat-mega-title">
                                                        <a href="#"><i class="expand menu-expand"></i>TV &amp; Video</a>
                                                        <ul style="display: none;">
                                                            <li><a href="shop-left-sidebar.html">4K Ultra HDTVs</a></li>
                                                            <li><a href="shop-left-sidebar.html">All TVs</a></li>
                                                            <li><a href="shop-left-sidebar.html">Refurbished TVs</a></li>
                                                            <li><a href="shop-left-sidebar.html">TV Accessories</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li><a href="#">Station Consoles</a></li>
                                        </ul>
                                    </div>
                                </div>--%>
                    <div class="category-menu">
                        <div class="category-heading">
                            <h2 class="categories-toggle"><span>All Categories</span></h2>
                        </div>
                        <div class="category-menu-list" style="">
                            <div id="slide-out">
                                <div id="mobile-menu" class="nav-mobile">
                                    <div id="div_ProdCategory" runat="server" class="main-menu">
                                        <%-- <ul>
                                            <li class="menu-item-has-children has-children"><a href="#">Electronics</a>
                                                <ul class="sub-menu">
                                                    <li><a href="#">Toys & Game</a></li>
                                                    <li><a href="#">Speakers</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="#">Electronics</a></li> 
                                        </ul>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="sidebar shop-sidebar d-none">
                        <!-- Price Filter Options End -->
                        <!-- Sidebar Categorie Start -->
                        <div class="sidebar-categorie mb-30">
                            <h3 class="sidebar-title">categories</h3>
                            <ul class="sidbar-style">
                                <li class="form-check">
                                    <input class="form-check-input" value="#" id="camera" type="checkbox">
                                    <label class="form-check-label" for="camera">Cameras (8)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" id="GamePad" type="checkbox">
                                    <label class="form-check-label" for="GamePad">GamePad (8)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" id="Digital" type="checkbox">
                                    <label class="form-check-label" for="Digital">Digital Cameras (8)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" id="Virtual" type="checkbox">
                                    <label class="form-check-label" for="Virtual">Virtual Reality (8) </label>
                                </li>
                            </ul>
                        </div>
                        <!-- Sidebar Categorie Start -->
                        <!-- Product Size Start -->
                        <div class="size mb-30">
                            <h3 class="sidebar-title">size</h3>
                            <ul class="size-list sidbar-style">
                                <li class="form-check">
                                    <input class="form-check-input" value="" id="small" type="checkbox">
                                    <label class="form-check-label" for="small">S (6)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="" id="medium" type="checkbox">
                                    <label class="form-check-label" for="medium">M (9)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="" id="large" type="checkbox">
                                    <label class="form-check-label" for="large">L (8)</label>
                                </li>
                            </ul>
                        </div>
                        <!-- Product Size End -->
                        <!-- Product Color Start -->
                        <div class="color mb-30">
                            <h3 class="sidebar-title">color</h3>
                            <ul class="color-option sidbar-style">
                                <li>
                                    <span class="white"></span>
                                    <a href="#">white (4)</a>
                                </li>
                                <li>
                                    <span class="orange"></span>
                                    <a href="#">Orange (2)</a>
                                </li>
                                <li>
                                    <span class="blue"></span>
                                    <a href="#">Blue (6)</a>
                                </li>
                                <li>
                                    <span class="yellow"></span>
                                    <a href="#">Yellow (8)</a>
                                </li>
                            </ul>
                        </div>
                        <!-- Product Color End -->
                        <!-- Sidebar Categorie Start -->
                        <div class="sidebar-categorie mb-30">
                            <h3 class="sidebar-title">Components</h3>
                            <ul class="sidbar-style">
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">cotton (4)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">polyester (4)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">Viscose (5)</label>
                                </li>
                            </ul>
                        </div>
                        <!-- Sidebar Categorie Start -->
                        <!-- Sidebar Categorie Start -->
                        <div class="sidebar-categorie mb-30">
                            <h3 class="sidebar-title">Styles</h3>
                            <ul class="sidbar-style">
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">casual (5)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">dressy (2)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">girly (8)</label>
                                </li>
                            </ul>
                        </div>
                        <!-- Sidebar Categorie Start -->
                        <!-- Sidebar Categorie Start -->
                        <div class="sidebar-categorie">
                            <h3 class="sidebar-title">Properties</h3>
                            <ul class="sidbar-style">
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">colorful dress (2)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">maxi dress (2)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">midi dress (2)</label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">short dress (4) </label>
                                </li>
                                <li class="form-check">
                                    <input class="form-check-input" value="#" type="checkbox">
                                    <label class="form-check-label">short sleve (3) </label>
                                </li>
                            </ul>
                        </div>
                        <!-- Sidebar Categorie Start -->
                    </div>
                </div>


                <div class="col-lg-9 order-1 order-lg-2">
                    <!-- Grid & List View Start -->
                    <%--<div class="grid-list-top border-default universal-padding d-md-flex justify-content-md-between align-items-center mb-30">
                        <div class="grid-list-view d-flex align-items-center  mb-sm-15">
                            <ul class="nav tabs-area d-flex align-items-center" role="tablist">
                                <li><a class="active" data-bs-toggle="tab" href="#grid-view" aria-selected="true" role="tab"><i class="fa fa-th"></i></a></li>
                            </ul>
                            <span class="show-items">There are 8 products.</span>
                        </div>
                        <!-- Toolbar Short Area Start -->
                        <div class="main-toolbar-sorter clearfix">
                            <div class="toolbar-sorter d-md-flex align-items-center">
                                <label>Sort By:</label>
                                <select class="sorter wide" style="display: none;">
                                    <option value="Position">Relevance</option>
                                    <option value="Product Name">Neme, A to Z</option>
                                    <option value="Product Name">Neme, Z to A</option>
                                    <option value="Price">Price low to heigh</option>
                                    <option value="Price">Price heigh to low</option>
                                </select><div class="nice-select sorter wide" tabindex="0">
                                    <span class="current">Relevance</span><ul class="list">
                                        <li data-value="Position" class="option selected">Relevance</li>
                                        <li data-value="Product Name" class="option">Neme, A to Z</li>
                                        <li data-value="Product Name" class="option">Neme, Z to A</li>
                                        <li data-value="Price" class="option">Price low to heigh</li>
                                        <li data-value="Price" class="option">Price heigh to low</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- Toolbar Short Area End -->
                    </div>--%>
                    <!-- Grid & List View End -->
                    <div class="shop-area mb-all-40">
                        <!-- Grid & List Main Area End -->
                        <div class="tab-content">
                            <div id="grid-view" class="tab-pane fade show active" role="tabpanel">
                                <div class="border-hover-effect">
                                    <div id="div_Product" runat="server" class=" row"></div>



                                    <%--<div class="col-lg-4 col-md-4 col-sm-6 col-6"> 
                                        <div class="single-makal-product">
                                            <div class="pro-img">
                                                <a href="product_detail.aspx">
                                                    <img src="images/product/product_1.jpg" alt="product-img">
                                                </a>
                                                <span class="sticker-new">new</span>
                                                <div class="quick-view-pro">
                                                    <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                                                </div>
                                            </div>
                                            <div class="pro-content">
                                                <h4 class="pro-title">
                                                    <a href="product_detail.aspx">Modern Eye Brush</a>
                                                </h4>
                                                <p>
                                                    <span class="price">$45.50</span>
                                                </p>
                                                <div class="pro-actions">
                                                    <div class="actions-primary">
                                                        <a href="product_detail.aspx" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a>
                                                    </div>
                                                    <div class="actions-secondary">
                                                        <div class="rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> 
                                    </div>--%>


                                    <%--   <div class="col-lg-4 col-md-4 col-sm-6 col-6">
                                        <!-- Single Product Start Here -->
                                        <div class="single-makal-product">
                                            <div class="pro-img">
                                                <a href="product_detail.aspx">
                                                    <img src="images/product/product_2.jpg" alt="product-img">
                                                </a>
                                                <span class="sticker-new">new</span>
                                                <span class="sticker-sale">-5%</span>
                                                <div class="quick-view-pro">
                                                    <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                                                </div>
                                            </div>
                                            <div class="pro-content">
                                                <h4 class="pro-title">
                                                    <a href="product_detail.aspx">Modern Eye Brush</a>
                                                </h4>
                                                <p>
                                                    <span class="price">$45.50</span>
                                                </p>
                                                <div class="pro-actions">
                                                    <div class="actions-primary">
                                                        <a href="product_detail.aspx" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a>
                                                    </div>
                                                    <div class="actions-secondary">
                                                        <div class="rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Single Product End Here -->
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-6 col-6">
                                        <!-- Single Product Start Here -->
                                        <div class="single-makal-product">
                                            <div class="pro-img">
                                                <a href="product_detail.aspx">
                                                    <img src="images/product/product_3.jpg" alt="product-img">
                                                </a>
                                                <span class="sticker-new">new</span>
                                                <div class="quick-view-pro">
                                                    <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                                                </div>
                                            </div>
                                            <div class="pro-content">
                                                <h4 class="pro-title">
                                                    <a href="#">Modern Eye Brush</a>
                                                </h4>
                                                <p>
                                                    <span class="price">$45.50</span>
                                                </p>
                                                <div class="pro-actions">
                                                    <div class="actions-primary">
                                                        <a href="product_detail.aspx" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a>
                                                    </div>
                                                    <div class="actions-secondary">
                                                        <div class="rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Single Product End Here -->
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-6 col-6">
                                        <!-- Single Product Start Here -->
                                        <div class="single-makal-product">
                                            <div class="pro-img">
                                                <a href="product_detail.aspx">
                                                    <img src="images/product/product_4.jpg" alt="product-img">
                                                </a>
                                                <span class="sticker-new">new</span>
                                                <div class="quick-view-pro">
                                                    <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                                                </div>
                                            </div>
                                            <div class="pro-content">
                                                <h4 class="pro-title">
                                                    <a href="product_detail.aspx">Modern Eye Brush</a>
                                                </h4>
                                                <p>
                                                    <span class="price">$45.50</span>
                                                </p>
                                                <div class="pro-actions">
                                                    <div class="actions-primary">
                                                        <a href="product_detail.aspx" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a>
                                                    </div>
                                                    <div class="actions-secondary">
                                                        <div class="rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Single Product End Here -->
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-6 col-6">
                                        <!-- Single Product Start Here -->
                                        <div class="single-makal-product">
                                            <div class="pro-img">
                                                <a href="product_detail.aspx">
                                                    <img src="images/product/product_5.jpg" alt="product-img">
                                                </a>
                                                <span class="sticker-new">new</span>
                                                <div class="quick-view-pro">
                                                    <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                                                </div>
                                            </div>
                                            <div class="pro-content">
                                                <h4 class="pro-title">
                                                    <a href="product_detail.aspx">Modern Eye Brush</a>
                                                </h4>
                                                <p>
                                                    <span class="price">$45.50</span>
                                                </p>
                                                <div class="pro-actions">
                                                    <div class="actions-primary">
                                                        <a href="product_detail.aspx" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a>
                                                    </div>
                                                    <div class="actions-secondary">
                                                        <div class="rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Single Product End Here -->
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-6 col-6">
                                        <!-- Single Product Start Here -->
                                        <div class="single-makal-product">
                                            <div class="pro-img">
                                                <a href="product_detail.aspx">
                                                    <img src="images/product/product_6.jpg" alt="product-img">
                                                </a>
                                                <span class="sticker-new">new</span>
                                                <div class="quick-view-pro">
                                                    <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="#"></a>
                                                </div>
                                            </div>
                                            <div class="pro-content">
                                                <h4 class="pro-title">
                                                    <a href="product_detail.aspx">Modern Eye Brush</a>
                                                </h4>
                                                <p>
                                                    <span class="price">$45.50</span>
                                                </p>
                                                <div class="pro-actions">
                                                    <div class="actions-primary">
                                                        <a href="product_detail.aspx" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a>
                                                    </div>
                                                    <div class="actions-secondary">
                                                        <div class="rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Single Product End Here -->
                                    </div>--%>
                                </div>
                                <!-- Row End -->
                            </div>

                        </div>
                        <!-- Grid & List Main Area End -->
                    </div>
                    <!-- Shop Breadcrumb Area Start -->
                    <%--<div class="shop-breadcrumb-area border-default mt-30">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-5">
                                <span class="show-items">Showing 1-12 of 13 item(s) </span>
                            </div>
                            <div class="col-lg-8 col-md-8 col-sm-7">
                                <ul class="pfolio-breadcrumb-list text-center">
                                    <li class="float-left prev"><a href="#"><i class="fa fa-angle-left" aria-hidden="true"></i>Previous</a></li>
                                    <li class="active"><a href="#">1</a></li>
                                    <li><a href="#">2</a></li>
                                    <li class="float-right next"><a href="#">Next<i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>--%>
                    <!-- Shop Breadcrumb Area End -->
                </div>
                <!-- product Categorie List End -->
            </div>
            <!-- Row End -->
        </div>
        <!-- Container End -->
    </div>






    <%-- <div class="d-none">
        <div class="page_header_content"> 
            <asp:Image ID="Img_Banner" runat="server" Style="width: 100%" /> 
        </div>
    </div>

    
    <!-- Services Section -->
    <section class="home-services-section pt-2 pb-4 d-none">
        <div class="container">
            <div class="blocks-column">
                <div class="inner-column">
                    <ul id="div_category" runat="server" class="product align-items-center"> </ul>
                </div>
            </div>
        </div>
    </section>--%>
    <!-- End Services Section -->
    <%--  <div class="container"> 
        <div class="col-md-4" style="display: none;">
            <a href="Cart" class="cart fa fa-3x fa-shopping-cart" style="display: block;"></a>
            <span class="cart-data">0</span>
        </div>
    </div>--%>
    <!-- Product-tab-box End -->

    <asp:HiddenField ID="hdn_CatId" runat="server" Value="0" />
    <asp:HiddenField ID="hdn_SubCatId" runat="server" Value="0" />
    <script src="datepick/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
        var URL = "Service.aspx";
        $(function () {
            //BindProduct();
            GetCount();
        });



        function BindProduct() {
            let CatId = $('#<%=hdn_CatId.ClientID%>').val();
            let SubCatId = $('#<%=hdn_SubCatId.ClientID%>').val()
            $.ajax({
                type: "POST",
                url: 'product.aspx/BindProduct',
                data: '{CatId: "' + CatId + '", SubCatId: "' + SubCatId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var tbl = "";
                    for (var i = 0; i < data.d.length; i++) {
                        tbl += '<div class="col-lg-4 col-md-4 col-sm-6 col-6">';
                        tbl += '<div class="single-makal-product">';
                        tbl += '<div class="pro-img"> <a href="p?' + data.d[i].Qury_product + '">  <img src="Productimage/' + data.d[i].ImageName + '" alt="product-img"> </a>';
                        tbl += '<span class="sticker-new">new</span>';
                        tbl += '<div class="quick-view-pro"> <a data-bs-toggle="modal" data-bs-target="#product-window" class="quick-view" href="javascript:void(0)"></a> </div>';
                        tbl += '</div>';
                        tbl += '<div class="pro-content">';
                        tbl += '<h4 class="pro-title"> <a href="p?' + data.d[i].Qury_product + '">' + data.d[i].pname + '</a> </h4>';
                        tbl += '<span class="product-item_code">Item Code: ' + data.d[i].Pcode + '</span>';
                        tbl += '<span class="product-qty">' + data.d[i].PackSizeName + ' </span>';



                        tbl += '<div class="pro-actions">';
                        tbl += '<div class="actions-secondary"> <span class="price">MRP. ' + data.d[i].MRP + '</span> </div>';
                        tbl += '<div class="actions-primary">';
                        tbl += '<a href="javascript:void(0)" onclick="AddToCart(' + data.d[i].batchid + ')" class="add-to-cart" data-toggle="tooltip" data-original-title="Add to Cart">Add To Cart</a> ';
                        tbl += '</div>';

                        tbl += '</div>';
                        tbl += '</div>';
                        tbl += '</div>';
                        tbl += '</div>';
                    }
                    $('#<%=div_Product.ClientID%>').html(tbl);
                    if (data.d.length == 0) {
                        $('#<%=div_Product.ClientID%>').html('No data found.');
                        return false;
                    }
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    return false;
                }
            });
        }


        function AddToCart(Batchid) {
            $.ajax({
                type: "POST",
                url: URL + '/AddProduct',
                data: '{Batchid: "' + Batchid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) { 
                    $('#AddCart_' + Batchid).text('Added to Cart'); 
                    $('#AddCart_' + Batchid).removeClass('add-to-cart');
                    $('#AddCart_' + Batchid).addClass('added-to-cart');

                    GetCount();
                    ShowSuccess();
                    HideSuccess();
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


        //function GetCount() {
        //    $.ajax({
        //        type: "POST",
        //        url: URL + '/GetCount',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (data) {
        //            $('#lbl_MasterCartCount').text(data.d);
        //            $('.cart-data').text(data.d);
        //            BindMasterCartTable();
        //        },
        //        error: function (response) { }
        //    });
        //}

        //function BindMasterCartTable() {
        //    $.ajax({
        //        type: "POST",
        //        url: URL + '/GetCartData',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (data) {
        //            var TotalAmount = 0, Gross = 0, GSTAMT = 0;
        //            var tbl = "";
        //            for (var i = 0; i < data.d.length; i++) {
        //                TotalAmount = TotalAmount + parseFloat(data.d[i].totalamt);
        //                Gross = Gross + parseFloat(data.d[i].Gross);
        //                GSTAMT = GSTAMT + parseFloat(data.d[i].GSTAMT);

        //                tbl += '<div class="single-cart-box">';
        //                tbl += '<div class="cart-img">';
        //                tbl += '<a href="javascript:void(0)"> <img src="../ProductImage/' + data.d[i].image + '" alt="cart-image"> </a>';
        //                tbl += '<span class="pro-quantity">' + data.d[i].qty + 'X</span>';
        //                tbl += '</div>';
        //                tbl += '<div class="cart-content">';
        //                tbl += '<h6> <a href="javascript:void(0)">' + data.d[i].pname + '</a> </h6>';
        //                tbl += '<span class="cart-price">' + data.d[i].DPWithTax.toFixed(2) + '</span>';
        //                tbl += '</div>';
        //                tbl += '<a class="del-icone" href="javascript:void(0)"> <i class="ion-close"></i> </a>';
        //                tbl += '</div>';
        //            }
        //            let FooterStr = '';


        //            FooterStr += '<div class="cart-footer">';
        //            FooterStr += '<ul class="price-content">';
        //            FooterStr += '<li>Subtotal <span>' + parseFloat(Gross.toFixed(2)) +'</span> </li>';
        //            FooterStr += '<li>Taxes <span>' + parseFloat(GSTAMT.toFixed(2)) +'</span> </li>';
        //            FooterStr += '<li>Total <span>' + parseFloat(TotalAmount.toFixed(2)) +'</span> </li>';
        //            FooterStr += '</ul>';
        //            FooterStr += '<div class="cart-actions text-center"> <a class="cart-checkout" href="cart">Checkout</a> </div>';
        //            FooterStr += '</div>';
        //            tbl += FooterStr;
        //            $('#div_Master_Cart_table').empty().append(tbl);
        //            if (data.d.length == 0) {
        //                $('#div_Master_Cart_table').empty().append('Your cart is empty...');
        //                return false;
        //            }
        //        },
        //        error: function (data) {
        //            alert("Server error. Time out.!!");
        //            return false;
        //        }
        //    });
        //}
    </script>

    <script>
        const list = document.querySelectorAll('.list');

        function accordion(e) {
            e.stopPropagation();
            if (this.classList.contains('active')) {
                this.classList.remove('active');
            }
            else if (this.parentElement.parentElement.classList.contains('active')) {
                this.classList.add('active');
            }
            else {
                for (i = 0; i < list.length; i++) {
                    list[i].classList.remove('active');
                }
                this.classList.add('active');
            }
        }
        for (i = 0; i < list.length; i++) {
            list[i].addEventListener('click', accordion);
        }

    </script>
    <style>
        .service-block.active {
            background: #002e9e;
            color: #ffffff;
        }

            .service-block.active h5 a {
                color: #ffffff;
            }

        .product li {
            display: inline-block;
            margin-left: 10px;
        }





        .service-block.active {
            background: #002e9e;
            color: #ffffff;
        }

            .service-block.active h5 a {
                color: #ffffff;
            }

        .product li {
            display: inline-block;
            margin-left: 10px;
        }
    </style>
    <script>

        jQuery(function ($) {

            var mobileItems = jQuery('.nav-mobile .main-menu');
            mobileItems.find('li.menu-item-has-children').append('<i class="mobile-arrows fa fa-chevron-down"></i>');
            jQuery(".nav-mobile .main-menu li.menu-item-has-children i.mobile-arrows").click(function () {
                if (jQuery(this).hasClass("fa-chevron-down"))
                    jQuery(this).removeClass("fa-chevron-down").addClass("fa-chevron-up");
                else
                    jQuery(this).removeClass("fa-chevron-up").addClass("fa-chevron-down");

                jQuery(this).parent().find('ul:first').slideToggle(300);
                jQuery(this).parent().find('> .mobile-arrows').toggleClass('is-open');
            });

        });
    </script>
</asp:Content>
