<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="RewardAndClubIncome.aspx.cs" Inherits="secretadmin_RewardAndClubIncome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ maxDate: '0', dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ maxDate: '0', dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <script type="text/javascript">
        function Confirmation() {
            if (confirm("Are you sure want to perform this action?")) {
                return true;
            }
            return false;
        }
    
    </script>
    <div class="col-sm-12">
        <h2 class="head">
            <i class="fa fa-edit" aria-hidden="true"></i>&nbsp;Club Payout</h2>
    </div>
    <div class="col-sm-12">
        <h5>
            <asp:Label ID="lblLastClubPayoutDate" runat="server" Font-Bold="true"></asp:Label></h5>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <div class="col-sm-1">
            From</div>
        <div class="col-sm-2">
            <div class="input-group">
                <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" ToolTip="DD/MM/YYYY"
                    CssClass="form-control" TabIndex="1" autocomplete="off">
                </asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
            <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" ErrorMessage="Select From Date."
                ForeColor="Red" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtFromDate"
                ValidationGroup="pp"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revFromDate" runat="server" ErrorMessage="Select Valid Date."
                ForeColor="Red" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtFromDate"
                ValidationExpression="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                ValidationGroup="pp"></asp:RegularExpressionValidator>
            <div class="clearfix">
            </div>
            <br />
        </div>
        <div class="col-sm-1">
            To</div>
        <div class="col-sm-2">
            <div class="input-group">
                <asp:TextBox ID="txtToDate" placeholder="DD/MM/YYYY" ToolTip="DD/MM/YYYY" runat="server"
                    CssClass="form-control" TabIndex="2" autocomplete="off">
                </asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
            <asp:RequiredFieldValidator ID="rfvToDate" runat="server" ErrorMessage="Select To Date."
                ForeColor="Red" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtToDate"
                ValidationGroup="pp"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revToDate" runat="server" ErrorMessage="Select Valid Date."
                ForeColor="Red" SetFocusOnError="true" Display="Dynamic" ValidationExpression="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                ControlToValidate="txtToDate" ValidationGroup="pp"></asp:RegularExpressionValidator>
            <div class="clearfix">
            </div>
            <br />
        </div>
        <div class="col-sm-6">
            <asp:Button ID="btnClubIncome" runat="server" Text="Calculate Club & Reward Income"
                CssClass="btn btn-success" OnClick="btnClubIncome_Click" ValidationGroup="pp"
                OnClientClick="return Confirmation();" TabIndex="3" />&nbsp;
            <div class="clearfix">
            </div>
            <br />
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="table-responsive">
        <asp:GridView ID="GridClubIncome" runat="server" AutoGenerateColumns="false" AllowPaging="true"
            PageSize="20" CssClass="table table-hover table-stripped mygrd" OnPageIndexChanging="GridClubIncome_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="payoutno" HeaderText="Payout No" />
                <asp:BoundField DataField="pfromdate" HeaderText="Payout From" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="pTodate" HeaderText="Payout To" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="currentdate" HeaderText="Current Date" DataFormatString="{0:dd/MM/yyyy}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
