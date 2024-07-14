<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="PointTransfertoBank.aspx.cs" Inherits="user_PointTransfertoBank" %>

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
    <div class="site-content">
        <!-- middle content -->
        <div class="indexmiddle">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
              <div class="panel-heading">
            <i class="fa fa-address-book" aria-hidden="true"></i>&nbsp;   P-Wallet To CJ-Wallet
        </div>
           <div class="panel panel-default">
            <div class="clearfix">
            </div>
            <br />
            <div class="col-md-12">
            <p>Transfer fund from your Wallet to other member&#39;s Walet.</p>
               <div class="form-group">
                        <div class="col-md-2">
                            Current Balance</div>
                        <div class="col-md-3">
                         <asp:Label ID="lblBalance" runat="server" Font-Bold="True" Font-Size="Larger"></asp:Label>
                        </div>
                        </div>
                        <div class="clearfix"></div><br />
                         <div class="form-group">
                        <div class="col-md-2">
                            User Id:</div>
                        <div class="col-md-3">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtUserID" runat="server" AutoPostBack="true" CausesValidation="True"
                                   CssClass="form-control" OnTextChanged="txtUserID_TextChanged"></asp:TextBox>
                                <asp:Label ID="lblUser" runat="server"></asp:Label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserID"
                            Display="None" ErrorMessage="User ID require." SetFocusOnError="True" ValidationGroup="t">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserID"
                            ErrorMessage="Invalid user id." SetFocusOnError="True" ValidationExpression="^[0-9a-zA-Z]*$"
                            ValidationGroup="t" Display="None"></asp:RegularExpressionValidator>
                        </div>
                        </div>
                        <div class="clearfix"></div><br />
                          <div class="form-group">
                        <div class="col-md-2">
                           Amount</div>
                        <div class="col-md-3">
                         <asp:TextBox ID="TxtAmount" runat="server" CssClass="form-control" CausesValidation="True"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtAmount"
                            Display="None" ErrorMessage="Amount Required" SetFocusOnError="True" ValidationGroup="t">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtAmount"
                            ErrorMessage="Invalid Amount" SetFocusOnError="True" ValidationExpression="^[0-9]*$"
                            ValidationGroup="t" Display="None"></asp:RegularExpressionValidator>
                        <%--   <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TxtAmount"
                                        Display="None" ErrorMessage="Points limit is 1-900000." MaximumValue="900000"
                                        MinimumValue="1" SetFocusOnError="True" Type="Double" ValidationGroup="t"></asp:RangeValidator>--%>
                        </div>
                        </div>
                        <div class="clearfix"></div><br />
                         <div class="form-group">
                        <div class="col-md-2">
                           Remarks</div>
                        <div class="col-md-3">
                         <asp:TextBox ID="txtRemark" runat="server" Height="42px" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                        </div>
                        </div>
                       <%-- <div class="clearfix"></div><br />--%>

                          <div class="form-group" style="display:none">
                    <div class="col-md-2">
                       </div>
                          <div class="col-md-2">
                       <asp:RadioButton ID="rdbtn1" runat="server" CssClass="form-control" GroupName="tp" 
                                  Text="OTP" Checked="True" oncheckedchanged="rdbtn1_CheckedChanged" /></div>
                    <div class="col-md-2">
 <asp:RadioButton ID="rdbtn2" runat="server" CssClass="form-control" GroupName="tp" Text="Trans. Pass." Enabled="False" />
                    </div>

                      </div>

                      <br /><br />
                     <div class="clearfix"></div>

                          <div class="form-group" style="display:none">
                        <div class="col-md-2">
                             Transaction Password:</div>
                        <div class="col-md-3">
                         <asp:TextBox CssClass="form-control" ID="TxtEpassword" runat="server" TextMode="Password" CausesValidation="True"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtEpassword"
                            Display="None" ErrorMessage="Transaction password require." SetFocusOnError="True"
                            ValidationGroup="t"></asp:RequiredFieldValidator>

                            </div>
                            </div>
                            <div class="clearfix"></div><br />
                             
                            
                   
                     <div class="form-group">
                    <div class="col-md-2">
                    </div>
                      <div class="col-md-2">
                    <tr>
                   
                                                                    <td colspan="2" style="width: 100%">
                                                                        <div id="trOTPGen">
                                                                            <a href="#\" onclick="OPTGenerate(1)" class="btn btn-default">Generate OTP</a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                <tr>
                                   <td colspan="2" style="width: 100%;display:none">
                                      <div id="trOTPVerify" style="display: none">
                                                                            ENTER OTP :
