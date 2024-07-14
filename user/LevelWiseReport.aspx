<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="LevelWiseReport.aspx.cs" Inherits="User_LevelWiseReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Level Wise Summary Report</h4>
    </div>

    <div class="form-group card-group-row row" style="display: none;">
        <label class="col-md-2 control-label">Search Level</label>
        <div class="col-md-2">
            <asp:TextBox ID="txt_Level" runat="server" Width="100px" CssClass="form-control">1</asp:TextBox>
        </div>
        <div class="col-md-1 text-left">
            <%--<asp:Button ID="btnSearch" runat="server" BackColor="#F37E15" BorderColor="Black"
                BorderWidth="1px" Font-Bold="True" ForeColor="White" Text="Search" OnClick="btnSearch_Click" />--%>
        </div>
      
    </div>
    <div class="clearfix"></div>
 

    <%-- <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="#6D609E"></asp:Label>--%>
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
            <tfoot align="right">
                <tr>
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

    <script type="text/javascript">
        var $JDT = $.noConflict(true);
        var pageUrl = '<%=ResolveUrl("LevelWiseReport.aspx")%>';
        $JDT(function () {
            //$.noConflict(true);
            BindTable();
        });


        function BindTable() {
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    var T_CurrentRPV = 0
                    for (var i = 0; i < data.d.length; i++) {
                        T_CurrentRPV = parseFloat(T_CurrentRPV) + parseFloat(data.d[i].CurrentRPV);
                        json.push([i,
                            data.d[i].Level,
                            //data.d[i].Count,
                            //data.d[i].CurrentRPV,
                            '<div style="text-align:right;">' + data.d[i].CurrentRPV + '</div>',
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
                            { title: "#" },
                            { title: "Level" },
                            //{ title: "No Of Associate" },
                            { title: '<div style="text-align:right;">CurrentRPV</div>'},
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
                            //var PPV = api.column(2).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(2).footer()).html(T_CurrentRPV.toFixed(2));
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

