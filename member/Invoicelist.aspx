<%@ Page Title="" Language="C#" MasterPageFile="~/member/member.master" AutoEventWireup="true" CodeFile="Invoicelist.aspx.cs" Inherits="member_Invoicelist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <h4 class="fs-20 font-w600  me-auto float-left mb-0"> Invoice List</h4>

    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_DispatchStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All Invoice</asp:ListItem>
                <asp:ListItem Value="1">Dispatched</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="InvoiceNo" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="0">Cancelled</asp:ListItem>
                <asp:ListItem Value="1">Confirmed</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button> 
        </div>
        <div class="col-md-1 pull-right d-none" style="text-align: right;">
           
        </div>
    </div>


    <div class="clearfix">
    </div>
    <hr />
   
    <div class="table-responsive">
       <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
            <tfoot align="center">
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
        var pageUrl = '<%=ResolveUrl("Invoicelist.aspx")%>';
        $JDT(function () {
            // $.noConflict(true);
            BindTable();
        });


        function BindTable() {

            var SponsorId = $('#<%=txtSearch.ClientID%>').val(),
                min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                Del_Status = $('#<%=ddl_DispatchStatus.ClientID%>').val(),
                status = $('#<%=ddlStatus.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: pageUrl + '/BindInvoice',
                data: '{SponsorId: "' + SponsorId + '", min: "' + min + '", max: "' + max + '", status: "' + status
                    + '", Del_Status: "' + Del_Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        let InvUrl = '';
                        if (data.d[i].Billtype == '4' || data.d[i].Billtype == '6')  {
                            InvUrl = 'LR_Invoice';
                        }
                        else {
                            InvUrl = 'Invoice';
                        }
                        var Invoice = '<a href="../Common/' + InvUrl + '.aspx?id=' + data.d[i].srno_Encript + '" style="color: #727272; font-weight: bold;">' + data.d[i].InvoiceNo + '</a>';


                        //var Invoice = '<a href="../Common/Invoice.aspx?id=' + data.d[i].srno_Encript + '" style="color: #727272; font-weight: bold;">' + data.d[i].InvoiceNo + '</a>';

                        json.push([i + 1,
                        data.d[i].Date,
                            Invoice,
                        data.d[i].NoOFProduct,
                        data.d[i].Actual_Qty,
                        data.d[i].grossAmt,
                        data.d[i].SGST,
                        data.d[i].CGST,
                        data.d[i].IGST,
                        data.d[i].Cess,
                        data.d[i].Amt,

                        data.d[i].Discount,
                        data.d[i].CourierCharges,
                        data.d[i].NetAmt,
                        //data.d[i].BV,
                            data.d[i].PV,
                          //  data.d[i].WalletAmount,
                          //  data.d[i].secondaryAmount,

                       // data.d[i].InvoiceType,
                       // data.d[i].Subdistype,

                        data.d[i].status == "0" ? "<span style='color:red'>Cancelled </span>" : "Submit",
                        data.d[i].Del_Status == "0" ? "<span style='color:red'>Pending</span>" : "Delivered",

                        data.d[i].PayMode,
                        data.d[i].DispatchDate,
                        data.d[i].Transport,
                        data.d[i].Tracking,
                        data.d[i].EWayBill,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'print'],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            { title: "Date" },
                            { title: "Invoice No." },
                            { title: "No of Prod" },
                            { title: "Billed Qty." },
                            { title: "MRP" },
                            { title: "SGST" },
                            { title: "CGST" },
                            { title: "IGST" },
                            { title: "Cess" },
                            { title: "MRP with Tax" },

                            { title: "Discount" },
                            { title: "Courier Charges" },
                            { title: "<%=method.Invoice_Amount%>" },
                            //{ title: "TPV" },
                            { title: "" + '<%=method.PV%>' },
                           // { title: "Wallet <br> Amount" },
                           // { title: "Secondary <br> Amount" },
                            /*{ title: "Invoice Type" },*/
                           // { title: "Billing Type" },
                            { title: "Invoice Status" },
                            { title: "Dispatch Status" },

                            { title: "Payment Mode" },
                            { title: "Dispatch Date" },
                            { title: "Transport" },
                            { title: "Tracking" },
                            { title: "EWay Bill" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) {
                                return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0;
                            };

                            // Total over all pages
                            var NoofProducts = api.column(3).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(3).footer()).html(NoofProducts);

                            var BilledQty = api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(4).footer()).html(BilledQty);

                            var DPValue = api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(5).footer()).html(DPValue.toFixed(2));

                            var SGST = api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(6).footer()).html(SGST.toFixed(2));

                            var CGST = api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(7).footer()).html(CGST.toFixed(2));

                            var IGST = api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(8).footer()).html(IGST.toFixed(2));

                            var Cess = api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(9).footer()).html(Cess.toFixed(2));

                            var DPwithTax = api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(10).footer()).html(DPwithTax.toFixed(2));

                            var Discount = api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(11).footer()).html(Discount.toFixed(2));

                            var CourierCharges = api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(12).footer()).html(CourierCharges.toFixed(2));

                            var InvoiceValue = api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(13).footer()).html(InvoiceValue.toFixed(2));

                            //var TPV = api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            //$(api.column(14).footer()).html(TPV.toFixed(2));

                            var RPV = api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(14).footer()).html(RPV.toFixed(2));

                            //$(api.column(15).footer()).html(api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            //$(api.column(16).footer()).html(api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
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

