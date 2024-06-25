<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="PayoutLeaderShipInc.aspx.cs" Inherits="secretadmin_PayoutLeaderShipInc" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <style>
        td, th
        {
            padding: 5px 5px;
            border-color: #ddd;
        }
    </style>
  
        <h2 class="head">
            <i class="fa fa-exchange" aria-hidden="true"></i> Calculate Lead the Leadership</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
     <div class="panel panel-default">
  <div class="col-md-12">
   <div>
   
        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-1 control-label">
                From :</label>
            <div class="col-sm-2">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-1 control-label">
                To :</label>
            <div class="col-sm-2">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        </div>
  
    <div class="clearfix">
     <asp:Label ID="lblLastPayoutDate" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="10pt"></asp:Label>
    </div>
    <br />
    <hr />
    <div class="table-responsive" style="border: none">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
            <tr>
                <td style="width: 26px; height: 25px">
                </td>
                <td style="width: 350px; height: 25px">
                    <asp:Button ID="Button3" runat="server" Text="Calculate lead the leadership income"
                        OnClick="Button3_Click" CssClass="btn btn-success" OnClientClick="return confirm('Are you sure you want to create income？')"/>
                </td>
                <td style="width: 350px; height: 25px; border-right-width: 1px; border-right-color: #000000">
                     
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="border-left-width: 1px; border-left-color: #000000; height: 25px" colspan="3">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="show"
                        ControlToValidate="txtFromDate" Display="None" ErrorMessage="Please enter from date!"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                        ControlToValidate="txtFromDate" ErrorMessage="Please enter date in dd/mm/yyyy format!"
                        Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*" ValidationGroup="show"
                        Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="show"
                        ControlToValidate="txtToDate" Display="None" ErrorMessage="Please enter to date!"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtToDate"
                        ErrorMessage="Please enter date in dd/mm/yyyy format!" Font-Bold="False" ForeColor="#C00000"
                        ValidationExpression="^[0-9/]*" ValidationGroup="show" Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
                        ShowSummary="false" ValidationGroup="show" />
                </td>
            </tr>
        </table>
    </div>
 
    </div>   <div class="clearfix"></div>
    </div>
</asp:Content>

