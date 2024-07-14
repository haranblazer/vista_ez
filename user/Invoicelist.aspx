<%@ Page Title="Invoice List" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="Invoicelist.aspx.cs" Inherits="user_FristPurchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">My Shopping / Invoice List</h4>

    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_DispatchStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All Invoice</asp:ListItem>
                <asp:ListItem Value="1">Dispatched</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="InvoiceNo/ UserID" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="0">Cancelled</asp:ListItem>
                <asp:ListItem Value="1">Sumbit</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button> 
        </div>
        <div class="col-md-1 pull-right d-none" style="text-align: right;">
           
        </div>
    </div>


    <div class="clearfix">
    </div>
    <hr />
   
    <div class="table-responsive">
       <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
            <tfoot align="center">
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                     <th></th>
                </tr>
            </tfoot>
        </table>
         
    </div>
    
    <div id="Model_RateProduct" class="modal fade show" tabindex="-1" style="padding-right: 17px; background: #000000ab;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-thumbs-up" aria-hidden="true"></i>&nbsp;Rate The Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="Model_Close_RateProduct()"></button>

                </div>
                <div class="modal-body" style="height: 500px!important; overflow-y: scroll;">
                    <div class="table-responsive">
                        <table id="tblRateList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <input type="hidden" id="hnd_srno" value="0" />
 <input type="hidden" id="hnd_PId" value="0" />
 <input type="hidden" id="hnd_Rate" value="0" />


    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />

    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>

    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../Grid_js_css/buttons.dataTables.css" rel="stylesheet" />

    <script src="../Grid_js_css/jquery-3.5.1.js" type="text/javascript"></script>
    <script src="../Grid_js_css/jquery.dataTables.js" type="text/javascript"></script>
    <script src="../Grid_js_css/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/jszip.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/pdfmake.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/vfs_fonts.js" type="text/javascript"></script>
    <script src="../Grid_js_css/buttons.html5.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/buttons.print.min.js" type="text/javascript"></script>
    <script> var $JDT = $.noConflict(true); </script>

    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("Invoicelist.aspx")%>';
        $JDT(function () {
            // $.noConflict(true);
            BindTable();
        });


        function BindTable() {

            var SponsorId = $('#<%=txtSearch.ClientID%>').val(),
                min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                Del_Status = $('#<%=ddl_DispatchStatus.ClientID%>').val(),
                status = $('#<%=ddlStatus.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: pageUrl + '/BindInvoice',
                data: '{SponsorId: "' + SponsorId + '", min: "' + min + '", max: "' + max + '", status: "' + status
                    + '", Del_Status: "' + Del_Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        let InvUrl = '';
                        let RateProduct = '';
                        if (data.d[i].Billtype == '4' || data.d[i].Billtype == '6')  {
                            InvUrl = 'LR_Invoice';
                        }
                        else {
                            InvUrl = 'Invoice';
                        }
                        var Invoice = '<a href="../Common/' + InvUrl + '.aspx?id=' + data.d[i].srno_Encript + '" style="color: #727272; font-weight: bold;">' + data.d[i].InvoiceNo + '</a>';

                        RateProduct = '<a href="javascript:void(0)" class="btn btn-link" onclick="RateProduct(' + data.d[i].srno + ')">Rate The Product</a>';

                        //var Invoice = '<a href="../Common/Invoice.aspx?id=' + data.d[i].srno_Encript + '" style="color: #727272; font-weight: bold;">' + data.d[i].InvoiceNo + '</a>';

                        json.push([i + 1,
                        data.d[i].Date,
                            Invoice,
                            RateProduct,
                        data.d[i].NoOFProduct,
                        data.d[i].Actual_Qty,
                        data.d[i].grossAmt,
                        data.d[i].SGST,
                        data.d[i].CGST,
                        data.d[i].IGST,
                        data.d[i].Cess,
                        data.d[i].Amt,

                        data.d[i].Discount,
                        data.d[i].CourierCharges,
                        data.d[i].NetAmt,
                        //data.d[i].BV,
                            data.d[i].PV,
                            data.d[i].WalletAmount,
                            data.d[i].secondaryAmount,

                        data.d[i].InvoiceType,
                        data.d[i].Subdistype,

                        data.d[i].status == "0" ? "<span style='color:red'>Cancelled </span>" : "Submit",
                        data.d[i].Del_Status == "0" ? "<span style='color:red'>Pending</span>" : "Delivered",

                        data.d[i].PayMode,
                        data.d[i].DispatchDate,
                        data.d[i].Transport,
                        data.d[i].Tracking,
                        data.d[i].EWayBill,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'print'],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            { title: "Date" },
                            { title: "Invoice No." },
                            { title: "Rate The Product" },
                            { title: "No of Prod" },
                            { title: "Billed Qty." },
                            { title: "DP Value" },
                            { title: "SGST" },
                            { title: "CGST" },
                            { title: "IGST" },
                            { title: "Cess" },
                            { title: "DP with Tax" },

                            { title: "Discount" },
                            { title: "Courier Charges" },
                            { title: "<%=method.Invoice_Amount%>" },
                            //{ title: "TPV" },
                            { title: "" + '<%=method.PV%>' },
                            { title: "Wallet <br> Amount" },
                            { title: "Secondary <br> Amount" },
                            { title: "Invoice Type" },
                            { title: "Billing Type" },
                            { title: "Invoice Status" },
                            { title: "Dispatch Status" },

                            { title: "Payment Mode" },
                            { title: "Dispatch Date" },
                            { title: "Transport" },
                            { title: "Tracking" },
                            { title: "EWay Bill" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) {
                                return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0;
                            };

                            // Total over all pages
                            var NoofProducts = api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(4).footer()).html(NoofProducts);

                            var BilledQty = api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(5).footer()).html(BilledQty);

                            var DPValue = api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(7).footer()).html(DPValue.toFixed(2));

                            var SGST = api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(8).footer()).html(SGST.toFixed(2));

                            var CGST = api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(9).footer()).html(CGST.toFixed(2));

                            var IGST = api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(10).footer()).html(IGST.toFixed(2));

                            var Cess = api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(11).footer()).html(Cess.toFixed(2));

                            var DPwithTax = api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(12).footer()).html(DPwithTax.toFixed(2));

                            var Discount = api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(13).footer()).html(Discount.toFixed(2));

                            var CourierCharges = api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(14).footer()).html(CourierCharges.toFixed(2));

                            var InvoiceValue = api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(15).footer()).html(InvoiceValue.toFixed(2));

                            //var TPV = api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            //$(api.column(14).footer()).html(TPV.toFixed(2));

                            var RPV = api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(16).footer()).html(RPV.toFixed(2));

                            $(api.column(17).footer()).html(api.column(17).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(18).footer()).html(api.column(18).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                        }
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function Model_Close_RateProduct() {
            $('#Model_RateProduct').hide();
        }


        function RateProduct(srno) {
           
            $('#hnd_srno').val(srno);
            $('#Model_RateProduct').show();
            $('#LoaderImg').show();
            $('#tblRateList').html('');
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindRateProduct',
                data: '{srno: "' + srno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                  
                    for (var i = 0; i < data.d.length; i++) {
                        let RateProduct = '';
                        let ProductName = "'" + data.d[i].ProductName + "'";
                        let ImgName = "'" + data.d[i].ImageName + "'";
                        let TRate = "'" + data.d[i].TRate + "'";
                        let TMember = "'" + data.d[i].TMember + "'";

                        RateProduct = '';
                        if (parseInt(data.d[i].FId) == 0) {
                            RateProduct = '<a href="javascript:void(0)" class="btn btn-link" onclick="ProductWiseRate(' + srno + ',' + data.d[i].productid + ', ' + ProductName + ',' + ImgName + ',' + TRate + ',' + TMember + ')">Rate The Product</a>';
                        }
                        else {
                            if (data.d[i].Rate == "0.5") {
                                RateProduct += '<i class="fa fa-star-half-o" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                            }
                            else if (data.d[i].Rate == "1.0") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                            }
                            else if (data.d[i].Rate == "1.5") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-half-o" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                            }
                            else if (data.d[i].Rate == "2.0") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                            }
                            else if (data.d[i].Rate == "2.5") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-half-o" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                            }
                            else if (data.d[i].Rate == "3.0") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                            }
                            else if (data.d[i].Rate == "3.5") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-half-o" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                            }
                            else if (data.d[i].Rate == "4.0") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-o" style="font-size:24px; color:#C0C0C0"></i>';
                            }
                            else if (data.d[i].Rate == "4.5") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star-half-o" style="font-size:24px;color:#46ad05"></i>';
                            }
                            else if (data.d[i].Rate == "5.0") {
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                                RateProduct += '<i class="fa fa-star" style="font-size:24px;color:#46ad05"></i>';
                            }
                        }
                        json.push([i + 1,
                        '<a href="../Productimage/' + data.d[i].ImageName + '" data-fancybox="gallery"> <img src="../Productimage/' + data.d[i].ImageName + '" height="60px" width="50px"/> </a>',
                        data.d[i].ProductName,
                        //data.d[i].Rate,
                        '<div class="nowrap_content">' + data.d[i].Comments + '</div>',
                            RateProduct,
                        ]);

                    }

                    $JDT('#tblRateList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "#" },
                            { title: "Image" },
                            { title: "Product" },
                            // { title: "Rating" },
                            { title: "Customer Review" },
                            { title: "Rate The Product" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }



        function Model_Close_AddProductRate() {
            $('#Model_AddProductRate').hide();
        }


        function ProductWiseRate(srno, PId, ProductName, ImgName, TRate, TMember) {
          
            $('#div_rating_msg').html('');
            $('#Model_AddProductRate').show();
            $('#txt_feedback').val('');
            $('#hnd_PId').val(PId);
            $('#lbl_Rate_Product').html(ProductName);
            $('#div_Rate_Img').html('<a href="../Productimage/' + ImgName + '" data-fancybox="gallery"> <img src="../Productimage/' + ImgName + '" style="height: 80px; background:#eeeeee; margin-right:5px;"> </a>');

            $('#lbl_Rate_Point').html(TRate + ' <i class="fa fa-star"></i>');
            $('#lbl_Rate_Members').html('(' + TMember + ')');
        }


        function AddRating() {
        
            $('#div_rating_msg').html('');
            let srno = $('#hnd_srno').val();
            let PId = $('#hnd_PId').val();
            let Rate = $('#hnd_Rate').val();
            let feedback = $('#txt_feedback').val();
            if (parseFloat(Rate) < 1) {
                $('#div_rating_msg').html('<div class="alert alert-danger" role="alert">Please select a minimum rating of 1 for this product.!! </div>');
                return;
            }

            var Img1 = "";
            var fileUpload = $("#Img1").get(0);
            var files = fileUpload.files;
            var data = new FormData();
            var random = Math.floor(10000 + Math.random() * 90000);
            random = "P_Feedback_" + random;
            for (var i = 0; i < files.length; i++) {
                var ext = files[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data.append(random + '.' + ext, files[i]);
                Img1 = random + '.' + ext;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/AddRating',
                data: '{srno: "' + srno + '", PId: "' + PId + '", Rate: "' + Rate + '", feedback: "' + feedback + '", Img1: "' + Img1 + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "1") {
                        $('#div_rating_msg').html('<div class="alert alert-success" role="alert">Thank you for your review. </div>');

                        if (Img1 != '') {
                            for (var i = 0; i < files.length; i++) {
                                var ext = files[i].name.split(".");
                                ext = ext[ext.length - 1].toLowerCase();

                                data.append(random + '.' + ext, files[i]);
                                Img1 = random + '.' + ext;
                            }

                            var _URL = window.URL || window.webkitURL;
                            $.ajax({
                                url: "../UploadHandler.ashx",
                                type: "POST",
                                data: data,
                                contentType: false,
                                processData: false,
                                success: function (result) {
                                   // BindData_SendtoGoogle(srno, Rate);
                                },
                                error: function (err) { }
                            });
                        }
                        else {
                            BindData_SendtoGoogle(srno, Rate);
                        }
                    } else {
                        alert(response.d);
                    }
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }


        function BindData_SendtoGoogle(srno, Rate) {
            $('#div_rating_msg').html('');
            document.getElementById('dvPreview').src = '';

            RateProduct(srno);
            $('#Model_AddProductRate').hide();
            if (parseFloat(Rate) >= 4) {
                $('#Model_GoogleReview').show();
                setTimeout(function () {
                    $('#Model_GoogleReview').hide();
                    window.open('<%=method.GoogleReviewUrl%>', '_blank');
          }, 2000);
            }
        }

        function Rate(RateVal) {
            $('#hnd_Rate').val(RateVal);
        }


        function UploadImg1(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('dvPreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        };


        function dateFormate(datevalue) {
            var date_arr = "";
            var newformat = "";
            date_arr = datevalue.split('/');
            if (date_arr.length > 0) {
                newformat = date_arr[1] + '/' + date_arr[0] + '/' + date_arr[2];
            }
            if (datevalue == "") {
                newformat = '';
            }
            return newformat;
        }
    </script>
      <div id="Model_AddProductRate" data-bs-backdrop="static" class="modal fade show" tabindex="-1" style="background: #000000ab;" aria-modal="true" role="dialog">
      <div class="modal-dialog modal-xl modal-dialog-centered">
          <div class="modal-content">
              <div class="modal-header bg-primary">
                  <h5 class="modal-title text-white"><i class="fa fa-thumbs-up" aria-hidden="true"></i>&nbsp;Review This Product</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="Model_Close_AddProductRate()"></button>
              </div>
              <div class="modal-body" style="height: 500px!important; overflow-y: scroll;">

                  <div class="row">
                      <div class="col-md-4">
                          <div class="review_left">
                              <h2>
                                  <spna>What makes a good review</spna></h2>
                              <div class="review_left_text">
                                  <h3>
                                      <spna>
                                          Have you used this product?
                                      </spna>
                                  </h3>
                                  <p>
                                      Your review should be about your experience with the product.

                                  </p>
                              </div>
                              <div class=" review_left_text">
                                  <h3>
                                      <spna>Why review a product?</spna></h3>
                                  <p>
                                      Your valuable feedback will help fellow shoppers decide!
                                  </p>
                              </div>
                              <div class=" review_left_text">
                                  <h3>
                                      <spna>How to review a product?</spna></h3>
                                  <p>
                                      Your review should include facts. An honest opinion is always appreciated. If you have an issue with the product or service please contact us from the help centre.
                                  </p>
                              </div>
                          </div>
                      </div>
                      <div class="col-md-8">
                          <div class="review_right_header">

                              <div class="review_right_product">
                                  <a href="javascript:void(0)" class="d-flex">
                                      <div class="review_image" id="div_Rate_Img"></div>
                                      <div class="review_name">
                                          <div class="review_right_name"><span id="lbl_Rate_Product"></span></div>
                                          <div class="rating d-flex">
                                              <div class="review_right_star" id="lbl_Rate_Point"></div>
                                              <span id="lbl_Rate_Members"></span>
                                          </div>
                                      </div>
                                  </a>
                              </div>
                          </div>
                          <div class="clearfix"></div>
                          <div class="review_right">
                              <h5>Review this product</h5>
                              <div id="half-stars-example">
                                  <div class="rating-group">

                                      <input checked onclick="Rate(0.0)" class="rating__input rating__input--none" name="rating2" id="rating2-0" value="0" type="radio" />
                                      <label aria-label="0 stars" class="rating__label" for="rating2-0">&nbsp;</label>


                                      <label aria-label="0.5 stars" class="rating__label rating__label--half" for="rating2-05" data-toggle="tooltip" data-placement="top" title="Very Bad"><i class="rating__icon rating__icon--star fa fa-star-half"></i></label>
                                      <input onclick="Rate(0.5)" class="rating__input" name="rating2" id="rating2-05" value="0.5" type="radio" />

                                      <label aria-label="1 star" class="rating__label" for="rating2-10" data-toggle="tooltip" data-placement="top" title="Very Bad"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                                      <input onclick="Rate(1.0)" class="rating__input" name="rating2" id="rating2-10" value="1" type="radio" />

                                      <label aria-label="1.5 stars" class="rating__label rating__label--half" for="rating2-15" data-toggle="tooltip" data-placement="top" title="Bad"><i class="rating__icon rating__icon--star fa fa-star-half"></i></label>
                                      <input onclick="Rate(1.5)" class="rating__input" name="rating2" id="rating2-15" value="1.5" type="radio" />

                                      <label aria-label="2 stars" class="rating__label" for="rating2-20" data-toggle="tooltip" data-placement="top" title="Bad"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                                      <input onclick="Rate(2.0)" class="rating__input" name="rating2" id="rating2-20" value="2" type="radio" />

                                      <label aria-label="2.5 stars" class="rating__label rating__label--half" for="rating2-25" data-toggle="tooltip" data-placement="top" title="Good"><i class="rating__icon rating__icon--star fa fa-star-half"></i></label>
                                      <input onclick="Rate(2.5)" class="rating__input" name="rating2" id="rating2-25" value="2.5" type="radio" />

                                      <label aria-label="3 stars" class="rating__label" for="rating2-30" data-toggle="tooltip" data-placement="top" title="Good"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                                      <input onclick="Rate(3.0)" class="rating__input" name="rating2" id="rating2-30" value="3" type="radio" />

                                      <label aria-label="3.5 stars" class="rating__label rating__label--half" for="rating2-35" data-toggle="tooltip" data-placement="top" title="Very Good"><i class="rating__icon rating__icon--star fa fa-star-half"></i></label>
                                      <input onclick="Rate(3.5)" class="rating__input" name="rating2" id="rating2-35" value="3.5" type="radio" />

                                      <label aria-label="4 stars" class="rating__label" for="rating2-40" data-toggle="tooltip" data-placement="top" title="Very Good"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                                      <input onclick="Rate(4.0)" class="rating__input" name="rating2" id="rating2-40" value="4" type="radio" />

                                      <label aria-label="4.5 stars" class="rating__label rating__label--half" for="rating2-45" data-toggle="tooltip" data-placement="top" title="Excellent"><i class="rating__icon rating__icon--star fa fa-star-half"></i></label>
                                      <input onclick="Rate(4.5)" class="rating__input" name="rating2" id="rating2-45" value="4.5" type="radio" />

                                      <label aria-label="5 stars" class="rating__label" for="rating2-50" data-toggle="tooltip" data-placement="top" title="Excellent"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                                      <input onclick="Rate(5.0)" class="rating__input" name="rating2" id="rating2-50" value="5" type="radio" />
                                  </div>

                              </div>

                              <hr />
                              <h5>Review this product</h5>

                              <textarea id="txt_feedback" placeholder="Description....." class="form-control" rows="0" cols="0" style="height: 150px;"></textarea>
                              <br />

                              <input type="file" id="Img1" onchange="javascript:UploadImg1(this);" accept=".png,.jpg,.jpeg,.gif" value="Upload Image"/>
                             <%-- <label for="Img1" title="Upload Image"><i class="fa fa-upload"></i></label>--%>
                              <img id="dvPreview" src="#" alt="your image" style="height:100px; width:100px;"/>
                              <br />


                              <input type="button" onclick="AddRating()" class="btn btn-primary" value="Submit" />
                              <div id="div_rating_msg"></div>
                          </div>
                      </div>
                  </div>

              </div>
          </div>
      </div>
  </div>
     <style>
     .review_right_header h5 {
         padding-top: 20px;
     }

     .review_right_header {
         height: 80px;
         margin: 8px;
         color: #212121;
         background: #fff;
         box-shadow: 0 0 1.5px 1px rgba(0,0,0,.16);
         padding: 0px 10px;
     }

     .rating {
         /*float: right;*/
     }

     .review_right_product {
         /*  float: right;*/
         /*  min-width: 300px;*/

         font-weight: 400;
     }

     .review_right_star {
         background: #0242b8;
         padding: 7px;
         height: 27px;
         border-radius: 6px;
         line-height: 1px;
         color: #fff;
     }

     .rating span {
         color: #0242b8;
         padding: 5px;
     }

     .review_name {
         padding: 2px;
         margin: 0px;
         float: left;
     }

     .review_right_name span {
         color: #000;
     }

     .nowrap_content {
         white-space: nowrap;
         overflow: hidden;
         text-overflow: ellipsis;
         width: 200px;
     }

     .review_right_name {
         font-size: 16px;
         /*white-space: nowrap;
         overflow: hidden;
         text-overflow: ellipsis;*/
         text-align: right;
     }

     hr {
         background: #e0e0e0;
         height: 1px;
         border: 0;
         margin: 15px 0;
     }

     .review_right {
         margin: 8px;
         color: #212121;
         background: #fff;
         box-shadow: 0 0 1.5px 1px rgba(0,0,0,.16);
         /* min-height: 440px;*/
         padding: 10px;
     }

         .review_right h5 {
             margin: 0 0 10px;
         }

     .review_left {
         margin: 8px;
         color: #212121;
         background: #fff;
         box-shadow: 0 0 1.5px 1px rgba(0,0,0,.16);
         /*min-height: 528px;*/
         float: left;
     }

         .review_left h2 {
             padding: 12px;
             /* height: 64px; */
             font-weight: 800;
             font-size: 18px;
             border: solid #e0e0e0;
             border-width: 0 0 1px;
         }

     .review_left_text {
         border: solid #e0e0e0;
         border-width: 0 0 1px;
         /* font-weight: 400;*/
         margin-bottom: 10px;
     }

         .review_left_text p {
             font-size: 14px;
             padding: 0px 12px;
         }

         .review_left_text h3 {
             margin-bottom: 0px;
             font-size: 18px;
             padding: 12px;
             line-height: 1;
             font-weight: 500;
         }

     #half-stars-example {
     }

         #half-stars-example .rating-group {
             display: inline-flex;
         }

         #half-stars-example .rating__icon {
             pointer-events: none;
         }

         #half-stars-example .rating__input {
             position: absolute !important;
             left: -9999px !important;
         }

         #half-stars-example .rating__label {
             cursor: pointer;
             /* if you change the left/right padding, update the margin-right property of .rating__label--half as well. */
             padding: 0 0.1em;
             font-size: 2rem;
         }

         #half-stars-example .rating__label--half {
             padding-right: 0;
             margin-right: -0.6em;
             z-index: 2;
         }

         #half-stars-example .rating__icon--star {
             color: #46ad05;
         }

             #half-stars-example .rating__icon--star:hover {
                 color: #46ad05;
             }

         #half-stars-example .rating__icon--none {
             color: #eee;
         }

         #half-stars-example .rating__input--none:checked + .rating__label .rating__icon--none {
             color: red;
         }

         #half-stars-example .rating__input:checked ~ .rating__label .rating__icon--star {
             color: #ddd;
         }

         #half-stars-example .rating-group:hover .rating__label .rating__icon--star,
         #half-stars-example .rating-group:hover .rating__label--half .rating__icon--star {
             color: #46ad05;
         }

         #half-stars-example .rating__input:hover ~ .rating__label .rating__icon--star,
         #half-stars-example .rating__input:hover ~ .rating__label--half .rating__icon--star {
             color: #ddd;
         }

         #half-stars-example .rating-group:hover .rating__input--none:not(:hover) + .rating__label .rating__icon--none {
             color: #eee;
         }

         #half-stars-example .rating__input--none:hover + .rating__label .rating__icon--none {
             color: red;
         }

     @media only screen and (min-width: 320px) and (max-width: 479px) {
         .review_name {
             width: 162px;
         }

         .review_right_header h5 {
             font-size: 14px;
             padding-top: 5px;
         }

         .review_right_header {
             height: 132px;
         }

         .modal-body {
             padding: 0rem;
         }
     }

     .modal-confirm .icon-box {
         color: #fff;
         position: absolute;
         margin: 0 auto;
         left: 0;
         right: 0;
         top: -57px;
         width: 95px;
         height: 95px;
         border-radius: 50%;
         z-index: 9;
         background: #82ce34;
         padding: 15px;
         text-align: center;
         box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
     }

         .modal-confirm .icon-box i {
             font-size: 58px;
             position: relative;
             top: 3px;
         }
 </style>
</asp:Content>
