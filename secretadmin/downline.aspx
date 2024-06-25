<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="downline.aspx.cs" Inherits="admin_downline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <script >

            $(document).ready(function() {
            $('#<%=txtRegNo.ClientID %>').autocomplete(document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(","));
            });
       
    </script> <div id="title" class="b2">
        <h2>
            Downline</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <center>
        <table >
            <tr>
                <td class="top_table">
                   User Id:</td>
                <td class="top_table">
                    <asp:TextBox ID="txtRegNo" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="bottom_table">
                    Payout Number:</td>
                <td class="bottom_table">
                    <asp:TextBox ID="txtPayoutNo" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:Button ID="BtnSubmit" runat="server" OnClick="BtnSubmit_Click" Text="Submit"
                        ValidationGroup="v" CssClass="btn" /></td>
            </tr>
            <tr>
                <td class="alignr">
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table></center><div id="divUserID" style="display: none;" runat="server">
                        </div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtRegNo"
            Display="None" ErrorMessage="Please enter user id!" ValidationGroup="v"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtPayoutNo" Display="None"
                ErrorMessage="Please enter payout no!" ValidationGroup="v"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                    ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtRegNo"
                    Display="None" ErrorMessage="Only alpha numeric value is allowed !" ValidationExpression="^[a-zA-Z0-9]*"
                    ValidationGroup="v"></asp:RegularExpressionValidator><asp:RegularExpressionValidator
                        ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtPayoutNo"
                        Display="None" ErrorMessage="Only numeric value is allowed !" ValidationExpression="^[0-9]*"
                        ValidationGroup="v"></asp:RegularExpressionValidator><asp:ValidationSummary ID="ValidationSummary1"
                            runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="v" />
        



</asp:Content>
