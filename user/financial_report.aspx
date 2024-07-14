<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="financial_report.aspx.cs" Inherits="user_financial_report" %>

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
            Payout Report
        </div>
    </div>

    <br />
    <ul class="dashboard_menu">
        <%--<li><a href="UserRepurchaseList.aspx" class="d1"><span>First Purchase Payout</span></a></li>--%>
       
        <li><a href="PayoutWeekly.aspx" class="d1"><span>Weekly Payout</span></a></li>
         <li><a href="UserRepurchaseList2.aspx" class="d1"><span>Monthly Payout</span></a></li>
         <li><a href="Reward_New.aspx" class="d1"><span>Reward List</span></a></li>
        <%--<li><a href="BusinessInformation.aspx" class="d1"><span>Total Income Report</span></a></li>
        <li><a href="Asso_GST_Turnover.aspx" class="d1"><span>GST Turnover Report</span></a></li>--%>
    </ul>
</asp:Content>


