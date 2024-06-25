<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cheqprint.aspx.cs" Inherits="admin_cheqprint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center><table border="0" cellpadding="0" cellspacing="0" style="width: 800px"> 
        <tr>
            <td style="height: 20px">
            </td>
            <td style="width: 800px; height: 20px; text-align: center">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Red"
                    Visible="False" Width="308px"></asp:Label></td>
            <td style="height: 20px">
            </td>
        </tr>
        <tr>
            <td style="height: 121px">
            </td>
            <td style="width: 800px; text-align: center; height: 121px;">
               <asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False" AllowPaging="true"  CellPadding="1" Height="106px" Width="498px" ForeColor="#333333" GridLines="None" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging" Font-Names="Arial" Font-Size="Small">
                <Columns>
                <asp:TemplateField HeaderText="Sr.No"><ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>
                   <asp:BoundField HeaderText="Name" DataField="appmstfName" />
                   <asp:BoundField HeaderText="User ID" DataField="appmstid" />
                   <asp:BoundField HeaderText="Closing" DataField="PaymenttranDraftId" />
                   <asp:BoundField HeaderText="Total Amount" DataField="dispachedamt" />
                </Columns>
                   <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                   <RowStyle BackColor="#EFF3FB" />
                   <EditRowStyle BackColor="#2461BF" />
                   <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                   <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                   <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="Black" />
                   <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
            <td style="height: 121px">
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td style="width: 800px; text-align: center;">
                <asp:Button ID="btnprint" runat="server" OnClick="btnprint_Click" Text="Print Cheque"
                    Width="86px" Height="29px" /></td>
            <td>
            </td>
        </tr></table></center>
    </div>
    </form>
</body>
</html>
