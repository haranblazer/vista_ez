<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="CalculateShare.aspx.cs" Inherits="CalculateShare" Title="Untitled Page" %>
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
            <td style="width: 100px; height: 28px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 600px; border-bottom: #000000 1px solid;
                height: 28px; background-color: #2881A2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">&nbsp;Calculate Share Income</span></strong></td>
            <td style="width: 100px; height: 28px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD;
                text-align: center">
                From :
                <asp:TextBox
                    ID="txtFddd" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                &nbsp; /<asp:TextBox ID="txtFmm" runat="server" MaxLength="2" Width="47px" ></asp:TextBox>&nbsp;
                /
                <asp:TextBox ID="txtfyy" runat="server" MaxLength="4" Width="47px">200</asp:TextBox></td>
            <td style="border-right: #000000 1px solid; width: 300px; height: 35px; background-color: #EDF0FD;
                text-align: center">
                To :
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
                border-bottom: #000000 1px solid; height: 35px; background-color: #EDF0FD; text-align: center">
                <asp:Label ID="error" runat="server" ForeColor="Red" Width="238px"></asp:Label></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 25px;
                text-align: center">
                <asp:Label ID="Label1" runat="server"></asp:Label></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 35px;
                text-align: center">
                <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 3px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 3px;
                text-align: center">
                <asp:Label ID="Label4" runat="server" Text="New Joinings"></asp:Label>&nbsp;&nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label ID="Label3" runat="server" Text="Qualifiers" Width="45px"></asp:Label>
                &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
                <asp:Label ID="Label2" runat="server" Text="Share income" Width="100px"></asp:Label>
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
                &nbsp; &nbsp; &nbsp;
                <asp:Label ID="Label6" runat="server" Text="0" Width="67px"></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label ID="Label5" runat="server" Text="0"
                    Width="68px"></asp:Label>
                &nbsp;&nbsp;
                <asp:TextBox ID="TextBox1" runat="server" Width="96px" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
                &nbsp;&nbsp;
            </td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 53px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 53px;
                text-align: center">
                &nbsp;<asp:Button ID="Button2" runat="server" Text="Submit" OnClick="Button2_Click" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 100px; height: 53px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 26px;">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000;
                text-align: center; height: 26px;">
                <asp:Label ID="Label7" runat="server" Text="Successfully Completed" Width="133px"></asp:Label></td>
            <td style="width: 100px; height: 26px;">
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
    </table>
    <br />
    <br />
    <br />
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;<br />
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
</asp:Content>

