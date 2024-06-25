<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PinUpdate.aspx.cs" Inherits="admin_PinUpdate" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>UPDATE PIN</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><center><table style="width: 789px; height: 275px">
        <tr>
            <td style="background-color: #414141;" colspan="4">
                <span style="color: #ffffff; font-family: Arial"><strong>UPDATE PIN</strong></span></td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px; text-align: left">
                <span style="font-size: 10pt; font-family: Arial">PIN SERIAL NO.</span></td>
            <td style="width: 188px">
                <asp:TextBox ID="txtpin" runat="server" Enabled="False"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px; text-align: left">
                <span style="font-size: 10pt; font-family: Arial">REGISTRATION NUMBER</span></td>
            <td style="width: 188px">
                <asp:TextBox ID="txtregno" runat="server" Enabled="False"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 26px">
            </td>
            <td style="width: 100px; height: 26px; text-align: left">
                <span style="font-size: 10pt; font-family: Arial">USED STATUS</span></td>
            <td style="width: 188px; height: 26px">
                <asp:TextBox ID="txtpaid" runat="server" Enabled="False"></asp:TextBox></td>
            <td style="width: 100px; height: 26px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px; text-align: left">
                <span style="font-size: 10pt; font-family: Arial">PIN TYPE</span></td>
            <td style="width: 188px">
                <asp:TextBox ID="txtpintype" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px; text-align: left">
                <span style="font-size: 10pt; font-family: Arial">PLAN TYPE</span></td>
            <td style="width: 188px">
                <asp:TextBox ID="txtplantype" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px; text-align: left">
                <span style="font-size: 10pt; font-family: Arial">AMOUNT</span></td>
            <td style="width: 188px">
                <asp:TextBox ID="txtamount" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td align="right" style="width: 100px; text-align: left;">
                <span style="font-size: 10pt; font-family: Arial">ALLOTED TO</span></td>
            <td style="width: 188px">
                <asp:TextBox ID="txtallotedto" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td align="right" style="width: 100px; text-align: left;">
                <span style="font-size: 10pt; font-family: Arial">ALLOTMENT DATE</span></td>
            <td style="width: 188px">
                <asp:TextBox ID="txtdate" runat="server" Width="45px"></asp:TextBox>/<asp:TextBox
                    ID="txtmonth" runat="server" Width="44px"></asp:TextBox>/<asp:TextBox ID="txtyear"
                        runat="server" Width="41px"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td align="right" style="width: 100px">
            </td>
            <td style="width: 188px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 26px">
            </td>
            <td align="center" colspan="2" style="height: 26px">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="SUBMIT" /></td>
            <td style="width: 100px; height: 26px">
            </td>
        </tr>
    </table></center>
    
    </div>
    </form>
</body>
</html>
