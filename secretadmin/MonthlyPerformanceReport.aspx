<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="MonthlyPerformanceReport.aspx.cs" Inherits="secretadmin_MonthlyPerformanceReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Monthly Performance Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">
        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddl_Month" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_FranType" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Active" CssClass="form-control" runat="server">
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="0">Deactive</asp:ListItem>
                <asp:ListItem Value="-1">All</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Franchiseid" runat="server" CssClass="form-control" placeholder="Enter Franchise Id."> </asp:TextBox>
        </div>
        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>

            <%-- <asp:Button ID="btn_search" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btn_search_Click" />--%>
        </div>
        <%-- <div class="col-sm-1">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />
        </div>
        <div class="col-sm-2  pull-right">
            <asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                <asp:ListItem>100</asp:ListItem>
                <asp:ListItem>500</asp:ListItem>
                <asp:ListItem>All</asp:ListItem>
            </asp:DropDownList>
        </div>--%>
    </div>




    <div class="table-responsive" style="padding-bottom: 10px;">
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
                </tr>
            </tfoot>
        </table>


        <%--  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover"
            EmptyDataText="Record not found." EmptyDataRowStyle-ForeColor="Red" AllowPaging="True"
            OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="50" ShowFooter="true" FooterStyle-Font-Bold="true">
            <Columns>
                <asp:TemplateField HeaderText="SNo">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Month" DataField="Month"></asp:BoundField>
                <asp:BoundField HeaderText="FranchiseId" DataField="FranchiseId"></asp:BoundField>
                <asp:BoundField HeaderText="Franchise Name" DataField="FranchiseName"></asp:BoundField>
                <asp:BoundField HeaderText="District" DataField="District"></asp:BoundField>
                <asp:BoundField HeaderText="State" DataField="State"></asp:BoundField>
                <asp:BoundField HeaderText="Mobile" DataField="Mobile"></asp:BoundField>
                <asp:BoundField HeaderText="Purchase" DataField="PurchaseValue"></asp:BoundField>
                <asp:BoundField HeaderText="Associate Sales" DataField="AssociateSalesValue"></asp:BoundField>
                <asp:BoundField HeaderText="Franchise Sales" DataField="FranchiseSalesValue"></asp:BoundField>
                <asp:BoundField HeaderText="Closing Stock" DataField="ClosingStock"></asp:BoundField>
                <asp:BoundField HeaderText="Commission" DataField="CommissionGenerated"></asp:BoundField> 
            </Columns>
        </asp:GridView>--%>
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
        var pageUrl = '<%=ResolveUrl("MonthlyPerformanceReport.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let Month = $('#<%=ddl_Month.ClientID%>').val(),
                FranType = $('#<%=ddl_FranType.ClientID%>').val(),
                Active = $('#<%=ddl_Active.ClientID%>').val(),
                Franchiseid = $('#<%=txt_Franchiseid.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ Month: "' + Month + '", FranType: "' + FranType + '", Active: "' + Active + '", Franchiseid: "' + Franchiseid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1, 
                        data.d[i].Month,
                        data.d[i].FranchiseId,
                        data.d[i].FranchiseName,
                        data.d[i].District,
                        data.d[i].State,
                        data.d[i].Mobile,
                        data.d[i].PurchaseValue,
                        data.d[i].AssociateSalesValue,
                        data.d[i].FranchiseSalesValue,
                        data.d[i].ClosingStock,
                        data.d[i].CommissionGenerated,
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
                            { title: "Month" },
                            { title: "F Id" },
                            { title: "Fran Name" },
                            { title: "District" },
                            { title: "State" },
                            { title: "Mobile" },
                            { title: "Purchase" },
                            { title: "Asso. <br> Sales" },
                            { title: "Fran <br> Sales" },
                            { title: "Closing <br> Stock" },
                            { title: "COMM." },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
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

