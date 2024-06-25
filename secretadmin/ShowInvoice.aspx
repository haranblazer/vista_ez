<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowInvoice.aspx.cs" Inherits="admin_ShowInvoice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:GridView id="dgr" runat="server" Font-Size="Small" Font-Names="Arial" GridLines="None" ForeColor="#333333" CellPadding="4" AutoGenerateColumns="False" DataKeyNames="appmstid" ShowHeader="false">
            <Columns>
               
              
             
                <asp:HyperLinkField HeaderText="Print Invoice" DataTextField="AppMstid" DataNavigateUrlFields="srno,AppMstid" DataNavigateUrlFormatString="invoice.aspx?n={0}&amp;n1={1}"  Text="Print Invoice" ></asp:HyperLinkField>
          
            </Columns>
            <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True"  />
            <RowStyle ForeColor="#333333"  />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy"  />
            <PagerStyle BackColor="#69B5D1" ForeColor="Black" HorizontalAlign="Center"  />
            <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White"  />
        </asp:GridView>
    </div>
    </form>
</body>
</html>
