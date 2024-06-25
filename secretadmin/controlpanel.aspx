<%@ Page Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="controlpanel.aspx.cs" Inherits="admin_controlpanel" Title="Admin User Permissions : Super Admin Control Panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
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
            <td style="width: 100px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 600px; border-bottom: #000000 1px solid;
                height: 25px; background-color: #2881A2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Admin User Permissions</span></strong></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD;
                text-align: right">
                Pin Generation &nbsp; :</td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD">
                &nbsp;
                <asp:CheckBox ID="CheckBox1" runat="server"  /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #ffffff;
                text-align: right">
                Change Profile &nbsp; :</td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #ffffff">
                &nbsp;
                <asp:CheckBox ID="CheckBox2" runat="server"  /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD;
                text-align: right">
                Payout &nbsp; :</td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD">
                &nbsp;
                <asp:CheckBox ID="CheckBox3" runat="server"  /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #ffffff;
                text-align: right">
                Awards &nbsp; :</td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #ffffff">
                &nbsp;
                <asp:CheckBox ID="CheckBox4" runat="server"  /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD;
                text-align: right">
                Reports &nbsp; :</td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD">
                &nbsp;
                <asp:CheckBox ID="CheckBox5" runat="server"  /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #ffffff;
                text-align: right">
                Change Password &nbsp; :</td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #ffffff">
                &nbsp;
                <asp:CheckBox ID="CheckBox6" runat="server"  /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD;
                text-align: right">
                Activate / De-activate ID &nbsp; :</td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD">
                &nbsp;
                <asp:CheckBox ID="CheckBox7" runat="server" /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; border-bottom: #000000 1px solid;
                height: 35px; background-color: #ffffff; text-align: right">
                News &nbsp; :</td>
            <td style="border-right: #000000 1px solid; width: 300px; border-bottom: #000000 1px solid;
                height: 35px; background-color: #ffffff">
                &nbsp;
                <asp:CheckBox ID="CheckBox16" runat="server"/></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="height: 35px; background-color: #ffffff; text-align: center;
                border-right-width: 1px; border-right-color: #000000">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#2881A2" Width="150px"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="height: 35px; background-color: #ffffff; text-align: center;
                border-right-width: 1px; border-right-color: #000000">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="height: 35px; background-color: #ffffff; text-align: center;
                border-right-width: 1px; border-right-color: #000000">
                <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" NavigateUrl="~/admin/control1.aspx">Back</asp:HyperLink></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>

