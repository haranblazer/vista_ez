<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="about-us.aspx.cs" Inherits="about_us" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list">
                <li class="breadcrumb-item"><a href="default">Home</a></li>
                <li class="breadcrumb-item"><a href="javascript:void(0)">About Us</a></li>
            </ol>
        </div>
    </div>
    <section class="about-area about-page-area ptb-50 pt-0">
        <div class="container-fluid">
            <div class="row about-page-wrap">
                <div class="col-md-7">
                    <div class="about-content pt-20">
                        <h3 class="title ">Who We Are:</h3>
                        <p>
                            We are India's leading commerce venture. We started our journey in year 2017 with a 24x7 Shopping Channel reaching 100 million household.
                        </p>
                        <p>We further expanded Our business into e-commerce domain with multiple D2C Brands with an objective to help manufactures & MSMEs build & grow their brand and reach customers directly.  </p>
                        <p>Our brand partner's world class manufacturing facilities are spread across India, heavily promoting Make in India. </p>
                        <p>
                            With our own 24x7 logistics and customer service operations, we provide seamless service to our esteemed customers across India.

                        </p>


                        <p>
                            <b>Vision: </b>Simplify Commerce in India for Businesses & Individuals to Grow & Reach Their True Potential.</p><p>
                            <b>Mission:</b> Building India's Biggest Direct to Customer Network by Enabling Indian brands to amplify their growth & expand their reach, offering unparalleled growth opportunities to Business Partners & drive customer delight with diverse product line.<br />
                        </p>

                        <h3 class="title mt-12">Our Core Values:</h3><br />
                        <p>
                            <b>Customer First: </b>
We go above & beyond to provide great products & outstanding support to our customer. </p>

<p><b>Speed & Agility: </b>
We Implement at speed & are ready to change as per the business requirement. </p>

<p><b>Hustle: </b>
We act with a sense of urgency to deliver a win. </p>

<p><b>Be Frugal: </b>
We employ innovation to build our businesses sustainably while being frugal with resources. </p>

<p><b>Solve Big Problem: </b>
We strive to Eliminate the complexity of commerce for MSME & Manufacturers. </p>

<p><b>Respect, Humulty & Integrity: </b>
We encourage open conversations & candid feedback for improvement while maintaining the utmost respect. </p>

<p><b>Big Audacious Goal: </b>
Aiming for multifold business growth by using technology, experimenting with new ideas, fail fast & scale fast.

                        </p>




                    </div>
                </div>

                <%--<div class="col-md-7">
                    <div class="about-content pt-20">
                        <h3 class="title">Our Company </h3>
                        <p><b>Vision: </b>We are the first and aspire to be India's largest video commerce platform creating opportunities for important segments of society.</p>
                        <p><b>Mission:</b> We deliver phygital and real - time shopping experience digitally by connecting local Indian shops and businesses with online customers.</p>
                        <h3 class="title mt-12">Values:</h3>
                        <p>
                            •	Customer First<br />
                            •	Big Hairy Audacious Goals (BHAG)<br />
                            •	Being frugal<br />
                            •	Speed & Agility<br />
                            •	Solving Big Problems<br />
                            •	Respect, Integrity and Humility<br />
                            •	Hustle
                        </p>
                        <h3 class="title mt-12">What We Do:</h3>
                        <p>
                            •	Personalized Shopping Experience<br />
                            •	Creating Shoppable Videos<br />
                            •	Presence across Multiple Categories<br />
                            •	Connecting Shops/Markets/Events Online<br />
                            •	Driving Engagement & Interaction between Shoppers & Sellers<br />
                            •	Delivering Physical Experience<br />
                            •	Real-Time Shopping<br />
                            •	Delivering to 27,000+ Pin codes
                        </p>
                    </div>
                </div>--%>
                <div class="col-md-5">
                    <div class="about-thumb">
                        <img src="images/about_us.jpg" class="img">
                    </div>
                </div>
            </div>
        </div>
    </section>
    <style>
        .about-page-wrap .about-content .title {
            font-size: 22px;
            line-height: 1.3;
            margin-bottom: 5px;
            /* max-width: 500px; */
            color: #323232;
            font-weight: 500;
            /* font-family: alex brush,cursive; */
            text-transform: capitalize;
        }

        .about-page-wrap .about-thumb img {
            width: 100%;
        }

        .about-page-wrap {
            /*-webkit-box-align: center;
            -ms-flex-align: center;
            align-items: center;*/
            /*box-shadow: -15px 0 35px rgba(0, 0, 0, 0.1), 0 -15px 35px rgba(0, 0, 0, 0.1), 0 15px 35px rgba(0, 0, 0, 0.1);*/
            box-shadow: -20px 19px 35px rgba(0, 0, 0, 0.1), 20px 7px 20px 0px rgba(0, 0, 0, 0.1), 0 15px 6px rgba(0, 0, 0, 0.1);
        }

            .about-page-wrap .about-content {
                /*margin-right: -30px;*/
            }

                .about-page-wrap .about-content p {
                    font-size: 16px;
                    margin-bottom: 20px;
                    text-align: justify;
                }
    </style>
</asp:Content>
