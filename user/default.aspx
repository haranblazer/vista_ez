<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .acr-category-body {
            padding: 10px 0px 5px 10px;
        }
    </style>
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators" id="div_Slidercount" runat="server"></ol>
        <!-- Wrapper for slides -->
        <div class="carousel-inner" id="DivSlider" runat="server"></div>
    </div>

    <div class="section section-padding orange-bg pt-4">
        <div class="container">
            <br />
            <br />
            <div class="row">
                <div class="col-lg-4">
                    <article class="post">
                        <div class="post-thumbnail">
                            <a href="#">
                                <img src="images/home/overseas.jpg"></a>
                        </div>
                        <div class="post-body">
                            <h5 class="post-title"><a href="#">Overview</a></h5>
                            <p class="post-text">
                                We are a leading, direct selling company reintroducing ancient Ayurved and natural concepts in the most advanced form.
                            </p>
                            <div class="post-controls float-right">
                                <a href="#" data-toggle="modal" data-target="#quickViewModal">Read More...</a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </article>
                </div>
                <div class="col-lg-4">
                    <article class="post">
                        <div class="post-thumbnail">
                            <a href="#">
                                <img src="images/home/direct-selling-business.jpg"></a>
                        </div>
                        <div class="post-body">
                            <h5 class="post-title"><a href="#">Direct Selling Business</a></h5>
                            <p class="post-text">
                                Direct selling is selling the product directly to users; where users may be the direct selling associates or people referred 
                            </p>
                            <div class="post-controls float-right">
                                <a href="#" data-toggle="modal" data-target="#selling-business">Read More... </a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </article>
                </div>
                <div class="col-lg-4">
                    <article class="post">
                        <div class="post-thumbnail">
                            <a href="#">
                                <img src="images/home/direct-selling-company.jpg"></a>
                        </div>
                        <div class="post-body">
                            <h5 class="post-title"><a href="#">Selection of appropriate Direct Selling Company</a> </h5>
                            <p class="post-text">
                                Direct selling opportunity mostly knocks through direct contacts  
                            </p>
                            <div class="post-controls float-right">
                                <a href="#" data-toggle="modal" data-target="#direct-selling-company">Read More...</a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </article>
                </div>
                <div class="col-lg-4">
                    <article class="post">
                        <div class="post-thumbnail">
                            <a href="#">
                                <img src="images/home/direct-selling-associate.jpg"></a>
                        </div>
                        <div class="post-body">
                            <h5 class="post-title"><a href="#">Career path of Direct Selling Associate</a> </h5>
                            <p class="post-text">
                                A journey of financial freedom & personal excellence:
                            </p>
                            <div class="post-controls float-right">
                                <a href="#" data-toggle="modal" data-target="#direct-selling-associate">Read More...</a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </article>
                </div>
                <div class="col-lg-4">
                    <article class="post">
                        <div class="post-thumbnail">
                            <a href="#">
                                <img src="images/home/why-toptime.jpg"></a>
                        </div>
                        <div class="post-body">
                            <h5 class="post-title"><a href="#">Why Toptime?</a></h5>
                            <p class="post-text">
                                We follow the vision of Deltas Group established in 1985; and the commitment to take Advance Ayurved
                            </p>
                            <div class="post-controls float-right">
                                <a href="#" data-toggle="modal" data-target="#why-toptime">Read More...</a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </article>
                </div>
                <div class="col-lg-4">
                    <article class="post">
                        <div class="post-thumbnail">
                            <a href="#">
                                <img src="images/home/toptime-profile.jpg"></a>
                        </div>
                        <div class="post-body">
                            <h5 class="post-title"><a href="#">Toptime Profile</a> </h5>
                            <p class="post-text">
                                Direct selling business was the most favourable business for Deltas Group, due to its vision of taking the Advance Ayurved 
                            </p>
                            <div class="post-controls float-right">
                                <a href="#" data-toggle="modal" data-target="#toptime-profile">Read More...</a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </article>
                </div>
            </div>
        </div>
    </div>
    <!-- Banner End -->
    <!-- Categories Start -->
    <div class="section section-padding">
        <div class="container">
            <div class="section-title-wrap section-header pt-0">
                <h5 class="custom-secondary">Categories</h5>
                <h2 class="title">Browse By Category</h2>
            </div>
            <div class="row ">
                <div class="col-lg-4 col-md-6">
                    <div class="acr-category">
                        <div class="acr-category-thumb">
                            <a href="products?Wellness">
                                <img src="images/home/wellness.jpg"></a>
                            <div class="acr-category-body">
                                <h5>
                                    <a href="products?Wellness">
                                        <img src="images/home/wellness.png" width="60px" />
                                        Wellness </a>
                                </h5>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="acr-category">
                        <div class="acr-category-thumb">
                            <a href="products?Healthcare">
                                <img src="images/home/healthcare.jpg"></a>
                            <div class="acr-category-body">
                                <h5><a href="products?Healthcare">
                                    <img src="images/home/healthcare.png" width="60px" />
                                    Healthcare</a></h5>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="acr-category">
                        <div class="acr-category-thumb">
                            <a href="products?Personalcare">
                                <img src="images/home/personalcare.jpg"></a>
                            <div class="acr-category-body">
                                <h5>
                                    <a href="products?Personalcare">
                                        <img src="images/home/personalcare.png" width="60px" />
                                        Personalcare</a>
                                </h5>
                                <!--<span>221 Indoor & Outdoor Furniture   </span>-->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="acr-category">
                        <div class="acr-category-thumb">
                            <a href="products?FMCG">
                                <img src="images/home/fmcg.jpg"></a>
                            <div class="acr-category-body">
                                <h5>
                                    <a href="products?FMCG">
                                        <img src="images/home/fmcg.png" width="60px" />
                                        FMCG </a>
                                </h5>
                                <!--<span>185 Indoor & Outdoor Furniture   </span>-->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="acr-category">
                        <div class="acr-category-thumb">
                            <a href="products?Agriculture">
                                <img src="images/home/agriculture.jpg"></a>
                            <div class="acr-category-body">
                                <h5>
                                    <a href="products?Agriculture">
                                        <img src="images/home/agriculture.png" width="60px" />
                                        Agriculture</a>
                                </h5>
                                <!-- <span>230 Indoor & Outdoor Furniture   </span>-->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="acr-category">
                        <div class="acr-category-thumb">
                            <a href="products?Beauty-Care">
                                <img src="images/home/beautycare.jpg"></a>
                            <div class="acr-category-body">
                                <h5>
                                    <a href="products?Beauty-Care">
                                        <img src="images/home/beuty-care.png" width="60px" />
                                        Beauty Care</a>
                                </h5>
                                <!--<span>365 Indoor & Outdoor Furniture   </span>-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Categories End -->
    <div class="section section-padding faq-style-2 video-bg">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-xl-6 col-lg-7">
                    <div class="sigma_about style-4">
                        <div class="sigma_about-image-1">
                            <img src="images/home-video.jpg" alt="img">
                        </div>
                        <a class="popup-youtube sigma_video-btn pulse" rel="external" href="https://www.youtube.com/watch?v=F_2GEQJ7KII">
                            <i class="fa fa-play"></i></a>
                    </div>
                    <%--  <div class="faq-image">
          <iframe width="100%" height="315" src="https://www.youtube.com/embed/F_2GEQJ7KII" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
          </div>--%>
                </div>
                <div class="col-xl-6 col-lg-5">
                    <div class="faq-content-wrapper">
                        <div class="section-title-wrap section-header" style="padding-bottom: 15px;">
                            <h2 class="title" style="font-size: 16px; line-height: 1.3; color: #1A1A18; font-weight: bold;">Pancha Tulasi Drops, a natural elixir prepared from the distillate of five species
                                of Tulasi</h2>
                        </div>
                        <div class="accordion">
                            <p style="margin-bottom: 10px;">
                                Modern day lifestyle, pollutants, climatic adversity & adulteration leads to imbalance
                                in immunity resulting in various endogenous (i.e. cancer, rheumatoid arthritis,
                                stress related disease) & exogenous (i.e. viral, Bacterial fungal, Nutrition related)
                                diseases. Need of the hour is an effective option that not only provides improved
                                immunity but also offers microbial protection.
                            </p>
                            <p>
                                DELTAS Pancha Tulasi Drops, a clinically tested formula is prepared from the distillate
                                of 5 species of Tulasi mixed together. Based on the Good Agricultural Practices,
                                the stringent collection & sourcing of Tulasi, Rama Tulasi, Vana Tulasi, Sweta Tulasi
                                and Nimbuka Tulasi is accomplished by Deltas Pharma under a stringent quality control
                                systems.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Categories End -->
    <!-- Best Low Fat  Start -->
    <div class="section section-padding" id="offer">
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
                            <%-- <div class="slide-item">
                                <img src="images/offer-1.jpg">
                            </div>
                            <div class="slide-item">
                                <img src="images/offer-2.jpg">
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Best Low Fat  End -->
    <br />
    <br />
    <div class="section section-padding pt-20">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="cta cta-2 item1">
                        <div class="cta-body" style="width: 100%">
                            <img src="images/user-icon.png" style="height: 70px; float: left; padding-right: 20px;" />
                            <br />
                            <h4>How we help?</h4>
                            <div class="clearfix">
                            </div>
                            <p style="margin: 0px">
                            </p>
                            <a href="faq.aspx" class="btn-link float-right">Read More...</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="cta cta-2 item1">
                        <div class="cta-body" style="width: 100%">
                            <img src="images/shop-icon.png" style="height: 70px; float: left; padding-right: 20px;" /><br />
                            <h4>Do you want to Buy?</h4>
                            <div class="clearfix">
                            </div>
                            <p style="margin: 0px">
                            </p>
                            <a href="products" class="btn-link float-right">Read More...</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="spacer spacer-lg spacer-bottom orange-bg">
        </div>
    </div>
    <div class="section section-padding pt-20">
        <div class="container">
            <div class="section-title-wrap section-header pt-0">
                <h5 class="custom-secondary">Our Brands</h5>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="col-item">
                        <div class="photo">
                            <img src="images/brand/brand-logo.png" class="img-responsive" />
                        </div>
                    </div>
                </div>
                <div id="carousel-example" class="carousel slide d-xs-none" data-ride="carousel"
                    style="width: 100%; display: none;">
                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">
                        <div class="item active">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/agefyte.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/amrrut-pancha-tulsi.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/classical-ayurved.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/nutrilong.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/sanjeevani.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/topflora.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/topkaa.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/topkleen.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/vatsal.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/amrrut-pancha-tulsi.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/classical-ayurved.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="col-item">
                                        <div class="photo">
                                            <img src="images/brand/nutrilong.jpg" class="img-responsive" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="section section-padding pb-0 d-none">
        <div class="container">
            <div class="section-title-wrap section-header pt-0">
                <h5 class="custom-secondary">Testimonials</h5>
                <h2 class="title">What Are People Saying</h2>
            </div>
            <div class="row">
                <!-- Testimonail item start -->
                <div class="col-lg-4 col-md-6">
                    <div class="acr-testimonial">
                        <div class="acr-testimonial-author">
                            <img src="images/test.jpg">
                            <div class="acr-testimonial-author-inner">
                                <h6>BUSINESS GROWTH</h6>
                            </div>
                        </div>
                        <div class="acr-testimonial-body">
                            <h5>BUSINESS GROWTH</h5>
                            <p>
                                Everyone in the world needs growth. We can help you achieve desired growth.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Testimonail item end -->
                <!-- Testimonail item start -->
                <div class="col-lg-4 col-md-6">
                    <div class="acr-testimonial">
                        <div class="acr-testimonial-author">
                            <img src="images/test.jpg">
                            <div class="acr-testimonial-author-inner">
                                <h6>TRAINING</h6>
                            </div>
                        </div>
                        <div class="acr-testimonial-body">
                            <h5>TRAINING</h5>
                            <p>
                                Our company helps you to develop skills to be successfull in business.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Testimonail item end -->
                <!-- Testimonail item start -->
                <div class="col-lg-4 col-md-6">
                    <div class="acr-testimonial">
                        <div class="acr-testimonial-author">
                            <img src="images/test.jpg" alt="testimonial">
                            <div class="acr-testimonial-author-inner">
                                <h6>PRODUCT CATALOGUE</h6>
                            </div>
                        </div>
                        <div class="acr-testimonial-body">
                            <h5>PRODUCT CATALOGUE</h5>
                            <p>
                                Our company is focused on helping you with world class products.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Testimonail item end -->
                <!-- Testimonail item start -->
                <div class="col-lg-4 col-md-6">
                    <div class="acr-testimonial">
                        <div class="acr-testimonial-author">
                            <img src="images/test.jpg" alt="testimonial">
                            <div class="acr-testimonial-author-inner">
                                <h6>BUSINESS PLAN</h6>
                            </div>
                        </div>
                        <div class="acr-testimonial-body">
                            <h5>BUSINESS PLAN</h5>
                            <p>
                                Our business plan can help to learn all the aspects of marketing and business planning
                                & coaching.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Testimonail item end -->
                <!-- Testimonail item start -->
                <div class="col-lg-4 col-md-6">
                    <div class="acr-testimonial">
                        <div class="acr-testimonial-author">
                            <img src="images/test.jpg" alt="testimonial">
                            <div class="acr-testimonial-author-inner">
                                <h6>BUSINESS TOOLS</h6>
                            </div>
                        </div>
                        <div class="acr-testimonial-body">
                            <h5>BUSINESS TOOLS</h5>
                            <p>
                                Our company is committed to delivering world-class financial planning.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Testimonail item end -->
                <!-- Testimonail item start -->
                <div class="col-lg-4 col-md-6">
                    <div class="acr-testimonial">
                        <div class="acr-testimonial-author">
                            <img src="images/test.jpg" alt="testimonial">
                            <div class="acr-testimonial-author-inner">
                                <h6>OUR OBJECTIVE</h6>
                            </div>
                        </div>
                        <div class="acr-testimonial-body">
                            <h5>OUR OBJECTIVE</h5>
                            <p>
                                Our objective is to inspire healthy living & enable people to discover business
                                leaders in them.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Testimonail item end -->
            </div>
        </div>
    </div>
    <style>
        .section {
            padding: 30px 0;
        }

        .toptime {
            color: #1A1A18;
            font-size: 16px;
        }
    </style>
    <div class="modal fade quick-view-modal" id="quickViewModal" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content about-home">
                <div class="modal-body">
                    <div class="close-btn close-dark close" data-dismiss="modal">
                        <span></span><span></span>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="section-title-wrap section-header p-0">
                                    <h5 class="custom-secondary">Overview</h5>
                                </div>
                                <p>
                                    We are a leading, direct selling company reintroducing ancient Ayurved and natural
                                    concepts in the most advanced form. We develop, manufacture and distribute innovative,
                                    premium quality Ayurvedic, personal care products and nutritional supplements in
                                    association with our Group company Deltaspharma India Private Limited. We are focused
                                    on securing competitive advantages in the following areas: Toptime people, Toptime
                                    products, Toptime culture we promote, and Toptime business ecosystem.
                                </p>
                                <ul class="toptime">
                                    <li>Toptime people have grown and transformed many seekers as healthy and prosperous
                                        lifestyle achievers. </li>
                                    <li>Toptime product range is based on a “farm to consumer” approach, providing a competitive
                                        edge with in-house manufacturing, R&D, quality, cost efficiency & demonstrability.</li>
                                    <li>Toptime culture ensures a seamless support system and education for ensuring comprehensive
                                        growth. Our methods accommodate personalized development and hand holding for achieving
                                        entrepreneurship.</li>
                                    <li>Toptime business ecosystem provides opportunity & security for young and experienced
                                        people; our business plan ensures long term and instant income opportunity.
                                    </li>
                                </ul>
                                <p>
                                    Ayurved is an ancient science of health envisaging natural principles to maintain
                                    inner balance with the universe; this science behind healthy mind and body narrates
                                    the methods of syncing our biological rhythm with the universe. The need for syncing
                                    with nature has been experienced in current times; the pandemic challenge is the
                                    proof of realization of our strength and the in-equilibrium with nature. We believe
                                    that the entire world needs to reinstate healthcare and lifestyle approaches; and
                                    foresee that the natural sciences and Ayurved will be the need of the 21st century,
                                    and therefore we believe it's the right time to take Ayurved and natural concepts
                                    from India to the world. In 1985, with our team of researchers; we started an organic
                                    herbal plantation to integrate the raw material with prospective manufacturing of
                                    Ayurvedic Products and Natural Concepts. Today we are providing the ancient Ayurved
                                    applications reinvented with modern day technology to our people not only in India
                                    but also overseas.
                                </p>
                                <p>
                                    We comply with various laws and regulations in India and we are ready for global
                                    reach. We believe our compensation plan is among the most generous compensation
                                    plans in the direct selling industry. We believe the high payout of our compensation
                                    plan enables sales leaders the opportunity to reach significant income levels and
                                    provides us with a competitive advantage in attracting and developing highly capable,
                                    motivated sales leaders.
                                </p>
                                <p>
                                    Toptime, as one of the Deltas Group companies, is emerging as India’ leading Ayurved
                                    and Natural concepts direct selling company. Our products are made with organic
                                    and natural ingredients following advanced Ayurved and optimum natural footprints.
                                    Our brands like Deltas Pancha Tulasi, Joddaram, NutriLong, SparrshVed, AgeFyte,
                                    MaamFresh, TopKaa, TopKleen, TopVet, TopFlora are complementing our aim -
                                </p>
                                <p>
                                    <b>“We care for nature, We care for you”</b>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade quick-view-modal" id="selling-business" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content about-home">
                <div class="modal-body">
                    <div class="close-btn close-dark close" data-dismiss="modal">
                        <span></span><span></span>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="section-title-wrap section-header p-0">
                                    <h5 class="custom-secondary">Direct Selling Business</h5>
                                </div>
                                <p>
                                    Direct selling is selling the product directly to users; where users may be the
                                    direct selling associates or people referred by direct selling associates. Both
                                    types of consumers get benefits as retail discounts; whereas the direct selling
                                    associates receive incentives over and above as compensation based on consumption
                                    levels for referrals. These referrals are of two types, i.e. users or consumers
                                    and sponsored direct selling associates, also known as downline associates.
                                </p>
                                <p>
                                    The referral consumers buy products or services regularly for discounts and incentives
                                    on their self purchase; whereas downline associates focus on increasing the consumer
                                    base and sponsoring new associates. This activity is known as “duplication” - the
                                    spine of the direct selling ecosystem for companies and associates.
                                </p>
                                <p>
                                    The culture of companies & people; their education, training and wholesome engagement
                                    ensures comprehensive duplication and sustainability. The approach of “Direct to
                                    Consumer” assures that the product is reached at a competitive quality and price
                                    to consumers. The cost of advertising, marketing and distribution is shared as payouts
                                    & rewards for direct selling associates. This payout & reward distribution system
                                    is also known as “compensation or business plan”.
                                </p>
                                <p>
                                    Observing the current global trend of e-commerce, digital revolution and phenomenal
                                    consumer awareness; we believe that the current and future consumer would like to
                                    know more about the product before reaching or using it. Direct selling is the strongest
                                    platform for creating product awareness, which is most of the time created through
                                    “word of mouth”. The testimonial of the known can create a solid confidence, value
                                    assurance and trust which otherwise would be obscure through e-commerce tools, celebrity
                                    engagements or other traditional marketing methods.
                                </p>
                                <p>
                                    The Indian direct selling industry has been beating the economic slowdown despite
                                    the recent global lockdown, notching up remarkable growth over the years and has
                                    been expanding its horizons in India as a rapidly emerging alternate distribution
                                    channel. India is expected to grow at a compound annual growth rate (CAGR) of about
                                    4.8 percent to reach Rs 15,930 crore by 2021 and 64500 crore by 2025.
                                </p>
                                <p>
                                    Direct Selling Business has performed in various markets and its growth statistics
                                    are unparalleled with any other marketing methods globally. Direct selling business,
                                    now combined with the internet revolution, is and will be the most preferred method
                                    of business for the 21st Century. Direct selling business is poised to become an
                                    alternative economy.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade quick-view-modal" id="direct-selling-company" role="dialog"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content about-home">
                <div class="modal-body">
                    <div class="close-btn close-dark close" data-dismiss="modal">
                        <span></span><span></span>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="section-title-wrap section-header p-0">
                                    <h5 class="custom-secondary">Selection of appropriate Direct Selling Company</h5>
                                </div>
                                <p>
                                    Direct selling opportunity mostly knocks through direct contacts or through social
                                    media communities. Evaluation of the source and testimony is the first; and the
                                    clarity of “WHY” to opt for direct selling is the next essential prerequisite for
                                    selection of the company. Once the prerequisites are attained, following steps shall
                                    be evaluated for selection of appropriate direct selling company:
                                </p>
                                <ul class="toptime">
                                    <li>Uniqueness of products & services and whether those products & services fall under
                                        your personal need and interest.</li>
                                    <li>Background and vision of the company, compliances, company policies, financial stability,
                                        the value propositions including brands, research, IPR and assets.</li>
                                    <li>Top management team with their experience and track records, business philosophy
                                        and culture.</li>
                                    <li>Sustainable and secure compensation plan ensuring sales based incentive and driven
                                        by products & services needs.</li>
                                    <li>Hand-holding or support system, including free access to basic promotional tools,
                                        education system and training. </li>
                                    <li>Top leadership performances and people testimonials</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade quick-view-modal" id="direct-selling-associate" role="dialog"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content about-home">
                <div class="modal-body">
                    <div class="close-btn close-dark close" data-dismiss="modal">
                        <span></span><span></span>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="section-title-wrap section-header p-0">
                                    <h5 class="custom-secondary">Selection of appropriate Direct Selling Company</h5>
                                </div>
                                <p>
                                    A journey of financial freedom & personal excellence:
                                </p>
                                <p>
                                    <b>You are an independent business owner - </b>Speed and innovation are your own
                                    with no debts, investments or dependencies.
                                </p>
                                <p>
                                    <b>“You are sharing not selling” -</b> Sharing as a consumer - the experience with
                                    company, products, loyalty advantages, business plan and testimonials; are the essence
                                    of direct selling - sales on your business ID happens on its own.
                                </p>
                                <p>
                                    <b>Realization of “Time is Money” with ease - </b>Involuntarily every action guides
                                    us towards becoming a better entrepreneur, where you achieve payouts and rewards
                                    while learning.
                                </p>
                                <p>
                                    <b>Optimizing “Work - Life” balance -</b> Planning of life related commitment and
                                    complementing it with work can be attained.
                                </p>
                                <p>
                                    <b>Benefits of “Personal Development” -</b> Education based enrichment of communication
                                    skills, leveraging social circle strength and uplifting teamwork aptitude, stepping
                                    towards event management, business management and leadership skills.
                                </p>
                                <p>
                                    <b>Opportunity to “Build Income & Lifestyle” -</b> Best mode to generate passive
                                    income with possibility for short-term income plans and sustainable long-term income
                                    with rewards.
                                </p>
                                <p>
                                    <b>21st Century’ “Ideal Business” -</b> Education, skills & business ecosystem at
                                    free of cost, where people expect trustworthy products or services at discount through
                                    web-based services.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade quick-view-modal" id="why-toptime" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content about-home">
                <div class="modal-body">
                    <div class="close-btn close-dark close" data-dismiss="modal">
                        <span></span><span></span>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="section-title-wrap section-header p-0">
                                    <h5 class="custom-secondary">Selection of appropriate Direct Selling Company</h5>
                                </div>
                                <p>
                                    We follow the vision of Deltas Group established in 1985; and the commitment to
                                    take Advance Ayurved & Natural Concepts to every household at an affordable price.
                                    Our state of art manufacturing strength, advanced R&D and substantial IPR supported
                                    us to register Deltas Ayurvedic products to various countries across the globe.
                                    Year 2016, the foundation of direct selling division - Toptime, complements the
                                    Group’ ideology through the “Farm to Consumer” approach. Since our inception, we
                                    have established a solid financial foundation and a culture of innovation that will
                                    continue to provide ample energy to help us sustain our growth. Despite the global
                                    economy continuing to struggle, we continued to elevate our performance in 2020.
                                </p>
                                <p>
                                    With five consecutive years of record-breaking revenue, we’re climbing to greater
                                    heights virtually in all 6 segments of business with our sights keenly focused on
                                    reaching our goal of becoming India's leading direct selling company. Toptime provides
                                    best opportunity for 21st century direct selling business seeker because:
                                </p>
                                <ul class="toptime">
                                    <li>Innovative products based on natural concepts and advanced Ayurved backed up with
                                        research. This provides a superior opportunity to supply need based healthcare and
                                        lifestyle products in the 21st century. Favourable opportunity due current global
                                        situation where immunity and preventive healthcare awareness became a viral phenomenon.</li>
                                    <li>With a strong financial and business background, we are striding towards our vision.
                                        We are complying with all the laws and regulations and developing a culture of prospective
                                        growth for our business associates.</li>
                                    <li>Top management team with over 20 years of establishing various businesses; believe
                                        that empowering people is the essential metrics for success of any organization.
                                        Growth and development of associates and leadership is the primary focus of the
                                        management team.</li>
                                    <li>Our compensation plan ensures optimum distribution of revenue over sales in a unique,
                                        secure and sustainable form for achieving short term and long-term incentive. Further,
                                        our need based innovative products incubate the culture of “sharing than selling”.</li>
                                    <li>Our web-based tools, education system and training programmes provide self development
                                        opportunities and wholesome engagement; our business culture inculcates personalised
                                        focus and hand holding. </li>
                                    <li>Our top leadership team pioneers education, training and duplication concepts and
                                        generating respectable income, achieving rewards for a better lifestyle and inspiring
                                        people for their personal growth and financial freedom.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade quick-view-modal" id="toptime-profile" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content about-home">
                <div class="modal-body">
                    <div class="close-btn close-dark close" data-dismiss="modal">
                        <span></span><span></span>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="section-title-wrap section-header p-0">
                                    <h5 class="custom-secondary">Toptime Profile</h5>
                                </div>
                                <p>
                                    Direct selling business was the most favourable business for Deltas Group, due to
                                    its vision of taking the Advance Ayurved and Natural Concepts to every household
                                    at affordable prices. Deltas manufacturing unit has provided private labeled products
                                    to some of the large direct selling companies in India, then through its private
                                    label business vertical since 2008. Our private label vertical supported not only
                                    supply but also the development requirements of various multinational and Indian
                                    companies; supported the clients to register their products successfully in various
                                    markets. Therefore, with our tremendous production capacity, we were ready to roll
                                    the direct selling business; and the right time has arrived in 2016 with release
                                    of guidelines in direct selling by the Department of Consumer Affairs, under the
                                    Ministry of External Affairs. Immediately with the release of the guidelines, we
                                    incorporated our direct selling vertical - Toptime Network Private Limited on 3rd
                                    June 2016. We were waiting for the right time to regulate direct selling in India,
                                    and we enrolled ourselves with the Department of Consumer Affairs. We believe the
                                    favourable time of Direct Selling started in India and with this we have started
                                    our one of the most favourable divisions.
                                </p>
                                <p>
                                    Our primary focus is development of people, education, training and transforming
                                    them to entrepreneurs; we thrive to create a better you as a healthy and sound entrepreneur.
                                    Our products come from 20 years of excellence in Deltas Group; having hundreds of
                                    products with the IPR is aligned for the Toptime Division. Healthcare, wellness,
                                    Personal care, FMCG, Agriculture and veterinary are the current segments with around
                                    100 products already available. We are looking forward to specialized nutrition,
                                    color cosmetics, women's intimate hygiene & lifestyle enhancing devices based on
                                    natural concepts in near future. Toptime thrives to bring products based on established
                                    quality standards of Deltas with a “Farm to consumer” approach.
                                </p>
                                <p>
                                    Our education and leadership development programs are conducted online and online
                                    across India; these programs are personalized and vetted under a senior management
                                    team. Toptime business culture incubates young and experienced associates and provides
                                    an equal opportunity for growth. We believe the 21st Century is our favourable Time;
                                    we are Toptime and we endeavour to reintroduce Ayurved as Advance Ayurved; an unparalleled
                                    need to maintain immunity, health, and lifestyle.
                                </p>
                                <h5 class="custom-secondary">Vision and Mission of the Company</h5>
                                <ul class="toptime">
                                    <li>Toptime Family is aiming to reach every household; create entrepreneurs propagating
                                        health and wellness rapidly.</li>
                                    <li>We inspire healthy living by promoting natural well-being and enable people to discover
                                        their business potential.</li>
                                    <li>Our Topmost goal is to engage people for spreading education of preventive healthcare
                                        and lifestyle; thence to achieve their own corporal, mental and financial health.
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Button trigger modal -->
    <%-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
        Launch demo modal
    </button>--%>
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

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
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

</asp:Content>