<asp:TextBox ID="txtOTP" runat="server" MaxLength="10" Style="background-color: transparent;
                                                                      width: 150px;"></asp:TextBox>
                           <a href="#\" onclick="OPTVerift()" class="btn btn-info">Verify</a>
                                                                            <br />
                                                                            <span id="lblOTPMSG"></span>
                                          
                                                                            <br />
                                                                            <div id="divRegenerate">
                                                                                <a id="A1" href="#\" onclick="OPTGenerate(2)" runat="server">Re-Generate OTP</a>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                  </div>
                           </div>
                            <div class="form-group">
                       <%-- <div class="col-md-2">
                           </div>--%>
                        <div class="col-md-2">
           <asp:Button ID="btnSubmit" runat="server" Text="Submit"  CssClass="btn btn-success" OnClick="btnSubmit_Click"
                            ValidationGroup="t" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="t" />
                            </div>
                            </div>
                             <div class="clearfix"></div><br />
            <div class="mws-panel-header">
                <span style="color: #000;"><i class="icon-chart"></i>WALLET TRANSFER RULES AND INFORMATION:</span>
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
                            <li>OTP is required for the Wallet Transfer. </li>
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
        <div class="clearfix"></div>
        </div>
        </div>
          <script type="text/javascript">

              function OPTGenerate(flag) {
                  var UserName = $('#<%=txtUserID.ClientID %>').val().trim();
                  var Amount = $('#<%=TxtAmount.ClientID %>').val().trim();

                  $('#<%=txtOTP.ClientID %>').val('');
                  $.ajax({
                      type: "POST",
                      url: 'PointTransfertoBank.aspx/GenerateOTP',
                      data: '{UserName: "' + UserName + '", Amount: "' + Amount + '"}',
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (response) {
                          if (response.d == '0') {
                              $('#trOTPGen').hide();
                              $('#trOTPVerify').show();
                              document.getElementById("<%=btnSubmit.ClientID%>").disabled = true;
                              if (flag == "2") {

                                  $('#lblOTPMSG').text("OTP RE-GENERATED.");
                                  $('#lblOTPMSG').css('color', 'green');
                              }
                              $('#<%=txtOTP.ClientID %>').val('<%=HttpContext.Current.Session["Value"] %>')
                          }
                          return false;
                      },
                      error: function (response) {
                          $('#lblmsgcoupon').text("Server error. Time out..!!");
                      }
                  });
              }

              function OPTVerift() {
                  var UserName = $('#<%=txtUserID.ClientID %>').val().trim();
                  var OTP = $('#<%=txtOTP.ClientID %>').val().trim();
                  $.ajax({
                      type: "POST",
                      url: 'PointTransfertoBank.aspx/VerifyOTP',
                      data: '{UserName: "' + UserName + '", OTP: "' + OTP + '"}',
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (response) {
                          if (response.d == '0') {
                              $('#lblOTPMSG').text("OTP Verified succeessfully.");
                              $('#lblOTPMSG').css('color', 'green');
                              $('#divRegenerate').hide();
                              $('#trOTPGen').hide();
                              $('#trOTPVerify').show();
                              document.getElementById("<%=btnSubmit.ClientID%>").disabled = false;


                              //  $('#btnNewRow').hide();

                              $('#<%=txtOTP.ClientID %>').attr('disabled', 'disabled');
                          }
                          else {
                              $('#lblOTPMSG').text(response.d);
                              $('#lblOTPMSG').css('color', 'red');
                          }
                      },
                      error: function (response) {
                          $('#lblmsgcoupon').text("Server error. Time out..!!");
                      }
                  });
              }
            </script>
    </div>
</asp:Content>
