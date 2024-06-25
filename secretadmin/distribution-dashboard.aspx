<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" 
    CodeFile="distribution-dashboard.aspx.cs" Inherits="secretadmin_distribution_dashboard" %>

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
                window.location = "DashboardDetailStateWise.aspx?Key=PRIMARYSALES&From=" + From + "&To=" + To;
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

    <div id="div_Distribution" runat="server" class="row ">
        <div class="clearfix"></div>
        <br />
        <div class="col-xl-12">
        <div class="card">
            <div class="row">
        <div class="col-md-4">
            <h3 style="margin-top: 0px;">Order Dashboard</h3>
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
            </div></div></div>
        <div class="clearfix"></div>
        <br />
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body p-3">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-0 text-left">Offline Orders</p>
                            <h3 class="text-primary text-end">
                                 <a style="cursor: pointer;" onclick="return GetDashboardUrl('PO_OFFLINE')" id="div_PO_Offline" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
                 <div class="card-body p-3">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-0 text-left">Online Orders</p>
                            <h3 class="text-primary text-end">
                                 <a style="cursor: pointer;" onclick="return GetDashboardUrl('PO_ONLINE')" id="div_PO_Online" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>

                <div class="card-body p-3">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-0 text-left">Processed</p>
                            <h3 class="text-primary text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('PO_INV_DONE')" id="div_PO_INV_DONE" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
               <%-- <div class="card-body p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left">Pending PO</p>
                            <h3 class="text-primary text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('PENDING_PO')" id="div_PENDING_PO" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body p-3">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-0 text-left">Dispatched</p>
                            <h3 class="text-primary text-end">
                                 <a style="cursor: pointer;" onclick="return GetDashboardUrl('DISPATCH')" id="div_DISPATCH" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 pb-1">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-1 text-left">Pending</p>
                            <h3 class="text-primary text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('PENDING')" id="div_PENDING" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="card-body p-4 ">
                    <div class="media">
                        <div class="media-body text-white">
                            <p class="mb-0 text-left"></p>
                            <h3 class="text-primary text-end"></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <%--<div class="card-body p-3">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-0 text-left">Franchise Transit</p>
                            <h3 class="text-primary text-end">
                                 <a style="cursor: pointer;" onclick="return GetDashboardUrl('Fran_Transit')" id="div_Fran_Transit" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>--%>
                <div class="card-body p-3">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-0 text-left">Pod Upload</p>
                            <h3 class="text-primary text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('Pod_Upload')" id="div_Fran_pod_upload" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left">Delivered</p>
                            <h3 class="text-primary text-end">
                               <a style="cursor: pointer;" onclick="return GetDashboardUrl('Fran_Delivery')" id="div_Fran_Delivery" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
           <div class="clearfix"></div>
       <%-- <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body  p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0 text-left">Pending F-Wallet</p>
                            <h3 class="text-primary text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('PENDING_F_WALLET')" id="div_PendingFWalletRequest" runat="server">0</a></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body  p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0 text-dark">Pending Company-Wallet</p>
                            <h3 class="text-primary text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('PENDING_C_WALLET')" id="div_PendingCWalletRequest" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

       <%-- <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card bg-blue">
                <div class="card-body  p-3">
                    <div class="media">
                        <div class="media-body text-white">
                            <p class="mb-0 text-left">Pending POs received</p>
                            <h3 class="text-orange text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('PENDING_PO')" id="div_PendingPOsreceived" runat="server">0</a></h3>
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
                            <p class="mb-0 text-dark">Pending Dispatches</p>
                            <h3 class="text-orange text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('PENDING_DISPATCH')" id="div_PendingDispatches" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
       <%-- ===================================================== --%>
    </div>
    <style>
        .container-fluid {
        background: #F8F8F8!important;
        }
    </style>
</asp:Content>