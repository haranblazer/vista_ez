<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="calculateGrowthPayout.aspx.cs" Inherits="admin_calculateGrowthPayout2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <table align="center" border="1" bordercolor="black" cellpadding="1" cellspacing="1"
        style="width: 84%; height: 211px">
        <tr align="center" colspan="2">
            <td align="center" colspan="5" style="height: 20px; text-align: left">
                <strong><span style="font-size: 10pt; font-family: Verdana">Calculate Growth Payout</span></strong>&nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: left" valign="top">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td align="center" colspan="1" style="width: 238px; height: 18px; text-align: left"
                valign="top">
                Closing No</td>
            <td align="center" colspan="2" style="width: 5px; height: 18px; text-align: left"
                valign="top">
                Balance</td>
            <td align="center" colspan="1" style="height: 18px; text-align: left" valign="top">
                Base</td>
            <td align="center" colspan="1" style="height: 18px; text-align: left" valign="top">
                Date</td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: left" valign="top">
            </td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: center" valign="top">
                Growth Base :<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                &nbsp; &nbsp; Joinings :
                <!-- Donor = 869,&nbsp;&nbsp;Chairman Club = 0,-->
                &nbsp; Total =
                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td align="center" colspan="1" style="width: 238px; height: 18px; text-align: left"
                valign="top">
                Enter Growth Base :
            </td>
            <td align="center" colspan="4" style="height: 18px; text-align: left" valign="top">
                <asp:TextBox ID="TextBox1" runat="server">0</asp:TextBox></td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: center" valign="top">
                <asp:Button ID="Button1" runat="server" Text="Calculate Growth Payout" OnClick="Button1_Click" /></td>
        </tr>
    </table>

</asp:Content>


