<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="FranchiseChangePass.aspx.cs" Inherits="franchise_FranchiseChangePass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <h2 class="head">
          <i class="fa fa-key" aria-hidden="true"></i>   Change Password
        </h2>
      
    <div class="clearfix">
    </div>   
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Old Password:
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtOldPwd" runat="server" TextMode="Password" TabIndex="1" CssClass="form-control"
                MaxLength="15"></asp:TextBox>
            &nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtOldPwd"
                ErrorMessage="Please enter old password!" SetFocusOnError="True" Display="None"
                ForeColor="#C00000" ValidationGroup="cp">*</asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            New Password:</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtNewPwd" runat="server" TabIndex="2" TextMode="Password" CssClass="form-control"
                MaxLength="15"></asp:TextBox>
            &nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNewPwd"
                ErrorMessage="Please enter new password!" SetFocusOnError="True" Display="None"
                ForeColor="#C00000" ValidationGroup="cp">*</asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Confirm Password:
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtConfirmPwd" runat="server" TabIndex="3" TextMode="Password" CssClass="form-control"
                MaxLength="15"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtConfirmPwd"
                ErrorMessage="Please enter confirm password!" Height="12px" SetFocusOnError="True"
                Width="12px" Display="None" ForeColor="#C00000" ValidationGroup="cp">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtNewPwd"
                ControlToValidate="txtConfirmPwd" ErrorMessage="Confirm password does't match!"
                Height="11px" Width="14px" Display="None" ForeColor="#C00000" ValidationGroup="cp">*</asp:CompareValidator>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <div class="col-sm-2 col-xs-3">
        </div>
        <div class="col-sm-9 col-xs-9">
            <asp:Button ID="btnChangePwd" runat="server" OnClick="Button1_Click" class="btn btn-success ladda-button"
                Text="Change Password" TabIndex="4" ValidationGroup="cp" />
        </div>
    </div>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtNewPwd"
        Display="None" ErrorMessage="Only alpha numeric value without space is alloed in password!"
        ForeColor="#C00000" ValidationExpression="^[A-Za-z0-9]*$" ValidationGroup="cp"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtConfirmPwd"
        Display="None" ErrorMessage="Only alpha numeric value without space is alloed in confirm password!"
        ForeColor="#C00000" ValidationExpression="^[A-Za-z0-9]*$" ValidationGroup="cp"></asp:RegularExpressionValidator>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="cp"
        HeaderText="Please check the following..." ShowMessageBox="true" ShowSummary="false" />
</asp:Content>
