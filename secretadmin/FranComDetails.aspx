<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="FranComDetails.aspx.cs" Inherits="secretadmin_FranComDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>--%>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Franchise Commission Details</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
        </div>


        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
            <div class="clearfix">
            </div>
        </div>



        <div class="col-sm-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
            <%-- &nbsp; &nbsp;
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                        Width="25px" />--%>
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
                </tr>
            </tfoot>
        </table>



        <%-- <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover"
            EmptyDataText="Record not found." EmptyDataRowStyle-ForeColor="Red" AllowPaging="True"
            OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="50" AllowSorting="true">
            <Columns>

                <asp:TemplateField HeaderText="Invoive Number">
                    <ItemTemplate><%# Eval("[Invoive Number]")%> </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Date">
                    <ItemTemplate><%# Eval("Date")%> </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="FPV">
                    <ItemTemplate><%# Eval("FPV")%> </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="APV">
                    <ItemTemplate><%# Eval("APV")%> </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Commission on FPV">
                    <ItemTemplate><%# Eval("[Commission on FPV]")%> </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Commission on APV">
                    <ItemTemplate><%# Eval("[Commission on APV]")%> </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="franchise Type">
                    <ItemTemplate><%# Eval("FranchiseType")%> </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>--%>
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
        var pageUrl = '<%=ResolveUrl("FranComDetails.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val());

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                        data.d[i].Invoive_Number,
                        data.d[i].Date,
                        data.d[i].FPV,
                        data.d[i].APV,

                        data.d[i].Commission_on_FPV,
                        data.d[i].Commission_on_APV,
                        data.d[i].FranchiseType,
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
                            { title: "Invoive Number" },
                            { title: "Date" },
                            { title: "FPV" },
                            { title: "APV" },
                            { title: "Commission on FPV" },
                            { title: "Commission on APV" },
                            { title: "Franchise Type" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        //"footerCallback": function (row, data, start, end, display) {
                        //    var api = this.api(), data;

                        //    // Remove the formatting to get integer data for summation
                        //    var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                        //    // Total over all pages

                        //    $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                        //    $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));

                        //}
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

