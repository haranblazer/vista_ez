<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="BarcodeBilling.aspx.cs" Inherits="secretadmin_BarcodeBilling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(function () {
            jQuery.noConflict(true);
            BindCartTable();
            if ($('#<%=txt_Userid.ClientID%>').val() != "") {
                GetUserId($('#<%=txt_Userid.ClientID%>').val())
            }
        });


        function GetProduct() {
          
            $('#lblmsg').html('');
            var Pid = $('#<%=txt_Barcode.ClientID%>').val();
           
            if (Pid != '') {
                $('#<%=txt_Barcode.ClientID%>').val(Pid);
                $.ajax({
                    type: "POST",
                    url: 'BarcodeBilling.aspx/GetBarcode',
                    data: '{Pid: "' + Pid + '",  DiscounType: "Rs", BillType: "' + $('#<%=ddltype.ClientID%>').val() + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "") {
                            BindCartTable();
                            $('#<%=txt_Barcode.ClientID%>').val('');
                        }
                        else {
                            $('#lblmsg').text(data.d);
                            $('#<%=txtpartgstno.ClientID%>').focus();
                            return false;
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
            // $('#processing').show();
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetCartData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // $('#processing').hide();

                    $('#tblList').empty().append("<thead><tr>");
                    $('#tblList').append("<th style='width: 2%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SN</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Code</th>");
                    $('#tblList').append("<th style='width: 22%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Prod Name</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Rate</th>");
                    $('#tblList').append("<th style='width: 14%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Quantity</th>");
                    $('#tblList').append("<th style='width: 10%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Gross</th>");
                    $('#tblList').append("<th style='width: 10%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Discount</th>");
                    $('#tblList').append("<th style='width: 8%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Taxable</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>GST(%)</th>");
                    $('#tblList').append("<th style='width: 7%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>GST</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>BV</th>");
                    $('#tblList').append("<th style='width: 10%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Net Amount</th>");
                    $('#tblList').append("<th style='width: 3%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'><center><span style='color:Red; font-size:x-large;'>&times;</span></center></th>");
                    $('#tblList').append("</tr></thead>");

                    var tbl = '<tbody>';
                    var TotalQty = 0, TotalGST = 0, TotalBV = 0, TotalAmt = 0, TotalTaxable = 0, NetAmt = 0;
                    for (var i = 0; i < data.d.length; i++) {

                        TotalQty = TotalQty + parseInt(data.d[i].qty);
                        TotalGST = TotalGST + parseFloat(data.d[i].Totaltaxamt);
                        TotalBV = TotalBV + parseFloat(data.d[i].totalbvamt);
                        TotalAmt = TotalAmt + parseFloat(data.d[i].Gross);
                        TotalTaxable = TotalTaxable + parseFloat(data.d[i].TaxableAmt);
                        NetAmt = NetAmt + parseFloat(data.d[i].totalamt);
                        var Pid = data.d[i].Pid;

                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        tbl += '<td>' + data.d[i].Pid + '</td>';
                        tbl += '<td>' + data.d[i].pname + '</td>';
                        tbl += '<td>' + data.d[i].DPAmt + '</td>';
                        tbl += '<td> <span class="glyphicon glyphicon-minus quant" onclick="MinusQty(' + Pid + ')" style="cursor: pointer;"></span> <input type="text" id="qty_' + Pid + '" value="' + data.d[i].qty + '" onchange="UpdateQty(' + Pid + ')" class="form-control input-number text-center" maxlength="5" style="width:70px; height: 29px; float: left; padding:5px;"/> <span class="glyphicon glyphicon-plus quant" onclick="AddQty(' + Pid + ')" style="cursor: pointer;"></span>  <input type="hidden" id="Maxqty_' + Pid + '" value="' + data.d[i].MaxQty + '"> </td>';
                        tbl += '<td>' + data.d[i].Gross + '</td>';

                        var dd = data.d[i].DiscounType;
                        var Disc_Type = '<select id="ddl_Discount_Type' + Pid + '" onchange="Discount(' + Pid + ')" class="dropdown-select form-control" style="width:40px; height: 29px; float: left; padding:0px;">';
                        if (data.d[i].DiscounType == "%") {
                            Disc_Type += '<option value="Rs">Rs</option>';
                            Disc_Type += '<option value="%" selected="selected">%</option></select>';
                        }
                        else {
                            Disc_Type += '<option value="Rs" selected="selected">Rs</option>';
                            Disc_Type += '<option value="%">%</option></select>';
                        }
                        tbl += '<td> <input type="text" id="Discount_' + Pid + '" value="' + data.d[i].Discount + '" onchange="Discount(' + Pid + ')" class="form-control text-center" maxlength="5" style="width:50px; height: 29px; float:left; padding:2px;"/>' + Disc_Type + ' </td>';

                        tbl += '<td>' + data.d[i].TaxableAmt + '</td>';


                        var GST_AMT = '<select id="GST_' + Pid + '" onchange="GST(' + Pid + ')" class="dropdown-select form-control" style="width:40px; height: 29px; float: left; padding:0px;">';
                        if (data.d[i].tax == "0") {
                            GST_AMT += '<option value="0" selected="selected">0</option>';
                        }
                        else {
                            GST_AMT += '<option value="0">0</option>';
                        }

                        if (data.d[i].tax == "5") {
                            GST_AMT += '<option value="5" selected="selected">5</option>';
                        }
                        else {
                            GST_AMT += '<option value="5">5</option>';
                        }

                        if (data.d[i].tax == "12") {
                            GST_AMT += '<option value="12" selected="selected">12</option>';
                        }
                        else {
                            GST_AMT += '<option value="12">12</option>';
                        }

                        if (data.d[i].tax == "18") {
                            GST_AMT += '<option value="18" selected="selected">18</option>';
                        }
                        else {
                            GST_AMT += '<option value="18">18</option>';
                        }

                        if (data.d[i].tax == "28") {
                            GST_AMT += '<option value="28" selected="selected">28</option>';
                        }
                        else {
                            GST_AMT += '<option value="28">28</option>';
                        }
                        GST_AMT += '</select>';
                        tbl += '<td>' + GST_AMT + '</td>';

                        tbl += '<td>' + data.d[i].Totaltaxamt + '</td>';
                        tbl += '<td>' + data.d[i].totalbvamt + '</td>';
                        tbl += '<td>' + data.d[i].totalamt + '</td>';
                        tbl += '<td><center><a href="#/"> <span style="color:Red; font-size:x-large;" onclick="DeleteProd(' + Pid + ');" title="Remove">&times;</span> </a> </center> </td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    tbl += "<thead><tr style='background-color:#f3f4f8;'><th></th> <th></th>  <th></th>  <th>Total :</th> <th>" + TotalQty + "</th> <th>" + TotalAmt.toFixed(2) + "</th>  <th> 0</th> <th> " + TotalTaxable.toFixed(2) + "</th> <th></th> <th>" + TotalGST.toFixed(2) + "</th> <th>" + Math.round(TotalBV) + "</th> <th>" + Math.round(NetAmt.toFixed(2)) + "</th> <th></th> </tr></thead>";
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
                        $('#<%=lbl_TotalBV.ClientID%>').text(TotalBV.toFixed(2));
                        $('#<%=lbl_Net_Amt.ClientID%>').text(NetAmt.toFixed(2));
                        $('#hnd_TotalAmt').val(Math.round(NetAmt.toFixed(2)));

                        $('#div_ProdDetails').show();

                        $('.js-term-condition').show();
                        $('#div_PaymentDetails').show();
                        $('.js-term-condition').show("slow");
                        $('#div_PaymentDetails').show("slow");
                        Update_Discount_Delcharge();
                        GetFreeProduct();
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


        var ITEMLISTID = [];
        function GetFreeProduct() {

            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetOfferProduct',
                data: '{TotalAmt: "' + $('#hnd_TotalAmt').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#FreeList').empty().append("");
                    $('#Amount_Max_Item').val(0);
                    $('#BV_Max_Item').val(0);

                    if (data.d.length > 0) {
                        var NoOfOffer = 0;
                        var tblContent = "";

                        tblContent += "<table class='table'>";
                        tblContent += "<thead> <tr style='background-color:rgb(192,192,192); color: #fff!important; background-color: #4CAF50!important;'><th>SNo.</th>";
                        tblContent += "<th>Scheme</th>";
                        tblContent += "<th>Offer Type</th>";
                        tblContent += "<th>Items</th>";
                        tblContent += "<th>Amount</th>";
                        tblContent += "<th>Product Offer</th>";
                        tblContent += "</tr></thead>";
                        tblContent += '<tbody>';
                        ITEMLISTID.length = 0;

                        for (var i = 0; i < data.d.length; i++) {

                            var temp = data.d[i].Item_Qty == '0' ? ' checked disabled="disabled"' : ' disabled="disabled" ';
                            var CheckBox = '<label class="check_1">' + data.d[i].ItemName + ' <input type="checkbox" id="' + data.d[i].ITEMID + '" onclick="SelectItemOffer(' + data.d[i].ITEMID + ')"" ' + temp + '"> <span class="checkmark"></span> </label>';
                            tblContent += '<tr style="height:30px;">';
                            var Hidden = '<input type="hidden" id="NoofItem' + data.d[i].ITEMID + '" value="' + data.d[i].NoofItem + '"/>';
                            Hidden += ' <input type="hidden" id="RS' + data.d[i].ITEMID + '" value="' + data.d[i].RS + '"/>';
                            Hidden += ' <input type="hidden" id="OfferType' + data.d[i].ITEMID + '" value="' + data.d[i].Offer_Type + '"/>';

                            tblContent += '<td>' + (i + 1) + Hidden + '</td>';

                            tblContent += '<td>' + data.d[i].Scheme + '</td>';
                            tblContent += '<td>' + data.d[i].Offer_Type + '</td>';
                            tblContent += '<td>' + CheckBox + '</td>';
                            tblContent += '<td>' + data.d[i].RS + '.00</td>';
                            tblContent += '<td>' + data.d[i].ProdOffer + '</td>';
                            tblContent += '</tr>';
                            ITEMLISTID.push(data.d[i].ITEMID);
                            if (data.d[i].Item_Qty != "0") {
                                if (data.d[i].Offer_Type == "AMOUNT") {
                                    $('#Amount_Max_Item').val(data.d[i].Item_Qty);
                                }
                                if (data.d[i].Offer_Type == "BV") {
                                    $('#BV_Max_Item').val(data.d[i].Item_Qty);
                                }
                            }
                        }


                        var disabled_Amount = $('#Amount_Max_Item').val() == '0' ? ' disabled="disabled"' : '';
                        var disabled_BV = $('#BV_Max_Item').val() == '0' ? ' disabled="disabled"' : '';

                        tblContent += '</tbody> </table> ';
                        tblContent += "<h5 style='text-align:center; color:red;'><b>  <input type='checkbox' id='chk_Amount' onclick='OfferCheck(1)' '" + disabled_Amount + "'> <label for='chk_Amount'>Offer Available On Amount : " + $('#Amount_Max_Item').val() + "</label><br/> <input type='checkbox' id='chk_BV' onclick='OfferCheck(2)' '" + disabled_BV + "'>  <label for='chk_BV'>Offer Available On BV : " + $('#BV_Max_Item').val() + "</label> </b> </H5> <hr/>";
                        $('#FreeList').empty().append(tblContent);
                        SelectItemOffer(0)
                    }
                },
                error: function (response) {
                }
            });
        }

        function OfferCheck(id) {

            if (id == '1') { $('#chk_BV').attr('checked', false); }
            if (id == '2') { $('#chk_Amount').attr('checked', false); }

            $.each(ITEMLISTID, function (index, value) {
                if ($('#OfferType' + value).val() == "AMOUNT" || $('#OfferType' + value).val() == "BV") {
                    $('#' + value).attr('checked', false);
                }

                if ($('#OfferType' + value).val() == "AMOUNT") {
                    if (id == '1') {
                        $('#' + value).removeAttr('disabled', 'disabled');
                    }
                    else {
                        $('#' + value).attr('disabled', 'disabled');
                    }
                }

                if ($('#OfferType' + value).val() == "BV") {
                    if (id == '2') {
                        $('#' + value).removeAttr('disabled', 'disabled');
                    }
                    else {
                        $('#' + value).attr('disabled', 'disabled');
                    }
                }

            });
        }



        function SelectItemOffer(ITEMID) {
            var ItemCount = 0;
            $.each(ITEMLISTID, function (index, value) {
                if ($('#' + value).is(":checked")) {
                    if ($('#' + value).is(':enabled')) {
                        ItemCount = ItemCount + 1;
                    }
                }

                if ($('#chk_Amount').is(":checked")) {
                    if (parseInt(ItemCount) > parseInt($('#Amount_Max_Item').val())) {
                        $('#' + ITEMID).attr('checked', false);
                        alert('Offer available maximum quantity is :' + $('#Amount_Max_Item').val());
                        return false;
                    }
                }
                if ($('#chk_BV').is(":checked")) {
                    if (parseInt(ItemCount) > parseInt($('#BV_Max_Item').val())) {
                        $('#' + ITEMID).attr('checked', false);
                        alert('Offer available maximum quantity is :' + $('#BV_Max_Item').val());
                        return false;
                    }
                }
            });

            var SchemeAmt = 0;
            $.each(ITEMLISTID, function (index, value) {
                if ($('#' + value).is(":checked")) {
                    var RS = $('#RS' + value).val();
                    SchemeAmt = (parseInt(SchemeAmt) + parseInt(RS));
                }
            });
            $('#<%=lbl_SchemeAmt.ClientID %>').text(SchemeAmt.toFixed(2));
            var TotalAmount = (parseFloat($('#hnd_TotalAmt').val()) + (SchemeAmt));
            $('#<%=lbl_Net_Amt.ClientID %>').text(TotalAmount.toFixed(2));
        }





        function GST(Pid) {
            $('#lblmsg').html('');
            var GST = $('#GST_' + Pid).val();
            GST = parseFloat((GST == '' || GST == null || isNaN(parseFloat(GST))) ? 0 : GST);
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/UpdateGST',
                data: '{Pid: "' + Pid + '", GST: "' + GST + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#lblmsg').text(data.d);
                    BindCartTable();
                    $('#<%=txt_Barcode.ClientID%>').focus();
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
                }
            });
        }



        function Discount(Pid) {
            $('#lblmsg').html('');
            var Discount = $('#Discount_' + Pid).val();
            Discount = parseFloat((Discount == '' || Discount == null || isNaN(parseFloat(Discount))) ? 0 : Discount);
            var DiscounType = $('#ddl_Discount_Type' + Pid).val();
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/UpdateDiscount',
                data: '{Pid: "' + Pid + '", Discount: "' + Discount + '", DiscounType: "' + DiscounType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#lblmsg').text(data.d);
                    BindCartTable();
                    $('#<%=txt_Barcode.ClientID%>').focus();
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
                }
            });
        }

        function MinusQty(Pid) {
            var Qty = $('#qty_' + Pid).val();
            $('#qty_' + Pid).val(parseInt(Qty) - 1);
            UpdateQty(Pid);
        }

        function AddQty(Pid) {
            var Qty = $('#qty_' + Pid).val();
            $('#qty_' + Pid).val(parseInt(Qty) + 1);
            UpdateQty(Pid);
        }

        function UpdateQty(Pid) {
            $('#lblmsg').html('');
            if (Pid <= 0) {
                $('#lblmsg').text("Server error. Time out.!!");
                $('#<%=txt_Barcode.ClientID%>').focus();
                return false;
            }

            var Maxqty = $('#Maxqty_' + Pid).val();
            var Qty = $('#qty_' + Pid).val();
            if (parseInt(Qty) > parseInt(Maxqty)) {
                $('#qty_' + Pid).val(Maxqty);
                Qty = Maxqty;
                $('#lblmsg').text("Stock in hand : " + Maxqty);
            }
            // if (Qty > 0) {
            //$('#processing').show();
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/UpdateQty',
                data: '{Pid: "' + Pid + '", Qty: "' + Qty + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // $('#processing').hide();
                    if (data.d == "") {
                        BindCartTable();
                        $('#<%=txt_Barcode.ClientID%>').focus();
                        return;
                    }
                    else {
                        $('#lblmsg').text(data.d);
                        $('#<%=txt_Barcode.ClientID%>').focus();
                    }
                },
                error: function (response) {
                    // $('#processing').hide();
                    $('#lblmsg').text("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
                }
            });
        }



        function DeleteProd(Pid) {
            $('#lblmsg').html('');
            if (!confirm('Are you sure you want to delete？')) {
                return false;
            }
            // $('#processing').show();
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/DeleteProd',
                data: '{Pid: "' + Pid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // $('#processing').hide();
                    if (data.d == "") {
                        BindCartTable();
                        $('#<%=txt_Barcode.ClientID%>').focus();
                        return;
                    }
                    else {
                        $('#lblmsg').text(data.d);
                        $('#<%=txt_Barcode.ClientID%>').focus();
                    }
                },
                error: function (response) {
                    // $('#processing').hide();
                    $('#lblmsg').text("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
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
            $('#<%=lbl_Net_Amt.ClientID%>').text(Math.round((parseFloat(Hnd_NetAmt) + parseFloat(delCharge)) - parseFloat(discount)) + ".00");
            return;
        }
         
    </script>
    <input type="hidden" id="Amount_Max_Item" value="0" />
    <input type="hidden" id="BV_Max_Item" value="0" />
    <input type="hidden" id="hnd_TotalAmt" value="0" />
    <asp:HiddenField ID="hnd_Barcode" runat="server" Value="0" />
    <h2 class="head">
        <label>
            Generate Invoice & Stock Transfer</label>
        <input type="checkbox" id="chk_Barcode" onclick="CHK_Barcode()" style="width: 20px;
            height: 20px; margin-top: -3px;" />
        <label for="chk_Barcode">
            <i class="fa fa-barcode" aria-hidden="true"></i>
        </label>
    </h2>
    <div class="panel panel-default">
        <div class="col-md-12" style="padding-top: 10px;">
            <div class="clearfix">
            </div>
            <div class="row" style="padding-bottom: 10px;">
                <div class="col-md-2">
                    <asp:DropDownList ID="ddltype" runat="server" CssClass="form-control" onchange="ResetCart();">
                        <asp:ListItem Value="1">Generate Invoice</asp:ListItem>
                        <asp:ListItem Value="2">Stock Transfer</asp:ListItem>
                    </asp:DropDownList>
                </div>
                  <div class="col-md-2">
                    <asp:DropDownList ID="ddl_PackageType" runat="server" CssClass="form-control" onchange="ResetCart();">
                        <asp:ListItem Value="1">Topper</asp:ListItem>
                        <asp:ListItem Value="3">Repurchage</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txt_Userid" runat="server" onchange="GetUserId(this);" CssClass="form-control"
                        placeholder="Enter User Id"></asp:TextBox>
                    <span id="lblUserName" style="font-size: 10px;"></span>
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txt_Barcode" runat="server" CssClass="form-control" placeholder="Select Product..."></asp:TextBox>
                </div>
             
                <div class="col-md-2">
                    <asp:TextBox ID="txtpartgstno" runat="server" CssClass="form-control" placeholder="Party GST No"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:TextBox ID="txtbilldate" runat="server" placeholder="Select Billing Date." CssClass="form-control"></asp:TextBox>
                    <asp:DropDownList ID="ddlplaceofsupply" runat="server" CssClass="form-control" Enabled="false">
                        <asp:ListItem Value="0">Seller State</asp:ListItem>
                    </asp:DropDownList>
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
            <div class="table-responsive">
                <table id="tblList" class="table" style="width: 100%; border-collapse: collapse;">
                </table>
                <center>
                    <span id="lbl_tbl" style="color: Red; padding: 2px;"></span>
                </center>
            </div>
            <div class="table-responsive">
                <div id="FreeList" style="width: 100%">
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="col-md-6">
                <br />
                <div id="div_PaymentDetails" style="display: none;">
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <label class="control-label">
                                Gross
                            </label>
                        </div>
                        <div class="col-md-4 col-xs-4 text-right">
                            <asp:Label ID="lbl_Prod_Val" runat="server" CssClass="control-label">0</asp:Label>
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <label class="control-label">
                                GST
                            </label>
                        </div>
                        <div class="col-md-4 col-xs-4 text-right">
                            <asp:Label ID="lbl_Gst_Amt" runat="server" CssClass="control-label">0</asp:Label>
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <label class="control-label">
                                BV</label>
                        </div>
                        <div class="col-md-4 col-xs-4 text-right">
                            <asp:Label ID="lbl_TotalBV" runat="server" CssClass="control-label">0</asp:Label>
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <label class="control-label">
                                Scheme</label>
                        </div>
                        <div class="col-md-4 col-xs-4 text-right">
                            <asp:Label ID="lbl_SchemeAmt" runat="server" CssClass="control-label">0</asp:Label>
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row" style="padding-top: 5px;">
                        <div class="col-md-6 col-xs-6">
                            <label class="control-label">
                                Discount</label>
                        </div>
                        <div class="col-md-4 col-xs-4 pull-right">
                            <asp:TextBox ID="txt_Discount" runat="server" CssClass="form-control text-right"
                                Font-Size="Medium" Width="60px" onchange="Update_Discount_Delcharge()" Style="padding: 4px;">0</asp:TextBox>
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <label class="control-label">
                                Delivery Charge</label>
                        </div>
                        <div class="col-md-4 col-xs-4 pull-right">
                            <select id="ddl_GST" onchange="Update_Discount_Delcharge()" class="dropdown-select form-control"
                                style="width: 40px; padding: 0px; float: left;">
                                <option value="0">0</option>
                                <option value="18" selected="selected">18</option>
                            </select>
                            <asp:TextBox ID="txt_DelCharge" runat="server" CssClass="form-control text-right"
                                Font-Size="Medium" Width="60px" onchange="Update_Discount_Delcharge()" Style="padding: 4px;
                                float: left;">0</asp:TextBox>
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <label class="control-label">
                                Net Delivery Charge</label>
                        </div>
                        <div class="col-md-4 col-xs-4 text-right">
                            <asp:Label ID="lbl_DeliveryAmount" runat="server" CssClass="control-label" Font-Bold="true">0</asp:Label>
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row" style="padding-top: 10px; padding-bottom: 5px;">
                        <div class="col-md-6 col-xs-6">
                            <label class="control-label">
                                Net Amount(Rs)</label>
                        </div>
                        <div class="col-md-4 col-xs-4 text-right">
                            <asp:Label ID="lbl_Net_Amt" runat="server" CssClass="control-label" Font-Bold="true">0</asp:Label>
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                        </div>
                        <div class="col-md-4 col-xs-4 pull-right">
                            <input type="button" id="btn_submit" value="Save Details" onclick="return Generate_Inv()"
                                class="btn btn-success btn-block" />
                        </div>
                        <div class="col-md-2 col-sm-2">
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="div_ProdDetails" style="display: none;">
                <div class="row" style="padding-bottom: 10px;">
                    <div class="col-sm-12">
                        <a href="javascript:;" onclick="javascript:showdiv();"><span style="float: left;">Shipping
                            Details </span>
                            <div id="div_Plus_minus" style="float: left; padding: 3px;">
                            </div>
                        </a>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div id="div_shipping" style="display: none;">
                    <div class="row" style="padding-bottom: 10px;">
                        <div class="col-sm-6">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Your Name"></asp:TextBox>
                        </div>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="ddl_state" runat="server" CssClass="form-control">
                                <asp:ListItem Value="0">Select State</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row" style="padding-bottom: 10px;">
                        <div class="col-sm-6">
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Enter Your City"></asp:TextBox>
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control" placeholder="Enter Your Pincode"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="row" style="padding-bottom: 10px;">
                        <div class="col-sm-12">
                            <asp:TextBox ID="txtaddress" runat="server" placeholder="Enter Your Address " CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <hr />
                </div>
                <div class="row" style="padding-bottom: 10px;">
                    <div class="col-sm-6">
                        <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="form-control" onchange="PayModeDisplay(this);">
                            <asp:ListItem Value="1">Cash</asp:ListItem>
                            <asp:ListItem Value="2">Cheque</asp:ListItem>
                            <asp:ListItem Value="3">Net Banking</asp:ListItem>
                            <asp:ListItem Value="4">DD</asp:ListItem>
                            <asp:ListItem Value="5">Credit Card</asp:ListItem>
                            <asp:ListItem Value="6">Debit Card</asp:ListItem>
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
            </div>
            <div class="clearfix">
            </div>
            <hr />
            <div class="col-md-12 js-term-condition" style="display: none">
                <div class="row">
                    <span><b>Terms & Conditions</b>
                        <ol>
                            <li>Goods Once Sold Will Not Be Taken Back.</li>
                            <li>Warranty Will Be Under Taken By The Manufacturer Only.</li>
                            <li>All Disputes Are Subject To
                                <asp:Label ID="lbladminadress" runat="server"></asp:Label>
                                Jurisdiction.</li>
                            <li>Company Is Not Responsible After The Goods Leave The Premises.</li>
                            <li>Any Inaccuracy In This Bill Must Be Notifided Immediately On Its Receipt.</li>
                            <li>This is a computer generated invoice. No signature required.</li>
                        </ol>
                    </span>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <div id="divProductcode" style="display: none;" runat="server">
        </div>
        <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
        <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
        <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(function () {

                showdiv();
                $('#<%=txtbilldate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });
                $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });

                BindChkBarcode($('#<%=hnd_Barcode.ClientID%>').val());
            });

            function Generate_Inv() {
                $('#lblmsg').html('');
                var MSG = "";
                var BillType = $('#<%=ddltype.ClientID%>').val(),
                    distype= $('#<%=ddl_PackageType.ClientID%>').val(),
                    UserId = $('#<%=txt_Userid.ClientID%>').val(),
                    Discount = $('#<%=txt_Discount.ClientID%>').val(),
                    DelCharge = $('#<%=lbl_DeliveryAmount.ClientID%>').text(),
                    User_State = $('#<%=ddl_state.ClientID%>').val(),
                    Admin_State = $('#<%=ddlplaceofsupply.ClientID%>').val(),
                    paymode = $('#<%=ddlpaytype.ClientID%> option:selected').text(),
                    bankname = $('#<%=txtbname.ClientID%>').val(),
                    checkno = $('#<%=txtDD.ClientID%>').val(),
                    CheDate = $('#<%=txtDate.ClientID%>').val(),
                    toAdd = $('#<%=txtName.ClientID%>').val() + "<br/>" + $('#<%=txtaddress.ClientID%>').val() + ", " + $('#<%=ddl_state.ClientID%> option:selected').text() + ", " + $('#<%=txtCity.ClientID%>').val() + ", " + $('#<%=txtPincode.ClientID%>').val(),
                    GSTNo = $('#<%=txtpartgstno.ClientID%>').val(),
                    PlaseOfSuply = $('#<%=ddlplaceofsupply.ClientID%> option:selected').text(),
                    BillDate = $('#<%=txtbilldate.ClientID%>').val() ;


                var SchemeItemIdStr = "";
                var ItemCount = 0;
                $.each(ITEMLISTID, function (index, value) {
                    if ($('#' + value).is(":checked")) {
                        var NoofItem = $('#NoofItem' + value).val();
                        SchemeItemIdStr += value + '^' + NoofItem + ",";
                        if ($('#' + value).is(':enabled')) {
                            ItemCount = ItemCount + 1;
                        }
                    }
                });

                Discount = parseFloat((Discount == '' || Discount == null || isNaN(parseFloat(Discount))) ? 0 : Discount);
                DelCharge = parseFloat((DelCharge == '' || DelCharge == null || isNaN(parseFloat(DelCharge))) ? 0 : DelCharge);



                if (parseInt(ItemCount) > 0) {
                    var flag = 0;
                    if ($('#chk_Amount').is(":checked")) {
                        flag = 1;
                    }
                    if ($('#chk_BV').is(":checked")) {
                        flag = 1;
                    }
                    if (flag == 0) {
                        MSG += "\n Please select your Offer";
                    }
                }   

                if ($('#chk_Amount').is(":checked")) {
                    if (parseInt(ItemCount) != parseInt($('#Amount_Max_Item').val())) {
                        MSG += "\n Please select No Of :" + $('#Amount_Max_Item').val() + " Item";
                    }
                }

                if ($('#chk_BV').is(":checked")) {
                    if (parseInt(ItemCount) != parseInt($('#BV_Max_Item').val())) {
                        MSG += "\n Please select No Of :" + $('#BV_Max_Item').val() + " Item";
                    }
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

                $('#processing').show();
                $.ajax({
                    type: "POST",
                    url: 'BarcodeBilling.aspx/GenerateInv', 
                    data: '{BillType: "' + BillType + '", distype: "' + distype + '", UserId: "' + UserId + '", Discount: "' + Discount + '", DelCharge: "' + DelCharge + '", User_State: "' + User_State + '", Admin_State: "' + Admin_State + '", paymode: "' + paymode + '", bankname: "' + bankname
                    + '", checkno: "' + checkno + '", CheDate: "' + CheDate + '", toAdd: "' + toAdd + '", GSTNo: "' + GSTNo + '", PlaseOfSuply: "' + PlaseOfSuply + '", BillDate: "' + BillDate
                    + '", SchemeItemIdStr: "' + SchemeItemIdStr + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $('#processing').hide();
                        if (data.d.Error == "") {

                            $('#<%=txt_Userid.ClientID%>').val('');
                            $('#<%=txt_Discount.ClientID%>').val(0);
                            $('#<%=txtpartgstno.ClientID%>').val('');
                            $('#<%=ddlplaceofsupply.ClientID%>').val(0);
                            $('#<%=ddl_state.ClientID%>').val(0);

                            if (BillType == "1") {
                                window.location = "GSTBill.aspx?id=" + data.d.InvoiceNo + "&st=" + data.d.status;
                            }
                            else if (BillType == "2") {
                                window.location = "StockTranBill.aspx?inv=" + data.d.InvoiceNo;
                            }
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
                        $('#lblUserName').text("Server error. Time out.!!");
                        $('#lblUserName').css('color', 'red');
                        $('#<%=txt_Userid.ClientID%>').val('');
                    }
                });
            }



            function GetUserId(Userid) {
                $('#lblmsg').html('');
                Userid = Userid.value;
                $('#lblUserName').text("");
                if (Userid != '') {
                    $.ajax({
                        type: "POST",
                        url: 'BarcodeBilling.aspx/GetUser',
                        data: '{Userid: "' + Userid + '", BillType: "' + $('#<%=ddltype.ClientID%>').val() + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.Error == "") {
                                $('#<%=txtName.ClientID%>').val(data.d.UserName);
                                $('#<%=txtaddress.ClientID%>').val(data.d.Address);
                                $('#<%=ddl_state.ClientID%>').val(data.d.State);
                                $('#<%=txtCity.ClientID%>').val(data.d.City);
                                $('#<%=txtPincode.ClientID%>').val(data.d.Pincode);
                                $('#<%=ddlplaceofsupply.ClientID%>').val(data.d.AdminState);
                                $('#lblUserName').text(data.d.UserName);
                                $('#lblUserName').css('color', 'Blue');
                            }
                            else {
                                $('#<%=txtName.ClientID%>').val('');
                                $('#<%=txtaddress.ClientID%>').val('');
                                $('#<%=ddl_state.ClientID%>').val('');
                                $('#<%=txtCity.ClientID%>').val('');
                                $('#<%=txtPincode.ClientID%>').val('');

                                $('#lblUserName').text("User Does Not Exists!");
                                $('#lblUserName').css('color', 'red');
                                $('#<%=txt_Userid.ClientID%>').val('');
                            }
                        },
                        error: function (response) {
                            $('#lblUserName').text("Server error. Time out.!!");
                            $('#lblUserName').css('color', 'red');
                            $('#<%=txt_Userid.ClientID%>').val('');
                        }
                    });
                }
            }


            function ResetCart() {
                $.ajax({
                    type: "POST",
                    url: 'BarcodeBilling.aspx/ResetCart',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "") {
                            BindCartTable();
                            $('#<%=txt_Userid.ClientID%>').val('');
                            $('#<%=txt_Barcode.ClientID%>').focus();
                            return;
                        }
                    },
                    error: function (response) {
                        $('#lblmsg').text("Server error. Time out.!!");
                        $('#<%=txt_Barcode.ClientID%>').focus();
                    }
                });
            }


            function PayModeDisplay(Paymode) {
                if (Paymode.value == 1) {
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


            function CHK_Barcode() {
                var Barcode = 0;
                if ($('#chk_Barcode').is(":checked")) {
                    Barcode = 1;
                    //BindChkBarcode(1);
                }
                else {
                    Barcode = 0;
                    //BindChkBarcode(0);
                }
                $.ajax({
                    type: "POST",
                    url: 'BarcodeBilling.aspx/ChkBarcode',
                    data: '{Barcode: "' + Barcode + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //window.location = "BarcodeBilling.aspx";
                    },
                    error: function (response) { }
                });

            }


            function BindChkBarcode(status) {
                if (status == 1) {
                    $('#<%=hnd_Barcode.ClientID%>').val(1);
                    $('#<%=txt_Barcode.ClientID%>').autocomplete('');
                    $("#chk_Barcode").attr('checked', true);
                }
                else {
                    $('#<%=hnd_Barcode.ClientID%>').val(0);
                    var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
                    $('#<%=txt_Barcode.ClientID%>').autocomplete(Productcode);
                    $('#chk_Barcode').attr('checked', false);
                }
            }
             
        </script>
        <style type="text/css">
            .quant
            {
                float: left;
                border: 1px solid #ebebea;
                padding: 7px;
                font-size: 11px;
            }
            tr, th
            {
                font-size: 13px;
            }
            td
            {
                padding: 2px !important;
            }
        </style>
</asp:Content>
