<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="billing.aspx.cs" Inherits="franchise_billing" %>

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
            Billing
        </div>
    </div>
    <br />
    <ul class="dashboard_menu">
        <li><a href="BarcodeBilling.aspx" class="d1"><span>Generate Invoice</span></a> </li>
        <li><a href="AssociateInvoiceList.aspx" class="d1"><span>Ez Partner Invoice</span></a></li>
        <li><a href="StockTranList.aspx" class="d1"><span>Franchise Invoice</span></a></li>
         <li id="id_Menu_SalesReturn_Asso" runat="server"><a href="returnitem.aspx" class="d1"><span>Associate Return Product</span></a></li>

        <li id="id_Menu_SalesReturn" runat="server" visible="false"><a href="ReturnProduct.aspx" class="d1"><span>Franchise Return Product</span></a></li>
       


        <li><a href="ReturnSalesList.aspx" class="d1"><span>Sales Return Made</span></a></li>
        <li><a href="SalesReturnReceived.aspx" class="d1"><span>Sales Return List</span></a></li>
        <li><a href="POList.aspx" class="d1"><span>Purchase Order Made</span></a></li>
        <li><a href="PO-Received.aspx" class="d1"><span>Purchase Order Receipt</span></a></li>

    </ul>
</asp:Content>
