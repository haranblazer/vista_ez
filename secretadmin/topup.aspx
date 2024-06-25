<%@ Page Language="C#" AutoEventWireup="true" CodeFile="topup.aspx.cs" Debug="true" Inherits="admin_topup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
   <center> <div>
       <br />
       <br />
       <br />
       <table style="width: 412px; border-right: #2881a2 1px solid; border-top: #2881a2 1px solid; border-left: #2881a2 1px solid; border-bottom: #2881a2 1px solid;">
           <tr>
               <td colspan="2" style="background-color: #2881a2">
                   <strong><span style="color: #ffffff; font-family: Arial">Top Up</span></strong></td>
           </tr>
           <tr>
               <td style="width: 138px; text-align: left">
                   <span style="font-size: 10pt; font-family: Arial">Registration No</span></td>
               <td style="width: 100px; text-align: left">
                   <asp:TextBox id="txtregno" runat="server"></asp:TextBox></td>
           </tr>
           <tr>
               <td style="width: 138px; text-align: left">
                   <span style="font-size: 10pt; font-family: Arial">Amount</span></td>
               <td style="width: 100px; text-align: left">
                   <asp:DropDownList ID="JoinFor" runat="server" Width="79px">
                       <asp:ListItem Value="1">2100</asp:ListItem>
                       <asp:ListItem Value="2">3800 </asp:ListItem>
                       <asp:ListItem Value="4">7300</asp:ListItem>
                   </asp:DropDownList></td>
           </tr>
           <tr>
               <td colspan="2">
                   <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#C00000"></asp:Label></td>
           </tr>
           <tr>
               <td colspan="2">
                   <asp:Button id="Button1" onclick="Button1_Click" runat="server" Text="Submit" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" ValidationGroup="p" BackColor="#2881A2"></asp:Button></td>
           </tr>
       </table>
       <br />
       <br />
       <br />
       <br />
    
    </div></center>
    </form>
</body>
</html>
