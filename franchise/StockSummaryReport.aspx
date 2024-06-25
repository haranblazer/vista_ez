<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="StockSummaryReport.aspx.cs" Inherits="franchise_StockSummaryReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Stock Summary Report</h4>

    <div class="row">

        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
            <div class="clearfix">
            </div>
        </div>

        <div class="col-sm-1 col-xs-6">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                Search
            </button>

        </div>

    </div>
    <div class="clearfix">
    </div>
    <hr />

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display" style="width: 100%">
            <tfoot align="left">
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
                   <%-- <th></th>--%>
                </tr>
            </tfoot>
        </table>
    </div>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
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
        var pageUrl = '<%=ResolveUrl("StockSummaryReport.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let PhysStock_Header = '';
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    var TotalRedeem = 0;
                    var TotalReplenish = 0;
                    for (var i = 0; i < data.d.length; i++) {
                        var Redeem = '<a target="_blank" style="color:blue;" href="TotalOut.aspx?pid=' + data.d[i].Pid_Encode + ' &typ=' + data.d[i].Mode19_Encode + ' &From=' + data.d[i].From_Encode + ' &To=' + data.d[i].To_Encode + '">' + data.d[i].Redeem + '</a>';
                        var Replenish = '<a target="_blank" style="color:blue;" href="TotalOut.aspx?pid=' + data.d[i].Pid_Encode + ' &typ=' + data.d[i].Mode20_Encode + ' &From=' + data.d[i].From_Encode + ' &To=' + data.d[i].To_Encode + '">' + data.d[i].Replenish + '</a>';
                        TotalRedeem = parseInt(TotalRedeem) + parseInt(data.d[i].Redeem);
                        TotalReplenish = parseInt(TotalRedeem) + parseInt(data.d[i].Replenish);


                        let PhysStock = '';
                        <%--if (<%=IsCompany%> == "2") {
                            PhysStock_Header = 'Phys.<br/> Stock';
                            PhysStock = ((parseInt(data.d[i].Closing_Qty) + parseInt(data.d[i].Replenish)) - parseInt(data.d[i].Redeem));
                        } else {
                            PhysStock_Header = '';
                            PhysStock = '';
                        }--%>
                       


                        var PurchaseDetails = '<a target="_blank" style="color:blue;" href="TotalOut.aspx?pid=' + data.d[i].Pid_Encode + ' &typ=' + data.d[i].Mode15_Encode + ' &From=' + data.d[i].From_Encode + ' &To=' + data.d[i].To_Encode + '">View</a>';
                        var SalesDetails = '<a target="_blank" style="color:blue;" href="TotalOut.aspx?pid=' + data.d[i].Pid_Encode + ' &typ=' + data.d[i].Mode12_Encode + ' &From=' + data.d[i].From_Encode + ' &To=' + data.d[i].To_Encode + '">View</a>';

                        json.push([i + 1,
                            data.d[i].ProductCode,
                            data.d[i].ProductName,
                        data.d[i].Opening_Qty,
                        data.d[i].Purchase_Qty,
                        data.d[i].Purchase_Return,
                        data.d[i].Sales_Qty,
                        data.d[i].Sales_Return,
                        data.d[i].Closing_Qty,
                            Redeem,
                            Replenish,
                           // PhysStock,
                            PurchaseDetails,
                            SalesDetails,
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
                            { title: "#" },
                            { title: "Prod<br/> Code" },
                            { title: "Product Name" },
                            { title: "Opng.<br/> Qty" },
                            { title: "Purc.<br/> Qty" },
                            { title: "Purc.<br/> Rtn" },
                            { title: "Sales<br/> Qty" },
                            { title: "Sales<br/> Rtn" },
                            { title: "Closing<br/> Qty" },
                            { title: "Redm." },
                            { title: "Repln" },
                            //{ title: PhysStock_Header },
                            { title: "Purc.<br/> Dtl." },
                            { title: "Sales<br/> Dtl." },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) {
                                return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0;
                            };

                            // Total over all pages
                            $(api.column(3).footer()).html(api.column(3).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                            $(api.column(4).footer()).html(api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                            $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));

                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));

                            $(api.column(9).footer()).html(TotalRedeem);
                            $(api.column(10).footer()).html(TotalReplenish);
                            $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                        }
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

    </script>
</asp:Content>

