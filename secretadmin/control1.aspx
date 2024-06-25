<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="control1.aspx.cs" Inherits="admin_control1" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="width: 600px; height: 25px">
            </td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Super Admin Control Panel</span></strong></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-top-color: #000000; border-bottom: #000000 1px solid; height: 25px;
                text-align: center">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="600px">
                    <Columns>
                        <asp:BoundField DataField="UserName" HeaderText="UserName" />
                        <asp:BoundField DataField="Password" HeaderText="Password" />
                        <asp:HyperLinkField   HeaderText="Allow/Deny" DataNavigateUrlFields="userName" DataNavigateUrlFormatString="controlpanel.aspx?n={0}"  Text="Permission" />
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EDF0FD" />
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; width: 600px; border-top-color: #000000;
                height: 35px; text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:Button ID="Button1" runat="server" Text="Show All User" OnClick="Button1_Click" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" />&nbsp;
                <asp:Button ID="Button2" runat="server" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px"
                    Font-Bold="True" ForeColor="White" PostBackUrl="~/admin/AddUser.aspx" Text="Add New User" /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
    </table>
    <br />
</asp:Content>

