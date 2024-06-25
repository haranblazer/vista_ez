<%@ Page Language="C#"  AutoEventWireup="true" MasterPageFile="MasterPage.master"  CodeFile="thanks.aspx.cs" Inherits="user_newjoins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

 <div id="title" class="b2">
        <h2>
            Welcome
        </h2>
        <hr />
    </div>
  
    <div class="tahks">
        <table style="width:100%;">
            <tr>
                <td style="width:35%;">
                    Your Id:
                </td>
                <td style="width:65%;">
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
        <asp:Button ID="btnSubmit" runat="server" Text="Back" CssClass="btn"
            OnClick="btnSubmit_Click" />
        
    </div>
</asp:Content>
