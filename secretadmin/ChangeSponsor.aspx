<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="ChangeSponsor.aspx.cs" Inherits="admin_ChangeSponsor" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 5%; height: 35px">
            </td>
            <td style="width: 600px; height: 25px">
            </td>
            <td style="width: 600px; height: 25px">
            </td>
            <td style="width: 5%">
            </td>
        </tr>
        <tr>
            <td style="width: 5%; height: 35px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                background-color: #2881a2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Change Sponsor I.D</span></strong></td>
            <td style="width: 5%">
            </td>
        </tr>
        <tr>
            <td style="width: 5%; height: 35px">
            </td>
            <td style="border-top-width: 1px; padding-left: 95px; font-weight: bold; font-size: 12px;
                border-bottom-width: 1px; border-bottom-color: #000000; vertical-align: middle;
                border-left: #000000 1px solid; width: 45%; color: #000000; border-top-color: #000000;
                height: 35px; background-color: #edf0fd; text-align: left; border-right-width: 1px;
                border-right-color: #000000">
                <strong>Enter Registration &nbsp;No.</strong>&nbsp;</td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; padding-left: 95px;
                font-weight: bold; border-left-width: 1px; font-size: 12px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; vertical-align: middle;
                width: 45%; color: #000000; border-top-color: #000000; height: 35px; background-color: #edf0fd;
                text-align: left">
                <asp:TextBox ID="regno" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="regno"
                    ErrorMessage="**" Font-Bold="True">**</asp:RequiredFieldValidator></td>
            <td style="width: 5%">
            </td>
        </tr>
        <tr>
            <td style="width: 5%; height: 35px">
            </td>
            <td style="border-top-width: 1px; padding-left: 95px; font-weight: bold; font-size: 12px;
                border-bottom-width: 1px; border-bottom-color: #000000; vertical-align: middle;
                border-left: #000000 1px solid; width: 45%; color: #000000; border-top-color: #000000;
                height: 35px; background-color: #edf0fd; text-align: left; border-right-width: 1px;
                border-right-color: #000000">
                Enter New Sponsor I.D</td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; padding-left: 95px;
                font-weight: bold; border-left-width: 1px; font-size: 12px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; vertical-align: middle;
                width: 45%; color: #000000; border-top-color: #000000; height: 35px; background-color: #edf0fd;
                text-align: left">
                <asp:TextBox ID="newsponsor" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="newsponsor"
                    ErrorMessage="**">**</asp:RequiredFieldValidator></td>
            <td style="width: 5%">
            </td>
        </tr>
        <tr>
            <td style="width: 5%; height: 35px">
            </td>
            <td colspan="2" style="border-top-width: 1px; padding-left: 95px; font-weight: bold;
                font-size: 12px; border-bottom-width: 1px; border-bottom-color: #000000; vertical-align: middle;
                border-left: #000000 1px solid; color: #000000; border-top-color: #000000; height: 35px;
                background-color: #edf0fd; text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:Label ID="Ok" runat="server"></asp:Label></td>
            <td style="width: 5%">
            </td>
        </tr>
        <tr>
            <td style="width: 5%; height: 35px">
            </td>
            <td colspan="2" style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; border-top-color: #000000;
                height: 35px; text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:Button ID="btnActivate" runat="server" BackColor="#2881A2" BorderColor="Black"
                    BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" OnClick="btnActivate_Click"
                    Style="background-image: url(admin_images/btn_bg.gif)" Text="Change" Width="70px" /></td>
            <td style="width: 5%">
            </td>
        </tr>
    </table>
</asp:Content>

