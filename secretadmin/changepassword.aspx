<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changepassword.aspx.cs" Inherits="admin_changepassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="width: 300px; height: 25px">
            </td>
            <td style="width: 300px; height: 25px">
            </td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 600px; border-bottom: #000000 1px solid;
                height: 15px; background-color: #2881A2; text-align: center">
                <span style="font-size: 16px; color: #ffffff; font-family: Arial;"><strong>Change Password</strong></span></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD;
                text-align: right">
                <span style="font-size: 10pt; font-family: Arial">
                Old Password &nbsp; :</span></td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD">
                    &nbsp;<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #ffffff;
                text-align: right">
                <span style="font-size: 10pt; font-family: Arial">
                New Password &nbsp; :</span></td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #ffffff">
                    &nbsp;<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; border-bottom: #000000 1px solid;
                height: 35px; background-color: #EDF0FD; text-align: right">
                <span style="font-size: 10pt; font-family: Arial">
                Confirm Password &nbsp; :</span></td>
            <td style="border-right: #000000 1px solid; width: 300px; border-bottom: #000000 1px solid;
                height: 35px; background-color: #EDF0FD">
                &nbsp;
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px;
                border-bottom-color: #000000; height: 35px; text-align: center">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Change Password" Width="124px" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px;
                border-bottom-color: #000000; height: 35px; text-align: center">
                <a href="adminLog.aspx"><span style="font-size: 10pt; font-family: Arial"><strong>Back</strong></span></a></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
