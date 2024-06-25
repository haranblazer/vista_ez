<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ProductWisePrimarySales.aspx.cs"
    EnableEventValidation="false" Inherits="secretadmin_ProductWisePrimarySales" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product Wise Primary Sales</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                 Search
            </button> 
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
                    <%--<th></th>
                     
                    <th></th> --%>
                </tr>
            </tfoot>
        </table>

       <%-- <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
            Font-Names="Arial" Font-Size="Small" PageSize="5000" AutoGenerateColumns="False"
            EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="GridView1_PageIndexChanging"
            FooterStyle-HorizontalAlign="Right">
            <Columns>
                <asp:TemplateField HeaderText="SNo">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Product Code" DataField="ProductCode" />
                <asp:BoundField HeaderText="Product Name" DataField="ProductName" />
                <asp:BoundField HeaderText="Purchase Qty" DataField="PurchaseQty" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Free Samples Qty" DataField="FreeSamplesQty" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Total Qty" DataField="TotalQty" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Purchase Rate" DataField="PurchaseRate" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Total Purchase value" DataField="Purchasevalue" ItemStyle-HorizontalAlign="Right" />
                <asp:BoundField HeaderText="Sales Qty" DataField="SalesQty" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Associate Rate" DataField="AssociateRate" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Sales Value" DataField="SalesValue" ItemStyle-HorizontalAlign="Right" />
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
        var pageUrl = '<%=ResolveUrl("ProductWisePrimarySales.aspx")%>';
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
                            data.d[i].ProductCode,
                            data.d[i].ProductName,
                            data.d[i].PurchaseQty,
                            data.d[i].FreeSamplesQty,
                            data.d[i].TotalQty,

                            data.d[i].PurchaseRate,
                            data.d[i].Purchasevalue,
                            data.d[i].SalesQty,
                            data.d[i].AssociateRate,
                            data.d[i].SalesValue, 
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
                            
                            { title: "Prod<br>Code" },
                            { title: "Product Name" },
                            { title: "Pur.<br>Qty" },
                            { title: "FS<br>Qty" },
                            { title: "Total<br>Qty" },

                            { title: "Pur.<br>Rate" },
                            { title: "Total<br>Pur.<br>value" },
                            { title: "<%=method.Associate%><br>Rate" },
                            { title: "Sales<br>Value" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages
                            $(api.column(3).footer()).html(api.column(3).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(4).footer()).html(api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));

                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            //$(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
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
