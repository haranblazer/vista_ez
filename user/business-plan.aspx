<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="business-plan.aspx.cs" Inherits="business_plan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
   
<%--<div class="subheader subheader1 bg-cover" style="background-image: url('images/business-tool.jpg')">    
</div>--%>
    <div class="orange-bg">
        <div class="container">
            <div class="section-title-wrap section-header">
                <%--  <h5 class="custom-secondary text-white">
                    Categories</h5>--%>
               <%-- <h2 class="title text-white">
                    Business Plan
                </h2>--%>
            </div>
        </div>
    </div>
    <div class="section1 section-padding pt-10">
        <div class="spacer orange-bg">
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-8 offset-lg-2">
            <article class="post-business-plan">
            <div class="post-thumbnail1">
            <a href="#"><img class="img-thumbnail" src="images/business-plan/business-plan-1.jpg"></a>
            </div>
            </article>
                    <div class="text-center">
                        <a data-fancybox="gallery" href="images/business-plan/business-plan-1.jpg" class="btn-custom primary secondary down-business1">
                            <i class="fa fa-eye" aria-hidden="true"></i> View</a> 
                        <a href="images/business-plan/business-plan.pdf" class="btn-custom primary secondary down-business" download><i class="fa fa-download"
                                    aria-hidden="true"></i> Download </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-4 col-xs-6 text-center" style="display: none;">
                    <a data-fancybox="gallery" href="images/business-plan/business-plan-2.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-2.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-3.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-3.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-4.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-4.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-5.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-5.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-6.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-6.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-7.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-7.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-8.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-8.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-9.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-9.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-10.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-10.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-11.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-11.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-12.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-12.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-13.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-13.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-14.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-14.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-15.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-15.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-16.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-16.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-17.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-17.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-18.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-18.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-19.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-19.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-20.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-20.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-21.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-21.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-22.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-22.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-23.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-23.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-24.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-24.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-25.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-25.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-26.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-26.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-27.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-27.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-28.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-28.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-29.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-29.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-30.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-30.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-31.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-31.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-32.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-32.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-33.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-33.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-34.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-34.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-35.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-35.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-36.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-36.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-37.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-37.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-38.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-38.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-39.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-39.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-40.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-40.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-41.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-41.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-42.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-42.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-43.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-43.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-44.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-44.jpg">
                    </a>
                  <%--   <a data-fancybox="gallery" href="images/business-plan/business-plan-45.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-45.jpg">
                    </a>
                       <a data-fancybox="gallery" href="images/business-plan/business-plan-46.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-46.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-47.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-47.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-48.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-48.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-49.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-49.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-50.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-50.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-51.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-51.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-52.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-52.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-53.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-53.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-54.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-54.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-55.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-55.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-56.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-56.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-57.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-57.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-58.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-58.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-59.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-57.jpg">
                    </a><a data-fancybox="gallery" href="images/business-plan/business-plan-60.jpg">
                        <img class="img-thumbnail" style="padding: 3px; margin-bottom: 20px" width="320px"
                            height="200px" src="images/business-plan/business-plan-58.jpg">
                    </a>--%>
                </div>
            </div>
        </div>
    </div>

    <style>
        a.btn-custom.primary.secondary.down-business1 {
    width: 150px;
    padding: 2px;
    background: none;
    border: 1px solid #fe6a00;
    color: #fe6a00;
}
        .btn-custom, .btn-custom-2 {
    cursor: pointer;
    display: inline-block;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    position: relative;
    background-color: none;
    line-height: 24px;
    border: 0;
    color: #fff;
    font-size: 17px;
    font-weight: 100;
    padding: 5px 5px;
    -webkit-transition: 0.3s;
    -o-transition: 0.3s;
    transition: 0.3s;
    border-radius: 5px;
    overflow: hidden;
    z-index: 1;
}
        .btn-custom.primary {
    background-color: #fe6a00;
}
        a.btn-custom.primary.secondary.down-business {
    padding: 3px;
    width: 150px;
}
    </style>
</asp:Content>
