<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="CreateFranchisePayout.aspx.cs" Inherits="secretadmin_CreateFranchisePayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <script type="text/javascript">
        function ConfirmationMsg() {
            if (confirm("Are you sure want to Proceed?")) {
                return true;
            }
            return false;
        }
    
    </script>
  <h4 class="fs-20 font-w600  me-auto float-left mb-0">Create Franchise Payout</h4>
    <div class="row">
                  
            <div class="col-md-2">              
                    <asp:TextBox ID="txtFromDate" runat="server" BackColor="White" CssClass="form-control"
                        placeholder="DD/MM/YYYY" MaxLength="10"></asp:TextBox>                  
            </div>
      
           
            <div class="col-md-2">                
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" BackColor="White"
                        placeholder="DD/MM/YYYY" MaxLength="10"></asp:TextBox>                   
            </div>
                </div>


     
    <hr />

            <div class="col-md-6">
                <asp:Label ID="lblLastPayoutDate" runat="server" Font-Bold="True" Font-Names="Arial"
                    ForeColor="blue"></asp:Label>
            </div>
      
   <div class="table-responsive">
    <asp:GridView ID="GridPayoutDate" runat="server" AutoGenerateColumns="false" AllowPaging="true"
        PageSize="5" EmptyDataText="No Record Found." CssClass="table table-hover table-stripped mygrd"
        OnPageIndexChanging="GridPayoutDate_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Sr.No">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="payoutno" HeaderText="Payout No" />
            <asp:BoundField DataField="pfromdate" HeaderText="Payout From" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="pdate" HeaderText="Payout To" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="currentdate" HeaderText="Current Date" DataFormatString="{0:dd/MM/yyyy}" />
        </Columns>
    </asp:GridView>
    
    <div class="clearfix">
    </div>
   
    <div class="form-group">
        <div class="col-md-4">
            <asp:Button ID="btnCreateFranchisePayout" runat="server" Text="Click here to make above date as next payout date"
                OnClick="btnCreateFranchisePayout_Click" CssClass="btn-primary btn" OnClientClick="return ConfirmationMsg();" />
        </div>
    </div>
    </div>
    <div class="col-sm-12">
        <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" ValidationGroup="show"
            SetFocusOnError="true" ControlToValidate="txtFromDate" Display="None" ErrorMessage="Please Enter From Date !!!"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revFromDate" runat="server" SetFocusOnError="true"
            ControlToValidate="txtFromDate" ErrorMessage="Please Enter Date in DD/MM/YYYY Format !!!"
            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*" ValidationGroup="show"
            Display="none"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="rfvToDate" runat="server" ValidationGroup="show"
            SetFocusOnError="true" ControlToValidate="txtToDate" Display="None" ErrorMessage="Please Enter To Date !!!"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revToDate" runat="server" ControlToValidate="txtToDate"
            ErrorMessage="Please Enter Date in DD/MM/YYYY Format !!!" Font-Bold="False" ForeColor="#C00000"
            ValidationExpression="^[0-9/]*" ValidationGroup="show" Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
        <asp:ValidationSummary ID="ValidateDate" runat="server" ShowMessageBox="true" ShowSummary="false"
            ValidationGroup="show" HeaderText="Please correct the following..." />
    </div>
  
</asp:Content>
