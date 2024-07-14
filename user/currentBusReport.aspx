<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="currentBusReport.aspx.cs" Inherits="user_currentBusReport" %>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Current Business Report</h4>
    <hr />

    <div class="clearfix"> </div>
    <br />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
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
        var pageUrl = '<%=ResolveUrl("currentBusReport.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() { 
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                //data: '{ UserId: "' + UserId + '", DOWNUP: "' + DOWNUP + '", Paid: "' + Paid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
 
                        json.push([
                            i + 1,
                            data.d[i].UserName,
                            data.d[i].UserId,
                            data.d[i].CurrRank,
                            data.d[i].NextRank,
                            parseFloat(data.d[i].First_Purchase_BV) + parseFloat(data.d[i].Self_Repurchase_BV),
                            data.d[i].FreshBV_A,
                            data.d[i].FreshBV_B,
                            data.d[i].FreshMatcheBV,
                            data.d[i].TotalGroupBV_A,
                            data.d[i].TotalGroupBV_B,
                            data.d[i].TotalBV,
                            data.d[i].CarryLeft,
                            data.d[i].CarryRight,
                            data.d[i].TotalMatched,

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

                            { title: "User Name" },
                            { title: "UserId" },
                            { title: "Current Rank" },
                            { title: "Next Rank " },
                            { title: "Personal<br>Repurchase" },
                            { title: "Fresh BV A" },
                            { title: "Fresh BV B" },
                            { title: "Fresh <br>Matched BV" },
                            { title: "Total Group<br>BV A" },
                            { title: "Total Group<br>BV B" },
                            { title: "Total BV" },
                            { title: "Carry<br>Forward A" },
                            { title: "Carry<br>Forward B" },
                            { title: "Total Matched" },
                        ],
                        "lengthMenu": [[15, 100, -1], [15, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        //"footerCallback": function (row, data, start, end, display) {
                        //    var api = this.api(), data;
                        //    // Remove the formatting to get integer data for summation
                        //    var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                        //    //    // Total over all pages
                        //    $(api.column(1).footer()).html('Total:');
                        //    $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
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

