<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="wallet.aspx.cs" Inherits="user_wallet" %>

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
            Wallet
        </div>
    </div>

    <br />
    <ul class="dashboard_menu">
        <li><a href="walletrequest.aspx" class="d1"><span>Wallet Request</span></a> </li>
        <li><a href="approvewalletlist.aspx" class="d1"><span>Approved Request</span></a></li>
        <li><a href="TransferWallet.aspx" class="d1"><span>Transfer Wallet Payout to Company </span></a></li>
        <li><a href="dwallet.aspx" class="d1"><span>Company Wallet Passbook</span></a></li>
        <li><a href="pwallet.aspx" class="d1"><span>Payout Wallet Passbook</span></a></li>
        <%--<li><a href="LoyaltyWallet.aspx" class="d1"><span>Loyalty Wallet Passbook</span></a></li>
        <li><a href="WalletProduct.aspx" class="d1"><span>Product Wallet Passbook</span></a></li>--%>


    </ul>
</asp:Content>


