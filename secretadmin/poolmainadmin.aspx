<%@ Page Language="C#" AutoEventWireup="true" CodeFile="poolmainadmin.aspx.cs" Inherits="solaradmin_poolmainadmin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Pool Selection List</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>
        <table style="width: 687px; height: 82px; text-align: center">
            <tr>
                <td align="center" colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                    border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                    background-color: #2881a2; text-align: center">
                    <span><span><span style="font-size: 16px"><strong><span style="color: #ffffff; font-family: Verdana">
                        Pool Selection List</span></strong></span></span></span></td>
            </tr>
            <tr>
                <td style="width: 96px; height: 47px">
                    <center>
                        <table style="width: 656px; height: 24px">
                            <tr>
                                <td style="width: 63px; height: 47px">
                                    <asp:RadioButton ID="rbtn1" runat="server" AutoPostBack="True" OnCheckedChanged="rbtn1_CheckedChanged"
                                        Text="Pool 0" /></td>
                                <td style="width: 78px; height: 47px">
                                    <asp:RadioButton ID="rbtn2" runat="server" AutoPostBack="True" OnCheckedChanged="rbtn2_CheckedChanged"
                                        Text="Pool 1" /></td>
                                <td style="width: 87px; height: 47px">
                                    <asp:RadioButton ID="rbtn3" runat="server" AutoPostBack="True" OnCheckedChanged="rbtn3_CheckedChanged"
                                        Text="Pool 2" /></td>
                                <td style="width: 87px; height: 47px">
                                    <asp:RadioButton ID="rbtn4" runat="server" AutoPostBack="True" OnCheckedChanged="rbtn4_CheckedChanged"
                                        Text="Pool 3" /></td>
                                <td style="width: 87px; height: 47px">
                                    <asp:RadioButton ID="rbtn5" runat="server" AutoPostBack="True" OnCheckedChanged="rbtn5_CheckedChanged"
                                        Text="Pool 4" /></td>
                                <td style="width: 87px; height: 47px">
                                    <asp:RadioButton ID="rbtn6" runat="server" AutoPostBack="True" OnCheckedChanged="rbtn6_CheckedChanged"
                                        Text="Pool 5" /></td>
                                <td style="width: 87px; height: 47px">
                                    <asp:RadioButton ID="rbtn7" runat="server" AutoPostBack="True" OnCheckedChanged="rbtn7_CheckedChanged"
                                        Text="Pool 6" /></td>
                            </tr>
                        </table>
                    </center>
                </td>
            </tr>
        </table>
    </center>
    </div>
    </form>
</body>
</html>
