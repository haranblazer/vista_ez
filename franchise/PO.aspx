<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="PO.aspx.cs" Inherits="franchise_OP" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script> var $JJ = $.noConflict(true); </script>
    <script type="text/javascript">

        $JJ(function () {
            //$.noConflict(true);
            BindCartTable();
            if ($('#<%=txt_Userid.ClientID%>').val() != "") {
                GetUserId($('#<%=txt_Userid.ClientID%>').val())
            }
        });


        function GetProduct() {
            $('#lblmsg').html('');
            var Pid = $('#<%=txt_Barcode.ClientID%>').val();
            if (Pid != '') {

                $.ajax({
                    type: "POST",
                    url: 'PO.aspx/GetBarcode',
                    data: '{Productcode: "' + Pid + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "") {
                            BindCartTable();
                            $('#<%=txt_Barcode.ClientID%>').val('');
                        }
                        else if (data.d == "0") {
                            $('#lblmsg').text("Quantity not Available.!!");
                            $('#<%=txt_Barcode.ClientID%>').val('');
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
            var ClosePO = $('#<%=hnd_ClosePO.ClientID%>').val();
            $('#<%=txt_Barcode.ClientID%>').val('');
            $('#lbl_tbl').text('');
            $.ajax({
                type: "POST",
                url: 'PO.aspx/GetCartData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblList').empty().append("<thead><tr>");
                    $('#tblList').append("<th style='width: 1%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>SN</th>");
                    //$('#tblList').append("<th style='width: 4%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>Code</th>");
                    $('#tblList').append("<th style='width: 30%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>Prod Name</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>Batch No</th>");
                    $('#tblList').append("<th style='width: 6%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>Offer</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>Rate</th>");
                    $('#tblList').append("<th style='width: 14%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>Ordered/ Closing/ Rcv'd Qty</th>");
                    $('#tblList').append("<th style='width: 11%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'><center>Quantity</center></th>");
                    $('#tblList').append("<th style='width: 9%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>Gross</th>");
                    // $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Disc</th>");
                    //$('#tblList').append("<th style='width: 9%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Taxable</th>");
                    $('#tblList').append("<th style='width: 4%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>GST(%)</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>GST</th>");
                    
                    //$('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>FPV</th>");
                    $('#tblList').append("<th style='width: 8%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>Net Amount</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'>RPV</th>");
                    $('#tblList').append("<th style='width: 2%; border-bottom: 1px dotted #fcddc3; background-color:#fcddc3;'><center><span style='color:Red; font-size:x-large;'>&times;</span></center></th>");
                    $('#tblList').append("</tr></thead>");

                    var tbl = '<tbody>';
                    var TotalQty = 0, TotalGST = 0, TotalBV = 0, TotalFPV = 0, TotalAmt = 0, TotalTaxable = 0, NetAmt = 0;
                    for (var i = 0; i < data.d.length; i++) {

                        TotalQty = TotalQty + parseInt(data.d[i].qty);
                        TotalGST = TotalGST + parseFloat(data.d[i].Totaltaxamt);
                        TotalBV = TotalBV + parseFloat(data.d[i].totalbvamt);
                        TotalFPV = TotalFPV + parseFloat(data.d[i].TotalFPV);
                        TotalAmt = TotalAmt + parseFloat(data.d[i].Gross);
                        TotalTaxable = TotalTaxable + parseFloat(data.d[i].TaxableAmt);
                        NetAmt = NetAmt + parseFloat(data.d[i].totalamt);
                        var Pid = data.d[i].Pid;
                        var batchid = data.d[i].batchid;
                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        //tbl += '<td>' + data.d[i].Pcode + '</td>';
                        tbl += '<td style="text-align: left;">' + data.d[i].Pcode + '-' + data.d[i].pname + '</td>';
                        tbl += '<td>' + data.d[i].BatchNo + '</td>';

                        if (data.d[i].OFFERID == "0") {
                            tbl += '<td><span class="dotGrey"></span></td>';
                        } else {
                            tbl += '<td><span class="dotGreen"></span></td>';
                        }


                        tbl += '<td>' + data.d[i].DPAmt + '</td>';
                        tbl += '<td>' + data.d[i].ReqQnt + '/ ' + data.d[i].MaxQty + '/ ' + data.d[i].Received + '</td>';
                        if (ClosePO == "0") {
                            tbl += '<td> <span class="fa fa-minus quant" onclick="MinusQty(' + batchid + ')" style="cursor: pointer;"></span> <input type="text" id="qty_' + batchid + '" value="' + data.d[i].qty + '" onchange="UpdateQty(' + batchid + ')" class="form-control input-number text-center" maxlength="4" style="width:50px; height: 29px; float: left; padding:5px;"/> <span class="fa fa-plus quant" onclick="AddQty(' + batchid + ')" style="cursor: pointer;"></span>  <input type="hidden" id="Maxqty_' + batchid + '" value="' + data.d[i].MaxQty + '"> </td>';
                        }
                        else {
                            tbl += '<td>' + data.d[i].qty + '</td>';
                        }
                        tbl += '<td>' + data.d[i].Gross + '</td>';

                        //tbl += '<td>' + data.d[i].Discount + '</td>';

                        //tbl += '<td>' + data.d[i].TaxableAmt + '</td>';


                        //var GST_AMT = '<select id="GST_' + batchid + '" onchange="GST(' + batchid + ')" class="dropdown-select form-control" style="width:40px; height: 29px; float: left; padding:0px;">';
                        //if (data.d[i].tax == "0") {
                        //    GST_AMT += '<option value="0" selected="selected">0</option>';
                        //}
                        //else {
                        //    GST_AMT += '<option value="0">0</option>';
                        //}

                        //if (data.d[i].tax == "5") {
                        //    GST_AMT += '<option value="5" selected="selected">5</option>';
                        //}
                        //else {
                        //    GST_AMT += '<option value="5">5</option>';
                        //}

                        //if (data.d[i].tax == "12") {
                        //    GST_AMT += '<option value="12" selected="selected">12</option>';
                        //}
                        //else {
                        //    GST_AMT += '<option value="12">12</option>';
                        //}

                        //if (data.d[i].tax == "18") {
                        //    GST_AMT += '<option value="18" selected="selected">18</option>';
                        //}
                        //else {
                        //    GST_AMT += '<option value="18">18</option>';
                        //}

                        //if (data.d[i].tax == "28") {
                        //    GST_AMT += '<option value="28" selected="selected">28</option>';
                        //}
                        //else {
                        //    GST_AMT += '<option value="28">28</option>';
                        //}
                        //GST_AMT += '</select>';

                        //if (ClosePO == "0") {
                        //    tbl += '<td>' + GST_AMT + '</td>';
                        //}
                        //else {
                        //    tbl += '<td>' + data.d[i].tax + '</td>';
                        //}

                        tbl += '<td>' + data.d[i].tax + '</td>';

                        tbl += '<td>' + data.d[i].Totaltaxamt + '</td>';
                        // tbl += '<td>' + data.d[i].TotalFPV + '</td>';
                        tbl += '<td>' + data.d[i].totalamt + '</td>';
                        tbl += '<td>' + data.d[i].totalbvamt + '</td>';
                       
                        tbl += '<td><center><a href="#/"> <span style="color:Red; font-size:x-large;" onclick="DeleteProd(' + batchid + ');" title="Remove">&times;</span> </a> </center> </td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    tbl += "<thead><tr style='background-color:#fcddc3;'>  <th></th> <th>Total :</th>  <th></th> <th></th> <th></th> <th></th> <th>" + TotalQty + "</th> <th>" + TotalAmt.toFixed(2) + "</th>  <th> 0</th> <th>" + TotalGST.toFixed(2) + "</th> <th>" + NetAmt.toFixed(2) + "</th> <th>" + TotalBV.toFixed(2) + "</th>  <th></th> </tr></thead>";
                    //<th>" + Math.round(TotalBV) + "</th> <th> " + TotalTaxable.toFixed(2) + "</th>
                    $('#tblList').append(tbl);
                    $('#<%=txt_Barcode.ClientID%>').focus();
                    if (data.d.length == 0) {
                        $('.js-term-condition').hide();
                        $('#div_PaymentDetails').hide();
                        $('#div_ProdDetails').hide();
                        $('#tblList').empty();
                        $('#lbl_tbl').text('Cart is empty.....');
                        $('#<%=txt_Barcode.ClientID%>').focus();
                        return false;
                    }
                    if (data.d.length > 0) {
                        /* Show Calculation */
                        $('#<%=lbl_Prod_Val.ClientID%>').text(TotalAmt.toFixed(2));
                        $('#<%=lbl_Gst_Amt.ClientID%>').text(TotalGST.toFixed(2));
                        $('#<%=lbl_Net_Amt.ClientID%>').text(NetAmt.toFixed(2));

                        $('#lbl_GrossAmount_Upper').text("Gross Amount(Rs): " + $('#<%=lbl_Net_Amt.ClientID%>').text());


                        $('#hnd_TotalAmt').val(NetAmt.toFixed(2));

                        $('#div_ProdDetails').show();
                        $('.js-term-condition').show();
                        $('#div_PaymentDetails').show();
                        $('.js-term-condition').show("slow");
                        $('#div_PaymentDetails').show("slow");
                        if (ClosePO != "0") {
                            $('#btn_submit').attr('disabled', true);
                        }
                        Update_Discount_Delcharge();
                    }
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
                    return false;
                }
            });
        }



        function GST(batchid) {
            $('#lblmsg').html('');
            var GST = $('#GST_' + batchid).val();
            GST = parseFloat((GST == '' || GST == null || isNaN(parseFloat(GST))) ? 0 : GST);
            $.ajax({
                type: "POST",
                url: 'PO.aspx/UpdateGST',
                data: '{batchid: "' + batchid + '", GST: "' + GST + '"}',
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


        function MinusQty(batchid) {
            var Qty = $('#qty_' + batchid).val();
            $('#qty_' + batchid).val(parseInt(Qty) - 1);
            UpdateQty(batchid);
        }

        function AddQty(batchid) {
            var Qty = $('#qty_' + batchid).val();
            $('#qty_' + batchid).val(parseInt(Qty) + 1);
            UpdateQty(batchid);
        }

        function UpdateQty(batchid) {

            $('#lblmsg').html('');
            if (batchid <= 0) {
                $('#lblmsg').text("Server error. Time out.!!");
                return false;
            }

            var Maxqty = $('#Maxqty_' + batchid).val();
            var Qty = $('#qty_' + batchid).val();
            if (parseInt(Qty) > parseInt(Maxqty)) {
                $('#qty_' + batchid).val(Maxqty);
                Qty = Maxqty;
                $('#lblmsg').text("Stock in hand : " + Maxqty);
            }


            $.ajax({
                type: "POST",
                url: 'PO.aspx/UpdateQty',
                data: '{batchid: "' + batchid + '", Qty: "' + Qty + '"}',
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



        function DeleteProd(batchid) {
            $('#lblmsg').html('');

            $.ajax({
                type: "POST",
                url: 'PO.aspx/DeleteProd',
                data: '{batchid: "' + batchid + '"}',
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

            $('#lblmsg').html('');
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
            delCharge = parseFloat(delCharge) + parseFloat((delCharge * GST / 100));
            $('#<%=lbl_DeliveryAmount.ClientID%>').text(delCharge);
            $('#<%=lbl_Net_Amt.ClientID%>').text((parseFloat(Hnd_NetAmt) + parseFloat(delCharge)) - parseFloat(discount).toFixed(2));
            $('#lbl_GrossAmount_Upper').text("Gross Amount(Rs): " + $('#<%=lbl_Net_Amt.ClientID%>').text());
            return;
        }
    </script>
    <input type="hidden" id="hnd_Inv" value="" />
    <input type="hidden" id="hnd_TotalAmt" value="0" />
    <asp:HiddenField ID="hnd_ClosePO" runat="server" Value="0" />
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Purchase Order Approve</h4>
    </div>


    <div class="clearfix">
    </div>
    <div class="row" style="padding-bottom: 10px;">
        <div class="col-md-2">
            <asp:TextBox ID="txt_PONo" runat="server" CssClass="form-control" placeholder="Select PO No." Enabled="false"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Userid" runat="server" onchange="GetUserId(this);" CssClass="form-control" Enabled="false"
                placeholder="Enter User Id"></asp:TextBox>
            <span id="lblName" style="font-size: 10px;"></span>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Barcode" runat="server" CssClass="form-control" placeholder="Select Product..."></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:DropDownList ID="ddlSellerState" runat="server" CssClass="form-control" Enabled="false">
                <asp:ListItem Value="0">Seller State</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-4">
            <asp:CheckBox ID="chk_Status" runat="server" Text="&nbsp;Close PO" />
            <br />
            <span style="font-size: smaller; color: red;">After PO closed you can't send any Item.</span>
        </div>

    </div>
    <div class="clearfix">
    </div>
    <div class="row" style="padding-bottom: 10px; height: 35px;">
        <div id="lblmsg" class="col-sm-12 text-center" style="color: Red;">
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="row" style="padding-bottom: 10px;">
        <div class="col-sm-3"><span id="lbl_GrossAmount_Upper" style="font-size: 17px; color: blue;"></span></div>
        <div class="col-sm-3"><span id="lbl_RPVTPV_Upper" style="font-size: 17px; color: blue;"></span></div>

        <div class="col-md-3"></div>
        <div class="col-md-3"></div>
    </div>

    <div class="clearfix">
    </div>
    <div class="table-responsive">
        <table id="tblList" class="table" style="width: 100%; border-collapse: collapse;">
        </table>
        <center>
            <span id="lbl_tbl" style="color: Red; padding: 2px;"></span>
        </center>
    </div>

    <div class="clearfix">
    </div>

    <div class="row">
        <div class="col-md-6" id="div_ProdDetails" style="display: none;">
            <%--<div class="row" style="padding-bottom: 10px;">
                <div class="col-sm-12">
                    <a href="javascript:;" onclick="javascript:showdiv();"><span style="float: left;">Shipping
                            Details </span>
                        <div id="div_Plus_minus" style="float: left; padding: 3px;">
                        </div>
                    </a>
                </div>
            </div>
            <div class="clearfix">
            </div>--%>
            <div id="div_shipping">
                <div class="row" style="padding-bottom: 10px;">
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Enter Your Name"></asp:TextBox>
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
                    <a onclick="OPTGenerate(1)" class="btn btn-default">Generate OTP</a>
                </div>
                <div class="col-sm-6">
                    <div id="trOTPVerify" style="display: none">
                        ENTER OTP :
                             <asp:TextBox ID="txtOTP" runat="server" MaxLength="10" CssClass="form-control" Style="width: 120px;"></asp:TextBox>
                        <a onclick="OPTVerift()" class="btn btn-info">Verify</a>
                        <br />
                        <span id="lblOTPMSG"></span>
                        <br />
                        <div id="divRegenerate">
                            <a onclick="OPTGenerate(2)">Re-Generate OTP</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix">
            </div>


            <div class="row" style="padding-bottom: 10px;">
                <div class="col-sm-12">
                    <asp:TextBox ID="txt_UserRemark" runat="server" MaxLength="500" CssClass="form-control"
                        TextMode="MultiLine" placeholder="Remark" Style="height: 110px;"></asp:TextBox>
                </div>
            </div>



        </div>

        <div class="col-md-6">

            <div id="div_PaymentDetails" style="display: none;">
                <div class="row">
                    <div class="col-md-9 col-xs-8">

                        <asp:Label ID="lbl_baltext" runat="server" CssClass="control-label form-control">F-Wallet Balance</asp:Label>

                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_Bal" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>

                    <div class="clearfix"></div>


                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Gross
                        </label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_Prod_Val" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>
                    <div class="col-md-2 col-sm-2">
                    </div>

                    <div class="clearfix">
                    </div>

                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            GST
                        </label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_Gst_Amt" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>


                    <div class="clearfix">
                    </div>


                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">FPV </label>
                    </div>
                    <div class="col-md-3 col-xs-4 ">
                        <asp:Label ID="lbl_FPV" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>

                    <div class="clearfix"></div>


                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Scheme</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_SchemeAmt" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>




                    <div class="clearfix">
                    </div>

                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Discount</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:TextBox ID="txt_Discount" runat="server" CssClass="form-control"
                            Font-Size="Medium" onchange="Update_Discount_Delcharge()">0</asp:TextBox>
                    </div>


                    <div class="clearfix">
                    </div>

                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Delivery Charge</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <select id="ddl_GST" onchange="Update_Discount_Delcharge()" class="dropdown-select form-control"
                            style="width: 40px; padding: 0px; float: left;">
                            <option value="0">0</option>
                            <option value="18" selected="selected">18</option>
                        </select>
                        <asp:TextBox ID="txt_DelCharge" runat="server" CssClass="form-control"
                            Font-Size="Medium" Width="60px" onchange="Update_Discount_Delcharge()" Style="padding: 4px; float: left;">0</asp:TextBox>
                    </div>


                    <div class="clearfix">
                    </div>

                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Net Delivery Charge</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_DeliveryAmount" runat="server" CssClass="control-label form-control" Font-Bold="true">0</asp:Label>
                    </div>
                    <div class="col-md-2 col-sm-2">
                    </div>

                    <div class="clearfix">
                    </div>

                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Net Amount(Rs)</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:Label ID="lbl_Net_Amt" runat="server" CssClass="control-label form-control" Font-Bold="true">0</asp:Label>
                    </div>
                    <div class="col-md-2 col-sm-2">
                    </div>

                    <div class="clearfix">
                    </div>

                    <div class="col-md-9 col-xs-8">
                        <label class="control-label form-control">
                            Adjustment Amount</label>
                    </div>
                    <div class="col-md-3 col-xs-4">
                        <asp:TextBox ID="txt_Adjustment" runat="server" Enabled="false" CssClass="form-control"
                            Font-Size="Medium">0</asp:TextBox>
                    </div>
                    <div class="col-md-2 col-sm-2">
                    </div>

                    <div class="clearfix">
                    </div>


                    <div class="col-md-4 col-xs-4">
                        <input type="button" id="btn_submit" value="Save Details" onclick="return Generate_Inv()"
                            class="btn btn-primary btn-block" />
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
    <hr />
    <div class="col-md-12 js-term-condition" style="display: none">
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


    <div class="clearfix"></div>
    <div id="divProductcode" style="display: none;" runat="server"></div>
    <input type="hidden" id="hnd_Url" value="" />

    <asp:HiddenField ID="hnd_Dist" runat="server" Value="0" />
    <%--  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
        <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(function () {--%>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
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
        $J(function () {
            SH_PaymentMode();
            showdiv();
            PayModeDisplay();

            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
            //$('#<%=txt_Barcode.ClientID%>').autocomplete(Productcode);
            $J('#<%=txt_Barcode.ClientID%>').autocomplete({ source: Productcode });

            if ($('#<%=hnd_Dist.ClientID%>').val() != "0") {
                GetDistrict($('#<%=hnd_Dist.ClientID%>').val());
            }


        });

        function closePopup() {
            $('.basicModal').hide();
            window.location = window.location.href;
        }

        function Copy() {
            var text = $("#hnd_Url").val();
            var sampleTextarea = document.createElement("textarea");
            document.body.appendChild(sampleTextarea);
            sampleTextarea.value = text; //save main text in it
            sampleTextarea.select(); //select textarea contenrs
            document.execCommand("copy");
            document.body.removeChild(sampleTextarea);
            ///alert("Copied the text: " + text);
            $("#btn_copy").val('Copied');
        }

        function Generate_Inv() {
            $('#lblmsg').html('');
            var MSG = "";
            var PONo = $('#<%=txt_PONo.ClientID%>').val(),
                UserId = $('#<%=txt_Userid.ClientID%>').val(),
                Discount = $('#<%=txt_Discount.ClientID%>').val(),
                DelCharge = $('#<%=lbl_DeliveryAmount.ClientID%>').text(),
                User_State = $('#<%=ddl_state.ClientID%>').val(),
                Admin_State = $('#<%=ddlSellerState.ClientID%>').val(),
                paymode = $('#<%=ddlpaytype.ClientID%> option:selected').text(),
                bankname = $('#<%=txtbname.ClientID%>').val(),
                checkno = $('#<%=txtDD.ClientID%>').val(),
                CheDate = $('#<%=txtDate.ClientID%>').val(),
                toAdd = $('#<%=txtUserName.ClientID%>').val() + "<br/>" + $('#<%=txtaddress.ClientID%>').val() + ", " + $('#<%=ddl_state.ClientID%> option:selected').text() + ",  " + $('#<%=ddl_state.ClientID%> option:selected').text() + ", " + $('#<%=txtCity.ClientID%>').val() + ", " + $('#<%=txtPincode.ClientID%>').val() + " <br/>Mobile No:" + $('#<%=txt_Mobile.ClientID%>').val(),
                GSTNo = "",
                UserRemark = $('#<%=txt_UserRemark.ClientID%>').val(),
                SellerState = $('#<%=ddlSellerState.ClientID%> option:selected').text(),
                PlaseOfSuply = $('#<%=ddl_state.ClientID%> option:selected').text(),

                ClosePO = $('#<%= chk_Status.ClientID %>').is(':checked') == true ? "1" : "0";

            if ($('#<%=ddlpaytype.ClientID%>').val() == "7") {
                paymode = "Wallet";
            }

            Discount = parseFloat((Discount == '' || Discount == null || isNaN(parseFloat(Discount))) ? 0 : Discount);
            DelCharge = parseFloat((DelCharge == '' || DelCharge == null || isNaN(parseFloat(DelCharge))) ? 0 : DelCharge);


            if (PONo == "") {
                MSG += "\n Please Enter PO No.!";
                $('#<%=txt_PONo.ClientID%>').focus();
            }

            if (UserId == "") {
                MSG += "\n Please Enter User Id.!";
                $('#<%=txt_Userid.ClientID%>').focus();
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
                url: 'PO.aspx/GenerateInv',
                data: '{PONo: "' + PONo + '",UserId: "' + UserId + '", Discount: "' + Discount + '", DelCharge: "' + DelCharge + '", User_State: "' + User_State + '", Admin_State: "' + Admin_State + '", paymode: "' + paymode + '", bankname: "' + bankname
                    + '", checkno: "' + checkno + '", CheDate: "' + CheDate + '", toAdd: "' + toAdd + '", GSTNo: "' + GSTNo + '", PlaseOfSuply: "' + PlaseOfSuply + '", SellerState: "' + SellerState + '", ClosePO: "' + ClosePO + '", UserRemark: "' + UserRemark + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $("#btn_submit").val("Save Details");
                    $('#btn_submit').attr('disabled', false);
                    if (data.d.Error == "") {
                        $("#hnd_Inv").val(data.d.InvoiceNo);
                        $("#hnd_Url").val(data.d.Url);
                        $('#<%=txt_Userid.ClientID%>').val('');
                        $('#<%=txt_Discount.ClientID%>').val(0);
                        $('#<%=txt_Adjustment.ClientID%>').val(0);

                        $('#<%=ddlSellerState.ClientID%>').val(0);
                        $('#<%=ddl_state.ClientID%>').val(0);

                        BindCartTable();
                        $('#lbl_tbl').text('');

                        $('#div_Model_Msg').html("Invoice Generated Successfully. Invoice Number is : " + $("#hnd_Inv").val() + "<br/> <a href='" + $("#hnd_Url").val() + "' style='color:blue' target='_blank'>" + $("#hnd_Url").val() + "</a> <span> <input type='button' id='btn_copy' class='btn btn-primary btn-xxs' value='Copy' style='min-height: 0px; width:122px; font-size:14px;' onclick='Copy()' /> </span>");
                        $(".basicModal").show();

                        //alert("Invoice Generated Successfully. Invoice Number is : " + $("#hnd_Inv").val());
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



        function GetUserId(Userid) {
            $('#lblmsg').html('');
            //Userid = Userid.value;
            $('#<%=lbl_Bal.ClientID%>').text('0');
            $('#lblName').text("");
            if (Userid != '') {

                $.ajax({
                    type: "POST",
                    url: 'PO.aspx/GetUser',
                    data: '{Userid: "' + Userid + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.Error == "") {
                            <%--$('#<%=txtUserName.ClientID%>').val(data.d.UserName);
                                $('#<%=txtaddress.ClientID%>').val(data.d.Address);
                                $('#<%=ddl_state.ClientID%>').val(data.d.State);
                                $('#<%=txtCity.ClientID%>').val(data.d.City);
                                $('#<%=txtPincode.ClientID%>').val(data.d.Pincode);--%>
                            $('#<%=ddlSellerState.ClientID%>').val(data.d.AdminState);
                            $('#lblName').text(data.d.UserName);
                            $('#lblName').css('color', 'Blue');
                            if ($('#<%=ddlpaytype.ClientID%>').val() == "7") {
                                GetBalance();
                            }
                        }
                        else {
                                <%--$('#<%=txtUserName.ClientID%>').val('');
                                $('#<%=txtaddress.ClientID%>').val('');
                                $('#<%=ddl_state.ClientID%>').val('');
                                $('#<%=txtCity.ClientID%>').val('');
                                $('#<%=txtPincode.ClientID%>').val('');--%>

                            $('#lblName').text(data.d.Error);
                            $('#lblName').css('color', 'red');
                            $('#<%=txt_Userid.ClientID%>').val('');
                        }
                    },
                    error: function (response) {
                        $('#lblName').text("Server error. Time out.!!");
                        $('#lblName').css('color', 'red');
                        $('#<%=txt_Userid.ClientID%>').val('');
                    }
                });
            }
        }


        function SH_PaymentMode() {
              <%--  $("#<%=ddlpaytype.ClientID %>").empty().append($("<option></option>").val(1).html('Cash')); --%>
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(2).html('Cheque'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(3).html('Net Banking'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(4).html('DD'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(5).html('Credit Card'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(6).html('Debit Card'));
            $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(7).html('F-Wallet'));
        }

        function ResetCart() {
            SH_PaymentMode();
            $.ajax({
                type: "POST",
                url: 'PO.aspx/ResetCart',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "") {
                        BindCartTable();
                        $('#<%=txt_Userid.ClientID%>').val('');
                    }
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                }
            });
        }

        function PayModeDisplay() {
            var Paymode = $('#<%=ddlpaytype.ClientID%>').val();
            $('#trOTPGen').hide();
            $('#<%=lbl_Bal.ClientID%>').text(0);
            $('#btn_submit').attr('disabled', false);
            if (Paymode == 1) {
                $('#<%=txtbname.ClientID%>').hide();
                $('#<%=txtDD.ClientID%>').hide();
                $('#<%=txtDate.ClientID%>').hide();
            }
            else if (Paymode == 7) {
                $('#<%=txtbname.ClientID%>').hide();
                $('#<%=txtDD.ClientID%>').hide();
                $('#<%=txtDate.ClientID%>').hide();
                $('#trOTPGen').show();
                $('#btn_submit').attr('disabled', true);
                GetBalance();
            }
            else {
                $('#<%=txtbname.ClientID%>').show();
                $('#<%=txtDD.ClientID%>').show();
                $('#<%=txtDate.ClientID%>').show();
            }
        }



        function GetBalance() {

            $.ajax({
                type: "POST",
                url: 'PO.aspx/GetBalanceUser',
                data: '{RegNo: "' + $('#<%=txt_Userid.ClientID%>').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#<%=lbl_Bal.ClientID%>').text(data.d);
                },
                error: function (response) {
                }
            });
        }


        function OPTGenerate(flag) {
            var UserName = $('#<%=txt_Userid.ClientID %>').val();
            var Amount = $('#<%=lbl_Net_Amt.ClientID %>').text();

            if (UserName == '') {
                alert("Please Enter User Id.!!");
                $('#<%=txt_Userid.ClientID %>').focus();
                return;
            }
            $('#<%=txtOTP.ClientID %>').val('');
            $.ajax({
                type: "POST",
                url: 'PO.aspx/GenerateOTP',
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
                    $('#lblmsgcoupon').text("Server error. Time out..!!");
                }
            });
        }

        function OPTVerift() {
            var UserName = $('#<%=txt_Userid.ClientID %>').val();
            var OTP = $('#<%=txtOTP.ClientID %>').val().trim();
            if (UserName == '') {
                alert("Please Enter User Id.!!");
                $('#<%=txt_Userid.ClientID %>').focus();
                return;
            }
            $.ajax({
                type: "POST",
                url: 'PO.aspx/VerifyOTP',
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
                    $('#lblmsgcoupon').text("Server error. Time out..!!");
                }
            });
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


        function GetDistrict(District) {
            $('#<%=ddl_district.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetDistrict',
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



    </script>


    <div class="modal fade  basicModal show" tabindex="-1" style="padding-right: 17px; background: #000000ab;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content" style="background: #dbdbdb;">
                <div class="modal-header pb-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup()" style="right: 7px; position: absolute; top: 8px; font-size: 20px;">
                    </button>
                    <div class="icon-box">
                        <i class="fa fa-check"></i>
                    </div>
                    <h4 class="modal-title w-100">Success!</h4>
                </div>
                <div class="modal-body pb-0">
                    <p id="div_Model_Msg"></p>
                </div>
            </div>
        </div>
    </div>



    <style type="text/css">
        .quant {
            float: left;
            border: 1px solid #ebebea;
            padding: 8px 3px;
            font-size: 11px;
            margin-top: 6px;
            height: 28px;
        }

        tr, th {
            font-size: 13px;
        }

        td {
            padding: 2px !important;
        }

        .dotGreen {
            height: 18px;
            width: 18px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 18px;
            width: 18px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>
</asp:Content>


