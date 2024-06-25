<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="DwalletToUwallet.aspx.cs" Inherits="user_DwalletToDwallet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 
 

     <div class="middle">
  <!-- middle content -->
  <div class="indexmiddle">
   
    <asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager> 
       

  <h2 class="head"> <i class="fa fa-rocket" aria-hidden="true"></i>
                D-wallet to D-wallet
            </h2>
                  <p>Transfer fund form your Wallet to other member&#39;s Walet.</p>  
                    
        <br /><div class="clearfix"></div>
      <div class="form-group">
               <div class="col-md-3">
               Current Balance
               </div>
                <div class="col-md-4">
                <asp:Label ID="lblBalance" runat="server" Font-Bold="True" Font-Size="Larger "></asp:Label>
               </div>
               </div>
               <div class="clearfix"></div>
               <br />
                <div class="form-group">
               <div class="col-md-3">
                User Id:
               </div>
                <div class="col-md-4">
                 <asp:UpdatePanel ID="UpdatePanel1"  runat="server">
                                     <ContentTemplate>
                                    <asp:TextBox ID="txtUserID"   runat="server" CssClass="form-control"  AutoPostBack="true" CausesValidation="True"
                                         ontextchanged="txtUserID_TextChanged" ></asp:TextBox>
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
               <div class="clearfix"></div>
               <br />
                <div class="form-group">
               <div class="col-md-3">
                Amount:
               </div>
                <div class="col-md-4">
                  <asp:TextBox  ID="TxtAmount"
                                        runat="server"  CssClass="form-control" CausesValidation="True"></asp:TextBox>

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
               <div class="clearfix"></div>
               <br />
                <div class="form-group">
               <div class="col-md-3">
               Transaction Password:
               </div>
                <div class="col-md-4">
                <asp:TextBox 
                                        ID="TxtEpassword" CssClass="form-control" runat="server" TextMode="Password" CausesValidation="True"
                                        ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtEpassword"
                                        Display="None" ErrorMessage="Transaction password require." SetFocusOnError="True"
                                        ValidationGroup="t"></asp:RequiredFieldValidator>
               </div>
               </div>
               <div class="clearfix"></div>
               <br />
                <div class="form-group">
               <div class="col-md-3">
                 Remarks
               </div>

                <div class="col-md-4">
                <asp:TextBox ID="txtRemark" runat="server"  TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
               </div>
               </div>
               <div class="clearfix"></div>
               <br />
               <div class="form-group">
                <div class="col-md-3">
   
 </div>

 <div class="col-md-4">
  <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success"
                                        OnClick="btnSubmit_Click" ValidationGroup="t" />
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" ValidationGroup="t" />
 </div>
 </div>
               
                                            
         
           
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

