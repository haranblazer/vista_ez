<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DispatchReward.aspx.cs" Inherits="admin_rewards" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
   
</head>
<body style="font-size: 12pt">
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="130">
            <tr>
                <td colspan="3" style="height: 25px; text-align: center">
                </td>
            </tr>
            <tr>
                <td colspan="3" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                    border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                    background-color: #2881a2; text-align: center">
                    <strong><span style="color: #ffffff; font-family: Arial;">Reward List For Eligible Candidate</span></strong></td>
            </tr>
            <tr>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px; border-bottom-color: blue; width: 69px; border-top-color: blue;
                    height: 22px; border-right-width: 1px; border-right-color: blue">
                </td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px; border-bottom-color: blue; width: 79px; border-top-color: blue;
                    height: 22px; border-right-width: 1px; border-right-color: blue">
                </td>
            </tr>
            <tr>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 69px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rdbtnMobile" runat="server" Font-Bold="True" GroupName="r" Text="Digital Camera"
                        Width="266px" Font-Names="Arial" Font-Size="10pt" Checked="True" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 79px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    &nbsp;
                    <asp:RadioButton ID="rdbtnLaptop" runat="server" Font-Bold="True" GroupName="r" Text="Rs 15000/- For Laptop"
                        Width="217px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rdbtnBike" runat="server" Font-Bold="True" GroupName="r"
                        Text="Rs 35000/- For Bike" Width="252px" Font-Names="Arial" Font-Size="10pt" /></td>
            </tr>
            <tr>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 69px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rbtnAlto" runat="server" Font-Bold="True" GroupName="r"
                        Text="Rs 200000/- For Alto" Width="302px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 79px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rdbtnFiesta" runat="server" Font-Bold="True" GroupName="r"
                        Text='Rs 500000/- For Swift' Width="237px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rbtnHondaCity" runat="server" Font-Bold="True" GroupName="r"
                        Text="Rs 800000/- For Innova" Width="234px" Font-Names="Arial" Font-Size="10pt" /></td>
            </tr>
            <tr>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 69px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    </td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 79px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    </td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    </td>
            </tr>
            <tr>
                <td colspan="3" style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100%;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: center">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="Red"
                        Text="Label" Visible="False" Width="208px" Font-Names="Arial"></asp:Label>
                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="Red"
                        Text="Label" Visible="False" Width="208px" Font-Names="Arial"></asp:Label>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3" style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px;
                    height: 23px; text-align: center; border-right-width: 1px; border-right-color: blue">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp;
                    <asp:Button ID="btnshow" runat="server" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid"
                        BorderWidth="1px" Font-Bold="True" ForeColor="White" OnClick="Button1_Click"
                        Text="Show" Width="82px" />
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/admin_images/excel.gif" /><asp:Button
                            ID="Button3" runat="server" BackColor="#093872" BorderStyle="None" Font-Bold="True"
                            Font-Italic="True" ForeColor="White" OnClick="Button3_Click" Text="EXPORT" Width="80px" /></td>
            </tr>
            <tr>
                <td colspan="3" style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px; border-bottom-color: blue; width: 800px; border-top-color: blue;
                    height: 35px; text-align: center; border-right-width: 1px; border-right-color: blue">
                    &nbsp;<span style="font-size: 11pt; font-family: Arial">Total Selected Member</span>&nbsp;
                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Style="left: 1px" Text="0" Font-Names="Arial" Font-Size="10pt"></asp:Label>
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                    border-left: #000000 1px solid; border-bottom: #000000 1px solid">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                        DataKeyNames="userid" ForeColor="#333333" GridLines="None" OnRowCreated="GridView1_RowCreated"
                        Width="100%" Font-Names="Arial" Font-Size="10pt">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <asp:Label ID="srno1" runat="server" Text='<%# Container.DataItemIndex +1%>'>  </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="userid" HeaderText="User Id" />
                            <asp:BoundField DataField="fname" HeaderText="Name" />
                            <asp:BoundField DataField="aname" HeaderText="Award Name" />
                            <asp:BoundField DataField ="adate" HeaderText ="Award Date" />
                         
                        </Columns>
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EDF0FD" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 15px; text-align: center">
                    &nbsp; &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 15px; text-align: center" runat="server" visible="false">
                    </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
