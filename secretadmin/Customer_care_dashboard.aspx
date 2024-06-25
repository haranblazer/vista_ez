<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="Customer_care_dashboard.aspx.cs" Inherits="secretadmin_Customer_care_dashboard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" />
    <script src="datepick/jquery.datepick.js"></script>
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>

    <div id="cont"></div>

    <!--#include virtual="dashboard-include.aspx"-->

    <hr />
    <div id="div_Customercare" runat="server" class="row">
        <div class="clearfix"></div>
        <br />
        <div class="col-xl-12">
            <div class="card">
                <div class="row">
                    <div class="col-md-4">
                        <h3 style="margin-top: 0px;">KYC Dashboard</h3>
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
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="col-xl-4 col-xxl-4 col-lg-4 col-sm-4">
            <div class="widget-stat card">
                <div class="card-body p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0 text-left">Pending Aadhar Approvals</p>
                            <h3 class=" text-end">
                                <a href="AddressApprovedByAdmin.aspx" id="div_PendingAadharApprovals" class="text-primary" runat="server">0</a></h3>
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
                            <p class="mb-0">Pending Pan Approvals</p>
                            <h3 class="text-primary text-end">
                                <a href="PANApprovedByAdmin.aspx" id="div_PendingPanApprovals" runat="server" class="text-primary">0</a>
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
                            <p class="mb-0 text-left">Pending Bank Approvals</p>
                            <h3 class="text-primary text-end">
                                <a href="BankApprovedByAdmin.aspx" id="div_PendingBankApprovals" runat="server" class="text-primary">0</a>
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
    </style>
</asp:Content>

