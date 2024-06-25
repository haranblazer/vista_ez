<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rewardrequestlist.aspx.cs" Inherits="rewardrequestlist" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body style="font-size: 12pt">
    <form id="form1" runat="server">
    <div>
        <div style="text-align: center">
            <table>
                <tr>
                    <td style="width: 100px; height: 21px; text-align;" align="center">
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="10pt"
                            Text="1 For Selected  ; 2 For Not Selected  ; 0 For Skipped" Width="361px"></asp:Label></td>
                </tr>
                <tr>
                    <td align="center" style="font-weight: bold;" bgcolor="#009bd1">
                        <span style="font-size: 14pt; font-family: Arial">
                        Reward Request List</span></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                            BorderColor="Black" BorderWidth="1px" CellPadding="4" DataKeyNames="AppMstRegNo"
                            Font-Names="Arial" Font-Size="10pt" ForeColor="#333333" GridLines="None" Height="20px"
                            OnPageIndexChanging="GridView1_PageIndexChanging1" PageSize="25" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No">
                                    <ItemStyle Font-Bold="True" Height="20px" />
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AppMstRegNo" HeaderText="UserId" />
                                <asp:BoundField DataField="AppMstfname" HeaderText="Name" />
                                <asp:BoundField DataField="R1" HeaderText="Wrist Watch Pair" />
                                <asp:BoundField DataField="R2" HeaderText="Magic Bullte OR vacuum Cleaner" />
                                <asp:BoundField DataField="R3" HeaderText="R.O.Water Purifier OR Digital Camera Worth Rs 8,600" />
                                <asp:BoundField DataField="R4" HeaderText="Laptop Worth Rs 20,000" />
                                <asp:BoundField DataField="R5" HeaderText="Bike Worth Rs 30,000" />
                                <asp:BoundField DataField="R6" HeaderText="LCD 32 Worth Rs 50,000" />
                                <asp:BoundField DataField="R7" HeaderText="Maruti Alto (Base Model)" />
                                <asp:BoundField DataField="R8" HeaderText="Maruti Swift (Base Model)" />
                                <asp:BoundField DataField="R9" HeaderText="Hyundai Verna (Base Model)" />
                                 <asp:BoundField DataField="R10" HeaderText="Skoda (Base Model)" />
                                <asp:BoundField DataField="R11" HeaderText="Rs 25 Lakhs For Home" />
                                <asp:BoundField DataField="R12" HeaderText="Mercedes Benz OR Rs 40 Lakh" />
                            </Columns>
                            <RowStyle BackColor="#EDF0FD" />
                            <PagerStyle BackColor="#69B5D1" ForeColor="Black" />
                            <HeaderStyle BackColor="#69B5D1" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial"></asp:Label></td>
                </tr>
            </table>
        </div>
    
    </div>
    </form>
</body>
</html>
