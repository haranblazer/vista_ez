<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="FranchisePurchaseList.aspx.cs" Inherits="franchise_FranchisePurchaseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Franchise Purchase List</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">

        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-md-2 ">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>

        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txt_SalesRepId" runat="server" CssClass="form-control" placeholder="Enter Franchise Id"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="Txt_InvoiceNo" runat="server" MaxLength="30" CssClass="form-control" placeholder="Enter Invoice No."></asp:TextBox>
        </div>


        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1" Selected="True">All </asp:ListItem>
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="2">Cancelled</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Del_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1" Selected="True">All </asp:ListItem>
                <asp:ListItem Value="1">Dispatch</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="clearfix"></div>

        <div class="col-sm-11"></div>
        <div class="col-md-1 col-xs-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                Search
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


    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>



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
        var pageUrl = '<%=ResolveUrl("FranchisePurchaseList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            var SalesRepId = $('#<%=txt_SalesRepId.ClientID%>').val();
            var invoiceno = $('#<%=Txt_InvoiceNo.ClientID%>').val();
            var status = $('#<%=ddl_Status.ClientID%>').val();
            var Del_Status = $('#<%=ddl_Del_Status.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", SalesRepId: "' + SalesRepId + '", invoiceno: "' + invoiceno + '",  status: "' + status + '", Del_Status: "' + Del_Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        var InvoiceNo = '<a style="color: #727272; font-weight: bold;" href="../Common/StockTranBill.aspx?id=' + data.d[i].srno_Encode + '">' + data.d[i].InvoiceNo + '</a>';

                        var Img1Color = "style=color:blue;";
                        if (data.d[i].Slip != "")
                            Img1Color = "style=color:green;";

                        var Img2Color = "style=color:blue;";
                        if (data.d[i].Img2 != "")
                            Img2Color = "style=color:green;";

                        var Upload_lr1 = ' <a href="../images/Slip/' + data.d[i].Slip + '" data-fancybox="gallery" ' + Img1Color + '"> <i class="fa fa-eye" title="View Image 1"></i> </a>';
                        var Upload_lr2 = ' <a href="../images/Slip/' + data.d[i].Img2 + '" data-fancybox="gallery" ' + Img2Color + '"> <i class="fa fa-eye" title="View Image 2"></i> </a>';

                        json.push([i + 1,

                        data.d[i].Date,
                            InvoiceNo,
                        data.d[i].SellerUserId,
                        data.d[i].SellerName,
                        data.d[i].SellerDistrict,
                        data.d[i].SellerState,
                        data.d[i].NoOFProduct,
                        data.d[i].grossAmt,
                        data.d[i].SGST,
                        data.d[i].CGST,

                        data.d[i].IGST,
                        data.d[i].Cess,
                        data.d[i].netAmt,
                        data.d[i].CourierCharges,
                        data.d[i].Discount,

                        data.d[i].Amount,
                            /* data.d[i].TotalFPV,*/
                            "",
                        data.d[i].status == "2" ? "<span style='color:red'>Cancelled</<span>" : "<span style='color:green'>Submit</<span>",
                        data.d[i].Del_Status == "1" ? "<span style='color:green'>Delivered</<span>" : "<span style='color:red'>Pending</<span>",


                        data.d[i].EwayNo,
                        data.d[i].DispatchDate,
                        data.d[i].Tracking,
                        data.d[i].Transport,
                        data.d[i].DeliveryDate,

                        data.d[i].DurationDays,
                        data.d[i].Del_Remarks,
                        data.d[i].ConfirmWith,
                            InvoiceNo,
                        data.d[i].No_Boxes,

                        data.d[i].Weight_KG,
                        data.d[i].TotalBV,
                            Upload_lr1,
                            Upload_lr2,
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
                            { title: "Invoice No." },
                            { title: "Seller ID" },
                            { title: "Seller Name" },
                            { title: "Seller District" },
                            { title: "Seller State" },
                            { title: "No.Of Product" },
                            { title: "DP Value" },
                            { title: "SGST" },
                            { title: "CGST" },

                            { title: "IGST" },
                            { title: "Cess" },
                            { title: "DP with Tax" },
                            { title: "Courier Charges" },
                            { title: "Discount" },

                            { title: "Invoice Value" },
                            /*{ title: "FPV" },*/
                            { title: "Billing Type" },
                            { title: "Invoice Status" },
                            { title: "Dispatch Status" },

                            { title: "EWay Bill" },
                            { title: "Dispatch Date" },
                            { title: "Docket No" },
                            { title: "Transporter Name" },
                            { title: "Delivery date" },

                            { title: "Duration days" },
                            { title: "Remarks" },
                            { title: "Confirm With" },
                            { title: "Invoice No." },
                            { title: "No. Boxes" },
                            { title: "Weight KG" },

                            { title: "RPV" },

                            { title: "Img LR1" },
                            { title: "Img LR2" },


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
                            var Val1 = api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(7).footer()).html(Val1);

                            var Val2 = api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(8).footer()).html(Val2.toFixed(2));

                            var Val3 = api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(9).footer()).html(Val3.toFixed(2));

                            var Val4 = api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(10).footer()).html(Val4.toFixed(2));

                            var Val5 = api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(11).footer()).html(Val5.toFixed(2));

                            var Val6 = api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(12).footer()).html(Val6.toFixed(2));

                            var Val7 = api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(13).footer()).html(Val7.toFixed(2));

                            var Val8 = api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(14).footer()).html(Val8.toFixed(2));

                            var Val9 = api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(15).footer()).html(Val9.toFixed(2));

                            var Val10 = api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(16).footer()).html(Val10.toFixed(2));

                            var Val11 = api.column(17).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(17).footer()).html(Val11.toFixed(2));
                        }
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
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

