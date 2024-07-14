<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="UnitWalletPass.aspx.cs" Inherits="user_PointTransfertoBank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <script>     var jq151 = jQuery.noConflict(true);</script>--%>
    <%-- <script language="javascript" type="text/javascript">
     function CallVal(txt) {
         ServerSendValue(txt.value, "ctx");
     }
     function ServerResult(arg) {

         if (arg == "You cannot leave blank field here !") {
             document.getElementById("lblUser.ClientID").style.color = "Red";
             document.getElementById("lblUser.ClientID").innerHTML = arg;


         }
         else {
             document.getElementById("<%=lblUser.ClientID%>").style.color = "darkblue";
             document.getElementById("<%=lblUser.ClientID%>").innerHTML = arg;


         }
     }
     function ClientErrorCallback() {
     }
    </script>--%>
    <div class="middle">
        <!-- middle content -->
        <div class="indexmiddle">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div class="col-md-12">
                <h3 style="background: #C20913; color: #fff; padding: 8px 8px; margin: 10px 0px;">
                    P-Wallet To D-Wallet
                </h3>
            </div>
            <table align="left" style="width: 100%">
                <tr>
                    <td colspan="2">
                        Transfer fund from your Wallet to other member&#39;s Walet.
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong><span style="font-size: large">Current Balance</span> </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblBalance" runat="server" Font-Bold="True" Font-Size="Larger"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        User Id:
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtUserID" runat="server" AutoPostBack="true" CausesValidation="True"
                                    Width='200' OnTextChanged="txtUserID_TextChanged"></asp:TextBox>
                                <asp:Label ID="lblUser" runat="server"></asp:Label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserID"
                            Display="None" ErrorMessage="User ID require." SetFocusOnError="True" ValidationGroup="t">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserID"
                            ErrorMessage="Invalid user id." SetFocusOnError="True" ValidationExpression="^[0-9a-zA-Z]*$"
                            ValidationGroup="t" Display="None"></asp:RegularExpressionValidator>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        Amount:
                    </td>
                    <td>
                        <asp:TextBox ID="TxtAmount" runat="server" Width='200' CausesValidation="True"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtAmount"
                            Display="None" ErrorMessage="Amount Required" SetFocusOnError="True" ValidationGroup="t">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtAmount"
                            ErrorMessage="Invalid Amount" SetFocusOnError="True" ValidationExpression="^[0-9]*$"
                            ValidationGroup="t" Display="None"></asp:RegularExpressionValidator>
                        <%--   <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TxtAmount"
                                        Display="None" ErrorMessage="Points limit is 1-900000." MaximumValue="900000"
                                        MinimumValue="1" SetFocusOnError="True" Type="Double" ValidationGroup="t"></asp:RangeValidator>--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Transaction Password:
                    </td>
                    <td>
                        <asp:TextBox Width='200' ID="TxtEpassword" runat="server" TextMode="Password" CausesValidation="True"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtEpassword"
                            Display="None" ErrorMessage="Transaction password require." SetFocusOnError="True"
                            ValidationGroup="t"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        Remarks
                    </td>
                    <td>
                        <asp:TextBox ID="txtRemark" runat="server" Height="42px" TextMode="MultiLine" Width='200'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td class="bottom_table" colspan="1">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="primaryAction" OnClick="btnSubmit_Click"
                            ValidationGroup="t" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="t" />
                    </td>
                </tr>
            </table>
            <div class="mws-panel-header">
                <span style="color: #fff;"><i class="icon-chart"></i>WALLET TRANSFER RULES AND INFORMATION:</span>
            </div>
            <table style="width: 100%;">
                <tr>
                    <td>
                        <b>Rules:</b>
                        <br />
                        <ol style="margin-left: 20px; list-style-type: decimal;">
                            <li>You can transfer Wallet to other member accounts via Wallet Transfer.</li>
                            <li>Wallets are just a virtual figure having no financial value. </li>
                            <li>Please do not transact Wallet with currency. Company will not be responsible for
                                such transaction and it is illegal to transact with currency, any member found doing
                                the act will be terminated immediate. </li>
                            <li>Wrong transfer and Wallet theft is the sole responsibility of each member; company
                                will not be liable or bound to refund those wrongly transferred wallets or points
                                being theft. </li>
                            <li>Any member found involved in theft of other member wallet will be terminated.
                            </li>
                        </ol>
                        <strong>Information:-
                            <br />
                        </strong>
                        <ol style="margin-left: 20px; list-style-type: decimal;">
                            <li>Please enter the recipient member ID that you would like to transfer Wallet to.</li>
                            <li>Wallet transferrable cannot exceed the balance in your Wallet Center. </li>
                            <li>Your Transaction Password is required for the Wallet Transfer. </li>
                            <li>Wallet Transfer is taken place immediately, once Submit button on confirmation step
                                is clicked.</li>
                        </ol>
                    </td>
                </tr>
            </table>
            <!--
		<div class="clearfix"></div>  
		<div id="mws-footer" >Copyright CIBS 2015. All Rights Reserved.</div> 
		-->
        </div>
    </div>
</asp:Content>
