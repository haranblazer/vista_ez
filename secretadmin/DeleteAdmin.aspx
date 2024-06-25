<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="DeleteAdmin.aspx.cs" Inherits="admin_DeleteAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Remove User</h4>
    </div>

    <div class="row">
        <div class="col-sm-2 control-label">
            Select User Name :
        </div>
        <div class="col-sm-3">
            <asp:DropDownList ID="ddlLogInId" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlLogInId_SelectedIndexChanged">
                <asp:ListItem Selected="True">Select</asp:ListItem>
            </asp:DropDownList>
        </div>



        <div class="col-sm-3">
            <asp:TextBox ID="txtName" runat="server" onkeypress="return CheckAlpha()" CssClass="form-control"
                Enabled="False" placeholder="Name"></asp:TextBox>
        </div>



        <div class="col-sm-3">
            <asp:TextBox ID="txtLogInId" runat="server" onkeypress="return CheckAlpha()" CssClass="form-control" Enabled="False" placeholder="Login id"></asp:TextBox>
        </div>

        <div class="col-sm-1 ">
            <asp:Button ID="Button3" runat="server" OnClick="Button1_Click" Text="Delete" CssClass="btn btn-primary" />
        </div>
    </div>

    <div class="clearfix"></div>
    <br />

    <table style="width: 100%;">


        <tr id="Tr1" runat="server" visible="false">
            <td style="width: 260px; text-align: right;" class="bottom_table">Password :</td>
            <td class="bottom_table">
                <asp:TextBox ID="txtPassword" runat="server" Width="148px" Enabled="False"></asp:TextBox>&nbsp;</td>
        </tr>
        <tr runat="server">
            <td class="alignr" style="width: 260px"></td>
            <td></td>
        </tr>
        <tr runat="server" visible="false">
            <td class="alignr" style="width: 260px"></td>
            <td>&nbsp;</td>
        </tr>
    </table>
    </div>
    <div class="clearfix"></div>
    </div>

</asp:Content>
