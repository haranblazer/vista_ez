<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="ProductStock.aspx.cs" Inherits="admin_ProductStock" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Stock Summary Report</h4>
    <div class="row">
        <div class="col-sm-1 ">
            <label class="control-label">
                Franchise</label>
        </div>
        <div class="col-sm-4">
            <asp:DropDownList ID="ddl_RoleWise" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2 col-xs-6">
          <%--  <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search"
                OnClick="btnSearch_Click" />--%>
            <button type="button" title="Search" class="btn btn-success" onclick="BindTable()">Search</button>
        </div>


      <%--  <div class="col-md-6 col-xs-6" style="text-align: right;">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="25px" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                Style="margin-left: 0px" Width="26px" />
        </div>--%>
    </div>


    <hr />



    <div class="table-responsive">
          <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
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
                </tr>
            </tfoot>
        </table>


      <%--  <asp:GridView ID="Grdreport" CssClass="table table-striped table-hover" AutoGenerateColumns="false"
            runat="server" OnRowCommand="Grdreport_RowCommand" ShowFooter="true" DataKeyNames="Pid">
            <Columns>
              
                <asp:BoundField DataField="Pid" HeaderText="Code" />
                <asp:TemplateField HeaderText="Product Name" ItemStyle-Width="300">
                    <ItemTemplate>
                        <asp:Label ID="lblPName" runat="server" Text='<%#Eval("ProductName")%>' Width="180px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Opening" HeaderText="Op Bal" ItemStyle-HorizontalAlign="Right" />

                <asp:TemplateField HeaderText="TI">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_TI" runat="server" Text='<%# Eval("ItemIn")%>' CommandName="TI" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="GRN">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_GRN" runat="server" Text='<%# Eval("GRN")%>' CommandName="GRN" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sales">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_Sales" runat="server" Text='<%# Eval("Sold")%>' CommandName="Sales" Style="color: red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Packed">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_Packed" runat="server" Text='<%# Eval("Packed")%>' CommandName="Packed" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Packed Using">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_PackedUsing" runat="server" Text='<%# Eval("PackedUsing")%>' CommandName="PackedUsing" Style="color: red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Un Packed">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_UnPacked" runat="server" Text='<%# Eval("UnPacked")%>' CommandName="UnPacked" Style="color: red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Un Packed Items">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_UnPackedItems" runat="server" Text='<%# Eval("UnPackedItems")%>' CommandName="UnPackedItems" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

 
                <asp:TemplateField HeaderText="TO">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_ItemOut" runat="server" Text='<%# Eval("ItemOut")%>' CommandName="ItemOut" Style="color: red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Issued">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_Issued" runat="server" Text='<%# Eval("Issued")%>' CommandName="Issued" Style="color: red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="From Item Adj">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_FromItemAdj" runat="server" Text='<%# Eval("FromItemAdj")%>' CommandName="FromItemAdj" Style="color: red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
 
                <asp:TemplateField HeaderText="To Item Adj">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_ToItemAdj" runat="server" Text='<%# Eval("ToItemAdj")%>' CommandName="ToItemAdj" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sales Return">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_SalesReturn" runat="server" Text='<%# Eval("SalesReturn")%>' CommandName="SalesReturn" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="RTV">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_RTV" runat="server" Text='<%# Eval("RTV")%>' CommandName="RTV" Style="color: black;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Balance">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_Balance" runat="server" Text='<%# Eval("BalQty")%>' CommandName="Balance" Style="color: green;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                 
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
        var pageUrl = '<%=ResolveUrl("ProductStock.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {

            var UserId = $('#<%=ddl_RoleWise.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ UserId: "' + UserId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        var Pid = "'" + data.d[i].Pid + "'";
                        json.push([ 
                            data.d[i].Pid, 
                            data.d[i].ProductName,

                           // data.d[i].Opening,
                            '<a href="#/" onclick="Details(' + Pid + ',11)" style="color:blue;">' + data.d[i].ItemIn + '</a>',
                            '<a href="#/" onclick="Details(' + Pid + ',15)" style="color:blue;">' + data.d[i].GRN + '</a>',
                            '<a href="#/" onclick="Details(' + Pid + ',12)" style="color:blue;">' + data.d[i].Sold + '</a>',
                            //data.d[i].Packed,
                            //data.d[i].PackedUsing,
                            //data.d[i].UnPacked,
                            //data.d[i].UnPackedItems,
                            '<a href="#/" onclick="Details(' + Pid + ',14)" style="color:blue;">' + data.d[i].ItemOut + '</a>',
                            '<a href="#/" onclick="Details(' + Pid + ',16)" style="color:blue;">' + data.d[i].Issued + '</a>',
                            //data.d[i].FromItemAdj,
                            //data.d[i].ToItemAdj,
                            '<a href="#/" onclick="Details(' + Pid + ',13)" style="color:blue;">' + data.d[i].SalesReturn + '</a>',
                           // data.d[i].RTV,
                            '<a href="#/" onclick="Details(' + Pid + ',0)" style="color:blue;">' + data.d[i].BalQty+'</a>',
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
                         
                            { title: "Code" },
                            { title: "Product Name" },
                            //{ title: "Op Bal" },
                            { title: "TI" },
                            { title: "GRN" },

                            { title: "Sales" },
                            //{ title: "Packed" },
                            //{ title: "Packed Using" },
                            //{ title: "Un Packed" },
                            //{ title: "Un Packed Items" },

                            { title: "TO" },
                            { title: "Issued" },
                            //{ title: "From Item Adj" },
                            //{ title: "To Item Adj" },
                            { title: "Sales Return" },
                            //{ title: "RTV" },
                            { title: "Balance" }, 
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            //    // Total over all pages
                            $(api.column(1).footer()).html('Total:');
                            $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                        }
                    });
 
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }

        function Details(Pid, Typ) {
            var UserId = $('#<%=ddl_RoleWise.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Details',
                data: '{Pid: "' + Pid + '", Typ: "' + Typ + '", UserId: "' + UserId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    window.open("TotalIn.aspx?pid=" + data.d.Pid + "&typ=" + data.d.Typ + "&u=" + data.d.UserId , '_blank');
                    //window.location = "TotalIn.aspx?pid=" + data.d.Pid + "&typ=" +data.d.Typ;
                    // Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("13"));
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

    </script>

</asp:Content>
