<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="my_business.aspx.cs" Inherits="user_my_business" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .container-fluid {
            padding-top: 0;
            padding-right: 0rem !important;
            padding-left: 0rem !important;
        }
    </style>
    <div class="top-bar">
        <div class="page-title">
            My Business
        </div>
    </div>

    <br />
    <ul class="dashboard_menu">
        <li><a href="direct.aspx" class="d1"><span>Genealogy</span></a></li>
        <li><a href="GroupSales.aspx" class="d1"><span>Generation Downline</span></a></li>
        <li><a href="GenLevelReport.aspx" class="d1"><span>Generation Level Report</span></a></li>
        <li><a href="MonthlyGenerationPoint.aspx" class="d1"><span>Business Information</span></a></li>
        <li><a href="LegWiseMonthlyReport.aspx" class="d1"><span>Legwise Monthly Reports</span></a></li>
        <li><a href="MonthlyPurchase.aspx" class="d1"><span>Monthly Purchase Value</span></a></li>
        <li><a href="FindSponsorRank.aspx" class="d1"><span>Team Group Sales</span></a></li>

        <li><a href="currentBusReport.aspx" class="d1"><span>Current Business Report</span></a></li>


    </ul>
</asp:Content>


