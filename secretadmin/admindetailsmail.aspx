<%@ Page Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="admindetailsmail.aspx.cs" Inherits="admin_admindetailsmail" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 25%; height: 25px">
            </td>
            <td style="width: 15%; height: 25px">
            </td>
            <td style="width: 35%; height: 25px">
            </td>
            <td style="width: 25%; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                background-color: #2881A2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff;">Message View</span></strong></td>
            <td style="width: 25%; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%;">
            </td>
            <td style="border-left: #000000 1px solid; width: 15%; background-color: #EDF0FD;
                text-align: right">
                &nbsp;</td>
            <td style="border-right: #000000 1px solid; width: 35%; background-color: #EDF0FD">
                <asp:Label ID="Label1" runat="server" ForeColor="Red" Width="255px"></asp:Label></td>
            <td style="width: 25%;">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 15%; height: 35px; background-color: #EDF0FD;
                text-align: right">
                <strong>User ID No.&nbsp; :</strong></td>
            <td style="border-right: #000000 1px solid; width: 35%; height: 35px; background-color: #EDF0FD">
                &nbsp;
                <asp:TextBox ID="TextBox4" runat="server" Enabled="False" Width="226px"></asp:TextBox></td>
            <td style="width: 25%; height: 35px">
                &nbsp;
                </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 15%; height: 35px; background-color: #EDF0FD;
                text-align: right">
                <strong>Your
                Name&nbsp; :</strong></td>
            <td style="border-right: #000000 1px solid; width: 35%; height: 35px; background-color: #EDF0FD">
                &nbsp;
                <asp:TextBox ID="TextBox1" runat="server" Enabled="False" Width="226px"></asp:TextBox></td>
            <td style="width: 25%; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid;
                width: 15%; height: 35px; background-color: #EDF0FD;
                text-align: right; border-top-width: 1px; border-bottom-width: 1px; border-bottom-color: #000000; border-top-color: #000000; border-right-width: 1px; border-right-color: #000000;">
                <strong>
                Subject&nbsp; :</strong></td>
            <td style="border-right: #000000 1px solid; width: 35%; height: 35px; background-color: #EDF0FD">
                &nbsp;
                <asp:TextBox ID="TextBox2" runat="server" Enabled="False" Width="226px"></asp:TextBox></td>
            <td style="width: 25%; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 113px">
            </td>
            <td style="border-left: #000000 1px solid; width: 15%; height: 113px; background-color: #EDF0FD;
                text-align: right">
                <strong>
                Message&nbsp; :</strong></td>
            <td style="border-right: #000000 1px solid; width: 35%; height: 113px; background-color: #EDF0FD">
                &nbsp;
                <asp:TextBox ID="TextBox3" runat="server" Enabled="False" Height="94px" TextMode="MultiLine"
                    Width="226px"></asp:TextBox></td>
            <td style="width: 25%; height: 113px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 35px">
            </td>
            <td colspan="2" style="border-top: #000000 1px solid; height: 35px; text-align: center">
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Send" Visible="False" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" />
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Reply" Width="67px" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" />
                <asp:Button ID="Button3" runat="server" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px"
                    Font-Bold="True" ForeColor="White" PostBackUrl="~/admin/admincheckmail.aspx"
                    Text="Inbox" /></td>
            <td style="width: 25%; height: 35px">
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
</asp:Content>

