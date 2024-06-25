<%@ Page Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="ActivateUserId.aspx.cs" Inherits="admin_ActivateUserId" Title="Activate / Deactivate User ID : Admin Control" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 25%; height: 20px">
            </td>
            <td style="width: 25%; height: 20px">
            </td>
            <td style="width: 25%; height: 20px">
            </td>
            <td style="width: 25%; height: 20px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                background-color: #2881A2; text-align: center">
                <span style="font-size: 16px; color: #ffffff"><strong>Activate / Deactivate User ID's</strong></span></td>
            <td style="width: 25%; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 40px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 40px;
                text-align: center; background-color: #EDF0FD;">
                Please enter ID's No. seperated by Comma<br />
                <em>(e.g. 20080001,20080010,20080200)</em></td>
            <td style="width: 25%; height: 40px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 25px">
            </td>
            <td style="border-left: #000000 1px solid; width: 25%; height: 25px; text-align: right; background-color: #EDF0FD;">
                &nbsp;&nbsp; <strong>Select :</strong></td>
            <td style="border-right: #000000 1px solid; width: 25%; height: 25px; text-align: center; background-color: #EDF0FD;">
                    <asp:RadioButton ID="rdbDeactivate" runat="server" Checked="True"
                        GroupName="p" Text="Deactivate" />
                    &nbsp;&nbsp;
                    <asp:RadioButton ID="rdbActivate" runat="server" GroupName="p"
                        Text="Activate" /></td>
            <td style="width: 25%; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 20px">
            </td>
            <td style="border-left: #000000 1px solid; width: 25%; height: 20px; text-align: right; background-color: #EDF0FD;">
                <strong>Enter ID No :</strong></td>
            <td style="border-right: #000000 1px solid; width: 25%; height: 20px; text-align: center; background-color: #EDF0FD;">
                <br />
                <asp:TextBox ID="txtEnterId" runat="server" Height="66px"
                    TextMode="MultiLine"></asp:TextBox><br />
            </td>
            <td style="width: 25%; height: 20px">
                &nbsp;<asp:Label ID="error" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 25%; height: 25px">
            </td>
            <td colspan="2" style="border-top: #000000 1px solid; height: 25px; text-align: center">
                <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
            <td style="width: 25%; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 25%; height: 20px">
            </td>
            <td colspan="2" style="height: 20px; text-align: center">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 25%; height: 20px">
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
    <br />
    <br />
</asp:Content>

