<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="IncRegId.aspx.cs" Inherits="admin_IncRegId" Title="Increase Registration ID : Admin Control" %>
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
                <strong><span style="font-size: 16px; color: #ffffff">Increase Registration ID</span></strong></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-top-color: #000000; border-bottom: #000000 1px solid; height: 35px;
                background-color: #EDF0FD; text-align: center">
                    Enter Registration No. :
                <asp:TextBox ID="TextBox1" runat="server" Style="z-index: 100;
                        left: 38px; position: relative; top: 0px"></asp:TextBox></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; width: 600px; border-top-color: #000000;
                height: 35px; text-align: center; border-right-width: 1px; border-right-color: #000000">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="SUBMIT" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
    </table>
    
</asp:Content>

