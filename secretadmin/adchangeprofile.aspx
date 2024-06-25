<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="adchangeprofile.aspx.cs" Inherits="admin_adchangeprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
    <h4 class="fs-20 font-w600  me-auto">Profile</h4>
    </div>

  
<asp:Panel ID="pnlProfile" runat="server" DefaultButton="Button1">
        <div class="row">
         
            <div class="col-sm-4 ">
                <asp:TextBox ID="txtRegNo" runat="server" CssClass="form-control" TabIndex="1" placeholder=" Please Enter Id No."></asp:TextBox>
            </div>
       
            <div class="col-sm-2 col-xs-3 ">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" TabIndex="2"
                    CssClass="btn  btn-primary" ValidationGroup="s" />
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Names="Arial"></asp:Label>
            </div>
        </div>

        <table style="width: 100%">
            <tr>
                <td style="vertical-align: top; text-align: center;">
                    &nbsp;&nbsp;
                    <asp:RequiredFieldValidator ID="rfvUserID" runat="server" ControlToValidate="txtRegNo"
                        Display="None" SetFocusOnError="true" ErrorMessage="Please Enter User Id !" Font-Names="Arial"
                        Font-Size="10pt" ForeColor="#C00000" ValidationGroup="s"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revUserId" runat="server" ControlToValidate="txtRegNo"
                        SetFocusOnError="true" ErrorMessage="Only aplhanumeric value is allowed !" ValidationExpression="^[A-Za-z0-9]*$"
                        Display="None" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" ValidationGroup="s"></asp:RegularExpressionValidator>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="s"
                        ShowMessageBox="true" ShowSummary="false" HeaderText="Please check the following errors..." />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
