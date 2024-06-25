<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="adminchangepassword.aspx.cs" Inherits="admin_adminchangepassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Password settings</h4>
    </div>


    <div class="row">

        <div class="col-sm-3 ">
            <asp:TextBox ID="txtOldPwd" runat="server" TextMode="Password" TabIndex="1" CssClass="form-control"
                MaxLength="15" placeholder="Enter Current Password" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$"
                title="Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtOldPwd"
                ErrorMessage="Please enter current password!" SetFocusOnError="True" Display="None"
                ForeColor="#C00000" ValidationGroup="cp">*</asp:RequiredFieldValidator>
        </div>


        <div class="col-sm-3">
            <asp:TextBox ID="txtNewPwd" runat="server" TabIndex="2" TextMode="Password" CssClass="form-control"
                MaxLength="15" placeholder="Enter New Password"
                pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$"
                title="Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNewPwd"
                ErrorMessage="Please enter new password!" SetFocusOnError="True" Display="None"
                ForeColor="#C00000" ValidationGroup="cp">*</asp:RequiredFieldValidator>
        </div>


        <div class="col-sm-3">
            <asp:TextBox ID="txtConfirmPwd" runat="server" CssClass="form-control" TabIndex="3"
                TextMode="Password" MaxLength="15" placeholder="Enter Confirm New Password" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$"
                title="Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtConfirmPwd"
                ErrorMessage="Please enter confirm password!" Height="12px" SetFocusOnError="True"
                Width="12px" Display="None" ForeColor="#C00000" ValidationGroup="cp">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtNewPwd"
                SetFocusOnError="true" ControlToValidate="txtConfirmPwd" ErrorMessage="Confirm password does't match!"
                Height="11px" Width="14px" Display="None" ForeColor="#C00000" ValidationGroup="cp">*</asp:CompareValidator>
        </div>


        <div class="col-sm-2 ">
            <asp:Button ID="btnChangePwd" runat="server" OnClick="Button1_Click" CssClass="btn btn-primary"
                Text="Change Password" TabIndex="4" ValidationGroup="cp" />
        </div>
    </div>
    <div class="col-md-12">
        <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtNewPwd"
            SetFocusOnError="true" Display="None" ErrorMessage="Password must contain: Minimum 8 characters atleast 1 UpperCase Alphabet, 1 LowerCase Alphabet, 1 Number and 1 Special Character"
            ForeColor="#C00000" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}" ValidationGroup="cp"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtConfirmPwd"
            SetFocusOnError="true" Display="None" ErrorMessage="Password must contain: Minimum 8 characters atleast 1 UpperCase Alphabet, 1 LowerCase Alphabet, 1 Number and 1 Special Character"
            ForeColor="#C00000" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}" ValidationGroup="cp"></asp:RegularExpressionValidator>--%>

        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="cp" ShowMessageBox="true"
            ShowSummary="false" HeaderText="Please correct the following errors..." />
    </div>

</asp:Content>
