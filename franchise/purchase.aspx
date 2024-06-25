<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="purchase.aspx.cs" Inherits="franchise_purchase" %>

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
            Purchase
        </div>
    </div>
    <br />
    <ul class="dashboard_menu">
       <%-- <li><a href="AddVendor.aspx" class="d1"><span>Add Vendor</span></a></li>--%>
        <li><a href="Vendorlist.aspx" class="d1"><span>Vendor List</span></a></li>
        <li><a href="Purchase-order.aspx" class="d1"><span>Create Purchase Order</span></a></li>
        <li><a href="Purchase-order-List.aspx" class="d1"><span>Purchase Order List</span></a></li>

        <li><a href="Recieved_PO_List.aspx" class="d1"><span>Purchase Invoice List</span></a></li>

         <li><a href="vendor_return_stock.aspx" class="d1"><span>Vendor Return Stock </span></a></li>

        <li><a href="AddEditQuantity.aspx" class="d1"><span>Add Batch</span></a></li>
        <li id="li_PackedUnpacked" runat="server" visible="false" class="d1"><a href="AddPacked.aspx"><span>Packed/ Unpacked</span></a></li>
        <li><a href="ProductwisePendingPO.aspx" class="d1"><span>Product Wise Pending Order</span></a></li>
    </ul>

</asp:Content>

