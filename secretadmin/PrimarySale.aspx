<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="PrimarySale.aspx.cs"
    Inherits="secretadmin_PrimarySale" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function GetDashboardUrl(flag) {
            var From = $('#<%=txtFromDate.ClientID%>').val(),
                To = $('#<%=txtToDate.ClientID%>').val();

            if (flag == "INVWISE") {
                window.location = "PrimarySaleDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "DEPOWISE") {
                window.location = "PrimarySaleDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "BUYERWISE") {
                window.location = "PrimarySaleDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
        }
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-4 mt-4">Primary Sales Report</h4>
    <div id="div_Directors" runat="server" visible="false" class="row">
        <div class="col-md-2" style="display: none;">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>
        <div class="col-md-2" style="display: none;">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card bg-grey">
                <div class="card-body p-4">
                    <div class="media">
                        <div class="media-body text-white ">
                            <p class="mb-0 text-dark">Invoice Wise</p>
                            <h3 class="text-orange text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('INVWISE')" id="lbl_INVWISE" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card bg-blue">
                <div class="card-body p-4">
                    <div class="media">
                        <div class="media-body text-white">
                            <p class="mb-0 text-left">
                                Depot Wise
                            </p>
                            <h3 class="text-orange text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('DEPOWISE')" id="lbl_DEPOWISE" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card bg-grey">
                <div class="card-body p-4">
                    <div class="media">
                        <div class="media-body text-white ">
                            <p class="mb-0 text-dark">
                                Buyer Wise
                            </p>
                            <h3 class="text-orange text-end">
                                <a style="cursor: pointer;" onclick="return GetDashboardUrl('BUYERWISE')" id="lbl_BUYERWISE" runat="server">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- <div class="container-fluid page__container">
       
        <div id="div_Directors" runat="server" visible="false" class="row panel card card-body ">
            <div class="clearfix"></div>
            <br />
            <div class="col-md-4">
                <h2 style="margin-top: 0px;">Primary Sales Report</h2>
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" style="display:none;"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" style="display:none;"></asp:TextBox>
            </div>

            <div class="clearfix"></div>
            <br />

            <div class="col-lg-4">
                <div class="small-box bg-blue">
                    <div class="inner">
                        <h3><a style="cursor: pointer;" onclick="return GetDashboardUrl('INVWISE')" id="lbl_INVWISE" runat="server">0</a></h3>
                        <p>Invoice Wise </p>
                    </div>
                    <div class="icon">
                        <i class="fa fa-handshake-o"></i>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="small-box bg-blue">
                    <div class="inner">
                        <h3><a style="cursor: pointer;" onclick="return GetDashboardUrl('DEPOWISE')" id="lbl_DEPOWISE" runat="server">0</a></h3>
                        <p>Depo Wise </p>
                    </div>
                    <div class="icon">
                        <i class="fa fa-handshake-o"></i>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="small-box bg-blue">
                    <div class="inner">
                        <h3><a style="cursor: pointer;" onclick="return GetDashboardUrl('BUYERWISE')" id="lbl_BUYERWISE" runat="server">0</a></h3>
                        <p>Buyer Wise </p>
                    </div>
                    <div class="icon">
                        <i class="fa fa-handshake-o"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>--%>

    <%--<style>
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
    </style>--%>
    <style>
        .widget-stat .media .media-body p {
            
            font-size: 1.2rem;
        }
    </style>
</asp:Content>


