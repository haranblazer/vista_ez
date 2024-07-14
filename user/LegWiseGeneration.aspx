<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="LegWiseGeneration.aspx.cs"
    Inherits="User_LegWiseGeneration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Super 20 Report</h4>

    <div class="row">

        <div class="col-sm-1 control-label">Month</div>
        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddl_Month" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>
        <div class="col-sm-1">
            <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
        </div>
    </div>



    <div class="clearfix"></div>
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%"></table>
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
        var pageUrl = '<%=ResolveUrl("LegWiseGeneration.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var Months = $('#<%=ddl_Month.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Userid: "", Months: "' + Months + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        var Userid = "'" + data.d[i].Userid + "'";
                        let RPV_Count = '';
                        if (data.d[i].RPV_Count1 != '0') {
                            if ("<%=Userid%>" == data.d[i].Userid) {
                                RPV_Count = 'Self';
                            } else {
                                RPV_Count = '<a href="#/" onclick="DL_User(' + Userid + ')" style="color:blue;">' + data.d[i].RPV_Count1 + '</a>';
                            }
                        }
                        else {
                            RPV_Count = '<a href="javascript:void(0)" style="color:black;">' + data.d[i].RPV_Count1 + '</a>';
                        }
                        
                        json.push([i + 1,
                        data.d[i].Userid,
                            data.d[i].UserName,
                            data.d[i].PBVAmt,
                            RPV_Count,
                            //data.d[i].RPV_Count2,
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
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "RPV" },
                            { title: "750 Count" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function DL_User(Userid) {
            var Months = $('#<%=ddl_Month.ClientID%>').val();
            $("#DL_Table_Modal").modal('show');
            $('#div_DL_Table').empty().append('');
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Userid: "' + Userid + '", Months: "' + Months + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    
                    var tbl = "";
                    tbl += '<table class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">';
                    tbl += '<thead>';
                    tbl += '<tr>'; 
                    tbl += '<th scope="col">User Id </th>';
                    tbl += '<th scope="col">User Name </th>';
                     tbl += '<th scope="col">RPV</th>';
                    tbl += '</tr>';
                    tbl += '</thead>';
                    tbl += '<tbody>';

                    for (var i = 0; i < data.d.length; i++) {
                        tbl += '<tr>';
                        tbl += '<td>' + data.d[i].Userid + '</td>'; 
                        tbl += '<td>' + data.d[i].UserName + '</td>';
                        tbl += '<td>' + data.d[i].PBVAmt + '</td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    tbl += '</table>';
                    $('#div_DL_Table').empty().append(tbl); 
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Modal HTML -->
    <div id="DL_Table_Modal" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                        <h5 class="modal-title">Downline Report</h5> 
                    </div>
                <%-- <div class="modal-header">
                        <h5 class="modal-title">Modal Title</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>--%>
                <div class="modal-body">
                    <div id="div_DL_Table" class="product-descr"></div>
                </div>

            </div>
        </div>
    </div>
     

</asp:Content>

