<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master"
    AutoEventWireup="true" CodeFile="POList.aspx.cs" Inherits="franchise_POList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Purchase Order Made</h4>
   <div class="row">
                        <div class="col-md-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                                MaxLength="10"></asp:TextBox>
                        </div>

                        <div class="col-md-2 ">

                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                                MaxLength="10"></asp:TextBox>

                        </div>

                        <div class="col-md-2 col-xs-6">
                            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                                <i class="fa fa-search"></i>&nbsp;Search
                            </button>
                            <%-- <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Search"
                    OnClick="btnSearch_Click" />--%>
                        </div>
                        <div class="col-md-2 pull-right text-right col-xs-6">
                            <%-- <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                    Width="25px" />
                <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                    Style="margin-left: 0px" Width="26px" />--%>
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
                    </tr>
                </tfoot>
            </table>
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
            var pageUrl = '<%=ResolveUrl("POList.aspx")%>';
            $JDT(function () {
                BindTable();
            });


            function BindTable() {
                var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
                $.ajax({
                    type: "POST",
                    url: pageUrl + '/BindTable',
                    data: '{ min: "' + min + '", max: "' + max + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var json = [];

                        for (var i = 0; i < data.d.length; i++) {
                            var InvoiceNo = '<a style="color:blue;" href="PO_BILL.aspx?id=' + data.d[i].srno_Encode + '">' + data.d[i].InvoiceNo + '</a>';

                            json.push([i + 1,
                                InvoiceNo,
                            data.d[i].Status == "1" ? "<span style='color:green'>" + data.d[i].Status_Text + "</<span>" : "<span style='color:red'>" + data.d[i].Status_Text + "</<span>",
                            data.d[i].SalesRepId,
                            data.d[i].SellerName,
                            data.d[i].doe,
                            data.d[i].NoOFProduct,
                            data.d[i].amt,
                            data.d[i].grossAmt,
                            data.d[i].tax,
                            data.d[i].netAmt,
                            data.d[i].SellerState,
                            data.d[i].PlaceOfSupply,
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
                                { title: "SNo" },

                                { title: "Invoice No." },
                                { title: "Status" },
                                { title: "Seller ID" },
                                { title: "Seller Name" },
                                { title: "Bill Date" },
                                { title: "No.Of Product" },

                                { title: "Amount" },
                                { title: "Gross" },
                                { title: "Tax Amount" },
                                { title: "Net Amount" },
                                { title: "Source state" },
                                { title: "Target State" },
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

                                //    // Total over all pages
                                var Val1 = api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                                $(api.column(6).footer()).html(Val1);

                                var Val2 = api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                                $(api.column(7).footer()).html(Val2.toFixed(2));

                                var Val3 = api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                                $(api.column(8).footer()).html(Val3.toFixed(2));

                                var Val4 = api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                                $(api.column(9).footer()).html(Val4.toFixed(2));

                                var Val5 = api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                                $(api.column(10).footer()).html(Val5.toFixed(2));
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
