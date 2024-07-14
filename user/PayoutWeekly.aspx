<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="PayoutWeekly.aspx.cs" Inherits="User_PayoutWeekly" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Weekly Payout</h4>
    </div>


    <%--  <div class="form-group">
        <div class="row">
            <div class="col-md-11"></div>
            <div class="col-md-1">
                <asp:ImageButton ID="ibtnExcel" runat="server" ImageUrl="images/excel.gif" Width="24px" OnClick="ibtnExcel_Click" />
            </div>
        </div>
    </div>--%>

    <div class="clearfix"></div>

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
        var pageUrl = '<%=ResolveUrl("PayoutWeekly.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                //data: '{iselegible: "' + iselegible + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        var Statement = '<a stye="color:blue;" target="_blank" href="../secretadmin/WeeklyPayoutStatement.aspx?n=' + data.d[i].Decode_payoutno + '&id=' + data.d[i].Decode_appmstregno + '"><i class="fa fa-print"></i></a>';

                        json.push([i + 1,
                            data.d[i].Payout_Period,
                            data.d[i].payoutno,
                            data.d[i].Status,
                            data.d[i].Matching_Counts,
                            data.d[i].Total_Payout,
                            data.d[i].TDS,
                            data.d[i].PC_Charges,
                           
                            data.d[i].Net_Payout,
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
                            { title: "SNo." },
                            { title: "Payout Period" },
                            { title: "Payout No" },
                            { title: "Status" },
                            { title: "Matching Bonus" },
                            { title: "Total Payout" },
                            { title: "TDS" },
                            { title: "PC Charges" },
                            { title: "Net Payout" },
                            { title: "Print" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };

                            //    // Total over all pages
                            var Val = api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(4).footer()).html(Val.toFixed(0));

                            var Val = api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(5).footer()).html(Val.toFixed(2));

                            var Val = api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(6).footer()).html(Val.toFixed(2));

                            var Val = api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(7).footer()).html(Val.toFixed(2));

                            var Val = api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(8).footer()).html(Val.toFixed(2));
                             
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

