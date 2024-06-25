<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchResult.aspx.cs" Inherits="admin_SearchResult" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px"> <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-left-width: 1px; border-left-color: #000000; width: 83px; height: 35px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Red"
                    Width="135px"></asp:Label></td>
            <td colspan="2" style="height: 35px">
            </td>
            <td style="width: 175px; height: 35px; border-right-width: 1px; border-right-color: #000000; text-align: right;">
                <span style="font-size: 11pt; font-family: Arial"><strong>
                No Of Records Found&nbsp;</strong></span>
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial"></asp:Label></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr> <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td colspan="4" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 700px; border-bottom: #000000 1px solid;
                height: 35px">          
                
                
                
              
            <asp:DataGrid ID="dgr" runat="server" AllowPaging="True" OnPageIndexChanged="dgr_PageIndexChanged" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="50" Width="720px" Font-Names="Arial" Font-Size="Small">
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Sr.No" ItemStyle-Font-Bold="true">
                                        <ItemTemplate  >
                                        <%#dgr.PageSize * dgr.CurrentPageIndex + Container.ItemIndex + 1%>
                                        </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:HyperLinkColumn  DataTextField="AppMstFName" DataNavigateUrlField="AppMstregno" DataNavigateUrlFormatString="edit.aspx?n={0}"  HeaderText="Edit"></asp:HyperLinkColumn>
                                        <asp:BoundColumn DataField="appmstregno" HeaderText="UserId"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="AppmstFName" HeaderText=" First Name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="AppMstLName" HeaderText="Last Name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="AppMstCity" HeaderText="City"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="AppmstState" HeaderText="State"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="SponsorId" HeaderText="SponsorId"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="AppmstDoj" HeaderText="Joining_Date"></asp:BoundColumn>
                                      
                                    </Columns>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                                    <PagerStyle BackColor="#738EFF" ForeColor="Black" HorizontalAlign="Center" Mode="NumericPages" />
                                    <AlternatingItemStyle BackColor="White" />
                                    <ItemStyle BackColor="#EDF0FD" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#738EFF" Font-Bold="True" ForeColor="Black" Font-Names="Arial" />
                                </asp:DataGrid></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr></table>
    </div>
    </form>
</body>
</html>
