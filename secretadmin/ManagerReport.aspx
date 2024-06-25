<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ManagerReport.aspx.cs" Inherits="admin_ManagerReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
<br />
<h2>Manager Report</h2>
<hr />
    <asp:DropDownList ID="ddlManagerReport" runat="server" AutoPostBack="true">
    <asp:ListItem Value="0" Selected="True">-Select-</asp:ListItem>
    <asp:ListItem Value="1">Managers & above List</asp:ListItem>
    <asp:ListItem Value="2">Area Managers & above List</asp:ListItem>
    <asp:ListItem Value="3">District Managers & Above List</asp:ListItem>
    <asp:ListItem Value="4">Regional Managers & Above List</asp:ListItem>
    <asp:ListItem Value="5">Division Managers & Above List</asp:ListItem>
    <asp:ListItem Value="6">Zonal Managers & Above List</asp:ListItem>
    <asp:ListItem Value="7">General Managers & Above List</asp:ListItem>
    <asp:ListItem Value="8">Country Managers List</asp:ListItem>
    </asp:DropDownList>
    <br /><br />
    <h4><asp:Label ID="lblMessage" runat="server" Text="No Data"></asp:Label></h4>
</asp:Content>

