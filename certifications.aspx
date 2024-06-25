<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="certifications.aspx.cs" Inherits="certifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list d-block text-center">
                <li class="breadcrumb-item"><a href="#">Certifications</a></li>
            </ol>
        </div>
    </div>
    <section class="container-fluid mt-5">
        <div class="row">
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/zin_gst_up_1.png">
                    <img src="images/certifications/zin_gst_up_1.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/zin_gst_up_2.png">
                    <img src="images/certifications/zin_gst_up_2.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/pan_zingool.png">
                    <img src="images/certifications/pan_zingool.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/coi_zingool.png">
                    <img src="images/certifications/coi_zingool.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/kremlin_drug_licence_1.png">
                    <img src="images/certifications/kremlin_drug_licence_1.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/kremlin_drug_licence_2.png">
                    <img src="images/certifications/kremlin_drug_licence_2.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/sachveda_ayush_1.png">
                    <img src="images/certifications/sachveda_ayush_1.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/sachveda_ayush_2.png">
                    <img src="images/certifications/sachveda_ayush_2.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/sachveda_drug_licence_1.png">
                    <img src="images/certifications/sachveda_drug_licence_1.png" class="img-fluid" />
                </a>
            </div>
            <div class="col-sm-6 col-md-3 mb-4 text-center">
                <a data-fancybox="gallery" data-src="images/certifications/sachveda_drug_licence_3.png">
                    <img src="images/certifications/sachveda_ayush_2.png" class="img-fluid" />
                </a>
            </div>
        </div>
    </section>
    <style>
        .breadcrumb-item a, .breadcrumb-item {
            color: #040404;
            font-size: 26px;
        }
    </style>
    <script>
        const myCarousel = new Carousel(document.querySelector("#myCarousel"), {
            preload: 1
        });

        Fancybox.assign('[data-fancybox="carousel-gallery"]', {
            closeButton: "top",
            Thumbs: false,
            Carousel: {
                Dots: true,
                on: {
                    change: (that) => {
                        myCarousel.slideTo(myCarousel.getPageforSlide(that.page), {
                            friction: 0
                        });
                    }
                }
            }
        });
    </script>
</asp:Content>
