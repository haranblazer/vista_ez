<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="StartStop.aspx.cs" Inherits="admin_StartStop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .color {
            color: #fff;
        }
    </style>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Page Permission </h4>
    </div>




    <div class="form-group row">
        <div class="col-md-2 control-label">
            <asp:Label ID="lblSignup" runat="server" Text="Signup"></asp:Label>
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnSignupOn" runat="server" CssClass="color btn" OnClick="btnSignupOn_Click" />
        </div>
    </div>
    <div class="clearfix"></div>
    <br />

    <div class="form-group row">
        <div class="col-md-2 control-label">
            <asp:Label ID="lblLogin" runat="server" Text="Login"></asp:Label>
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnLoginOn" runat="server" CssClass="color btn" OnClick="btnLoginOn_Click" />
        </div>
    </div>
    <div class="clearfix"></div>
    <br />


    <div class="form-group row">
        <div class="col-md-2 control-label">
            <asp:Label ID="lblBilling" runat="server" Text="Billing"></asp:Label>
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnBillingOn" runat="server" CssClass="color btn" OnClick="btnBillingOn_Click" />
        </div>
    </div>

</asp:Content>
