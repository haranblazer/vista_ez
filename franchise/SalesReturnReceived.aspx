<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="SalesReturnReceived.aspx.cs" Inherits="franchise_SalesReturnReceived" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Sales Return Received</h4>
   <div class="row">


                        <div class="col-sm-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="txtUserid" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-sm-1 col-xs-6 text-left">
                            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                                Search
                            </button>
                            <%--<asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Search"
                OnClick="btnSearch_Click" />--%>
                        </div>

                        <div class="col-sm-12 col-xs-6 text-right pull-right">
                            <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif"
                OnClick="imgbtnExcel_Click" />--%>
                        </div>
                    </div>
         <div class="clearfix">
        </div>
        <hr />

        <div class="table-responsive">
            <table id="tblList" class="table table-striped table-hover display" style="width: 100%">
                 <tfoot align="left">
                    <tr>
                         <th style="text-align:right">Total:</th>
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
            var pageUrl = '<%=ResolveUrl("SalesReturnReceived.aspx")%>';
            $JDT(function () {
                BindTable();
            });


            function BindTable() {
                var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
                var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
                var Regno = $('#<%=txtUserid.ClientID%>').val();
                $.ajax({
                    type: "POST",
                    url: pageUrl + '/BindTable',
                    data: '{min: "' + min + '", max: "' + max + '", Regno: "' + Regno + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var json = [];
                        for (var i = 0; i < data.d.length; i++) {
                            var Print = '<a style="color:blue;" href="../Common/ReturnInv.aspx?id=' + data.d[i].srno_Encript + '"> <i class="fa fa-print" aria-hidden="true"></i> </a>';

                            json.push([i + 1,
                                 data.d[i].Doe,
                                 data.d[i].InvoiceNo,
                                 data.d[i].SellerUserId,
                                 data.d[i].SellerName,
                                 //data.d[i].BuyerUserId,
                                 //data.d[i].BuyerName,
                                 data.d[i].ProdCount,
                                 data.d[i].DP,
                                 data.d[i].SGST,

                                 data.d[i].CGST,
                                 data.d[i].IGST,
                                 data.d[i].DPWithTax,
                                 data.d[i].Courier_Charges,
                                 data.d[i].InvoiceValue,
                                 data.d[i].StatusText,
                                 data.d[i].Dispatch_Status,
                                 data.d[i].PAN,
                                 data.d[i].GSTN,
                                 data.d[i].Dispatch_Date,

                                 data.d[i].Dispatch_Details,
                                 Print,
                                 "",
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

                                { title: "Date" },
                                { title: "Stock Transfer No." },
                                { title: "From (ID)" },
                                { title: "From (Name)" },
                               // { title: "To (Franchise ID)" },
                               // { title: "To (Franchise Name)" },
                                { title: "No of Products" },
                                { title: "DP Value after Discount" },
                                { title: "SGST" },

                                { title: "CGST" },
                                { title: "IGST" },
                                { title: "DP with Tax" },
                                { title: "Courier Charges" },
                                { title: "<%=method.Invoice_Amount%>" },
                                { title: "Invoice Status" },
                                { title: "Dispatch Status" },
                                { title: "PAN" },
                                { title: "GSTN" },
                                { title: "Dispatch Date" },

                                { title: "Dispatch Details" },
                                { title: "Print" },
                                { title: "Action" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,
                            "footerCallback": function (row, data, start, end, display) {
                                var api = this.api(), data;

                                // Remove the formatting to get integer data for summation
                                var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };

                                // Total over all pages 
                                $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                                $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(12).footer()).html(api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
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


