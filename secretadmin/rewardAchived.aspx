<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rewardAchived.aspx.cs" Inherits="admin_rewardAchived" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><center><table border="0" align="center" cellpadding="0" cellspacing="0" style="border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid">
        <tr>
            <td colspan="3" style="height: 25px; text-align: left"> <table width="800px" cellspacing="0" style="border-top-width: thin; border-left-width: thin; border-bottom-width: thin; border-right-width: thin;">
            <tr>
                <td style="width: 800px; background-color: #2881a2; text-align: center;">
                    <span style="color: #ffffff"><span style="font-family: Arial"><strong>Reward Achieved List</strong></span></span></td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: #f5f5f5;">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; text-align: left;">
                    <table style="width: 400px">
                        <tr>
                            <td style="width: 100px">
                                <asp:RadioButton ID="rbtnQualify" runat="server" Checked="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="ok" Text="Qualify" /></td>
                            <td style="width: 100px">
                                <asp:RadioButton ID="rbtnDispatch" runat="server" Font-Names="Arial" Font-Size="Small"
                                    GroupName="ok" Text="Dispatch" /></td>
                        </tr>
                    </table>
                    </td>
            </tr>
            <tr>
                <td style="width: 800px;background-color: #f5f5f5; text-align: center;">
                    <asp:Button ID="btnsShow" runat="server" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid"
                        BorderWidth="1px" Font-Bold="True" ForeColor="White" 
                        Text="Show" Width="82px" OnClick="btnsShow_Click"  />
                    <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="Small" ForeColor="#C00000"></asp:Label></td>
            </tr>
        </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid; border-top-color: #000000; border-bottom: #000000 1px solid">
                <asp:GridView ID="GridView1" runat="server" Width="794px" DataKeyNames="Appmstregno" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small">
                    <Columns>
                        <asp:BoundField  DataField="Appmstregno"   HeaderText="User Id" />
                        <asp:BoundField  DataField="appmstfname"  HeaderText="Name" />
                        <asp:BoundField  DataField="AwardAchivedDate"  HeaderText="Achieved Date" />
                        
                        <asp:BoundField  DataField="awardname" HeaderText="Award Name" />
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
    </table></center>
    
    </div>
    </form>
</body>
</html>
