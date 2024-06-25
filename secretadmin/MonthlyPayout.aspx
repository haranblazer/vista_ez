﻿<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="MonthlyPayout.aspx.cs" Inherits="secretadmin_MonthlyPayout" %>


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
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Monthly Payout Details</h4>
    <div class="row">
                    <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" BackColor="White"></asp:TextBox>
                </div>

               
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" BackColor="White"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:Button ID="Button1" OnClick="Button1_Click" runat="server" Text="Show " ValidationGroup="Show"
                        CssClass="btn btn-primary" TabIndex="3"></asp:Button>
                </div>
                </div>



   <hr />

            <div class="table-responsive" style="border: none">
                <table class="table table-striped table-hover">
                    <tr style="border: 1px solid #ddd;">
                        <td class="top_table">Total New Members Joined
                        </td>
                        <td class="top_table">Total New Members
                        </td>
                        <td class="top_table">Total Purchasing Members
                        </td>
                        <td class="top_table">Total Counts Generated
                        </td>
                        <td class="top_table">Total TPV Generated
                        </td>
                        <td class="top_table">Last payout was generated
                        </td>
                    </tr>

                    <tr style="border: 1px solid #ddd;">
                        <td class="top_table">
                            <asp:Label ID="lblTotalRegistered" runat="server" Font-Names="Arial">0</asp:Label>
                        </td>
                        <td class="top_table">
                            <asp:Label ID="lblunpaid" runat="server" Font-Names="Arial">0</asp:Label>
                        </td>
                        <td class="top_table">
                            <asp:Label ID="lblpaidUsers" runat="server" Text="0" Font-Names="Arial"></asp:Label>
                        </td>
                        <td class="top_table">
                            <asp:Label ID="lbltotalcollection" runat="server" Text="0" Font-Names="Arial"></asp:Label>
                        </td>
                        <td class="top_table">
                            <asp:Label ID="lbltotalamount" runat="server" Text="0" Font-Names="Arial"></asp:Label>
                        </td>
                        <td class="top_table">
                            <asp:Label ID="lblLastPayoutDate" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label>
                        </td>
                    </tr>

                </table>
            </div>
            <div class="clearfix"></div>

            <div class="table-responsive">

                <table class="table table-striped table-hover">
                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;" class="top_table">
                            <span style="font-size: 14px; font-family: Arial;"><strong>Payout Particulars</strong></span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left" class="top_table">
                            <span style="font-size: 14px; font-family: Arial;"><strong>Amount</strong></span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left" class="top_table">
                            <span style="font-size: 14px; font-family: Arial;"><strong>% of TPV</strong></span>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Bronze& Silver Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_BSF_T_Inc" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_BSF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Gold Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_GF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_GF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>
                   
                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Ruby Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_RF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_RF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Pearl Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_PF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_PF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>
 

                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Diamond Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_DF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_DF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Double Diamond Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_DDF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_DDF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>
                   
                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Blue Diamond Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_BLUEDF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_BLUEDF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Black Diamond Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_BLACKDF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_BLACKDF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Crown Ambassador Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_CAF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_CAF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Offer Income</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_OI_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_OI_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>
                   
                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">
                            <span style="font-size: 10pt; font-family: Arial">Reward Fund</span>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_RWDF_T" runat="server" Width="120px"></asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lbl_RWDF_T_Per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                        </td>
                    </tr>



                    <tr>
                        <td style="padding-left: 20px; width: 25%; height: 25px;">Total Income
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lblTotalPayout" runat="server" Font-Names="Arial">0</asp:Label>
                        </td>
                        <td style="padding-right: 20px; width: 25%; height: 25px; text-align: left;">
                            <asp:Label ID="lblPercentage" runat="server" Text="0" Font-Names="Arial"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="Button3" runat="server" Text="Click here to make above date as next payout date"
                                OnClick="Button3_Click" CssClass="btn-primary btn" ValidationGroup="show" OnClientClick="return confirm('Are you sure you want to create payout？')" />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="border-left-width: 1px; border-left-color: #000000; height: 25px" colspan="3">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="show"
                                ControlToValidate="txtFromDate" Display="None" ErrorMessage="Please enter from date!"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                                ControlToValidate="txtFromDate" ErrorMessage="Please enter date in dd-mm-yyyy format!"
                                Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9-]*" ValidationGroup="show"
                                Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="show"
                                ControlToValidate="txtToDate" Display="None" ErrorMessage="Please enter to date!"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtToDate"
                                ErrorMessage="Please enter date in dd-mm-yyyy format!" Font-Bold="False" ForeColor="#C00000"
                                ValidationExpression="^[0-9-]*" ValidationGroup="show" Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
                                ShowSummary="false" ValidationGroup="show" />
                        </td>
                    </tr>
                </table>
            </div>
       
</asp:Content>
