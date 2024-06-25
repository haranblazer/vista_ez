<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListOfPayout.aspx.cs" Inherits="admin_ListOfPayout2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div style="text-align: center">
            &nbsp;</div>
    </div>
        <div style="text-align: center">
            <table border="1" cellpadding="4" cellspacing="4" style="border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid" >
                <tr>
                    <td style="width: 800px">
            <table cellpadding="5" cellspacing="5">
                <tr>
                    <td style="width: 800px; text-align: center; background-color: #2881a2;">
                        <strong><span style="font-family: Verdana; color: #ffffff;">
                        List Of Payout Member</span></strong></td>
                </tr>
                <tr>
                    <td style="width: 800px; text-align: center;">
                        <strong><span style="font-size: 12pt"><span style="font-family: Verdana; font-size: 10pt;">Enter Payout No &nbsp;:</span> &nbsp;</span><asp:TextBox ID="txtpayoutno" runat="server"></asp:TextBox>&nbsp;&nbsp;
                            <asp:Button ID="btnsubmit" runat="server" Font-Bold="True" Text="Submit" OnClick="btnsubmit_Click" /></strong></td>
                </tr>
                <tr>
                    <td style="width: 800px; text-align: center">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                            ForeColor="#C00000"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 800px; text-align: center;">
                        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Font-Names="Arial" Font-Size="Small"  AutoGenerateColumns="False" >
                           <Columns>
                    <asp:TemplateField HeaderText="Sr.No"><ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>
                               <asp:BoundField DataField="RegNo" HeaderText="Id" />
                               <asp:BoundField DataField="FirstName" HeaderText="Name" />
                               <asp:BoundField  DataField="jumboclub1amt" HeaderText="BROI Incomet"/>
                               
                               
                               <asp:BoundField  DataField="jumboclub2amt" HeaderText="ROI Team Bonus"/>
                              
                               <asp:BoundField  DataField="TotalEarning" HeaderText="Total Earning"/>
                               <asp:BoundField  DataField="DispachedAmt" HeaderText="Dispached Amount"/>
                    </Columns>
                   
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <EditRowStyle BackColor="#2461BF" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <HeaderStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <span style="font-family: Arial"><span style="font-size: 10pt">
                        <strong><a href="welcome.aspx">Back</a></strong></span></span></td>
                </tr>
            </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
