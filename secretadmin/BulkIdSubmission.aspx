<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="BulkIdSubmission.aspx.cs" Inherits="admin_BulkIdSubmission" Title="Untitled Page" %>
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
                <strong><span style="font-size: 16px; color: #ffffff">Bulk ID Submission</span></strong></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 40px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                height: 40px; background-color: #EDF0FD; text-align: center">
                <strong>Write Down Qualifiying User ID's<br />
                </strong>(use comma between ID's)</td>
            <td style="width: 100px; height: 40px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 169px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                height: 169px; background-color: #EDF0FD; text-align: center">
                <asp:TextBox ID="TextBox2" runat="server" Height="154px" TextMode="MultiLine" Width="443px" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                    ErrorMessage="**" Width="20px"></asp:RequiredFieldValidator></td>
            <td style="width: 100px; height: 169px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 33px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                border-bottom: #000000 1px solid; height: 35px; background-color: #EDF0FD; text-align: center">
                Enter Closing No. -
                <asp:TextBox
                    ID="TextBox1" runat="server"  Style="position: relative"
                    Width="103px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                        runat="server" ControlToValidate="TextBox1" ErrorMessage="RequiredFieldValidator"
                        Width="24px">**</asp:RequiredFieldValidator><asp:Label ID="Label2" runat="server" Width="73px"></asp:Label></td>
            <td style="width: 100px; height: 33px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left-width: 1px; border-left-color: #000000; width: 600px; height: 35px;
                text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:Label ID="Label1" runat="server"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 36px">
            </td>
            <td style="border-left-width: 1px; border-left-color: #000000; width: 600px; height: 36px;
                text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click1" Text="Submit" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 100px; height: 36px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 36px">
            </td>
            <td style="border-left-width: 1px; border-left-color: #000000; width: 600px; height: 36px;
                text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/admin/SelectQualifyingGrowthId.aspx">Back</asp:HyperLink></td>
            <td style="width: 100px; height: 36px">
            </td>
        </tr>
    </table>
    <br />
</asp:Content>

