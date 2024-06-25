<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="vendor_return_stock.aspx.cs" Inherits="franchise_vendor_return_stock" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <input type="hidden" id="hnd_TotalAmt" value="0" />
    <input type="hidden" id="hnd_Inv" value="" />
    <asp:HiddenField ID="hnd_Barcode" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_UserStateID" runat="server" Value="0" />
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Vendor Return Stock</h4>


    <div class="row">
        <div class="col-sm-1 col-form-label">Vendor ID.</div>
        <div class="col-sm-3">
            <asp:TextBox ID="txt_FromId" runat="server" onchange="GetFromId();" CssClass="form-control"
                placeholder="Enter From Id"></asp:TextBox>
            <span id="lbl_FromName" style="font-size: 10px;"></span>
        </div>

        <div class="col-sm-2 d-none">
            <asp:TextBox ID="txt_Toid" runat="server" onchange="GetToId();" CssClass="form-control"
                placeholder="Enter To Id"></asp:TextBox>
            <span id="lbl_ToName" style="font-size: 10px;"></span>
        </div>
        <div class="col-sm-4">
            <asp:TextBox ID="txt_Barcode" runat="server" CssClass="form-control" placeholder="Select Product..."></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:DropDownList ID="ddlSellerState" runat="server" CssClass="form-control" Style="display: none;">
                <asp:ListItem Value="0">Seller State</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="row">
        <div id="lblmsg" class="col-sm-12 text-center" style="color: Red;">
        </div>
    </div>
    <hr />

    <div class="clearfix">
    </div>

    <div class="table-responsive">
        <table id="tblList" class="table" style="width: 100%; border-collapse: collapse;">
        </table>
        <center>
            <span id="lbl_tbl" style="color: Red; padding: 2px;"></span>
        </center>
    </div>
    <div class=" card-group-row row">
        <div class="col-md-6" id="div_ProdDetails" style="display: none;">


            <div id="div_shipping" style="display: none;">
                <h4 class="billing-cart">Shipping Detail</h4>
                <div class="row" style="padding-bottom: 10px;">
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Your Name"></asp:TextBox>
                    </div>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txt_Mobile" runat="server" CssClass="form-control" placeholder="Enter Your Mobile No."></asp:TextBox>
                    </div>
                </div>

                <div class="clearfix"></div>
                <div class="row" style="padding-bottom: 10px;">
                    <div class="col-sm-12">
                        <asp:TextBox ID="txtaddress" runat="server" placeholder="Enter Your Address " CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="clearfix"></div>
                <div class="row" style="padding-bottom: 10px;">
                    <div class="col-sm-6">
                        <asp:DropDownList ID="ddl_state" runat="server" CssClass="form-control" onchange="GetDistrict('');">
                            <asp:ListItem Value="0">Select State</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-6">
                        <asp:DropDownList ID="ddl_district" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">Select District</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row" style="padding-bottom: 10px;">
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Enter Your City"></asp:TextBox>
                    </div>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control" placeholder="Enter Your Pincode"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix"></div>

                <hr />
            </div>
            <div class="row" style="padding-bottom: 10px;">
                <div class="col-sm-6">
                    <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="form-control" onchange="PayModeDisplay();">
                    </asp:DropDownList>
                </div>
                <div class="col-sm-6">
                    <asp:TextBox ID="txtbname" runat="server" placeholder="Enter Bank Name." CssClass="form-control"
                        MaxLength="100" Style="display: none;"></asp:TextBox>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="row" style="padding-bottom: 10px;">
                <div class="col-sm-6">
                    <asp:TextBox ID="txtDate" runat="server" placeholder="Select cheque date." CssClass="form-control"
                        MaxLength="10" Style="display: none;"></asp:TextBox>
                </div>
                <div class="col-sm-6">
                    <asp:TextBox ID="txtDD" runat="server" placeholder="Enter DD/Cheque/Transaction No."
                        MaxLength="30" CssClass="form-control" Style="display: none;"></asp:TextBox>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="row" style="padding-bottom: 10px;">
                <div class="col-sm-6" id="trOTPGen">
                    <a href="#\" onclick="OPTGenerate(1)" class="btn btn-default">Generate OTP</a>
                </div>
                <div class="col-sm-6">
                    <div id="trOTPVerify" style="display: none">
                        ENTER OTP :
                            <div class="clearfix"></div>
                        <asp:TextBox ID="txtOTP" runat="server" MaxLength="10" CssClass="form-control" Style="width: 120px; float: left"></asp:TextBox>
                        <a href="#\" onclick="OPTVerift()" class="btn btn-info" style="float: left">Verify</a>
                        <div class="clearfix">
                        </div>

                        <br />
                        <span id="lblOTPMSG"></span>
                        <br />
                        <div id="divRegenerate">
                            <a href="#\" onclick="OPTGenerate(2)">Re-Generate OTP</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="col-md-12 js-term-condition">
                <div class="row">
                    <span><b>Terms & Conditions</b>
                        <ul class="list-icons">
                            <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i>Goods Once Sold Will Not Be Taken Back.</li>
                            <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i>Warranty Will Be Under Taken By The Manufacturer Only.</li>
                            <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i>All Disputes Are Subject To
                                <asp:Label ID="lbladminadress" runat="server"></asp:Label>
                                Jurisdiction.</li>
                            <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i>Company Is Not Responsible After The Goods Leave The Premises.</li>
                            <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i>Any Inaccuracy In This Bill Must Be Notifided Immediately On Its Receipt.</li>
                            <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i>This is a computer generated invoice. No signature required.</li>
                        </ul>
                    </span>
                </div>
            </div>
        </div>
        <div class="col-md-6">

            <div id="div_PaymentDetails" style="display: none;">
                <h4 class="billing-cart">Billing Detail</h4>
                <div class="row">
                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Net Amount
                        </label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_Prod_Val" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            GST
                        </label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_Gst_Amt" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>
                </div>

                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Discount</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:TextBox ID="txt_Discount" runat="server" CssClass="form-control text-left"
                            onchange="Update_Discount_Delcharge()">0.00</asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Delivery Charge</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <select id="ddl_GST" onchange="Update_Discount_Delcharge()" class="dropdown-select form-control text-left"
                            style="width: 40px; padding: 0px; float: left; display: none;">
                            <option value="0">0%</option>
                            <%-- <option value="18" selected="selected">18%</option>--%>
                        </select>
                        <asp:TextBox ID="txt_DelCharge" runat="server" CssClass="form-control text-left" onchange="Update_Discount_Delcharge()" Style="padding: 4px; float: left;">0.00</asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Net Delivery Charge</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_DeliveryAmount" runat="server" CssClass="control-label form-control">0.00</asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Gross Amount(Rs)</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_Net_Amt" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Adjustment Amount</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:TextBox ID="txt_Adjustment" runat="server" Enabled="false" CssClass="form-control text-left">0.00</asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">Gross Weight</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_GrossWeight" runat="server" CssClass="control-label form-control">0.00</asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-4 col-xs-4">
                        <input type="button" id="btn_submit" value="Save Details" onclick="return Generate_Inv()"
                            class="btn btn-primary btn-block" />
                    </div>
                    <div class="col-md-6 col-xs-6">
                    </div>
                    <div class="col-md-2 col-sm-2">
                    </div>
                </div>
                <div class="clearfix">
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix">
    </div>




    <div class="clearfix"></div>
    <div id="divProductcode" style="display: none;" runat="server"></div>

    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });
        });
    </script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script> var $J = $.noConflict(true); </script>
    <script type="text/javascript">
        const URL = "vendor_return_stock.aspx";
        $J(function () {
            GetToId();
            BindCartTable();
            if ($('#<%=txt_FromId.ClientID%>').val() != '') {
                GetFromId();
            }

            SH_PaymentMode();
            showdiv();

            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
            $J('#<%=txt_Barcode.ClientID%>').autocomplete({ source: Productcode });
        });






        function Generate_Inv() {
            $('#lblmsg').html('');
            var MSG = "";
            var FromId = $('#<%=txt_FromId.ClientID%>').val(),
                ToId = $('#<%=txt_Toid.ClientID%>').val(),
                Discount = $('#<%=txt_Discount.ClientID%>').val(),
                DelCharge = $('#<%=lbl_DeliveryAmount.ClientID%>').text(),
                User_State = $('#<%=hnd_UserStateID.ClientID%>').val(),
                BuyerState = $('#<%=ddl_state.ClientID%> option:selected').text(),
                Admin_State = $('#<%=ddlSellerState.ClientID%>').val(),
                SellerState = $('#<%=ddlSellerState.ClientID%> option:selected').text(),
                paymode = $('#<%=ddlpaytype.ClientID%> option:selected').text(),
                bankname = $('#<%=txtbname.ClientID%>').val(),
                checkno = $('#<%=txtDD.ClientID%>').val(),
                CheDate = $('#<%=txtDate.ClientID%>').val(),
                toAdd = $('#<%=txtName.ClientID%>').val() + "<br/>" + $('#<%=txtaddress.ClientID%>').val() + ", " + $('#<%=ddl_state.ClientID%> option:selected').text() + ", " + $('#<%=ddl_district.ClientID%> option:selected').text() + ", " + $('#<%=txtCity.ClientID%>').val() + ", " + $('#<%=txtPincode.ClientID%>').val() + " <br/>Mobile No:" + $('#<%=txt_Mobile.ClientID%>').val();


            Discount = parseFloat((Discount == '' || Discount == null || isNaN(parseFloat(Discount))) ? 0 : Discount);
            DelCharge = parseFloat((DelCharge == '' || DelCharge == null || isNaN(parseFloat(DelCharge))) ? 0 : DelCharge);

            if (FromId == "") {
                MSG += "\n Please Enter FromId.!";
                $('#<%=txt_FromId.ClientID%>').focus();
            }

            if (ToId == "") {
                MSG += "\n Please Enter ToId.!";
                $('#<%=txt_Toid.ClientID%>').focus();
            }
            if (User_State == "0") {
                MSG += "\n Please Select Buyer State.!";
                $('#<%=ddl_state.ClientID%>').focus();
            }

            if ($("#<%=ddl_district.ClientID%>").val() == "0") {
                MSG += "\n Please Select Shipping Details District.!";
                $('#<%=ddl_district.ClientID%>').focus();
            }

            if (Admin_State == "0") {
                MSG += "\n Please Select Seller State.!";
                $('#<%=ddlSellerState.ClientID%>').focus();
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to save your details.？')) {
                return false;
            }

            $('#btn_submit').attr('disabled', true);
            $("#btn_submit").val("processing.....");
            $.ajax({
                type: "POST",
                url: URL + '/GenerateInv',
                data: '{FromId: "' + FromId + '", ToId: "' + ToId + '", Discount: "' + Discount + '", DelCharge: "' + DelCharge + '", User_State: "' + User_State + '", Admin_State: "' + Admin_State + '", paymode: "' + paymode
                    + '", bankname: "' + bankname + '", checkno: "' + checkno + '", CheDate: "' + CheDate + '", toAdd: "' + toAdd + '", BuyerState: "' + BuyerState + '", SellerState: "' + SellerState + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $("#btn_submit").val("Save Details");
                    $('#btn_submit').attr('disabled', false);
                    if (data.d.Error == "") {
                        $("#hnd_Inv").val(data.d.InvoiceNo);
                        $('#<%=txt_FromId.ClientID%>').val('');
                           // $('#<%=txt_Toid.ClientID%>').val('');
                            $('#<%=txt_Discount.ClientID%>').val(0.00);
                            $('#<%=txt_Adjustment.ClientID%>').val(0.00);
                            $('#<%=ddl_state.ClientID%>').val(0);
                            $('#<%=txtPincode.ClientID%>').val('');
                            BindCartTable();
                            $('#lbl_tbl').text('');
                            $('#trOTPVerify').hide();
                            alert("Sales Return Save Successfully. Sales Return No is : " + $("#hnd_Inv").val());
                        }
                        else if (data.d.Error == "Sessionlogout") {
                            window.location = "Logout.aspx";
                        }
                        else {
                            $('#lblmsg').text(data.d.Error);
                            $('html, body').animate({
                                scrollTop: $('.head').offset().top
                            }, 1000);
                        }
                    },
                    error: function (response) {
                        $('#processing').hide();
                        $('#lblName').text("Server error. Time out.!!");
                        $('#lblName').css('color', 'red');
                    }
                });
        }


        function ResetCart() {

            $.ajax({
                type: "POST",
                url: URL + '/ResetCart',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) { },
                error: function (response) { }
            });
        }


        function GetFromId() {
            ResetCart();
            $('#lblmsg').html('');
            var regno = $('#<%=txt_FromId.ClientID%>').val();
            $('#lbl_FromName').text("");
            if (regno == '') {
                return;
            }
               <%-- if (regno == '12345') {
                    $('#<%=txt_FromId.ClientID%>').val('');
                    $('#lblmsg').html('This is admin Id. Please try another id.!!');
                    return;
                }--%>
            $.ajax({
                type: "POST",
                url: URL + '/GetVendor',
                data: '{regno: "' + regno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    if (data.d.Error == "") {
                        $('#<%=txtName.ClientID%>').val(data.d.UserName);
                            $('#<%=txtaddress.ClientID%>').val(data.d.Address);
                            $('#<%=ddl_state.ClientID%>').val(data.d.State);
                            $('#<%=hnd_UserStateID.ClientID%>').val(data.d.State);
                            $('#<%=txtCity.ClientID%>').val(data.d.City);
                            $('#<%=txtPincode.ClientID%>').val(data.d.Pincode);
                            $('#<%=txt_Mobile.ClientID%>').val(data.d.Mobile);
                            GetDistrict(data.d.distt);

                            $('#lbl_FromName').text(data.d.UserName);
                            $('#lbl_FromName').css('color', 'Blue');
                        }
                        else {
                            $('#<%=txtName.ClientID%>').val('');
                            $('#<%=txtaddress.ClientID%>').val('');
                            $('#<%=txt_Mobile.ClientID%>').val('');
                            $('#<%=ddl_state.ClientID%>').val('0');
                            $('#<%=hnd_UserStateID.ClientID%>').val('0');
                            $('#<%=txtCity.ClientID%>').val('');
                            $('#<%=txtPincode.ClientID%>').val('');

                            $('#lbl_FromName').text(data.d.Error);
                            $('#lbl_FromName').css('color', 'red');
                            $('#<%=txt_FromId.ClientID%>').val('');
                        }
                    },
                    error: function (response) {
                        $('#lblName').text("Server error. Time out.!!");
                        $('#lblName').css('color', 'red');
                        $('#<%=txt_FromId.ClientID%>').val('');
                    }
                });
        }


        function GetToId() {
            $('#lblmsg').html('');
            var regno = $('#<%=txt_Toid.ClientID%>').val();
            $('#lbl_ToName').text("");
            if (regno == '') {
                return;
            }
            $.ajax({
                type: "POST",
                url: URL + '/GetUser',
                data: '{regno: "' + regno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#<%=txtName.ClientID%>').val(data.d.UserName);
                            $('#<%=ddlSellerState.ClientID%>').val(data.d.State);
                            $('#lbl_ToName').text(data.d.UserName);
                            $('#lbl_ToName').css('color', 'Blue');
                        }
                        else {
                            $('#<%=txtName.ClientID%>').val('');
                           // $('#<%=txt_Toid.ClientID%>').val('');
                            $('#lbl_ToName').text(data.d.Error);
                            $('#lbl_ToName').css('color', 'red');
                        }
                    },
                    error: function (response) {
                       // $('#<%=txt_Toid.ClientID%>').val('');
                        $('#lbl_ToName').text("Server error. Time out.!!");
                        $('#lbl_ToName').css('color', 'red');
                    }
                });
        }



        function GetDistrict(District) {
            $('#<%=ddl_district.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
            $.ajax({
                type: "POST",
                url: URL + '/GetDistrict',
                data: "{'StateId':'" + $("#<%=ddl_state.ClientID%>").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#<%=ddl_district.ClientID %>").empty().append($("<option></option>").val(0).html('Select District'));
                            PopulateControl(response.d, $("#<%=ddl_district.ClientID%>"));
                            if (District != '') {
                                $("#<%=ddl_district.ClientID%>").val(District);
                        }
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
        }

        function PopulateControl(list, control) {
            if (list.length > 0) {
                control.removeAttr("disabled");
                $.each(list, function () {
                    control.append($("<option></option>").val(this['Value']).html(this['Text']));
                });
            }
            else {
                control.empty().append('<option selected="selected" value="0">Not available<option>');
            }
        }

        function SH_PaymentMode() {
            $('#<%=txtOTP.ClientID %>').removeAttr('disabled');
            $("#<%=ddlpaytype.ClientID %>").empty().append($("<option></option>").val(1).html('Cash'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(2).html('Cheque'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(3).html('Net Banking'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(4).html('DD'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(5).html('Credit Card'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(6).html('Debit Card'));

            PayModeDisplay();
        }

        function PayModeDisplay() {
            var Paymode = $('#<%=ddlpaytype.ClientID%>').val();
            $('#trOTPGen').hide();
            $('#btn_submit').attr('disabled', false);
            if (Paymode == 1) {
                $('#<%=txtbname.ClientID%>').hide();
                    $('#<%=txtDD.ClientID%>').hide();
                    $('#<%=txtDate.ClientID%>').hide();
                }
                else {

                    $('#<%=txtbname.ClientID%>').show();
                    $('#<%=txtDD.ClientID%>').show();
                    $('#<%=txtDate.ClientID%>').show();
            }
        }


        function showdiv() {
            if ($("#div_shipping").is(":hidden")) {
                $("#div_Plus_minus").html('<i class="fa fa-minus"></i>');
                $("#div_shipping").css('display', 'block');
            }
            else {
                $("#div_Plus_minus").html('<i class="fa fa-plus"></i>');
                $("#div_shipping").css('display', 'none');
            }
        }


        function OPTGenerate(flag) {
            var UserName = $('#<%=txt_FromId.ClientID %>').val();
            var Amount = $('#<%=lbl_Net_Amt.ClientID %>').text();

            if (UserName == '') {
                alert("Please Enter User Id.!!");
                $('#<%=txt_FromId.ClientID %>').focus();
                return;
            }
            $('#<%=txtOTP.ClientID %>').val('');
            $.ajax({
                type: "POST",
                url: URL + '/GenerateOTP',
                data: '{UserName: "' + UserName + '", Amount: "' + Amount + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == '0') {
                        $('#trOTPGen').hide();
                        $('#trOTPVerify').show();
                        if (flag == "2") {
                            $('#lblOTPMSG').text("OTP RE-GENERATED.");
                            $('#lblOTPMSG').css('color', 'green');
                        }
                    }
                    return false;
                },
                error: function (response) {
                    $('#lblOTPMSG').text("Server error. Time out..!!");
                }
            });
        }

        function OPTVerift() {
            var UserName = $('#<%=txt_FromId.ClientID %>').val();
            var OTP = $('#<%=txtOTP.ClientID %>').val().trim();
            if (UserName == '') {
                alert("Please Enter User Id.!!");
                $('#<%=txt_FromId.ClientID %>').focus();
                return;
            }
            $.ajax({
                type: "POST",
                url: URL + '/VerifyOTP',
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
                        $('#<%=txtOTP.ClientID %>').attr('disabled', true);
                            $('#btn_submit').attr('disabled', false);
                        }
                        else {
                            $('#lblOTPMSG').text(response.d);
                            $('#lblOTPMSG').css('color', 'red');
                        }
                    },
                    error: function (response) {
                        $('#lblOTPMSG').text("Server error. Time out..!!");
                    }
                });
        }



        function GetProduct() {
            $('#lblmsg').html('');
            var Productcode = $('#<%=txt_Barcode.ClientID%>').val();
            if (Productcode != '') {
                var Userid = $('#<%=txt_Toid.ClientID%>').val();
                    if (Userid == '') {
                        alert("Please Enter FromId.!!");
                        return false;
                    }
                    $.ajax({
                        type: "POST",
                        url: URL + '/GetBarcode',
                        data: '{Productcode: "' + Productcode + '", Userid: "' + Userid + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == "") {
                                BindCartTable();
                                $('#<%=txt_Barcode.ClientID%>').val('');
                                }
                                else if (data.d == "0") {
                                    $('#lblmsg').text("Quantity not available in another batch.!!");
                                    $('#<%=txt_Barcode.ClientID%>').val('');
                                }
                                else if (data.d == "1") {
                                    $('#lblmsg').text("This product already added.!!");
                                    $('#<%=txt_Barcode.ClientID%>').val('');
                                }
                                else if (data.d == "Sessionlogout") {
                                    window.location = "Logout.aspx";
                                }
                                else {
                                    $('#lblmsg').text(data.d);
                                }
                            },
                            error: function (response) {
                                $('#lblmsg').text("Server error. Time out.!!");
                                $('#<%=txt_Barcode.ClientID%>').focus();
                                return false;
                            }
                        });
            }
        }



        function BindCartTable() {

            $('#<%=txt_Barcode.ClientID%>').val('');
            $('#lbl_tbl').text('');
            $.ajax({
                type: "POST",
                url: URL + '/GetCartData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblList').empty().append("<thead><tr>");
                    $('#tblList').append("<th style='width: 2%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>SN</th>");
                    // $('#tblList').append("<th style='width: 4%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Code</th>");
                    $('#tblList').append("<th style='width: 25%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>Products</th>");
                    $('#tblList').append("<th style='width: 16%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>Batch No</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>Rate</th>");
                    $('#tblList').append("<th style='width: 16%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>Quantity</th>");
                    $('#tblList').append("<th style='width: 8%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>Net Amount</th>");
                    // $('#tblList').append("<th style='width: 14%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>Disc</th>");
                    $('#tblList').append("<th style='width: 6%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>Taxable</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>GST(%)</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>GST</th>");
                    //$('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>" + $('#hnd_BVType').val() + "</th>");
                    $('#tblList').append("<th style='width: 10%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'>Gross Amount</th>");
                    $('#tblList').append("<th style='width: 2%; border-bottom: 1px dotted #d3d3d3; background-color:#fcddc3;'><center><span style='color:Red; font-size:x-large;'>&times;</span></center></th>");
                    $('#tblList').append("</tr></thead>");


                    var tbl = '<tbody>';
                    var TotalQty = 0, TotalGST = 0, TotalBV = 0, TotalFPV = 0, TotalAmt = 0, TotalTaxable = 0, NetAmt = 0, GrossWeight = 0;
                    for (var i = 0; i < data.d.length; i++) {

                        GrossWeight = GrossWeight + parseFloat(data.d[i].TotalWeight);
                        TotalQty = TotalQty + parseInt(data.d[i].qty);
                        TotalGST = TotalGST + parseFloat(data.d[i].Totaltaxamt);
                        TotalBV = TotalBV + parseFloat(data.d[i].totalbvamt);
                        TotalFPV = TotalFPV + parseFloat(data.d[i].TotalFPV);
                        TotalAmt = TotalAmt + parseFloat(data.d[i].Gross);
                        TotalTaxable = TotalTaxable + parseFloat(data.d[i].TaxableAmt);
                        NetAmt = NetAmt + parseFloat(data.d[i].totalamt);
                        var Pid = data.d[i].Pid;
                        var batchid = data.d[i].batchid;
                        var Sno = data.d[i].Sno;

                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        //tbl += '<td>' + data.d[i].Pcode + '</td>';
                        tbl += '<td>' + data.d[i].Pcode + ' - ' + data.d[i].pname + '</td>';

                        var ddl_Batch = '<select id="ddl_Batch' + Sno + '" onchange="ChangeBatch(' + Sno + ')" class="dropdown-select form-control" style="width:140px; height: 29px; float: left; padding:0px; font-size:small;">"' + GetBatch(data.d[i].Batch, batchid) + '" </select>';
                        tbl += '<td>' + ddl_Batch + '</td>';
                        // tbl += '<td>' + data.d[i].BatchNo + '</td>';

                        tbl += '<td>' + data.d[i].DPAmt.toFixed(2) + '</td>';

                        tbl += '<td> <span class="fa fa-minus quant" onclick="MinusQty(' + Sno + ')" style="cursor: pointer;"></span> <input type="text" id="qty_' + Sno + '" value="' + data.d[i].qty + '" onchange="UpdateQty(' + Sno + ')" class="form-control input-number text-center" maxlength="4" style="width:50px; height: 29px; float: left; padding:5px;"/> <span class="fa fa-plus quant" onclick="AddQty(' + Sno + ')" style="cursor: pointer;"></span>  <input type="hidden" id="Maxqty_' + Sno + '" value="' + data.d[i].MaxQty + '"> </td>';
                        tbl += '<td>' + data.d[i].Gross.toFixed(2) + '</td>';

                        //var dd = data.d[i].DiscounType;
                        //var Disc_Type = '<select id="ddl_Discount_Type' + Sno + '" onchange="Discount(' + Sno + ')" class="dropdown-select form-control" style="width:38px; height: 29px; float: left; padding:0px; font-size:small; text-align: center;">';
                        //if (data.d[i].DiscounType == "%") {
                        //    Disc_Type += '<option value="Rs">Rs</option>';
                        //    Disc_Type += '<option value="%" selected="selected">%</option></select>';
                        //}
                        //else {
                        //    Disc_Type += '<option value="Rs" selected="selected">Rs</option>';
                        //    Disc_Type += '<option value="%">%</option></select>';
                        //}
                        //tbl += '<td> <input type="text" id="Discount_' + Sno + '" value="' + data.d[i].Discount + '" onchange="Discount(' + Sno + ')" class="form-control text-center" maxlength="5" style="width:50px; height: 29px; float:left; padding:2px;"/>' + Disc_Type + ' </td>';

                        // tbl += '<td>' + data.d[i].Discount + '</td>';

                        tbl += '<td>' + data.d[i].TaxableAmt.toFixed(2) + '</td>';

                        tbl += '<td>' + data.d[i].tax.toFixed(2) + '</td>';

                        tbl += '<td>' + data.d[i].Totaltaxamt.toFixed(2) + '</td>';
                        //tbl += '<td>' + data.d[i].totalbvamt + '</td>';
                        tbl += '<td>' + data.d[i].totalamt.toFixed(2) + '</td>';
                        tbl += '<td><center><a href="#/"> <span style="color:Red; font-size:x-large;" onclick="DeleteProd(' + Sno + ');" title="Remove">&times;</span> </a> </center> </td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    tbl += "<thead><tr style='background-color:#fcddc3;'><th></th> <th>Total :</th>  <th></th> <th></th> <th>" + TotalQty + "</th> <th>" + TotalAmt.toFixed(2) + "</th>   <th> " + TotalTaxable.toFixed(2) + "</th> <th></th> <th>" + TotalGST.toFixed(2) + "</th> <th>" + NetAmt.toFixed(2) + "</th> <th></th> </tr></thead>";
                    $('#tblList').append(tbl);
                    $('#<%=txt_Barcode.ClientID%>').focus();

                        GrossWeight = GrossWeight.toFixed(3);
                        $('#<%=lbl_GrossWeight.ClientID%>').text(GrossWeight);
                        if (data.d.length == 0) {
                            $('.js-term-condition').hide();
                            $('#div_PaymentDetails').hide();
                            $('#div_ProdDetails').hide();
                            $('#tblList').empty();

                            $('#lbl_tbl').text('Cart is empty.....');
                            $('#<%=txt_Barcode.ClientID%>').focus();
                        $('#<%=lbl_GrossWeight.ClientID%>').text("0.00");
                            return false;
                        }
                        if (data.d.length > 0) {
                            /* Show Calculation */
                            $('#<%=lbl_Prod_Val.ClientID%>').text(TotalTaxable.toFixed(2));
                        $('#<%=lbl_Gst_Amt.ClientID%>').text(TotalGST.toFixed(2));

                        $('#<%=lbl_Net_Amt.ClientID%>').text(NetAmt.toFixed(2));
                            $('#hnd_TotalAmt').val(Math.round(NetAmt.toFixed(2)));

                            $('#lbl_GrossAmount_Upper').text("Gross Amount(Rs): " + NetAmt.toFixed(2));

                            $('#div_ProdDetails').show();

                            $('.js-term-condition').show();
                            $('#div_PaymentDetails').show();
                            $('.js-term-condition').show("slow");
                            $('#div_PaymentDetails').show("slow");

                            Update_Discount_Delcharge();

                        }
                    },
                    error: function (data) {
                        // $('#processing').hide();
                        alert("Server error. Time out.!!");
                        $('#<%=txt_Barcode.ClientID%>').focus();
                        return false;
                    }
                });
        }


        function GetBatch(Batch, batchid) {
            var BatchString = "";
            if (Batch != '') {
                var MainRow = Batch.split('~');
                if (MainRow.length > 0) {
                    for (var i = 0; i < MainRow.length; i++) {
                        if (MainRow[i] != null && MainRow[i] != '' && MainRow[i] != ' ' && MainRow[i] != 'undefined') {
                            var SubRow = MainRow[i].split(',');
                            if (SubRow.length > 0) {
                                if (SubRow[0] != batchid) {
                                    BatchString = BatchString + "<option value=" + SubRow[0] + ">" + SubRow[1] + "</option>";
                                }
                                else {
                                    BatchString = BatchString + "<option value=" + SubRow[0] + " selected='selected'>" + SubRow[1] + "</option>";
                                }

                            }
                        }
                    }
                }
            }
            return BatchString;
        }



        function Discount(Sno) {
            $('#lblmsg').html('');
            var Discount = $('#Discount_' + Sno).val();
            Discount = parseFloat((Discount == '' || Discount == null || isNaN(parseFloat(Discount))) ? 0 : Discount);
            var DiscounType = $('#ddl_Discount_Type' + Sno).val();
            if (DiscounType == "%" && Discount > 100) {
                $('#Discount_' + Sno).val(100);
                Discount = 100;
            }

            $.ajax({
                type: "POST",
                url: URL + '/UpdateDiscount',
                data: '{Sno: "' + Sno + '", Discount: "' + Discount + '", DiscounType: "' + DiscounType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#lblmsg').text(data.d);
                    BindCartTable();
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                }
            });
        }



        function ChangeBatch(Sno) {
            var FromId = $('#<%=txt_Toid.ClientID%>').val();
            var batchid = $('#ddl_Batch' + Sno).val();
            if (FromId == '') {
                alert("Please Enter FromId.!!");
                return false;
            }
            $('#lblmsg').html('');
            if (Sno <= 0) {
                $('#lblmsg').text("Server error. Time out.!!");
                return false;
            }
            if (batchid <= 0) {
                $('#lblmsg').text("Server error. Time out.!!");
                return false;
            }

            $.ajax({
                type: "POST",
                url: URL + '/UpdateBatch',
                data: '{Sno: "' + Sno + '", batchid: "' + batchid + '", FromId: "' + FromId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "") {
                        BindCartTable();
                        return;
                    }
                    else {
                        $("#hnd_Inv").val(data.d);

                        BindCartTable();
                        $('#lblmsg').text($("#hnd_Inv").val());

                    }
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                }
            });
        }


        function MinusQty(Sno) {
            var Qty = $('#qty_' + Sno).val();
            $('#qty_' + Sno).val(parseInt(Qty) - 1);
            UpdateQty(Sno);
        }

        function AddQty(Sno) {
            var Qty = $('#qty_' + Sno).val();
            $('#qty_' + Sno).val(parseInt(Qty) + 1);
            UpdateQty(Sno);
        }

        function UpdateQty(Sno) {
            $('#lblmsg').html('');
            if (Sno <= 0) {
                $('#lblmsg').text("Server error. Time out.!!");
                return false;
            }

            var Maxqty = $('#Maxqty_' + Sno).val();
            var Qty = $('#qty_' + Sno).val();
            //if (parseInt(Qty) > parseInt(Maxqty)) {
            //    $('#qty_' + Pid).val(Maxqty);
            //    Qty = Maxqty;
            //    $('#lblmsg').text("Maximum Allowed :" + Maxqty);
            //}

            var Userid = $('#<%=txt_Toid.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: URL + '/UpdateQty',
                data: '{Sno: "' + Sno + '", Qty: "' + Qty + '", Userid: "' + Userid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "") {
                        BindCartTable();
                        return;
                    }
                    else {
                        $('#lblmsg').text(data.d);
                    }
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                }
            });
        }



        function DeleteProd(Sno) {
            $('#lblmsg').html('');

            $.ajax({
                type: "POST",
                url: URL + '/DeleteProd',
                data: '{Sno: "' + Sno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "") {
                        BindCartTable();
                        return;
                    }
                    else {
                        $('#lblmsg').text(data.d);
                    }
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                }
            });
        }

        function Update_Discount_Delcharge() {

            var Hnd_NetAmt = $('#hnd_TotalAmt').val();
            var discount = $('#<%=txt_Discount.ClientID%>').val();
            discount = parseFloat((discount == '' || discount == null || isNaN(parseFloat(discount))) ? 0 : discount);
            if (discount > parseFloat(Hnd_NetAmt)) {
                alert("Discount cann't greater than Net Amount.!!");
                return;
            }

            var GST = $('#ddl_GST').val();
            GST = parseFloat((GST == '' || GST == null || isNaN(parseFloat(GST))) ? 0 : GST);
            var delCharge = $('#<%=txt_DelCharge.ClientID%>').val();
            delCharge = parseFloat((delCharge == '' || delCharge == null || isNaN(parseFloat(delCharge))) ? 0 : delCharge);
            if (delCharge < 0)
                delCharge = 0;
            delCharge = parseFloat(delCharge) + parseFloat((delCharge * GST / 100));
            $('#<%=lbl_DeliveryAmount.ClientID%>').text(delCharge.toFixed(2));
            var Net_Amt = (parseFloat(Hnd_NetAmt) + parseFloat(delCharge)) - parseFloat(discount);
            $('#<%=lbl_Net_Amt.ClientID%>').text(Net_Amt.toFixed(2));

            $('#lbl_GrossAmount_Upper').val("Gross Amount(Rs): " + Net_Amt.toFixed(2));
            return;
        }




    </script>
    <style type="text/css">
        .quant {
            float: left;
            border: 1px solid #ebebea;
            padding: 7px 3px;
            font-size: 11px;
            margin-top: 6px;
        }

        tr, th {
            font-size: 13px;
        }

        td {
            padding: 2px !important;
        }

        .billing-cart {
            text-align: left;
            background: #fcddc3;
            margin: 15px 0;
            padding: 10px;
            color: #000;
        }
    </style>
</asp:Content>

