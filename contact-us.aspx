<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="contact-us.aspx.cs" Inherits="contact_us" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list">
                <li class="breadcrumb-item"><a href="default">Home</a></li>
                <li class="breadcrumb-item"><a href="javascript:void(0)">Contact Us</a></li>
            </ol>
        </div>
    </div>
    
    <section class="contact-page-sec">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 p-1">
                    <div class="contact-info">
                        <div class="contact-info-item">
                            <div class="contact-info-icon">
                                <i class="fa fa-map-marker"></i>
                            </div>
                            <div class="contact-info-text">
                                <h2>Write Us</h2>
                                <h6>Zingool Technologies Pvt. Ltd.</h6>
                                <span>Plot 9, Sector 16A,


                                </span>
                                <span>Film City,
Noida, UP-201301</span>
                            </div>
                        </div>
                    </div>
                </div>
                 <div class="col-md-3 p-1">
                    <div class="contact-info">
                        <div class="contact-info-item">
                            <div class="contact-info-icon">
                                <i class="fa fa-map-marker"></i>
                            </div>
                            <div class="contact-info-text">
                                <h2>Registered Office Address</h2>
                                <h6>Zingool Technologies Pvt. Ltd.</h6>
                                <span>135, Continental Building


                                </span>
                                <span>Dr. Annie Besant Road, Worli</span>
<span>Mumbai Mumbai City MH 400018</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 p-1">
                    <div class="contact-info">
                        <div class="contact-info-item">
                            <div class="contact-info-icon">
                                <i class="fa fa-envelope"></i>
                            </div>
                            <div class="contact-info-text">
                                <h2>E-mail ID</h2>
                                <span>care@ezcarestore.com</span>
                               <%-- <span>yourmail@gmail.com</span>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 p-1">
                    <div class="contact-info">
                        <div class="contact-info-item">
                            <div class="contact-info-icon">
                                <i class="fa fa-phone"></i>
                            </div>
                            <div class="contact-info-text">
                                <h2>Contact No.</h2>
                                <span>+91 72890 88882</span>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="contact-page-form" method="post">
                        <h2>Get in Touch</h2>
                        <form method="post" action="contact-us.aspx">
                            <div class="row">
                               <div class="col-md-12">
                                    <div class="single-input-field">
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name*">
                                        </asp:TextBox>
                                    </div>
                               </div>
                               <div class="col-md-12">
                                    <div class="single-input-field">
                                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Phone No"></asp:TextBox>
                                    </div>
                               </div>
                               <div class="col-md-12">
                                    <div class="single-input-field">
                                        <asp:DropDownList ID="DdlState" CssClass="form-control" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                               <div class="col-md-12">
                                    <div class="single-input-field">
                                        <asp:DropDownList ID="ddlDistrict" CssClass="form-control" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="single-input-field">
                                        <asp:TextBox ID="txt_City" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="single-input-field">
                                        <asp:TextBox ID="txt_Pincode" runat="server" CssClass="form-control" placeholder="Pin Code"></asp:TextBox>
                                    </div>
                                </div>

                              <div class="col-md-12">
                                    <div class="single-input-field">
                                        <asp:TextBox ID="txtMsg" runat="server" CssClass="form-control" placeholder="Write Your Message" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </div>
                                  <div class="col-md-12">
                                <div class="single-input-fieldsbtn">
                                    <asp:Button ID="btn_Submit" runat="server" Text="Submit" CssClass="btn" OnClick="btn_Submit_Click" />
                                </div>
                                      </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="contact-page-map">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3504.06207006287!2d77.31291387457023!3d28.567898787014553!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390ce446cbc475bb%3A0x63ddb8f003b48507!2sPlot%209%2C%2016%2C%20Film%20City%2C%20Sector%2016A%2C%20Noida%2C%20Uttar%20Pradesh%20201301!5e0!3m2!1sen!2sin!4v1711972423111!5m2!1sen!2sin" width="100%" height="460" frameborder="0" style="border: 0" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <style>
        section {
            padding: 20px 0;
            min-height: 100vh;
        }

        .contact-info {
    display: inline-block;
    width: 100%;
    text-align: center;
    margin-bottom: 10px;
    background: #fff4fc;
    height: calc(100% - 20px);
    padding: 30px 0px;
    box-shadow: 10px 10px 10px rgba(137, 151, 186, 0.15);
}

        .contact-info-icon {
            margin-bottom: 15px;
        }
        .contact-page-sec .contact-page-form h2 {
            color: #071c34;
            text-transform: capitalize;
            font-size: 22px;
            font-weight: 700;
        }

        .contact-info-icon i {
            font-size: 48px;
            color: #ff0041;
        }

        .contact-info-text p {
            margin-bottom: 0px;
        }

        .contact-info-text h2 {
            color: #ff0041;
            font-size: 22px;
            text-transform: capitalize;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .contact-info-text span {
            color: #000;
            font-size: 16px;
            font-weight:;
            display: inline-block;
            width: 100%;
        }

        .contact-page-form {
            display: inline-block;
            width: 100%;
            margin-top: 30px;
        }

        .contact-page-map {
            margin-top: 36px;
        }

        .contact-page-form form {
            padding: 20px 15px 0;
        }

        .form-control {
            height: 50px !important;
            padding: 8px 15px;
            border-radius: 0px !important;
            border: 1px solid #dbd8d8 !important;
            width: 100%;
            color: #242323;
            border-color: #ff0041;
            background-color: #fff7f7;
            letter-spacing: 0.1px;
            font-size: 0.98rem !important;
            margin-bottom: 15px;
        }
       .btn {
            min-width: 180px;
            font-family: var(--font-family-heading);
            font-size: var(--font-16);
            /* font-weight: 700; */
            line-height: 20px;
            text-transform: capitalize;
            text-align: center;
            overflow: hidden;
            display: inline-block;
            padding: 7px 7px;
            border: 0px solid transparent;
            border-radius: 0px;
            color: #fff;
            background-color: #ff0041;
        }

            .btn:hover {
                background-color: #ff0041;
                color: #fff;
            }

         
    </style>
</asp:Content>
