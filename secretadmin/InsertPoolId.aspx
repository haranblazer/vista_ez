<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="InsertPoolId.aspx.cs" Inherits="admin_InsertPoolId" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 819px" align="center">
        <tr align="center">
            <td colspan="3">
                <br />
                <br />
                <br />
                <br />
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<table>
                    <tr>
                        <td bordercolor="#000099" colspan="2" style="color: #ffffff; height: 17px; background-color: #2881a2">
                            &nbsp;<strong>
                Insert Pool Id </strong>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#edf0fd" style="width: 100px; height: 26px">
                <asp:Label ID="Label2" runat="server" Text="User Id" Width="136px" style="text-align: right"></asp:Label></td>
                        <td bgcolor="#edf0fd" style="width: 154px; height: 26px">
                <asp:TextBox ID="TextBox2" runat="server" style="text-align: left"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td bgcolor="#edf0fd" colspan="2">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" /></td>
                    </tr>
                    <tr>
                        <td bgcolor="#edf0fd" colspan="2" style="height: 18px">
                <asp:Label ID="Label3" runat="server" Text="label3" Width="167px"></asp:Label></td>
                    </tr>
                </table>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>

