<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="MonthlyGenerationPoint.aspx.cs" Inherits="User_MonthlyGenerationPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                <h4 class="fs-20 font-w600  me-auto">Monthly Information</h4>
            </div>
        </div>
        
    </div>
    <div class="clearfix"></div>
   
    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
            <tfoot align="center">
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                  <%--  <th></th>
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
        var pageUrl = '<%=ResolveUrl("MonthlyGenerationPoint.aspx")%>';
        $JDT(function () { 
            BindTable();
        });


        function BindTable() {
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                //data: '{rank: "' + rank + '", paid: "' + paid + '", Userid: "' + Userid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                            data.d[i].Month,
                            data.d[i].PPV,
                            data.d[i].GPV,
                            //data.d[i].TPV,
                           // data.d[i].GPV_TPV,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "350px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            { title: "Month" },
                            { title: "" + '<%=method.PV%>' },
                            { title: "" + '<%=method.GBV%>' },
                            //{ title: "TPV" },
                            //{ title: "GPV+TPV" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        // columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) {
                                return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0;
                            };

                            // Total over all pages
                            var PPV = api.column(2).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(2).footer()).html(PPV.toFixed(2));

                            var GPV = api.column(3).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(3).footer()).html(GPV.toFixed(2));

                            //var TPV = api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            //$(api.column(4).footer()).html(TPV.toFixed(2));

                            //var GPV_TPV = api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            //$(api.column(5).footer()).html(GPV_TPV.toFixed(2)); 
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

