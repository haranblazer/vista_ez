<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="ChangeFProfile.aspx.cs" Inherits="admin_ChangeFProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


        <h2 class="head">
            <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;Update Franchise Profile</h2>
  
<div class="panel panel-default">
<div class="col-md-12">
       <asp:Panel ID="pnlProfile" runat="server" DefaultButton="Button1">
        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
                Please Enter Id No.:</label>
            <div class="col-sm-2 col-xs-9">
                <asp:TextBox ID="txtfrno" runat="server" CssClass="form-control" TabIndex="1"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 col-xs-3 btn3">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" TabIndex="2"
                    CssClass="btn  btn-success" ValidationGroup="s" />
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Names="Arial"></asp:Label>
            </div>
        </div>
        <table style="width: 100%">
            <tr>
                <td style="vertical-align: top; text-align: center;">
                    &nbsp;&nbsp;
                    <asp:RequiredFieldValidator ID="rfvFID" runat="server" ControlToValidate="txtfrno"
                        Display="None" SetFocusOnError="true" ErrorMessage="Please Enter Franchise Id !" Font-Names="Arial"
                        Font-Size="10pt" ForeColor="#C00000" ValidationGroup="s"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="rreFID" runat="server" ControlToValidate="txtfrno"
                        SetFocusOnError="true" ErrorMessage="Only aplhanumeric value is allowed !" ValidationExpression="^[A-Za-z0-9]*$"
                        Display="None" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" ValidationGroup="s"></asp:RegularExpressionValidator>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="s"
                        ShowMessageBox="true" ShowSummary="false" HeaderText="Please check the following errors..." />
                </td>
            </tr>
        </table>
    </asp:Panel>
    </div>
    <div class="clearfix"></div>
    </div>
</asp:Content>

