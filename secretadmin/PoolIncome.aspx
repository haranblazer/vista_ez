<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="PoolIncome.aspx.cs" Inherits="secretadmin_PoolIncome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <script type="text/javascript">
        function validateAndConfirm(message) {
            var validated = Page_ClientValidate('show');
            if (validated) {
                return confirm(message);
            }
        }
    
    </script>
    <div style="padding: 15px 0px 0px 15px;">
        <h2 class="head">
            <i class="fa fa-money" aria-hidden="true"></i>&nbsp;Create Pool Income</h2>
            <br />
    </div>
    <div>
        <div class="form-group">
            <div class="col-md-1">
                <strong>From </strong>
            </div>
            <div class="col-md-2">
                <div class="input-group">
                    <asp:TextBox ID="txtFromDate" runat="server" BackColor="White" CssClass="form-control"
                        MaxLength="10" placeholder="DD/MM/YYYY" ValidationGroup="show" ToolTip="Date of Birth format should be DD/MM/YYYY"></asp:TextBox>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-1">
                <strong>To </strong>
            </div>
            <div class="col-md-2">
                <div class="input-group">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                        MaxLength="10" ValidationGroup="show" ToolTip="Date of Birth format should be DD/MM/YYYY"
                        BackColor="White"></asp:TextBox>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-3">
                <asp:Button ID="Button3" runat="server" Text="Click Here To Make Pool Income" OnClick="Button3_Click"
                    OnClientClick="return validateAndConfirm('Do you really want to make pool income?')"
                    CssClass="btn-success btn" ValidationGroup="show" />
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-md-6">
                <asp:Label ID="lblLastPayoutDate" runat="server" Font-Bold="True" Font-Names="Arial"></asp:Label>
            </div>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="show"
        SetFocusOnError="true" ControlToValidate="txtFromDate" Display="None" ErrorMessage="Please enter from date!"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
        ControlToValidate="txtFromDate" ErrorMessage="Please enter date in dd/mm/yyyy format!"
        Font-Bold="False" ForeColor="#C00000" ValidationExpression="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
        ValidationGroup="show" Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="show"
        SetFocusOnError="true" ControlToValidate="txtToDate" Display="None" ErrorMessage="Please enter to date!"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtToDate"
        ErrorMessage="Please enter date in dd/mm/yyyy format!" Font-Bold="False" ForeColor="#C00000"
        ValidationExpression="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
        ValidationGroup="show" Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
        HeaderText="Please correct the following errors..." ShowSummary="false" ValidationGroup="show" />
</asp:Content>
