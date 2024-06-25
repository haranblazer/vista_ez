<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="FranchisePayoutDetails.aspx.cs" Inherits="franchise_FranchisePayoutDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 id="ContentPlaceHolder1_vendhead" class="fs-20 font-w600  me-auto">Your Commission Report</h4>
    </div>


    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
            <tfoot align="right">
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
                   <%-- <th></th>
                    <th></th>--%>
                </tr>
            </tfoot>
        </table> 
    </div>


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
        var pageUrl = '<%=ResolveUrl("FranchisePayoutDetails.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                //data: '{pid: "' + pid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var Statement = '<a href="../Common/PayoutStatment.aspx?id=' + data.d[i].Fid + '" style="color:blue;">Statment</a>';

                        json.push([i + 1,
                        //data.d[i].Franchise_ID,
                        //data.d[i].Franchise_Name,
                        //data.d[i].Franchise_Type,
                        //data.d[i].PAN,
                        //data.d[i].Bank,

                        //data.d[i].Account_No,
                        //data.d[i].IFSC_Code,
                        data.d[i].FromDate,
                        data.d[i].ToDate,

                        //data.d[i].FPV,
                        //data.d[i].APV,
                        data.d[i].Commission_on_FPV,

                        data.d[i].Commission_on_APV,
                        data.d[i].Stock_Value_as_on_5th_Day,
                        data.d[i].Opening_Amount,
                        data.d[i].Maintainance_Expenses,
                        data.d[i].Offer_Income,

                        data.d[i].Total_Commission,
                        data.d[i].TDS,
                        data.d[i].Dispatch_Amount,


                        data.d[i].PayoutNo,
                            Statement,
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
                            { title: "From Date" },
                            { title: "To Date" },
                            //{ title: "Franchise ID" }, 
                            //{ title: "Franchise Name" },
                            //{ title: "Franchise Type" }, 
                            //{ title: "PAN" },
                            //{ title: "Bank" }, 
                            //{ title: "Account No" },
                            //{ title: "IFSC Code" },
                            //{ title: "FPV" },
                            //{ title: "APV" },

                            { title: "COMM. <br>on Purch." },
                            { title: "COMM. <br>on Sales" },
                            { title: "Stock Value as <br> on 3/5th Day" },
                            { title: "Opening <br>Amount" },
                            { title: "Maint. <br>Expenses" },
                            { title: "Offer <br>Income" },
                            { title: "Total <br>COMM." },
                            { title: "TDS" },
                            { title: "Dispatch <br>Amount" },
                            { title: "Payout No" },
                            { title: "Statment" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };

                            // Total over all pages 

                            $(api.column(3).footer()).html(api.column(3).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(4).footer()).html(api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            //$(api.column(12).footer()).html(api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            //$(api.column(13).footer()).html(api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                        }
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
    </script>

</asp:Content>


