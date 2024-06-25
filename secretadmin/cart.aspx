<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="cart.aspx.cs" Inherits="cart" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="testmonial header_cat ptb-90">
        <div class="container">
            <div class="text-center">
                <h2>Cart</h2>
                <div class="bread-crumb">
                    <span>
                        <a href="default.aspx">Home</a></span><i class="fa fa-angle-right"></i><span><a href="javascript:void(0)">Cart</a>
                        </span>
                </div>
            </div>
        </div>
    </div>


    <div class="section checkout-sec cart-sec pt-4">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div id="lblmsg" class="col-sm-12 text-center" style="color: Red;">
                    </div>
                </div>
                <div class="clearfix">
                </div>

                <div class="col-12">
                    <div class="table-responsive">
                        <table class="table text-nowrap" id="tblList"></table>
                    </div>
                </div>

                <div class="col-12">
                    <div id="FreeList" class="checkout-table"></div>
                </div>


                <div class="col-xl-6" style="display: none;">
                    <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Enter Userid" onchange="GetUserId();"></asp:TextBox>
                    <span id="lbl_PaymentUserid"></span>
                </div>


                <div id="div_ProdDetails" class="col-xl-6">
                    <div class="checkout-form">
                        <h4 class="billing-cart">Shipping Detail</h4>
                        <div class="row">
                            <div class="col-xl-12 form-group">
                                <span id="lbl_UserDetails" style="color: blue;"></span>
                            </div>

                            <div class="col-xl-12 form-group">
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Your Name"></asp:TextBox>
                            </div>
                            <div class="col-xl-12 form-group">
                                <asp:TextBox ID="txtaddress" runat="server" placeholder="Enter Your Address " CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-xl-6 form-group">
                                <asp:DropDownList ID="ddl_state" runat="server" CssClass="form-control" onchange="GetDistrict('');">
                                    <asp:ListItem Value="0">Select State</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xl-6 form-group">
                                <asp:DropDownList ID="ddl_district" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0">Select District</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xl-6 form-group">
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Enter Your City"></asp:TextBox>
                            </div>
                            <div class="col-xl-6 form-group">
                                <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control" placeholder="Enter Your Pincode"></asp:TextBox>
                            </div>
                            <div class="col-xl-12 form-group">
                                <asp:TextBox ID="txt_Mobile" runat="server" CssClass="form-control" placeholder="Enter Your Mobile No."></asp:TextBox>
                            </div>
                        </div>
                        <h4 class="billing-cart">Payment Mode</h4>
                        <div class="row">
                            <div class="clearfix"></div>

                            <div class="col-xl-6 form-group">
                                <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="5">CCAvenue</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xl-6 form-group">
                               <%-- <img src="https://www.morinalife.com/images/cc_avenue.png" height="40px" />--%>
                            </div>

                            <div class="col-xl-6 form-group d-none">
                                <asp:TextBox ID="txt_RefUser" runat="server" CssClass="form-control" placeholder="Reference User"></asp:TextBox>
                                <span id="lblRefName" style="font-size: 10px;"></span>
                                <%--<input type="email" class="form-control" placeholder="Generate OTP" name="email" value="" required="">--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="div_ProdDetails2" class="col-xl-6"> 
                    <div class="checkout-form">
                        <h4 class="billing-cart">Billing Detail</h4>
                        <div class="row">

                            <div class="col-6" style="display: none;">
                                <asp:Label ID="lbl_baltext" runat="server" CssClass="control-label"></asp:Label>
                            </div>
                            <div class="col-6" style="display: none;">
                                <asp:Label ID="lbl_Bal" runat="server" CssClass="control-label"></asp:Label>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-8 pb-2" style="display: none;"><span id="lbl_BVType" style="display: none;" class="form-control">RPV</span></div>
                            <div class="col-4 pb-2 text-end">
                                <asp:Label ID="lbl_TotalBV" Style="display: none;" runat="server" CssClass="control-label form-control">0</asp:Label>
                            </div>
                            <div class="clearfix"></div>


                            <div class="col-8 pb-2"><span class="form-control">Gross</span></div>
                            <div class="col-4 pb-2 text-end">
                                <asp:Label ID="lbl_Gross" runat="server" CssClass="control-label form-control">0</asp:Label>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-8 pb-2"><span class="form-control">Billing Value</span></div>
                            <div class="col-4 pb-2 text-end">
                                <asp:Label ID="lbl_Prod_Val" runat="server" CssClass="control-label form-control">0</asp:Label>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-8 pb-2"><span class="form-control">GST</span></div>
                            <div class="col-4 pb-2 text-end">
                                <asp:Label ID="lbl_Gst_Amt" runat="server" CssClass="control-label form-control">0</asp:Label>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-8 pb-2"><span class="form-control">Adjustment Amount</span></div>
                            <div class="col-4 pb-2 text-end">
                                <asp:TextBox ID="txt_Adjustment" runat="server" Enabled="false" CssClass="form-control text-end" Font-Size="Medium">0</asp:TextBox>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-8 pb-2"><span class="form-control">Scheme</span></div>
                            <div class="col-4 pb-2 text-end">
                                <asp:Label ID="lbl_SchemeAmt" runat="server" CssClass="control-label form-control">0</asp:Label>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-8 pb-2 d-none"><span class="form-control">Discount <span id="lbl_DiscountPerc" class="pull-right text-right" style="font-weight: 700;"></span></span></div>
                            <div class="col-4 pb-2 text-end d-none">
                                <asp:TextBox ID="txt_Discount" runat="server" CssClass="form-control text-end" Enabled="false">0</asp:TextBox>
                            </div>

                            <div class="clearfix"></div>
                            <div class="col-8 pb-2"><span class="form-control">Delivery Charge</span></div>

                            <div class="col-4 pb-2 text-end d-flex">
                                <div class="col-5">
                                    <select id="ddl_GST" class="form-control" disabled="disabled">
                                        <option value="0">0</option>
                                    </select>
                                </div>
                                <div class="col-7">
                                    <asp:TextBox ID="txt_DelCharge" runat="server" CssClass="form-control text-left hidden" Enabled="false"
                                        Font-Size="Medium">0</asp:TextBox>

                                </div>

                            </div>

                        <div class="clearfix"></div>
                        <div class="col-8 pb-2"><span class="form-control">Net Delivery Charge</span></div>
                        <div class="col-4 pb-2 text-end">
                            <asp:Label ID="lbl_DeliveryAmount" runat="server" CssClass="control-label form-control" Font-Bold="true">0</asp:Label>
                        </div>

                        <div class="clearfix"></div>
                        <div class="col-8 pb-2"><span class="form-control">Invoice Value(Rs)</span></div>
                        <div class="col-4 pb-2 text-end">
                            <asp:Label ID="lbl_Net_Amt" runat="server" CssClass="control-label form-control" Font-Bold="true">0</asp:Label>
                        </div>
                        <div class="clearfix"></div>

                        <div class="col-8 pb-2"><span class="form-control">Gross Weight</span></div>
                        <div class="col-4 pb-2 text-end">
                            <asp:Label ID="lbl_GrossWeight" runat="server" CssClass="control-label form-control" Font-Bold="true">0</asp:Label>
                        </div>
                        <div class="clearfix"></div>
                        <hr />
                        <div class="col-8">
                            <a href="products" class="btn">Continue shopping</a>
                        </div>
                        <div class="col-4 ">
                            <input type="button" id="btn_submit" value="Check Out" onclick="return Generate_Inv()" class='btn' />
                        </div>
                        <div class="clearfix"></div>
                        <br />
                    </div>
                    <div class="row" style="display: none;">
                        <div class="clearfix">
                        </div>
                        <div class="col-lg-12">
                            <b>Terms & Conditions </b>
                            <br />
                            1. Good Once Sold Will Be Taken Back.<br />
                            2. Warranty Will Be Under Taken By The Manufacture Only.<br />
                            3. All Disputes Are Subject To Jurisdiction.<br />
                            4. Company Is Not Responsible After The Goods Leave The Premises<br />
                            5. Any Inaccuracy In The Bill Must Be Notifided Immediately On Its Receipt.<br />
                            6. This is a Computer Generated Invoice. No Signature Required.
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    </div>
    <input type="hidden" id="hnd_TotalGross" value="0" />
    <input type="hidden" id="hnd_DISC_Perc" value="0" />
    <input type="hidden" id="hnd_jamount" value="0" />


    <!-- Checkout End -->
    <input type="hidden" id="NoOf_Row_PV" value="0" />
    <input type="hidden" id="NoOf_Row_Amount" value="0" />

    <input type="hidden" id="Product_Max_Item" value="0" />
    <input type="hidden" id="Amount_Max_Item" value="0" />
    <input type="hidden" id="BV_Max_Item" value="0" />
    <input type="hidden" id="hnd_TotalAmt" value="0" />
    <input type="hidden" id="hnd_BVType" value="TPV" />
    <input type="hidden" id="hnd_Inv" value="" />
    <script src="datepick/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
        var URL = "Service.aspx";
        $(function () {
            $('#lbl_UserDetails').text("(Customer)");
            if ($('#<%=txt_Userid.ClientID%>').val() != "") {
                GetUserId();
            }

            GetCount();
            BindCartTable();
        });



        function BindCartTable() {
            $('#tblList').empty();
            $.ajax({
                type: "POST",
                url: URL + '/GetCartData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblList').empty().append("<thead><tr>");
                    $('#tblList').append("<th>#</th>");
                    $('#tblList').append("<th>Products</th>");
                    $('#tblList').append("<th>HSN Code</th>");
                    $('#tblList').append("<th>MRP</th>");
                    $('#tblList').append("<th>Quantity</th>");
                    $('#tblList').append("<th>Gross Value</th>");
                    $('#tblList').append("<th>Disc%</th>");
                    $('#tblList').append("<th>Disc Value</th>");
                    $('#tblList').append("<th>Billing Value</th>");
                    $('#tblList').append("<th>GST</th>");
                    $('#tblList').append("<th>Tax</th>");
                    $('#tblList').append("<th>Invoice Value</th>");
                    /*$('#tblList').append("<th>RPV</th>");*/
                    $('#tblList').append("<th><center><span style='color:Red; font-size:x-large;'>&times;</span></center></th>");
                    $('#tblList').append("</tr></thead>");

                    var tbl = '<tbody>';
                    var TotalQty = 0, TotalGST = 0, TotalBV = 0, TotalAmt = 0, TotalTaxable = 0, NetAmt = 0, GrossWeight = 0;
                    var TotalGross = 0, TotalDiscount = 0;
                    for (var i = 0; i < data.d.length; i++) {

                        TotalGross = TotalGross + parseFloat(data.d[i].Gross);
                        TotalDiscount = TotalDiscount + parseFloat(data.d[i].Discount);
                        GrossWeight = GrossWeight + parseFloat(data.d[i].TotalWeight);
                        TotalQty = TotalQty + parseInt(data.d[i].qty);
                        TotalGST = TotalGST + parseFloat(data.d[i].Totaltaxamt);
                        /*TotalBV = TotalBV + parseFloat(data.d[i].totalbvamt);*/
                        TotalAmt = TotalAmt + parseFloat(data.d[i].Gross);
                        TotalTaxable = TotalTaxable + parseFloat(data.d[i].TaxableAmt);
                        NetAmt = NetAmt + parseFloat(data.d[i].totalamt);
                        var Pid = data.d[i].Pid;
                        var batchid = data.d[i].batchid;
                        tbl += '<tr>';
                        tbl += '<td>' + (i + 1) + '</td>';
                        tbl += '<td data-title="product">' + data.d[i].Pcode + ' ' + data.d[i].pname + '</td>';
                        tbl += '<td>' + data.d[i].hsncode + '</td>';
                        tbl += '<td>' + data.d[i].DPWithTax.toFixed(4) + '</td>';
                        tbl += '<td style="display: flex;"> <span class="fa fa-minus quant" onclick="MinusQty(' + batchid + ')" style="cursor: pointer;"></span> <input type="text" id="qty_' + batchid + '" value="' + data.d[i].qty + '" onchange="UpdateQty(' + batchid + ')" class="form-control input-number text-center" maxlength="4" style="width:50px; height: 27px; float: left; padding:5px; border: 1px solid #e9e7e7;"/> <span class="fa fa-plus quant" onclick="AddQty(' + batchid + ')" style="cursor: pointer;"></span>  <input type="hidden" id="Maxqty_' + batchid + '" value="' + data.d[i].MaxQty + '"> </td>';

                        tbl += '<td>' + data.d[i].Gross + '</td>';
                        tbl += '<td>' + data.d[i].Disc_Perc_Val + '%</td>';
                        tbl += '<td>' + data.d[i].Discount + '</td>';

                        tbl += '<td data-title="Price">' + data.d[i].TaxableAmt + '</td>';
                        tbl += '<td data-title="Price">' + data.d[i].tax + '%</td>';
                        tbl += '<td data-title="Price">' + data.d[i].Totaltaxamt + '</td>';
                        tbl += '<td data-title="Price">' + data.d[i].totalamt + '</td>';
                        /*tbl += '<td data-title="Price">' + data.d[i].totalbvamt + '</td>';*/
                        tbl += '<td class="remove"><center><a href="#/"> <span style="color:Red; font-size:x-large;" onclick="DeleteProd(' + batchid + ');" title="Remove">&times;</span> </a> </center> </td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    tbl += "<thead><tr><th></th> <th>Total :</th>  <th></th> <th></th> <th>" + TotalQty + "</th>   <th>" + TotalGross.toFixed(2) + "</th> <th></th> <th>" + TotalDiscount.toFixed(2) + "</th>  <th> " + TotalTaxable.toFixed(2) + "</th> <th></th> <th>" + TotalGST.toFixed(2) + "</th> <th>" + Math.round(NetAmt) + "</th> <th></th> </tr></thead>";
                    $('#tblList').append(tbl);

                    GrossWeight = GrossWeight.toFixed(3);
                    $('#<%=lbl_GrossWeight.ClientID%>').text(GrossWeight);
                    var DeliveryCharge = 0;

                    if (data.d.length == 0) {
                        $('#<%=txt_Userid.ClientID%>').hide();
                        $('#lbl_PaymentUserid').hide();
                        $('#tblList').empty();
                        $('#FreeList').empty().append('');
                        $('#tblList').text('Cart is empty.....');
                        $('#tblList').css('color', 'red');
                        $('#<%=lbl_GrossWeight.ClientID%>').text("0");

                        return false;
                    }
                    if (data.d.length > 0) {
                        /* Show Calculation */

                        $('#<%=lbl_Gross.ClientID%>').text(Math.round(TotalGross.toFixed(2)));
                        $('#hnd_TotalGross').val(Math.round(TotalGross.toFixed(2)));

                        $('#<%=lbl_Prod_Val.ClientID%>').text(TotalAmt.toFixed(2));
                        $('#<%=lbl_Gst_Amt.ClientID%>').text(TotalGST.toFixed(2));
                        $('#<%=lbl_TotalBV.ClientID%>').text(TotalBV.toFixed(2));
                        $('#<%=lbl_Net_Amt.ClientID%>').text(parseFloat(NetAmt.toFixed(2)) + parseFloat(DeliveryCharge));
                        $('#hnd_TotalAmt').val(Math.round(NetAmt));


                        $('#lbl_PaymentUserid').show("slow");
                        Get_Trade_Values();
                        if ($('#<%=txt_Userid.ClientID%>').val() != "") {
                            GetFreeProduct();
                        } 
                        //Update_Discount_Delcharge();
                    }
                    BindMasterCartTable();
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    return false;
                }
            });
        }



        function Get_Trade_Values() {

            $('#hnd_DISC_Perc').val(0);
            $('#<%=txt_DelCharge.ClientID%>').val(0);
            let InvAmt = $('#hnd_TotalGross').val() == "" ? "0" : $('#hnd_TotalGross').val();
            let OldAmt = 0; // $('#hnd_jamount').val() == "" ? "0" : $('#hnd_jamount').val();
            $.ajax({
                type: "POST",
                url: URL + '/Get_Trade_Values',
                data: '{InvAmt: "' + InvAmt + '", OldAmt: "' + OldAmt + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#<%=txt_DelCharge.ClientID%>').val(data.d.Delivery_Charges);
                    Update_Discount_Delcharge();
                },
                error: function (data) { }
            });
        }



        var PRDS_COUNT = [];
        var PRDS_OFFERON_PRDS = [];
        var ITEMLISTID = [];
        function GetFreeProduct() {

            $('#FreeList').empty().append("");
            $('#Amount_Max_Item').val(0);
            $('#BV_Max_Item').val(0);
            $('#Product_Max_Item').val(0);

            $('#NoOf_Row_PV').val(0);
            $('#NoOf_Row_Amount').val(0);

            var BillType = "1";
            var OfferOn = "3";
            var TotalBV = $('#<%=lbl_TotalBV.ClientID%>').text();

            $.ajax({
                type: "POST",
                url: URL + '/GetOfferProduct',
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
                                if (data.d[i].Category_wise_item == '1' && data.d[i].Offer_Type == "PRODUCT") {
                                    temp = ' checked disabled="disabled" ';
                                }
                                else if (data.d[i].Category_wise_item != '1' && data.d[i].Offer_Type == "PRODUCT") {
                                    temp = ' disabled="disabled" ';
                                }
                                else if (data.d[i].Offer_Type == "AMOUNT" || data.d[i].Offer_Type == "BV") {
                                    temp = data.d[i].Item_Qty == '0' ? ' checked disabled="disabled"' : ' disabled="disabled" ';
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
                                tblContent += '<td>' + data.d[i].ProdOffer + '</td>';
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
                        tblContent += "<h5 style='text-align:center; color:blue;'><b>  <input type='checkbox' id='chk_PRODUCT' onclick='OfferCheck(3)' '" + disabled_Product + "'>  <label for='chk_PRODUCT'>Offer Available On (Product) : " + $('#Product_Max_Item').val() + "</label> <br/> <input type='checkbox' id='chk_Amount' onclick='OfferCheck(1)' '" + disabled_Amount + "'> <label for='chk_Amount'>Offer Available On (Amount) : " + $('#Amount_Max_Item').val() + "</label><br/> <input type='checkbox' id='chk_BV' onclick='OfferCheck(2)' '" + disabled_BV + "'>  <label for='chk_BV'>Offer Available On (PV) : " + $('#BV_Max_Item').val() + "</label>  </b> </H5> <hr/>";
                        $('#FreeList').empty().append(tblContent);
                        SelectItemOffer(0);
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

                if ($('#ItemQty' + value).val() != "0") {

                    if ($('#OfferType' + value).val() == "AMOUNT" || $('#OfferType' + value).val() == "BV") {
                        $('#' + value).attr('checked', false);
                    }

                    if ($('#OfferType' + value).val() == "PRODUCT") {
                        if ($('#chk_PRODUCT').is(":checked")) {
                            $('#' + value).removeAttr('disabled', 'disabled');
                        } else {
                            $('#' + value).attr('disabled', 'disabled');
                        }
                    }
                    else if ($('#OfferType' + value).val() == "AMOUNT") {
                        if (id == '1') {
                            $('#' + value).removeAttr('disabled', 'disabled');
                        }
                        else {
                            $('#' + value).attr('disabled', 'disabled');
                        }
                        if ($('#chk_Amount').is(":checked")) {
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
                        if ($('#chk_BV').is(":checked")) {
                            $('#' + value).removeAttr('disabled', 'disabled');
                        }
                        else {
                            $('#' + value).attr('disabled', 'disabled');
                        }
                    }

                }
            });
        }



        function SelectItemOffer(ITEMID) {
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
                url: URL + '/UpdateQty',
                data: '{batchid: "' + batchid + '", Qty: "' + Qty + '", BillType: "1", Pack_Rep: "3"}',
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
                url: URL + '/DeleteProd',
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
            //if (discount > parseFloat(Hnd_NetAmt)) {
            //    alert("Discount cann't greater than Net Amount.!!");
            //    return;
            //}

            var GST = $('#ddl_GST').val();
            GST = parseFloat((GST == '' || GST == null || isNaN(parseFloat(GST))) ? 0 : GST);
            var delCharge = $('#<%=txt_DelCharge.ClientID%>').val();
            delCharge = parseFloat((delCharge == '' || delCharge == null || isNaN(parseFloat(delCharge))) ? 0 : delCharge);
            delCharge = parseFloat(delCharge) + parseFloat((delCharge * GST / 100));

            var Deliverycharge = $('#<%=lbl_DeliveryAmount.ClientID%>').text() == "" ? "0" : $('#<%=lbl_DeliveryAmount.ClientID%>').text();
            $('#<%=lbl_Net_Amt.ClientID%>').text(Math.round((parseFloat(Hnd_NetAmt) + parseFloat(delCharge) + parseFloat(Deliverycharge)) - parseFloat(discount)) + ".00");
            return;
        }
    </script>




    <script type="text/javascript">
        var URL = "Service.aspx";

        function Generate_Inv() {

            var UserId = $('#<%=txt_Userid.ClientID%>').val();
            $('#lblmsg').html('');
            var MSG = "";
            var PackStockType = 1,
                BillType = 3,
                Discount = $('#<%=txt_Discount.ClientID%>').val(),
                DelCharge = $('#<%=lbl_DeliveryAmount.ClientID%>').text(),
                User_State = $('#<%=ddl_state.ClientID%> option:selected').text(),
                Admin_State = '',
                paymode = $('#<%=ddlpaytype.ClientID%> option:selected').text(),
                PaymodeVal = $('#<%=ddlpaytype.ClientID%>').val(),
                bankname = '',
                checkno = '',
                CheDate = '',
                toAdd = $('#<%=txtName.ClientID%>').val() + "<br/>" + $('#<%=txtaddress.ClientID%>').val() + ", " + $('#<%=ddl_state.ClientID%> option:selected').text() + ", " + $('#<%=ddl_district.ClientID%> option:selected').text() + ", " + $('#<%=txtCity.ClientID%>').val() + ", " + $('#<%=txtPincode.ClientID%>').val(),
                GSTNo = '',
                SellerState = '',
                PlaseOfSuply = $('#<%=ddl_state.ClientID%> option:selected').text(),
                Ref_User = $('#<%=txt_RefUser.ClientID%>').val(),

                Name = $('#<%=txtName.ClientID%>').val(),
                address = $('#<%=txtaddress.ClientID%>').val(),
                state = $('#<%=ddl_state.ClientID%> option:selected').text(),
                district = $('#<%=ddl_district.ClientID%> option:selected').text(),
                City = $('#<%=txtCity.ClientID%>').val(),
                Pincode = $('#<%=txtPincode.ClientID%>').val(),
                Mobile = $('#<%=txt_Mobile.ClientID%>').val(),
                DISC_Perc = $('#hnd_DISC_Perc').val();

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


            if (Name == "") {
                MSG += "\n Please Enter Name.!";
                $('#<%=txtName.ClientID%>').focus();
            }
            if (address == "") {
                MSG += "\n Please Enter Address.!";
                $('#<%=txtaddress.ClientID%>').focus();
            }
            if (state == "") {
                MSG += "\n Please Select State.!";
                $('#<%=ddl_state.ClientID%>').focus();
            }
            if (district == "") {
                MSG += "\n Please Select District.!";
                $('#<%=ddl_district.ClientID%>').focus();
            }
            if (City == "") {
                MSG += "\n Please Enter City.!";
                $('#<%=txtCity.ClientID%>').focus();
            }
            if (Pincode == "") {
                MSG += "\n Please Enter Pincode.!";
                $('#<%=txtPincode.ClientID%>').focus();
            }
            if (Mobile == "") {
                MSG += "\n Please Enter Mobile.!";
                $('#<%=txt_Mobile.ClientID%>').focus();
            }



            if (district == "") {
                MSG += "\n Please Select District.!";
                $('#<%=ddl_district.ClientID%>').focus();
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
                data: '{PackStockType: "' + PackStockType + '", BillType: "' + BillType + '", UserId: "' + UserId
                    + '", Discount: "' + Discount + '", DelCharge: "' + DelCharge + '", User_State: "' + User_State
                    + '", Admin_State: "' + Admin_State + '", paymode: "' + paymode + '", bankname: "' + bankname
                    + '", checkno: "' + checkno + '", CheDate: "' + CheDate + '", toAdd: "' + toAdd + '", GSTNo: "' + GSTNo
                    + '", PlaseOfSuply: "' + PlaseOfSuply + '", SellerState: "' + SellerState
                    + '", SchemeItemIdStr: "' + SchemeItemIdStr + '", Ref_User: "' + Ref_User
                    + '" , Name: "' + Name + '" , address: "' + address + '" , state: "' + state
                    + '" , district: "' + district + '" , City: "' + City + '" , Pincode: "' + Pincode
                    + '", DISC_Perc: "' + DISC_Perc + '", Mobile: "' + Mobile + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $("#btn_submit").val("Save Details");
                    $('#btn_submit').attr('disabled', false);
                    if (data.d.Error == "") {
                        $("#hnd_Inv").val(data.d.InvoiceNo);
                        $('#<%=ddl_state.ClientID%>').val(0);

                        if (PaymodeVal == "5") {
                            window.location = "CCAvenue_Request.aspx?id=" + data.d.InvoiceNo;
                        }

                        if (paymode == "PTran80" || paymode == "BankTran") {
                            alert("Invoice Generated Successfully. Invoice Number is : " + data.d.InvoiceNo);
                            window.location = "Default.aspx";
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
                    $('#lbl_PaymentUserid').text("Server error. Time out.!!");
                    $('#lbl_PaymentUserid').css('color', 'red');
                }
            });
        }


        function GetUserId() {

            $('#lblmsg').html('');
            var Userid = $('#<%=txt_Userid.ClientID%>').val();
            if (Userid == '') {
                $('#<%=txtName.ClientID%>').val('');
                $('#<%=txtaddress.ClientID%>').val('');
                $('#<%=ddl_state.ClientID%>').val('');
                $('#<%=txtCity.ClientID%>').val('');
                $('#<%=txtPincode.ClientID%>').val('');
                $('#<%=txt_Mobile.ClientID%>').val('');
                return;
            }
            $.ajax({
                type: "POST",
                url: URL + '/GetUser',
                data: '{Userid: "' + Userid + '", Self_Validate: "1", BillType: "1"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#hnd_jamount').val(data.d.jamount);
                        if (data.d.IsCustomer == "True") {
                            $('#lbl_UserDetails').text("(Customer)");
                        }
                        else {
                            let Associate ="<%=method.Associate%>";
                            $('#lbl_UserDetails').text(Associate + " Total Purchase: " + data.d.jamount);
                        }

                        $('#<%=txtName.ClientID%>').val(data.d.UserName);
                        $('#<%=txtaddress.ClientID%>').val(data.d.Address);
                        $('#<%=ddl_state.ClientID%>').val(data.d.State);
                        $('#<%=txtCity.ClientID%>').val(data.d.City);
                        $('#<%=txtPincode.ClientID%>').val(data.d.Pincode);
                        $('#<%=txt_Mobile.ClientID%>').val(data.d.Mobile);
                        $('#lbl_PaymentUserid').text(data.d.UserName);
                        $('#lbl_PaymentUserid').css('color', 'blue');

                        GetDistrict(data.d.distt);
                    }
                    else {
                        $('#lbl_PaymentUserid').text(Userid + ' Invalid User Id.!!');
                        $('#lbl_PaymentUserid').css('color', 'red');

                        $('#<%=txtName.ClientID%>').val('');
                        $('#<%=txtaddress.ClientID%>').val('');
                        $('#<%=ddl_state.ClientID%>').val('');
                        $('#<%=txtCity.ClientID%>').val('');
                        $('#<%=txtPincode.ClientID%>').val('');
                        $('#<%=txt_Mobile.ClientID%>').val('');
                    }
                },
                error: function (response) {
                    $('#lbl_PaymentUserid').text("Server error. Time out.!!");
                    $('#lbl_PaymentUserid').css('color', 'red');
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
                        $('#<%=ddl_district.ClientID %> option:selected').text(District);
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

    <style>
        .form-control {
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .quant {
            float: left;
            border: 1px solid #ebebea;
            padding: 7px;
            font-size: 11px;
        }

        button.btn-custom.secondary {
            height: 48px;
            background: #fe6a00;
            border: none;
            line-height: 0;
            width: 100%;
            margin-bottom: 5px;
        }

        input[type="text"] {
            height: 40px;
            padding: 10px;
        }

        .billing-cart {
            text-align: left;
            /*background: #fff4fc;*/
            margin: 15px 0;
            padding: 10px;
            font-weight: 500;
            font-size: 22px;
        }

        table th {
            /* background: #fff4fc;*/
            padding: .5rem .5rem;
            border: 1px solid #efecec;
        }

        .btn {
            min-width: 180px;
            font-family: var(--font-family-heading);
            font-size: var(--font-16);
            /* font-weight: 700; */
            line-height: 20px;
            text-transform: capitalize;
            text-align: center;
            overflow: hidden;
            display: inline-block;
            padding: 7px 7px;
            border: 0px solid transparent;
            border-radius: 5px;
            color: #fff;
            background-color: #000;
        }

            .btn:hover {
                background-color: #000;
                color: #fff;
            }

            .btn:before {
                background-color: #002e9e00 !important;
                color: var(--white-color) !important;
            }
    </style>


</asp:Content>
