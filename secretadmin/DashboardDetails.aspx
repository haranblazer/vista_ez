<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="DashboardDetails.aspx.cs" Inherits="secretadmin_DashboardDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">
        <asp:Label ID="lbl_ReportName" runat="server"></asp:Label>
        Report</h4>

    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>

        </div>
        <div class="col-md-2 col-xs-6">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>

    </div>


    <div class="clearfix"></div>
    <div class="row">
        <div class="table-responsive">

            <table id="tblList" class="table table-striped table-hover display" style="width: 100%">
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
                        <%--<th></th>
                        <th></th>--%>
                        <%--<th></th>
                        <th></th>
                        <th></th>

                        <th></th> --%>
                    </tr>
                </tfoot>
            </table>


           <%-- <asp:GridView ID="Grid_RPV" runat="server" AllowPaging="false" CellPadding="1" CssClass="table table-striped table-hover mygrd"
                AutoGenerateColumns="false" ShowFooter="true" FooterStyle-ForeColor="Red" EmptyDataText="No Record Found."
                FooterStyle-Font-Size="X-Large" FooterStyle-Font-Bold="true" EmptyDataRowStyle-ForeColor="Red">
                <Columns>

                    <asp:TemplateField HeaderText="Invoice No">
                        <ItemTemplate><%#Eval("[Invoice No]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Invoice Date">
                        <ItemTemplate><%#Eval("[Date]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Seller UserId">
                        <ItemTemplate><%#Eval("[Seller UserId]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Seller Name">
                        <ItemTemplate><%#Eval("[Seller Name]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Seller State">
                        <ItemTemplate><%#Eval("[Seller State]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Seller District">
                        <ItemTemplate><%#Eval("[Seller District]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Buyer UserId">
                        <ItemTemplate><%#Eval("[Buyer UserId]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Buyer Name">
                        <ItemTemplate><%#Eval("[Buyer Name]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Buyer Mobile No">
                        <ItemTemplate><%#Eval("[Buyer Mobile No]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Amount">
                        <ItemTemplate><%#Eval("[Total Amount]") %> </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="DP Amount">
                        <ItemTemplate><%#Eval("[DP Amount]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Normal PV">
                        <ItemTemplate><%#Eval("[Normal PV]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Topper PV">
                        <ItemTemplate><%#Eval("[Topper PV]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sponsor ID">
                        <ItemTemplate><%#Eval("[Sponsor ID]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sponsor Name">
                        <ItemTemplate><%#Eval("[Sponsor Name]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reference Id">
                        <ItemTemplate><%#Eval("[Reference Id]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reference Name">
                        <ItemTemplate><%#Eval("[Reference Name]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tax / Sales Invoive">
                        <ItemTemplate><%#Eval("[Tax / Sales Invoive]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Billing Type">
                        <ItemTemplate><%#Eval("[Billing Type]") %> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Invoice Status">
                        <ItemTemplate><%#Eval("[Invoice Status]") %> </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>--%>

        </div>
    </div>


    <div class="clearfix">
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
        var pageUrl = '<%=ResolveUrl("DashboardDetails.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        
                        json.push([i + 1,
                            data.d[i].Invoice_No,
                            data.d[i].Date,
                            //data.d[i].Seller_UserId,
                            //data.d[i].Seller_Name,
                            //data.d[i].Seller_State,
                            //data.d[i].Seller_District,
                            data.d[i].Buyer_UserId,
                            data.d[i].Buyer_Name,
                            data.d[i].Buyer_Mobile_No,
                            data.d[i].Total_Amount,
                            data.d[i].DP_Amount,
                            data.d[i].Normal_PV,
                            data.d[i].Topper_PV,
                            data.d[i].Sponsor_ID,
                            data.d[i].Sponsor_Name,
                            //data.d[i].Reference_Id,
                            //data.d[i].Reference_Name,
                            data.d[i].Tax_Sales_Invoive,
                            data.d[i].Billing_Type,
                            data.d[i].Invoice_Status, 
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
                            { title: "#" },
                            { title: "Invoice No" },
                            { title: "Invoice Date" },
                            //{ title: "Seller UserId" },
                            //{ title: "Seller Name" },
                            //{ title: "Seller State" },
                            //{ title: "Seller District" },
                            { title: "Buyer UserId" },
                            { title: "Buyer Name" },
                            { title: "Buyer Mobile_No" },

                            { title: "Total Amount" },
                            { title: "DP Amount" }, 
                            { title: "Normal PV" },
                            { title: "Topper PV" },
                            { title: "Sponsor ID" },
                            { title: "Sponsor Name" },
                            //{ title: "Reference Id" },
                            //{ title: "Reference Name" },
                            { title: "Tax/Sales Invoive" },
                            { title: "Billing Type" },

                            { title: "Invoice Status" }, 
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
                            $(api.column(1).footer()).html("Total:");
                          
                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                        }
                    });
                },
                error: function (result) {
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

