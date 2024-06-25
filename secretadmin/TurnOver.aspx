<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TurnOver.aspx.cs" Inherits="admin_TurnOver" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body style="font-size: 12pt">
    <form id="form1" runat="server">
    <div>
    <center>
        &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            <table border="0" cellpadding="0" cellspacing="0" style="width: 523px; border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid; height: 311px;">
        <tr>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 600px; border-bottom: #000000 1px solid;
                height: 28px; background-color: #2881a2; text-align: center">
                <strong><span style="color: #ffffff; font-family: Arial;">&nbsp;Calculate Turnover</span></strong></td>
        </tr>
        <tr>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #edf0fd;
                text-align: center">
                <span style="font-size: 10pt; font-family: Arial">
                From :</span>
                <asp:TextBox ID="txtFddd" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                &nbsp; /<asp:TextBox ID="txtFmm" runat="server" MaxLength="2" Width="47px"></asp:TextBox>&nbsp;
                /
                <asp:TextBox ID="txtfyy" runat="server" MaxLength="4" Width="47px">200</asp:TextBox></td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #edf0fd;
                text-align: center">
                <span style="font-size: 10pt; font-family: Arial">
                To :</span>
                <asp:TextBox ID="txttodd" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                /
                <asp:TextBox ID="txttomm" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                /
                <asp:TextBox ID="txttoyy" runat="server" MaxLength="4" Width="47px">200</asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="2" style="border-right: #000000 1px solid; border-left: #000000 1px solid;
                border-bottom: #000000 1px solid; height: 35px; background-color: #edf0fd; text-align: center">
                <asp:Label ID="error" runat="server" ForeColor="Red" Width="238px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 25px;
                text-align: center">
                <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 35px;
                text-align: center">
                <span style="font-size: 10pt; font-family: Arial">Enter Registration No:-</span><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 3px;
                text-align: center">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 53px;
                text-align: center">
                <table>
                    <tr>
                        <td style="width: 100px; height: 32px">
                            <asp:Label ID="Label4" runat="server" Text="Consolidated Turnover" Font-Names="Arial" Font-Size="10pt" Width="130px"></asp:Label></td>
                        <td style="width: 100px; height: 32px">
                            <asp:Label ID="Label5" runat="server" Text="0" Width="68px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 100px; text-align: left;">
                            <asp:Label ID="Label3" runat="server" Text="Plan A Turnover" Width="97px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                        <td style="width: 100px">
                            <asp:Label ID="Label6" runat="server" Text="0" Width="67px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 100px; text-align: left;">
                            <asp:Label ID="Label2" runat="server" Text="Plan B Turnover" Width="100px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                        <td style="width: 100px">
                            <asp:Label ID="Label7" runat="server" Text="0" Width="68px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                    </tr>
                </table>
                &nbsp; &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 48px;
                text-align: center">
                <asp:Button ID="Button1" runat="server" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px"
                    Font-Bold="True" ForeColor="White" OnClick="Button1_Click" Text="Show" /></td>
        </tr>
    </table>
        </center>
    </div>
    </form>
</body>
</html>
