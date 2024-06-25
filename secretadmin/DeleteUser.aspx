<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="DeleteUser.aspx.cs" Inherits="admin_DeleteUser" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table align="center" border="1" bordercolor="black" cellpadding="1" cellspacing="1"
        style="width: 84%; height: 140px">

        <tr>
            <td style="height: 27px; text-align: center;" colspan="2" align="center">
                <strong style="font-weight: bold; font-size: 14pt">Delete User</strong></td>
        </tr>
        <tr>
            <td style="width: 341px; height: 31px; text-align: center;">
               <strong> Enter User Id</strong></td>
            <td style="height: 31px; text-align: center;">
                &nbsp;
                <asp:TextBox ID="TextBox1" runat="server" Height="20px" Width="135px" OnTextChanged="TextBox1_TextChanged"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="center" colspan="2" style="height: 25px; text-align: center;">
                &nbsp;<asp:Label ID="Label1" runat="server" Text="Label" Width="92px"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="2" style="height: 28px; text-align: center;" align="center">
                <asp:Button ID="Button1" runat="server" Text="Submit" Width="91px" OnClick="Button1_Click" /></td>
        </tr>
    </table>
</asp:Content>

