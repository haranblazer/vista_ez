<%@ Page Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="adminSendMail.aspx.cs" Inherits="admin_adminSendMail" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <br />
    <br />
    <br />
<table align="center" cellpadding=0 cellspacing=0 width="500">
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px; text-align: center">
                <asp:Label ID="Label1" runat="server" ForeColor="Red" Width="255px"></asp:Label></td>
            <td style="width: 100px">
            </td>
        </tr>
    <tr>
        <td style="width: 100px">
            userId<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox4"
                ErrorMessage="not Empty">*</asp:RequiredFieldValidator></td>
        <td style="width: 100px">
            <asp:TextBox ID="TextBox4" runat="server" Width="276px"></asp:TextBox></td>
        <td style="width: 100px">
            </td>
    </tr>
        <tr>
            <td style="width: 100px">
                Name</td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox1" runat="server" Width="276px"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
                Subject</td>
            <td style="width: 100px; height: 25px">
                <asp:TextBox ID="TextBox2" runat="server" Width="276px"></asp:TextBox></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                Message</td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox3" runat="server" Height="94px" TextMode="MultiLine" Width="275px"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="text-align: center;" colspan="3">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Send" Width="67px" />
                <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" Height="20px" NavigateUrl="~/admin/admincheckmail.aspx"
                    Width="85px">InBox</asp:HyperLink></td>
        </tr>
    </table>

</asp:Content>

