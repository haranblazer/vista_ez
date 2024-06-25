<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceAndWelcomeletter.aspx.cs" Inherits="admin_InvoiceAndWelcomeletter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
   <center> &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            <table> <tr class="sub">
                <td style="text-align: center" >
                   <asp:GridView ID="dgr" ShowHeader="false" DataKeyNames="appmstid" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None"  Font-Names="Arial" Font-Size="Small" >
            <Columns>
               
              
             
                <asp:HyperLinkField HeaderText="Print Invoice" DataNavigateUrlFields="srno,AppMstid" DataNavigateUrlFormatString="invoice.aspx?n={0}&amp;n1={1}"  Text="Print Invoice" />
          
            </Columns>
            <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
            <RowStyle ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <PagerStyle BackColor="#69B5D1" ForeColor="Black" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
                    
                   </td>
                <td style="text-align: center; vertical-align: top;" >
                    <a href="welcomeletter.aspx"><span style="font-size: 10pt; font-family: Arial">Print Welcome Letter</span></a></td>
                <td >
                    &nbsp;</td>
            </tr></table>
        </center>
    </div>
    </form>
</body>
</html>
