<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Purchase-order.aspx.cs" Inherits="secretadmin_Purchase_order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto" runat="server" id="vendhead">New Purchase Order </h4>
    </div>


    <div class="form-group row">
        <span class="label-text col-md-2 col-form-label">Vendor Name</span>
        <div class="col-md-3">
            <asp:DropDownList ID="ddl_Vendor" runat="server" CssClass="form-control" onchange="GetVender()">
            </asp:DropDownList>
            <span id="lbl_Currency" style="color: white; background-color: green;"></span>
        </div>
        <div class="col-md-1"></div>
        <span class="label-text col-md-2 col-form-label py-0">Deliver To</span>
        <div class="col-md-3 form-inline">
            <label class="form-radio mr-3">
                <asp:RadioButtonList ID="rdo_DeliverTo" runat="server" Enabled="false" RepeatDirection="Horizontal">
                    <asp:ListItem Value="1" Selected="True">Organization</asp:ListItem>
                    <asp:ListItem Value="2">Customer</asp:ListItem>
                </asp:RadioButtonList>
            </label>
        </div>
    </div>

    <div class="form-group row">
        <span class="label-text col-md-2 col-form-label"></span>
        <div class="col-md-4">
            <div id="div_GSTIN"></div>
            <div id="div_Address"></div>
        </div>
        <span class="label-text col-md-2 col-form-label"></span>
        <div class="col-md-4">
            <div id="div_Organization"></div>
        </div>

    </div>

    <div class="form-group row">
        <span class="label-text col-md-2 col-form-label">Vendor Register No.</span>
        <div class="col-md-3">
            <asp:TextBox ID="txt_regno" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
        </div>
        <div class="col-md-1"></div>
        <span class="label-text col-md-2 col-form-label">Purchase Order#</span>
        <div class="col-md-3">
            <asp:TextBox ID="txt_PO" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
        </div>
        <div class="col-md-1"></div>
    </div>

    <div class="form-group row">
        <span class="label-text col-md-2 col-form-label">Place of Supply</span>
        <div class="col-md-3">
            <asp:DropDownList ID="ddl_DestinationOfSupply" runat="server" CssClass="form-control" Enabled="false">
            </asp:DropDownList>
        </div>
        <div class="col-md-1"></div>
        <span class="label-text col-md-2 col-form-label">Reference#</span>
        <div class="col-md-3">
            <asp:TextBox ID="txt_Reference" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-1"></div>
    </div>


    <div class="form-group row">
        <span class="label-text col-md-2 col-form-label">Date</span>
        <div class="col-md-3">
            <asp:TextBox ID="txtbilldate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-1"></div>
        <div class="col-md-6"></div>
    </div>
    <div class="form-group row">
        <span class="label-text col-md-2 col-form-label">Expected Delivery Date </span>
        <div class="col-md-3">
            <asp:TextBox ID="txt_DeliveryDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-1"></div>
        <span class="label-text col-md-2 col-form-label">Payment Terms </span>
        <div class="col-md-3">
            <asp:DropDownList ID="ddl_PaymentTerm" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-md-1"></div>
    </div>

    <div class="clearfix">
    </div>
    <div class="form-group row">
        <span class="label-text col-md-2 col-form-label">Select Product </span>
        <div class="col-md-3">
            <span id="sclor"></span>
            <asp:TextBox ID="txt_Barcode" runat="server" CssClass="form-control" onblur="javascript:GetProduct()" placeholder="Enter Product Code & Name..."></asp:TextBox>
        </div>
        <div class="col-md-1"></div>
        <span class="label-text col-md-2 col-form-label">Source Of Supply</span>
        <div class="col-md-3">
            <asp:DropDownList ID="ddl_SourceOfSupply" runat="server" Enabled="false" CssClass="form-control">
            </asp:DropDownList>
        </div>
    </div>
    <div class="form-group row" style="padding-bottom: 0px; height: 25px;">
        <div id="lblmsg" class="col-sm-12 text-center" style="color: Red;"></div>
    </div>

    <div class="clearfix">
    </div>

    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover" cellspacing="0" rules="all" border="1" style="width: 100%; border-collapse: collapse;">
        </table>
       
        </div>
     <div class="row">
        <div id="div_TC" class="col-md-6" style="display: none;">
            <div class="form-group row">
                <div class="col-md-4 label-text col-md-2 col-form-label">
                   Terms & Conditions 
                </div>
                <div class="col-md-8 text-right">
                    <textarea id="txt_TC" class="form-control" placeholder="Enter the terms and conditions of your business to be displayed in your transaction" style="height: 70px;"></textarea>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-md-4 label-text col-md-2 col-form-label">
                   Notes 
                </div>
                <div class="col-md-8 text-right">
                    <textarea id="txt_Note" class="form-control" placeholder="Will be displayed on purchase order"></textarea>
                </div>
            </div>
            <div class="form-group row" style="display: none;">
                <div class="col-md-6 label-text col-md-6 col-form-label">
                    <small>Attach File(s)</small> 
                </div>
                <div class="col-md-6 text-right">
                    <input type="file" onchange="CheckUploadFile();" />
                </div>
            </div>

            <div class="form-group row" style="display: none;">
                <div class="col-md-6">
                    <span class="label-text col-md-6 col-form-label"><small>You can upload a maximum of 5 files, 5MB each </small></span>
                </div>
                <div class="col-md-6 text-right">
                    <span class="label-text col-md-12 col-form-label">Template: 'Standard Template' </span>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-md-6">
                </div>
                <div class="col-md-6 text-right">
                    <a href="Purchase-order-List.aspx" class="btn btn-success btn-block ">Purchase Order list</a>
                </div>
            </div>




        </div>
        <div id="div_Calculation" class="col-md-6" style="display: none;">
            <div class="form-group row">
              
                <div class="label-text col-md-4 col-form-label">Sub Total </div>
                <div class="col-md-6 label-text col-form-label text-right">
                    <asp:Label ID="lbl_SubTotal" runat="server" CssClass="control-label">0</asp:Label>
                </div>
            </div>
            <hr />
            <div class="form-group row">
               
                <div class="label-text col-md-2 col-form-label">Discount </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txt_Discount" runat="server" class="form-control text-right" Width="150px" onchange="Calc_NetAmt()"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddl_DisType" runat="server" CssClass="form-control" Width="65px" onchange="Calc_NetAmt()">
                        <asp:ListItem>Rs</asp:ListItem>
                        <asp:ListItem>%</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 label-text col-form-label text-right">
                    <asp:Label ID="lbl_Discount" runat="server" CssClass="control-label">0</asp:Label>
                </div>
            </div>
            <hr />
            <div class="form-group row">
              
                    <div class="label-text col-md-4 col-form-label">Adjustment </div>
                
                <div class="col-md-4 text-right">
                    <asp:TextBox ID="txt_Adjustment" runat="server" CssClass="form-control text-right" onchange="Calc_NetAmt()" Enabled="false"></asp:TextBox>
                </div>
                <div class="abel-text col-md-2 col-form-label text-right">
                    <asp:Label ID="lbl_Adjustment" runat="server" CssClass="control-label">0</asp:Label>
                </div>
            </div>
            <hr />
            <div class="form-group row" style="background-color: #f9f8f8; border: 1px solid #ececec; padding: 10px 1%;">
               
                <span class="label-text col-md-4 col-form-label">Total </span>
                <div class="label-text col-md-6 col-form-label text-right">
                    <asp:Label ID="lbl_Total" runat="server" CssClass="control-label">0</asp:Label>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-md-8"></div>
                <div class="col-md-4 text-right">
                    <input type="button" id="btn_submit" value="Save Details" onclick="return Generate_Inv()" class="btn btn-success" />
                </div>

            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <div id="divProductcode" style="display: none;" runat="server"></div>
    <input type="hidden" id="hnd_SubTotalAmt" value="0" />

    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtbilldate.ClientID%>').datepick({ dateFormat: 'dd-mm-yyyy' });
            $JD('#<%=txt_DeliveryDate.ClientID%>').datepick({ dateFormat: 'dd-mm-yyyy' });
        });
    </script>


    <%--<link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>--%>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script> var $J = $.noConflict(true); </script>

    <script type="text/javascript">
        var URL = "Purchase-order.aspx";
        $J(function () {
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
            //$J('#<%=txt_Barcode.ClientID%>').autocomplete(Productcode);
            $J('#<%=txt_Barcode.ClientID%>').autocomplete({ source: Productcode });
            BindCartTable();
        });


        function GetProduct() {
            $('#lblmsg').html('');
            var Pid = $('#<%=txt_Barcode.ClientID%>').val();
            if (Pid != '') {
                $('#<%=txt_Barcode.ClientID%>').val(Pid);
                $.ajax({
                    type: "POST",
                    url: URL + '/GetBarcode',
                    data: '{Pid: "' + Pid + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "") {
                            $('#<%=txt_Barcode.ClientID%>').val('');
                            BindCartTable();
                        }
                        else {
                            $('#lblmsg').text(data.d);
                            $('#<%=txt_Reference.ClientID%>').focus();
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
            $('#lblmsg').html('');
            $.ajax({
                type: "POST",
                url: URL + '/GetCartData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblList').empty().append("<thead><tr>");
                    $('#tblList').append("<th style='width: 2%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SN</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Code</th>");
                    $('#tblList').append("<th style='width: 22%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Prod Name</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Rate</th>");
                    $('#tblList').append("<th style='width: 14%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Quantity</th>");
                    $('#tblList').append("<th style='width: 10%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Gross</th>");
                    $('#tblList').append("<th style='width: 5%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>GST(%)</th>");
                    $('#tblList').append("<th style='width: 7%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>GST</th>");
                    $('#tblList').append("<th style='width: 10%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Net Amount</th>");
                    $('#tblList').append("<th style='width: 3%; border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'><center><span style='color:Red; font-size:x-large;'>&times;</span></center></th>");
                    $('#tblList').append("</tr></thead>");
                    var tbl = '<tbody>';
                    var TotalQty = 0, TotalGST = 0, TotalGross = 0, TotalAmt = 0;
                    for (var i = 0; i < data.d.length; i++) {

                        TotalQty = TotalQty + parseInt(data.d[i].qty);
                        TotalGST = TotalGST + parseFloat(data.d[i].GSTAMT);
                        TotalGross = TotalGross + parseFloat(data.d[i].Gross);
                        TotalAmt = TotalAmt + parseFloat(data.d[i].totalamt);
                        var Pid = data.d[i].Pid;

                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        tbl += '<td>' + data.d[i].Pcode + '</td>';
                        tbl += '<td>' + data.d[i].pname + '</td>';
                        // tbl += '<td>' + data.d[i].Price + '</td>';
                        tbl += '<td> <input type="text" id="Rate_' + Pid + '" value="' + data.d[i].Price + '" onchange="UpdateRate(' + Pid + ')" class="form-control input-number text-center" maxlength="6" style="width:70px; height: 29px; float: left; padding:5px;"/> </td>';

                        tbl += '<td> <span class="fa fa-minus quant" onclick="MinusQty(' + Pid + ')" style="cursor: pointer;"></span> <input type="text" id="qty_' + Pid + '" value="' + data.d[i].qty + '" onchange="UpdateQty(' + Pid + ')" class="form-control input-number text-center" maxlength="6" style="width:70px; height: 29px; float: left; padding:5px;"/> <span class="fa fa-plus quant" onclick="AddQty(' + Pid + ')" style="cursor: pointer;"></span>  <input type="hidden" id="Maxqty_' + Pid + '" value="' + data.d[i].MaxQty + '"> </td>';
                        tbl += '<td>' + data.d[i].Gross + '</td>';
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
                        tbl += '<td>' + data.d[i].GSTAMT + '</td>';
                        tbl += '<td>' + data.d[i].totalamt + '</td>';
                        tbl += '<td><center><a href="#/"> <span style="color:Red; font-size:x-large;" onclick="DeleteProd(' + Pid + ');" title="Remove">&times;</span> </a> </center> </td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    tbl += "<thead><tr style='background-color:#f3f4f8;'><th></th> <th></th>  <th></th>  <th>Total :</th> <th>" + TotalQty + "</th> <th>" + TotalGross.toFixed(2) + "</th>  <th> 0</th> <th> " + TotalGST.toFixed(2) + "</th>  <th>" + TotalAmt.toFixed(2) + "</th> <th></th> </tr></thead>";
                    $('#tblList').append(tbl);
                    $('#<%=txt_Barcode.ClientID%>').focus();

                    if (data.d.length == 0) {
                        $('#div_Calculation').hide();
                        $('#div_TC').hide();
                        $('#tblList').empty();
                        $('#lbl_tbl').text('Cart is empty.....');
                        $('#<%=txt_Barcode.ClientID%>').focus();
                        return false;
                    }
                    if (data.d.length > 0) {
                        $('#div_Calculation').show();
                        $('#div_TC').show();
                        $('#<%=lbl_SubTotal.ClientID%>').text(TotalAmt.toFixed(2));
                        $('#hnd_SubTotalAmt').val(TotalAmt.toFixed(2));
                        Calc_NetAmt();


                        $('html, body').animate({
                            scrollTop: $('#sclor').offset().top
                        }, 1000);
                    }
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
                    return false;
                }
            });
        }


        function Calc_NetAmt() {
            var TotalAmt = 0, NetDiscount = 0;
            var SubTotalAmt = $('#hnd_SubTotalAmt').val();
            var Discount = $('#<%=txt_Discount.ClientID%>').val() == "" ? "0" : $('#<%=txt_Discount.ClientID%>').val();
            var DisType = $('#<%=ddl_DisType.ClientID%>').val();
            if (DisType == "%" && parseFloat(Discount) > 0) {
                if (parseFloat(Discount) > 100) {
                    alert("Discount value less than 100%.!!");
                    $('#<%=txt_Discount.ClientID%>').val(0);
                    return false;
                }
                NetDiscount = (parseFloat(SubTotalAmt) * parseFloat(Discount) / 100).toFixed(2);
            }
            else {
                if (parseFloat(Discount) > parseFloat(SubTotalAmt)) {
                    alert("Discount value less than Amount.!!");
                    $('#<%=txt_Discount.ClientID%>').val(0);
                    return false;
                }
                NetDiscount = Discount;
            }
            $('#<%=lbl_Discount.ClientID%>').text(NetDiscount);
            TotalAmt = parseFloat(SubTotalAmt) - parseFloat(NetDiscount);
            var Adjustment = Math.round(TotalAmt.toFixed(2)) - TotalAmt.toFixed(2);
            $('#<%=txt_Adjustment.ClientID%>').val(Adjustment.toFixed(2));
            $('#<%=lbl_Total.ClientID%>').text(Math.round(TotalAmt).toFixed(2));
        }


        function UpdateRate(Pid) {

            $('#lblmsg').html('');
            if (Pid <= 0) {
                $('#lblmsg').text("Server error. Time out.!!");
                $('#<%=txt_Barcode.ClientID%>').focus();
                return false;
            }

            var Rate = $('#Rate_' + Pid).val();

            if (parseFloat(Rate) < 0) {
                $('#Rate_' + Pid).val(0);
                $('#lblmsg').text("Stock in hand : " + Maxqty);
            }
            $.ajax({
                type: "POST",
                url: URL + '/UpdateRate',
                data: '{Pid: "' + Pid + '", Rate: "' + Rate + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
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
            $.ajax({
                type: "POST",
                url: URL + '/UpdateQty',
                data: '{Pid: "' + Pid + '", Qty: "' + Qty + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
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
                    $('#lblmsg').text("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
                }
            });
        }


        function GST(Pid) {
            $('#lblmsg').html('');
            var GST = $('#GST_' + Pid).val();
            GST = parseFloat((GST == '' || GST == null || isNaN(parseFloat(GST))) ? 0 : GST);
            $.ajax({
                type: "POST",
                url: URL + '/UpdateGST',
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



        function DeleteProd(Pid) {
            $('#lblmsg').html('');
            $.ajax({
                type: "POST",
                url: URL + '/DeleteProd',
                data: '{Pid: "' + Pid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
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
                    $('#lblmsg').text("Server error. Time out.!!");
                    $('#<%=txt_Barcode.ClientID%>').focus();
                }
            });
        }


        function GetVender() {
            $.ajax({
                type: "POST",
                url: URL + '/GetVenderDetail',
                data: '{Vid: "' + $('#<%=ddl_Vendor.ClientID%>').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#<%=ddl_SourceOfSupply.ClientID%>').val(data.d.Source_Supply);
                        $('#<%=ddl_DestinationOfSupply.ClientID%>').val(data.d.Org_State);

                        $('#lbl_Currency').text(data.d.Currency);
                        $('#div_GSTIN').html("GST TREATMENT: <br/>" + data.d.GSTNAME + " <br/>GSTIN : " + data.d.GSTIN);
                        $('#div_Address').html("BILLING ADDRESS: <br/>" + data.d.ComName + " <br/>" + data.d.DisplayName + "<br/>" + data.d.B_Address + " <br/>" + data.d.CountryName + " <br/>" + data.d.B_State + " <br/>" + data.d.B_City + " <br/>" + data.d.B_ZipCode);

                        $('#div_Organization').html(data.d.Org_Add);

                        $('#<%=txt_PO.ClientID%>').val(data.d.PurchaseOrder);
                        $('#<%=txt_regno.ClientID%>').val(data.d.V_regno);
                    }
                    else {
                        $('#<%=ddl_SourceOfSupply.ClientID%>').val(0);
                        $('#lbl_Currency').text('');
                        $('#div_GSTIN').text('');
                        $('#div_Address').text('');
                        $('#div_Organization').text('');
                    }
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }


        function Generate_Inv() {
            $('#lblmsg').html('');
            var MSG = "";
            var VendorId = $('#<%=ddl_Vendor.ClientID%>').val(),
            DeliverTo = $('#<%=rdo_DeliverTo.ClientID%>').val(),
            SourceOfSupply = $('#<%=ddl_SourceOfSupply.ClientID%>').val(),
            DestinationOfSupply = $('#<%=ddl_DestinationOfSupply.ClientID%>').val(),
            Reference = $('#<%=txt_Reference.ClientID%>').val(),
            BillDate = $('#<%=txtbilldate.ClientID%>').val(),
            DeliveryDate = $('#<%=txt_DeliveryDate.ClientID%>').val(),
            PaymentTerm = $('#<%=ddl_PaymentTerm.ClientID%>').val(),

            Discount = $('#<%=txt_Discount.ClientID%>').val(),
            AdjustmentAmt = $('#<%=txt_Adjustment.ClientID%>').val(),
            TC = $('#txt_TC').val(),
            Note = $('#txt_Note').val(),
            DiscountVal = $('#<%=txt_Discount.ClientID%>').val(),
            DisType = $('#<%=ddl_DisType.ClientID%>').val(),
            Adjustment = $('#<%=txt_Adjustment.ClientID%>').val();

            DiscountVal = parseFloat((DiscountVal == '' || DiscountVal == null || isNaN(parseFloat(DiscountVal))) ? 0 : DiscountVal);
            AdjustmentAmt = parseFloat((AdjustmentAmt == '' || AdjustmentAmt == null || isNaN(parseFloat(AdjustmentAmt))) ? 0 : AdjustmentAmt);

            if (VendorId == "0") {
                MSG += "\n Please Select Vender.!";
                $('#<%=ddl_Vendor.ClientID%>').focus();
            }
            if (DestinationOfSupply == "0") {
                MSG += "\n Please Select Destination Of Supply.!";
                $('#<%=ddl_DestinationOfSupply.ClientID%>').focus();
            }
            if (BillDate == "") {
                MSG += "\n Please Select Date.!";
                $('#<%=txtbilldate.ClientID%>').focus();
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
                url: URL + '/GenerateInv',
                data: '{VendorId: "' + VendorId + '", DeliverTo: "' + DeliverTo + '", SourceOfSupply: "' + SourceOfSupply + '", DestinationOfSupply: "' + DestinationOfSupply + '", Reference: "' + Reference + '", BillDate: "' + BillDate
                + '", DeliveryDate: "' + DeliveryDate + '", PaymentTerm: "' + PaymentTerm + '", TC: "' + TC
                + '", Note: "' + Note + '", DiscountVal: "' + DiscountVal + '", DisType: "' + DisType + '", Adjustment: "' + Adjustment + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#processing').hide();
                    if (data.d.Error == "") {
                        window.location = "GRN-Fran-Bill.aspx?id=" + data.d.InvoiceNo;
                    }
                    else if (data.d.Error == "-1") {
                        window.location = "~/Login.aspx";
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
                }
            });
        }

    </script>

    <style type="text/css">
        .quant {
    float: left;
    border: 1px solid #ababab;
    padding: 7px 3px;
    font-size: 11px;
    margin-top: 6px;
    border-radius: 4px;
    background: #fff;
}

        tr, th {
            font-size: 13px;
        }

        td {
            padding: 2px !important;
        }
    </style>
</asp:Content>
