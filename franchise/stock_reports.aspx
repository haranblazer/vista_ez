<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="stock_reports.aspx.cs" Inherits="franchise_stock_reports" %>

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
            Stock Reports
        </div>
    </div>
    <br />
    <ul class="dashboard_menu">
        
       <li><a href="StockSummaryReport.aspx" class="d1"><span>Stock Summary Report</span></a></li>
        <li><a href="ClosingStock.aspx" class="d1"><span>Closing Stock Report</span></a></li>

         <li><a href="BatchList.aspx" class="d1"><span>Product Batch List</span></a></li>
        <li><a href="PriceList.aspx" class="d1"><span>Price List</span></a></li>

    </ul>

</asp:Content>

