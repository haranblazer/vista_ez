<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="SecondarySalesDetails.aspx.cs" Inherits="secretadmin_RunTour" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">
        <asp:Label ID="lbl_ReportName" runat="server"></asp:Label>Report</h4>
      <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txt_UserId" runat="server" CssClass="form-control" placeholder="Buyer User Id."></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_UserName" runat="server" CssClass="form-control" placeholder="Buyer User Name."></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_InvNo" runat="server" CssClass="form-control" placeholder="Invoice No."></asp:TextBox>
        </div>
        <div class="col-sm-1">
            <%-- <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CssClass="btn btn-primary" />--%>
            <button type="button" id="Button1" runat="server" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>

        </div>

        <%-- <div class="col-sm-1 text-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />
        </div>--%>

        <div class="clearfix"></div>
        <div class="row">
            <div class="table-responsive">
                 
                <table id="tblList_INVWISE" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
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


                <table id="tblList_DEPOWISE" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
                    <tfoot align="left">
                        <tr>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </tfoot>
                </table>


                <table id="tblList_BUYERWISE" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
                    <tfoot align="left">
                        <tr>
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
        var pageUrl = '<%=ResolveUrl("SecondarySalesDetails.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let InvNo = $('#<%=txt_InvNo.ClientID%>').val(),
                UserId = $('#<%=txt_UserId.ClientID%>').val(),
                UserName = $('#<%=txt_UserName.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ InvNo: "' + InvNo + '", UserId: "' + UserId + '", UserName: "' + UserName + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {


                        if ("<%=MasterKey%>" == "SEC_INVWISE") {
                            json.push([i + 1,
                            data.d[i].Invoice_No,
                            data.d[i].Invoice_Date,
                            //data.d[i].Seller_UserId,
                                //data.d[i].Seller_Name,

                            data.d[i].Buyer_UserId,
                            data.d[i].Buyer_Name,
                            data.d[i].Buyer_District,
                            data.d[i].Buyer_State,
                                data.d[i].NoOFProduct,

                                data.d[i].Billed_Qty,
                                data.d[i].DP_Value,
                            data.d[i].Total_Amount,
                            data.d[i].RPV,
                            data.d[i].TPV,
                            ]);
                        }
                        if ("<%=MasterKey%>" == "SEC_DEPOWISE") {
                            json.push([i + 1,
                            data.d[i].Seller_UserId,
                            data.d[i].Seller_Name,
                            data.d[i].Seller_District,
                            data.d[i].Seller_State,
                            data.d[i].Total_Amount,
                            ]);
                        }

                        if ("<%=MasterKey%>" == "SEC_BUYERWISE") {
                            json.push([i + 1,
                            data.d[i].Buyer_UserId,
                            data.d[i].Buyer_Name,
                            data.d[i].Buyer_District,
                            data.d[i].Buyer_State,
                            data.d[i].Total_Amount,
                            ]);
                        }
                    }

                   
                      

                    if ("<%=MasterKey%>" == "SEC_INVWISE") {

                        $('#tblList_INVWISE').show();
                        $('#tblList_DEPOWISE').hide();
                        $('#tblList_BUYERWISE').hide();

                        $JDT('#tblList_INVWISE').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "Invoice No" },
                                { title: "Invoice Date" },
                                //{ title: "Seller UserId" },
                                //{ title: "Seller Name" },
                                { title: "Buyer UserId" },
                                { title: "Buyer Name" },
                                { title: "Buyer District" },
                                { title: "Buyer State" },
                                { title: "NOP" },
                                { title: "Qty" },
                                { title: "DP Value" },
                                { title: "Total Amount" },
                                { title: "RPV" },
                                { title: "TPV" },
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

                                $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                                $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));

                                $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                                $(api.column(12).footer()).html(api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            }
                        });
                    }

                    if ("<%=MasterKey%>" == "SEC_DEPOWISE") {
                        $('#tblList_INVWISE').hide();
                        $('#tblList_DEPOWISE').show();
                        $('#tblList_BUYERWISE').hide();

                        $JDT('#tblList_DEPOWISE').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "Seller UserId" },
                                { title: "Seller Name" },
                                { title: "Seller District" },
                                { title: "Seller State" },
                                { title: "Total Amount" },
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
                                $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            }
                        });

                    }

                    if ("<%=MasterKey%>" == "SEC_BUYERWISE") {
                        $('#tblList_INVWISE').hide();
                        $('#tblList_DEPOWISE').hide();
                        $('#tblList_BUYERWISE').show();

                        $JDT('#tblList_BUYERWISE').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "500px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "Buyer UserId" },
                                { title: "Buyer Name" },
                                { title: "Buyer District" },
                                { title: "Buyer State" },
                                { title: "Total Amount" },
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
                                $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            }
                        });
                    }
                     
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        } 
    </script>



</asp:Content>

