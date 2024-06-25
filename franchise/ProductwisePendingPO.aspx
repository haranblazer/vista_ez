<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ProductwisePendingPO.aspx.cs" Inherits="ProductwisePendingPO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product Wise Order</h4>
     
   

    <div class="row">
        <div class="col-sm-3">
            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Open Order</asp:ListItem>
                <asp:ListItem Value="1">Closed Order</asp:ListItem>
                <asp:ListItem Value="-1">All Order</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-1 col-xs-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>

    </div>
    <br />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
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
                </tr>
            </tfoot>
        </table>
    </div>
     <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
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

        var pageUrl = '<%=ResolveUrl("ProductwisePendingPO.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
             
            var Status = $('#<%=ddl_Status.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Status: "' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        var ReceiveOrder = '';
                        if (data.d[i].Status == '0') {
                            ReceiveOrder = '<a style="color:blue;" href="Stock-GIT.aspx?Inv=' + data.d[i].PONumber + '">GRN</a>';
                        }
                        else {
                            ReceiveOrder = '<span style="color:green">Rcv"d</span>';
                        }
                        var Status = '';
                        var srno = data.d[i].Srno;
                        if (data.d[i].Status == "0") {
                            Status = '<a href="#/" onclick="UpdateStatus(' + srno + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            Status = '<a href="#/" onclick="UpdateStatus(' + srno + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }


                        json.push([i + 1,
                            ReceiveOrder,
                            Status,
                        data.d[i].ProductName,
                            data.d[i].ProductCode,

                        data.d[i].QtyOrdered,
                        data.d[i].QtyReced,
                        data.d[i].QtyPending,
                           
                        data.d[i].PONumber,
                        data.d[i].PODate,
                        data.d[i].V_regno,
                        data.d[i].VendorName,
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
                            { title: "GRN <br> Rec'd." },
                            { title: "Order Open <br> Closed" },
                            { title: "Product Name" },
                            { title: "Code" },
                            { title: "Qty <br> Ord." },
                            { title: "Qty <br> Rec'd." },
                            { title: "Qty <br> Pend" },
                           
                            { title: "Order Number" },
                            { title: "Order Date" },
                            { title: "V. Id" },
                            { title: "Vendor Name" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages
                            
                            $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                        }
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
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

