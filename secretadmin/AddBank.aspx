<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="AddBank.aspx.cs" Inherits="secretadmin_AddBank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <br />
    <div class="col-sm-12">
    <h1>Add Bank</h1>  
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <div class="col-md-2 col-sm-3">
            <asp:Label ID="lblBankName" runat="server" Text="Bank Name" Style="color: #000;"></asp:Label>
        </div>
        <div class="col-md-3 col-sm-6">
            <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <div class="col-md-2">
        </div>
        <div class="col-md-3">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" Style="background-color: #1D964B"
                CssClass="btn btn-success" OnClick="btnSubmit_Click" />
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
</asp:Content>
