<%@ Page Title="Payout List" Language="C#" AutoEventWireup="true" EnableEventValidation="false"
    MasterPageFile="MasterPage.master" CodeFile="PayoutList.aspx.cs"
    Inherits="admin_PayoutList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Payout List</h4>

    <div class="row">
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_Payout_Fillter" runat="server" CssClass="form-control">
                <asp:ListItem Selected="True" Value="-1">All Payout</asp:ListItem>
                <asp:ListItem Value="1">Dispatch & Release</asp:ListItem>
                <asp:ListItem Value="0">Hold Payout</asp:ListItem>
                <asp:ListItem Value="2">Release</asp:ListItem>

            </asp:DropDownList>
        </div>
        <div class="col-md-3">
            <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>

        <div class="col-md-2">
            <asp:DropDownList ID="ddl_BankWallet" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="0">Bank</asp:ListItem>
                <asp:ListItem Value="1">Wallet</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-3">
        </div>
        <div class="col-md-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>

    </div>


    <hr />



    <div class="table-responsive" id="trGrid" runat="server">



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

        var pageUrl = '<%=ResolveUrl("PayoutList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let payoutno = $('#<%=ddlDateRange.ClientID%>').val(),
                BankWallet = $('#<%=ddl_BankWallet.ClientID%>').val(),
                iselegible = $('#<%=ddl_Payout_Fillter.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ payoutno: "' + payoutno + '", BankWallet: "' + BankWallet + '", iselegible: "' + iselegible + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                        data.d[i].Payout_Date,
                        '<a href="adminpaymentreport.aspx?n=' + data.d[i].Encode_Payout + '&id=' + data.d[i].Encode_Userid + '"  class="btn btn-link"  style="padding: 0.175rem 0.687rem !important;" target="_blank">' + data.d[i].appmstregno + '</a>',
                        data.d[i].User_Name,

                        data.d[i].Status,
                        data.d[i].Release_Amt,
                        data.d[i].Release_Paouyt,
                        data.d[i].Mobile,
                        data.d[i].PAN,
                        data.d[i].Bank,

                        data.d[i].Branch,
                        data.d[i].Account_No,
                        data.d[i].IFSC_Code,

                        //data.d[i].Opening_Counts,
                        //data.d[i].Closing_Counts,
                        //data.d[i].Match_Count,

                        data.d[i].PBV,
                        data.d[i].Self_Help_Qualified == "1" ? "<div style='color:green;'>Yes</div>" : "<div style='color:red;'>No</div>",
                        data.d[i].RoyaltyAmt,
                        data.d[i].binaryamt,



                        data.d[i].Total_Payout,
                        data.d[i].TDS,
                        data.d[i].PC_Charges,

                        data.d[i].Dispatch_Amount,
                        data.d[i].Payout_Status,
                        data.d[i].ID_Status,
                        data.d[i].Bank_Details,
                            //data.d[i]._500_PPV,
                            //data.d[i].Left_Topper,
                            //data.d[i].Right_Topper,

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
                            { title: "Payout Date" },
                            { title: "User Id" },
                            { title: "User Name" },

                            { title: "Status" },
                            { title: "Release <br> Amt" },
                            { title: "Release <br> Paouyt" },
                            { title: "Mobile" },
                            { title: "PAN" },
                            { title: "Bank" },

                            { title: "Branch" },
                            { title: "Account No" },
                            { title: "IFSC Code" },

                            { title: "First Purch." },
                            
                            { title: "Self Help Club <br>Bonus Qualified" },
                            { title: "Active <br>Bonus" },
                            { title: "Self Help <br>Club Bonus" },
                            { title: "Total <br> Payout" },
                            { title: "TDS" },
                            { title: "PC <br> Charges" },

                            { title: "Dispatch <br> Amount" },
                            { title: "Payout <br> Status" },
                            { title: "ID <br> Status" },
                            { title: "Bank <br> Details" },
                            //{ title: "500 <br> PPV" },
                            //{ title: "Left <br> Topper" },
                            //{ title: "Right <br> Topper" },

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages

                            // $(api.column(13).footer()).html(api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(14).footer()).html(api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(15).footer()).html(api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(16).footer()).html(api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(17).footer()).html(api.column(17).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(18).footer()).html(api.column(18).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(19).footer()).html(api.column(19).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(20).footer()).html(api.column(20).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                        }
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }

    </script>

</asp:Content>
