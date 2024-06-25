<%@ Page Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="pingeneration.aspx.cs" Inherits="admin_pingeneration2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table style="width: 70%; position: relative; left: 150px; text-align: left;">
                <tr>
                    <td colspan="3" style="width: 470px">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="width: 470px">
                        <asp:Label ID="Label1" runat="server" Style="position: relative; left: 37px; top: 0px;" Text="How many pin do u want to genrate?" Width="230px"></asp:Label><asp:DropDownList ID="DropDownList1" runat="server" Style="left: 103px; position: relative; top: 1px;"
                            Width="76px">
                            <asp:ListItem>101250</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>6</asp:ListItem>
                            <asp:ListItem>7</asp:ListItem>
                            <asp:ListItem>8</asp:ListItem>
                            <asp:ListItem>9</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem>11</asp:ListItem>
                            <asp:ListItem>100000</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td style="height: 21px; width: 470px;" colspan="3">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 21px; width: 470px;">
                        <asp:ListBox ID="ListBox1" runat="server" Height="44px" Style="left: 42px; position: relative;
                            top: 2px" Visible="False" Width="28px"></asp:ListBox>
                        <asp:ListBox ID="ListBox2" runat="server" Height="31px" Style="left: 51px; position: relative;
                            top: -2px" Visible="False" Width="15px"></asp:ListBox>
                        <asp:Button ID="btnOk" runat="server" Font-Bold="True" Style="left: 145px; position: relative; top: -5px;"
                            Text="Ok" Width="127px" OnClick="btnOk_Click" /></td>
                </tr>
            </table>
</asp:Content>



