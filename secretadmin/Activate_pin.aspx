<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Activate_pin.aspx.cs" Inherits="admin_Activate_pin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
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
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>  &nbsp;</center>
        <center>
            <table border="0" cellpadding="0" cellspacing="0" style="width: 800px; border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid;">
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="height: 25px">
            </td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881a2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff; font-family: Arial;">Activate Pin (One by One)</span></strong></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 600px; border-top-color: #000000;
                height: 25px; background-color: #f3f3f3; text-align: center">
                <strong><span style="font-family: Arial">Enter Pin Numbers</span></strong></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 600px; border-top-color: #000000;
                height: 35px; background-color: #f3f3f3; text-align: center">
                <span style="font-family: Arial">
                1.&nbsp;</span>
                <asp:TextBox ID="txtpin1" runat="server" onkeypress="return Checknumeric()" Width="160px"></asp:TextBox>&nbsp;
                <asp:Label ID="lblpin1" runat="server" Width="127px" ForeColor="Red" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 32px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 600px; border-top-color: #000000;
                height: 35px; background-color: #f3f3f3; text-align: center">
            2.&nbsp;
            <asp:TextBox ID="txtpin2" runat="server" onkeypress="return Checknumeric()" Style="z-index: 100;
                left: 0px; position: relative; top: -1px" Width="160px"></asp:TextBox>&nbsp;
            <asp:Label ID="lblpin2" runat="server" Width="127px" ForeColor="Red" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
            <td style="width: 100px; height: 32px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 600px; border-top-color: #000000;
                height: 35px; background-color: #f3f3f3; text-align: center">
            3.&nbsp;
            <asp:TextBox ID="txtpin3" runat="server" onkeypress="return Checknumeric()" Style="z-index: 100;
                left: 0px; position: relative; top: -1px" Width="160px"></asp:TextBox>&nbsp;
            <asp:Label ID="lblpin3" runat="server" Width="127px" ForeColor="Red" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 600px; border-top-color: #000000;
                height: 35px; background-color: #f3f3f3; text-align: center">
            4.&nbsp;
            <asp:TextBox ID="txtpin4" runat="server" onkeypress="return Checknumeric()" Style="z-index: 100;
                left: 0px; position: relative; top: -1px" Width="160px"></asp:TextBox>&nbsp;
            <asp:Label ID="lblpin4" runat="server" Width="127px" ForeColor="Red" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-top-color: #000000; border-bottom: #000000 1px solid; height: 35px;
                background-color: #f3f3f3; text-align: center">
            5.&nbsp;
            <asp:TextBox ID="txtpin5" runat="server" onkeypress="return Checknumeric()" Style="z-index: 100;
                left: 0px; position: relative; top: -1px" Width="160px"></asp:TextBox>&nbsp;
            <asp:Label ID="lblpin5" runat="server" Width="127px" ForeColor="Red" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; width: 600px; border-top-color: #000000;
                height: 35px; text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:Button ID="btnActivate" runat="server" OnClick="btnActivate_Click" Text="Activate" Width="93px" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; width: 600px; border-top-color: #000000;
                height: 35px; text-align: center; border-right-width: 1px; border-right-color: #000000">
            </td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881a2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff; font-family: Arial;">Activate Pins (By Range)</span></strong></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 600px; border-top-color: #000000;
                height: 35px; background-color: #f3f3f3; text-align: center">
                <span style="font-family: Arial">
                From : </span>
                <asp:TextBox ID="txtstart" runat="server"></asp:TextBox>&nbsp;<span style="font-family: Arial">
                    To :</span>
                <asp:TextBox ID="txtend" runat="server"></asp:TextBox></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px;">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-top-color: #000000; border-bottom: #000000 1px solid;
                background-color: #f3f3f3; text-align: left">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                &nbsp;&nbsp;
                <asp:Label ID="lblfrom" runat="server" Text="Label" Width="150px" ForeColor="Red" Visible="False" Font-Names="Arial" Font-Size="Small"></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <asp:Label ID="lblto" runat="server" Text="Label" Width="154px" ForeColor="Red" Visible="False" style="text-align: left" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
            <td style="width: 100px;">
            </td>
        </tr>
        <tr id="message" runat="server">
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; width: 600px; border-top-color: #000000;
                height: 25px; text-align: center; border-right-width: 1px; border-right-color: #000000">
                <span style="font-family: Arial">
                Pin Range has been Activated </span>
            </td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; width: 600px; border-top-color: #000000;
                height: 35px; text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:Button ID="btn123" runat="server" Text="Activate" Width="102px" OnClick="btn123_Click" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
    </table>
        </center>
    </div>
    </form>
</body>
</html>
