<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="GeneratePin.aspx.cs" Inherits="tohadmin_GeneratePin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="title" class="b2">
        <h2>
            Generate Pin
        </h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <table style="width: 100%;">
        <tr>
            <td>
                <table style="width: 100%;">
                    <tr id="trtxt" runat="server">
                        <td class="top_table">
                            Enter number of pins .&nbsp; :&nbsp;&nbsp;
                            <asp:TextBox ID="txtNo" runat="server" onkeypress="return Checknumeric()" 
                                MaxLength="4"></asp:TextBox>
                            &nbsp;
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" TabIndex="13" ValidationGroup="gp" CssClass="btn" />&nbsp;
                                <asp:Button ID="btnSoldPins" runat="server" TabIndex="13" CssClass="btn" OnClick="btnSoldPins_Click" />&nbsp;
                            <asp:Button ID="btnUnSoldPins" runat="server" TabIndex="13" CssClass="btn" OnClick="btnUnSoldPins_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="1" style="text-align: center">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNo"
                    Display="None" ErrorMessage="Please enter number of pinas!" ForeColor="#C00000"
                    ValidationGroup="gp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNo"
                    Display="None" ErrorMessage="Only numeric value is allowed!" ForeColor="#C00000"
                    ValidationGroup="gp" ValidationExpression="^[0-9]*"></asp:RegularExpressionValidator>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="gp"
                    ShowMessageBox="true" ShowSummary="false" />
            </td>
        </tr>
    </table>

   

</asp:Content>
