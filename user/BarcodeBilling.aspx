<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="BarcodeBilling.aspx.cs" Inherits="secretadmin_BarcodeBilling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="datepick/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            BindCartTable();
            if ($('#<%=txt_Userid.ClientID%>').val() != "") {
                GetUserId($('#<%=txt_Userid.ClientID%>').val())
            }
        });


        function GetProduct() {
            $('#lblmsg').html('');
            var Pid = $('#<%=txt_Barcode.ClientID%>').val();
            if (Pid != '') {
                var BillType = $('#<%=ddltype.ClientID%>').val();

                var Pack_Rep = $('#<%=ddl_BillType.ClientID%>').val();
                $.ajax({
                    type: "POST",
                    url: 'BarcodeBilling.aspx/GetBarcode',
                    data: '{Productcode: "' + Pid + '",  DiscounType: "Rs", BillType: "' + BillType + '", Pack_Rep: "' + Pack_Rep + '"}',
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
                        else if (data.d == "1") {
                            $('#lblmsg').text("This product already added.!!");
                            $('#<%=txt_Barcode.ClientID%>').val('');
                        }
                        else if (data.d == "Sessionlogout") {
                            window.location = "Logout.aspx";
                        }
                        else {
                            $('#lblmsg').text(data.d);
                            $('#<%=txtpartgstno.ClientID%>').focus();
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



        function GetReferenceUserProduct() {
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetReferenceUserProduct',
                data: '{BillType: "' + $('#<%=ddltype.ClientID%>').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        $('#<%=txt_RefUser.ClientID%>').show();
                    }
                    else {
                        $('#<%=txt_RefUser.ClientID%>').hide();
                        $('#<%=txt_RefUser.ClientID%>').val('');
                    }
                },
                error: function (response) { }
            });
        }




        function BindCartTable() {

            GetReferenceUserProduct();

            var Pack_Rep = $('#<%=ddl_BillType.ClientID%>').val();
            if (Pack_Rep == "1") {
                $('#hnd_BVType').val("<%=method.BINARY_PV%>");
            }
            else {
                $('#hnd_BVType').val("<%=method.PV%>");
            }

            $('#<%=txt_Barcode.ClientID%>').val('');
            $('#lbl_tbl').text('');
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetCartData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblList').empty().append("<thead><tr>");
                    $('#tblList').append("<th style='width: 2%;'>#</th>");
                    $('#tblList').append("<th style='width: 25%;'>Products</th>");

                    //$('#tblList').append("<th style='width: 5%;'>HSN Code</th>");

                    $('#tblList').append("<th class='text-end' style='width: 7%;'>" + $('#hnd_BVType').val() + "</th>");
                    $('#tblList').append("<th class='text-end' style='width: 5%;'>MRP</th>");
                    $('#tblList').append("<th class='text-end' style='width: 8%;'><%=method.DP%>(excl.Tax)</th>");
                    $('#tblList').append("<th style='width:10%;'>Quantity</th>");
                    $('#tblList').append("<th class='text-end' style='width: 8%;'>Gross <br>Value</th>");
                    $('#tblList').append("<th class='text-end' style='width: 6%;'>Disc%</th>");
                    $('#tblList').append("<th class='text-end' style='width: 7%;'>Disc <br>Value</th>");
                    //$('#tblList').append("<th style='width: 8%; '>Billing <br>Value</th>");
                    // $('#tblList').append("<th style='width: 7%;'>DP <br>Value</th>");

                    $('#tblList').append("<th class='text-end' style='width: 6%;'>GST%</th>");
                    $('#tblList').append("<th class='text-end' style='width: 4%;'>GST Val</th>");
                    $('#tblList').append("<th class='text-end' style='width: 11%;'><%=method.DP%>(incl.Tax)</th>");

                    $('#tblList').append("<th style='width:1%;'><center><span style='color:Red; font-size:x-large;'>&times;</span></center></th>");
                    $('#tblList').append("</tr></thead>");

                    var tbl = '<tbody>';
                    var TotalQty = 0, TotalGST = 0, TotalBV = 0, TotalDiscount = 0, TotalGross = 0, TotalAmt = 0, TotalTaxable = 0, NetAmt = 0, GrossWeight = 0;
                    for (var i = 0; i < data.d.length; i++) {

                        GrossWeight = GrossWeight + parseFloat(data.d[i].TotalWeight);
                        TotalQty = TotalQty + parseInt(data.d[i].qty);
                        TotalGST = TotalGST + parseFloat(data.d[i].Totaltaxamt);
                        TotalBV = TotalBV + parseFloat(data.d[i].totalbvamt);
                        TotalGross = TotalGross + parseFloat(data.d[i].Gross);
                        TotalTaxable = TotalTaxable + parseFloat(data.d[i].TaxableAmt);
                        NetAmt = NetAmt + parseFloat(data.d[i].totalamt);
                        TotalDiscount = TotalDiscount + parseFloat(data.d[i].Discount);
                        var Pid = data.d[i].Pid;
                        var batchid = data.d[i].batchid;
                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        // tbl += '<td>' + data.d[i].Pcode + '</td>';
                        tbl += '<td style="text-align: left;">' + data.d[i].Pcode + ' - ' + data.d[i].pname
                            //+ '<br/>Batch No. ' + data.d[i].BatchNo
                            //+ '<br/>Mfg Dt. ' + data.d[i].BatchDate
                            //+ '<br/>Exp Dt. ' + data.d[i].ExpiryDate
                            + '</td>';
                        //tbl += '<td>' + data.d[i].hsncode + '</td>';

                        tbl += '<td class="text-end">' + data.d[i].totalbvamt + '</td>';
                        tbl += '<td>' + data.d[i].MRP + '</td>';
                        tbl += '<td>' + data.d[i].DPAmt + '</td>';
                        tbl += '<td style="text-align: left;"><div class="d-flex"> <span class="fa fa-minus quant" onclick="MinusQty(' + batchid + ')" style="cursor: pointer;"></span> <input type="text" id="qty_' + batchid + '" value="' + data.d[i].qty + '" onchange="UpdateQty(' + batchid + ')" class="form-control input-number text-center" maxlength="4" style="width:40px; height: 29px; float: left; padding:0px;"/> <span class="fa fa-plus quant" onclick="AddQty(' + batchid + ')" style="cursor: pointer;"></span>  <input type="hidden" id="Maxqty_' + batchid + '" value="' + data.d[i].MaxQty + '"> </td>';

                        //tbl += '<td>' + data.d[i].TaxableAmt + '</td>'; 

                        tbl += '<td class="text-end">' + data.d[i].Gross + '</td>';
                        tbl += '<td class="text-end">' + data.d[i].Disc_Perc_Val + '%</td>';
                        tbl += '<td class="text-end">' + data.d[i].Discount + '</td>';
                        tbl += '<td class="text-end">' + data.d[i].tax + '%</td>';
                        tbl += '<td class="text-end">' + data.d[i].Totaltaxamt + '</td>';

                        tbl += '<td class="text-end">' + data.d[i].totalamt.toFixed(2) + '</td>';

                        tbl += '<td><center><a href="javascript:void(0)"> <span style="color:Red; font-size:x-large;" onclick="DeleteProd(' + batchid + ');" title="Remove">&times;</span> </a> </center> </td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';

                    tbl += "<thead><tr> <th></th> <th>Total :</th>   <th class='text-end'>" + TotalBV.toFixed(0) + "</th>  <th></th> <th></th> <th class='text-end'>" + TotalQty + "</th>  <th class='text-end'>" + TotalGross.toFixed(2) + "</th>  <th></th> <th class='text-end'>" + TotalDiscount.toFixed(2) + "</th>  <th></th> <th class='text-end'>" + TotalGST.toFixed(2) + "</th> <th class='text-end'>" + NetAmt.toFixed(2) + "</th>  <th></th> </tr></thead>";

                    //tbl += "<thead><tr> <th></th> <th>Total :</th> <th>" + TotalBV + "</th> <th>" + TotalQty + "</th> <th>" + TotalAmt.toFixed(2) + "</th> <th></th> </tr></thead>"; // <th>" + Math.round(TotalBV) + "</th>

                    //tbl += "<thead><tr><th></th> <th>Total :</th> <th></th> <th></th> <th></th> <th>" + TotalQty + "</th>   <th> " + TotalTaxable.toFixed(2) + "</th> <th> " + TotalDiscount.toFixed(2) + "</th> <th></th>  <th>" + TotalGST.toFixed(2) + "</th> <th>" + NetAmt.toFixed(2) + "</th> <th></th> </tr></thead>"; // <th>" + Math.round(TotalBV) + "</th>
                    $('#tblList').append(tbl);
                    $('#<%=txt_Barcode.ClientID%>').focus();
                    $('#lbl_BVType').text($('#hnd_BVType').val());

                    GrossWeight = GrossWeight.toFixed(3);
                    $('#<%=lbl_GrossWeight.ClientID%>').text(GrossWeight);

                     //var DeliveryCharge = Calc_Delivery_Charge(NetAmt);
                   // $('#<%=lbl_DeliveryAmount.ClientID%>').text(DeliveryCharge.toFixed(2));

                     

                    if (data.d.length == 0) {
                        $('.js-term-condition').hide();
                        $('#div_PaymentDetails').hide();
                        $('#div_ProdDetails').hide();
                        $('#tblList').empty();
                        $('#FreeList').empty().append('');
                        $('#lbl_tbl').text('Cart is empty.....');
                        $('#<%=txt_Barcode.ClientID%>').focus();
                        $('#<%=lbl_GrossWeight.ClientID%>').text("0");
                        return false;
                    }
                    if (data.d.length > 0) {
                        /* Show Calculation */
                        $('#<%=lbl_Prod_Val.ClientID%>').text(TotalAmt.toFixed(2));
                        $('#<%=lbl_Gst_Amt.ClientID%>').text(TotalGST.toFixed(2));
                        $('#<%=lbl_TotalBV.ClientID%>').text(TotalBV.toFixed(2));
                        $('#<%=txt_Discount.ClientID%>').val(TotalDiscount);

                        $('#hnd_TotalBV').val(TotalBV.toFixed(2));

                        $('#<%=lbl_Net_Amt.ClientID%>').text(parseFloat(NetAmt.toFixed(2)));
                        $('#hnd_TotalAmt').val(Math.round(NetAmt));

                       <%-- if ($('#<%=ddl_BillType.ClientID%>').val() == "4" || $('#<%=ddl_BillType.ClientID%>').val() == "6") {
                            $('#lbl_GrossAmount_Upper').text("Gross Amount " + $('#<%=lbl_Prod_Val.ClientID%>').text());
                        } else {
                            $('#lbl_GrossAmount_Upper').text("Gross Amount " + $('#<%=lbl_Net_Amt.ClientID%>').text());
                        }--%>

                        <%--if (Pack_Rep == "1" || Pack_Rep == "3") {
                            $('#lbl_RPVTPV_Upper').text($('#hnd_BVType').val() + " " + TotalBV.toFixed(0));
                        }
                        else {
                            $('#<%=lbl_TotalBV.ClientID%>').text("0.00");
                            $('#lbl_RPVTPV_Upper').text("");
                        }--%>


                        $('#div_ProdDetails').show();
                        $('.js-term-condition').show();
                        $('#div_PaymentDetails').show();
                        $('.js-term-condition').show("slow");
                        $('#div_PaymentDetails').show("slow");

                        Update_Discount_Delcharge();

                        if ($('#<%=ddl_BillType.ClientID%>').val() == "1" || $('#<%=ddl_BillType.ClientID%>').val() == "3") {
                            GetFreeProduct();
                        }


                    }
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
                    return false;
                }
            });
        }






        var PRDS_COUNT = [];
        var PRDS_OFFERON_PRDS = [];
        var ITEMLISTID = [];
        function GetFreeProduct() {
            if ($('#<%=ddl_BillType.ClientID%>').val() == "0") {
                $('#FreeList').empty().append("");
                $('#Amount_Max_Item').val(0);
                $('#BV_Max_Item').val(0);
                $('#Product_Max_Item').val(0);

                $('#NoOf_Row_PV').val(0);
                $('#NoOf_Row_Amount').val(0);
                return false;
            }
            var BillType = "1";
            if ($('#<%=ddltype.ClientID%>').val() == "2" || $('#<%=ddltype.ClientID%>').val() == "3") {
                BillType = "2";
            }
            var OfferOn = $('#<%=ddl_BillType.ClientID%>').val();
            var TotalBV = $('#<%=lbl_TotalBV.ClientID%>').text();

            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetOfferProduct',
                data: '{TotalAmt: "' + $('#hnd_TotalAmt').val() + '", TotalBV: "' + TotalBV + '", BillType: "' + BillType + '", OfferOn: "' + OfferOn + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $('#FreeList').empty().append("");
                    $('#Amount_Max_Item').val(0);
                    $('#BV_Max_Item').val(0);
                    $('#Product_Max_Item').val(0);
                    if (data.d.length > 0) {
                        var NoOfOffer = 0;
                        var NoOfItem_Row_PV = 0;
                        var NoOfItem_Row_Amt = 0;

                        var tblContent = "";

                        tblContent += "<table class='table text-center'>";
                        tblContent += "<thead> <tr style='background-color:rgb(252 221 195); color: #000!important; '><th>SNo.</th>";
                        tblContent += "<th>Scheme</th>";
                        tblContent += "<th>Offer Type</th>";
                        tblContent += "<th>Items</th>";
                        tblContent += "<th>Amount</th>";
                        tblContent += "<th>Product Offer</th>";
                        tblContent += "</tr></thead>";
                        tblContent += '<tbody>';
                        ITEMLISTID.length = 0;


                        PRDS_COUNT.lenght = 0;
                        PRDS_COUNT = [];

                        PRDS_OFFERON_PRDS.lenght = 0;
                        PRDS_OFFERON_PRDS = [];


                        if (data.d[0].flushed == "1") {
                            $('#FreeList').empty().append("You want to get a scheme. Then you should invoice values less than " + data.d[0].MaxAmount + ".");
                            return;
                        }
                        else {
                            for (var i = 0; i < data.d.length; i++) {
                                if (data.d[i].Offer_Type == "PRODUCT") {
                                    if (PRDS_COUNT.indexOf(data.d[i].PId) == -1) {
                                        PRDS_COUNT.push(data.d[i].PId);
                                    }
                                    PRDS_OFFERON_PRDS.push({ PId: data.d[i].PId, ITEMID: data.d[i].ITEMID });
                                }

                                var temp = '';
                                if (data.d[i].Offer_Type == "PRODUCT") {
                                    temp = ' checked " ';
                                }
                                //else if (data.d[i].Category_wise_item != '1' && data.d[i].Offer_Type == "PRODUCT") {
                                //    temp = ' disabled="disabled" ';
                                //}
                                else if (data.d[i].Offer_Type == "AMOUNT" || data.d[i].Offer_Type == "BV") {
                                    temp = data.d[i].Item_Qty == '0' ? ' checked "' : ' " ';
                                }
                                var CheckBox = '<label class="check_1">' + data.d[i].ItemName + ' <input type="checkbox" id="' + data.d[i].ITEMID + '" onclick="SelectItemOffer(' + data.d[i].ITEMID + ')"" ' + temp + '"> <span class="checkmark"></span> </label>';
                                tblContent += '<tr style="height:30px;">';

                                var Hidden = '<input type="hidden" id="NoofItem' + data.d[i].ITEMID + '" value="' + data.d[i].NoofItem + '"/>';
                                Hidden += ' <input type="hidden" id="RS' + data.d[i].ITEMID + '" value="' + data.d[i].RS + '"/>';
                                Hidden += ' <input type="hidden" id="OfferType' + data.d[i].ITEMID + '" value="' + data.d[i].Offer_Type + '"/>';
                                Hidden += ' <input type="hidden" id="SID' + data.d[i].ITEMID + '" value="' + data.d[i].SID + '"/>';
                                Hidden += ' <input type="hidden" id="PID' + data.d[i].PId + '" value="' + data.d[i].PId + '"/>';

                                tblContent += '<td>' + (i + 1) + Hidden + '</td>';
                                tblContent += '<td>' + data.d[i].Scheme + '</td>';

                                var Temp_Offer_Type = data.d[i].Offer_Type;
                                if (data.d[i].Offer_Type == "BV") {
                                    Temp_Offer_Type = "PV";
                                }

                                tblContent += '<td>' + Temp_Offer_Type + '</td>';
                                tblContent += '<td>' + CheckBox + '</td>';
                                tblContent += '<td>' + data.d[i].RS + '.00</td>';
                                tblContent += '<td style="text-align:left;">' + data.d[i].ProdOffer + '</td>';
                                tblContent += '</tr>';

                                ITEMLISTID.push(data.d[i].ITEMID);

                                if (data.d[i].Item_Qty != "0") {
                                    if (data.d[i].Offer_Type == "AMOUNT") {
                                        $('#Amount_Max_Item').val(data.d[i].Item_Qty);
                                        NoOfItem_Row_Amt = (NoOfItem_Row_Amt + 1);
                                    }
                                    if (data.d[i].Offer_Type == "BV") {
                                        $('#BV_Max_Item').val(data.d[i].Item_Qty);
                                        NoOfItem_Row_PV = (NoOfItem_Row_PV + 1);
                                    }

                                }
                            }
                        }
                        var PRDS_Count = 0;
                        $.each(PRDS_COUNT, function (index, value) {
                            PRDS_Count = parseInt(PRDS_Count) + 1;
                        });

                        $('#Product_Max_Item').val(PRDS_Count);


                        $('#NoOf_Row_Amount').val(NoOfItem_Row_Amt);
                        $('#NoOf_Row_PV').val(NoOfItem_Row_PV);

                        var disabled_Amount = $('#Amount_Max_Item').val() == '0' ? ' disabled="disabled"' : '';
                        var disabled_BV = $('#BV_Max_Item').val() == '0' ? ' disabled="disabled"' : '';
                        var disabled_Product = $('#Product_Max_Item').val() == '0' ? ' disabled="disabled"' : '';
                        tblContent += '</tbody> </table> ';
                        //tblContent += "<h5 style='text-align:center; color:blue;'><b>  <input type='checkbox' id='chk_PRODUCT' onclick='OfferCheck(3)' '" + disabled_Product + "'>  <label for='chk_PRODUCT'>Offer Available On (Product) : " + $('#Product_Max_Item').val() + "</label> <br/> <input type='checkbox' id='chk_Amount' onclick='OfferCheck(1)' '" + disabled_Amount + "'> <label for='chk_Amount'>Offer Available On (Amount) : " + $('#Amount_Max_Item').val() + "</label><br/> <input type='checkbox' id='chk_BV' onclick='OfferCheck(2)' '" + disabled_BV + "'>  <label for='chk_BV'>Offer Available On (PV) : " + $('#BV_Max_Item').val() + "</label>  </b> </H5> <hr/>";
                        tblContent += "<span style='text-align:center; color:#fe6a00;'><b>  <input type='checkbox' id='chk_PRODUCT' '" + disabled_Product + "'>  <label for='chk_PRODUCT'>Offer Available On (Product) : " + $('#Product_Max_Item').val() + "</label> &nbsp;&nbsp; <input type='checkbox' id='chk_Amount' '" + disabled_Amount + "'> <label for='chk_Amount'>Offer Available On (Amount) : " + $('#Amount_Max_Item').val() + "</label> &nbsp;&nbsp; <input type='checkbox' id='chk_BV' '" + disabled_BV + "'>  <label for='chk_BV'>Offer Available On (PV) : " + $('#BV_Max_Item').val() + "</label>   </span> <hr/>";
                        $('#FreeList').empty().append(tblContent);
                        SelectItemOffer(0);
                    }
                },
                error: function (response) {
                }
            });
        }



        function SelectItemOffer(ITEMID) {
            if (parseInt($('#Product_Max_Item').val()) > 0) {
                $('#chk_PRODUCT').attr('checked', true);
            }
            if (parseInt($('#BV_Max_Item').val()) > 0) {
                $('#chk_BV').attr('checked', true);
            }
            if (parseInt($('#Amount_Max_Item').val()) > 0) {
                $('#chk_Amount').attr('checked', true);
            }

            var PRDS_EXISTS = [];
            var Count_Amt_Item = 0, Count_BV_Item = 0, Count_Product_Item = 0;
            $.each(ITEMLISTID, function (index, value) {

                if ($('#OfferType' + value).val() == "AMOUNT") {
                    if ($('#NoOf_Row_Amount').val() == "1") {
                        $('#' + value).attr('checked', true);
                        $('#chk_Amount').attr('checked', true);
                    }
                }
                else if ($('#OfferType' + value).val() == "BV") {
                    if ($('#NoOf_Row_PV').val() == "1") {
                        $('#' + value).attr('checked', true);
                        $('#chk_BV').attr('checked', true);
                    }
                }

                if ($('#' + value).is(":checked")) {
                    if ($('#OfferType' + value).val() == "AMOUNT") {
                        Count_Amt_Item = Count_Amt_Item + 1;
                    }
                    else if ($('#OfferType' + value).val() == "BV") {
                        Count_BV_Item = Count_BV_Item + 1;
                    }
                    else if ($('#OfferType' + value).val() == "PRODUCT") {
                        if ($('#' + value).is(':enabled')) {
                            Count_Product_Item = Count_Product_Item + 1;
                            PRDS_EXISTS.lenght = 0;
                            PRDS_EXISTS = [];
                            for (var i = 0; i < PRDS_OFFERON_PRDS.length; i++) {
                                if ($('#' + PRDS_OFFERON_PRDS[i].ITEMID).is(':checked')) {
                                    if (PRDS_EXISTS.indexOf(PRDS_OFFERON_PRDS[i].PId) == -1) {
                                        PRDS_EXISTS.push(PRDS_OFFERON_PRDS[i].PId);
                                    }
                                    else {
                                        $('#' + ITEMID).attr('checked', false);
                                        alert('Selection of Offer/Scheme for Different Product/Catagory.!');
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                }


                if ($('#chk_Amount').is(":checked")) {
                    if (parseInt(Count_Amt_Item) > parseInt($('#Amount_Max_Item').val())) {
                        $('#' + ITEMID).attr('checked', false);
                        alert('Offer Selection on Amount = ' + $('#Amount_Max_Item').val());
                        return false;
                    }
                }
                if ($('#chk_BV').is(":checked")) {
                    if (parseInt(Count_BV_Item) > parseInt($('#BV_Max_Item').val())) {
                        $('#' + ITEMID).attr('checked', false);
                        alert('Offer Selection on BV = ' + $('#BV_Max_Item').val());
                        return false;
                    }
                }
                if ($('#chk_PRODUCT').is(":checked")) {
                    if (parseInt(Count_Product_Item) > parseInt($('#Product_Max_Item').val())) {
                        $('#' + ITEMID).attr('checked', false);
                        alert('Offer Selection on Product = ' + $('#Product_Max_Item').val());
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
            Update_Discount_Delcharge();
            //var TotalAmount = (parseFloat($('#hnd_TotalAmt').val()) + (SchemeAmt));

            //var Deliverycharge = $('#<%=lbl_DeliveryAmount.ClientID%>').text() == "" ? "0" : $('#<%=lbl_DeliveryAmount.ClientID%>').text();


            //$('#<%=lbl_Net_Amt.ClientID %>').text((parseFloat(TotalAmount.toFixed(2)) + parseFloat(Deliverycharge)).toFixed(2));
        }


        function GST(batchid) {
            $('#lblmsg').html('');
            var GST = $('#GST_' + batchid).val();
            GST = parseFloat((GST == '' || GST == null || isNaN(parseFloat(GST))) ? 0 : GST);
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/UpdateGST',
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



        function Discount(batchid) {
            $('#lblmsg').html('');
            var Discount = $('#Discount_' + batchid).val();
            Discount = parseFloat((Discount == '' || Discount == null || isNaN(parseFloat(Discount))) ? 0 : Discount);
            var DiscounType = $('#ddl_Discount_Type' + batchid).val();
            if (DiscounType == "%" && Discount > 100) {
                $('#Discount_' + batchid).val(100);
                Discount = 100;
            }

            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/UpdateDiscount',
                data: '{batchid: "' + batchid + '", Discount: "' + Discount + '", DiscounType: "' + DiscounType + '"}',
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
                if ($('#<%=ddl_BillType.ClientID%>').val() == "4") {
                    $('#lblmsg').text("Only 1 pc of each product can be selected.!!");
                }
                else {
                    $('#lblmsg').text("Maximum Allowed : : " + Maxqty);
                }
            }

            var BillType = "1";
            if ($('#<%=ddltype.ClientID%>').val() == "2" || $('#<%=ddltype.ClientID%>').val() == "3") {
                BillType = "2";
            }
            var Pack_Rep = $('#<%=ddl_BillType.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/UpdateQty',
                data: '{batchid: "' + batchid + '", Qty: "' + Qty + '", BillType: "' + BillType + '", Pack_Rep: "' + Pack_Rep + '"}',
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
                url: 'BarcodeBilling.aspx/DeleteProd',
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


        function Calc_Delivery_Charge(NetAmt) {
            let DeliveryCharge = 0;
            if (NetAmt <= 1000) {
                DeliveryCharge = 99;
            }
            else if (NetAmt > 1001 && NetAmt <= 2000) {
                DeliveryCharge = 149;
            }
            else if (NetAmt > 2001 && NetAmt <= 3000) {
                DeliveryCharge = 199;
            }
            else if (NetAmt > 3000) {
                DeliveryCharge = 0;
            }
            return DeliveryCharge
        }


        function Update_Discount_Delcharge() {
            $('#lblmsg').html('');
            var Hnd_NetAmt = $('#hnd_TotalAmt').val();
            var discount = "0"; // $('#<%=txt_Discount.ClientID%>').val();
            discount = parseFloat((discount == '' || discount == null || isNaN(parseFloat(discount))) ? 0 : discount);
            //if (discount > parseFloat(Hnd_NetAmt)) {
            //    alert("Discount cann't greater than Net Amount.!!");
            //    return;
            //}

            var GST = $('#ddl_GST').val();
            GST = parseFloat((GST == '' || GST == null || isNaN(parseFloat(GST))) ? 0 : GST);
            <%--var delCharge = $('#<%=txt_DelCharge.ClientID%>').val();
            delCharge = parseFloat((delCharge == '' || delCharge == null || isNaN(parseFloat(delCharge))) ? 0 : delCharge);
            delCharge = parseFloat(delCharge) + parseFloat((delCharge * GST / 100));--%>
            // $('#<%=lbl_DeliveryAmount.ClientID%>').text(delCharge);

           // var Deliverycharge = $('#<%=lbl_DeliveryAmount.ClientID%>').text() == "" ? "0" : $('#<%=lbl_DeliveryAmount.ClientID%>').text();

            var delCharge = 0; // $('#<%=txt_DelCharge.ClientID%>').val();

            if ($('#<%=ddl_PickupType.ClientID%>').val() == "1") {
                var delCharge = Calc_Delivery_Charge($('#hnd_TotalAmt').val());
                $('#<%=lbl_DeliveryAmount.ClientID%>').text(delCharge.toFixed(2));
            } else {
                $('#<%=lbl_DeliveryAmount.ClientID%>').text(0);
            }


            $('#<%=lbl_Net_Amt.ClientID%>').text(Math.round((parseFloat(Hnd_NetAmt) + parseFloat(delCharge)) - parseFloat(discount)) + ".00");

           <%-- if ($('#<%=ddl_BillType.ClientID%>').val() == "4" || $('#<%=ddl_BillType.ClientID%>').val() == "6") {
                $('#lbl_GrossAmount_Upper').text("Gross Amount " + $('#<%=lbl_Prod_Val.ClientID%>').text());
            } else {
                $('#lbl_GrossAmount_Upper').text("Gross Amount " + $('#<%=lbl_Net_Amt.ClientID%>').text());
            }--%>

            let TotalInv = (parseFloat($('#<%=lbl_Prod_Val.ClientID%>').text()) + parseFloat($('#<%=lbl_Gst_Amt.ClientID%>').text()));
            //var Adjustment = TotalInv.toFixed(2).toString().split(".")[1];
            var Adjustment = (parseFloat(Hnd_NetAmt) - parseFloat(TotalInv));
            $('#<%=txt_Adjustment.ClientID%>').val(Adjustment.toFixed(2));

            return;
        }
    </script>

    <input type="hidden" id="hnd_DISC_Perc" value="0" />

    <input type="hidden" id="hnd_jamount" value="0" />

    <input type="hidden" id="hnd_TotalBV" value="0" />
    <input type="hidden" id="hnd_ExtraPV" value="0" />

    <input type="hidden" id="NoOf_Row_PV" value="0" />
    <input type="hidden" id="NoOf_Row_Amount" value="0" />

    <input type="hidden" id="Product_Max_Item" value="0" />
    <input type="hidden" id="Amount_Max_Item" value="0" />
    <input type="hidden" id="BV_Max_Item" value="0" />
    <input type="hidden" id="hnd_TotalAmt" value="0" />
    <input type="hidden" id="hnd_BVType" value="<%=method.BINARY_PV%>" />
    <input type="hidden" id="hnd_Inv" value="" />
    <asp:HiddenField ID="hnd_Barcode" runat="server" Value="0" />
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Associate Invoice</h4>

    <div class=" row">
        <div class="col-md-2 d-none">
            <asp:DropDownList ID="ddltype" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddltype_SelectedIndexChanged">
                <asp:ListItem Value="1">Associate Invoice</asp:ListItem>
                <%--<asp:ListItem Value="3">Make New PO</asp:ListItem>--%>
            </asp:DropDownList>
        </div>
        <div id="div_Packagetype" runat="server" class="col-md-2">
            <asp:DropDownList ID="ddl_BillType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddltype_SelectedIndexChanged">
                <%--  <asp:ListItem Value="1">First Billing</asp:ListItem>--%>
                <asp:ListItem Value="3">Generation</asp:ListItem>
                <asp:ListItem Value="4">Consistency</asp:ListItem>
                <%-- <asp:ListItem Value="6">P-Wallet</asp:ListItem> --%>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control"
                placeholder="Enter User Id" Enabled="false"></asp:TextBox>
            <span id="lblUserName" style="font-size: 10px;"></span>
        </div>
        <div class="col-sm-3">
            <asp:TextBox ID="txt_Barcode" runat="server" CssClass="form-control" placeholder="Select Product..."></asp:TextBox>
        </div>
        <div class="col-md-2" style="display: none;">
            <asp:TextBox ID="txtpartgstno" runat="server" CssClass="form-control" placeholder="Party GST No"></asp:TextBox>
        </div>
        <div class="col-md-2" style="display: none;">
            <asp:TextBox ID="txt_EwayNo" runat="server" CssClass="form-control" placeholder="Enter E-Way Bill No."></asp:TextBox>
            <asp:DropDownList ID="ddlSellerState" runat="server" CssClass="form-control" Style="display: none;">
                <asp:ListItem Value="0">Seller State</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="txtbilldate" runat="server" placeholder="Select Billing Date." CssClass="form-control" Style="display: none;"></asp:TextBox>

        </div>
    </div>



    <div class="row" style="padding-bottom: 10px;">
        <div id="lblmsg" class="col-sm-12 text-center" style="color: Red;">
        </div>
    </div>
    <hr />
    <%--<div class="clearfix">
    </div>
    <div class="row" style="padding-bottom: 10px;">
        <div class="col-sm-3"><span id="lbl_GrossAmount_Upper" style="font-size: 17px; color: blue;"></span></div>
        <div class="col-sm-3"><span id="lbl_RPVTPV_Upper" style="font-size: 17px; color: blue;"></span></div>
        <div class="col-sm-3"></div>
        <div class="col-sm-3"></div>
    </div>--%>

    <div class="clearfix">
    </div>
    <div class="table-responsive">
        <div style="overflow: auto;">
            <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%;"></table>
        </div>
        <center>
            <span id="lbl_tbl" style="color: Red; padding: 2px;"></span>
        </center>
    </div>
    <div class="table-responsive">
        <div style="overflow: auto;">
            <div id="FreeList" style="width: 100%">
            </div>
        </div>
    </div>

    <div class="clearfix">
    </div>
    <div class=" card-group-row row">
        <div class="col-md-6" id="div_ProdDetails" style="display: none;">


            <div id="div_shipping" style="display: block;">
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
                    <a href="javascript:void(0)" onclick="OPTGenerate(1)" class="btn btn-primary">Generate OTP</a>
                </div>
                <div class="col-sm-6">
                    <div id="trOTPVerify" style="display: none">
                        ENTER OTP :
                            <div class="clearfix"></div>
                        <asp:TextBox ID="txtOTP" runat="server" MaxLength="10" CssClass="form-control" Style="width: 120px; float: left"></asp:TextBox>
                        <a href="javascript:void(0)" onclick="OPTVerift()" class="btn btn-light" style="float: left">Verify</a>
                        <div class="clearfix">
                        </div>

                        <br />
                        <span id="lblOTPMSG"></span>
                        <br />
                        <div id="divRegenerate">
                            <a href="javascript:void(0)" onclick="OPTGenerate(2)" class="btn btn-primary">Re-Generate OTP</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="padding-bottom: 10px;">
                <div class="col-sm-12">
                    <asp:TextBox ID="txt_UserRemark" runat="server" Rows="3" placeholder="Remark"
                        MaxLength="500" CssClass="form-control" Style="height: 150px;"></asp:TextBox>
                </div>
            </div>
            <div class="clearfix">
            </div>

        </div>
        <div class="col-md-6">

            <div id="div_PaymentDetails" style="display: none;">
                <h4 class="billing-cart">Billing Detail</h4>

                <div class="clearfix"></div>
                <div class="row" style="display: none;">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            Cumulative Invoice Value
                        </label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left;">
                        <asp:Label ID="lbl_CumulativeInvVal" runat="server" CssClass="control-label form-control" Style="text-align: right;">0</asp:Label>
                    </div>
                </div>


                <div class="clearfix"></div>
                <div class="row" style="display: none;">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            <asp:Label ID="lbl_baltext" runat="server">Wallet Balance</asp:Label>
                        </label>
                    </div>
                    <div class="col-md-4 col-xs-4 " style="width: 30%; float: left;">
                        <asp:Label ID="lbl_Bal" runat="server" CssClass="control-label form-control" Style="text-align: right;">0.00</asp:Label>
                    </div>
                </div>
                <div class="clearfix"></div>

                <div class="row">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            Gross
                        </label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left;">
                        <asp:Label ID="lbl_Prod_Val" runat="server" CssClass="control-label form-control" Style="text-align: right;">0</asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            GST
                        </label>
                    </div>
                    <div class="col-md-3 col-xs-4" style="width: 30%; float: left;">
                        <asp:Label ID="lbl_Gst_Amt" runat="server" CssClass="control-label form-control" Style="text-align: right;">0</asp:Label>
                    </div>
                </div>

                <div class="clearfix"></div>
                <div class="row d-none">
                    <div class="col-md-8 col-xs-8">
                        <label class="control-label form-control">Extra PV</label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="text-align: right;">
                        <asp:Label ID="lbl_ExtraPV" runat="server" CssClass="control-label form-control">0.00</asp:Label>
                    </div>
                </div>

                <div class="clearfix">
                </div>
                <div class="row d-none">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control"><span id="lbl_BVType">PV</span> </label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left;">
                        <asp:Label ID="lbl_TotalBV" runat="server" CssClass="control-label form-control" Style="text-align: right;">0</asp:Label>
                    </div>

                </div>

                <div class="clearfix">
                </div>
                <div class="row d-none">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            Scheme</label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left;">
                        <asp:Label ID="lbl_SchemeAmt" runat="server" CssClass="control-label form-control" Style="text-align: right;">0.00</asp:Label>
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="row" style="padding-top: 5px;">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">Discount <span id="lbl_DiscountPerc" class="pull-right text-right" style="font-weight: 700;"></span></label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left;">
                        <asp:TextBox ID="txt_Discount" runat="server" CssClass="form-control text-left" Enabled="false"
                            Style="text-align: right;">0.00</asp:TextBox>
                    </div>
                </div>
                <div class="clearfix"></div>

                <div class="row">
                    <div class="col-md-8"><span class="form-control">Select Pickup Type</span></div>
                    <div class="col-md-4 text-end d-flex">
                        <asp:DropDownList ID="ddl_PickupType" runat="server" onchange="Update_Discount_Delcharge();" class="form-control">
                            <asp:ListItem Value="0">Pickup Type</asp:ListItem>
                            <asp:ListItem Value="1">Courier</asp:ListItem>
                            <asp:ListItem Value="2">Store pickup</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="clearfix"></div>


                <div class="row">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            Delivery Charge</label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left;">
                        <select id="ddl_GST" class="dropdown-select form-control text-left"
                            style="width: 45%; float: left; text-align: right;" disabled="disabled">
                            <option value="0">0%</option>
                            <%-- <option value="18" selected="selected">18%</option>--%>
                        </select>
                        <asp:TextBox ID="txt_DelCharge" runat="server" CssClass="form-control text-right" Enabled="false"
                            Width="55%" Style="float: left; text-align: right;">0.00</asp:TextBox>
                    </div>

                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            Net Delivery Charge</label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left; text-align: right">
                        <asp:Label ID="lbl_DeliveryAmount" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>

                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            Gross Amount(Rs)</label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: right; text-align: right;">
                        <asp:Label ID="lbl_Net_Amt" runat="server" CssClass="control-label form-control">0</asp:Label>
                    </div>

                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">
                            Adjustment Amount</label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left; text-align: right;">
                        <asp:TextBox ID="txt_Adjustment" runat="server" Enabled="false" CssClass="form-control" Style="text-align: right;">0.00</asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-8 col-xs-8" style="width: 70%; float: left;">
                        <label class="control-label form-control">Gross Weight</label>
                    </div>
                    <div class="col-md-4 col-xs-4" style="width: 30%; float: left; text-align: right;">
                        <asp:Label ID="lbl_GrossWeight" runat="server" CssClass="control-label form-control"></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">
                    <div class="col-md-4 col-xs-4">
                        <input type="button" id="btn_submit" value="Save Details" onclick="return Generate_Inv()"
                            class="btn btn-primary" />
                    </div>
                    <div class="col-md-2 col-sm-2">
                    </div>
                    <div class="col-md-6 col-xs-6">
                        <asp:TextBox ID="txt_RefUser" runat="server" CssClass="form-control" onchange="GetUserRefId();" placeholder="Reference User"></asp:TextBox>
                        <span id="lblRefName" style="font-size: 10px;"></span>
                    </div>


                </div>
                <div class="clearfix">
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix">
    </div>

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




    <div id="divProductcode" style="display: none;" runat="server"></div>


    <%-- <link href="assets/css/jquery.autocomplete.css" rel="stylesheet" />--%>
    <script src="assets/js/jquery.autocomplete.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <%--<link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>--%>

    <%--    <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>--%>
    <%--  <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>--%>

    <script> var $J = $.noConflict(true); </script>

    <script type="text/javascript">
        $(function () {
            SH_PaymentMode();
            showdiv();
            // $('#<%=txtbilldate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });
            // $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });

            BindChkBarcode($('#<%=hnd_Barcode.ClientID%>').val());
        });

        function Generate_Inv() {

            $('#lblmsg').html('');
            var MSG = "";
            var PackStockType = $('#<%=ddltype.ClientID%>').val(),
                BillType = $('#<%=ddl_BillType.ClientID%>').val(),
                UserId = $('#<%=txt_Userid.ClientID%>').val(),
                Discount = "0", // $('#<%=txt_Discount.ClientID%>').val(), 
                DelCharge = $('#<%=lbl_DeliveryAmount.ClientID%>').text(),
                User_State = $('#<%=ddl_state.ClientID%>').val(),
                Admin_State = $('#<%=ddlSellerState.ClientID%>').val(),
                paymode = $('#<%=ddlpaytype.ClientID%> option:selected').text(),
                paymodeVal = $('#<%=ddlpaytype.ClientID%>').val(),
                bankname = $('#<%=txtbname.ClientID%>').val(),
                checkno = $('#<%=txtDD.ClientID%>').val(),
                CheDate = $('#<%=txtDate.ClientID%>').val(),
                toAdd = $('#<%=txtName.ClientID%>').val() + "<br/>" + $('#<%=txtaddress.ClientID%>').val() + ", " + $('#<%=ddl_state.ClientID%> option:selected').text() + ", " + $('#<%=ddl_district.ClientID%> option:selected').text() + ", " + $('#<%=txtCity.ClientID%>').val() + ", " + $('#<%=txtPincode.ClientID%>').val() + " <br/>Mobile No:" + $('#<%=txt_Mobile.ClientID%>').val(),
                GSTNo = $('#<%=txtpartgstno.ClientID%>').val(),
                SellerState = $('#<%=ddlSellerState.ClientID%> option:selected').text(),
                PlaseOfSuply = $('#<%=ddl_state.ClientID%> option:selected').text(),
                BillDate = $('#<%=txtbilldate.ClientID%>').val(),
                EwayNo = $('#<%=txt_EwayNo.ClientID%>').val(),
                UserRemark = $('#<%=txt_UserRemark.ClientID%>').val(),
                Ref_User = $('#<%=txt_RefUser.ClientID%>').val(),
                DISC_Perc = $('#hnd_DISC_Perc').val(),
                Adjustment = $('#<%=txt_Adjustment.ClientID%>').val();

            if (PackStockType == "1") {
                if (paymodeVal == "16")
                    paymode = "WalletProduct";
                if (paymodeVal == "7")
                    paymode = "PTran80";
                if (paymodeVal == "8")
                    paymode = "BankTran";
                if (paymodeVal == "9")
                    paymode = "RedeemWallet";
                if (paymodeVal == "11")
                    paymode = "PTran20";
                if (paymodeVal == "12")
                    paymode = "RewardWallet";
            }

            Adjustment = parseFloat((Adjustment == '' || Adjustment == null || isNaN(parseFloat(Adjustment))) ? 0 : Adjustment);
            Discount = parseFloat((Discount == '' || Discount == null || isNaN(parseFloat(Discount))) ? 0 : Discount);
            DelCharge = parseFloat((DelCharge == '' || DelCharge == null || isNaN(parseFloat(DelCharge))) ? 0 : DelCharge);


            var SchemeItemIdStr = "";
            var Count_Amt_Item = 0, Count_BV_Item = 0, Count_Product_Item = 0;
            $.each(ITEMLISTID, function (index, value) {
                if ($('#' + value).is(":checked")) {
                    var NoofItem = $('#NoofItem' + value).val();
                    SchemeItemIdStr += value + '^' + NoofItem + ",";

                    if ($('#OfferType' + value).val() == "AMOUNT") {
                        Count_Amt_Item = Count_Amt_Item + 1;
                    }
                    else if ($('#OfferType' + value).val() == "BV") {
                        Count_BV_Item = Count_BV_Item + 1;
                    }
                    else if ($('#OfferType' + value).val() == "PRODUCT") {
                        if ($('#' + value).is(':enabled')) {
                            Count_Product_Item = Count_Product_Item + 1;
                        }
                    }
                }
            });


            if ($('#chk_Amount').is(":checked")) {
                if ($('#Amount_Max_Item').val() != Count_Amt_Item) {
                    MSG += "\n Please select Amount Offer No Of = " + $('#Amount_Max_Item').val() + " Item";
                }
            }
            if ($('#chk_BV').is(":checked")) {
                if ($('#BV_Max_Item').val() != Count_BV_Item) {
                    MSG += "\n Please select BV Offer No Of = " + $('#BV_Max_Item').val() + " Item";
                }
            }
            if ($('#chk_PRODUCT').is(":checked")) {
                if ($('#Product_Max_Item').val() != Count_Product_Item) {
                    MSG += "\n Please select Product Offer No Of = " + $('#Product_Max_Item').val() + " Item";
                }
            }

            if ($('#Product_Max_Item').val() != Count_Product_Item) {
                MSG += "\n Please select Product Offer.!!";
            }
            if ($('#Amount_Max_Item').val() != Count_Amt_Item) {
                MSG += "\n Please select Amount Offer.!!";
            }
            if ($('#BV_Max_Item').val() != Count_BV_Item) {
                MSG += "\n Please select PV Offer.!!";
            }


            if (User_State == "0") {
                MSG += "\n Please Select Buyer State.!";
                $('#<%=txt_Userid.ClientID%>').focus();
            }

            if ($("#<%=ddl_district.ClientID%>").val() == "0") {
                MSG += "\n Please Select District.!";
                $('#<%=ddl_district.ClientID%>').focus();
            }

            if (Admin_State == "0") {
                MSG += "\n Please Select Seller State.!";
                $('#<%=txt_Userid.ClientID%>').focus();
            }

            if (PackStockType == "1") {
                if (BillType == "0") {
                    MSG += "\n Please Select Package.!";
                    $('#<%=ddl_BillType.ClientID%>').focus();
                }
            }

            if (UserId == "") {
                MSG += "\n Please Enter User Id.!";
                $('#<%=txt_Userid.ClientID%>').focus();
            }

            if ($('#<%=ddl_PickupType.ClientID%>').val() == "0") {
                MSG += "\n Please Select Pickup Type.!";
                $('#<%=ddl_PickupType.ClientID%>').focus();
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
                url: 'BarcodeBilling.aspx/GenerateInv',
                data: '{PackStockType: "' + PackStockType + '", BillType: "' + BillType + '", UserId: "' + UserId + '", Discount: "' + Discount + '", DISC_Perc: "' + DISC_Perc + '", DelCharge: "' + DelCharge + '", User_State: "' + User_State + '", Admin_State: "' + Admin_State + '", paymode: "' + paymode + '", bankname: "' + bankname
                    + '", checkno: "' + checkno + '", CheDate: "' + CheDate + '", toAdd: "' + toAdd + '", GSTNo: "' + GSTNo + '", PlaseOfSuply: "' + PlaseOfSuply + '", SellerState: "' + SellerState + '", BillDate: "' + BillDate
                    + '", SchemeItemIdStr: "' + SchemeItemIdStr + '", EwayNo: "' + EwayNo + '", paymodeVal: "' + paymodeVal + '", UserRemark: "' + UserRemark + '", Ref_User: "' + Ref_User + '", Adjustment: "' + Adjustment + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $("#btn_submit").val("Save Details");
                    $('#btn_submit').attr('disabled', false);
                    if (data.d.Error == "") {
                        if (paymodeVal == "5") {  //Paytm
                            window.location = "PaytmRequest.aspx?id=" + data.d.InvoiceNo;
                        }
                        else if (paymodeVal == "14") {
                            window.location = "../OpenMoneyReq.aspx?id=" + data.d.InvoiceNo;
                        }
                        //if (paymodeVal == "13") {
                        //    window.location = "RazorpayRequest.aspx?id=" + data.d.InvoiceNo;
                        //}
                        else {
                            $("#hnd_Inv").val(data.d.InvoiceNo);

                            $('#<%=txt_Discount.ClientID%>').val(0.00);
                            $('#<%=txt_Adjustment.ClientID%>').val(0.00);
                            $('#<%=txtpartgstno.ClientID%>').val('');
                            $('#<%=ddl_state.ClientID%>').val(0);
                            $('#<%=txt_EwayNo.ClientID%>').val('');
                            $('#<%=txt_Mobile.ClientID%>').val('');
                            $('#<%=txtPincode.ClientID%>').val('');
                            BindCartTable();
                            $('#lbl_tbl').text('');
                            $('#trOTPVerify').hide();
                            alert("Invoice Generated Successfully. Invoice Number is : " + $("#hnd_Inv").val());
                        }
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
                    $('#lblUserName').text("Server error. Time out.!!");
                    $('#lblUserName').css('color', 'red');
                }
            });
        }



        function GetUserId(Userid) {
            $('#lblmsg').html('');
            $('#lblUserName').text("");
            if (Userid == '') {
                return;
            }
            var Self_Validate = "1";
            if ($('#<%=ddltype.ClientID%>').val() == "2" || $('#<%=ddltype.ClientID%>').val() == "3") {
                Self_Validate = "2";
            }
            var BillType = $('#<%=ddltype.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetUser',
                data: '{Userid: "' + Userid + '", Self_Validate: "' + Self_Validate + '", BillType: "' + BillType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#hnd_jamount').val(data.d.jamount);
                        $('#<%=lbl_CumulativeInvVal.ClientID%>').text(data.d.jamount);
                        $('#<%=txtName.ClientID%>').val(data.d.UserName);
                        $('#<%=txtaddress.ClientID%>').val(data.d.Address);
                        $('#<%=ddl_state.ClientID%>').val(data.d.State);
                        $('#<%=txtCity.ClientID%>').val(data.d.City);
                        $('#<%=txtPincode.ClientID%>').val(data.d.Pincode);
                        $('#<%=txt_Mobile.ClientID%>').val(data.d.Mobile);
                        $('#lblUserName').text(data.d.UserName);
                        $('#lblUserName').css('color', 'Blue');
                        GetDistrict(data.d.distt);
                        Update_Discount_Delcharge();

                        var paymode = $('#<%=ddlpaytype.ClientID%>').val();
                        if (paymode == "16" || paymode == "7" || paymode == "8" || paymode == "9" || paymode == "11" || paymode == "12") {
                            GetBalance($('#<%=ddlpaytype.ClientID%>').val());
                        }
                    }
                    else {
                        $('#<%=txt_Mobile.ClientID%>').val('');
                        $('#<%=txtName.ClientID%>').val('');
                        $('#<%=txtaddress.ClientID%>').val('');
                        $('#<%=ddl_state.ClientID%>').val('');
                        $('#<%=txtCity.ClientID%>').val('');
                        $('#<%=txtPincode.ClientID%>').val('');

                        $('#lblUserName').text(data.d.Error);
                        $('#lblUserName').css('color', 'red');
                        $('#hnd_jamount').val('0');
                    }
                },
                error: function (response) {
                    $('#lblUserName').text("Server error. Time out.!!");
                    $('#lblUserName').css('color', 'red');

                }
            });
        }



        function GetUserRefId() {
            $('#lblmsg').html('');
            var RefUser = $('#<%=txt_RefUser.ClientID%>').val();
            $('#lblRefName').text("");

            if (RefUser == '') {
                return;
            }

            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetUser',
                data: '{Userid: "' + RefUser + '", Self_Validate: "1", BillType: "1"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#lblRefName').text(data.d.UserName);
                        $('#lblRefName').css('color', 'Blue');
                    }
                    else {
                        $('#lblRefName').text("Please Enter Valid Reference UserId.!!");
                        $('#lblRefName').css('color', 'red');
                    }
                },
                error: function (response) {
                    $('#lblRefName').text("Server error. Time out.!!");
                    $('#lblRefName').css('color', 'red');
                }
            });
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



        function SH_PaymentMode() {

            $('#<%=div_Packagetype.ClientID%>').show();
            $("#<%=ddlpaytype.ClientID %>").empty();

            if ($('#<%=ddl_BillType.ClientID%>').val() == "4") {
                $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(9).html('Consistency Wallet'));
            }
            else if ($('#<%=ddl_BillType.ClientID%>').val() == "6") {
                $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(16).html('Product Wallet'));
            }
            else {
                <%--$("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(1).html('Cash'));
                    $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(2).html('Cheque'));
                    $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(3).html('Net Banking'));
                    $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(4).html('DD'));
                    $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(5).html('Credit Card'));
                    $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(6).html('Debit Card'));--%>
               // $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(8).html('Company Wallet'));
               // $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(13).html('Razorpay'));
                $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(5).html('CCAvenue'));
                //$("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(14).html('OpenMoney'));


               <%-- $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(7).html('G Wallet'));
                $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(11).html('T Wallet'));
                $("#<%=ddlpaytype.ClientID %>").append($("<option></option>").val(12).html('R Wallet'));--%>
            }

            PayModeDisplay();
        }


        function PayModeDisplay() {

            var Paymode = $('#<%=ddlpaytype.ClientID%>').val();
            $('#trOTPGen').hide();

            $('#<%=lbl_Bal.ClientID%>').text('0.00');
            $('#<%=lbl_baltext.ClientID%>').text("");
            $('#btn_submit').attr('disabled', false);
            if (Paymode == 1 || Paymode == 5 || Paymode == 14) {
                $('#<%=txtbname.ClientID%>').hide();
                $('#<%=txtDD.ClientID%>').hide();
                $('#<%=txtDate.ClientID%>').hide();
            }
            else if (Paymode == 16 || Paymode == 7 || Paymode == 8 || Paymode == 9 || Paymode == 11 || Paymode == 12) {
                $('#<%=txtbname.ClientID%>').hide();
                $('#<%=txtDD.ClientID%>').hide();
                $('#<%=txtDate.ClientID%>').hide();
                $('#trOTPGen').show();
                $('#btn_submit').attr('disabled', true);
                GetBalance(Paymode);
            }
            else {
                $('#<%=txtbname.ClientID%>').show();
                $('#<%=txtDD.ClientID%>').show();
                $('#<%=txtDate.ClientID%>').show();
            }
        }

        function ResetCart() {

            SH_PaymentMode();
            if ($('#<%=ddl_BillType.ClientID%>').val() == "1") {
                $('#hnd_BVType').val("<%=method.BINARY_PV%>");
            }
            else {
                $('#hnd_BVType').val("<%=method.PV%>");
            }
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/ResetCart',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "") {
                        BindCartTable();
                    }
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                }
            });
        }



        function GetBalance(WalletType) {

            if (WalletType == "16") {
                $('#<%=lbl_baltext.ClientID%>').text("P-Wallet Balance");
            }
            else if (WalletType == "7") {
                $('#<%=lbl_baltext.ClientID%>').text("Payout-Wallet Balance");
            }
            else if (WalletType == "8") {
                $('#<%=lbl_baltext.ClientID%>').text("Company-Wallet Balance");
            }
            else if (WalletType == "9") {
                $('#<%=lbl_baltext.ClientID%>').text("Consistency Wallet Balance");
            }
            else if (WalletType == "11") {
                $('#<%=lbl_baltext.ClientID%>').text("T Wallet Balance");
            }
            else if (WalletType == "12") {
                $('#<%=lbl_baltext.ClientID%>').text("R Wallet Balance");
            }

            if ($('#<%=txt_Userid.ClientID%>').val() == '') {
                $('#lblmsg').text("Please Enter User Id.!!");
                return;
            }
            $.ajax({
                type: "POST",
                url: 'BarcodeBilling.aspx/GetBalanceUser',
                data: '{RegNo: "' + $('#<%=txt_Userid.ClientID%>').val() + '", WalletType: "' + WalletType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#<%=lbl_Bal.ClientID%>').text(data.d);
                },
                error: function (response) {
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
                    //$('#<%=txt_Barcode.ClientID%>').autocomplete(Productcode);
                $J('#<%=txt_Barcode.ClientID%>').autocomplete({ source: Productcode });
                $('#chk_Barcode').attr('checked', false);
            }
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
                url: 'BarcodeBilling.aspx/GenerateOTP',
                data: '{UserName: "' + UserName + '", Amount: "' + Amount + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#<%=txtOTP.ClientID %>').val(response.d);

                    //if (response.d == '0') {
                    $('#trOTPGen').hide();
                    $('#trOTPVerify').show();
                    if (flag == "2") {
                        $('#lblOTPMSG').text("OTP RE-GENERATED.");
                        $('#lblOTPMSG').css('color', 'green');
                    }
                    //}
                    //return false;
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
                url: 'BarcodeBilling.aspx/VerifyOTP',
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
    </script>


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

        .billing-cart {
            text-align: left;
            background: #ffe5f0;
            margin: 15px 0;
            padding: 10px;
            color: #000;
        }
    </style>

</asp:Content>
