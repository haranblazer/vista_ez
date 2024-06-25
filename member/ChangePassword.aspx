<%@ Page Title="" Language="C#" MasterPageFile="~/member/member.master" AutoEventWireup="true" 
    CodeFile="ChangePassword.aspx.cs" Inherits="member_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
        HeaderText="Please Check Following Problems:" ShowMessageBox="true" ShowSummary="false"
        ValidationGroup="v" />

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Change Password</h4>

    </div>



    <div class="form-group card-group-row row">

        <div class="col-md-3">
            <asp:TextBox ID="txtOldPwd" runat="server" MaxLength="30" CssClass="form-control" placeholder="Type Current Password" TextMode="Password" pattern="/^[ A-Za-z0-9()[\]+-*/%]*$/" title="Current Password must contain letters and numbers." required="required"></asp:TextBox>
            <%-- <asp:RequiredFieldValidator ID="rfvOldPwd" runat="server" ControlToValidate="txtOldPwd"
                                                        ErrorMessage="Current Password" Width="1px" Display="None" ValidationGroup="v">**</asp:RequiredFieldValidator>--%>
            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtOldPwd"
                                                        Display="none" ErrorMessage="Invalid Current Password!" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9]*"
                                                        ValidationGroup="v">*</asp:RegularExpressionValidator>--%>
        </div>

        <div class="col-md-3 ">
            <asp:TextBox ID="txtNewPwd" runat="server" MaxLength="30" CssClass="form-control" placeholder="Type New Password" TextMode="Password" pattern="/^[ A-Za-z0-9()[\]+-*/%]*$/" title="New Password must contain letters and numbers." required="required"></asp:TextBox>

            <%--<asp:RequiredFieldValidator ID="rfvNewPwd" runat="server" ControlToValidate="txtNewPwd"
                                                        ErrorMessage="New Password" Width="1px" Display="None" ValidationGroup="v">**</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtNewPwd"
                                                        Display="none" ErrorMessage="Invalid New Password!" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9]*"
                                                        ValidationGroup="v">*</asp:RegularExpressionValidator>--%>
        </div>

        <div class="col-md-3 ">
            <asp:TextBox ID="txtConfirmPwd" runat="server" MaxLength="30" CssClass="form-control" placeholder="Confirm New Password" TextMode="Password" pattern="/^[ A-Za-z0-9()[\]+-*/%]*$/" title="Confirm New Password must contain letters and numbers." required="required"></asp:TextBox>

            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirmPwd"
                                                        ErrorMessage="Confirm Password" Width="1px" Display="None" ValidationGroup="v">**</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtConfirmPwd"
                                                        Display="none" ErrorMessage="Invalid Confirm Password!" SetFocusOnError="True"
                                                        ValidationExpression="^[a-zA-Z0-9]*" ValidationGroup="v">*</asp:RegularExpressionValidator>   --%>
        </div>

        <div class="col-md-2">
            <asp:Button ID="ImageButton1" runat="server" OnClick="ImageButton1_Click" CssClass="btn btn-primary"
                Text="Submit" />
            <br />
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtNewPwd"
                ControlToValidate="txtConfirmPwd" CultureInvariantValues="True" ErrorMessage="Password Not Matched!"
                Font-Bold="True" Width="150px" ValidationGroup="v" ForeColor="White">Password Not Matched!</asp:CompareValidator>
            <br />
            <%--<asp:Label ID="lblerror" runat="server" Font-Bold="True" ForeColor="#81991E"></asp:Label>--%>
        </div>

    </div>
</asp:Content>

