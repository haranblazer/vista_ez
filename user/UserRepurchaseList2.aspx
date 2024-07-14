<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="UserRepurchaseList2.aspx.cs" Inherits="user_UserRepurchaseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Monthly Payout</h4>
    </div>


    <div class="row" style="display: none;">
        <div class="col-sm-3">
            <asp:DropDownList ID="ddl_Payout_Fillter" runat="server" CssClass="form-control">
                <asp:ListItem Selected="True" Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Payout</asp:ListItem>
                <asp:ListItem Value="0">Hold Payout</asp:ListItem>
                <asp:ListItem Value="2">Release Payout</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="Label2" runat="server"></asp:Label>
        </div>
    </div>


    <div class="table-responsive">
        <table cellpadding="0" width="100%" cellspacing="0" class="table table-striped table-hover display dataTable no-footer"
            style="margin-top: 10px;">
            <tr>
                <th class="tatoal_ba">Total Amount
                </th>
                <th id="Th1" runat="server" class="tatoal_ba">TDS Amount
                </th>
                <th class="tatoal_ba">Admin Charges
                </th>
                <th class="tatoal_ba">Dispatched Amount
                </th>
                <th class="tatoal_ba">Hold Amount
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
                    <asp:Label ID="lbl_HoldAmt" runat="server" Text="0" Font-Bold="True"></asp:Label>
                </td>
            </tr>
        </table>
        <div class="col-md-12">
            <p>
                <span class="label label-default " style="background-color: #fff; color: Black;">Dispatched
                                        Payout</span> <span style="background-color: #ffebea; color: Black;" class="label label-default ">Hold Payout</span> <span class="label label" style="background-color: #e2fbd7; color: Black;">Release Payout </span>
            </p>
        </div>
        <div class="clearfix"></div>

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
        var pageUrl = '<%=ResolveUrl("UserRepurchaseList2.aspx")%>';
        $JDT(function () {
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
                    for (var i = 0; i < data.d.length; i++) {

                        var Statement = '<a stye="color:blue;" target="_blank" href="../secretadmin/payoutstatementreport.aspx?n=' + data.d[i].payoutno_Encode + '&id=' + data.d[i].Regno_Encode + '&uid=' + data.d[i].Appmstid_Encode + '"><i class="fa fa-print"></i></a>';

                        json.push([i + 1,
                        data.d[i].payoutno,
                        data.d[i].PayoutStatus,
                        data.d[i].ReleaseAmt,
                        data.d[i].Paymenttodate,
                        data.d[i].PPV,
                            data.d[i].GPV,
                            data.d[i].Matched,
                            data.d[i].Inc1,
                            data.d[i].Inc2,
                            data.d[i].Inc3,
                            data.d[i].Inc4,
                            data.d[i].Inc5,
                            data.d[i].Inc6,
                            data.d[i].Inc7, 
                        //data.d[i].TPV,
                        //data.d[i].PGPV,
                        //data.d[i].FSI,
                        //data.d[i].LB,
                             
                        ////zm
                        ////data.d[i].StaterFund,
                        ////data.d[i].DepthAmt,
                        //data.d[i].zm,
                        //data.d[i].TF,
                        //data.d[i].CF,
                        //data.d[i].HF,
                        //data.d[i].PR,
                        //data.d[i].PB,
                        //data.d[i].RB,
                        ///*data.d[i].BF,*/
                        //data.d[i].GrowthAmt,

                        //data.d[i].directamt,
                        //data.d[i].PF,
                        //data.d[i].OI3,
                        //data.d[i].OI4,
                        //data.d[i].MG1,
                        //data.d[i].MG2,
                        //data.d[i].MG3,
                        //data.d[i].MG4,
                        data.d[i].Total_Income,
                        data.d[i].TDS,

                        data.d[i].PC,
                        data.d[i].Dispatch_Amount,
                        data.d[i].Remark,
                            data.d[i].bankstatus == "2" ? "<span style='color:grean;'>Approved </span>" : "<span style='color:red;'>Pending</span>",
                            Statement,

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
                            { title: "SNo." },

                            { title: "Payout No" },
                            { title: "Status" },
                            { title: "Release <br> Amt" },
                            { title: "Payout <br>Date" },
                            { title: "<%=method.PV%>" },
                            { title: "<%=method.GBV%>" },
                            { title: "Matched" },
 

                            { title: "Startup<br>Club Bonus" },
                            { title: "Achievers <br>Club Bonus" },
                            { title: "Star<br>Club Bonus" },
                            { title: "Prime <br>Club Bonus" },
                            { title: "Unicorn<br> Club Bonus" },
                            { title: "Royalty<br>Club Bonus" },
                            { title: "Self Purchase<br>Bonus" },



                            //{ title: "TPV" },
                            //{ title: "PGPV" },
                            //{ title: "Repurchase<br>Bonus" },
                            //{ title: "Organizer<br>Bonus" },

                            ////{ title: "Starter <br>Fund" },
                            ////{ title: "2WF" },
                            //{ title: "Flagship<br>Bonus" },
                            //{ title: "Travel<br>Fund" },
                            //{ title: "Car<br>Fund" },
                            //{ title: "House<br>Fund" },
                            //{ title: "Diamond<br>Directors<br>Club Bonus" },
                            //{ title: "Double<br>Diamond<br>Directors<br>Club Bonus" },
                            //{ title: "Gold Directors<br>Club Bonus" },
                            ///*{ title: "BLDF" },*/
                            //{ title: "Ambassadors<br>Club Bonus" },


                            //{ title: "Diamond Booster<br> Fund" },
                            //{ title: "Super 20 Booster <br>Fund" },
                            //{ title: "Super 4 Booster <br>Fund" },
                            //{ title: "GRP Booster <br>Fund" },
                            //{ title: "DDAR" },
                            //{ title: "BDAR" },
                            //{ title: "BDAR" },
                            //{ title: "CAAR" },
                            { title: "Total <br>Income" },
                            { title: "TDS" },

                            { title: "Admin<br>Charges" },
                            { title: "Dispatch <br>Amount" },
                            { title: "Bank KYC" },
                            { title: "Bank <br>Verification" },
                            { title: "Print" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            //    // Total over all pages

                            var Val = api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(5).footer()).html(Val.toFixed(2));

                            var Val = api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(6).footer()).html(Val.toFixed(2));

                            var Val = api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(7).footer()).html(Val.toFixed(2));

                            var Val = api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(8).footer()).html(Val.toFixed(2));

                            var Val = api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(9).footer()).html(Val.toFixed(2));

                            var Val = api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(10).footer()).html(Val.toFixed(2));

                            
                            var Val = api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(11).footer()).html(Val.toFixed(2));

                            var Val = api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(12).footer()).html(Val.toFixed(2));

                            var Val = api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(13).footer()).html(Val.toFixed(2));
                            var Val = api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(14).footer()).html(Val.toFixed(2));

                            var Val = api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(15).footer()).html(Val.toFixed(2));
                            var Val = api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(16).footer()).html(Val.toFixed(2));
                            var Val = api.column(17).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(17).footer()).html(Val.toFixed(2));
                            var Val = api.column(18).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(18).footer()).html(Val.toFixed(2));

                           

                        }
                    });
                },
                error: function (result) { alert('1'); alert(result); }
            });
        }
    </script>


</asp:Content>
