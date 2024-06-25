<%@ Page Language="C#" AutoEventWireup="true" CodeFile="modifypayment.aspx.cs" Inherits="admin_modyfypayment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
  <div align="center">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
      <td><div align="center">
        <table width="900" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
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
                background-color: #2881a2; text-align: center">
                <strong><span style="font-size: 11pt; color: #ffffff; font-family: Arial;">Modify Payment</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
                background-color: #f3f3f3; text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">
                User ID: </span>
            </td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #f3f3f3; text-align: left;">
                <asp:TextBox ID="txtid" runat="server" BorderWidth="0px" Enabled="False"></asp:TextBox></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
                background-color: #ffffff; text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">Display:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #ffffff; text-align: left;">
                <asp:TextBox ID="txtdisp" runat="server">0</asp:TextBox>&nbsp;&nbsp;&nbsp;
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr style="background-color:#f3f3f3">
            <td style="width: 50px; height: 35px;background-color: #ffffff">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
               text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">Binary Income:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; text-align: left">
                <asp:TextBox ID="txtbinary" runat="server">0</asp:TextBox></td>
            <td style="width: 50px; height: 35px;background-color: #ffffff">
            </td>
        </tr>
        <tr style="background-color:#f3f3f3">
            <td style="width: 50px; height: 35px;background-color: #ffffff">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
               text-align: right">
                <span style="font-size: 10pt; font-family: Arial">Mobile:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; text-align: left">
                <asp:TextBox ID="txtMobile" runat="server">0</asp:TextBox></td>
            <td style="width: 50px; height: 35px;background-color: #ffffff">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
                background-color: #ffffff; text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">Laptop :</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #ffffff; text-align: left;">
                <asp:TextBox ID="txtLaptop" runat="server">0</asp:TextBox>&nbsp;&nbsp;&nbsp;
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
           <tr style="background-color:#f3f3f3">
            <td style="width: 50px; height: 35px;background-color: #ffffff">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
               text-align: right">
                <span style="font-size: 10pt; font-family: Arial">Bike :</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; text-align: left">
                <asp:TextBox ID="txtBike" runat="server">0</asp:TextBox></td>
            <td style="width: 50px; height: 35px;background-color: #ffffff">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
                background-color: #ffffff; text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">Alto:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #ffffff; text-align: left;">
                <asp:TextBox ID="txtAlto" runat="server">0</asp:TextBox>&nbsp;&nbsp;&nbsp;
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
           <tr style="background-color:#f3f3f3">
            <td style="width: 50px; height: 35px;background-color: #ffffff">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
               text-align: right">
                <span style="font-size: 10pt; font-family: Arial">Fiesta:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; text-align: left">
                <asp:TextBox ID="txtFiesta" runat="server">0</asp:TextBox></td>
            <td style="width: 50px; height: 35px;background-color: #ffffff">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
                background-color: #ffffff; text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">Honda City :</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #ffffff; text-align: left;">
                <asp:TextBox ID="txtHondaCity" runat="server">0</asp:TextBox>&nbsp;&nbsp;&nbsp;
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
                background-color: #ffffff; text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">TDS:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #ffffff; text-align: left;">
                <asp:TextBox ID="txtTDS" runat="server" Enabled="False">0</asp:TextBox>&nbsp;&nbsp;&nbsp;
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; border-left: #000000 1px solid; width: 350px; height: 35px;
                background-color: #f3f3f3; text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">
                Other Charges:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #f3f3f3; text-align: left;">
                <asp:TextBox ID="txtother" runat="server" Enabled="False">0</asp:TextBox>&nbsp;&nbsp;&nbsp;
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; font-weight: bold; font-size: 14px; border-left: #000000 1px solid;
                width: 350px; color: #ffffff; height: 35px; background-color: #5789a4; text-align: right;">
                <span style="font-size: 10pt; font-family: Arial">
                Total Income:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #5789a4; text-align: left;">
                <asp:TextBox ID="txttotal" runat="server" Enabled="False">0</asp:TextBox></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; font-weight: bold; font-size: 14px; border-left: #000000 1px solid;
                width: 350px; color: #ffffff; height: 35px; background-color: #5789a4; text-align: right;">
                <span style="font-size: 9pt; font-family: Arial">
                Dispatched Income:</span></td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #5789a4; text-align: left;">
                <asp:TextBox ID="txtdispatch" runat="server">0</asp:TextBox></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="padding-left: 100px; font-weight: bold; font-size: 14px; border-left: #000000 1px solid;
                width: 350px; color: #ffffff; height: 35px; background-color: #5789a4; text-align: right">
                Reason For Modification:</td>
            <td style="border-right: #000000 1px solid; padding-right: 95px; padding-left: 5px;
                width: 350px; height: 35px; background-color: #5789a4; text-align: left">
                <asp:TextBox ID="TxtReason" runat="server" ></asp:TextBox>
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="height: 25px; text-align: center; border-right-width: 1px;
                border-right-color: #000000">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td colspan="2" style="height: 35px; text-align: center; border-right-width: 1px;
                border-right-color: #000000">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td colspan="2" style="height: 35px; text-align: center; border-right-width: 1px;
                border-right-color: #000000">
                <a href="javascript:window.close()"><span style="font-size: 10pt; font-family: Arial">
                    <strong>Close windows</strong></span></a><span style="font-size: 10pt; font-family: Arial"><strong>
                    </strong></span>
        </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
    </table>
   
    
            </td>
          </tr>
        </table>
      </div></td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
    </form>
</body>
</html>
