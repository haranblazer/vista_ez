<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="TransferWallet.aspx.cs" Inherits="User_TransferWallet" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Transfer Payout Wallet to Company Wallet</h4>
    </div>
    <br />

    <div class="form-group card-group-row row">
        <div class="col-md-2 control-label  ">
            From Wallet
        </div>
        <div class="col-md-4">
            <asp:DropDownList ID="ddl_BillType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_BillType_SelectedIndexChanged">
                <asp:ListItem Value="7">Payout Wallet</asp:ListItem>
                <%--<asp:ListItem Value="11">T Wallet</asp:ListItem>--%>
                <%--  <asp:ListItem Value="12">R Wallet</asp:ListItem> --%>
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:Label ID="lblBalance" runat="server"></asp:Label>
        </div>
    </div>

    <div class="clearfix"></div>

    <div class="form-group card-group-row row">
        <div class="col-md-2 control-label">
            To Company Wallet Bal
        </div>
        <div class="col-md-4">
            <asp:Label ID="lbl_CWallet" runat="server">0</asp:Label>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="form-group card-group-row row">
        <div class="col-md-2 control-label">
            Amount
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="TxtAmount" onkeypress="return onlyNumbers(event,this);"
                runat="server" CausesValidation="True" ValidationGroup="t" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtAmount"
                Display="None" ErrorMessage="Amount require." SetFocusOnError="True" ValidationGroup="t"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtAmount"
                ErrorMessage="Invalid amount" SetFocusOnError="True" ValidationGroup="t" ValidationExpression="^[0-9]*$"
                Display="None"></asp:RegularExpressionValidator>
            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TxtAmount"
                Display="None" ErrorMessage="Points limit is 1-900000." MaximumValue="900000"
                MinimumValue="1" SetFocusOnError="True" Type="Double" ValidationGroup="t"></asp:RangeValidator>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="form-group card-group-row row">
        <div class="col-md-2 control-label">
            Remarks:
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtRemark" runat="server" Height="100px" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="form-group card-group-row row">
        <div class="col-md-2">
        </div>
        <div class="col-md-4">
            <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary"
                OnClick="btnSubmit_Click" ValidationGroup="t" OnClientClick="return confirm('Are you sure you want to transfer amount.？')" />
        </div>
    </div>
    <div class="clearfix"></div>

    <script language="Javascript" type="text/javascript">

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57)) { return false; }
            return true;
        }
    </script>



</asp:Content>
