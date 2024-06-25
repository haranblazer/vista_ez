<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="welcome.aspx.cs" Inherits="mumbaiadmin_welcome" Title="Admin Control Panel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%--<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>--%>
    <%--<div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Secondary Sales</h4>
    </div>

    <div class="row">
        <div class="clearfix"></div>
        <br /> 
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
    </div>
    <hr />--%>


    <%--  <div class="row">

        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card bg-blue">
                <div class="card-body  p-3 pb-0">
                    <div class="media ">
                        <div class="media-body text-white">
                            <h2 class="mb-0 text-left text-white">GPV</h2>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0">
                    <div class="media border-bottom">
                        <div class="media-body text-white">
                            <p class="mb-0 text-left"></p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_GPV" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body text-white">
                            <p class="mb-1 text-left">Invoice  Amount </p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_GPV_AMT" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>
                <span id="lbl_GPV_CNT" runat="server" class="badge sticker text-white bg-primary">0</span>
            </div>
        </div>

        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card bg-grey">
                <div class="card-body  p-3 pb-0">
                    <div class="media ">
                        <div class="media-body ">
                            <h2 class="mb-0 text-left ">TPV</h2>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0">
                    <div class="media border-bottom" style="border-bottom: 1px solid #393939 !important;">
                        <div class="media-body ">
                            <p class="mb-0 text-left"></p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_TPV" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body ">
                            <p class="mb-1 text-left">Invoice  Amount </p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_TPV_AMT" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>
                <span id="lbl_TPV_CNT" runat="server" class="badge sticker text-white bg-primary">0</span>
            </div>
        </div>
        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card bg-blue">
                <div class="card-body  p-3 pb-0">
                    <div class="media ">
                        <div class="media-body text-white">
                            <h2 class="mb-0 text-left text-white">Loyalty Invoice</h2>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0">
                    <div class="media border-bottom">
                        <div class="media-body text-white">
                            <p class="mb-0 text-left"></p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_Loyalty" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body text-white">
                            <p class="mb-1 text-left">Invoice  Amount </p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_Loyalty_AMT" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>
                <span id="lbl_Loyalty_CNT" runat="server" class="badge sticker text-white bg-primary">0</span>
            </div>
        </div>
        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card bg-grey">
                <div class="card-body  p-3 pb-0">
                    <div class="media ">
                        <div class="media-body ">
                            <h2 class="mb-0 text-left ">GPV + TPV</h2>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0">
                    <div class="media border-bottom" style="border-bottom: 1px solid #393939 !important;">
                        <div class="media-body ">
                            <p class="mb-0 text-left"></p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_GPV_TPV" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body ">
                            <p class="mb-1 text-left">Invoice  Amount </p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_GPV_TPV_AMT" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>
                <span id="lbl_GPV_TPV_CNT" runat="server" class="badge sticker text-white bg-primary">0</span>
            </div>
        </div>
    </div>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Primary Summary</h4>
    </div>
    <div class="row">
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card bg-blue">
                <div class="card-body  p-3 pb-0">
                    <div class="media ">
                        <div class="media-body text-white">
                            <h2 class="mb-0 text-left text-white">Online Sales</h2>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0">
                    <div class="media border-bottom">
                        <div class="media-body text-white">
                            <p class="mb-0 text-left"></p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_Online_Sales" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body text-white">
                            <p class="mb-1 text-left">Invoice  Amount </p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_Online_Sales_AMT" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>
                <span id="lbl_Online_Sales_CNT" runat="server" class="badge sticker text-white bg-primary">0</span>
            </div>
        </div>

        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card bg-grey">
                <div class="card-body  p-3 pb-0">
                    <div class="media ">
                        <div class="media-body ">
                            <h2 class="mb-0 text-left ">Offline Sales</h2>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0">
                    <div class="media border-bottom" style="border-bottom: 1px solid #393939 !important;">
                        <div class="media-body ">
                            <p class="mb-0 text-left"></p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_Off_Sales" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body ">
                            <p class="mb-1 text-left">Invoice  Amount </p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_Off_Sales_AMT" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>
                <span id="lbl_Off_Sales_CNT" runat="server" class="badge sticker text-white bg-primary">0</span>
            </div>
        </div>

        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card bg-blue">
                <div class="card-body  p-3 pb-0">
                    <div class="media ">
                        <div class="media-body text-white">
                            <h2 class="mb-0 text-left text-white">Total Sales </h2>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0">
                    <div class="media border-bottom">
                        <div class="media-body text-white">
                            <p class="mb-0 text-left"></p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_Total_Sales" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body text-white">
                            <p class="mb-1 text-left">Invoice  Amount </p>
                            <h1 class="text-orange text-left">
                                <a href="#" id="lbl_Total_Sales_AMT" runat="server" class="text-orange">0</a>
                            </h1>
                        </div>
                    </div>
                </div>
                <span id="lbl_Total_Sales_CNT" runat="server" class="badge sticker text-white bg-primary">0</span>
            </div>
        </div>



    </div>
    <style>
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

        .media-body h2 {
            color: #393939
        }
    </style>--%>
</asp:Content>
