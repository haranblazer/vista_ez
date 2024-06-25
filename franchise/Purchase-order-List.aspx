<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="Purchase-order-List.aspx.cs" Inherits="franchise_Purchase_order_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Purchase Order List </h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">

        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="col-sm-2">
            <asp:TextBox ID="txt_orderno" placeholder="Order No." runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-sm-1 col-xs-6">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                Search
            </button>
        </div>
        <div class="col-sm-1 col-xs-6 text-right pull-right">
        </div>
    </div>
    <hr />
    <div class="clearfix"></div>

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

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
        var pageUrl = '<%=ResolveUrl("Purchase-order-List.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {

            var orderno = $('#<%=txt_orderno.ClientID%>').val();
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{orderno: "' + orderno + '", min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    $('#LoaderImg').hide();
                    for (var i = 0; i < data.d.length; i++) {

                        var Invoice = '<a style="color:blue;" href="GRN-Fran-Bill.aspx?id=' + data.d[i].srno_Encript + '">' + data.d[i].InvoiceNo + '</a>';
                        //var ReceiveOrder = '<a href="Stock-GIT.aspx?Inv=' + data.d[i].InvoiceNo + '">' + data.d[i].InvoiceNo + '</a>';

                        var ReceiveOrder = '';
                        if (data.d[i].Status == '0') {
                            ReceiveOrder = '<a style="color:blue;" href="Stock-GIT.aspx?Inv=' + data.d[i].InvoiceNo + '">GRN</a>';
                        }
                        else {
                            ReceiveOrder = '<span style="color:green">Rcv"d</span>';
                        }
                        var Status = '';
                        var srno = data.d[i].srno;
                        if (data.d[i].Status == "0") {
                            Status = '<a href="#/" onclick="UpdateStatus(' + srno + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            Status = '<a href="#/" onclick="UpdateStatus(' + srno + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }


                        json.push([i + 1,
                            Invoice,
                            ReceiveOrder,
                            Status,
                        data.d[i].VenderName,
                        data.d[i].SessionId,
                        data.d[i].UserName,
                        data.d[i].DeliverTo,
                        data.d[i].Gross,
                        data.d[i].GST,
                        data.d[i].Discount,
                        data.d[i].NetAmt,
                        data.d[i].BillDate,
                        data.d[i].DeliveryDate,
                        data.d[i].SourceOfSupply,
                        data.d[i].DestinationOfSupply,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "SNo" },
                            { title: "Order No." },
                            { title: "GRN/ REC" },
                            { title: "Order Closed" },
                            { title: "Vender Name" },
                            { title: "Deliver Userid" },
                            { title: "Deliver Name" },
                            { title: "Deliver To" },
                            { title: "Gross" },
                            { title: "GST" },
                            { title: "Discount" },
                            { title: "Net Amt" },
                            { title: "Bill Date" },
                            { title: "Delivery Date" },
                            { title: "Source Of Supply" },
                            { title: "Place of Supply" },
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


        function UpdateStatus(srno) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{srno: "' + srno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    BindTable();
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        }

    </script>


</asp:Content>

