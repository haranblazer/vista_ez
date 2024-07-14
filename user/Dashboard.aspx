<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs" Inherits="User_Dashboard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hnf_DailyPayoutDate" runat="server" Value="" />
    <asp:HiddenField ID="hnf_WeeklyPayoutDate" runat="server" Value="" />
    <asp:HiddenField ID="hnf_MonthlyPayoutDate" runat="server" Value="" />
    <asp:HiddenField ID="hnf_LastActiveDate" runat="server" Value="" />

    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script> var $J = $.noConflict(true); </script>
    <script type="text/javascript">

        $J(function () {
            ScanStatus();
            getdate();
        });

        function getdate() {

            var days1, hours1, minutes1, sec1, timer1;
            end1 = new Date($('#<%=hnf_LastActiveDate.ClientID%>').val());
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


    <div class="d-flex align-items-center sidebar-p-a border-bottom sidebar-account d-none d-lg-none">
        <a href="#" class="flex d-flex align-items-center text-underline-0 text-body"><span
            class="avatar mr-3">
            <asp:Image ID="ProfileImage" runat="server" CssClass="avatar-img rounded-circle"></asp:Image>
        </span><span class="flex d-flex flex-column"><strong style="font-size: 25px">
            <asp:Label ID="lblUserName" runat="server"></asp:Label>
            -
            <asp:Label ID="lbl_usrid" runat="server"></asp:Label></strong>
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
        <div class="col-6 col-md-6 d-none">
            <div class="daily-close pull-right mt-2">
                Daily Closing  
                <span1 id='lbl_DailyPayoutTime' runat="server"></span1>
                <span>
                    <i class="flaticon-381-alarm-clock"></i>
                </span>
            </div>
        </div>




        <div class="default-tab">
            <ul class="nav nav-pills mb-4 light text-orange" role="tablist" style="flex-flow: nowrap;">
                <li class="nav-item text-center d-none">
                    <a class="nav-link " data-bs-toggle="tab" href="#first_purchase">
                        <div class="icon">
                            <i class="fa fa-sitemap"></i>
                        </div>

                        <h4>First Purchase</h4>

                    </a>

                </li>
                <li class="nav-item text-center">
                    <a class="nav-link active" data-bs-toggle="tab" href="#generation">
                        <div class="icon">
                            <i class="fa fa-users"></i>
                        </div>
                        <h4>Generation</h4>
                    </a>
                </li>
                <%-- <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#topper">
                        <img src="images/topper.png" width="65px" />
                    </a>
                    <span class="text-primary">Topper</span>
                </li>--%>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#loyalty">
                        <div class="icon">
                            <i class="fa fa-handshake-o"></i>
                        </div>
                        <h4>Consistency</h4>
                    </a>
                </li>
                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#RetailBooster">
                        <img src="images/retail_booster.png" width="65px" />
                    </a>
                    <span class="text-primary">Arogyam</span>
                </li>

                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#tours" onclick="GetTourList();">
                        <img src="images/tour.png" width="65px" />
                    </a>
                    <span class="text-primary">Tours</span>
                </li>
                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#QualifiedStar" onclick="GetQualifiedStar();">
                        <img src="images/QualifiedStar.png" width="65px" />
                    </a>
                    <span class="text-primary">Qualified Star</span>
                </li>

                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#wallet">
                        <div class="icon">
                            <i class="fa fa-credit-card"></i>
                        </div>
                        <h4>Wallet</h4>
                    </a>
                </li>
                <li class="nav-item text-center">
                    <a class="nav-link" data-bs-toggle="tab" href="#kyc1">
                        <div class="icon">
                            <i class="fa fa-file-archive-o"></i>
                        </div>
                        <h4>KYC</h4>
                    </a>
                </li>
                <li class="nav-item text-center d-none">
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

                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#Achievement">
                        <img src="images/achievement.png" width="65px" />
                    </a>
                    <span class="text-primary">Achievement</span>
                </li>

                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#EventTour" onclick="BindEventTour();">
                        <img src="images/event-barcode.png" width="65px" />
                    </a>
                    <span class="text-primary">Event Tour</span>
                </li>

                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#star_insurance">
                        <img src="images/insurance.png" width="65px" />
                    </a>
                    <span class="text-primary">Insurance</span>
                </li>

                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#car">
                        <img src="images/car.png" width="65px" />
                    </a>
                    <span class="text-primary">Car</span>
                </li>
                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#pfo">
                        <img src="images/leaderboard.png" width="65px" />
                    </a>
                    <span class="text-primary">FOP</span>
                </li>

                <li class="nav-item text-center d-none">
                    <a class="nav-link" data-bs-toggle="tab" href="#leaderboard">
                        <img src="images/leaderboard_crown.png" width="65px" />
                    </a>
                    <span class="text-primary">Leaderboard</span>
                </li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane fade active show" id="generation" role="tabpanel">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h2 class="mb-0 text-primary" style="font-size: 22px;">
                                                            <span><%=method.Associate%></span></h2>
                                                    </div>
                                                    <span id="lbl_RepurchaseRank_FirstPurch" runat="server" class="fs-18 d-block mb-2">Generation Pin</span>
                                                </div>
                                                <div class="apexcharts-legend"><i class="fa fa-user-o"></i></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h2 class="mb-0 text-primary">
                                                            <span id="lbl_NoOfAssociate_FirstPurch" runat="server">0</span></h2>
                                                    </div>
                                                    <span class="fs-17 d-block mb-2">NO. of <%=method.Associate%></span>
                                                </div>
                                                <div class="apexcharts-legend"><i class="fa fa-users"></i></div>
                                            </div>
                                        </div>



                                        <div class="col-sm-3">
                                            <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h2 class="mb-0 text-primary">
                                                            <span id="lblSponsor_FirstPurch" runat="server"></span></h2>

                                                    </div>
                                                    <span class="fs-17 d-block mb-2">Direct <%=method.Associate%></span>
                                                </div>
                                                <div class="apexcharts-legend"><i class="fa fa-user-circle"></i></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h2 class="mb-0 text-primary">
                                                            <span id="lblPaidSponsor_FirstPurch" runat="server">0</span></h2>

                                                    </div>
                                                    <span class="fs-17 d-block mb-2">Paid Direct <%=method.Associate%></span>
                                                </div>
                                                <div class="apexcharts-legend"><i class="fa fa-cubes"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                       
                        <%--Start--%>
                        <div class="col-lg-12">
                        <div class="row">
                            <div class="col-md-12">
                            <div class="card-header card-header-large p-0">
                                <h3>Weekly </h3>
                            </div>
                                </div>
                            <div class="col-md-3">
                                <div class="card p-3"> 
                                   
                                    <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                        <div>
                                            <div class="d-flex align-items-center mb-1">
                                                <h3 class="mb-0"> <a href="#" id="lbl_BV_Weekly" runat="server" class="text-primary">0</a></h3> 
                                            </div>
                                            <span class="fs-18 d-block mb-2">BV</span>
                                        </div>
                                        <div class="apexcharts-legend"><i class="fa fa-chevron-circle-left"></i></div>
                                    </div>
                                </div> 
                                    
                            </div>
                            <div class="col-md-3">
                                <div class="card p-3"> 
                                    <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                        <div>
                                            <div class="d-flex align-items-center mb-1">
                                                <h2 class="mb-0"> <a href="#" id="lbl_GPV_Weekly" runat="server" class="text-primary">0</a></h2> 
                                            </div>
                                            <span class="fs-18 d-block mb-2">GBV</span>
                                        </div>
                                        <div class="apexcharts-legend"><i class="fa fa-chevron-circle-right"></i></div>
                                    </div>
                                </div> 
                            </div>
                             
                            <div class="col-md-3">
                              <div class="card p-3"> 
                                    <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                        <div>
                                            <div class="d-flex align-items-center mb-1">
                                                <h2 class="mb-0"> <a href="#" id="lbl_Matched" runat="server" class="text-primary">0</a></h2>
                                            </div>
                                            <span class="fs-18 d-block mb-2">Matched <%=method.PV %></span>
                                        </div>
                                        <div class="apexcharts-legend"><i class="fa fa-suitcase"></i></div>
                                    </div>
                                </div> 
                            </div>


                            <div class="col-md-3">
                               <div class="card p-3"> 
                                    <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                        <div>
                                            <div class="d-flex align-items-center mb-1">
                                                <h2 class="mb-0"> <a href="#" id="lbl_BV_Weekly_CarryForward" runat="server" class="text-primary">0</a></h2>
                                            </div>
                                            <span class="fs-18 d-block mb-2">Carry Forward</span>
                                        </div>
                                        <div class="apexcharts-legend"><i class="fa fa-comments"></i></div>
                                    </div>
                                </div> 
                            </div>
                            
                            <div class="clearfix"></div>
                             <div class="col-md-12">
                            <div class="card-header card-header-large p-0">
                                <h3>Monthly </h3>
                            </div>
                                 </div>
                           <div class="col-md-3">
                                <div class="card p-3"> 
                                    <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                        <div>
                                            <div class="d-flex align-items-center mb-1">
                                                <h3 class="mb-0"> <a href="#" id="lbl_BV_Monthly" runat="server" class="text-primary">0</a></h3> 
                                            </div>
                                            <span class="fs-18 d-block mb-2">BV</span>
                                        </div>
                                        <div class="apexcharts-legend"><i class="fa fa-chevron-circle-left"></i></div>
                                    </div>
                                </div> 
                            </div>
                            <div class="col-md-3">
                                <div class="card p-3"> 
                                    <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                        <div>
                                            <div class="d-flex align-items-center mb-1">
                                                <h2 class="mb-0"><a href="#" id="lbl_GPV_Monthly" runat="server" class="text-primary">0</a></h2>
                                            </div>
                                            <span class="fs-18 d-block mb-2">GBV</span>
                                        </div>
                                        <div class="apexcharts-legend"><i class="fa fa-chevron-circle-right"></i></div>
                                    </div>
                                </div> 
                            </div>
                            <div class="col-md-3">
                                <div class="card p-3"> 
                                    <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                        <div>
                                            <div class="d-flex align-items-center mb-1">
                                                <h2 class="mb-0"> <a href="#" id="lbl_First_PV" runat="server" class="text-primary">0</a></h2> 
                                            </div>
                                            <span class="fs-18 d-block mb-2">First Purchase</span>
                                        </div>
                                        <div class="apexcharts-legend"><i class="fa fa-user-circle-o"></i></div>
                                    </div>
                                </div> 
                            </div>
                            <div class="col-md-3">
                               <div class="card p-3"> 
                                    <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                        <div>
                                            <div class="d-flex align-items-center mb-1">
                                                <h2 class="mb-0"> <a href="#" id="lbl_Rest_PV" runat="server" class="text-primary">0</a></h2> 
                                            </div>
                                            <span class="fs-18 d-block mb-2">Self Repurchase</span>
                                        </div>
                                        <div class="apexcharts-legend"><i class="fa fa-user"></i></div>
                                    </div>
                                </div> 
                            </div>



                          <%--  End--%>


                            <div class="bg-white" style="border-radius: 0.75rem; display: none;">
                                <div class="card-header border-0 p-0 pt-4 pb-4 ">

                                    <div class="card-action coin-tabs m-auto">
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" data-bs-toggle="tab" href="#daily_pur" role="tab" aria-selected="false">Personal BV</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-bs-toggle="tab" href="#weekly_pur" role="tab" aria-selected="true">Previous Month</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-bs-toggle="tab" href="#monthly_pur" role="tab" aria-selected="false">Carry Forward BV</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card-body p-0">

                                    <div class="tab-content">
                                        <div class="tab-pane fade active show" id="daily_pur">

                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row separate-row">
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <span id="lbl_currentMonth_PPV_FirstPurch" runat="server">0</span></h2>
                                                                    </div>
                                                                    <span class="fs-17 d-block mb-2"><%=method.PV%></span>
                                                                </div>
                                                                <div class="apexcharts-legend"><i class="fa fa-snowflake-o"></i></div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <span id="lbl_currentMonth_GPV_FirstPurch" runat="server">600</span></h2>

                                                                    </div>
                                                                    <span class="fs-17 d-block mb-2"><%=method.GBV%></span>
                                                                </div>
                                                                <div class="apexcharts-legend"><i class="fa fa-database"></i></div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-blue">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">
                                                                        <div class="media-body text-white">
                                                                            <p class="mb-0 text-left"></p>
                                                                            <h3 class="text-white text-end">
                                                                                <span id="ctl00_ContentPlaceHolder1_lbl_currentMonth_TPV">400</span></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-grey">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">
                                                                        <div class="media-body text-white ">
                                                                            <p class="mb-0 text-dark"><%=method.GBV%></p>
                                                                            <h3 class="text-orange text-end">
                                                                                <span id="ctl00_ContentPlaceHolder1_lbl_currentMonth_TGBV">1000</span></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="tab-pane fade " id="weekly_pur">


                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row separate-row">
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <span id="ctl00_ContentPlaceHolder1_Label1">0</span></h2>
                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.PV%></span>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <span id="ctl00_ContentPlaceHolder1_Label2">0</span></h2>

                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.GBV%></span>
                                                                </div>

                                                            </div>
                                                        </div>

                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-blue">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">
                                                                        <div class="media-body text-white">
                                                                            <p class="mb-0 text-left"></p>
                                                                            <h3 class="text-white text-end">
                                                                                <span id="ctl00_ContentPlaceHolder1_lbl_Previous_TPV">0</span></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-grey">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">

                                                                        <div class="media-body text-white ">
                                                                            <p class="mb-0 text-dark"><%=method.GBV%></p>
                                                                            <h3 class="text-orange text-end">
                                                                                <span id="ctl00_ContentPlaceHolder1_lbl_Previous_TGBV">0</span></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>
                                        <div class="tab-pane fade" id="monthly_pur">


                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row separate-row">
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <span id="ctl00_ContentPlaceHolder1_Label3">0</span></h2>

                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.PV%></span>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <span id="ctl00_ContentPlaceHolder1_Label4">0</span></h2>
                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.GBV%></span>
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
</div>

                    </div>
                    <div class="card-header card-header-large p-0">
                        <h3>Reference Link </h3>
                    </div>

                    <div class="row">
                        <div class="col-xl-6 col-xxl-6 col-lg-6 col-sm-6">
                            <div class="widget-stat card">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-center">
                                                <button id="demo" class="btn btn-primary" onclick="copyToClipboard($('#<%=lblUserInLeft.ClientID %>').text())">
                                                    <%--Left--%> Referral Copy Text</button>
                                            </p>
                                            <h3 class="text-white text-center">
                                                <asp:LinkButton ID="lblUserInLeft" runat="server" Font-Size='14px'
                                                    OnClick="lblUserInLeft_Click" OnClientClick="aspnetForm.target ='_blank';"></asp:LinkButton></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-6 col-xxl-6 col-lg-6 col-sm-6 d-none">
                            <div class="widget-stat card bg-grey">
                                <div class="card-body  p-3">
                                    <div class="media">

                                        <div class="media-body text-white ">
                                            <p class="mb-0 text-center">
                                                <button id="demo1" class="btn btn-primary" onclick="copyToClipboard($('#<%=lblUserInRight.ClientID %>').text())">
                                                    Right Referral Copy Text</button>
                                            </p>
                                            <h3 class="text-orange text-center">
                                                <asp:LinkButton ID="lblUserInRight" runat="server" ForeColor='#000000' Font-Size='14px'
                                                    OnClick="lblUserInRight_Click" OnClientClick="aspnetForm.target ='_blank';"></asp:LinkButton></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="tab-pane fade" id="first_purchase" role="tabpanel">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row separate-row">
                                        <div class="col-sm-6">
                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h2 class="mb-0 text-primary">
                                                            <asp:Label ID="lbl_RepurchaseRank" runat="server">0</asp:Label></h2>
                                                        <%-- <span class="text-success ms-3">+0.5 %</span>--%>
                                                    </div>
                                                    <span class="fs-18 d-block mb-2">Generation  Pin</span>
                                                </div>
                                                <div class="apexcharts-legend"><i class="fa fa-user-o"></i></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h2 class="mb-0 text-primary">
                                                            <asp:Label ID="lbl_NoOfAssociate" runat="server">0</asp:Label></h2>
                                                        <%--<span class="text-success ms-3">+0.5 %</span>--%>
                                                    </div>
                                                    <span class="fs-18 d-block mb-2">NO. of <%=method.Associate%></span>
                                                </div>
                                                <div class="apexcharts-legend"><i class="fa fa-users"></i></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="job-icon pb-2 d-flex justify-content-between" style="position: relative;">
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h2 class="mb-0 text-primary">
                                                            <asp:Label ID="lblSponsor" runat="server">0</asp:Label></h2>
                                                        <%-- <span class="text-success ms-3">+0.5 %</span>--%>
                                                    </div>
                                                    <span class="fs-18 d-block mb-2">Direct <%=method.Associate%></span>
                                                </div>
                                                <div class="apexcharts-legend"><i class="fa fa-user-circle"></i></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="job-icon pb-2 d-flex justify-content-between" style="position: relative;">
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h2 class="mb-0 text-primary">
                                                            <asp:Label ID="lblPaidSponsor" runat="server">0</asp:Label></h2>
                                                        <%--<span class="text-success ms-3">+0.5 %</span>--%>
                                                    </div>
                                                    <span class="fs-18 d-block mb-2">Paid Direct <%=method.Associate%></span>
                                                </div>
                                                <div class="apexcharts-legend"><i class="fa fa-cubes"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="bg-white" id="user-activity1" style="border-radius: 0.75rem;">
                                <div class="card-header border-0 p-0 pt-4 pb-4 ">
                                    <%--<h4 class="fs-20 mb-1">Chart</h4>--%>
                                    <div class="card-action coin-tabs m-auto">
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
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row separate-row">
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <asp:Label ID="lbl_currentMonth_PPV" runat="server">0</asp:Label></h2>
                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.PV%></span>
                                                                </div>
                                                                <div class="apexcharts-legend"><i class="fa fa-snowflake-o"></i></div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <asp:Label ID="lbl_currentMonth_GPV" runat="server">0</asp:Label></h2>

                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.GBV%></span>
                                                                </div>
                                                                <div class="apexcharts-legend"><i class="fa fa-database"></i></div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-blue">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">
                                                                        <div class="media-body text-white">
                                                                            <p class="mb-0 text-left"></p>
                                                                            <h3 class="text-white text-end">
                                                                                <asp:Label ID="lbl_currentMonth_TPV" runat="server">0</asp:Label></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-grey">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">

                                                                        <div class="media-body text-white ">
                                                                            <p class="mb-0 text-dark"><%=method.GBV%></p>
                                                                            <h3 class="text-orange text-end">
                                                                                <asp:Label ID="lbl_currentMonth_TGBV" runat="server">0</asp:Label></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>



                                        <div class="tab-pane fade " id="weekly1">

                                            <%-- <h2>Previous Month</h2>--%>
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row separate-row">
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <asp:Label ID="Label1" runat="server">0</asp:Label></h2>
                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.PV%></span>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <asp:Label ID="Label2" runat="server">0</asp:Label></h2>

                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.GBV%></span>
                                                                </div>

                                                            </div>
                                                        </div>

                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-blue">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">
                                                                        <div class="media-body text-white">
                                                                            <p class="mb-0 text-left"></p>
                                                                            <h3 class="text-white text-end">
                                                                                <asp:Label ID="lbl_Previous_TPV" runat="server">0</asp:Label></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-grey">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">

                                                                        <div class="media-body text-white ">
                                                                            <p class="mb-0 text-dark"><%=method.GBV%></p>
                                                                            <h3 class="text-orange text-end">
                                                                                <asp:Label ID="lbl_Previous_TGBV" runat="server">0</asp:Label></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>
                                        <div class="tab-pane fade" id="monthly1">
                                            <%-- <h2>Cumulative</h2>--%>

                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row separate-row">
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <asp:Label ID="Label3" runat="server">0</asp:Label></h2>

                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.PV%></span>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="job-icon pb-4 d-flex justify-content-between" style="position: relative;">
                                                                <div>
                                                                    <div class="d-flex align-items-center mb-1">
                                                                        <h2 class="mb-0 text-primary">
                                                                            <asp:Label ID="Label4" runat="server">0</asp:Label></h2>

                                                                    </div>
                                                                    <span class="fs-18 d-block mb-2"><%=method.GBV%></span>
                                                                </div>

                                                            </div>
                                                        </div>

                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-blue">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">
                                                                        <div class="media-body text-white">
                                                                            <p class="mb-0 text-left"></p>
                                                                            <h3 class="text-white text-end">
                                                                                <asp:Label ID="lbl_Cumulative_TPV" runat="server">0</asp:Label></h3>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3 d-none">
                                                            <div class="widget-stat card bg-grey">
                                                                <div class="card-body  p-3">
                                                                    <div class="media">

                                                                        <div class="media-body text-white ">
                                                                            <p class="mb-0 text-dark"><%=method.GBV%></p>
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
                            </div>
                        </div>
                        <div class="col-lg-6 d-none">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <div class="row  justify-content-between">
                                                <div class="col text-center">
                                                    <div class="h2 text-white" id='days1'>00</div>
                                                    <div>Days</div>
                                                </div>
                                                <div class="col text-center">
                                                    <div class="h2 text-white" id='hours1'>00</div>
                                                    <div>Hours</div>
                                                </div>
                                                <div class="col text-center">
                                                    <div class="h2 text-white" id='minutes1'>00</div>
                                                    <div>Min</div>
                                                </div>
                                                <div class="col text-center">
                                                    <div class="h2 text-white" id='seconds1'>00</div>
                                                    <div>Sec</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12 ">
                        <div class="col-md-12 d-none">
                            <h3>Generation Payout Eligibility</h3>
                        </div>
                        <div class="card d-none">
                            <div class="card-body">
                                <div class="row ">
                                    <div class="col-sm-4">
                                        <div class="job-icon  d-flex justify-content-between" style="position: relative; border-right: 1px solid #eee;">
                                            <div>
                                                <div class="d-flex align-items-center mb-1">
                                                    <h2 class="mb-0 text-primary">
                                                        <asp:Label ID="lbl_Rep_Required" runat="server">0</asp:Label></h2>
                                                </div>
                                                <span class="fs-18 d-block mb-2">Required
                                                </span>
                                            </div>
                                            <div class="apexcharts-legend me-2"><i class="fa fa-bullseye"></i></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="job-icon  d-flex justify-content-between" style="position: relative; border-right: 1px solid #eee;">
                                            <div>
                                                <div class="d-flex align-items-center mb-1">
                                                    <h2 class="mb-0 text-primary">
                                                        <asp:Label ID="lbl_Rep_Achieved" runat="server">0</asp:Label></h2>
                                                </div>
                                                <span class="fs-18 d-block mb-2">Achieved</span>
                                            </div>
                                            <div class="apexcharts-legend me-2"><i class="fa fa-trophy"></i></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="job-icon d-flex justify-content-between" style="position: relative;">
                                            <div>
                                                <div class="d-flex align-items-center mb-1">
                                                    <h2 class="mb-0 text-primary">
                                                        <asp:Label ID="lbl_Rep_Shortfall" runat="server">0</asp:Label></h2>
                                                </div>
                                                <span class="fs-18 d-block mb-2">Shortfall</span>
                                            </div>
                                            <div class="apexcharts-legend"><i class="fa fa-star-half"></i></div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xl-12">
                            <div class="card">
                                <!--#include virtual="Highcharts.aspx"-->
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
                                            <h3 class="text-white text-end">
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
                                            <h3 class="text-white text-end">
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
                                            <h3 class="text-white text-end">
                                                <asp:Label ID="lblTotLeftBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body  p-3 pt-0 pb-1">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-1 text-left">Total TCC Right</p>
                                            <h3 class="text-white text-end">
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
                                            <h3 class="text-white text-end">
                                                <asp:Label ID="lblNewLeftBV" runat="server">0</asp:Label></h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body  p-3 pt-0 pb-1">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left ">New TCC Right</p>
                                            <h3 class="text-white text-end">
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
                                            <p class="mb-0 text-white">Self Cummulative  </p>
                                            <h3 class="text-white text-end">
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
                                            <h3 class="text-white text-end">
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
                            <div id="div_TourTbl" class="card card-form table-responsive border-bottom bg-blue" data-toggle="lists">
                            </div>
                        </div>



                        <%-- <div class="col-md-12">
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
                        </div>--%>

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

                <div class="tab-pane fade" id="QualifiedStar">
                    <div class="row">
                        <div class="col-md-12">
                            <div id="div_QualifiedStar" class="card card-form table-responsive border-bottom bg-blue" data-toggle="lists">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="wallet">
                    <link href="css/wallet_dashboard.css" rel="stylesheet" />
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="walletCard">
                                <div class="walletCardWrapper bg-blue_gradiant">
                                    <img src="images/map.png" class="white_logo_icon">
                                    <div class="WCardlogo">
                                        <%-- <img src="images/white_logo.png" width="160">--%>
                                    </div>
                                    <div class="Fwalletname">Company Wallet</div>
                                    <div class="chip">
                                        <img src="images/chip.png">
                                    </div>
                                    <svg class="wave" viewbox="0 3.71 26.959 38.787" width="26.959" height="38.787" fill="white">
                                        <path d="M19.709 3.719c.266.043.5.187.656.406 4.125 5.207 6.594 11.781 6.594 18.938 0 7.156-2.469 13.73-6.594 18.937-.195.336-.57.531-.957.492a.9946.9946 0 0 1-.851-.66c-.129-.367-.035-.777.246-1.051 3.855-4.867 6.156-11.023 6.156-17.718 0-6.696-2.301-12.852-6.156-17.719-.262-.317-.301-.762-.102-1.121.204-.36.602-.559 1.008-.504z"></path>
                                        <path d="M13.74 7.563c.231.039.442.164.594.343 3.508 4.059 5.625 9.371 5.625 15.157 0 5.785-2.113 11.097-5.625 15.156-.363.422-1 .472-1.422.109-.422-.363-.472-1-.109-1.422 3.211-3.711 5.156-8.551 5.156-13.843 0-5.293-1.949-10.133-5.156-13.844-.27-.309-.324-.75-.141-1.114.188-.367.578-.582.985-.542h.093z"></path>
                                        <path d="M7.584 11.438c.227.031.438.144.594.312 2.953 2.863 4.781 6.875 4.781 11.313 0 4.433-1.828 8.449-4.781 11.312-.398.387-1.035.383-1.422-.016-.387-.398-.383-1.035.016-1.421 2.582-2.504 4.187-5.993 4.187-9.875 0-3.883-1.605-7.372-4.187-9.875-.321-.282-.426-.739-.266-1.133.164-.395.559-.641.984-.617h.094zM1.178 15.531c.121.02.238.063.344.125 2.633 1.414 4.437 4.215 4.437 7.407 0 3.195-1.797 5.996-4.437 7.406-.492.258-1.102.07-1.36-.422-.257-.492-.07-1.102.422-1.359 2.012-1.075 3.375-3.176 3.375-5.625 0-2.446-1.371-4.551-3.375-5.625-.441-.204-.676-.692-.551-1.165.122-.468.567-.785 1.051-.742h.094z"></path>
                                    </svg>
                                    <div class="wallet-amount">
                                        <h4>
                                            <asp:Label ID="lbl_UserName_CWallet" runat="server"></asp:Label></h4>
                                        <small>Available</small>
                                        <h4 class="m-0"><a id="lbl_C_Wallet" runat="server" href="dwallet.aspx" class="text-white">0</a></h4>
                                    </div>
                                    <div class="Lbtn">
                                        <a href="BarcodeBilling.aspx" class="btn btn-warning1  btn-sm">Shop Now</a>
                                        <a href="dwallet.aspx" class="btn btn-primary1 btn-sm mr-1">Passbook</a>
                                    </div>
                                    <div class="Rbtn">
                                        <img src="images/visa-logo.png" width="100px" />
                                        <%-- <a href="#" class="btn btn-dark1 btn-sm">Passbook</a>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 d-none">
                            <div class="walletCard">
                                <div class="walletCardWrapper bg-green_gradiant">
                                    <img src="images/map.png" class="white_logo_icon">
                                    <div class="WCardlogo">
                                        <%--<img src="images/white_logo.png" width="160">--%>
                                    </div>
                                    <div class="Fwalletname">Product Wallet</div>
                                    <div class="chip">
                                        <img src="images/chip.png">
                                    </div>
                                    <svg class="wave" viewbox="0 3.71 26.959 38.787" width="26.959" height="38.787" fill="white">
                                        <path d="M19.709 3.719c.266.043.5.187.656.406 4.125 5.207 6.594 11.781 6.594 18.938 0 7.156-2.469 13.73-6.594 18.937-.195.336-.57.531-.957.492a.9946.9946 0 0 1-.851-.66c-.129-.367-.035-.777.246-1.051 3.855-4.867 6.156-11.023 6.156-17.718 0-6.696-2.301-12.852-6.156-17.719-.262-.317-.301-.762-.102-1.121.204-.36.602-.559 1.008-.504z"></path>
                                        <path d="M13.74 7.563c.231.039.442.164.594.343 3.508 4.059 5.625 9.371 5.625 15.157 0 5.785-2.113 11.097-5.625 15.156-.363.422-1 .472-1.422.109-.422-.363-.472-1-.109-1.422 3.211-3.711 5.156-8.551 5.156-13.843 0-5.293-1.949-10.133-5.156-13.844-.27-.309-.324-.75-.141-1.114.188-.367.578-.582.985-.542h.093z"></path>
                                        <path d="M7.584 11.438c.227.031.438.144.594.312 2.953 2.863 4.781 6.875 4.781 11.313 0 4.433-1.828 8.449-4.781 11.312-.398.387-1.035.383-1.422-.016-.387-.398-.383-1.035.016-1.421 2.582-2.504 4.187-5.993 4.187-9.875 0-3.883-1.605-7.372-4.187-9.875-.321-.282-.426-.739-.266-1.133.164-.395.559-.641.984-.617h.094zM1.178 15.531c.121.02.238.063.344.125 2.633 1.414 4.437 4.215 4.437 7.407 0 3.195-1.797 5.996-4.437 7.406-.492.258-1.102.07-1.36-.422-.257-.492-.07-1.102.422-1.359 2.012-1.075 3.375-3.176 3.375-5.625 0-2.446-1.371-4.551-3.375-5.625-.441-.204-.676-.692-.551-1.165.122-.468.567-.785 1.051-.742h.094z"></path>
                                    </svg>
                                    <div class="wallet-amount">
                                        <h4>
                                            <asp:Label ID="lbl_UserName_PWallet" runat="server"></asp:Label></h4>
                                        <small>Available</small>
                                        <h4 class="m-0"><a id="lbl_P_Wallet" runat="server" href="WalletProduct.aspx" class="text-white">0</a></h4>
                                    </div>
                                    <div class="Lbtn">
                                        <a href="BarcodeBilling.aspx" class="btn btn-warning1  btn-sm">Shop Now</a>
                                        <a href="WalletProduct.aspx" class="btn btn-primary1 btn-sm mr-1">Passbook</a>
                                    </div>
                                    <div class="Rbtn">
                                        <img src="images/master-logo.png" width="100px" />
                                        <%-- <a href="#" class="btn btn-dark1 btn-sm">Passbook</a>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="walletCard">
                                <div class="walletCardWrapper bg-orange_gradian">
                                    <img src="images/map.png" class="white_logo_icon">
                                    <div class="WCardlogo">
                                        <%--<img src="images/white_logo.png" width="160">--%>
                                    </div>
                                    <div class="Fwalletname">Payout Wallet</div>
                                    <div class="chip">
                                        <img src="images/chip.png">
                                    </div>
                                    <svg class="wave" viewbox="0 3.71 26.959 38.787" width="26.959" height="38.787" fill="white">
                                        <path d="M19.709 3.719c.266.043.5.187.656.406 4.125 5.207 6.594 11.781 6.594 18.938 0 7.156-2.469 13.73-6.594 18.937-.195.336-.57.531-.957.492a.9946.9946 0 0 1-.851-.66c-.129-.367-.035-.777.246-1.051 3.855-4.867 6.156-11.023 6.156-17.718 0-6.696-2.301-12.852-6.156-17.719-.262-.317-.301-.762-.102-1.121.204-.36.602-.559 1.008-.504z"></path>
                                        <path d="M13.74 7.563c.231.039.442.164.594.343 3.508 4.059 5.625 9.371 5.625 15.157 0 5.785-2.113 11.097-5.625 15.156-.363.422-1 .472-1.422.109-.422-.363-.472-1-.109-1.422 3.211-3.711 5.156-8.551 5.156-13.843 0-5.293-1.949-10.133-5.156-13.844-.27-.309-.324-.75-.141-1.114.188-.367.578-.582.985-.542h.093z"></path>
                                        <path d="M7.584 11.438c.227.031.438.144.594.312 2.953 2.863 4.781 6.875 4.781 11.313 0 4.433-1.828 8.449-4.781 11.312-.398.387-1.035.383-1.422-.016-.387-.398-.383-1.035.016-1.421 2.582-2.504 4.187-5.993 4.187-9.875 0-3.883-1.605-7.372-4.187-9.875-.321-.282-.426-.739-.266-1.133.164-.395.559-.641.984-.617h.094zM1.178 15.531c.121.02.238.063.344.125 2.633 1.414 4.437 4.215 4.437 7.407 0 3.195-1.797 5.996-4.437 7.406-.492.258-1.102.07-1.36-.422-.257-.492-.07-1.102.422-1.359 2.012-1.075 3.375-3.176 3.375-5.625 0-2.446-1.371-4.551-3.375-5.625-.441-.204-.676-.692-.551-1.165.122-.468.567-.785 1.051-.742h.094z"></path>
                                    </svg>
                                    <div class="wallet-amount">
                                        <h4>
                                            <asp:Label ID="lbl_UserName_GWallet" runat="server"></asp:Label></h4>
                                        <small>Available</small>
                                        <h4 class="m-0"><a id="lbl_GenerationBal" runat="server" href="pwallet.aspx" class="text-white">0</a></h4>
                                    </div>
                                    <div class="Lbtn">
                                        <a href="BarcodeBilling.aspx" class="btn btn-warning1  btn-sm">Shop Now</a>

                                        <a href="pwallet.aspx" class="btn btn-primary1 btn-sm mr-1">Passbook</a>
                                        <a href="TransferWallet.aspx" class="btn btn-warning1  btn-sm">Transfer</a>
                                    </div>
                                    <div class="Rbtn">
                                        <img src="images/rupay-logo.png" width="100px" />
                                        <%-- <a href="#" class="btn btn-dark1 btn-sm">Passbook</a>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-6 d-none">
                            <div class="walletCard">
                                <div class="walletCardWrapper bg-vallet_gradiant">
                                    <img src="images/map.png" class="white_logo_icon">
                                    <div class="WCardlogo">
                                        <%--<img src="images/white_logo.png" width="160">--%>
                                    </div>
                                    <div class="Fwalletname">Consistency Wallet</div>
                                    <div class="chip">
                                        <img src="images/chip.png">
                                    </div>
                                    <svg class="wave" viewbox="0 3.71 26.959 38.787" width="26.959" height="38.787" fill="white">
                                        <path d="M19.709 3.719c.266.043.5.187.656.406 4.125 5.207 6.594 11.781 6.594 18.938 0 7.156-2.469 13.73-6.594 18.937-.195.336-.57.531-.957.492a.9946.9946 0 0 1-.851-.66c-.129-.367-.035-.777.246-1.051 3.855-4.867 6.156-11.023 6.156-17.718 0-6.696-2.301-12.852-6.156-17.719-.262-.317-.301-.762-.102-1.121.204-.36.602-.559 1.008-.504z"></path>
                                        <path d="M13.74 7.563c.231.039.442.164.594.343 3.508 4.059 5.625 9.371 5.625 15.157 0 5.785-2.113 11.097-5.625 15.156-.363.422-1 .472-1.422.109-.422-.363-.472-1-.109-1.422 3.211-3.711 5.156-8.551 5.156-13.843 0-5.293-1.949-10.133-5.156-13.844-.27-.309-.324-.75-.141-1.114.188-.367.578-.582.985-.542h.093z"></path>
                                        <path d="M7.584 11.438c.227.031.438.144.594.312 2.953 2.863 4.781 6.875 4.781 11.313 0 4.433-1.828 8.449-4.781 11.312-.398.387-1.035.383-1.422-.016-.387-.398-.383-1.035.016-1.421 2.582-2.504 4.187-5.993 4.187-9.875 0-3.883-1.605-7.372-4.187-9.875-.321-.282-.426-.739-.266-1.133.164-.395.559-.641.984-.617h.094zM1.178 15.531c.121.02.238.063.344.125 2.633 1.414 4.437 4.215 4.437 7.407 0 3.195-1.797 5.996-4.437 7.406-.492.258-1.102.07-1.36-.422-.257-.492-.07-1.102.422-1.359 2.012-1.075 3.375-3.176 3.375-5.625 0-2.446-1.371-4.551-3.375-5.625-.441-.204-.676-.692-.551-1.165.122-.468.567-.785 1.051-.742h.094z"></path>
                                    </svg>
                                    <div class="wallet-amount">
                                        <h4>
                                            <asp:Label ID="lbl_UserName_Loyalty" runat="server"></asp:Label></h4>
                                        <small>Available</small>
                                        <h4 class="m-0"><a id="lbl_LoyaltyWallet" runat="server" href="LoyaltyWallet.aspx" class="text-white">0</a></h4>
                                    </div>
                                    <div class="Lbtn">
                                        <a href="BarcodeBilling.aspx" class="btn btn-warning1  btn-sm">Shop Now</a>
                                        <a href="LoyaltyWallet.aspx" class="btn btn-primary1 btn-sm mr-1">Passbook</a>
                                    </div>
                                    <div class="Rbtn">
                                        <img src="images/american-logo.png" width="100px" />
                                        <%-- <a href="#" class="btn btn-dark1 btn-sm">Passbook</a>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">T Wallet</p>
                                            <h3 class="text-orange text-end"> 
                                                <a id="lbl_TopperBal" runat="server" href="TWallet.aspx" class="text-white">0</a>
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
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
                        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
                            <div class="widget-stat card bg-blue">
                                <div class="card-body  p-3">
                                    <div class="media">
                                        <div class="media-body text-white">
                                            <p class="mb-0 text-left">Lucky Draw Coupons List</p>
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
                            <asp:DropDownList ID="ddl_SearchTyp" runat="server" CssClass="form-control">
                                <asp:ListItem Value="GenerationRank">Generation Rank</asp:ListItem>
                                <%-- <asp:ListItem Value="TopperRank">Topper Rank</asp:ListItem>--%>
                                <asp:ListItem Value="DomesticTour">Domestic Tour</asp:ListItem>
                                <asp:ListItem Value="InternationalTour">International Tour</asp:ListItem>
                                <asp:ListItem Value="Loyalty">Consistency</asp:ListItem>
                                <asp:ListItem Value="RetailBoosterLoyalty">Arogyam Wellness Center Loyalty</asp:ListItem>
                                <asp:ListItem Value="Staterfund">Stater Fund</asp:ListItem>
                                <asp:ListItem Value="TopEarnersclub">Top Earners Club</asp:ListItem>
                                <asp:ListItem Value="RankUpgrade">Qualified Star</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <%--<div class="col-md-3">
                            <asp:DropDownList ID="ddl_Month" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>--%>

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
                    <div class="html-content" id="div_EventTour"></div>
                </div>

                <div class="tab-pane fade" id="star_insurance">

                    <div id="printableArea">
                        <div style="font-size: 10px; background-image: url(images/star_insurance_card1.jpg); background-repeat: no-repeat; height: 276px; width: 470px;">
                            <div style="padding-left: 31px; padding-top: 7.8em; color: #e7e3e0; font-size: 13.5px; font-family: arial;">
                                <table>
                                    <tbody>
                                        <tr style="height: 40px;">
                                            <td>
                                                <p style="margin-bottom: 0px; line-height: 1.5;">
                                                    <span><%=method.Associate%> Name : </span>
                                                    <span id="lbl_Inc_UserName" runat="server" style="font-weight: 600; font-size: 14px; text-transform: uppercase"></span>
                                                </p>
                                                <p style="margin-bottom: 0px; line-height: 1.5;">
                                                    <span><%=method.Associate%> ID : </span>
                                                    <span id="lbl_Inc_Userid" runat="server"></span>
                                                </p>

                                                <p style="margin-bottom: 0px; line-height: 1.5;">
                                                    <span>Policy No : </span>
                                                    <span id="lbl_Inc_PolicyNo" runat="server"></span>
                                                </p>
                                                <p style="margin-bottom: 0px; line-height: 1.5;">
                                                    <span>Sum Insured : </span>
                                                    <span id="lbl_Inc_SumInsured" runat="server"></span>
                                                </p>
                                                <p style="margin-bottom: 0px; line-height: 1.5;">
                                                    <span>Start Date : </span>
                                                    <span id="lbl_Inc_StartDate" runat="server"></span>
                                                </p>
                                                <p style="margin-bottom: 0px; line-height: 1.5;">
                                                    <span>End Date :</span>
                                                    <span id="lbl_Inc_EndDate" runat="server"></span>
                                                </p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5 text-center">
                        <input type="button" class="btn btn-primary" onclick="printDiv('printableArea')" value="Print " />
                    </div>
                </div>

                <div class="tab-pane fade" id="car">
                    <!--#include virtual="car_tc.aspx"-->
                </div>
                <div class="tab-pane fade" id="pfo">
                    <!--#include virtual="pfo.aspx"-->
                </div>
                <div class="tab-pane fade" id="leaderboard">
                    <!--#include virtual="leaderboard1.aspx"-->
                </div>
            </div>
        </div>
    </div>


    <div class="clearfix">
    </div>

    <link rel="stylesheet" type="text/css" href="../popup/style.css" />

    <%-- <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>--%>

    <%------- print Insurance------%>
    <script>
        function printDiv(divName) {

            var printContents = document.getElementById(divName).innerHTML;

            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
    <%------- print Insurance End------%>
    <script type="text/javascript">
      <%--  $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });--%>

        function HideMe() {
            jQuery('.popup1').hide();
            jQuery('#fade').hide();
        }

       <%-- $(function () {
            DailyPayoutdate($('#<%=hnf_DailyPayoutDate.ClientID%>').val());
            MonthlyPayoutdate($('#<%=hnf_MonthlyPayoutDate.ClientID%>').val());
            WeeklyPayoutdate($('#<%=hnf_WeeklyPayoutDate.ClientID%>').val());

        });--%>


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
            let Month = "";
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
                        }


                        if (flag == "RankUpgrade") {
                            json.push([i + 1,
                            '<a href="../secretadmin/Template_QualiStar.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName
                            + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].Rank + '&RN=' + data.d[i].RN
                            + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>',
                            data.d[i].Month,
                            data.d[i].Rank,
                            data.d[i].RN,
                            ]);
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


                    if (flag == "RankUpgrade") {
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
                    let Int_Condition = 0, Int_Achieved = 0, Int_PermittedGPV = 0, Int_Shortfall = 0;
                    let TotalContaint = "", Containt = "", Tid = "", TourType = "";
                    if (data.d.length > 0) {

                        var ArrTours = data.d[0].NoOfTours.split(",");
                        for (var i in ArrTours) {
                            Tid = ArrTours[i];
                            if (parseInt(Tid) > 0) {
                                for (let j = 0; j < data.d.length; j++) {

                                    if (data.d[j].Tid == Tid && data.d[j].TourType != "4") {
                                        TourType = data.d[j].TourType;

                                        if (Containt == "") {
                                            Containt += "<div class='widget-stat bg-blue'>";
                                            Containt += "<div class='card-body p-6'>";
                                            Containt += "<table class='table text-white'>";
                                            Containt += "<thead> <tr> <th colspan='6' class='text-center'>" + data.d[j].TourName + " (" + data.d[j].Perid + ")</th> </tr> </thead> ";
                                            Containt += "<thead>";
                                            Containt += "<tr class='selected'>";
                                            Containt += "<th class='selected'>Leg ID</th>";
                                            Containt += "<th class='selected'>User Name</th>";
                                            Containt += "<th class='selected'>Required</th>";
                                            Containt += "<th class='selected'>Achieved</th>";
                                            Containt += "<th class='selected'>Permitted <%=method.GBV%></th>";
                                            Containt += "<th class='selected'>Shortfall</th>";
                                            Containt += "</tr>";
                                            Containt += "</thead>";
                                            Containt += "<tbody>";
                                        }


                                        Containt += "<tr class='selected'>";
                                        Containt += "<td class='selected'>" + data.d[j].LegID + "</td>";
                                        Containt += "<td class='selected'>" + data.d[j].UserName + "</td>";
                                        Containt += "<td class='selected currency-inr'>" + CurrencyFormate(data.d[j].Required) + "</td>";
                                        Containt += "<td class='selected'>" + CurrencyFormate(data.d[j].Achieved) + "</td>";
                                        Containt += "<td class='selected'>" + CurrencyFormate(data.d[j].PermittedGPV) + "</td>";
                                        Containt += "<td >" + CurrencyFormate(data.d[j].Shortfall) + "</td>";
                                        Containt += "</tr>";

                                        Int_Condition = data.d[j].Condition;
                                        Int_Achieved = parseInt(Int_Achieved) + parseInt(data.d[j].Achieved);
                                        Int_PermittedGPV = parseInt(Int_PermittedGPV) + parseInt(data.d[j].PermittedGPV);
                                        Int_Shortfall = parseInt(Int_Shortfall) + parseInt(data.d[j].Shortfall);

                                        //if (TourType == "4") {
                                        //    if (parseInt(data.d[j].Achieved) >= parseInt(data.d[j].Condition)) {
                                        //        MaxLegCount = parseInt(MaxLegCount) + 1;
                                        //    }
                                        //}
                                    }
                                }
                                if (Containt != "") {
                                    Containt += "</tbody>";
                                    Containt += "<thead>";
                                    Containt += "<tr class='selected' style='border-top:1px solid #ffffff'>";
                                    Containt += "<td class='selected'>Total</td>";
                                    Containt += "<td class='selected'></td>";
                                    Containt += "<td class='selected'>" + CurrencyFormate(Int_Condition) + "</td>";
                                    Containt += "<td class='selected'>" + CurrencyFormate(Int_Achieved) + "</td>";
                                    Containt += "<td class='selected'>" + CurrencyFormate(Int_PermittedGPV) + "</td>";
                                    Containt += "<td style=' font-size: 1.2rem; text-align:left;'>" + CurrencyFormate(Int_Shortfall) + "</td>";
                                    Containt += "</tr>";
                                    Containt += "</thead>";


                                    //if (TourType == "4") {
                                    //    Containt += "<thead>";
                                    //    Containt += "<tr class='selected' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff;'>";
                                    //    Containt += "<td  colspan='6' style='border-bottom:1px solid #fff!important;  color: #fe6a00; font-size: 20px;'>Note: <b>*</b>Applicable for Bronze and below</td>";
                                    //    Containt += "</tr>";
                                    //    Containt += "</thead>";
                                    //}
                                    //else {
                                    if (TourType != "4") {
                                        Containt += "<thead>";
                                        Containt += "<tr class='selected' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff;'>";
                                        Containt += "<td class='selected' style='color: #fe6a00;'>Status</td>";
                                        Containt += "<td class='selected' style='color: #fe6a00;'>Achieved</td>";

                                        if (parseInt(Int_PermittedGPV) >= parseInt(Int_Condition))
                                            Containt += "<td  colspan='4' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>Yes</td>";
                                        else
                                            Containt += "<td  colspan='4' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>No</td>";

                                        Containt += "</tr>";
                                        Containt += "</thead>";
                                    }
                                    //}


                                    Containt += " </table> ";
                                    Containt += " </div> </div> ";
                                }
                                TotalContaint += Containt;

                                Containt = "";
                                Int_Condition = 0;
                                Int_Achieved = 0;
                                Int_PermittedGPV = 0;
                                Int_Shortfall = 0;
                            }
                        }
                    }


                    $('#div_TourTbl').empty().append(TotalContaint);
                    if (TotalContaint == '')
                        $('#div_TourTbl').hide();
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function GetQualifiedStar() {
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: 'Dashboard.aspx/TourList',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {



                    $('#LoaderImg').hide();
                    let Int_Condition = 0, Int_Achieved = 0, Int_PermittedGPV = 0, Int_Shortfall = 0, MaxLegCount = 0;
                    let TotalContaint = "", Containt = "", Tid = "", TourType = "";
                    if (data.d.length > 0) {

                        var ArrTours = data.d[0].NoOfTours.split(",");
                        for (var i in ArrTours) {

                            Tid = ArrTours[i];
                            if (parseInt(Tid) > 0) {
                                for (let j = 0; j < data.d.length; j++) {

                                    if (data.d[j].Tid == Tid && data.d[j].TourType == "4") {
                                        TourType = data.d[j].TourType;

                                        if (Containt == "") {
                                            Containt += "<div class='widget-stat bg-blue'>";
                                            Containt += "<div class='card-body p-6'>";
                                            Containt += "<table class='table text-white'>";
                                            Containt += "<thead> <tr> <th colspan='6' class='text-center'>" + data.d[j].TourName + " (" + data.d[j].Perid + ")</th> </tr> </thead> ";
                                            Containt += "<thead>";
                                            Containt += "<tr class='selected'>";
                                            Containt += "<th class='selected'>Leg ID</th>";
                                            Containt += "<th class='selected'>User Name</th>";
                                            Containt += "<th class='selected'>Required</th>";
                                            Containt += "<th class='selected'>Achieved</th>";
                                            Containt += "<th class='selected'>Permitted <%=method.GBV%></th>";
                                            Containt += "<th class='selected'>Shortfall</th>";
                                            Containt += "</tr>";
                                            Containt += "</thead>";
                                            Containt += "<tbody>";
                                        }


                                        Containt += "<tr class='selected'>";
                                        Containt += "<td class='selected'>" + data.d[j].LegID + "</td>";
                                        Containt += "<td class='selected'>" + data.d[j].UserName + "</td>";
                                        Containt += "<td class='selected currency-inr'>" + CurrencyFormate(data.d[j].Required) + "</td>";
                                        Containt += "<td class='selected'>" + CurrencyFormate(data.d[j].Achieved) + "</td>";
                                        Containt += "<td class='selected'>" + CurrencyFormate(data.d[j].PermittedGPV) + "</td>";
                                        Containt += "<td >" + CurrencyFormate(data.d[j].Shortfall) + "</td>";
                                        Containt += "</tr>";

                                        Int_Condition = data.d[j].Condition;
                                        Int_Achieved = parseInt(Int_Achieved) + parseInt(data.d[j].Achieved);
                                        Int_PermittedGPV = parseInt(Int_PermittedGPV) + parseInt(data.d[j].PermittedGPV);
                                        Int_Shortfall = parseInt(Int_Shortfall) + parseInt(data.d[j].Shortfall);

                                    }
                                }

                                if (Containt != "") {

                                    Containt += "</tbody>";
                                    Containt += "<thead>";
                                    Containt += "<tr class='selected' style='border-top:1px solid #ffffff'>";
                                    Containt += "<td class='selected'>Total</td>";
                                    Containt += "<td class='selected'></td>";
                                    Containt += "<td class='selected'>" + CurrencyFormate(Int_Condition) + "</td>";
                                    Containt += "<td class='selected'>" + CurrencyFormate(Int_Achieved) + "</td>";
                                    Containt += "<td class='selected'>" + CurrencyFormate(Int_PermittedGPV) + "</td>";
                                    Containt += "<td style=' font-size: 1.2rem; text-align:left;'>" + CurrencyFormate(Int_Shortfall) + "</td>";
                                    Containt += "</tr>";
                                    Containt += "</thead>";


                                    if (TourType == "4") {
                                        Containt += "<thead>";
                                        Containt += "<tr class='selected' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff;'>";
                                        Containt += "<td  colspan='6' style='border-bottom:1px solid #fff!important;  color: #fe6a00; font-size: 20px;'>Note: <b>*</b>Applicable for Bronze and below</td>";
                                        Containt += "</tr>";
                                        Containt += "</thead>";
                                    }
                                    //else {
                                    //    Containt += "<thead>";
                                    //    Containt += "<tr class='selected' style='border-top:1px solid #ffffff; border-bottom:1px solid #ffffff;'>";
                                    //    Containt += "<td class='selected' style='color: #fe6a00;'>Status</td>";
                                    //    Containt += "<td class='selected' style='color: #fe6a00;'>Achieved</td>";

                                    //    if (parseInt(Int_PermittedGPV) >= parseInt(Int_Condition))
                                    //        Containt += "<td  colspan='4' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>Yes</td>";
                                    //    else
                                    //        Containt += "<td  colspan='4' style='border-bottom:1px solid #fff!important; text-align:center; color: #fe6a00; font-size: 20px;'>No</td>";

                                    //    Containt += "</tr>";
                                    //    Containt += "</thead>";
                                    //}


                                    Containt += " </table> ";
                                    Containt += " </div> </div> ";
                                }
                                TotalContaint += Containt;

                                Containt = "";
                                Int_Condition = 0;
                                Int_Achieved = 0;
                                Int_PermittedGPV = 0;
                                Int_Shortfall = 0;
                            }
                        }
                    }


                    $('#div_QualifiedStar').empty().append(TotalContaint);
                    if (TotalContaint == '')
                        $('#div_QualifiedStar').hide();
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
            //$('#btn_PDF').hide();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: 'Dashboard.aspx/BindEventTour',
                //data: '{min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var Contents = '';
                    for (var i = 0; i < data.d.length; i++) {

                        // $('#btn_PDF').show();
                        Contents = '';

                        /*  Contents += '<div id="Div_BarCode' + (i + 1) + '" style="width: 300px; height: 550px; margin: auto">';
                          Contents += '<div style="background-image: url(images/barcode.jpg); background-repeat: no-repeat; height: 532px; width: 300px;">';
                          Contents += '<div style="padding-left: 45px; padding-top: 168px;"> <svg id="BarCode' + (i + 1) + '" style="height: 58px; width: 355px; width: 214px; border-width: 0px;"></svg>  </div>';
                          Contents += '<div style="padding-left: 32px; padding-top: 72px;">';
                          Contents += ' <table> <tbody>';
  
                          Contents += '<tr>';
                          Contents += '<td><span style="font-size: 16px; color: #ffffff; font-weight: bold; font-family: arial;">Name : </span></td>';
                          Contents += '<td> <span style="font-size: 16px; color: #ffffff; font-family: arial;">' + data.d[i].AppMstFName + '</span> </td>';
                          Contents += '</tr>';
  
                          Contents += '<tr>';
                          Contents += '<td><span style="font-size: 16px; color: #ffffff; font-weight: bold; font-family: arial;">ID no : </span></td>';
                          Contents += '<td> <span style="font-size: 16px; color: #ffffff; font-family: arial;">' + data.d[i].AppMstRegNo + '</span> </td>';
                          Contents += '</tr>';
  
                          Contents += '<tr>';
                          Contents += '<td><span style="font-size: 16px; color: #ffffff; font-weight: bold; font-family: arial;">Date : </span></td>';
                          Contents += '<td> <span style="font-size: 16px; color: #ffffff; font-family: arial;">' + data.d[i].Date + '</span> </td>';
                          Contents += '</tr>';
  
                          Contents += '<tr>';
                          Contents += '<td><span style="font-size: 16px; color: #ffffff; font-weight: bold; font-family: arial;">Time : </span></td>';
                          Contents += '<td> <span style="font-size: 16px; color: #ffffff; font-family: arial;">' + data.d[i].Time + '</span> </td>';
                          Contents += '</tr>';
  
                          Contents += '<tr>';
                          Contents += '<td><span style="font-size: 16px; color: #ffffff; font-weight: bold; font-family: arial;">Place : </span></td>';
                          Contents += '<td> <span style="font-size: 16px; color: #ffffff; font-family: arial;">' + data.d[i].Place + '</span> </td>';
                          Contents += '</tr>';
  
                          Contents += '<tr>';
                          Contents += '<td><span style="font-size: 16px; color: #ffffff; font-weight: bold; font-family: arial;">Venue : </span></td>';
                          Contents += '<td> <span style="font-size: 16px; color: #ffffff; font-family: arial;">' + data.d[i].Venue + '</span> </td>';
                          Contents += '</tr>';
  
                          Contents += '</tbody> </table>';
                          Contents += '</div>';
                          Contents += '</div>';
                          Contents += '</div> <br>'; */




                        /*Contents += '<div id="Div_BarCode' + (i + 1) + '" style="width: 720px; margin: auto;">';
                        Contents += '<div style="background-image: url(images/barcode.jpg); background-repeat: no-repeat; height: 1280px; width: 720px;">';
                        Contents += '<div style="padding-left: 141px; padding-top: 416px;">';
                        Contents += '<table> <tbody> <tr> <td> <svg id="BarCode' + (i + 1) + '" style="height: 120px; width: 447px; border-width: 0px;"></svg>  </td> </tr> </tbody>  </table>';
                         
                        Contents += '</div>';
                        Contents += '<div style="padding-left: 70px; padding-top: 188px;">';
                        Contents += '<table> <tbody> ';
                        Contents += '<tr>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-weight: bold; font-family: arial;">Name : </span></td>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-family: arial;">' + data.d[i].AppMstFName + ' </span>  </td>';
                        Contents += '</tr>';
                        Contents += '<tr>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-weight: bold; font-family: arial;">ID no :</span></td>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-family: arial;">' + data.d[i].AppMstRegNo + '</span> </td>';
                        Contents += '</tr>';
                        Contents += '<tr>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-weight: bold; font-family: arial;">Date : </span></td>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-family: arial;">' + data.d[i].Date + '</span> </td>';
                        Contents += '</tr>';
                        Contents += '<tr>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-weight: bold; font-family: arial;">Time : </span></td>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-family: arial;">' + data.d[i].Time + '</span> </td>';
                        Contents += '</tr>';
                        Contents += '<tr>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-weight: bold; font-family: arial;">Place : </span></td>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-family: arial;">' + data.d[i].Place + '</span> </td>';
                        Contents += '</tr>';

                        Contents += '<tr>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-weight: bold; font-family: arial;">Venue : </span></td>';
                        Contents += '<td> <span style="font-size: 36px; color: #ffffff; font-family: arial;">' + data.d[i].Venue + '</span> </td>';
                        Contents += '</tr>';
                        Contents += '</tbody> </table>';
                        Contents += '</div>';
                        Contents += '</div>';
                        Contents += '</div> <br>';*/



                        Contents += '<div id="Div_BarCode' + (i + 1) + '" style="width: 290px; height: 400px; margin: auto">';
                        Contents += '<div style="background-image: url(images/barcode_new.jpg); background-repeat: no-repeat; height: 400px; width: 290px;">';

                        Contents += '<div style="padding-left: 0px; padding-top: 126px;"> <svg id="BarCode' + (i + 1) + '" style="height: 45px; width: 230px; border-width: 0px;"></svg>  </div>';
                        Contents += '<div style="padding-left: 26px; padding-top: 58px;">';
                        Contents += ' <table> <tbody>';

                        Contents += '<tr>';
                        Contents += '<td><span style="font-size: 12px; color: #ffffff; font-weight: bold; font-family: arial;">Name : </span></td>';
                        Contents += '<td> <span style="font-size: 12px; color: #ffffff; font-family: arial;">' + data.d[i].AppMstFName + '</span> </td>';
                        Contents += '</tr>';

                        Contents += '<tr>';
                        Contents += '<td><span style="font-size: 12px; color: #ffffff; font-weight: bold; font-family: arial;">ID no : </span></td>';
                        Contents += '<td> <span style="font-size: 12px; color: #ffffff; font-family: arial;">' + data.d[i].AppMstRegNo + '</span> </td>';
                        Contents += '</tr>';

                        Contents += '<tr>';
                        Contents += '<td><span style="font-size: 12px; color: #ffffff; font-weight: bold; font-family: arial;">Date : </span></td>';
                        Contents += '<td> <span style="font-size: 12px; color: #ffffff; font-family: arial;">' + data.d[i].Date + '</span> </td>';
                        Contents += '</tr>';

                        Contents += '<tr>';
                        Contents += '<td><span style="font-size: 12px; color: #ffffff; font-weight: bold; font-family: arial;">Time : </span></td>';
                        Contents += '<td> <span style="font-size: 12px; color: #ffffff; font-family: arial;">' + data.d[i].Time + '</span> </td>';
                        Contents += '</tr>';

                        Contents += '<tr>';
                        Contents += '<td><span style="font-size: 12px; color: #ffffff; font-weight: bold; font-family: arial;">Place : </span></td>';
                        Contents += '<td> <span style="font-size: 12px; color: #ffffff; font-family: arial;">' + data.d[i].Place + '</span> </td>';
                        Contents += '</tr>';

                        Contents += '<tr>';
                        Contents += '<td><span style="font-size: 12px; color: #ffffff; font-weight: bold; font-family: arial;">Venue : </span></td>';
                        Contents += '<td> <span style="font-size: 12px; color: #ffffff; font-family: arial;">' + data.d[i].Venue + '</span> </td>';
                        Contents += '</tr>';

                        Contents += '</tbody> </table>';
                        Contents += '</div>';
                        Contents += '</div>';
                        Contents += '</div> <br>';


                        Contents += '<center><a href="javascript:void(0)" class="btn btn-primary" onclick="generatePDF(' + (i + 1) + ')">Save Ticket</a> </center> <br>';

                        $("#div_EventTour").empty().append(Contents);

                        JsBarcode("#BarCode" + (i + 1), data.d[i].QRCode, { format: "code128", displayValue: true, lineColor: "#24292e", width: 2, height: 30, fontSize: 12 });
                        Contents = '';

                    }

                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }



        //function generatePDF() {
        //    var panel = document.getElementById("div_EventTour");
        //    var printWindow = window.open('', '', 'height=500,width=1000');
        //      printWindow.document.write('<html><head><title>Save Ticket</title>'); 
        //    printWindow.document.write('</head><body >');
        //    printWindow.document.write(panel.innerHTML);
        //    printWindow.document.write('</body></html>');
        //    printWindow.document.close();
        //    setTimeout(function () { printWindow.print(); }, 500);
        //    return false;
        //}



        function generatePDF(id) {

            // var HTML_Width = "260"; // $("#Div_BarCode" + id).width();
            // var HTML_Height = "400"; // $("#Div_BarCode" + id).height();

            var HTML_Width = $("#Div_BarCode" + id).width();
            var HTML_Height = $("#Div_BarCode" + id).height();
            var top_left_margin = 15;
            var PDF_Width = HTML_Width + (top_left_margin * 0);
            var PDF_Height = (PDF_Width * 1.5) + (top_left_margin * 0);
            var canvas_image_width = HTML_Width;
            var canvas_image_height = HTML_Height;

            var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;

            html2canvas($("#Div_BarCode" + id)[0]).then(function (canvas) {
                var imgData = canvas.toDataURL("image/jpeg", 1.0);
                var pdf = new jsPDF('p', 'pt', [PDF_Width, PDF_Height]);
                pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin, canvas_image_width, canvas_image_height);
                for (var i = 1; i <= totalPDFPages; i++) {
                    pdf.addPage(PDF_Width, PDF_Height);
                    pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height * i) + (top_left_margin * 4), canvas_image_width, canvas_image_height);
                }
                pdf.save("EventTour.pdf");
            });
        }


    </script>


    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>


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

        .container-fluid {
            background: #F8F8F8 !important;
        }

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
                <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup()" style="position: absolute; right: 5px; top: 5px; z-index: 9999;">
                </button>

                <%--<img src="https://toptimenet.com/images/PopupImage/WhatsApp%20Image%202022-05-07%20at%2010.34.50%20AM.jpeg" width="100%" />--%>

                <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div id="div_Popup_img" runat="server"></div>

                        <%--
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="https://toptimenet.com/images/SliderImage/show%20the%20plan%20(1).jpg" >
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="https://toptimenet.com/images/SliderImage/show%20the%20plan%20(1).jpg">
                                              
                    </div>   --%>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>
    </div>


    <style>
        @media (max-width: 480px) {
            .Rbtn {
                display: none;
            }
        }
    </style>
</asp:Content>
