<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Receipt.aspx.cs" Inherits="user_Receipt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Receipt</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="0" cellpadding="0" cellspacing="0" style="width: 699px; border-right: #000000 1px solid;
                border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid;">
                <tr>
                    <td align="left" style="font-size:10pt; font-family: Arial; font-weight:bold;
                        height: 15px; text-align: center">
                        <div style="font-family: Trebuchet MS;  font-size: 24px; font-weight: bold;">
                            <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
                            is an unit of<br />
                            Sparknet(India) Marketing Pvt. Ltd.<br />
                        </div>
                        <asp:Label ID="lblHAddress" runat="server" Font-Names="Trebuchet MS" Font-Size="10pt"
                            ></asp:Label><br />
                        Phone No :-&nbsp;
                        <asp:Label ID="lblPhone" runat="server" Font-Names="Trebuchet MS" Font-Size="10pt"></asp:Label><br />
                        Email &nbsp;:-&nbsp;
                        <asp:Label ID="lbleMail" runat="server" Font-Names="Trebuchet MS" Font-Size="10pt"></asp:Label><br />
                        Website :-&nbsp;
                        <asp:Label ID="lblWebSite" runat="server" Font-Names="Trebuchet MS" Font-Size="10pt"></asp:Label></td>
                    <td style="height: 15px" valign="top">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 12px">
                        </td>
                </tr>
                <tr>
                    <td style="width: 100%; text-align: center;">
                        &nbsp;--------------------------------------------------------------------------------------------------------------&nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 49px; text-align: center">
                        <strong><span style="font-size: 14pt; font-family: Arial">RECEIPT</span></strong></td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 95px; vertical-align: top;">
                        <span style="font-size: 10pt; font-family: Arial">RECEIVED WITH THANKS Rs.</span><asp:Label
                            ID="lblPackageCost" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label><span
                                style="font-size: 10pt; font-family: Arial"> TOWARDS COST OF </span>
                        <asp:Label ID="lblProductName" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label>&nbsp;<br />
                        <span style="font-size: 10pt; font-family: Arial">FROM
                            <asp:Label ID="lblIBO" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label>
                            AGAINST RECEIPT NO. </span>
                        <asp:Label ID="lblreceiptInvoiceNo" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label><span
                            style="font-size: 10pt; font-family: Arial"></span></td>
                </tr>
                <tr>
                    <td style="width: 100%; text-align: right">
                        <strong><span style="font-size: 10pt; font-family: Arial">For
                            <asp:Label ID="lblCName" runat="server" Font-Names="Trebuchet MS" Font-Size="9pt"></asp:Label>&nbsp;</span></strong></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
