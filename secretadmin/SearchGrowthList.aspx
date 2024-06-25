<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="SearchGrowthList.aspx.cs" Inherits="admin_DeselectGrowthList" Title="Growth List : Admin Control Panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 700px; height: 25px">
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Growth List</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 700px;
                border-bottom: #000000 1px solid; height: 35px; background-color: #EDF0FD; text-align: center">
                Enter Closing No. <asp:TextBox ID="TextBox2" runat="server"
                        Style="position: relative" Width="103px" OnTextChanged="TextBox2_TextChanged"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                    ErrorMessage="RequiredFieldValidator">**</asp:RequiredFieldValidator></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px">
            </td>
            <td style="border-bottom-width: 1px; border-bottom-color: #000000; width: 700px;
                text-align: center">
                <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="TextBox2"
                    ErrorMessage="Enter Value Between 1 to 12" MaximumValue="12" MinimumValue="1"
                    Type="Integer" Width="183px"></asp:RangeValidator></td>
            <td style="width: 50px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-bottom-width: 1px; border-bottom-color: #000000; width: 700px;
                height: 35px; text-align: center">
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click1" Text="Submit" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 16px">
            </td>
            <td style="border-bottom-width: 1px; border-bottom-color: #000000; width: 700px;
                height: 16px; text-align: center">
                <asp:Label ID="Label1" runat="server" Width="107px" Font-Bold="True" ForeColor="Red"></asp:Label><asp:Label ID="Label4" runat="server" Width="129px" Font-Bold="True" ForeColor="Black"></asp:Label></td>
            <td style="width: 50px; height: 16px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 35px; text-align: center">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                    BorderColor="Black" BorderWidth="1px" CellPadding="4" DataKeyNames="UserId"
                    ForeColor="#333333" GridLines="None" OnPageIndexChanging="GridView1_PageIndexChanging1"
                    PageSize="25" Width="700px" Height="20px">
                    <Columns>
                        <asp:BoundField DataField="UserId" HeaderText="UserId" />
                        <asp:BoundField DataField="FName" HeaderText="Name" />
                        <asp:BoundField DataField="ClosingNo" HeaderText="Closing No" />
                        <asp:BoundField DataField="SID" HeaderText="Sponser Id" />
                        <asp:BoundField DataField="joinfor" HeaderText="Joinfor" />
                    </Columns>
                    <RowStyle BackColor="#EDF0FD" />
                    <PagerStyle BackColor="#69B5D1" ForeColor="Black" />
                    <HeaderStyle BackColor="#69B5D1" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
    </table>
    <br />
</asp:Content>

