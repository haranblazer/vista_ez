<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RewardDispatched.aspx.cs" Inherits="admin_RewardDispatched" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <br />
        <br />
     <center>   <table width="800px" cellspacing="0" style="border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid">
            <tr>
                <td style="width: 800px; background-color: #2881a2; text-align: center;">
                    <span style="color: #ffffff"><span style="font-family: Arial">&nbsp;<strong>Dispatch Reward</strong></span><strong>&nbsp;</strong></span></td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: #f5f5f5;">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <table style="width: 800px">
                        <tr style="background-color: #f5f5f5;">
                            <td style="width: 92px; text-align: left">
                                <asp:RadioButton ID="colourmobile" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Text="Colour Mobile" Width="177px" /></td>
                            <td style="width: 100px; text-align: left">
                                </td>
                            <td style="width: 100px; text-align: left">
                                </td>
                        </tr>
                        <tr>
                            <td style="width: 92px; text-align: left">
                                <asp:RadioButton ID="bike" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                                    GroupName="r" Text="Bike or Laptop" Width="156px" /></td>
                            <td style="width: 100px; text-align: left">
                                </td>
                            <td style="width: 100px; text-align: left">
                                </td>
                        </tr>
                        <tr style="background-color: #f5f5f5;">
                            <td style="width: 92px; text-align: left">
                                <asp:RadioButton ID="alto" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                                    GroupName="r" Text="Maruti Alto" Width="127px" /></td>
                            <td style="width: 100px; text-align: left">
                                </td>
                            <td style="width: 100px; text-align: left">
                                </td>
                        </tr>
                        <tr>
                            <td style="width: 92px; text-align: left">
                                <asp:RadioButton ID="house" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                                    GroupName="r" Text="House or Rs 15,00,000 Cash" Width="336px" /></td>
                            <td style="width: 100px; text-align: left">
                            </td>
                            <td style="width: 100px; text-align: left">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 800px;background-color: #f5f5f5; text-align: left;" >
                    <span style="font-size: 11pt; font-family: Arial"></span>&nbsp;
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <strong><span style="font-size: 11pt; font-family: Arial">ID Number:</span></strong></td>
                            <td style="width: 100px">
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
                        </tr>
                    </table>
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
                    <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="Small" ForeColor="#C00000"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 800px;background-color: #f5f5f5; text-align: center;">
                    <asp:Button ID="btnsSubmit" runat="server" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid"
                        BorderWidth="1px" Font-Bold="True" ForeColor="White" 
                        Text="Submit" Width="82px" OnClick="btnsDispatch_Click" /></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px;background-color: #f5f5f5;">
                </td>
            </tr>
        </table></center>
    
    
    </div>
    </form>
</body>
</html>
