<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="dispatch.aspx.cs" Inherits="franchise_dispatch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .container-fluid {
            padding-top: 0;
            padding-right: 0rem !important;
            padding-left: 0rem !important;
        }
    </style>
    <%--        <li><a href="AssociateInvoiceList.aspx" class="d1"><span>Invoice List</span></a> </li>--%>
    <div class="top-bar">
        <div class="page-title">
            Dispatch
        </div>
    </div>
    <br />
    <ul class="dashboard_menu">
       <%-- <li><a href="AssociateInvoiceList.aspx" class="d1"><span>Invoice List</span></a></li>--%>

        <li><a href="Add_Transporter.aspx"  class="d1"><span>Add Transporter</span></a></li>
        <li><a href="TransporterList.aspx" class="d1"><span>Transporter List</span></a></li>
    </ul>

</asp:Content>

