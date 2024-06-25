<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="wallet.aspx.cs" Inherits="franchise_wallet" %>

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
       


        <li><a href="UWallet.aspx" class="d1"><span>Passbook</span></a></li>
        <li><a href="UWalletRequest.aspx" class="d1"><span>Wallet Request</span></a></li>
        <li style="display: none;"><a href="OD_Wallet.aspx" class="d1"><span>OD Passbook</span></a></li>
    </ul>

</asp:Content>

