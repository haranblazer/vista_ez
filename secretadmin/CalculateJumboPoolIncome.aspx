<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CalculateJumboPoolIncome.aspx.cs" Inherits="CalculateJumboPoolIncome" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center> <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="width: 300px; height: 25px">
            </td>
            <td style="width: 300px; height: 25px">
            </td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 28px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 600px; border-bottom: #000000 1px solid;
                height: 28px; background-color: #2881a2; text-align: center">
                <strong><span style="font-size: 10pt; color: #ffffff; font-family: Arial;">&nbsp;Calculate Cash Assure Income</span></strong></td>
            <td style="width: 100px; height: 28px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #edf0fd;
                text-align: center">
                <span style="font-size: 10pt; font-family: Arial">
                From :</span>
                <asp:TextBox ID="txtFddd" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                &nbsp; /<asp:TextBox ID="txtFmm" runat="server" MaxLength="2" Width="47px"></asp:TextBox>&nbsp;
                /
                <asp:TextBox ID="txtfyy" runat="server" MaxLength="4" Width="47px">200</asp:TextBox></td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #edf0fd;
                text-align: center">
                <span style="font-size: 10pt; font-family: Arial">
                To :</span>
                <asp:TextBox ID="txttodd" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                /
                <asp:TextBox ID="txttomm" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                /
                <asp:TextBox ID="txttoyy" runat="server" MaxLength="4" Width="47px">200</asp:TextBox></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-left: #000000 1px solid;
                border-bottom: #000000 1px solid; height: 35px; background-color: #edf0fd; text-align: center">
                <asp:Label ID="error" runat="server" ForeColor="Red" Width="238px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 25px;
                text-align: center">
                <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 35px;
                text-align: center">
                <asp:Button ID="Button1" runat="server" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px"
                    Font-Bold="True" ForeColor="White" OnClick="Button1_Click" Text="Show" />
                </td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 3px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 3px;
                text-align: center">
            </td>
            <td style="width: 100px; height: 3px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 3px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 3px;
                text-align: center">
                <table>
                    <tr>
                        <td align="left" style="width: 100px">
                            <span style="font-size: 10pt; font-family: Arial; text-align: left">
                New Join&nbsp;</span></td>
                        <td style="width: 100px">
                <asp:TextBox ID="TextBox11" runat="server" Width="100px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 100px">
                <asp:Label ID="Label8" runat="server" Text="Jpool1 Qualifiers" Width="100px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                        <td style="width: 100px">
                <asp:TextBox ID="TextBox6" runat="server" ReadOnly="True" Width="99px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 100px">
                <asp:Label ID="Label2" runat="server" Text="Jpool1" Width="100px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                        <td style="width: 100px">
                <asp:TextBox ID="TextBox1" runat="server" Width="99px"></asp:TextBox></td>
                    </tr>
                </table>
            </td>
            <td style="width: 100px; height: 3px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 3px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 3px;
                text-align: center">
            <asp:Button ID="Button2" runat="server" BackColor="#2881A2" BorderColor="Black"
                    BorderWidth="1px" Font-Bold="True" ForeColor="White" OnClick="Button2_Click"
                    Text="Submit" />&nbsp;</td>
            <td style="width: 100px; height: 3px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 3px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 3px;
                text-align: center">
                &nbsp;
                &nbsp;&nbsp;
            </td>
            <td style="width: 100px; height: 3px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 35px;
                text-align: center">
                <asp:Label ID="Label7" runat="server" Text="Successfully Completed" Width="224px" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 35px;
                text-align: center">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/admin/InsertPoolId.aspx" Font-Names="Arial" Font-Size="10pt">Add other Pool Data</asp:HyperLink>&nbsp;</td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 35px;
                text-align: center">
                &nbsp; &nbsp;
            </td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 53px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 53px;
                text-align: center">
                &nbsp;</td>
            <td style="width: 100px; height: 53px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 17px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 17px;
                text-align: center">
                </td>
            <td style="width: 100px; height: 17px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 48px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 48px;
                text-align: center">
                </td>
            <td style="width: 100px; height: 48px">
            </td>
        </tr>
    </table></center>
    </div>
    </form>
</body>
</html>
