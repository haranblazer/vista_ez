<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="DashboardTopper.aspx.cs" Inherits="User_DashboardTopper" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script> var $J = $.noConflict(true); </script>

    <asp:HiddenField ID="hnf_DailyPayoutDate" runat="server" Value="" />
    <asp:HiddenField ID="hnf_WeeklyPayoutDate" runat="server" Value="" />
    <asp:HiddenField ID="hnf_MonthlyPayoutDate" runat="server" Value="" />

    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>



    <div class="d-flex align-items-center sidebar-p-a border-bottom sidebar-account d-none d-lg-none">
        <a href="#" class="flex d-flex align-items-center text-underline-0 text-body"><span
            class="avatar mr-3">
            <asp:Image ID="ProfileImage" runat="server" CssClass="avatar-img rounded-circle"></asp:Image>
        </span><span class="flex d-flex flex-column"><strong style="font-size: 25px">
            <asp:Label ID="lblUserName" runat="server"></asp:Label>
            -
            <asp:Label ID="lbl_usrid" runat="server"></asp:Label></strong>
            <%-- <small class="text-muted" style="font-size:20px"> </small>--%>
            <span id="lbl_Status" runat="server"></span></span></a>
        <div class="dropdown ml-auto">
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
    </div>


    <div class="row">
        <div class=" col-6 col-md-6">
            <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                <h4 class="fs-20 font-w600  me-auto">Binary Dashboard</h4>
            </div>
        </div>
        <div class="col-6 col-md-6">
            <div class="daily-close pull-right mt-2">
                Daily Closing  
                <span1 id='lbl_DailyPayoutTime' runat="server"></span1>
                <span>
                    <i class="flaticon-381-alarm-clock"></i>
                </span>
            </div>
        </div>
        <div class="default-tab">
            <ul class="nav nav-pills mb-4 light text-orange" role="tablist">

                <li class="nav-item text-center">
                    <a class="nav-link active" data-bs-toggle="tab" href="#topper">
                        <div class="icon">
                            <i class="fa fa-cubes"></i>
                        </div>
                    </a>
                    <h4 class="text-primary">Binary</h4>
                </li>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#wallet">
                        <div class="icon">
                            <i class="fa fa-credit-card"></i>
                        </div>
                    </a>
                    <h4 class="text-primary">Wallet</h4>
                </li>
            </ul>
            <div class="tab-content">



                <div class="tab-pane fade active show" id="topper">
                    <div class="row">
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body">
                                            <p class="mb-0 text-left">Binary PIN/ Type</p>
                                            <h3 class=" text-end">
                                                <asp:Label ID="lbl_BinaryRank" runat="server"></asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body">
                                            <p class="mb-0">Total TCC Matching</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lblcpl" runat="server"></asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body">
                                            <p class="mb-0 text-left">Current Month Matching</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lbl_Cur_Month_Pair" runat="server"></asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3 ">
                                    <div class="media border-bottom">
                                        <div class="media-body">
                                            <p class="mb-0 text-left">Total TCC Left</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lblTotLeftBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body  p-3 pt-0 pb-1">
                                    <div class="media">
                                        <div class="media-body">
                                            <p class="mb-1 text-left">Total TCC Right</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lblTotRightBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media border-bottom">
                                        <div class="media-body text-white ">
                                            <p class="mb-1">TMI Left</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lblTotCarryLeftBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body  p-3 pt-0 pb-1">
                                    <div class="media">
                                        <div class="media-body">
                                            <p class="mb-0 text-left">TMI Right</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lblTotCarryRightBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media border-bottom">
                                        <div class="media-body">
                                            <p class="mb-0 text-left">New TCC Left</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lblNewLeftBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body  p-3 pt-0 pb-1">
                                    <div class="media">
                                        <div class="media-body">
                                            <p class="mb-0 text-left ">New TCC Right</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lblNewRightBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <h3>binary	Payout Eligibilty</h3>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body">
                                            <p class="mb-0">Self Cummulative TPV </p>
                                            <h3 class=" text-end">
                                                <asp:Label ID="lbl_CummulativeJoinfor" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body">
                                            <p class="mb-0 text-left">Self Binary</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lbl_SelfTopper" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body">
                                            <p class="mb-0 ">Validity Date</p>
                                            <h3 class="text-end">
                                                <asp:Label ID="lbl_ValidityDateTopper" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>




                </div>


                <div class="tab-pane fade" id="wallet">
                    <div class="row">


                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body">
                                            <p class="mb-0 text-left">T Wallet</p>
                                            <h3 class="text-end">
                                                <a id="lbl_TopperBal" runat="server" href="TWallet.aspx">0</a>
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-black">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body">
                                            <p class="mb-0">R Wallet</p>
                                            <h3 class="text-end">
                                                <a id="lbl_RewardBal" runat="server" href="RWallet.aspx">0</a>
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <ul>
                                <li>Reward Wallet Points will be transferred when monthly Binary Pin is upgraded
                                </li>
                                <li>All Payout Dispatch amount below Rs 100 or If Payout is on Hold or Bank details not updated - will be transferred as C Wallet Points
                                </li>

                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid page__container d-none">
        <div class="row panel card card-body">
            <div class="classic-tabs mx-2 col-lg">
                <div class="tab-content" id="myClassicTabContentOrange">
                    <div class="tab-pane fade d-none" id="contact-classic-orange" role="tabpanel" aria-labelledby="contact-tab-classic-orange">
                        <div class="card-header__title m-0 col-md-5 float-left">
                            <i class="material-icons icon-muted icon-30pt">assessment</i> Daily Closing
                            <div class="clearfix">
                            </div>

                        </div>
                        <div class="row col-md-7">
                            <div class="card card-body text-center">
                                <div class="d-flex flex-row align-items-center">
                                    <div class="card-header__title m-0">
                                        <i class="fa fa-clock"></i>
                                        <span1>Days</span1>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                    <div class="text-amount ml-auto">
                                        <span id='days1'>00</span>
                                    </div>
                                </div>
                            </div>
                            <div class="card card-body text-center">
                                <div class="d-flex flex-row align-items-center">
                                    <div class="card-header__title m-0">
                                        <i class="fa fa-clock"></i>
                                        <span1>Hours</span1>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                    <div class="text-amount ml-auto">
                                        <span id='hours1'>00</span>
                                    </div>
                                </div>
                            </div>
                            <div class="card card-body text-center">
                                <div class="d-flex flex-row align-items-center">
                                    <div class="card-header__title m-0">
                                        <i class="fa fa-clock"></i>
                                        <span1>Min</span1>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                    <div class="text-amount ml-auto">
                                        <span id='minutes1'>00</span>
                                    </div>
                                </div>
                            </div>
                            <div class="card card-body text-center">
                                <div class="d-flex flex-row align-items-center">
                                    <div class="card-header__title m-0">
                                        <i class="fa fa-clock"></i>
                                        <span1>Sec</span1>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                    <div class="text-amount ml-auto">
                                        <span id='seconds1'>00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-group" style="display: none">
                            <div class="card card-body text-center">
                                <div class="d-flex flex-row align-items-center">
                                    <div class="card-header__title m-0">
                                        <i class="material-icons icon-muted icon-30pt">shopping_basket</i> Monthly Closing
                                        <div class="clearfix">
                                        </div>
                                        <span id='lbl_MonthlyPayoutTime' runat="server"></span>
                                    </div>
                                    <div class="text-amount ml-auto" style="font-size: 15px;">
                                        <div style='border: 1px solid #fff;'>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <span id='days2'>00</span>
                                                    </td>
                                                    <td>
                                                        <span id='hours2'>00</span>
                                                    </td>
                                                    <td>
                                                        <span id='minutes2'>00</span>
                                                    </td>
                                                    <td>
                                                        <span id='seconds2'>00</span>
                                                    </td>
                                                </tr>
                                                <tr style='background: none;'>
                                                    <td>
                                                        <span1>Days</span1>
                                                    </td>
                                                    <td>
                                                        <span1>Hours</span1>
                                                    </td>
                                                    <td>
                                                        <span1>Min</span1>
                                                    </td>
                                                    <td>
                                                        <span1>Sec</span1>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div class='clearfix'>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card card-body text-center" style="display: none;">
                                <div class="d-flex flex-row align-items-center">
                                    <div class="card-header__title m-0">
                                        <i class="material-icons  icon-muted icon-30pt">perm_identity</i> Loyalty Closing
                                        <div class="clearfix">
                                        </div>
                                        <span id='lbl_LoyaltyPayoutTime' runat="server"></span>
                                    </div>
                                    <div class="text-amount ml-auto" style="font-size: 15px;">
                                        <div style='border: 1px solid #fff;'>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <span id='days3'>00</span>
                                                    </td>
                                                    <td>
                                                        <span id='hours3'>00</span>
                                                    </td>
                                                    <td>
                                                        <span id='minutes3'>00</span>
                                                    </td>
                                                    <td>
                                                        <span id='seconds3'>00</span>
                                                    </td>
                                                </tr>
                                                <tr style='background: none;'>
                                                    <td>
                                                        <span1>Days</span1>
                                                    </td>
                                                    <td>
                                                        <span1>Hours</span1>
                                                    </td>
                                                    <td>
                                                        <span1>Min</span1>
                                                    </td>
                                                    <td>
                                                        <span1>Sec</span1>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div class='clearfix'>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade hidden" id="contact-classic-orange" role="tabpanel" aria-labelledby="contact-tab-classic-orange"
                        style="display: none;">
                        <section class="main--content">
                            <div class="row gutter-20">
                                <div class="col-xl-3 col-md-6">
                                    <div class="panel">
                                        <div style="background: #fff; border: 1px solid #a2c842; color: #546e7a;">
                                            <center>
                                                <asp:Image ID="Image1" runat="server" Height="150px" Width="100%" /></center>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-md-6">
                                    <div class="panel">
                                        <div class="weather--panel text-white bg-blue">
                                            <div class="weather--title">
                                                <i class="fa fa-map-marker-alt"></i>
                                                <span><a href="#">
                                                    <div id="MainContent_alertPan2">
                                                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="UploadPanCard.aspx" Style="color: #fff;"><i class="fa fa-file-text-o" aria-hidden="true"></i>  &nbsp;<span style="color: #fff; font-weight:bold;"> PAN Verification Status: ---Verify </span></asp:HyperLink>
                                                </a></span>
                                            </div>
                                        </div>

                                        <div class="weather--info">
                                            <span>Your PAN is <strong>
                                                <asp:Label ID="lblpanvarify" runat="server" Text="Not Verified"></asp:Label></strong>
                                                and Your status is <strong>
                                                    <asp:Label ID="lblpanconfirmed" runat="server" Text="Not Confirmed"></asp:Label>
                                                </strong>&nbsp; <a id="a1" runat="server" href="docdetail.aspx?doctype=P" style="font-weight: bold;">View Status</a></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="panel">
                                    <div class="weather--panel text-white bg-orange">
                                        <div class="weather--title">

                                            <a href="#">
                                                <div id="MainContent_alertKyc2">
                                                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="AddressProof.aspx" Style="color: #fff;">
                                    <i class="fa fa-files-o" aria-hidden="true"></i> &nbsp; <span style="color: #fff; font-weight:bold;"> Aadhaar Verification Status: ---Verify </span></asp:HyperLink>
                                                </div>
                                            </a>
                                        </div>

                                        <div class="weather--info">

                                            <span>Your documents are <strong>
                                                <asp:Label ID="lblkycvarify" runat="server" Text="Not Verified"></asp:Label></strong>
                                                and Your status is <strong>
                                                    <asp:Label ID="lblkycconfirmed" runat="server" Text="Not Confirmed"></asp:Label></strong>&nbsp;
                                    <a id="a3" runat="server" href="docdetail.aspx?doctype=A" style="font-weight: bold;">View Status</a></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="panel">
                                    <div class="weather--panel text-white bg-green">
                                        <div class="weather--title">
                                            <div id="MainContent_alertBank2">
                                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="AddBank.aspx" Style="color: #fff;"><i class="fa fa-university" aria-hidden="true"></i> &nbsp;<span style="color: #fff; font-weight:bold;">   Bank Verification Status: ---Verify </span></asp:HyperLink>

                                            </div>


                                        </div>

                                        <div class="weather--info">
                                            Your document is <strong>
                                                <asp:Label ID="lblbankvarify" runat="server" Text="Not Verified"></asp:Label></strong>
                                            and Your status is <strong>
                                                <asp:Label ID="lblbankconfirmed" runat="server" Text="Not Confirmed"></asp:Label></strong>&nbsp;
                                    <a id="a2" runat="server" href="docdetail.aspx?doctype=B" style="font-weight: bold;">View Status</a>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div class="tab-pane fade" id="awesome-classic-orange" role="tabpanel" aria-labelledby="awesome-tab-classic-orange">
                        <div id="Div3" style="background: #fff; /*border: 1px solid #546e7a; box-shadow: 0px 3px 3px 3px  #ececec; */ font-size: 20px; padding: 0px 9px 0px; color: #2bb3c0; font-weight: 700;">
                            <marquee behavior="scroll" onmouseover="this.stop();" height="20" onmouseout="this.start();"
                                direction="left" scrollamount="2" style="line-height: 20px; color: red;">
                                <div runat="server" id="dvNews">
                                </div>
                            </marquee>
                            <%--<div id="ctl00_ContentPlaceHolder1_div2" style="text-align: right; padding-right: 35px;
                            font-weight: bold; color: Green" height="300">
                            <a href="#" id="ctl00_ContentPlaceHolder1_a2" class="viewall view-bu" style="color: #fff;">
                                View All</a>
                            </div>--%>
                        </div>
                    </div>



                </div>
            </div>
        </div>
    </div>
    <!-- // END drawer-layout__content -->
    <div class="clearfix">
    </div>

    <link rel="stylesheet" type="text/css" href="../popup/style.css" />




    <script type="text/javascript">


        function HideMe() {
            jQuery('.popup1').hide();
            jQuery('#fade').hide();
        }

        $(function () {
            DailyPayoutdate($('#<%=hnf_DailyPayoutDate.ClientID%>').val());
            MonthlyPayoutdate($('#<%=hnf_MonthlyPayoutDate.ClientID%>').val());
            WeeklyPayoutdate($('#<%=hnf_WeeklyPayoutDate.ClientID%>').val());

        });


        function DailyPayoutdate(db_date) {
            // alert(db_date);
            // debugger;
            var days1, hours1, minutes1, sec1, timer1;
            end1 = new Date(db_date);
            end1 = end1.getTime();
            if (isNaN(end1)) {
                // alert(' "Invalid Date format- mm/dd/yyyy hh:mm:ss TT ');
                return;
            }

            timer1 = setInterval(calculate1, 1000);
            function calculate1() {
                var current1 = new Date();
                var remaining1 = parseInt((end1 - current1.getTime()) / 1000);
                if (remaining1 <= 0) {
                    clearInterval(timer1);
                    days1 = 0;
                    hours1 = 0;
                    minutes1 = 0;
                    sec1 = 0;
                    display1(days1, hours1, minutes1, sec1);
                } else {

                    days1 = parseInt(remaining1 / 86400);
                    remaining1 = (remaining1 % 86400);
                    hours1 = parseInt(remaining1 / 3600);
                    remaining1 = (remaining1 % 3600);
                    minutes1 = parseInt(remaining1 / 60);
                    remaining1 = (remaining1 % 60);
                    sec1 = parseInt(remaining1);

                    display1(days1, hours1, minutes1, sec1);
                }
            }

            function display1(days1, hours1, minutes1, sec1) {
                var dl1 = days1.toString().length;
                if (dl1 == "1") {
                    sl1 = 2;
                } else {
                    if (isNaN(dl1)) {
                        sl1 = 3;
                    }
                    sl1 = dl1;
                }

                document.getElementById("days1").innerHTML = ("00" + days1).slice(-sl1);
                document.getElementById("hours1").innerHTML = ("0" + hours1).slice(-2);
                document.getElementById("minutes1").innerHTML = ("0" + minutes1).slice(-2);
                document.getElementById("seconds1").innerHTML = ("0" + sec1).slice(-2);
            }
        }

        function MonthlyPayoutdate(db_date) {
            var days2, hours2, minutes2, sec2, timer2;
            end2 = new Date(db_date);
            end2 = end2.getTime();
            if (isNaN(end2)) {
                // alert(' "Invalid Date format- mm/dd/yyyy hh:mm:ss TT ');
                return;
            }

            timer2 = setInterval(calculate2, 1000);
            function calculate2() {
                var current2 = new Date();
                var remaining2 = parseInt((end2 - current2.getTime()) / 1000);
                if (remaining2 <= 0) {
                    clearInterval(timer2);
                    days2 = 0;
                    hours2 = 0;
                    minutes2 = 0;
                    sec2 = 0;
                    display2(days2, hours2, minutes2, sec2);
                } else {

                    days2 = parseInt(remaining2 / 86400);
                    remaining2 = (remaining2 % 86400);
                    hours2 = parseInt(remaining2 / 3600);
                    remaining2 = (remaining2 % 3600);
                    minutes2 = parseInt(remaining2 / 60);
                    remaining2 = (remaining2 % 60);
                    sec2 = parseInt(remaining2);

                    display2(days2, hours2, minutes2, sec2);
                }
            }

            function display2(days2, hours2, minutes2, sec2) {
                var dl2 = days2.toString().length;
                if (dl2 == "1") {
                    sl2 = 2;
                } else {
                    if (isNaN(dl2)) {
                        sl2 = 3;
                    }
                    sl2 = dl2;
                }

                document.getElementById("days2").innerHTML = ("00" + days2).slice(-sl2);
                document.getElementById("hours2").innerHTML = ("0" + hours2).slice(-2);
                document.getElementById("minutes2").innerHTML = ("0" + minutes2).slice(-2);
                document.getElementById("seconds2").innerHTML = ("0" + sec2).slice(-2);
            }
        }

        function WeeklyPayoutdate(db_date) {

            var days3, hours3, minutes3, sec3, timer3;
            end3 = new Date(db_date);
            end3 = end3.getTime();
            if (isNaN(end3)) {
                // alert(' "Invalid Date format- mm/dd/yyyy hh:mm:ss TT ');
                return;
            }

            timer3 = setInterval(calculate3, 1000);
            function calculate3() {
                var current3 = new Date();
                var remaining3 = parseInt((end3 - current3.getTime()) / 1000);
                if (remaining3 <= 0) {
                    clearInterval(timer3);
                    days3 = 0;
                    hours3 = 0;
                    minutes3 = 0;
                    sec3 = 0;
                    display3(days3, hours3, minutes3, sec3);
                } else {

                    days3 = parseInt(remaining3 / 86400);
                    remaining3 = (remaining3 % 86400);
                    hours3 = parseInt(remaining3 / 3600);
                    remaining3 = (remaining3 % 3600);
                    minutes3 = parseInt(remaining3 / 60);
                    remaining3 = (remaining3 % 60);
                    sec3 = parseInt(remaining3);

                    display3(days3, hours3, minutes3, sec3);
                }
            }

            function display3(days3, hours3, minutes3, sec3) {
                var dl3 = days3.toString().length;
                if (dl3 == "1") {
                    sl3 = 2;
                } else {
                    if (isNaN(dl3)) {
                        sl3 = 3;
                    }
                    sl3 = dl3;
                }

                document.getElementById("days3").innerHTML = ("00" + days3).slice(-sl3);
                document.getElementById("hours3").innerHTML = ("0" + hours3).slice(-2);
                document.getElementById("minutes3").innerHTML = ("0" + minutes3).slice(-2);
                document.getElementById("seconds3").innerHTML = ("0" + sec3).slice(-2);
            }
        }
    </script>


    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../Grid_js_css/buttons.dataTables.css" rel="stylesheet" />

    <script src="../Grid_js_css/jquery-3.5.1.js" type="text/javascript"></script>
    <script src="../Grid_js_css/jquery.dataTables.js" type="text/javascript"></script>
    <script src="../Grid_js_css/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/jszip.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/pdfmake.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/vfs_fonts.js" type="text/javascript"></script>
    <script src="../Grid_js_css/buttons.html5.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/buttons.print.min.js" type="text/javascript"></script>
    <script> var $JDT = $.noConflict(true); </script>

    <script type="text/javascript">

        function CurrencyFormate(Amount) {
            var Cur = new Intl.NumberFormat('en-IN').format(Amount);
            return Cur;
        }

        function dateFormate(datevalue) {
            var date_arr = "";
            var newformat = "";
            date_arr = datevalue.split('/');
            if (date_arr.length > 0) {
                newformat = date_arr[1] + '/' + date_arr[0] + '/' + date_arr[2];
            }
            if (datevalue == "") {
                newformat = '';
            }
            return newformat;
        }




    </script>


    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>


    <script type="text/javascript" src="https://cdn.jsdelivr.net/jsbarcode/3.6.0/JsBarcode.all.min.js"></script>

    <style>
        @media (min-width: 576px) {
            .modal-dialog {
                max-width: 650px;
                margin: 1.75rem auto;
            }
        }
    </style>



    <asp:HiddenField ID="hnd_Popup" runat="server" Value="" />
    <script type="text/javascript">
        $(function () {
            if ($('#<%=hnd_Popup.ClientID%>').val() == "1") {
                $('.bd-example-modal-md').show();
            }
        });

        function closePopup() {
            $('.bd-example-modal-md').hide();
        }
    </script>



    <div class="modal fade bd-example-modal-md show" tabindex="-1" style="padding-right: 17px; background: #000000ab;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup()" style="position: absolute; right: 5px; top: 5px;">
                </button>
                <div id="div_Popup_img" runat="server"></div>

            </div>
        </div>
    </div>

    <style>
        .container-fluid {
            background: #F8F8F8 !important;
        }
    </style>

</asp:Content>


