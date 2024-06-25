<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AddUser.aspx.cs" Inherits="admin_AddUser" Title="Add Admin User : Admin Control" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 200px; height: 25px">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" />
            </td>
            <td style="width: 200px; height: 25px">
            </td>
            <td style="width: 200px; height: 25px">
            </td>
            <td style="width: 200px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 200px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                background-color: #2881A2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Add New Admin User</span></strong></td>
            <td style="width: 200px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 200px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 200px; height: 35px; background-color: #EDF0FD;
                text-align: right">
                <strong>
                Username&nbsp; :</strong>&nbsp;
            </td>
            <td style="border-right: #000000 1px solid; width: 200px; height: 35px; background-color: #EDF0FD">
                <asp:TextBox ID="TextBox1" runat="server" Width="128px"></asp:TextBox>&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                    ErrorMessage="UserName Not Empty" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
            <td style="width: 200px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 200px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 200px; height: 35px; background-color: #EDF0FD;
                text-align: right; border-bottom: #000000 1px solid;">
                <strong>Password&nbsp; :</strong>&nbsp;
            </td>
            <td style="border-right: #000000 1px solid; width: 200px; height: 35px; background-color: #EDF0FD; border-bottom: #000000 1px solid;">
                <asp:TextBox ID="TextBox2" runat="server" Width="127px"></asp:TextBox>&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                    ErrorMessage="Password Not Empty" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
            <td style="width: 200px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 200px; height: 25px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 25px;
                text-align: center">
                <asp:Label ID="Label1" runat="server" ForeColor="Red" Width="132px" style="text-align: center"></asp:Label></td>
            <td style="width: 200px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 200px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 35px;
                text-align: center">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add New User" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 200px; height: 35px">
            </td>
        </tr>
    </table>
    <br />


</asp:Content>

