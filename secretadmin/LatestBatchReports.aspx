<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="LatestBatchReports.aspx.cs" Inherits="secretadmin_LatestBatchReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Latest Batch Reports</h4> 
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div> 
    <br /> 

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
          <%--  <tfoot align="left">
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
                </tr>
            </tfoot>--%>
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

        var pageUrl = '<%=ResolveUrl("LatestBatchReports.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
           
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
               // data: '{ product: "' + product + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) { 
                        json.push([i + 1,
                            data.d[i].ProductCode,
                            data.d[i].ProductName,
                            
                            data.d[i].PurchaseRate,
                            data.d[i].MRP,
                            data.d[i].DPValue,
                            data.d[i].GSTRate,
                            data.d[i].AssociateRate,
                            data.d[i].RPV,
                            //data.d[i].TPV,

                            //data.d[i].FPV,
                            //data.d[i].APV, 
                            data.d[i].BatchNo,
                            data.d[i].MFg,
                            data.d[i].Exp, 
                            data.d[i].HSNCode,
                            data.d[i].CatName,
                        ]);
                         
                    }


                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel'],
                        data: json,
                        columns: [
                            { title: "#" },
                            { title: "Code" },
                            { title: "Product Name" }, 
                            { title: "Pur.<br> Rate" },
                            { title: "MRP" },
                            { title: "DP <br> Value" },
                            { title: "GST <br> Rate" },
                            { title: "<%=method.Associate%> <br> Rate" }, 
                            { title: "<%=method.PV%>" },
                            //{ title: "TPV" },

                            //{ title: "FPV" },
                            //{ title: "APV" }, 
                            { title: "Batch No." },
                            { title: "Mfg." },
                            { title: "Exp." }, 
                            { title: "HSN" },
                            { title: "Category" },
                            
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        //"footerCallback": function (row, data, start, end, display) {
                        //    var api = this.api(), data; 
                        //    // Remove the formatting to get integer data for summation
                        //    var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                        //    // Total over all pages 
                        //    $(api.column(0).footer()).html("Total:");
                        //    //$(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0)); 
                        //}
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }

    </script>


</asp:Content>

