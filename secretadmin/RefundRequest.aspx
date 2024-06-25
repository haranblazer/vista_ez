<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefundRequest.aspx.cs" Inherits="admin_RefundRequest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>
            <table style="border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid" cellspacing="0" id="TABLE1" onclick="return TABLE1_onclick()">
                <tr>
                    <td style="width: 100%; background-color: #2881a2">
                        <span style="font-size: 11pt; color: #ffffff; font-family: Arial"><strong style="width: 100%">
                          Refund Request</strong></span></td>
                </tr>
                <tr style="color: #000000">
                    <td style="width: 100%; text-align: left">
                    </td>
                </tr>
                <tr style="background-color: #edf0fd;">
                    <td style="width: 100%; text-align: left">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#C00000"
                            Width="204px" Font-Size="Small"></asp:Label>
                        </td>
                </tr>
            <tr style="color: #000000">
                <td style="width: 100px"> <asp:GridView ID="GridView1" runat="server" Width="880px"  CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" AllowPaging="True"  PageSize="25" OnPageIndexChanging="GridView1_PageIndexChanging"  >
                    <Columns>
                    <asp:TemplateField HeaderText="Sr.No"><ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>

                        <asp:BoundField  DataField="userid"   HeaderText="User Id" />
                        <asp:BoundField  DataField="Amount" HeaderText="Amount" />
                        <asp:BoundField  DataField="Reason"  HeaderText="Reason" />
                        <asp:BoundField  DataField="date"  HeaderText="Date" />
                        
                        
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EDF0FD" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <PagerStyle BackColor="#69B5D1" ForeColor="#333333" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    
                </asp:GridView>
                </td>
            </tr>
        </table>
        </center>
    </div>
    </form>
</body>
</html>
