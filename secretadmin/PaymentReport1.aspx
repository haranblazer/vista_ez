<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="PaymentReport1.aspx.cs" Inherits="admin_PaymentReport1" %>

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
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Repurchase Payout Details</h4>
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




    <div class="table-responsive" style="border: none">
        <table class="table table-striped table-hover">
            <tr style="border: 1px solid #ddd;">
                <td class="top_table">Total New Members Joined
                </td>
                <td class="top_table">Total New Paid Members
                </td>
                <td class="top_table">Total New Unpaid Members
                </td>
                <td class="top_table">Total Purchasing Members
                </td>
                <td class="top_table">Total <%=method.GBV%> Generated
                </td>
                <td class="top_table">Total Amount
                </td>

                <td class="top_table">Last payout was generated
                </td>
            </tr>
            <tr style="border: 1px solid #ddd;">
                <td class="top_table">
                    <asp:Label ID="lblTotalRegistered" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td class="top_table">
                    <asp:Label ID="lblpaidUsers" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td class="top_table">
                    <asp:Label ID="lblunpaid" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td class="top_table">
                    <asp:Label ID="lbl_TotalPruchaseMember" runat="server" Font-Names="Arial">0</asp:Label>
                </td>
                <td class="top_table">
                    <asp:Label ID="lbltotalamount" runat="server" Font-Names="Arial">0</asp:Label>
                </td>
                <td class="top_table">
                    <asp:Label ID="lbltotalcollection" runat="server" Font-Names="Arial">0</asp:Label>
                </td>
                <td class="top_table">
                    <asp:Label ID="lblLastPayoutDate" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label>
                </td>
            </tr>
        </table>
    </div>


    <div class="clearfix"></div>
   
    <div class="table-responsive" style="border: none">
        <table class="table table-striped table-hover">
            <tr style="border: 1px solid #ddd;">
                <td class="top_table" style="font-size: 14px; font-family: Arial; border: 1px solid #ddd;">
                    <strong>Payout Particulars</strong>
                </td>
                <td class="top_table" style="font-size: 14px; font-family: Arial; border: 1px solid #ddd;">
                    <strong>Amount</strong>
                </td>
                <td class="top_table" style="font-size: 14px; font-family: Arial; border: 1px solid #ddd;">
                    <strong>% of <%=method.GBV%></strong>
                </td>
            </tr>


            <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Self Purchase Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_7" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_7_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Startup Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_1" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_1_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Performance Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_2" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_2_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Lifestyle Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_3" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_3_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Prime Club Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_4" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_4_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>




            <tr style="border: 1px solid #ddd;">
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Leadership Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_5" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_5_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Royalty Club Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_6" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_Inc_6_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>


            <%--    <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Royalty Club Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_RI" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_RI1_PER" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>
            
         <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Double Diamond Directors Club Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_TWF" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_TWF_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Ambassadors Club Bonus</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_FWF" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lbl_FWF_per" runat="server" Font-Names="Arial" Font-Size="10pt">0</asp:Label>
                </td>
            </tr> --%>



            <tr>
                <td style="border: 1px solid #ddd;">
                    <span style="font-size: 14px; font-family: Arial">Total Income</span>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lblTotalPayout" runat="server" Text="0" Font-Names="Arial" Font-Size="10pt"></asp:Label>
                </td>
                <td style="border: 1px solid #ddd;">
                    <asp:Label ID="lblPercentage" runat="server" Text="0" Font-Names="Arial"></asp:Label>
                </td>
            </tr>

        </table>

        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">

            <tr>
                <td style="width: 26px; height: 25px"></td>
                <td style="width: 350px; height: 25px">
                    <asp:Button ID="Button3" runat="server" Text="Click here to make above date as next payout date"
                        OnClick="Button3_Click" CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure you want to create new payout？')" />
                </td>
                <td style="width: 350px; height: 25px; border-right-width: 1px; border-right-color: #000000">
                    <asp:Button ID="Button4" runat="server" Text="Cancel" OnClick="Button4_Click" CssClass="btn-success btn" />
                </td>
            </tr>
            <tr>

                <td>
                    <asp:Button ID="Button2" runat="server" Text="Click here To Create Payout" OnClick="Button2_Click"
                        CssClass="btn-primary btn" ValidationGroup="show" Visible="false" />
                </td>
                <td></td>
            </tr>
            <tr>
                <td style="border-left-width: 1px; border-left-color: #000000; height: 25px" colspan="3">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="show"
                        ControlToValidate="txtFromDate" Display="None" ErrorMessage="Please enter from date!"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                        ControlToValidate="txtFromDate" ErrorMessage="Please enter date in dd/mm/yyyy format!"
                        Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9-]*" ValidationGroup="show"
                        Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="show"
                        ControlToValidate="txtToDate" Display="None" ErrorMessage="Please enter to date!"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtToDate"
                        ErrorMessage="Please enter date in dd/mm/yyyy format!" Font-Bold="False" ForeColor="#C00000"
                        ValidationExpression="^[0-9-]*" ValidationGroup="show" Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
                        ShowSummary="false" ValidationGroup="show" />
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
