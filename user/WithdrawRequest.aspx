<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="WithdrawRequest.aspx.cs" Inherits="user_WithdrawRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#">Wallet</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Bank Wallet Withdrawal</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Bank Wallet Withdrawal</h1>
                            </div>
                          <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div> 

                     <div class="container-fluid page__container">                 
         <div class="panel card card-body">
        <div class="panel panel-default">  
          
            <div class="panel-body">
     
                    <fieldset>
                        <div class="form-group card-group-row row">
                            <div class="col-md-2">
                                Balance</div>
                            <div class="col-md-4">
                                <asp:Label ID="lblBalance" runat="server" Font-Bold="True" Font-Size="Larger"></asp:Label>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        
                        <div class="form-group card-group-row row">
                            <div class="col-md-2">
                                Amount</div>
                            <div class="col-md-4">
                                <asp:TextBox onchange="javascript:trancount(this);return CallVal(this);" ID="TxtAmount"
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
                            <div class="col-md-2">
                                Remarks:</div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtRemark" runat="server" Height="100px" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-group" style="display: none">
                            <div class="col-md-2">
                            </div>
                            <div class="col-md-2">
                                <asp:RadioButton ID="rdbtn1" runat="server" CssClass="form-control" GroupName="tp"
                                    Text="OTP" Checked="True" /></div>
                            <div class="col-md-2">
                                <asp:RadioButton ID="rdbtn2" runat="server" CssClass="form-control" GroupName="tp"
                                    Text="Trans. Pass." Enabled="False" />
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-group" style="display: none">
                            <div class="col-md-3">
                                Transaction Password:</div>
                            <div class="col-md-4">
                                <asp:TextBox onchange="javascript:trancount(this);return CallVal(this);" CssClass="form-control"
                                    ID="TxtEpassword" runat="server" TextMode="Password" CausesValidation="True"
                                    ValidationGroup="t"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtEpassword"
                                    Display="None" ErrorMessage="Transaction password require." SetFocusOnError="True"
                                    ValidationGroup="t"></asp:RequiredFieldValidator>
                                <br />
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                       
                        <div class="form-group card-group-row row">
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
                                    <td colspan="2" style="width: 100%;">
                                        <div id="trOTPVerify" style="display:none;">
                                            ENTER OTP : <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                                            <a href="#\" onclick="OPTVerift()" class="btn btn-info">Verify</a>
                                           <br />
                                            <span id="lblOTPMSG"></span> 
                                            <div id="divRegenerate">
                                                <a id="A1" href="#\" onclick="OPTGenerate(2)" runat="server">Re-Generate OTP</a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 100%; display: none">
                                        <div id="divLIMIT500">
                                         
                                            <span id="lblLIMIT500"></span>
                                        </div>
                                    </td>
                                </tr>
                            </div>
                        </div>
                        <div class="form-group card-group-row row">
                            <div class="col-md-2">
                            </div>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Enabled="false" CssClass="btn btn-success"
                                    OnClick="btnSubmit_Click" ValidationGroup="t" />
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="t" />
                            </div>
                        </div>
                        <table align="left" style="width: 100%">
                            <%-- <tr>
                                <td>
                                    User Id:
                                </td>
                                <td>
                                    <asp:TextBox onchange="return CallVal(this);" ID="txtUserID" runat="server" CausesValidation="True"
                                        ValidationGroup="t" Width='200'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserID"
                                        Display="None" ErrorMessage="User ID require." SetFocusOnError="True" ValidationGroup="t"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserID"
                                        ErrorMessage="Invalid user id." SetFocusOnError="True" ValidationExpression="^[0-9a-zA-Z]*$"
                                        ValidationGroup="t" Display="None"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:Label ID="lblUser" runat="server"></asp:Label>
                                </td>
                            </tr>--%>
                        </table>
                    </fieldset>
                
            <script type="text/javascript">

                function OPTGenerate(flag) {
                    
                    
                    var Amount = $('#<%=TxtAmount.ClientID %>').val().trim();
                    if (Amount >= 500) {
                        $('#<%=txtOTP.ClientID %>').val('');
                        $.ajax({
                            type: "POST",
                            url: 'WithdrawRequest.aspx/GenerateOTP',
                            data: '{Amount: "' + Amount + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                
                                if (response.d == '0') {
                                    $('#trOTPGen').hide();
                                    $('#divLIMIT500').hide();
                                    $('#trOTPVerify').show();
                                    document.getElementById("<%=btnSubmit.ClientID%>").disabled = true;
                                    if (flag == "2") {

                                        $('#lblOTPMSG').text("OTP RE-GENERATED.");
                                        $('#lblOTPMSG').css('color', 'green');

                                    }
                                }
                                return false;
                            },
                            error: function (response) {
                                $('#lblmsgcoupon').text("Server error. Time out..!!");
                            }
                        });
                    }
                    else {
                        $('#divLIMIT500').show();
                        $('#lblLIMIT500').text("Can't enter less than 500.");
                        $('#lblLIMIT500').css('color', 'red');
                    }
                }

                function OPTVerift() {
                     
                    var OTP = $('#<%=txtOTP.ClientID %>').val().trim();
                    $.ajax({
                        type: "POST",
                        url: 'WithdrawRequest.aspx/VerifyOTP',
                        data: '{ OTP: "' + OTP + '"}',
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
            </div>
            </div>
            </div>


        </div>
       
</asp:Content>
