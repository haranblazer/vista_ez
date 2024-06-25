<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="reports.aspx.cs" Inherits="franchise_reports" %>

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
            Reports
        </div>
    </div>
    <br />
    <ul class="dashboard_menu">
<%--        <li><a href="AssociateInvoiceList.aspx" class="d1"><span>Invoice List</span></a> </li>--%>
      <%--  <li><a href="FranchisePurchaseList.aspx" class="d1"><span>Franchise Purchase List</span></a></li>
        <li><a href="StockTranList.aspx" class="d1"><span>Franchise Invoice List</span></a></li>--%>
        <li><a href="PerformanceReport.aspx" class="d1"><span>Performance Report</span></a></li>
        <li><a href="BatchList.aspx" class="d1"><span>Product Batch List</span></a></li>
        <li><a href="PriceList.aspx" class="d1"><span>Price List</span></a></li>
    </ul>

</asp:Content>

