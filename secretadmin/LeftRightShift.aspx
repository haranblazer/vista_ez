<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="LeftRightShift.aspx.cs" Inherits="admin_LeftRightShift" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table align="center" border="1" bordercolor="black" cellpadding="1" cellspacing="1"
        style="width: 84%; height: 211px">
        <tr align="center" colspan="2">
            <td align="center" colspan="5" style="height: 20px; text-align: left">
                <strong><span style="font-size: 10pt; font-family: Verdana" class=" ">&nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; Left Right Shift &amp; Sponser Id Change</span></strong></td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 12px; text-align: left" valign="top">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                Enter User IdNo.<asp:TextBox ID="idno" runat="server"
                    Style="z-index: 100; left: 23px; position: relative;
                    top: 0px"></asp:TextBox>
                <asp:Button ID="Button2" runat="server" Font-Bold="True" Style="z-index: 101; left: -96px;
                    position: relative; top: 126px" Text="Ok" Width="184px" OnClick="Button2_Click" />
                <asp:Label ID="error" runat="server" Font-Bold="True" ForeColor="Red" Style="position: relative;" Width="54px"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="idno"
                    ErrorMessage="RequiredFieldValidator" Font-Bold="True" Style="z-index: 103; left: -213px;
                    position: relative; top: 0px">**</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: left"
                valign="top">
                &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; Select Any One<asp:RadioButton ID="leftrightradio"
                    runat="server" AutoPostBack="True" Checked="True" GroupName="a"
                    Style="z-index: 100; left: 29px; position: relative; top: 0px" Text="Left / Right" />&nbsp;<asp:RadioButton
                        ID="RadioButton2" runat="server" AutoPostBack="True" GroupName="a"
                        Style="z-index: 102; left: 42px; position: relative; top: 0px" Text="Sponser Id" /></td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: left" valign="top">
                <asp:Label ID="Label3" runat="server" Style="z-index: 100; left: 47px; position: relative;
                    top: 0px" Text="Choose One"></asp:Label>
                <asp:DropDownList ID="DDleftright" runat="server" Style="z-index: 101; left: 88px; position: relative; top: 0px">
                    <asp:ListItem>Left</asp:ListItem>
                    <asp:ListItem>Right</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="Label4" runat="server" Style="z-index: 102; left: 130px; position: relative;
                    top: 0px" Text="Enter New Sponser Id."></asp:Label>
                <asp:TextBox ID="sponserid" runat="server" Style="z-index: 103; left: 136px; position: relative;
                    top: 1px" OnTextChanged="sponserid_TextChanged" Width="130px"></asp:TextBox>&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="sponserid"
                    ErrorMessage="**" Font-Bold="True" Style="z-index: 106; left: 135px; position: relative;
                    top: 0px">**</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: center" valign="top">
                <!-- Donor = 869,&nbsp;&nbsp;Chairman Club = 0,-->
                </td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: left"
                valign="middle">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="center" colspan="5" style="height: 18px; text-align: center" valign="top">
                </td>
        </tr>
    </table>

</asp:Content>


