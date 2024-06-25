<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs" Inherits="User_Dashboard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script> var $J = $.noConflict(true); </script>
    <script type="text/javascript">

        $J(function () {
            ScanStatus();
        });

        function copyToClipboard(text) {
            window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
        }

        function ScanStatus() {

            $.ajax({
                type: "POST",
                url: 'Dashboard.aspx/CheckStatus',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $('#kyc').show();

                    if (data.d.length == '0') {
                        $('#pdDiv').addClass("bg-red");
                        $("#pLabel").text("Pending");
                        $("#plxp").show();

                        $('#bdDiv').addClass("bg-red");
                        $("#bLabel").text("Pending");
                        $("#plxb").show();

                        $('#abDiv').addClass("bg-red");
                        $("#aLabel").text("Pending");
                        $("#plxa").show();
                    }


                    if (data != null) {
                        $.each(data.d, function (index, d) {

                            if (d.veri == "1") {
                                $('#kyc').css("color", "#48BA16");
                                $('#pdDiv').addClass("bg-dark-green");
                                $('#bdDiv').addClass("bg-dark-green");
                                $('#abDiv').addClass("bg-dark-green");

                                $("#aLabel").text("Approved");
                                $("#plxa").hide();

                                $("#pLabel").text("Approved");
                                $("#plxp").hide();

                                $("#bLabel").text("Approved");
                                $("#plxb").hide();
                            }
                            else {

                                if (d.psts == "0") {
                                    $('#pdDiv').addClass("bg-red");
                                    $("#pLabel").text("Pending");
                                    $("#plxp").show();
                                }
                                if (d.psts == "1") {
                                    $('#pdDiv').addClass("bg-pending");
                                    $("#pLabel").text("Approval Pending");
                                    $("#plxp").hide();
                                }
                                if (d.psts == "2") {
                                    $('#pdDiv').addClass("bg-dark-green");
                                    $("#pLabel").text("Approved");
                                    $("#plxp").hide();
                                }

                                if (d.bsts == "0") {
                                    $('#bdDiv').addClass("bg-red");
                                    $("#bLabel").text("Pending");
                                    $("#plxb").show();
                                }
                                if (d.bsts == "1") {
                                    $('#bdDiv').addClass("bg-pending");
                                    $("#bLabel").text("Approval Pending");
                                    $("#plxb").hide();
                                }
                                if (d.bsts == "2") {
                                    $('#bdDiv').addClass("bg-dark-green");
                                    $("#bLabel").text("Approved");
                                    $("#plxb").hide();
                                }

                                if (d.asts == "0") {
                                    $('#abDiv').addClass("bg-red");
                                    $("#aLabel").text("Pending");
                                    $("#plxa").show();
                                }
                                if (d.asts == "1") {
                                    $('#abDiv').addClass("bg-pending");
                                    $("#aLabel").text("Approval Pending");
                                    $("#plxa").hide();
                                }
                                if (d.asts == "2") {
                                    $('#abDiv').addClass("bg-dark-green");
                                    $("#aLabel").text("Approved");
                                    $("#plxa").hide();
                                }

                            }
                        });


                    }
                    else {
                        $('#kyc-classic-orange').hide();
                    }

                },
                error: function (response) {
                    $('#kyc-classic-orange').hide();
                    $('#kyc-classic-orange').text("Server error. Time out.!!");

                }
            });

        }
    </script>

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
                <h4 class="fs-20 font-w600  me-auto">Dashboard</h4>
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
                    <a class="nav-link active" data-bs-toggle="tab" href="#generation">
                        <img src="images/genretion.png" width="65px" />
                    </a>
                    <span class="text-primary">Generation</span>
                </li>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#topper">
                        <img src="images/topper.png" width="65px" />
                    </a>
                    <span class="text-primary">Topper</span>
                </li>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#loyalty">
                        <img src="images/loylaty.png" width="65px" />
                    </a>
                    <span class="text-primary">Loyalty</span>
                </li>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#RetailBooster">
                        <img src="images/retail_booster.png" width="65px" />
                    </a>
                    <span class="text-primary">Retail Booster</span>
                </li>

                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#tours" onclick="GetTourList();">
                        <img src="images/tour.png" width="65px" />
                    </a>
                    <span class="text-primary">Tours</span>
                </li>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#wallet">
                        <img src="images/wallet.png" width="65px" />
                    </a>
                    <span class="text-primary">Wallet</span>
                </li>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#kyc1">
                        <img src="images/kyc.png" width="65px" />
                    </a>
                    <span class="text-primary">KYC</span>
                </li>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#luckydraw">
                        <img src="images/luckydraw.png" width="65px" />
                    </a>
                    <span class="text-primary">Lucky Draw</span>
                </li>
                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#goa_qualify">
                        <img src="images/goa_qualify.png" width="65px">
                    </a>
                    <span class="text-primary">Offer Qualify</span>
                    <div id="div_GoaQualifyCount" runat="server" class="text-blue" style="position: relative; top: -96px; right: -12px; font-size: 20px; font-weight: 500; color: #0f306f;">0</div>
                </li>

                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#Achievement">
                        <img src="images/achievement.png" width="65px" />
                    </a>
                    <span class="text-primary">Achievement</span>
                </li>

                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#EventTour" onclick="BindEventTour();">
                        <img src="images/event-barcode.png" width="65px" />
                    </a>
                    <span class="text-primary">Event Tour</span>
                </li>

            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active show" id="generation" role="tabpanel">
                    <div class="row">
                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Generation Pin</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_RepurchaseRank" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body text-white ">
                                            <p class="mb-0 text-dark">No. Of Associate</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_NoOfAssociate" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Direct Associate</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblSponsor" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-dark">Paid Direct Associate</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblPaidSponsor" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="" id="user-activity1">
                            <div class="card-header border-0 p-0 pb-4">
                                <%--<h4 class="fs-20 mb-1">Chart</h4>--%>
                                <div class="card-action coin-tabs">
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-bs-toggle="tab" href="#daily1" role="tab" aria-selected="false">Current Month</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-bs-toggle="tab" href="#weekly1" role="tab" aria-selected="true">Previous Month</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-bs-toggle="tab" href="#monthly1" role="tab" aria-selected="false">Cumulative</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body p-0">

                                <div class="tab-content" id="myTabContent">
                                    <div class="tab-pane fade active show" id="daily1">
                                        <%-- <h2>Current Month</h2>--%>
                                        <div class="row">
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-blue">
                                                    <div class="card-body  p-3">
                                                        <div class="media">
                                                            <div class="media-body text-white">
                                                                <p class="mb-0 text-left">RPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_currentMonth_PPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-grey">
                                                    <div class="card-body  p-3">
                                                        <div class="media">

                                                            <div class="media-body text-white ">
                                                                <p class="mb-0 text-dark">GPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_currentMonth_GPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-blue">
                                                    <div class="card-body  p-3">
                                                        <div class="media">
                                                            <div class="media-body text-white">
                                                                <p class="mb-0 text-left">TPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_currentMonth_TPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-grey">
                                                    <div class="card-body  p-3">
                                                        <div class="media">

                                                            <div class="media-body text-white ">
                                                                <p class="mb-0 text-dark">GPV+TPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_currentMonth_TGBV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade " id="weekly1">

                                        <%-- <h2>Previous Month</h2>--%>
                                        <div class="row">
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-blue">
                                                    <div class="card-body  p-3">
                                                        <div class="media">
                                                            <div class="media-body text-white">
                                                                <p class="mb-0 text-left">RPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_Previous_PPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-grey">
                                                    <div class="card-body  p-3">
                                                        <div class="media">

                                                            <div class="media-body text-white ">
                                                                <p class="mb-0 text-dark">GPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_Previous_GPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-blue">
                                                    <div class="card-body  p-3">
                                                        <div class="media">
                                                            <div class="media-body text-white">
                                                                <p class="mb-0 text-left">TPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_Previous_TPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-grey">
                                                    <div class="card-body  p-3">
                                                        <div class="media">

                                                            <div class="media-body text-white ">
                                                                <p class="mb-0 text-dark">GPV+TPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_Previous_TGBV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="monthly1">
                                        <%-- <h2>Cumulative</h2>--%>
                                        <div class="row">
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-blue">
                                                    <div class="card-body  p-3">
                                                        <div class="media">
                                                            <div class="media-body text-white">
                                                                <p class="mb-0 text-left">RPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_Cumulative_PPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-grey">
                                                    <div class="card-body  p-3">
                                                        <div class="media">

                                                            <div class="media-body text-white ">
                                                                <p class="mb-0 text-dark">GPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_Cumulative_GPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-blue">
                                                    <div class="card-body  p-3">
                                                        <div class="media">
                                                            <div class="media-body text-white">
                                                                <p class="mb-0 text-left">TPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_Cumulative_TPV" runat="server">0</asp:Label></h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                                                <div class="widget-stat card bg-grey">
                                                    <div class="card-body  p-3">
                                                        <div class="media">

                                                            <div class="media-body text-white ">
                                                                <p class="mb-0 text-dark">GPV+TPV</p>
                                                                <h3 class="text-orange text-end">
                                                                    <asp:Label ID="lbl_Cumulative_TGBV" runat="server">0</asp:Label></h3>
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

                    </div>
                    <div class="row">
                        <div class="col-xl-9">
                            <!--#include virtual="Highcharts.aspx"-->
                        </div>
                        <div class="col-xl-3">
                            <div class="col-md-12">
                                <h3>Generation Payout Eligibility</h3>
                            </div>
                            <div class="col-xl-12">
                                <div class="widget-stat card bg-blue">
                                    <div class="card-body  p-3">
                                        <div class="media">
                                            <div class="media-body text-white">
                                                <p class="mb-0 text-left">Required</p>
                                                <h3 class="text-orange text-end">
                                                    <asp:Label ID="lbl_Rep_Required" runat="server">0</asp:Label></h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-12">
                                <div class="widget-stat card bg-grey">
                                    <div class="card-body  p-3">
                                        <div class="media">
                                            <div class="media-body text-white ">
                                                <p class="mb-0 text-dark">Achieved</p>
                                                <h3 class="text-orange text-end">
                                                    <asp:Label ID="lbl_Rep_Achieved" runat="server">0</asp:Label>
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-12">
                                <div class="widget-stat card bg-blue">
                                    <div class="card-body  p-3">
                                        <div class="media">
                                            <div class="media-body text-white">
                                                <p class="mb-0 text-left">Shortfall</p>
                                                <h3 class="text-orange text-end">
                                                    <asp:Label ID="lbl_Rep_Shortfall" runat="server">0</asp:Label>

                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>





                    <div class="card-header card-header-large bg-white d-none">
                        <h2>Reference Link
                        </h2>
                    </div>
                    <div class="card-group d-none">
                        <div class="card card-body text-center">
                            <div class="align-items-center">
                                <div class="">
                                    <span class="badge badge-primary">Left Referral </span>
                                </div>
                                <div class="clearfix">
                                </div>
                                <div class="text-amount ml-auto">
                                    <asp:LinkButton ID="lblUserInLeft" runat="server" ForeColor='#315787' Font-Size='24px'
                                        OnClick="lblUserInLeft_Click" OnClientClick="aspnetForm.target ='_blank';"></asp:LinkButton>
                                </div>
                                <div class="">
                                    <button id="demo" onclick="copyToClipboard($('#<%=lblUserInLeft.ClientID %>').text())">
                                        Copy Text</button>
                                </div>
                            </div>
                        </div>
                        <div class="card card-body text-center">
                            <div class="align-items-center">
                                <div class="">
                                    <span class="badge badge-success">Right Referral </span>
                                </div>
                                <div class="clearfix">
                                </div>
                                <div class="text-amount ml-auto">
                                    <asp:LinkButton ID="lblUserInRight" runat="server" ForeColor='#315787' Font-Size='24px'
                                        OnClick="lblUserInRight_Click" OnClientClick="aspnetForm.target ='_blank';"></asp:LinkButton>
                                </div>
                                <div class="">
                                    <button id="demo1" onclick="copyToClipboard($('#<%=lblUserInRight.ClientID %>').text())">
                                        Copy Text</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="tab-pane fade" id="topper">
                    <div class="row">
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Topper PIN/ Type</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_BinaryRank" runat="server"></asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body text-white ">
                                            <p class="mb-0 text-dark">Total TCC Matching</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblcpl" runat="server"></asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Current Month Matching</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_Cur_Month_Pair" runat="server"></asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3 ">
                                    <div class="media border-bottom">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Total TCC Left</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblTotLeftBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body  p-3 pt-0 pb-1">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-1 text-left">Total TCC Right</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblTotRightBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body  p-3">
                                    <div class="media border-bottom">

                                        <div class="media-body text-white ">
                                            <p class="mb-1 text-dark">TMI Left</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblTotCarryLeftBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body  p-3 pt-0 pb-1">
                                    <div class="media">
                                        <div class="media-body">
                                            <p class="mb-0 text-left text-dark">TMI Right</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblTotCarryRightBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media border-bottom">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">New TCC Left</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblNewLeftBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body  p-3 pt-0 pb-1">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left ">New TCC Right</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lblNewRightBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <h3>Topper	Payout Eligibilty</h3>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body text-white ">
                                            <p class="mb-0 text-white">Self Cummulative TPV </p>
                                            <h3 class=" text-end">
                                                <asp:Label ID="lbl_CummulativeJoinfor" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left text-dark">Self Topper</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_SelfTopper" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body text-white ">
                                            <p class="mb-0 ">Validity Date</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_ValidityDateTopper" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>




                </div>
                <div class="tab-pane fade" id="loyalty">


                    <div id="div_MonthlyPurchaseRoyalty" runat="server" class="card-group-row row"></div>

                </div>
                <div class="tab-pane fade" id="RetailBooster">
                    <div id="div_RetailBooster" runat="server" class="card-group-row row"></div>

                </div>

                <div class="tab-pane fade" id="tours">
                    <div class="row">


                        <div class="col-md-12">
                            <div id="div_TourInternational_Generation" class="card card-form table-responsive border-bottom"
                                data-toggle="lists" data-lists-values="[&quot;js-lists-values-employee-name&quot;]">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div id="div_TourDomestic_Generation" class="card card-form table-responsive border-bottom "
                                data-toggle="lists" data-lists-values="[&quot;js-lists-values-employee-name&quot;]">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div id="div_TourInternational_Topper" class="card card-form table-responsive border-bottom"
                                data-toggle="lists" data-lists-values="[&quot;js-lists-values-employee-name&quot;]">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div id="div_TourDomestic_Topper" class="card card-form table-responsive border-bottom "
                                data-toggle="lists" data-lists-values="[&quot;js-lists-values-employee-name&quot;]">
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div id="div_TourProduct_Generation" class="card card-form table-responsive border-bottom"
                                data-toggle="lists" data-lists-values="[&quot;js-lists-values-employee-name&quot;]">
                            </div>
                        </div>

                        <%--<div class="col-md-6">
                            <div id="div_TourListDomestic" runat="server" class="card card-form table-responsive border-bottom"
                                data-toggle="lists" data-lists-values="[&quot;js-lists-values-employee-name&quot;]">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div id="div_TourListInternational" runat="server" class="card card-form table-responsive border-bottom "
                                data-toggle="lists" data-lists-values="[&quot;js-lists-values-employee-name&quot;]">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div id="div_TourListTopper" runat="server" class="card card-form table-responsive border-bottom"
                                data-toggle="lists" data-lists-values="[&quot;js-lists-values-employee-name&quot;]">
                            </div>
                        </div>--%>
                    </div>
                </div>
                <div class="tab-pane fade" id="wallet">
                    <div class="row">
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">C Wallet</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_C_Wallet" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body text-white ">
                                            <p class="mb-0 text-dark">G Wallet</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_P_Wallet" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">T Wallet</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_TopperBal" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body text-white ">
                                            <p class="mb-0 text-dark">R Wallet</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_RewardBal" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Loyalty</p>
                                            <h3 class="text-orange text-end">
                                                <asp:Label ID="lbl_LoyaltyWallet" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <ul>
                                <li>Reward Wallet Points will be transferred when monthly Topper PIN is upgraded
                                </li>
                                <li>All Payout Dispatch amount below Rs 100 or If Payout is on Hold or Bank details not updated - will be transferred as C Wallet Points
                                </li>

                            </ul>
                        </div>
                    </div>
                </div>
                <%-- kyc-classic-orange--%>
                <div class="tab-pane fade" id="kyc1">
                    <div class="row">

                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div id="pdDiv" class="widget-stat card">
                                <a href="Changeprofile.aspx?d=1">
                                    <div class="card-body p-3">
                                        <div class="media">
                                            <div class="media-body text-white">
                                                <p class="mb-3 text-left">Pan Card</p>
                                                <h3 class=" text-end text-black">
                                                    <span id="pLabel" style="color: white;">0</span> <span id="plxp" style="color: white;">(click here)</span>
                                                </h3>
                                                <%--Approved--%>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div id="abDiv" class="widget-stat card">
                                <a href="Changeprofile.aspx?d=3">
                                    <div class="card-body  p-3">
                                        <div class="media">

                                            <div class="media-body text-white">
                                                <p class="mb-3">Aadhaar Card</p>
                                                <h3 class=" text-end text-black">
                                                    <span id="aLabel" style="color: white;">0</span> <span id="plxa" style="color: white;">(click here)</span>
                                                    <%--<h3 class="text-black text-end">Approved</h3>--%>
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div id="bdDiv" class="widget-stat card">
                                <a href="Changeprofile.aspx?d=2">
                                    <div class="card-body  p-3">
                                        <div class="media">
                                            <div class="media-body text-white">
                                                <p class="mb-3 text-left">Bank Details</p>

                                                <%--<h3 class="text-end text-white">Reject</h3>--%>
                                                <h3 class=" text-end text-black">
                                                    <span id="bLabel" style="color: white;">0</span> <span id="plxb" style="color: white;">(click here)</span>
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
                <%-- LuckyDraw-classic-orange--%>
                <div class="tab-pane fade" id="luckydraw">
                    <div class="row">
                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Lucky Draw</p>
                                            <h3 class="text-white text-end">
                                                <a href="LoyaltyCoupon.aspx" class="text-white" id="lbl_Coupon" runat="server">0</a></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Goa toure--%>
                <div class="tab-pane fade" id="goa_qualify">
                    <div class="row">
                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Goa Qualify</p>
                                            <h5 class="text-white">Current Month: <a href="#/" class="text-white  text-end" id="div_GoaCount" runat="server">0</a></h5>
                                            <h5 class="text-white">Accumulative: <a href="#/" class="text-white  text-end" id="div_GoaCountTotal" runat="server">0</a></h5>
                                            <%--<div  class="text-black" style="position: relative; top: -95px; right: -20px; font-size: 20px; font-weight: 500;">0</div> --%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white ">
                                            <p class="mb-0 text-dark">6th Anniversary Entry Pass</p>
                                            <h3 class="text-orange text-end"></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>



                <div class="tab-pane fade" id="Achievement">

                    <div class="row">

                        <div class="col-md-3">
                            <asp:DropDownList ID="ddl_SearchTyp" runat="server" CssClass="form-control" onchange="SH_Achieving();">
                                <asp:ListItem Value="GenerationRank">Generation Rank</asp:ListItem>
                                <asp:ListItem Value="TopperRank">Topper Rank</asp:ListItem>
                                <asp:ListItem Value="DomesticTour">Domestic Tour</asp:ListItem>
                                <asp:ListItem Value="InternationalTour">International Tour</asp:ListItem>
                                <asp:ListItem Value="Loyalty">Loyalty</asp:ListItem>
                                <asp:ListItem Value="RetailBoosterLoyalty">Retail Booster Loyalty</asp:ListItem>
                                <asp:ListItem Value="Staterfund">Stater Fund</asp:ListItem>
                                <asp:ListItem Value="TopEarnersclub">Top Earners Club</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-3">
                            <asp:DropDownList ID="ddl_Month" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-2">
                            <input type="button" class="btn btn-primary" value="Search" onclick="GetAchieving();" />
                        </div>

                    </div>
                    <div class="clearfix"></div>

                    <div class="table-responsive">
                        <table id="div_tblDownload" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
                            <tfoot align="left">
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </tfoot>
                        </table>

                    </div>

                </div>



                <div class="clearfix"></div>
                <div class="tab-pane fade" id="EventTour">
                    <div class="clearfix"></div>
                    <div id="div_EventTour"></div>

                    <%-- <svg id="barcode"></svg>--%>
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
                                </div></marquee>
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

    <%-- <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>--%>



    <script type="text/javascript">
      <%--  $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });--%>

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

        function GetAchieving() {

            let flag = $('#<%=ddl_SearchTyp.ClientID%>').val();
            let Month = $('#<%=ddl_Month.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: 'Dashboard.aspx/GetAchieving',
                data: '{ flag: "' + flag + '", Month: "' + Month + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    $('#LoaderImg').hide();

                    //$('#div_tblDownload').empty();
                    //if (flag == "GenerationRank" || flag == "TopperRank") {
                    //    $('#div_tblDownload').append("<tr>");
                    //    $('#div_tblDownload').append("<th>#</th>");
                    //    $('#div_tblDownload').append("<th>Date</th>");
                    //    $('#div_tblDownload').append("<th>ACHV. Type</th>");
                    //    $('#div_tblDownload').append("<th>ACHV.</th>");
                    //    $('#div_tblDownload').append("<th><i class='fa fa-download' aria-hidden='true'></i></th>");
                    //    $('#div_tblDownload').append("</tr><tbody>");
                    //}

                    //if (flag == "DomesticTour" || flag == "InternationalTour") {
                    //    $('#div_tblDownload').append("<tr>");
                    //    $('#div_tblDownload').append("<th>#</th>");
                    //    $('#div_tblDownload').append("<th>Date</th>");
                    //    $('#div_tblDownload').append("<th>Generation Pin</th>");
                    //    $('#div_tblDownload').append("<th>Tour Name</th>");
                    //    $('#div_tblDownload').append("<th><i class='fa fa-download' aria-hidden='true'></i></th>");
                    //    $('#div_tblDownload').append("</tr><tbody>");
                    //}

                    //if (flag == "Loyalty") {
                    //    $('#div_tblDownload').append("<tr>");
                    //    $('#div_tblDownload').append("<th>#</th>");
                    //    $('#div_tblDownload').append("<th>Payout Period</th>");
                    //    $('#div_tblDownload').append("<th>QLFY</th>");
                    //    $('#div_tblDownload').append("<th>Amount</th>");
                    //    $('#div_tblDownload').append("<th><i class='fa fa-download' aria-hidden='true'></i></th>");
                    //    $('#div_tblDownload').append("</tr><tbody>");
                    //}
                    //if (flag == "RetailBoosterLoyalty") {
                    //    $('#div_tblDownload').append("<tr>");
                    //    $('#div_tblDownload').append("<th>#</th>");
                    //    $('#div_tblDownload').append("<th>Payout Period</th>");
                    //    $('#div_tblDownload').append("<th>QLFY</th>");
                    //    $('#div_tblDownload').append("<th>Amount</th>");
                    //    $('#div_tblDownload').append("<th><i class='fa fa-download' aria-hidden='true'></i></th>");
                    //    $('#div_tblDownload').append("</tr><tbody>");
                    //}

                    //if (flag == "Staterfund") {
                    //    $('#div_tblDownload').append("<tr>");
                    //    $('#div_tblDownload').append("<th>#</th>");
                    //    $('#div_tblDownload').append("<th>Date</th>");
                    //    // $('#div_tblDownload').append("<th>QLFY</th>");
                    //    $('#div_tblDownload').append("<th>Amount</th>");
                    //    $('#div_tblDownload').append("<th><i class='fa fa-download' aria-hidden='true'></i></th>");
                    //    $('#div_tblDownload').append("</tr><tbody>");
                    //}

                    //if (flag == "TopEarnersclub") {
                    //    $('#div_tblDownload').append("<tr>");
                    //    $('#div_tblDownload').append("<th>#</th>");
                    //    $('#div_tblDownload').append("<th>Date</th>");
                    //    $('#div_tblDownload').append("<th>Amount</th>");
                    //    $('#div_tblDownload').append("<th><i class='fa fa-download' aria-hidden='true'></i></th>");
                    //    $('#div_tblDownload').append("</tr><tbody>");
                    //}


                    //let tblContent = "";
                    for (var i = 0; i < data.d.length; i++) {


                        if (flag == "GenerationRank" || flag == "TopperRank") {
                            json.push([i + 1,
                            '<a href="../secretadmin/Template_Tour.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].Rank + '&RN=' + data.d[i].RN
                            + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>',
                            data.d[i].Month,
                            data.d[i].Rank,
                            data.d[i].RN,
                            ]);
                        }


                        if (flag == "DomesticTour") {

                            json.push([i + 1,
                            '<a href="../secretadmin/Template_Tour.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].Rank + '&RN=' + data.d[i].RN
                            + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>',
                            data.d[i].Month,
                            data.d[i].Rank,
                            data.d[i].RN,
                            ]);


                            //if (data.d[i].Rank == "Domestic Tour") {
                            //    tblContent += '<tr>';
                            //    tblContent += '<td>' + (i + 1) + '</td>';
                            //    tblContent += '<td>' + data.d[i].Month + '</td>';
                            //    tblContent += '<td>' + data.d[i].Rank + '</td>';
                            //    tblContent += '<td>' + data.d[i].RN + '</td>';
                            //    tblContent += '<td> </td>';
                            //    tblContent += '</tr>';
                            //}
                        }

                        if (flag == "InternationalTour") {
                            json.push([i + 1,
                            '<a href="../secretadmin/Template_Tour.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].Rank + '&RN=' + data.d[i].RN
                            + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>',
                            data.d[i].Month,
                            data.d[i].Rank,
                            data.d[i].RN,
                            ]);

                            //if (data.d[i].Rank == "International Tour") {
                            //    tblContent += '<tr>';
                            //    tblContent += '<td>' + (i + 1) + '</td>';
                            //    tblContent += '<td>' + data.d[i].Month + '</td>';
                            //    tblContent += '<td>' + data.d[i].Rank + '</td>';
                            //    tblContent += '<td>' + data.d[i].RN + '</td>';
                            //    tblContent += '<td><a href="../secretadmin/Template_Tour.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            //        + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].Rank + '&RN=' + data.d[i].RN
                            //        + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a> </td>';
                            //    tblContent += '</tr>';
                            //}
                        }


                        if (flag == "Loyalty") {
                            json.push([i + 1,
                            '<a href="../secretadmin/Template_loyalty_Achi.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].TotalAmount + '&RN=' + data.d[i].TotalAmount
                            + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>',
                            data.d[i].Month,
                            data.d[i].Rank,
                            data.d[i].TotalAmount,
                            ]);


                            //tblContent += '<tr>';
                            //tblContent += '<td>' + (i + 1) + '</td>';
                            //tblContent += '<td>' + data.d[i].Month + '</td>';
                            //tblContent += '<td>' + data.d[i].Rank + '</td>';
                            //tblContent += '<td>' + data.d[i].TotalAmount + '</td>';
                            //tblContent += '<td> </td>';
                            //tblContent += '</tr>';
                        }

                        if (flag == "RetailBoosterLoyalty") {
                            json.push([i + 1,
                            '<a href="../secretadmin/Template_Retail_Booster.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].TotalAmount + '&RN=' + data.d[i].TotalAmount
                            + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>',
                            data.d[i].Month,
                            data.d[i].Rank,
                            data.d[i].TotalAmount,
                            ]);

                            //tblContent += '<tr>';
                            //tblContent += '<td>' + (i + 1) + '</td>';
                            //tblContent += '<td>' + data.d[i].Month + '</td>';
                            //tblContent += '<td>' + data.d[i].Rank + '</td>';
                            //tblContent += '<td>' + data.d[i].TotalAmount + '</td>';
                            //tblContent += '<td> </td>';
                            //tblContent += '</tr>';
                        }

                        if (flag == "Staterfund") {
                            json.push([i + 1,
                            '<a href="../secretadmin/Template_Starter_fund.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].Rank + '&RN=' + data.d[i].TotalAmount
                            + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a> </td>',
                            data.d[i].Month,
                            data.d[i].Rank,
                            data.d[i].TotalAmount,
                            ]);


                            //tblContent += '<tr>';
                            //tblContent += '<td>' + (i + 1) + '</td>';
                            //tblContent += '<td>' + data.d[i].Month + '</td>';
                            //tblContent += '<td>' + data.d[i].Rank + '</td>';
                            //tblContent += '<td>' + data.d[i].TotalAmount + '</td>';
                            //tblContent += '<td> ';
                            //tblContent += '</tr>';
                        }

                        if (flag == "TopEarnersclub") {

                            json.push([i + 1,
                            '<a href="../secretadmin/Template_Total_Income.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].TotalAmount + '&RN=' + data.d[i].TotalAmount
                            + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>',
                            data.d[i].Month,
                            data.d[i].TotalAmount,
                                "",
                            ]);


                            //tblContent += '<tr>';
                            //tblContent += '<td>' + (i + 1) + '</td>';
                            //tblContent += '<td>' + data.d[i].Month + '</td>';
                            //tblContent += '<td>' + data.d[i].TotalAmount + '</td>';
                            //tblContent += '<td>  </td>';
                            //tblContent += '</tr>';
                        }
                    }


                    if (flag == "GenerationRank" || flag == "TopperRank") {
                        $JDT('#div_tblDownload').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel', 'pdf'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
                                { title: "Date" },
                                { title: "ACHV. Type" },
                                { title: "ACHV." },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,
                        });
                    }

                    if (flag == "DomesticTour" || flag == "InternationalTour") {
                        $JDT('#div_tblDownload').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel', 'pdf'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
                                { title: "Date" },
                                { title: "Generation Pin" },
                                { title: "Tour Name" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,
                        });
                    }


                    if (flag == "Loyalty") {
                        $JDT('#div_tblDownload').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel', 'pdf'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
                                { title: "Payout Period" },
                                { title: "QLFY" },
                                { title: "Amount" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,
                        });
                    }

                    if (flag == "RetailBoosterLoyalty") {
                        $JDT('#div_tblDownload').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel', 'pdf'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
                                { title: "Payout Period" },
                                { title: "QLFY" },
                                { title: "Amount" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,
                        });
                    }

                    if (flag == "Staterfund") {
                        $JDT('#div_tblDownload').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel', 'pdf'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
                                { title: "Date" },
                                { title: "QLFY" },
                                { title: "Amount" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,
                        });
                    }

                    if (flag == "TopEarnersclub") {
                        $JDT('#div_tblDownload').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel', 'pdf'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
                                { title: "Date" },
                                { title: "Amount" },
                                { title: "" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,
                        });
                    }


                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }









        function GetTourList() {
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: 'Dashboard.aspx/TourList',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var TourInternational_Generation = "", TourDomestic_Generation = "", TourInternational_Topper = "", TourDomestic_Topper = "", TourProduct_Generation = "";
                    var Int_Gen_Condition = 0, Int_Gen_Achieved = 0, Int_Gen_PermittedGPV = 0, Int_Gen_Shortfall = 0;
                    var Dom_Gen_Condition = 0, Dom_Gen_Achieved = 0, Dom_Gen_PermittedGPV = 0, Dom_Gen_Shortfall = 0;
                    var Int_Topper_Condition = 0, Int_Topper_Achieved = 0, Int_Topper_PermittedGPV = 0, Int_Topper_Shortfall = 0;
                    var Dom_Topper_Condition = 0, Dom_Topper_Achieved = 0, Dom_Topper_PermittedGPV = 0, Dom_Topper_Shortfall = 0;

                    for (var i = 0; i < data.d.length; i++) {

                        if (data.d[i].TourType == "1" && data.d[i].Pack_Rep == "3") {
                            if (TourInternational_Generation == "") {
                                TourInternational_Generation += "<div class='col-xl-12 col-xxl-12 col-lg-12 col-sm-12'>";
                                TourInternational_Generation += "<div class='widget-stat bg-blue'>";
                                TourInternational_Generation += "<div class='card-body p-6'>";
                                TourInternational_Generation += "<table class='table text-white'>";
                                TourInternational_Generation += "<thead> <tr> <th colspan='6' class='text-center'>" + data.d[i].TourName + " (" + data.d[i].Perid + ")</th> </tr> </thead> ";
                                TourInternational_Generation += "<thead>";
                                TourInternational_Generation += "<tr class='selected'>";
                                TourInternational_Generation += "<th class='selected'>Leg ID</th>";
                                TourInternational_Generation += "<th class='selected'>User Name</th>";
                                TourInternational_Generation += "<th class='selected'>Required</th>";
                                TourInternational_Generation += "<th class='selected'>Achieved</th>";
                                TourInternational_Generation += "<th class='selected'>Permitted GPV</th>";
                                TourInternational_Generation += "<th class='selected'>Shortfall</th>";
                                TourInternational_Generation += "</tr>";
                                TourInternational_Generation += "</thead>";
                                TourInternational_Generation += "<tbody>";
                            }
                            TourInternational_Generation += "<tr class='selected'>";
                            TourInternational_Generation += "<td class='selected'>" + data.d[i].LegID + "</td>";
                            TourInternational_Generation += "<td class='selected'>" + data.d[i].UserName + "</td>";


                            TourInternational_Generation += "<td class='selected currency-inr'>" + CurrencyFormate(data.d[i].Required) + "</td>";
                            TourInternational_Generation += "<td class='selected'>" + CurrencyFormate(data.d[i].Achieved) + "</td>";
                            TourInternational_Generation += "<td class='selected'>" + CurrencyFormate(data.d[i].PermittedGPV) + "</td>";
                            TourInternational_Generation += "<td >" + CurrencyFormate(data.d[i].Shortfall) + "</td>";
                            TourInternational_Generation += "</tr>";

                            Int_Gen_Condition = data.d[i].Condition;
                            Int_Gen_Achieved = parseInt(Int_Gen_Achieved) + parseInt(data.d[i].Achieved);
                            Int_Gen_PermittedGPV = parseInt(Int_Gen_PermittedGPV) + parseInt(data.d[i].PermittedGPV);
                            Int_Gen_Shortfall = parseInt(Int_Gen_Shortfall) + parseInt(data.d[i].Shortfall);
                        }

                        if (data.d[i].TourType == "2" && data.d[i].Pack_Rep == "3") {
                            if (TourDomestic_Generation == "") {
                                TourDomestic_Generation += "<div class='col-xl-12 col-xxl-12 col-lg-12 col-sm-12'>";
                                TourDomestic_Generation += "<div class='widget-stat bg-grey'>";
                                TourDomestic_Generation += "<div class='card-body p-6'>";
                                TourDomestic_Generation += "<table class='table text-black text-left'>";
                                TourDomestic_Generation += "<thead> <tr> <th colspan='6' class='text-center' style='border-bottom:1px solid #fe6a00!important;'>" + data.d[i].TourName + " (" + data.d[i].Perid + ")</th> </tr> </thead> ";
                                TourDomestic_Generation += "<thead>";
                                TourDomestic_Generation += "<tr class='selected1' >";
                                TourDomestic_Generation += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Leg ID</th>";
                                TourDomestic_Generation += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>User Name</th>";
                                TourDomestic_Generation += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Required</th>";
                                TourDomestic_Generation += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Achieved</th>";
                                TourDomestic_Generation += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Permitted GPV</th>";
                                TourDomestic_Generation += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important; border-bottom:1px solid #fe6a00!important;'>Shortfall</th>";
                                TourDomestic_Generation += "</tr>";
                                TourDomestic_Generation += "</thead>";
                                TourDomestic_Generation += "<tbody >";

                            }
                            TourDomestic_Generation += "<tr class='selected1'>";
                            TourDomestic_Generation += "<td class='selected1'>" + data.d[i].LegID + "</td>";
                            TourDomestic_Generation += "<td class='selected1'>" + data.d[i].UserName + "</td>";
                            TourDomestic_Generation += "<td class='selected1'>" + CurrencyFormate(data.d[i].Required) + "</td>";
                            TourDomestic_Generation += "<td class='selected1'>" + CurrencyFormate(data.d[i].Achieved) + "</td>";
                            TourDomestic_Generation += "<td class='selected1'>" + CurrencyFormate(data.d[i].PermittedGPV) + "</td>";
                            TourDomestic_Generation += "<td style=' font-size: 1.2rem; text-align:left;'>" + CurrencyFormate(data.d[i].Shortfall) + "</td>";
                            TourDomestic_Generation += "</tr>";

                            Dom_Gen_Condition = data.d[i].Condition;
                            Dom_Gen_Achieved = parseInt(Dom_Gen_Achieved) + parseInt(data.d[i].Achieved);
                            Dom_Gen_PermittedGPV = parseInt(Dom_Gen_PermittedGPV) + parseInt(data.d[i].PermittedGPV);
                            Dom_Gen_Shortfall = parseInt(Dom_Gen_Shortfall) + parseInt(data.d[i].Shortfall);
                        }


                        if (data.d[i].TourType == "1" && data.d[i].Pack_Rep == "1") {
                            if (TourInternational_Topper == "") {
                                TourInternational_Topper += "<div class='col-xl-12 col-xxl-12 col-lg-12 col-sm-12'>";
                                TourInternational_Topper += "<div class='widget-stat bg-blue'>";
                                TourInternational_Topper += "<div class='card-body p-6'>";
                                TourInternational_Topper += "<table class='table text-white'>";
                                TourInternational_Topper += "<thead> <tr> <th colspan='6' class='text-center'>" + data.d[i].TourName + " (" + data.d[i].Perid + ")</th> </tr> </thead> ";
                                TourInternational_Topper += "<thead>";
                                TourInternational_Topper += "<tr class='selected'>";
                                TourInternational_Topper += "<th class='selected'>Leg ID</th>";
                                TourInternational_Topper += "<th class='selected'>User Name</th>";
                                TourInternational_Topper += "<th class='selected'>Required</th>";
                                TourInternational_Topper += "<th class='selected'>Achieved</th>";
                                TourInternational_Topper += "<th class='selected'>Permitted GPV</th>";
                                TourInternational_Topper += "<th class='selected' style=''>Shortfall</th>";
                                TourInternational_Topper += "</tr>";
                                TourInternational_Topper += "</thead>";
                                TourInternational_Topper += "<tbody>";

                            }
                            TourInternational_Topper += "<tr class='selected'>";
                            TourInternational_Topper += "<td class='selected'>" + data.d[i].LegID + "</td>";
                            TourInternational_Topper += "<td class='selected'>" + data.d[i].UserName + "</td>";
                            TourInternational_Topper += "<td class='selected'>" + CurrencyFormate(data.d[i].Required) + "</td>";
                            TourInternational_Topper += "<td class='selected'>" + CurrencyFormate(data.d[i].Achieved) + "</td>";
                            TourInternational_Topper += "<td class='selected'>" + CurrencyFormate(data.d[i].PermittedGPV) + "</td>";
                            TourInternational_Topper += "<td>" + CurrencyFormate(data.d[i].Shortfall) + "</th>";
                            TourInternational_Topper += "</tr>";

                            Int_Topper_Condition = data.d[i].Condition;
                            Int_Topper_Achieved = parseInt(Int_Topper_Achieved) + parseInt(data.d[i].Achieved);
                            Int_Topper_PermittedGPV = parseInt(Int_Topper_PermittedGPV) + parseInt(data.d[i].PermittedGPV);
                            Int_Topper_Shortfall = parseInt(Int_Topper_Shortfall) + parseInt(data.d[i].Shortfall);
                        }

                        if (data.d[i].TourType == "2" && data.d[i].Pack_Rep == "1") {
                            if (TourDomestic_Topper == "") {
                                TourDomestic_Topper += "<div class='col-xl-12 col-xxl-12 col-lg-12 col-sm-12'>";
                                TourDomestic_Topper += "<div class='widget-stat bg-grey'>";
                                TourDomestic_Topper += "<div class='card-body p-6'>";
                                TourDomestic_Topper += "<table class='table text-black'>";
                                TourDomestic_Topper += "<thead> <tr> <th colspan='6' style='border-bottom:1px solid #fe6a00!important;' class='text-center'>" + data.d[i].TourName + " (" + data.d[i].Perid + ")</th> </tr> </thead> ";
                                TourDomestic_Topper += "<thead>";
                                TourDomestic_Topper += "<tr class='selected1'>";
                                TourDomestic_Topper += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Leg ID</th>";
                                TourDomestic_Topper += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>User Name</th>";
                                TourDomestic_Topper += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Required</th>";
                                TourDomestic_Topper += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Achieved</th>";
                                TourDomestic_Topper += "<th class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Permitted GPV</th>";
                                TourDomestic_Topper += "<th style='border-bottom:1px solid #fe6a00!important; font-size: 1.2rem; text-align:left;'>Shortfall</th>";
                                TourDomestic_Topper += "</tr>";
                                TourDomestic_Topper += "</thead>";
                                TourDomestic_Topper += "<tbody>";
                            }
                            TourDomestic_Topper += "<tr class='selected1'>";
                            TourDomestic_Topper += "<td class='selected1'>" + data.d[i].LegID + "</td>";
                            TourDomestic_Topper += "<td class='selected1'>" + data.d[i].UserName + "</td>";
                            TourDomestic_Topper += "<td class='selected1'>" + CurrencyFormate(data.d[i].Required) + "</td>";
                            TourDomestic_Topper += "<td class='selected1'>" + CurrencyFormate(data.d[i].Achieved) + "</td>";
                            TourDomestic_Topper += "<td class='selected1'>" + CurrencyFormate(data.d[i].PermittedGPV) + "</td>";
                            TourDomestic_Topper += "<td style=' font-size: 1.2rem; text-align:left;'>" + CurrencyFormate(data.d[i].Shortfall) + "</td>";
                            TourDomestic_Topper += "</tr>";

                            Dom_Topper_Condition = data.d[i].Condition;
                            Dom_Topper_Achieved = parseInt(Dom_Topper_Achieved) + parseInt(data.d[i].Achieved);
                            Dom_Topper_PermittedGPV = parseInt(Dom_Topper_PermittedGPV) + parseInt(data.d[i].PermittedGPV);
                            Dom_Topper_Shortfall = parseInt(Dom_Topper_Shortfall) + parseInt(data.d[i].Shortfall);
                        }



                        if (data.d[i].Pack_Rep == "5") {
                            if (TourProduct_Generation == "") {
                                TourProduct_Generation += "<div class='col-xl-12 col-xxl-12 col-lg-12 col-sm-12'>";
                                TourProduct_Generation += "<div class='widget-stat bg-blue'>";
                                TourProduct_Generation += "<div class='card-body p-6'>";
                                TourProduct_Generation += "<table class='table text-white'>";
                                TourProduct_Generation += "<thead> <tr> <th colspan='6' class='text-center'>" + data.d[i].TourName + " (" + data.d[i].Perid + ")</th> </tr> </thead> ";
                                TourProduct_Generation += "<thead>";
                                TourProduct_Generation += "<tr class='selected'>";
                                TourProduct_Generation += "<th class='selected'>User Id</th>";
                                TourProduct_Generation += "<th class='selected'>User Name</th>";
                                TourProduct_Generation += "<th class='selected'>Tour Name</th>";
                                TourProduct_Generation += "<th class='selected'>Product Purchased</th>";
                                TourProduct_Generation += "</tr>";
                                TourProduct_Generation += "</thead>";
                                TourProduct_Generation += "<tbody>";
                            }
                            TourProduct_Generation += "<tr class='selected'>";
                            TourProduct_Generation += "<td class='selected'>" + data.d[i].LegID + "</td>";
                            TourProduct_Generation += "<td class='selected'>" + data.d[i].UserName + "</td>";
                            TourProduct_Generation += "<td class='selected'>" + data.d[i].TourName + "</td>";
                            TourProduct_Generation += "<td style=' font-size: 1.2rem; text-align:left;'>" + data.d[i].ProductCondition + "</td>";
                            TourProduct_Generation += "</tr>";

                        }






                    }
                    TourInternational_Generation += "</tbody>";
                    TourInternational_Generation += "<thead>";
                    TourInternational_Generation += "<tr class='selected' style='border-top:1px solid #ffffff'>";
                    TourInternational_Generation += "<td class='selected'>Total</td>";
                    TourInternational_Generation += "<td class='selected'></td>";
                    TourInternational_Generation += "<td class='selected'>" + CurrencyFormate(Int_Gen_Condition) + "</td>";
                    TourInternational_Generation += "<td class='selected'>" + CurrencyFormate(Int_Gen_Achieved) + "</td>";
                    TourInternational_Generation += "<td class='selected'>" + CurrencyFormate(Int_Gen_PermittedGPV) + "</td>";
                    TourInternational_Generation += "<td style=' font-size: 1.2rem; text-align:left;'>" + CurrencyFormate(Int_Gen_Shortfall) + "</td>";
                    TourInternational_Generation += "</tr>";
                    TourInternational_Generation += "</thead>";

                    TourInternational_Generation += "<thead>";
                    TourInternational_Generation += "<tr class='selected' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff;'>";
                    TourInternational_Generation += "<td class='selected' style='color: #fe6a00;'>Status</td>";
                    TourInternational_Generation += "<td class='selected' style='color: #fe6a00;'>Achieved</td>";
                    if (Int_Gen_PermittedGPV >= Int_Gen_Condition)
                        TourInternational_Generation += "<td  colspan='4' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>Yes</td>";
                    else
                        TourInternational_Generation += "<td  colspan='4' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>No</td>";

                    TourInternational_Generation += "</tr>";
                    TourInternational_Generation += "</thead>";

                    TourInternational_Generation += " </table> ";
                    TourInternational_Generation += " </div> </div> </div>";
                    $('#div_TourInternational_Generation').empty().append(TourInternational_Generation);
                    if (TourInternational_Generation == '')
                        $('#div_TourInternational_Generation').hide();

                    TourDomestic_Generation += "</tbody>";
                    TourDomestic_Generation += "<thead>";
                    TourDomestic_Generation += "<tr class='selected1' style='border-top:1px solid #fe6a00!important;'>";
                    TourDomestic_Generation += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Total</td>";
                    TourDomestic_Generation += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'></td>";
                    TourDomestic_Generation += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'>" + CurrencyFormate(Dom_Gen_Condition) + "</td>";
                    TourDomestic_Generation += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'>" + CurrencyFormate(Dom_Gen_Achieved) + "</td>";
                    TourDomestic_Generation += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'>" + CurrencyFormate(Dom_Gen_PermittedGPV) + "</td>";
                    TourDomestic_Generation += "<td style='border-bottom:1px solid #fe6a00!important; font-size: 1.2rem; text-align:left;'>" + CurrencyFormate(Dom_Gen_Shortfall) + "</td>";
                    TourDomestic_Generation += "</tr>";
                    TourDomestic_Generation += "</thead>";

                    TourDomestic_Generation += "<thead>";
                    TourDomestic_Generation += "<tr class='selected1' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff;'>";
                    TourDomestic_Generation += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important; color: #fe6a00;'>Status</td>";
                    TourDomestic_Generation += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important; color: #fe6a00;'>Achieved</td>";
                    if (Dom_Gen_PermittedGPV >= Dom_Gen_Condition)
                        TourDomestic_Generation += "<td colspan='4' style='border-bottom:1px solid #fe6a00!important; text-align:center; color: #fe6a00; font-size: 20px;'>Yes</td>";
                    else
                        TourDomestic_Generation += "<td colspan='4' style='border-bottom:1px solid #fe6a00!important; text-align:center; color: #fe6a00; font-size: 20px;'>No</td>";
                    TourDomestic_Generation += "</tr>";
                    TourDomestic_Generation += "</thead>";

                    TourDomestic_Generation += "</table> ";
                    TourDomestic_Generation += " </div> </div> </div>";
                    $('#div_TourDomestic_Generation').empty().append(TourDomestic_Generation);
                    if (TourDomestic_Generation == '')
                        $('#div_TourDomestic_Generation').hide();


                    TourInternational_Topper += "</tbody>";
                    TourInternational_Topper += "<thead>";
                    TourInternational_Topper += "<tr class='selected' style='border-top:1px solid #ffffff'>";
                    TourInternational_Topper += "<td class='selected'>Total</td>";
                    TourInternational_Topper += "<td class='selected'></td>";
                    TourInternational_Topper += "<td class='selected'>" + CurrencyFormate(Int_Topper_Condition) + "</td>";
                    TourInternational_Topper += "<td class='selected'>" + CurrencyFormate(Int_Topper_Achieved) + "</td>";
                    TourInternational_Topper += "<td class='selected'>" + CurrencyFormate(Int_Topper_PermittedGPV) + "</td>";
                    TourInternational_Topper += "<td >" + CurrencyFormate(Int_Topper_Shortfall) + "</td>";
                    TourInternational_Topper += "</tr>";
                    TourInternational_Topper += "</thead>";

                    TourInternational_Topper += "<thead>";
                    TourInternational_Topper += "<tr class='selected' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff;'>";
                    TourInternational_Topper += "<td class='selected' style='color: #fe6a00;'>Status</td>";
                    TourInternational_Topper += "<td class='selected' style='color: #fe6a00;'>Achieved</td>";
                    if (Int_Topper_Achieved >= Int_Topper_Condition)
                        TourInternational_Topper += "<td colspan='4' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>Yes</td>";
                    else
                        TourInternational_Topper += "<td colspan='4' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>No</td>";

                    TourInternational_Topper += "</tr>";
                    TourInternational_Topper += "</thead>";
                    TourInternational_Topper += "</table> ";
                    TourInternational_Topper += " </div> </div> </div>";
                    $('#div_TourInternational_Topper').empty().append(TourInternational_Topper);
                    if (TourInternational_Topper == '')
                        $('#div_TourInternational_Topper').hide();

                    TourDomestic_Topper += "</tbody>";
                    TourDomestic_Topper += "<thead>";
                    TourDomestic_Topper += "<tr class='selected1' style='border-top:1px solid #fe6a00!important;'>";
                    TourDomestic_Topper += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'>Total</td>";
                    TourDomestic_Topper += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'></td>";
                    TourDomestic_Topper += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'>" + CurrencyFormate(Dom_Topper_Condition) + "</td>";
                    TourDomestic_Topper += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'>" + CurrencyFormate(Int_Gen_Condition) + "</td>";
                    TourDomestic_Topper += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important;'>" + CurrencyFormate(Dom_Topper_PermittedGPV) + "</td>";
                    TourDomestic_Topper += "<td style='border-bottom:1px solid #fe6a00!important; font-size: 1.2rem; text-align:left;'>" + CurrencyFormate(Dom_Topper_Shortfall) + "</td>";
                    TourDomestic_Topper += "</tr>";
                    TourDomestic_Topper += "</thead>";

                    TourDomestic_Topper += "<thead>";
                    TourDomestic_Topper += "<tr class='selected1' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff; color: #fe6a00;'>";
                    TourDomestic_Topper += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important; color: #fe6a00;'>Status</td>";
                    TourDomestic_Topper += "<td class='selected1' style='border-bottom:1px solid #fe6a00!important; color: #fe6a00;'>Achieved</td>";
                    if (Dom_Topper_Achieved >= Dom_Topper_Condition)
                        TourDomestic_Topper += "<td  colspan='4' style='border-bottom:1px solid #fe6a00!important; text-align:center; color: #fe6a00; font-size: 20px;'>Yes</td>";
                    else
                        TourDomestic_Topper += "<td  style='border-bottom:1px solid #fe6a00!important; text-align:center; color: #fe6a00; font-size: 20px;'>No</td>";
                    TourDomestic_Topper += "</tr>";
                    TourDomestic_Topper += "</thead>";
                    TourDomestic_Topper += " </table> ";
                    TourDomestic_Topper += " </div> </div> </div>";
                    $('#div_TourDomestic_Topper').empty().append(TourDomestic_Topper);
                    if (TourDomestic_Topper == '')
                        $('#div_TourDomestic_Topper').hide();




                    TourProduct_Generation += "</tbody>";
                    TourProduct_Generation += "<thead>";
                    TourProduct_Generation += "<tr class='selected' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff;'>";
                    TourProduct_Generation += "<td class='selected' style='color: #fe6a00;'>Status</td>";
                    TourProduct_Generation += "<td class='selected' style='color: #fe6a00;'>Achieved</td>";
                    TourProduct_Generation += "<td  colspan='2' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>Yes</td>";
                    TourProduct_Generation += "</tr>";
                    TourProduct_Generation += "</thead>";

                    TourProduct_Generation += " </table> ";
                    TourProduct_Generation += " </div> </div> </div>";
                    $('#div_TourProduct_Generation').empty().append(TourProduct_Generation);
                    if (TourProduct_Generation == '')
                        $('#div_TourProduct_Generation').hide();





                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }

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


        function BindEventTour() {

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: 'Dashboard.aspx/BindEventTour',
                //data: '{min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();

                    var code = "1234567";
                    
                    for (var i = 0; i < data.d.length; i++) {

                        var IsUsed = data.d[i].IsScaned == "0" ? "<span class='dotGrey'></span>" : "<span class='dotGreen'></span>";

                        $("#div_EventTour").append("<div class='row'> <div class='col-md-2'>User Id</div>  <div class='col-md-4'>" + data.d[i].AppMstRegNo + "</div> </div>");
                        $("#div_EventTour").append("<div class='row'> <div class='col-md-2'>User Name </div>  <div class='col-md-4'>" + data.d[i].AppMstFName + "</div> </div>");
                        $("#div_EventTour").append("<div class='row'> <div class='col-md-2'>Tour Name </div>  <div class='col-md-4'>" + data.d[i].TourName + "</div> </div>");
                        $("#div_EventTour").append("<div class='row'> <div class='col-md-2'>Used Date</div>  <div class='col-md-4'>" + data.d[i].Scan_date + "</div> </div>");
                        $("#div_EventTour").append("<div class='row'> <div class='col-md-2'>Remark</div>  <div class='col-md-4'>" + data.d[i].Remark + "</div> </div>");
                        $("#div_EventTour").append("<div class='row'> <div class='col-md-2'>Status</div>  <div class='col-md-4'>" + IsUsed + "</div> </div>");
                        $("#div_EventTour").append("<svg id='barcode" + (i + 1) + "'></svg> <br/> <br/> <br/>");

                        JsBarcode("#barcode" + (i + 1), data.d[i].QRCode, { format: "codabar", displayValue: true, lineColor: "#24292e", width: 2, height: 60, fontSize: 20 });
                    }
                    
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }
         
    </script>

    <script type="text/javascript" src="https://cdn.jsdelivr.net/jsbarcode/3.6.0/JsBarcode.all.min.js"></script>
      <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>


</asp:Content>
