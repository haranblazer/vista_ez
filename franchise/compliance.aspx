<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="compliance.aspx.cs" Inherits="franchise_compliance" %>

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
            Compliance
        </div>
    </div>
    <br />
    <ul class="dashboard_menu">
        <li><a href="Franchise_GST_Turnover.aspx" class="d1"><span>GST Turnover Report</span></a></li>
        <li><a href="GSTReports.aspx" class="d1"><span>GST Report</span></a></li>
    </ul>

</asp:Content>

