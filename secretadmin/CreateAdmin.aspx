<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="CreateAdmin.aspx.cs" Inherits="admin_CreateAdmin" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <%--    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>--%>


    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">New User Creation</h4>
    </div>


    <div class="row">
        <div class="col-md-2 control-label">
            Name :
        </div>
        <div class="col-md-4 ">
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                Display="None" ErrorMessage="Please enter name!" Font-Bold="False" Font-Names="Arial"
                ForeColor="#C00000" ValidationGroup="CA"></asp:RequiredFieldValidator>
        </div>



        <div class="col-md-2 control-label">
            Login id :
        </div>
        <div class="col-md-4 ">
            <asp:TextBox ID="txtLogInId" runat="server" onkeypress="return CheckAlpha()" MaxLength="20"
                CssClass="form-control" placeholder="Login id"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLogInId"
                Display="None" ErrorMessage="Please enter desired login id!" Font-Bold="False"
                Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" ValidationGroup="CA"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtLogInId"
                Display="None" ErrorMessage="Please enter alpha numeric login id!" ForeColor="#C00000"
                ValidationExpression="^[A-Za-z0-9]*" Font-Bold="False" Font-Names="Arial" Font-Size="10pt"
                ValidationGroup="CA"></asp:RegularExpressionValidator>
        </div>



        <div class="col-md-2 control-label">
            Mobile No:
        </div>
        <div class="col-md-4 ">
            <asp:TextBox ID="txtmobile" runat="server" MaxLength="15" placeholder="Mobile no" CssClass="form-control"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtmobile"
                Display="None" ErrorMessage="Please enter Mobile No!" Font-Bold="False" Font-Names="Arial"
                Font-Size="10pt" ForeColor="#C00000" ValidationGroup="CA"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtmobile"
                Display="None" ErrorMessage="Please Enter Valid Mobile No." ForeColor="#C00000"
                ValidationExpression="^[789]\d{9}$" Font-Bold="False" Font-Names="Arial" Font-Size="10pt"
                ValidationGroup="CA"></asp:RegularExpressionValidator>
        </div>



        <div class="col-md-2 control-label">
            State:
        </div>
        <div class="col-md-4 ">
            <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="ContryExp" runat="server" ControlToValidate="DdlState"
                SetFocusOnError="true" ErrorMessage="Please Select State!" ForeColor="#C00000"
                InitialValue="0" ValidationGroup="CA"></asp:RequiredFieldValidator>
        </div>



        <div class="col-md-2 control-label">
            User Role:
        </div>
        <div class="col-md-4 ">
            <asp:DropDownList ID="ddl_UserRole" runat="server" CssClass="form-control">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddl_UserRole"
                SetFocusOnError="true" ErrorMessage="Please Select User Role!" ForeColor="#C00000"
                InitialValue="0" ValidationGroup="CA"></asp:RequiredFieldValidator>
        </div>

        <div class="col-md-2 control-label">
            Password:
        </div>
        <div class="col-md-4 ">
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"
                pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$" title="Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"
                required="required" CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPassword"
                Display="None" ErrorMessage="Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character" Font-Bold="False" Font-Names="Arial"
                Font-Size="10pt" ForeColor="#C00000" ValidationGroup="CA"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPassword"
                Display="None" ErrorMessage="Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character" ForeColor="#C00000"
                ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$" Font-Bold="False" Font-Names="Arial" Font-Size="10pt"
                ValidationGroup="CA"></asp:RegularExpressionValidator>
        </div>


        <div class="clearfix"></div>
        <div class="col-md-2 control-label d-none">
            Region:
        </div>
        <div class="col-md-4 d-none">
            <asp:DropDownList ID="ddl_Region" runat="server" CssClass="form-control"
                AutoPostBack="true" OnSelectedIndexChanged="ddl_Region_SelectedIndexChanged">
            </asp:DropDownList>
        </div>


        <div class="col-md-2 control-label d-none">
            Region State:
        </div>
        <div class="col-md-4 d-none">

            <asp:UpdatePanel ID="RegionStatepanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:DropDownList ID="ddl_RegionState" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddl_Region" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>



        <div class="clearfix"></div>
        <div class="col-md-12">
            <div class="alert alert-primary alert-dismissible fade show">

                <strong>Note!</strong> <span style="color: red;">Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character</span></a>)
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
            </div>
        </div>
        <div class="col-md-2">
        </div>
        <div class="col-md-3 ">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" CssClass="btn btn-primary"
                Text="Submit" ValidationGroup="CA" />
        </div>


        <div class="col-md-3 ">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ValidationGroup="CA" ShowSummary="False" />
        </div>
    </div>

    <%--  </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
