<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="PO-Received.aspx.cs" Inherits="franchise_PO_Received" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Purchase Order Received</h4>
      <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">

        <div class="col-md-2">

            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txt_PO" runat="server" CssClass="form-control" placeholder="Enter PO."
                MaxLength="20"></asp:TextBox>
        </div>
       
         <div class="col-md-2">
            <asp:DropDownList ID="ddl_POType" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">PO Type All</asp:ListItem>
                <asp:ListItem Value="0">Normal</asp:ListItem>
                <asp:ListItem Value="1">Offer</asp:ListItem>
            </asp:DropDownList>
        </div>
         <div class="col-md-2">
            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">PO Status All</asp:ListItem>
                <asp:ListItem Selected="True" Value="0">Pending</asp:ListItem>
                <asp:ListItem Value="1">Closed</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-2 col-xs-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <hr />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
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
                </tr>
            </tfoot>
        </table>
    </div>


    <div class="clearfix">
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
            var pageUrl = '<%=ResolveUrl("PO-Received.aspx")%>';
            $JDT(function () {
                BindTable();
            });


            function BindTable() {
                var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
                var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
                var Status = $('#<%=ddl_Status.ClientID%>').val(); 
                var PO = $('#<%=txt_PO.ClientID%>').val();
                var POType = $('#<%=ddl_POType.ClientID%>').val();
                $('#LoaderImg').show();
                $.ajax({
                    type: "POST",
                    url: pageUrl + '/BindTable',
                    data: '{min: "' + min + '", max: "' + max + '", Status: "' + Status
                        + '", PO: "' + PO + '", POType: "' + POType + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $('#LoaderImg').hide();
                        var json = [];

                        for (var i = 0; i < data.d.length; i++) {
                            var InvoiceNo = '<a style="color:blue;" href="PO.aspx?id=' + data.d[i].srno + '">' + data.d[i].InvoiceNo + '</a>';
                            var inv = "'" + data.d[i].InvoiceNo + "'";
                            var TransferTo = '<input type="text" css="form-control" style="width:80px;" id="txt_Transfer' + data.d[i].srno + '"/>';

                            json.push([i + 1,
                               InvoiceNo,
                               data.d[i].IsOffer == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>",
                               data.d[i].Status == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>",
                                data.d[i].Status == '1' ? '<input type="text" css="form-control disabled" readonly style="width:80px;" id="txt_Transfer' + data.d[i].srno + '"/>' : '<input type="text" css="form-control" style="width:80px;" id="txt_Transfer' + data.d[i].srno + '"/>',
                               data.d[i].Status == '1' ? '<input type="button" value="Transfer" class="btn btn-success disabled">' : '<a href="#/" onclick="POTransfer(' + inv + ',' + data.d[i].srno + ')" class="btn btn-success">Transfer</a>',
                               data.d[i].regno,
                               data.d[i].fname,
                               data.d[i].doe,
                               data.d[i].NoOFProduct,
                               data.d[i].amt,
                               data.d[i].grossAmt,
                               data.d[i].tax,
                               data.d[i].netAmt,
                               //data.d[i].SellerState,
                               //data.d[i].PlaceOfSupply,
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

                                { title: "PO No." },
                                { title: "Offer" },
                                { title: "PO<br> Close" },
                                { title: "Transfer <br>To" },
                                { title: "PO<br> Transfer" },
                                { title: "Seller<br> ID" },
                                { title: "Seller Name" },
                                { title: "Bill<br> Date" },
                                { title: "NOP" },

                                { title: "Amount" },
                                { title: "Gross" },
                                { title: "Tax<br> Amount" },
                                { title: "Net<br> Amount" },
                                //{ title: "Source state" },
                                //{ title: "Target State" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,
                            "footerCallback": function (row, data, start, end, display) {
                                var api = this.api(), data;

                                // Remove the formatting to get integer data for summation
                                var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                                $(api.column(1).footer()).html('Total:');
                                // Total over all pages 
                                $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                                $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(12).footer()).html(api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(13).footer()).html(api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            }
                        });
                    },
                    error: function (result) {
                        $('#LoaderImg').hide();
                        alert(result);
                    }
                });
            }


            function POTransfer(Invoice, srno) {
                var TransferTo = $('#txt_Transfer' + srno).val();
                $.ajax({
                    type: "POST",
                    url: pageUrl + '/UpdateTransferTo',
                    data: '{Invoice: "' + Invoice + '", TransferTo: "' + TransferTo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == '1') {
                            alert("Successfuly Transfer This Record.!!");
                            BindTable();
                        } else {
                            alert(data.d);
                            return
                        }
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


    <style type="text/css">
        .dotGreen {
            height: 18px;
            width: 18px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 18px;
            width: 18px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>
</asp:Content>


