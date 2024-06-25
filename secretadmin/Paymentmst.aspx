<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Paymentmst.aspx.cs" Inherits="admin_Pamentmst"
    MasterPageFile="MasterPage.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script src="\paymentmst/paymentmst.js" type="text/javascript"></script>--%>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="css/AddCompany.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtStartDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

        });   
    </script>
    <div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="pp"
            HeaderText="Please check the following errors......" ShowMessageBox="True" ShowSummary="False"
            Height="90px" Font-Bold="True" />
    </div>
   
        <h2 class="head">
            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Edit Website</h2>
     <div class="panel panel-default">
  <div class="col-md-12">
    
    <div class="clearfix">
    </div>
    <br />
    <div class="col-md-6">
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-md-3 col-xs-3 control-label">
                <asp:Label ID="lblTDS" runat="server" Text="TDS %" CssClass="lbl"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtTDS" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-md-3 col-xs-3 control-label">
                <asp:Label ID="lblOC" runat="server" Text=" Other Charges%"></asp:Label>
            </label>
            <div class="col-md-8 col-xs-9">
                <asp:TextBox ID="txtOC" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblCompanyName" runat="server" Text="Company Name" CssClass="lbl"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblWebsite" runat="server" Text="Website" CssClass="lbl"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblCompanyHead" runat="server" Text="Company Head"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtCompanyHead" runat="server" CssClass="form-control"> </asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblCity" runat="server" Text="City" CssClass="lbl"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblCinno" runat="server" Text=" CIN No" CssClass="lbl"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtCINNO" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblNoReply" runat="server" Text="No Reply Email" CssClass="lbl"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtNoReply" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="clearfix">
        </div>
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-md-3 col-xs-3 control-label">
                <asp:Label ID="lblNonTDS" runat="server" Text="Non TDS%"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtNonTDS" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-md-3 col-xs-3 control-label">
                <asp:Label ID="lblStartDate" runat="server" Text=" Start Date"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <div class="input-group">
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblPhone" runat="server" Text="Phone"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblEmail" runat="server" Text="Email Id"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblTinno" runat="server" Text="GST No"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtGstNo" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblPANNo" runat="server" Text=" PAN No"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtPANNo" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-3 col-xs-3 control-label">
                <asp:Label ID="lblNoReplyPass" runat="server" Text="No Reply Password" CssClass="lbl"></asp:Label>
            </label>
            <div class="col-sm-8 col-xs-9">
                <asp:TextBox ID="txtNorplypass" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-sm-3 col-xs-3">
            </div>
            <div class="col-sm-3 col-xs-9">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success"
                    ValidationGroup="pp" />
            </div>
        </div>
    </div>
    <div>
        <div class="col-sm-6">
            <asp:RegularExpressionValidator ID="revTax" runat="server" ControlToValidate="txtTDS"
                Display="None" ErrorMessage="Please enter only numeric value in TDS !" ValidationExpression="^(?:\d{1,})?(?:\.\d{1,2})?$"
                ValidationGroup="pp"></asp:RegularExpressionValidator>
            <%--  <asp:RegularExpressionValidator ID="revCompanyName" runat="server" ControlToValidate="txtCompanyName"
                ErrorMessage="Please enter only alphabets in company name !" SetFocusOnError="True"
                ValidationExpression="^[a-zA-Z][a-zA-Z\s]*$" ValidationGroup="pp" Display="None"></asp:RegularExpressionValidator>--%>
            <asp:RegularExpressionValidator ID="revphone" runat="server" ControlToValidate="txtPhone"
                Display="None" ErrorMessage="Please enter valid phone number..." SetFocusOnError="True"
                ValidationExpression="^[0-9]*$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="revCompanyHead" runat="server" ControlToValidate="txtCompanyHead"
                Display="None" ErrorMessage="Please enter only alphabets in company head !" SetFocusOnError="True"
                ValidationExpression="^[a-zA-Z][a-zA-Z\s.]*$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="revCity" runat="server" ControlToValidate="txtCity"
                ErrorMessage="Please enter only alphabets allowed in city fields !" ValidationExpression="^[a-zA-Z][a-zA-Z\s]*$"
                ValidationGroup="pp" Display="None"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                Display="None" ErrorMessage="Please enter valid email id !" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                ValidationGroup="pp"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="revPan" runat="server" ControlToValidate="txtPANNo"
                Display="None" ErrorMessage="Please enter correct PAN No. !" SetFocusOnError="True"
                ValidationExpression="^[a-zA-Z]{3}(p|P|c|C|h|H|f|F|a|A|t|T|b|B|l|L|j|J|g|G)[a-zA-Z][0-9]{4}[a-zA-Z]$"
                ValidationGroup="pp"></asp:RegularExpressionValidator>
        </div>
    </div>
    </div>
    <div class="clearfix"></div>
    </div>
</asp:Content>
