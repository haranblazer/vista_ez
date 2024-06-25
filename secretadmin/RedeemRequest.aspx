<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="RedeemRequest.aspx.cs" Inherits="secretadmin_PayoutLeaderShipInc" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Send Redeem Request</h4>
    </div>



    <div class="clearfix">
        <asp:Label ID="lblLastPayoutDate" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="10pt"></asp:Label>
    </div>

    <asp:Button ID="Button3" runat="server" Text="Send All Redeem Request To Admin"
        OnClick="Button3_Click" CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure you want to proceed？')" />



</asp:Content>

