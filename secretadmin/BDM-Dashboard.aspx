<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="BDM-Dashboard.aspx.cs" Inherits="secretadmin_BDM_Dashboard" %>

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
                window.location = "BDMDashboardDetails.aspx?Key=RPV&From=" + From + "&To=" + To;
            }
            else if (flag == "TPV") {
                window.location = "BDMDashboardDetails.aspx?Key=TPV&From=" + From + "&To=" + To;
            }
            else if (flag == "TPVRPV") {
                window.location = "BDMDashboardDetails.aspx?Key=TPVRPV&From=" + From + "&To=" + To;
            }
            else if (flag == "INVSALES") {
                window.location = "BDMDashboardDetailStateWise.aspx?Key=INVSALES&From=" + From + "&To=" + To;
            }
            else if (flag == "PRIMARYSALES") {
                window.location = "BDMDashboardDetailStateWise.aspx?Key=PRIMARYSALES&From=" + From + "&To=" + To;
            }
            else if (flag == "ONLINESALES") {
                window.location = "AssociatePackageBill.aspx?Key=ONLINESALES&From=" + From + "&To=" + To;
            }

        }


    </script>

    <%-- <div class="container-fluid page__container">
        <!--#include virtual="dashboard-include.aspx"-->
        <div  class="row panel card card-body ">--%>
    <div class="clearfix"></div>
    <br />
    <div class="card">
    <div class="row">
        <div class="col-md-4">
            <h3 style="margin-top: 0px;">BDM Dashboard</h3>
        </div>
        <div class="col-md-3">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CssClass="btn btn-success" />

        </div>
    </div>
        </div>
    <div class="clearfix"></div>
    <br />
    <div class="row">
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body  p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0 text-left">Total <span id="lbl_RPVText" runat="server"></span></p>
                            <h3 class=" text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('RPV')" id="lbl_RPV" class="text-primary" runat="server">0</a></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0 text-dark">Total <span id="lbl_TPVText" runat="server"></span></p>
                            <h3 class="text-primary text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('TPV')" id="lbl_TPV" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0 text-left">Total <span id="lbl_TPVRPVText" runat="server"></span></p>
                            <h3 class="text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('TPVRPV')" id="lbl_RPV_TPV" class="text-primary " runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0">Total Invoice Sales</p>
                            <h3 class="text-primary text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('INVSALES')" id="lbl_InvoiceSales" runat="server">0</a>

                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0 ">Total Primary Sales</p>
                            <h3 class=" text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('PRIMARYSALES')" id="lbl_PrimarySales" runat="server" class="text-primary">0</a>

                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>


    <style>
        .container-fluid {
        background: #F8F8F8!important;
        }
        .small-box {
            border-radius: 10px;
            position: relative;
            display: block;
            box-shadow: 0px 0px 25px 0px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }

            .small-box > .inner {
                padding: 20px;
            }

            .small-box h3 a {
                color: #fff;
            }

            .small-box h3 {
                font-size: 24px;
                font-weight: normal;
                margin: 0 0 10px 0;
                white-space: nowrap;
                padding: 0;
                color: white;
            }

            .small-box p {
                font-size: 16px;
                color: white;
            }

            .small-box .icon {
                position: absolute;
                top: 20px;
                right: 20px;
                z-index: 0;
                font-size: 40px;
                color: rgba(0,0,0,0.15);
                transition: all .3s linear;
                -webkit-transition: all .3s linear;
                -moz-transition: all .3s linear;
                -o-transition: all .3s linear;
            }

        .bg-blue {
            background-color: #0d47a1 !important;
        }
    </style>
</asp:Content>

