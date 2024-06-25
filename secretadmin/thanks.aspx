<%@ Page Language="C#"  AutoEventWireup="true" MasterPageFile="MasterPage.master"  CodeFile="thanks.aspx.cs" Inherits="user_newjoins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <center>
     <a href="ExpressSignUp.aspx" style="color: #000;">Back </a>
        <input type="button" value="Print this page" onclick="printpage()"/>
        
    </center>
<div style=" margin-left: auto; margin-right: auto; width: 700px;">
        <div id="invoicereg" runat="server">
        </div>
    </div>

      
    <table style="width: 100%; display: none;">
        <tr>
            <td style="width: 35%;">
                Your Id:
            </td>
            <td style="width: 65%;">
                <asp:Label ID="lblUserid" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Sponsor id:
            </td>
            <td>
                <asp:Label ID="lblSponsorId" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Your Password:
            </td>
            <td>
                <asp:Label ID="lblpassword" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Tran Password:
            </td>
            <td>
                <asp:Label ID="lblTranPwd" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Name:
            </td>
            <td>
                <asp:Label ID="lblname" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Mobile No
            </td>
            <td>
                <asp:Label ID="lblMobileNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                E-Mail Id:
            </td>
            <td>
                <asp:Label ID="LblEMailId" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <center>
        <a href="ExpressSignUp.aspx" style="color: #000;">Back </a>
        <input type="button" value="Print this page" onclick="printpage()"/>
        
    </center>
</asp:Content>
