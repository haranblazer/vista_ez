<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="FranchisesStockStatement.aspx.cs" Inherits="secretadmin_FranchisesStockStatement" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Franchise Stock Statement</h4>
   <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>


    <div class="form-group card-group-row row">
        <div class="col-sm-2" style="display: none;">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddltype" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_userid" runat="server" CssClass="form-control" placeholder="Enter Franchise Id"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                 Search
            </button>
            <%-- <asp:Button ID="btn_Search" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btn_Search_Click" />--%>
        </div>
        <%-- <div class="col-sm-2">
            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="images/excel.gif"
                OnClick="imgbtnExcel_Click" />
            <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />
        </div>--%>
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
                   <%-- <th></th>--%>
                </tr>
            </tfoot>
        </table>


        <%-- <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
            AutoGenerateColumns="false" PageSize="50"
            Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
            EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="SNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>



                <asp:TemplateField HeaderText="Franchise ID">
                    <ItemTemplate>
                        <%#Eval("[Franchise ID]") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Franchise Name">
                    <ItemTemplate>
                        <%#Eval("[Franchise Name]") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="State" HeaderText="State" />
                <asp:BoundField DataField="District" HeaderText="District" />
                <asp:TemplateField HeaderText="Mobile No">
                    <ItemTemplate>
                        <%#Eval("Mobile No") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Type" HeaderText="Type" />


                <asp:TemplateField HeaderText="DP Value">
                    <ItemTemplate>
                        <%#Eval("DPValue") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GST Value">
                    <ItemTemplate>
                        <%#Eval("GSTValue") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Associate Value">
                    <ItemTemplate>
                        <%#Eval("AssociateValue") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="RPV" HeaderText="RPV" />
                <asp:BoundField DataField="TPV" HeaderText="TPV" />

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
        var pageUrl = '<%=ResolveUrl("FranchisesStockStatement.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                FranType = $('#<%=ddltype.ClientID%>').val(),
                FranchiseID = $('#<%=txt_userid.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", FranType: "' + FranType + '", FranchiseID: "' + FranchiseID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                        data.d[i].Franchise_ID,
                        data.d[i].Franchise_Name,
                        data.d[i].State,
                        data.d[i].District,
                        data.d[i].Mobile_No,
                        data.d[i].Type,
                        data.d[i].DPValue,
                        data.d[i].GSTValue,
                        data.d[i].AssociateValue,
                        data.d[i].RPV,
                        //data.d[i].TPV,
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
                            { title: "Franchise ID" },
                            { title: "Franchise Name" },
                            { title: "State" },
                            { title: "District" },
                            { title: "Mobile No" },
                            { title: "Fran Type" },
                            { title: "DP Value" },
                            { title: "GST Value" },
                            { title: "Associate Value" },
                            { title: "<%=method.PV%>" },
                           // { title: "TPV" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages
                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(2));
                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
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

