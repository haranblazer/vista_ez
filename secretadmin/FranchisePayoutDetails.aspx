<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="FranchisePayoutDetails.aspx.cs" Inherits="secretadmin_FranchisePayoutDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Franchise Payout Details</h4>
    <div class="row">
        <div class="col-md-4">
            <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_Franchiseid" runat="server" CssClass="form-control" MaxLength="20" placeholder="Franchise Id"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_FranType" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>

       
    </div>



    <hr />
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

        var pageUrl = '<%=ResolveUrl("FranchisePayoutDetails.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let payoutno = $('#<%=ddlDateRange.ClientID%>').val(),
                Franchiseid = $('#<%=txt_Franchiseid.ClientID%>').val(),
                FranType = $('#<%=ddl_FranType.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ payoutno: "' + payoutno + '", Franchiseid: "' + Franchiseid + '", FranType: "' + FranType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                        data.d[i].Franchise_ID,
                        data.d[i].Franchise_Name,
                        data.d[i].Franchise_Type,
                        data.d[i].PAN,
                        data.d[i].Bank,
                        data.d[i].Branch,
                        data.d[i].Account_No,
                        data.d[i].IFSC_Code,
                        data.d[i].FPV,
                        data.d[i].APV,

                        data.d[i].Commission_on_FPV,
                        data.d[i].Commission_on_APV,
                        data.d[i].Stock_Value_as_on_5th_Day,
                        data.d[i].Opening_Amount,
                        data.d[i].Maintainance_Expenses,
                        data.d[i].Offer_Income,
                        data.d[i].Total_Commission,
                        data.d[i].TDS,
                        data.d[i].Dispatch_Amount,
                        data.d[i].FromDate,

                        data.d[i].ToDate,
                        data.d[i].PayoutNo,

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
                            { title: "Franchise Id" },
                            { title: "Franchise Name" },
                            { title: "Franchise Type" },
                            { title: "PAN" },
                            { title: "Bank" },
                            { title: "Branch" },
                            { title: "Account No" },
                            { title: "IFSC Code" },
                            { title: "FPV" },
                            { title: "APV" },

                            { title: "Commission on FPV" },
                            { title: "Commission on APV" },
                            { title: "Stock Value as on 5th Day" },
                            { title: "Opening Amount" },
                            { title: "Maintainance Expenses" },
                            { title: "Offer Income" },
                            { title: "Total Commission" },
                            { title: "TDS" },
                            { title: "Dispatch Amount" },
                            { title: "FromDate" },

                            { title: "ToDate" },
                            { title: "PayoutNo" },

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages

                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(12).footer()).html(api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(13).footer()).html(api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));

                            $(api.column(14).footer()).html(api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(15).footer()).html(api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(16).footer()).html(api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(17).footer()).html(api.column(17).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(18).footer()).html(api.column(18).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(19).footer()).html(api.column(19).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));

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
