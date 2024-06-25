<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="welcome.aspx.cs" Inherits="user_welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600 me-auto">Dashboard</h4>
    </div>


    <div class="card p-3">

    <div class="row">
        <div class="col-md-3">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CssClass="btn btn-success" />
        </div>
        <div class="col-md-3">
            <a href="javascript:void(0)" onclick="GetTopSellingTable();"
                class="btn btn-success pull-right" style="width: 100%">Top 20 Selling Products</a>
        </div>
     
    </div>
    </div>
        <div class="row">
                <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card">
                <div class="card-body p-3">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-0 text-left">Purchase</p>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 ">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-0 text-left">Current</p>
                            <h3 class="text-left">
                                <a href="POList.aspx" id="lbl_Purchases_Curr" runat="server" class="text-primary">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left">Previous</p>
                            <h3 class="text-left">
                                <a href="POList.aspx" id="lbl_Purchases_Prev" runat="server" class="text-primary">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card">
                <div class="card-body p-2">
                    <div class="media">
                        <div class="media-body text-black" style="padding: 5px; border: 1px solid #afafaf; border-radius: 10px; background: #e8eaf1;">
                        <p class="mb-0 text-left text-primary" id="lbl_TotalSales" runat="server">0</p>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <%--<p class="mb-0 text-left">Franchise</p>
                            <h3 class="text-left">
                                <a href="StockTranList.aspx" id="lbl_FranchiseSales" runat="server" class="text-primary">0</a>
                            </h3>--%>
                            <p class="mb-1 text-left"><%=method.Associate %></p>
                            <h3 class="text-orange text-left">
                                <a href="AssociateInvoiceList.aspx" id="A1" runat="server" class="text-primary">0</a>
                            </h3>

                        </div>
                    </div>
                </div>
               <%-- <div class="card-body p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left">Associate</p>
                            <h3 class="text-orange text-left">
                                <a href="AssociateInvoiceList.aspx" id="lbl_AssociateSales" runat="server" class="text-primary">0</a>
                            </h3>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card">
                <div class="card-body p-2">
                    <div class="media">
                        <div class="media-body text-primary" style="padding: 5px; border: 1px solid #afafaf; border-radius: 10px; background: #e8eaf1;">
                            <p class="mb-0 text-left">Stock MNT : <a href="ClosingStock.aspx" id="lbl_StockMNT" runat="server" class="text-primary">0</a></p>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3">
                    <div class="media border-bottom">
                        <div class="media-body">
                            <p class="mb-0 text-left">As on date</p>
                            <h3 class="text-orange text-left">
                                <a href="ClosingStock.aspx" id="lbl_StockValue" runat="server" class="text-primary">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left blink-text">Refill your Stock</p>
                            <h3 class="text-left blink-text" id="lbl_StockRefile" runat="server">0</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-xxl-3 col-lg-3 col-sm-3">
            <div class="widget-stat card">
                <div class="card-body p-3 ">
                    <div class="media ">
                        <div class="media-body">
                            <p class="mb-0 text-left">Stock</p>
                        </div>
                    </div>
                </div>
                <div class="card-body  p-3 ">
                    <div class="media border-bottom">
                        <div class="media-body ">
                            <p class="mb-0 text-left"><%=method.PV%></p>
                            <h3 class="text-left">
                                <a href="AssociateInvoiceList.aspx" id="lbl_RPVValue" runat="server" class="text-primary">0</a>
                            </h3>
                        </div>
                    </div>
                </div>
                <%--<div class="card-body p-3 pt-0 pb-1">
                    <div class="media">
                        <div class="media-body">
                            <p class="mb-1 text-left">TPV</p>
                            <h3 class="text-left">
                                <a href="AssociateInvoiceList.aspx" id="lbl_TPVValue" runat="server" class="text-primary"></a>
                            </h3>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
        </div>
       
    <div id="div_newdisplay" runat="server" visible="false" class="mb-4">
        <div class="col-sm">
            <div class="card m-0" style="background: #0f306f; color: #fff;">
                <div class="px-4 py-3">
                    <div class="row align-items-center">
                        <div class="col" style="min-width: 300px">
                            <div id="div_NewsId" runat="server" class="row card-group-row">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xl-12 mb-4">
            <!--#include virtual="Highcharts.aspx"-->
        </div>
        <div class="col-md-12">
            <div class="clearfix"></div>
            <div class="row" style="padding-bottom: 10px;">
                <div class="table-responsive">
                    <table id="tblList" class="table" style="width: 100%; border-collapse: collapse;">
                        <tfoot align="right">
                            <tr>
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
            </div>
        </div>
    </div>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        //function dateEvent(id) { $JD(id).datepick({ dateFormat: 'dd/mm/yyyy' }); }

    </script>


    <%--    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../Grid_js_css/buttons.dataTables.css" rel="stylesheet" />--%>

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

        var pageUrl = "welcome.aspx";

        $JDT(function () {
            BindTransitItem();
        });


        function GetTopSellingTable() {
            BindCartTable();
            $JDT('html, body').animate({
                scrollTop: $('#tblList').offset().top
            }, 2000);
        }


        function BindCartTable() {
            $.ajax({
                type: "POST",
                url: 'welcome.aspx/GetCartData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var json = [];
                    var TotalReq = 0
                    for (var i = 0; i < data.d.length; i++) {

                        var Pid = data.d[i].Pid;
                        var Requirement = '<div style="margin: auto; width: max-content;"> <span class="fa fa-minus quant" onclick="MinusQty(' + Pid + ')" style="cursor: pointer;"></span> <input type="text" id="qty_' + Pid + '" value="' + data.d[i].Requirement + '" onchange="UpdateQty(' + Pid + ')" class="form-control input-number text-center" maxlength="4" style="width:50px; height: 29px; float: left; padding:5px;"/> <span class="fa fa-plus quant" onclick="AddQty(' + Pid + ')" style="cursor: pointer;"></span> </div>';

                        TotalReq = parseInt(TotalReq) + parseInt(data.d[i].Requirement);
                        json.push([i + 1,
                        data.d[i].ProductName,
                        data.d[i].AssoSalesQty,
                        data.d[i].FranSalesQty,
                        data.d[i].TotalSalesQty,
                        data.d[i].ClosingStock,
                            Requirement,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "350px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: [''],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            { title: "Products" },
                            { title: "Associate <br/> Sales Qty" },
                            { title: " Sales Qty" },
                            { title: "Total<br/> Sales Qty" },
                            { title: "Closing<br/> Stock" },
                            { title: "Requirement <br> <a href='BarcodeBilling.aspx?BT=3&PT=3&PO=1' class='btn btn-outline-primary'>Add To Cart</a>" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 20,
                        "bPaginate": false,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };

                            // Total over all pages
                            $(api.column(1).footer()).html("Total:");

                            var AssociateQty = api.column(2).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(2).footer()).html(AssociateQty);

                            var FranchiseQty = api.column(3).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(3).footer()).html(FranchiseQty);

                            var TotalQty = api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(4).footer()).html(TotalQty);

                            $(api.column(6).footer()).html(TotalReq);

                        }
                    });
                },
                error: function (result) {
                    alert(result);
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
            var Qty = $('#qty_' + Pid).val();
            $.ajax({
                type: "POST",
                url: 'welcome.aspx/UpdateQty',
                data: '{Pid: "' + Pid + '", Qty: "' + Qty + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "") {
                        BindCartTable();
                        return;
                    }
                },
                error: function (response) {
                }
            });
        }




        function BindTransitItem() {

            $.ajax({
                type: "POST",
                url: 'welcome.aspx/BindTransitItem',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var Addevent = [];

                    if (data.d.length > 0) { $('.bd-example-modal-xl').show(); }
                    else { $('.bd-example-modal-xl').hide(); }

                    $('#tblTransit').empty().append("<thead style='    background-color: #fe6a00; color:#fff;'> <tr><th>#</th> <th>Inv. Date</th> <th>Invoice No.</th> <th>DP with Tax</th> <th>Dispatch Status</th> <th>Dispatch Date</th> <th>Remarks</th>  <th>Transport LR</th> <th>Receive</th> </tr></thead>");

                    var tblContent = '<tbody>';
                    for (var i = 0; i < data.d.length; i++) {

                        var srno = data.d[i].srno;
                        var Deliver = '';

                        var Img1Color = "style=color:blue;";
                        if (data.d[i].DispatchFileName != "")
                            Img1Color = "style=color:green;";


                        //Addevent.push({ id: srno });

                        tblContent += '<tr>';
                        tblContent += '<td style="text-align:center;">' + (i + 1) + '</td>';
                        tblContent += '<td>' + data.d[i].Doe + '</td>';
                        tblContent += '<td>' + data.d[i].InvoiceNo + '</td>';
                        tblContent += '<td>' + data.d[i].Amount + '</td>';
                        tblContent += '<td>Transit</td>';
                        tblContent += '<td>' + data.d[i].DispatchDate + '</td>';
                        tblContent += '<td>' + data.d[i].DeliveryRemark + '</td>';
                        tblContent += '<td style="text-align:center;"><a href="../images/Slip/' + data.d[i].DispatchFileName + '" data-fancybox="gallery" ' + Img1Color + '"> <i class="fa fa-eye" title="View Image 1"></i> </a></td>';
                        //tblContent += '<td><input type="text" id="txt_DeliverDate' + srno + '" value="' + data.d[i].DeliveryDate + '" onclick="dateEvent("txt_DeliverDate"' + srno + '");" placeholder="dd/mm/yyyy" class="form-control"></input></td>';
                        tblContent += '<td> <a href="#/" onclick="Deliver_Invice(' + srno + ')" class="button-blink">Receive</a> </td>';
                        tblContent += '</tr>';
                    }
                    tblContent += '</tbody>';
                    $('#tblTransit').append(tblContent);

                    //$.each(Addevent, function (index, value) {
                    //    dateEvent("#txt_DeliverDate" + value.id);
                    //});


                    //for (var i = 0; i < data.d.length; i++) {
                    //    json.push([i + 1,
                    //    data.d[i].Doe,
                    //    data.d[i].InvoiceNo,
                    //    data.d[i].Amount,
                    //    'Transit',
                    //    data.d[i].DispatchDate,
                    //     data.d[i].DeliveryRemark,
                    //    '<a href="../images/Slip/' + data.d[i].DispatchFileName + '" data-fancybox="gallery" ' + Img1Color + '"> <i class="fa fa-eye" title="View Image 1"></i> </a>',
                    //   '<input type="text" id="txt_DeliverDate' + srno + '" value="' + data.d[i].DeliveryDate + '" onclick="dateEvent("txt_DeliverDate"' + srno + '");" placeholder="dd/mm/yyyy" class="form-control"></input>',
                    //    Deliver,
                    //    ]);
                    //}

                    //$JDT('#tblTransit').DataTable({
                    //    dom: 'Blfrtip',
                    //    scrollY: "350px",
                    //    scrollX: true,
                    //    scrollCollapse: true,
                    //    searching: false,
                    //    buttons: [''],
                    //    data: json,
                    //    columns: [
                    //        { title: "#" },
                    //        { title: "Inv. Date" },
                    //        { title: "Invoice No." },
                    //        { title: "DP with Tax" },
                    //        { title: "Dispatch Status" },
                    //        { title: "Dispatch Date" },
                    //        { title: "Remarks" },
                    //        { title: "Transport LR" },
                    //        { title: "Deliver Date" },
                    //        { title: "Delivery" },
                    //    ],
                    //    "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                    //    "pageLength": 20,
                    //    "bPaginate": false,
                    //    "bDestroy": true,
                    //});

                },
                error: function (result) {
                    alert(result);
                }

            });
        }



        function Deliver_Invice(srno) {

            //var DeliverDate = $('#txt_DeliverDate' + srno).val();
            //if (DeliverDate != "")
            //    DeliverDate = dateFormate(DeliverDate);

            if (!confirm('Are you sure you want to deliver？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/Deliver_Inv',
                data: '{srno: "' + srno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Deliver Updated Successfully");
                        BindTransitItem();
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function closePopup() {
            $('.bd-example-modal-xl').hide();
        }


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


    <style>
        .widget-stat .media .media-body p {
            text-transform: capitalize;
        }

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

        table, th, td {
            border: 2px solid black;
            border-collapse: collapse;
        }

        input[type=checkbox] {
            display: none;
        }

        .zoom_image {
            transform: scale(3);
            cursor: zoom-out;
        }

        .zoom_img {
            transition: transform 0.25s ease;
            cursor: zoom-in;
        }

        input[type=checkbox]:checked ~ label > img {
            transform: scale(3);
            cursor: zoom-out;
        }

        #more {
            display: none;
        }

        .imagezoomout img:hover {
            transform: scale(1.7) !important;
        }

        .imagezoomout img {
            transform: scale(1) !important;
        }

        @media only screen and (min-width : 180px) and (max-width : 520px) {
            .imagezoomout img:hover {
                transform: scale(1) !important;
            }

            .imagezoomout img {
                transform: scale(1) !important;
            }
        }
    </style>

    <%--<button type="button" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg">Large modal</button>--%>
    <div class="modal fade bd-example-modal-xl show" tabindex="-1" style="padding-right: 17px; background: #000000ab;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content" style="overflow-y: scroll; max-height: 767px;">
                <div class="modal-header">
                    <h3 class="modal-title">Note:- Please click <span class="button-blink">Receive</span> button on receipt of goods! / समान प्राप्ति पर <span class="button-blink">Receive</span> बटन दबाना अनिवार्य है|</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup()">
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="table-responsive">
                        <table id="tblTransit" class="table table-striped primary-table-bordered" style="width: 100%; border-collapse: collapse;">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .container-fluid {
        background: #F8F8F8!important;
        }
  
        .button-blink {
            margin: 0.4em 0;
            display: inline-block;
            font-weight: 400;
            line-height: 1.5;
            color: #fff;
            text-align: center;
            text-decoration: none;
            vertical-align: middle;
            cursor: pointer;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: 0.425rem 1rem;
            font-size: .813rem;
            border-radius: 0.4rem;
            transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        }

        @keyframes glowing {
            0% {
                background-color: #fe6a00;
                box-shadow: 0 0 5px #fe6a00;
            }

            50% {
                background-color: #fe6a00;
                box-shadow: 0 0 20px #fe6a00;
            }

            100% {
                background-color: #315787;
                box-shadow: 0 0 5px #315787;
            }
        }

        .button-blink {
            animation: glowing 1300ms infinite;
        }

        .blink-text {
            animation: blinkingText 2s infinite;
        }

        @keyframes blinkingText {
            0% {
                color: #fff;
            }

            25% {
                color: var(--primary);
            }

            50% {
                color: #fff;
            }

            75% {
                color: var(--primary);
            }

            100% {
                color: #fff;
            }
        }


        [data-sidebar-position=fixed][data-layout=vertical] .nav-header {
            z-index: 9;
        }

        .table > tbody {
            text-align: left;
        }
    </style>

    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</asp:Content>
