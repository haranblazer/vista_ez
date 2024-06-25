<%@ Page Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="TeamIncome.aspx.cs" Inherits="admin_TeamIncome" Title="Calculate Team Income : Admin Control Panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">
function Checknumeric()
{
  if (event.keyCode >= 48 && event.keyCode <= 57) {
    return true; }
  else {
    alert("Please Enter Only Digit");
    return false;
  }
}
</script>

    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                background-color: #2881A2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">&nbsp;Assign
                    Rank And Calculate Team Income&nbsp;</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 350px; height: 35px; background-color: #EDF0FD;">
                &nbsp;</td>
            <td style="border-right: #000000 1px solid; width: 350px; height: 35px; background-color: #EDF0FD; text-align: right;">
                Total New Member :
                <asp:Label ID="Label5" runat="server" Font-Bold="True"></asp:Label>&nbsp;</td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 350px; height: 35px; text-align: right">
                Enter&nbsp; Id No &nbsp;:&nbsp;&nbsp;
            </td>
            <td style="border-right: #000000 1px solid; width: 350px; height: 35px">
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 350px; height: 35px; text-align: right; border-bottom: #000000 1px solid; background-color: #EDF0FD;">
                Enter New Rank&nbsp; :&nbsp;&nbsp;
            </td>
            <td style="border-right: #000000 1px solid; width: 350px; height: 35px; border-bottom: #000000 1px solid; background-color: #EDF0FD;">
                <asp:TextBox ID="TextBox2" runat="server"  onkeypress="return Checknumeric()">1</asp:TextBox></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="height: 25px; text-align: center; border-left-width: 1px; border-left-color: #000000;" colspan="2">
                <asp:Label ID="error" runat="server" Font-Bold="True" ForeColor="Red" Width="210px" style="text-align: center"></asp:Label>
                &nbsp;&nbsp;
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td colspan="2" style="height: 35px; text-align: center; border-right-width: 1px;
                border-right-color: #000000">
                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click1" BackColor="#2881A2" BorderColor="Black" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="height: 25px; text-align: center; border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px; border-bottom-color: #000000; border-right-width: 1px; border-right-color: #000000;">
                <asp:Label ID="ok" runat="server" Font-Bold="True" ForeColor="Black" Width="217px"></asp:Label></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 50px">
            </td>
            <td colspan="2" style="height: 50px; text-align: center; border-left-width: 1px; border-left-color: #000000; border-right-width: 1px; border-right-color: #000000;">
                <asp:Button ID="Button2" runat="server" Font-Bold="True" Text="Click Here To Calculate Team Income. "
                    Width="281px" OnClick="Button2_Click" BackColor="#2881A2" BorderColor="Black" ForeColor="White" /></td>
            <td style="width: 50px; height: 50px">
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>

