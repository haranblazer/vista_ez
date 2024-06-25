<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master"
    AutoEventWireup="true" CodeFile="Recieved_PO_List.aspx.cs" Inherits="franchise_Recieved_PO_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Purchase Inv List</h4>
   <div class="row">
                        <%-- <label class="col-sm-1 control-label">From </label>--%>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <%--<label class="col-sm-1 control-label">To </label>--%>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>


                        <div class="col-sm-3">
                            <asp:TextBox ID="txt_orderno" placeholder="PO No/ PI No/ Vendor Inv No" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>


                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_Vendor" placeholder="Vendor Id/ Name" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-sm-1">
                            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                                Search
                            </button>
                            <%-- <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Search" OnClick="btnSearch_Click" />--%>
                        </div>

                    </div>

    <div class="clearfix"></div>
    <hr />
    <%--<div>
        <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="green"></asp:Label>
    </div>--%>
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>
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
        var pageUrl = '<%=ResolveUrl("Recieved_PO_List.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var Vendor = $('#<%=txt_Vendor.ClientID%>').val();
            var orderno = $('#<%=txt_orderno.ClientID%>').val();
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Vendor: "' + Vendor + '",orderno: "' + orderno + '", min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        var Invoice = '<a style="color:blue;" href="PI-Bill.aspx?id=' + data.d[i].srno + '">' + data.d[i].InvoiceNo + '</a>';

                        json.push([i + 1,
                            data.d[i].BillDate,
                            Invoice,
                            data.d[i].OrderNo,
                            data.d[i].VendorInvNo,
                            data.d[i].VendorCode,
                            data.d[i].VenderName,
                            data.d[i].Gross,
                            data.d[i].GST,
                            data.d[i].NetAmt, 
                            data.d[i].VendorInv_Date,
                            //data.d[i].SourceOfSupply,
                            //data.d[i].DestinationOfSupply,
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
                            { title: "Order Date" },
                            { title: "PI No." },
                            { title: "Order No." },
                            { title: "Vendor Inv No." },
                            { title: "Vender Code" },
                            { title: "Vender Name" },
                            { title: "Gross" },
                            { title: "GST" },
                            { title: "Net Amt" },
                            { title: "Received Date" },
                            //{ title: "Source Of Supply" },
                            //{ title: "Place of Supply" },
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

