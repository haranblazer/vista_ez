<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="CalculateBinaryDirect.aspx.cs" Inherits="secretadmin_CalculateBinaryDirect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });


            $('#<%=txt_PTR1.ClientID%>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });

            $('#<%=txt_PTR2.ClientID%>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });
            $('#<%=txt_PTR3.ClientID%>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });
            $('#<%=txt_PTR4.ClientID%>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });
            $('#<%=txt_PTR5.ClientID%>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });

        });
    </script>
    <h2 class="head">
        <i class="fa fa-list"></i>Calculate Binary Income</h2>
    <!-- TitleActions -->
    <!-- /TitleActions -->
    <div class="panel panel-default">
        <div class="col-md-12">
            <div class="clearfix">
            </div>
            <br />
            <div>
                <div class="form-group">
                    <div class="col-md-1">
                        <strong>From </strong>
                    </div>
                    <div class="col-md-2">
                        <asp:TextBox ID="txtFromDate" runat="server" BackColor="White" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-1">
                        <strong>To </strong>
                    </div>
                    <div class="col-md-2">
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" BackColor="White"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-1">
                        <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-success"
                            ValidationGroup="show" /> 
                       
                    </div>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="bottom_table">
                <div class="form-group">
                    <div class="col-md-6">
                        <asp:Label ID="lblLastPayoutDate" runat="server" Font-Bold="True" Font-Names="Arial"></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div id="tbl_binary" runat="server" visible="false" class="table-responsive">
                <table  style="border: #ddd 1px solid;" class="table">
                    <tr>
                        <th>
                            <span style="font-size: 14px; font-family: Arial;"><strong>Plan</strong></span>
                        </th>
                        <th>
                            <span style="font-size: 14px; font-family: Arial;"><strong>BV</strong></span>
                        </th>
                        <th>
                            <span style="font-size: 14px; font-family: Arial;"><strong>Percent</strong></span>
                        </th>
                        <th>
                            <span style="font-size: 14px; font-family: Arial;"><strong>Amount</strong></span>
                        </th>
                        <th>
                            <span style="font-size: 14px; font-family: Arial;"><strong>Point Rate</strong></span>
                        </th>
                        <th>
                            <span style="font-size: 14px; font-family: Arial;"><strong>Ceiling/ Capping</strong></span>
                        </th>
                    </tr>
                    <tr style="border-top: 2px;">
                        <td>
                            <span id="lbl1" runat="server" style="font-size: 10pt; font-family: Arial"></span>
                        </td>
                        <td>
                            <asp:Label ID="lblBV1" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbl_B1" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txt_Binary1" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_PTR1" runat="server" Width="80px" MaxLength="8" CssClass="form-control"></asp:TextBox>
                        </td>
                         <td>
                            <asp:Label ID="lbl_CC1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbl2" runat="server" style="font-size: 10pt; font-family: Arial"></span>
                        </td>
                        <td>
                            <asp:Label ID="lblBV2" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbl_B2" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txt_Binary2" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_PTR2" runat="server" Width="80px" MaxLength="8" CssClass="form-control"></asp:TextBox>
                        </td>
                         <td>
                            <asp:Label ID="lbl_CC2" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbl3" runat="server" style="font-size: 10pt; font-family: Arial"></span>
                        </td>
                        <td>
                            <asp:Label ID="lblBV3" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbl_B3" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txt_Binary3" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_PTR3" runat="server" Width="80px" MaxLength="8" CssClass="form-control"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbl_CC3" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbl4" runat="server" style="font-size: 10pt; font-family: Arial"></span>
                        </td>
                        <td>
                            <asp:Label ID="lblBV4" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbl_B4" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txt_Binary4" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_PTR4" runat="server" Width="80px" MaxLength="8" CssClass="form-control"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbl_CC4" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbl5" runat="server" style="font-size: 10pt; font-family: Arial"></span>
                        </td>
                        <td>
                            <asp:Label ID="lblBV5" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbl_B5" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txt_Binary5" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_PTR5" runat="server" Width="80px" MaxLength="8" CssClass="form-control"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbl_CC5" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-size: 10pt; font-family: Arial">Total Binary </span>
                        </td>
                        <td>
                            <asp:Label ID="Label5" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbl_Per" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbl_Amt" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Button ID="btn_updateBinaryInc" runat="server" Text="Update" CssClass="btn btn-info"
                                OnClick="btn_updateBinaryInc_Click" />
                        </td>
                         <td>
                        </td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0" style="width: 80%">
                    <tr>
                        <td style="border-left-width: 1px; border-left-color: #000000; width: 26px; height: 25px">
                        </td>
                        <td style="border-left-width: 1px; border-left-color: #000000; width: 350px; height: 25px">
                            &nbsp;
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
                    <tr id="tr1" runat="server">
                        <td style="border-left-width: 1px; border-left-color: #000000; width: 26px; height: 25px">
                        </td>
                        <td style="border-left-width: 1px; border-left-color: #000000; width: 350px; height: 25px">
                        </td>
                        <td style="width: 350px; height: 25px; border-right-width: 1px; border-right-color: #000000">
                         <asp:Button ID="Button3" runat="server" Text="Calculate Income" OnClick="Button3_Click"
                            CssClass="btn-success btn" ValidationGroup="show" />
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
        </div>
        <div class="clearfix">
        </div>
        <br />
    </div>
</asp:Content>
