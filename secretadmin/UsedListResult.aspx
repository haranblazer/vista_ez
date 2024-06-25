<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UsedListResult.aspx.cs" Inherits="admin_UsedListResult" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><center><table border="0" cellpadding="0" cellspacing="0" style="width: 800px"> <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-bottom: #000000 1px solid; border-left: #000000 1px solid;
                height: 25px; text-align: center; border-top: #000000 1px solid;" valign="top">
            <asp:DataGrid ID="dgrd" runat="server" AllowPaging="true" PageSize="50" AllowCustomPaging="true" PagerStyle-Mode="NumericPages" OnPageIndexChanged="dgrd_PageIndexChanged" Width="697px" Font-Names="Arial" Font-Size="Small" >
              <Columns> <asp:TemplateColumn HeaderText="Sr.No" ItemStyle-Font-Bold="true">
                       <ItemTemplate >
                         <%#dgrd.PageSize * dgrd.CurrentPageIndex + Container.ItemIndex + 1%>
                       </ItemTemplate>
                    </asp:TemplateColumn></Columns>
               <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
       <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
       <AlternatingItemStyle BackColor="White" />
       <ItemStyle BackColor="#EDF0FD" ForeColor="#333333" />
      <HeaderStyle BackColor="#738EFF" Font-Bold="True" ForeColor="White" Height="20px" />
                <PagerStyle Mode="NumericPages" BackColor="#FC7905" />
            </asp:DataGrid></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr></table></center>
    
    </div>
    </form>
</body>
</html>
