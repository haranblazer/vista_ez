<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="directors-dashboard.aspx.cs" Inherits="secretadmin_directors_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function GetDashboardUrl(flag) {
            var From = $('#<%=txtFromDate.ClientID%>').val(),
                To = $('#<%=txtToDate.ClientID%>').val();

            if (flag == "RPV") {
                window.location = "DashboardDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "TPV") {
                window.location = "DashboardDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "LOYALTYINV") {
                window.location = "DashboardDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "TPVRPV") {
                window.location = "SecondarySales.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }

            else if (flag == "ONLINE_INVSALES") {
                window.location = "DashboardDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "OFFLINE_INVSALES") {
                window.location = "DashboardDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "FRAN_SALES") {
                window.location = "DashboardDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            //else if (flag == "TOTAL_SALES") {
            //    window.location = "DashboardDetails.aspx?Key=" + flag +"&From=" + From + "&To=" + To;
            //}
            else if (flag == "PRIMARYSALES") {
                window.location = "PrimarySale.aspx?Key=PRIMARYSALES&From=" + From + "&To=" + To;
            }

            else if (flag == "INVSALES") {
                window.location = "DashboardDetailStateWise.aspx?Key=INVSALES&From=" + From + "&To=" + To;
            }
            else if (flag == "PRIMARYSALES") {
                window.location = "PrimarySale.aspx?Key=PRIMARYSALES&From=" + From + "&To=" + To;
            }
            else if (flag == "ONLINESALES") {
                window.location = "AssociatePackageBill.aspx?Key=ONLINESALES&From=" + From + "&To=" + To;
            }
            else if (flag == "TOTALFWALLET") {
                window.location = "FranWalReq.aspx?Key=TOTALFWALLET&From=" + From + "&To=" + To;
            }
            else if (flag == "TOTALCWALLET") {
                window.location = "UserWalletRequest.aspx?Key=TOTALCWALLET&From=" + From + "&To=" + To;
            }
            else if (flag == "PENDING_F_WALLET") {
                window.location = "FranWalReq.aspx?Key=PENDINGFWALLET&From=" + From + "&To=" + To;
            }
            else if (flag == "PENDING_C_WALLET") {
                window.location = "UserWalletRequest.aspx?Key=PENDINGCWALLET&From=" + From + "&To=" + To;
            }
            else if (flag == "PENDING_PO") {
                window.location = "POList.aspx?Key=PENDING_PO&From=" + From + "&To=" + To;
            }
            else if (flag == "PENDING_DISPATCH") {
                window.location = "AssociatePackageBill.aspx?Key=PENDING_DISPATCH&From=" + From + "&To=" + To;
            }
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

    <div class="card-action coin-tabs mt-2">
        <ul class="nav nav-tabs" role="tablist">
            <%-- <li class="nav-item">
                <a class="nav-link" href="POList.aspx" target="_blank">Purchases order Franchises
                </a>
            </li>--%>
            <li class="nav-item ml-2">
                <a class="nav-link" href="ProductList.aspx" target="_blank">Products List</a>
            </li>
            <%-- <li class="nav-item ml-2">
                <a class="nav-link" href="FranchiseList.aspx" target="_blank">Franchises List</a>
            </li>--%>
            <li class="nav-item ml-2">
                <a class="nav-link" href="adchangeprofile.aspx" target="_blank"><%=method.Associate %> profile</a>
            </li>
            <li class="nav-item ml-2">
                <a class="nav-link" href="Date_Wise_Product_Stock.aspx" target="_blank">Date Wise Closing Stock
                </a>
            </li>
            <li class="nav-item ml-2">
                <a class="nav-link" href="LatestBatchReports.aspx" target="_blank">Latest Batch Reports</a>
            </li>
        </ul>
    </div>
    <!--#include virtual="dashboard-include.aspx"-->
    <hr />
    <div class="card">
        <div class="row">
            <div class="clearfix"></div>
            <div class="col-md-3">
                <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                    <h4 class="fs-20 font-w600  me-auto">Sales Dashboard</h4>
                </div>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CssClass="btn btn-primary" />
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="row">

        <div class="col-md-6" style="display: none;">
            <div class="card">
                <div class="row separate-row">
                    <div class="col-sm-6">
                        <div class="job-icon d-flex justify-content-between" style="position: relative; display: none;">
                            <div>
                                <div class="d-flex align-items-center mb-1">
                                    <h2 class="mb-0">
                                        <a href="#" id="lbl_TPV" runat="server" onclick="return GetDashboardUrl('TPV')" class="text-orange">0</a></h2>
                                    <span id="lbl_TPV_CNT" runat="server" onclick="return GetDashboardUrl('TPV')" class="badge sticker text-white bg-primary" style="cursor: pointer; display: none;">0</span>
                                </div>
                                <span class="fs-18 d-block mb-2"><%=method.BINARY %> PV</span>
                            </div>
                            <div class="apexcharts-legend"><i class="fa fa-user-o"></i></div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="job-icon d-flex justify-content-between" style="position: relative; display: none;">
                            <div>
                                <div class="d-flex align-items-center mb-1">
                                    <h2 class="mb-0">
                                        <a href="#" id="lbl_TPV_AMT" runat="server" onclick="return GetDashboardUrl('TPV')" class="text-orange">0</a></h2>
                                </div>
                                <span class="fs-18 d-block mb-2"><%=method.BINARY %> Inv Amt</span>
                            </div>
                            <div class="apexcharts-legend"><i class="fa fa-users"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="row  separate-row">
                    <div class="col-sm-6">
                        <div class="job-icon d-flex justify-content-between" style="position: relative;">
                            <div>
                                <div class="d-flex align-items-center mb-1">
                                    <h2 class="mb-0">
                                        <a href="#" id="lbl_GPV" runat="server" onclick="return GetDashboardUrl('RPV')" class="text-primary">0</a></h2>
                                    <span class="text-primary ms-3" id="lbl_GPV_CNT" runat="server" onclick="return GetDashboardUrl('RPV')" style="cursor: pointer; display: none;">0</span>
                                </div>
                                <span class="fs-18 d-block mb-2"><%=method.PV%></span>
                            </div>
                            <div class="apexcharts-legend"><i class="fa fa-user-o"></i></div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="job-icon d-flex justify-content-between" style="position: relative;">
                            <div>
                                <div class="d-flex align-items-center mb-1">
                                    <h2 class="mb-0">
                                        <a href="#" id="lbl_GPV_AMT" runat="server" onclick="return GetDashboardUrl('RPV')" class="text-primary">0</a></h2>
                                </div>
                                <span class="fs-18 d-block mb-2"><%=method.Invoice_Amount%></span>
                            </div>
                            <div class="apexcharts-legend"><i class="fa fa-users"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="row  separate-row">
                    <div class="col-sm-6">
                        <div class="job-icon d-flex justify-content-between" style="position: relative;">
                            <div>
                                <div class="d-flex align-items-center mb-1">
                                    <h2 class="mb-0">
                                        <a href="#" id="lbl_Loyalty" runat="server" onclick="return GetDashboardUrl('LOYALTYINV')" class="text-primary">0</a></h2>
                                    <span id="lbl_Loyalty_CNT" runat="server" onclick="return GetDashboardUrl('LOYALTYINV')" class="badge sticker text-white bg-primary" style="cursor: pointer; display: none;">0</span>
                                </div>
                                <span class="fs-18 d-block mb-2">Consistency Invoice</span>
                            </div>
                            <div class="apexcharts-legend"><i class="fa fa-user-o"></i></div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="job-icon d-flex justify-content-between" style="position: relative;">
                            <div>
                                <div class="d-flex align-items-center mb-1">
                                    <h2 class="mb-0">
                                        <a href="#" id="lbl_GPV_TPV_AMT" runat="server" onclick="return GetDashboardUrl('TPVRPV')" class="text-primary">0</a>
                                    </h2>
                                </div>
                                <span class="fs-18 d-block mb-2">Total Sales</span>
                            </div>
                            <div class="apexcharts-legend"><i class="fa fa-users"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 d-none">
            <div class="card">
                <div class="row  separate-row">
                    <div class="col-sm-6 d-none">
                        <div class="job-icon d-flex justify-content-between" style="position: relative;">
                            <div>
                                <div class="d-flex align-items-center mb-1">
                                    <h2 class="mb-0">
                                        <a href="#" id="lbl_GPV_TPV" runat="server" onclick="return GetDashboardUrl('TPVRPV')" class="text-primary">0</a></h2>
                                    <span id="lbl_GPV_TPV_CNT" runat="server" onclick="return GetDashboardUrl('TPVRPV')" class="badge sticker text-white bg-primary" style="cursor: pointer; display: none;">0</span>
                                </div>
                                <span class="fs-18 d-block mb-2">GPV + PV</span>
                            </div>
                            <div class="apexcharts-legend"><i class="fa fa-user-o"></i></div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="job-icon d-flex justify-content-between" style="position: relative;">
                            <div>
                                <div class="d-flex align-items-center mb-1">
                                    <h2 class="mb-0">
                                        <a href="#" id="lbl_Loyalty_AMT" runat="server" onclick="return GetDashboardUrl('LOYALTYINV')" class="text-primary">0</a>
                                    </h2>
                                </div>
                                <span class="fs-18 d-block mb-2"><%=method.Invoice_Amount%></span>
                            </div>
                            <div class="apexcharts-legend"><i class="fa fa-users"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Primary Sales</h4>
    </div>
    <div class="row">
        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card">
                <div class="card-body p-3 pb-0">
                    <div class="media">
                        <div class="media-body">
                            <h3 class="mb-0 text-left">Online Sales</h3>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 d-none">
                    <div class="media border-bottom">
                        <div class="media-body ">
                            <p class="mb-0 text-left"></p>
                            <h2 class="text-orange text-left">
                                <a href="#" id="lbl_Online_Sales" runat="server" onclick="return GetDashboardUrl('ONLINE_INVSALES')" class="text-primary">0</a>
                            </h2>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left"><%=method.Invoice_Amount%></p>
                            <h2 class="text-orange text-left">
                                <a href="#" id="lbl_Online_Sales_AMT" onclick="return GetDashboardUrl('ONLINE_INVSALES')" runat="server" class="text-primary">0</a>
                            </h2>
                        </div>
                    </div>
                </div>
                <span id="lbl_Online_Sales_CNT" runat="server" onclick="return GetDashboardUrl('ONLINE_INVSALES')" class="badge sticker text-white bg-primary d-none" style="cursor: pointer;">0</span>
            </div>
        </div>
        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card">
                <div class="card-body p-3 pb-0">
                    <div class="media">
                        <div class="media-body">
                            <h3 class="mb-0 text-left">Offline Sales</h3>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 d-none">
                    <div class="media border-bottom" style="border-bottom: 1px solid #393939 !important;">
                        <div class="media-body">
                            <p class="mb-0 text-left"></p>
                            <h1 class="text-left">
                                <a href="#" id="lbl_Off_Sales" runat="server" onclick="return GetDashboardUrl('OFFLINE_INVSALES')" class="text-primary">0</a>
                            </h1>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body ">
                            <p class="mb-1 text-left"><%=method.Invoice_Amount%></p>
                            <h2 class="text-left">
                                <a href="#" id="lbl_Off_Sales_AMT" runat="server" onclick="return GetDashboardUrl('OFFLINE_INVSALES')" class="text-primary">0</a>
                            </h2>
                        </div>
                    </div>
                </div>
                <span id="lbl_Off_Sales_CNT" runat="server" onclick="return GetDashboardUrl('OFFLINE_INVSALES')" class="badge sticker text-white bg-primary d-none" style="cursor: pointer">0</span>
            </div>
        </div>
        <%-- <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card">
                <div class="card-body p-3 pb-0">
                    <div class="media">
                        <div class="media-body">
                            <h3 class="mb-0 text-left">Franchise Sales</h3>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0 d-none">
                    <div class="media border-bottom">
                        <div class="media-body text-white">
                            <p class="mb-0 text-left"></p>
                            <h2 class="text-orange text-left">
                                <a href="#" id="lbl_Comp_Fran_Sales" runat="server" onclick="return GetDashboardUrl('FRAN_SALES')" class="text-white">0</a>
                            </h2>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left">Invoice Amount </p>
                            <h2 class="text-left">
                                <a href="#" id="lbl_Comp_Fran_AMT" runat="server" onclick="return GetDashboardUrl('FRAN_SALES')" class="text-primary">0</a>
                            </h2>
                        </div>
                    </div>
                </div>
                <span id="lbl_Comp_Fran_CNT" runat="server" onclick="return GetDashboardUrl('FRAN_SALES')" class="badge sticker text-white bg-primary d-none" style="cursor: pointer">0</span>
            </div>
        </div>--%>
        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card">
                <div class="card-body  p-3 pb-0">
                    <div class="media">
                        <div class="media-body">
                            <h3 class="mb-0 text-left">Total Sales </h3>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 d-none">
                    <div class="media border-bottom" style="border-bottom: 1px solid #393939 !important;">
                        <div class="media-body">
                            <p class="mb-0 text-left"></p>
                            <h3 class="text-orange text-left">
                                <a href="#" id="lbl_Total_Sales" runat="server" onclick="return GetDashboardUrl('PRIMARYSALES')" class="text-orange">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left"><%=method.Invoice_Amount%></p>
                            <h2 class="text-left">
                                <a href="#" id="lbl_Total_Sales_AMT" runat="server" onclick="return GetDashboardUrl('PRIMARYSALES')" class="text-primary">0</a>
                            </h2>
                        </div>
                    </div>
                </div>
                <span id="lbl_Total_Sales_CNT" runat="server" onclick="return GetDashboardUrl('PRIMARYSALES')" class="badge sticker text-white bg-primary d-none" style="cursor: pointer">0</span>
            </div>
        </div>
    </div>
    <div class="card-action coin-tabs1">
        <ul class="nav nav-tabs" role="tablist" id="myTab">
            <li class="nav-item active">
                <a class="nav-link active" data-bs-toggle="tab" href="#primary_sale_chart" role="tab" aria-selected="true">Primary Sale</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#member_details_chart" role="tab" aria-selected="false">Member Details</a>
            </li>
             
            
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#Product_wise_sale_chart" onclick="Details_Pie_Chart_ProductWise()" role="tab" aria-selected="false">Product Wise</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#Category_wise_sale_chart" onclick="Pie_Chart_CateWise()" role="tab" aria-selected="false">Category Wise</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#State_wise_sale_chart" onclick="Details_state_horizontal()" role="tab" aria-selected="false">State Wise</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#Franchise_wise_sale_chart" onclick="Details_Fran_horizontal()" role="tab" aria-selected="false">Franchise Wise</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#ComparisonChart" onclick="PopulateDashboard_Comparison()" role="tab" aria-selected="false">Month Wise</a>
            </li>
             
        </ul>
    </div>
    <div class="card-body p-0 pt-1">
        <div class="tab-content">
            <div class="tab-pane fade in active show" id="primary_sale_chart">
                <!--#include virtual="PrimaryChart.aspx"-->
            </div>
            <div class="tab-pane fade" id="member_details_chart">
                <!--#include virtual="Chart_bar_line.aspx"-->
            </div>
             
            <div class="tab-pane fade" id="Product_wise_sale_chart">
                <!--#include virtual="Chart_pie_prod_sale.aspx"-->
            </div>

            <div class="tab-pane fade" id="Category_wise_sale_chart">
                <!--#include virtual="Chart_pie_cate_sale.aspx"-->
            </div>

            <div class="tab-pane fade" id="State_wise_sale_chart">
                <!--#include virtual="Chart_bar_horizontal_state.aspx"-->
            </div>

            <div class="tab-pane fade" id="Franchise_wise_sale_chart">
                <!--#include virtual="Chart_bar_horizontal_Franchise.aspx"-->
            </div>

            <div class="tab-pane fade" id="ComparisonChart">
                <!--#include virtual="Chart_bar_comparison.aspx"-->
            </div>
            
        </div>
    </div>
    <div class="row d-none">
        <div class="col-md-6">
            <div class="table-responsive">
                <table class="table table-striped table-hover primary-table-bordered ">
                    <thead>
                        <tr>
                            <td colspan="4" align="center" style="font-weight: bold;">Secondary Sales</td>
                        </tr>

                    </thead>
                    <tbody>
                        <tr>
                            <td style="font-weight: bold;">State</td>
                            <td style="font-weight: bold;">Perivous  Month</td>
                            <td style="font-weight: bold;">Current Month</td>
                            <td style="font-weight: bold;">Growth</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-6">
            <div class="table-responsive">
                <table class="table table-striped table-hover primary-table-bordered ">
                    <thead>
                        <tr>
                            <td colspan="4" align="center" style="font-weight: bold;">Primary Sales</td>
                        </tr>

                    </thead>
                    <tbody>
                        <tr>
                            <td style="font-weight: bold;">State</td>
                            <td style="font-weight: bold;">Perivous  Month</td>
                            <td style="font-weight: bold;">Current Month</td>
                            <td style="font-weight: bold;">Growth</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <style>
        .coin-tabs1 .nav-tabs .nav-item .nav-link {
            border: 0;
            border-radius: 0rem;
            font-size: 1rem;
            padding: 0.5rem 1rem;
            /* border-top-left-radius: 0.75rem; */
            /* border-top-right-radius: 0.75rem; */
            border: 1px solid #000;
            margin-right: 5px;
            border-radius: 0.25em;
        }

            .coin-tabs1 .nav-tabs .nav-item .nav-link.active {
                background: var(--primary);
                color: #fff;
            }

        .sticker {
            position: absolute;
            width: 60px;
            background: #fe6a00;
            border-radius: 0.5rem;
            right: -5px;
            font-size: 1.05em;
            top: -15px;
            font-weight: 600;
        }

        .widget-stat .media .media-body p {
            text-transform: capitalize;
            font-weight: 500;
            font-size: 1.2rem;
            line-height: 1.8;
        }

        .media-body h3 {
            color: #6e6e6e;
        }
    </style>


    <%-- <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
   
      

        function GetDashboardUrl(flag) {
            var From = $('#<%=txtFromDate.ClientID%>').val(),
                To = $('#<%=txtToDate.ClientID%>').val();

            if (flag == "RPV") {
                window.location = "DashboardDetails.aspx?Key=RPV&From=" + From + "&To=" + To;
            }
            else if (flag == "TPV") {
                window.location = "DashboardDetails.aspx?Key=TPV&From=" + From + "&To=" + To;
            }
            else if (flag == "TPVRPV") {
                window.location = "DashboardDetails.aspx?Key=TPVRPV&From=" + From + "&To=" + To;
            }
            else if (flag == "INVSALES") {
                window.location = "DashboardDetailStateWise.aspx?Key=INVSALES&From=" + From + "&To=" + To;
            }
            else if (flag == "PRIMARYSALES") {
                window.location = "PrimarySale.aspx?Key=PRIMARYSALES&From=" + From + "&To=" + To;
            }
            else if (flag == "ONLINESALES") {
                window.location = "AssociatePackageBill.aspx?Key=ONLINESALES&From=" + From + "&To=" + To;
            }
            else if (flag == "TOTALFWALLET") {
                window.location = "FranWalReq.aspx?Key=TOTALFWALLET&From=" + From + "&To=" + To;
            }
            else if (flag == "TOTALCWALLET") {
                window.location = "UserWalletRequest.aspx?Key=TOTALCWALLET&From=" + From + "&To=" + To;
            }
            else if (flag == "PENDING_F_WALLET") {
                window.location = "FranWalReq.aspx?Key=PENDINGFWALLET&From=" + From + "&To=" + To;
            }
            else if (flag == "PENDING_C_WALLET") {
                window.location = "UserWalletRequest.aspx?Key=PENDINGCWALLET&From=" + From + "&To=" + To;
            }
            else if (flag == "PENDING_PO") {
                window.location = "POList.aspx?Key=PENDING_PO&From=" + From + "&To=" + To;
            }
            else if (flag == "PENDING_DISPATCH") {
                window.location = "AssociatePackageBill.aspx?Key=PENDING_DISPATCH&From=" + From + "&To=" + To;
            }
        }


    </script>
    
  
    <!--#include virtual="dashboard-include.aspx"-->
    <hr />
<div id="div_Directors" runat="server" visible="false" class="row">
            <div class="clearfix"></div>
            <br />
            <div class="col-md-4">
                <h3 style="margin-top: 0px;">Directors Dashboard</h3>
            </div>
            <div class="col-md-3"> 
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CssClass="btn btn-primary" />

            </div>
            <div class="clearfix"></div>
            <br />

    <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
<div class="widget-stat card bg-blue">
<div class="card-body  p-3">
<div class="media">
<div class="media-body text-white">
<p class="mb-0 text-left">Total <span id="lbl_RPVText" runat="server"></span></p>
<h3 class="text-orange text-end">
<a style="cursor: pointer;" onclick="return GetDashboardUrl('RPV')" id="lbl_RPV" runat="server">0</a>

</h3>
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
<p class="mb-0 text-dark">Total <span id="lbl_TPVText" runat="server"></span></p>
<h3 class="text-orange text-end">
<a style="cursor: pointer;" onclick="return GetDashboardUrl('TPV')" id="lbl_TPV" runat="server">0</a>
</h3>
</div>
</div>
</div>
</div>
</div>
  
    <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
<div class="widget-stat card bg-blue">
<div class="card-body p-3">
<div class="media">
<div class="media-body text-white">
<p class="mb-0 text-left"> Total <span id="lbl_TPVRPVText" runat="server"></span></p>
<h3 class="text-orange text-end">
   <a style="cursor: pointer;" onclick="return GetDashboardUrl('TPVRPV')" id="lbl_RPV_TPV" runat="server">0</a>
</h3>
</div>
</div>
</div>
</div>
</div>
           
<div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
<div class="widget-stat card bg-grey">
<div class="card-body p-3">
<div class="media">
<div class="media-body text-white">
<p class="mb-0 text-dark">Total Invoice Sales</p>
<h3 class="text-orange text-end">
<a style="cursor: pointer;" onclick="return GetDashboardUrl('INVSALES')" id="lbl_InvoiceSales" runat="server">0</a>

</h3>
</div>
</div>
</div>
</div>
</div>

<div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
<div class="widget-stat card bg-blue">
<div class="card-body p-3">
<div class="media">
<div class="media-body text-white">
<p class="mb-0 ">Total Primary Sales</p>
<h3 class="text-orange text-end">
<a style="cursor: pointer;" onclick="return GetDashboardUrl('PRIMARYSALES')" id="lbl_PrimarySales" runat="server">0</a>

</h3>
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
<p class="mb-0 text-dark">Total Sales Collection</p>
<h3 class="text-orange text-end">
<a id="lbl_TotalCollection" runat="server">0</a></h3>
 </div>
</div>
</div>
</div>
</div>         
        
    <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
<div class="widget-stat card bg-blue">
<div class="card-body p-3">
<div class="media">
<div class="media-body text-white">
<p class="mb-0 text-left"> Total C-Wallet</p>
<h3 class="text-orange text-end">
    <a style="cursor: pointer;" onclick="return GetDashboardUrl('TOTALCWALLET')"  id="lbl_CWalletApprove" runat="server">0</a>
</h3>
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
<p class="mb-0 text-dark">Total F-Wallet</p>
<h3 class="text-orange text-end"><a style="cursor: pointer;" onclick="return GetDashboardUrl('TOTALFWALLET')"  id="lbl_FWalletApprove" runat="server">0</a>
</h3>
</div>
</div>
</div>
</div>
</div>
            
    
     <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
<div class="widget-stat card bg-blue">
<div class="card-body p-3">
<div class="media">
<div class="media-body text-white">
<p class="mb-0 text-left">Online Sales</p>
<h3 class="text-orange text-end">
<a style="cursor: pointer;" onclick="return GetDashboardUrl('ONLINESALES')" id="lbl_TotalOnlineSales" runat="server">0</a>
</h3>
</div>
</div>
</div>
</div>
</div>
          
        </div>--%>
    <style>
        .container-fluid {
            background: #F8F8F8 !important;
        }
    </style>
</asp:Content>

