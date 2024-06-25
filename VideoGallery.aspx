<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="VideoGallery.aspx.cs" Inherits="VideoGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list">
                <li class="breadcrumb-item"><a href="default">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Video Gallery</a></li>
            </ol>
        </div>
    </div>
  
    <div class="home mt-10">
     <div class="container">
		<div class="tab text-center">
			<%--<input id="tab1" type="radio" name="tabs" checked>
			<label for="tab1"><i class="fa fa-camera-retro"></i> Product Demo</label>--%>
			<input id="tab2" type="radio" name="tabs" checked>
			<label for="tab2"><span class="fa fa-briefcase" aria-hidden="true"></span> Our Product</label>
			<input id="tab3" type="radio" name="tabs">
			<label for="tab3"><i class="fa fa-quote-left" aria-hidden="true"></i> Testimonials</label>
			<input id="tab4" type="radio" name="tabs">
			<label for="tab4"><i class="fa fa-book" aria-hidden="true"></i> Success Stories</label>
			<%--<input id="tab5" type="radio" name="tabs">
			<label for="tab5">Models</label>
			<input id="tab6" type="radio" name="tabs">
			<label for="tab6">Installation</label>--%>
			
		    <section id="content1">
			<div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                <div class="bg-primary mb-3 mx-auto" style="width: 60px; height: 2px;"></div>
                <h1 class="display-8 mb-3">Product Demo</h1>
            </div>
            <div class="row g-4 portfolio-container">
                <asp:DataList ID="ddlVideo" RepeatLayout="Flow" RepeatColumns="3" Width="100%" runat="server" RepeatDirection="Horizontal">
                    <itemtemplate>
                        <div class="col-lg-4 col-md-6 p-2 portfolio-item first wow fadeInUp" data-wow-delay="0.1s">
                            <div class="portfolio-inner">
                                <%# Eval("VName") %>
                                <div class="text-center p-2">
                                    <h5 class="lh-base mb-0"><%# Eval("Descriptions") %></h5>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <br />
                    </itemtemplate>
                </asp:DataList>
            </div>
		    </section>
		    <!-- end of section 1 -->
		    <section id="content2">
			    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                <%--<div class="bg-primary mb-3 mx-auto" style="width: 60px; height: 2px;"></div>
                <h1 class="display-8 mb-3">Our Product</h1>--%>
                </div>
            <div class="row g-4 portfolio-container">
                <asp:DataList ID="ddlVideo2" RepeatLayout="Flow" RepeatColumns="3" Width="100%" runat="server" RepeatDirection="Horizontal">
                    <itemtemplate>
                        <div class="col-lg-4 col-md-6 p-2 portfolio-item first wow fadeInUp" data-wow-delay="0.1s">
                            <div class="portfolio-inner">
                                <%# Eval("VName") %>
                                <div class="text-center p-2">
                                    <h5 class="lh-base mb-0"><%# Eval("Descriptions") %></h5>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <br />
                    </itemtemplate>
                </asp:DataList>
            </div>
		</section>
		<!-- end of section 2 -->
		<section id="content3">
		  <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                <%--<div class="bg-primary mb-3 mx-auto" style="width: 60px; height: 2px;"></div>
                <h1 class="display-8 mb-3">Testimonial</h1>--%>
            </div>
            <div class="row g-4 portfolio-container">
                <asp:DataList ID="ddlVideo3" RepeatLayout="Flow" RepeatColumns="3" Width="100%" runat="server" RepeatDirection="Horizontal">
                    <itemtemplate>
                        <div class="col-lg-4 col-md-6 p-2 portfolio-item first wow fadeInUp" data-wow-delay="0.1s">
                            <div class="portfolio-inner">
                                <%# Eval("VName") %>
                                <div class="text-center p-2">
                                    <h5 class="lh-base mb-0"><%# Eval("Descriptions") %></h5>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <br />
                    </itemtemplate>
                </asp:DataList>
            </div>
		</section>
		<!-- end of section 3 -->
		<section id="content4">
            <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
            <%--<div class="bg-primary mb-3 mx-auto" style="width: 60px; height: 2px;"></div>
                <h1 class="display-8 mb-3">Success Stories</h1>--%>
            </div>
            <div class="row g-4 portfolio-container">
                <asp:DataList ID="ddlVideo4" RepeatLayout="Flow" RepeatColumns="3" Width="100%" runat="server" RepeatDirection="Horizontal">
                    <itemtemplate>
                        <div class="col-lg-4 col-md-6 p-2 portfolio-item first wow fadeInUp" data-wow-delay="0.1s">
                            <div class="portfolio-inner">
                                <%# Eval("VName") %>
                                <div class="text-center p-2">
                                    <h5 class="lh-base mb-0"><%# Eval("Descriptions") %></h5>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <br />
                    </itemtemplate>
                </asp:DataList>
            </div>
		</section>
		<!-- end of section 4 -->
	</div>
</div>
  </div>
    <style>
section {
  display: none;
  padding: 20px;
 /* border: 1px solid #ddd;*/
  overflow: hidden;
}

.tab input {
  display: none;
}

label {
  display: inline-block;
  margin: 0 0 -1px;
  padding: 10px 25px;
  font-weight: bold;
  text-align: center;
  color: #595959;
  border: 1px solid transparent;
}

label:before {
  font-weight: normal;
  margin-right: 10px;
}

label:hover {
  color: #888;
  cursor: pointer;
}

input:checked + label {
   color: #ba2011;
    border: 1px solid #ba2011;
    border-bottom: 5px solid #ba2011;
    /* border-bottom: 1px solid #ddd; */
    border-radius: 10px;
}

#tab1:checked ~ #content1,
#tab2:checked ~ #content2,
#tab3:checked ~ #content3,
#tab4:checked ~ #content4,
#tab5:checked ~ #content5,
#tab6:checked ~ #content6,
#tab7:checked ~ #content7 {
  display: block;
}
ul > li{
	margin-bottom: 10px;
}



    </style>
</asp:Content>
