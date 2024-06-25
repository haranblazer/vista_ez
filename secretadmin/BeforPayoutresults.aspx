<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BeforPayoutresults.aspx.cs" Inherits="admin_BeforPayoutresults" %>
<%@ PreviousPageType VirtualPath="~/admin/beforPayout.aspx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center><table> <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
            </td>
            <td style="width: 50px; height: 25px">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/printer.gif" OnClick="ImageButton1_Click" ToolTip="Print" />

            </td>
        </tr> 
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                    ForeColor="Red"></asp:Label></td>
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
                text-align: center; width: 700px;" valign="top">
                 <asp:Panel ID="Panel1" runat="server">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"   ForeColor="#333333" GridLines="None"  Width="700px" Font-Names="Arial" Font-Size="Small" >
                        <Columns>
                      
                    <asp:TemplateField HeaderText="Sr.No"> <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>

                            <asp:BoundField DataField="userid" HeaderText="User Id" />
                              <asp:BoundField DataField="appmstfname" HeaderText="User Name" />
                                <asp:BoundField DataField="SponserId" HeaderText="Sponsor Id" />
                                  <asp:HyperLinkField DataTextField ="LeftTotal" HeaderText="Left Total"/>
                                 <asp:HyperLinkField DataTextField ="RightTotal" HeaderText="Right Total"/>
                                  <asp:HyperLinkField DataTextField ="Totalpair" HeaderText=" Total Pair"/>
                                  <asp:BoundField DataField="Totaldirect" HeaderText="Total Direct" />
                                    <asp:HyperLinkField DataTextField="directincome" NavigateUrl="~/admin/directincome.aspx.cs" DataNavigateUrlFields="userid"  DataNavigateUrlFormatString="directincome.aspx?n={0}" HeaderText="Direct Income" />
                                    <asp:HyperLinkField DataTextField="binaryincome" NavigateUrl="~/admin/bineryincome.aspx.cs" DataNavigateUrlFields="userid"  DataNavigateUrlFormatString="bineryincome.aspx?n={0}" HeaderText="Binary Income" />
                                    <asp:HyperLinkField DataTextField="spillincome" HeaderText="Spill Income" />
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EDF0FD" />
                        <EditRowStyle BackColor="#2461BF" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#738EFF" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#738EFF" Font-Bold="True" ForeColor="Black" Font-Names="Arial" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    </asp:Panel>
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr></table></center>
    </div>
    </form>
</body>
</html>
