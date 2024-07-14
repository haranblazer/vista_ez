<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="my_shopping.aspx.cs" Inherits="user_my_shopping" %>

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
            My Shopping
        </div>
    </div>

    <br />
    <ul class="dashboard_menu">
        <li><a href="../products" class="d1"><span>Shop Now</span></a></li>
       <%-- <li><a href="BarcodeBilling.aspx" class="d1"><span>Create Order</span></a></li>--%>
        <li><a href="Invoicelist.aspx" class="d1"><span>Invoice List </span></a></li>
        <li><a href="MonthlyRoyalty.aspx" class="d1"><span>Monthly Loyalty Purchase</span> </a></li>
        <li><a href="LoyaltyCoupon.aspx" class="d1"><span>Lucky Draw Status</span></a></li>
        <li><a href="OrderList.aspx" class="d1"><span>Order List</span></a></li>
        <%--<li><a href="../product.aspx" class="d1"><span>Shop Now</span></a></li>--%>
    </ul>
</asp:Content>


