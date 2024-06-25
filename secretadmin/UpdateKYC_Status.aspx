<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="UpdateKYC_Status.aspx.cs" Inherits="secretadmin_UpdateKYC_Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Update KYC Image </h4>
    </div>

    <div class="form-group row">
        <div class="col-sm-2 control-label">
            Select
        </div>
        <div class="col-sm-3 control-label">
            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                <asp:ListItem Value="PAN">PAN</asp:ListItem>
                <asp:ListItem Value="BANK">BANK</asp:ListItem>
                <asp:ListItem Value="AADHAR">AADHAR</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-2 control-label">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure you want to proceed？')" />
        </div>
        <div class="col-sm-4 control-label">
            <asp:Label ID="lbl_Msg" runat="server"></asp:Label>
        </div>
        <br />
    </div>
    <br />
</asp:Content>

