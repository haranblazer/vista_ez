<%@ Page Title="Package Payout" Language="C#" MasterPageFile="~/user/user.master"
    AutoEventWireup="true" CodeFile="UserRepurchaseList.aspx.cs" Inherits="user_UserRepurchaseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        td, th {
            padding: 5px 5px;
            border-color: #ddd;
        }
    </style>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">First Purchase Payout</h4>
    </div>
    <div class="col-sm-3">
        <asp:DropDownList ID="ddl_Payout_Fillter" runat="server" CssClass="form-control" onchange="BindTable()">
            <asp:ListItem Selected="True" Value="-1">All</asp:ListItem>
            <asp:ListItem Value="1">Payout</asp:ListItem>
            <asp:ListItem Value="0">Hold Payout</asp:ListItem>
            <asp:ListItem Value="2">Release Payout</asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </div>

    <div class="table-responsive">
        <table cellpadding="0" width="100%" cellspacing="0" class="table table-striped table-hover display dataTable no-footer"
            style="margin-top: 10px;">
            <tr>
                <th class="tatoal_ba">Total Amount
                </th>
                <th id="Th1" runat="server" class="tatoal_ba">TDS Amount
                </th>
                <th class="tatoal_ba">PC Charges
                </th>
                <th class="tatoal_ba">Dispatched Amount
                </th>

            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblTotalTotalEarned" runat="server" Text="0" Font-Bold="True"></asp:Label>
                </td>
                <td id="Td1" runat="server">
                    <asp:Label ID="lblTotalTdsAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblTotalhandlibgCharges" runat="server" Text="0" Font-Bold="True"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblTotalDispatchedAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lbl_HoldAmt" runat="server" Text="0" Font-Bold="True" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
        <div class="col-md-12">
            <p>
                <span class="label label-default " style="background-color: #fff; color: Black;">Dispatched
                                        Payout</span> <span style="background-color: #ffebea; color: Black;" class="label label-default ">Hold Payout</span> <span class="label label" style="background-color: #e2fbd7; color: Black;">Release Payout </span>
            </p>
        </div>
    </div>
    <div class="clearfix"></div>



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
        var pageUrl = '<%=ResolveUrl("UserRepurchaseList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var iselegible = $('#<%=ddl_Payout_Fillter.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{iselegible: "' + iselegible + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        var Statement = '<a stye="color:blue;" href="../secretadmin/adminpaymentreport.aspx?n=' + data.d[i].Decode_payoutno + '&id=' + data.d[i].Decode_appmstid + '">Statement</a>';

                        json.push([i + 1,
                        data.d[i].payoutno,
                        data.d[i].Paymenttodate,
                        data.d[i].ReleaseAmt,
                        data.d[i].RoyaltyAmt,
                        data.d[i].binaryamt,
                        data.d[i].totalearning,
                        data.d[i].tds,
                        data.d[i].handlingcharges,
                        data.d[i].dispachedamt,

                        data.d[i].paymenttrandraftno,
                        data.d[i].remarks,
                            Statement,
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
                            { title: "Payout No" },
                            { title: "Payout Date" },
                            { title: "Release Amt" },
                            { title: "Active Bonus" },
                            { title: "Self Help <br>Club Bonus" },
                            { title: "Total Income" },
                            { title: "TDS" },
                            { title: "PC Charges" },
                            { title: "Dispatch Amount" },

                            { title: "Tran No" },
                            { title: "Remark" },
                            { title: "Report" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };

                            $(api.column(3).footer()).html(api.column(3).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(4).footer()).html(api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));


                        }

                    });
                },
                error: function (result) {
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
