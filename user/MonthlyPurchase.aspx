<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="MonthlyPurchase.aspx.cs" Inherits="User_MonthlyPurchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Monthly Purchase Value</h4>
     <div class="row">

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_PackType" runat="server" CssClass="form-control">
               <%-- <asp:ListItem Value="3"> <%=method.PV%></asp:ListItem>
                <asp:ListItem Value="1">TPV</asp:ListItem>--%>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Amount" runat="server" CssClass="form-control" placeholder="Enter Invoice Amount." MaxLength="30"
                onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
            <%-- <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-success" OnClick="btnSearchByDate_Click" />--%>
        </div>
        <div class="col-md-4"></div>
        <div class="col-md-2 pull-right">
            <%--  <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="25px" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                Style="margin-left: 0px" Width="26px" />--%>
        </div>
    </div>

     
    <div class="clearfix"></div>
   <hr />
    <div class="table-responsive">
      <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
            <tfoot align="center">
                <tr> 
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </tfoot>
        </table>
        <%--<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"
            EmptyDataText="No Data Found" FooterStyle-Font-Bold="true" HeaderStyle-ForeColor="#ffffff"
            CssClass="table table-striped table-hover" HeaderStyle-BackColor="#fe6a00"
            PageSize="100" Width="100%" ShowFooter="True">
            <Columns>
                <asp:BoundField HeaderText="Date" DataField="Date" /> 
                <asp:BoundField HeaderText="Total Invoice Value" DataField="InvoiceValue" />
                <asp:BoundField HeaderText="Total RPV/ TPV" DataField="TotalRPV" />
            </Columns>
        </asp:GridView>--%>
    </div>
   
     <%--<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
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

    <script type="text/javascript">
        var $JDT = $.noConflict(true);
        var pageUrl = '<%=ResolveUrl("MonthlyPurchase.aspx")%>';
        $JDT(function () {
            //$.noConflict(true);
            BindTable();
        });


        function BindTable() {
            var PackType = $('#<%=ddl_PackType.ClientID%>').val();
            var Amount = $('#<%=txt_Amount.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{PackType: "' + PackType + '", Amount: "' + Amount + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i+1,
                            data.d[i].Date,
                            data.d[i].InvoiceValue,
                            data.d[i].TotalRPV,
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
                            { title: "Date" },
                            { title: "Total <%=method.Invoice_Amount%>" },
                            { title: "Total " + $('#<%=ddl_PackType.ClientID%> option:selected').text()},
                             
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };

                            // Total over all pages
                            var PPV = api.column(2).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(2).footer()).html(PPV.toFixed(2));

                            var GPV = api.column(3).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(3).footer()).html(GPV.toFixed(2));
                        }
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }
    </script>
</asp:Content>

