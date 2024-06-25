<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="RankCalc.aspx.cs" Inherits="admin_RankCalc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <table width="100%">
        <tr>
            <td style="padding-left: 20px; font-size: medium;">
                <b>Calculate Rank </b>
            </td>
        </tr>
        <tr>
            <td>
                <hr />
            </td>
        </tr>
        <tr>
            <td style="padding-left: 50px;">
                Last Calculate Rank :
                <asp:Label ID="lblmsg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="padding-left: 180px;">
                <asp:Button ID="btnSubmit" runat="server" Text="SUBMIT" 
                    OnClientClick="if (!confirm('Are you sure for calculate rank ?')) return false;" 
                    onclick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
