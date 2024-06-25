<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sendSMStoAll.aspx.cs" Inherits="SIMadmin_sendSMStoAll" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Send SMS To All</title>

</head>
<body>
    <form id="form1" runat="server">
    <div>
     <center>  &nbsp;</center> 
        <center>
            &nbsp;</center>
        <center>
            <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 535px; height: 127px;" >
            <tr>
                <td style="height: 30px; background-color: #2881a2;" colspan="2">
                    <strong><span style="color: #ffffff; font-family: Arial">Send SMS</span></strong></td>
            </tr>
            <tr>
                <td style="width: 18%; height: 214px;">
                    <span style="font-size: 10pt; font-family: Arial"><strong>Type Your Message:</strong></span></td>
                <td style="width: 50%; height: 214px; text-align: left;">
                    <asp:TextBox ID="txtMessage" runat="server" BackColor="White"
                        Height="205px" TextMode="MultiLine" Width="388px"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="background-color: lavender; height: 28px;" colspan="2">
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="10pt"
                        ForeColor="#C00000"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="height: 22px">
                    <asp:Button ID="btnSubmit" runat="server" BackColor="#2881A2" BorderColor="Black"
                        BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" OnClick="btnSubmit_Click"
                        Text="Submit" Width="82px" /></td>
            </tr>
        </table>
        </center>
    
    </div>
    </form>
</body>
</html>
