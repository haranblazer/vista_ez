<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ReturnSalesList.aspx.cs" Inherits="secretadmin_ReturnSalesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <h4 class="fs-20 font-w600  me-auto float-left mb-0">Sales Return List</h4>
     <div class="row">
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_FromId" runat="server" CssClass="form-control" placeholder="Enter From (Franchise Id)"></asp:TextBox>
                        </div>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_ToId" runat="server" CssClass="form-control" placeholder="Enter To (Franchise Id)"></asp:TextBox>
                        </div>
                        <div class="col-sm-1 col-xs-6 text-left">
                            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                                Search
                            </button>

                            <%-- <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Search"
                OnClick="btnSearch_Click" />--%>
                        </div>

                        <div class="col-sm-1 col-xs-6 text-right pull-right">
                            <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif"
                OnClick="imgbtnExcel_Click" />--%>
                        </div>
                    </div>




    <hr />

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
            <tfoot align="center">
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

        <%-- <asp:GridView AllowPaging="true" ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover mygrd"
                EmptyDataText="No Data Found" PageSize="100" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" DataKeyNames="InvoiceNo"
                ShowFooter="True">
                <Columns>
                    <asp:TemplateField HeaderText="SNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                        <FooterTemplate>Total:</FooterTemplate>
                    </asp:TemplateField>
                     <asp:BoundField HeaderText="Date" DataField="Doe" /> 
                    <asp:HyperLinkField DataNavigateUrlFields="srno_Encript" HeaderText="Stock Transfer No."
                        DataTextField="InvoiceNo" DataNavigateUrlFormatString="../Common/ReturnInv.aspx?id={0}" />
                    <asp:BoundField HeaderText="From (Franchise ID)" DataField="SellerUserId" />
                    <asp:BoundField HeaderText="From (Franchise Name)" DataField="SellerName" />
                    <asp:BoundField HeaderText="To (Franchise ID)" DataField="BuyerUserId" />
                    <asp:BoundField HeaderText="To (Franchise Name)" DataField="BuyerName" />
                     
                    <asp:BoundField HeaderText="No of Products" DataField="ProdCount" />
                     <asp:BoundField HeaderText="Billed Qty." DataField="Actual_Qty" />
                    <asp:BoundField HeaderText="DP Value after Discount" DataField="DP" />
                    <asp:BoundField HeaderText="SGST" DataField="SGST" />
                    <asp:BoundField HeaderText="CGST" DataField="CGST" />
                    <asp:BoundField HeaderText="IGST" DataField="IGST" />
                    <asp:BoundField HeaderText="DP with Tax" DataField="DPWithTax" />
                    <asp:BoundField HeaderText="Courier Charges" DataField="Courier_Charges" />
                    <asp:BoundField HeaderText="Invoice Value" DataField="InvoiceValue" />
                    <asp:BoundField HeaderText="Invoice Status" DataField="StatusText" />
                    <asp:BoundField HeaderText="Dispatch Status" DataField="Dispatch_Status" />
                     <asp:BoundField HeaderText="Payment Mode" DataField="PayMode" />
                    <asp:BoundField HeaderText="PAN" DataField="PAN" />
                    <asp:BoundField HeaderText="GSTN" DataField="GSTN" />
                    <asp:BoundField HeaderText="Dispatch Date" DataField="Dispatch_Date" />
                    <asp:BoundField HeaderText="Dispatch Details" DataField="Dispatch_Details" />
                    <asp:HyperLinkField DataNavigateUrlFields="srno_Encript" HeaderText="Print" ControlStyle-CssClass="fa fa-print"
                        ItemStyle-HorizontalAlign="Center" DataNavigateUrlFormatString="../Common/ReturnInv.aspx?id={0}" />
                    <asp:BoundField HeaderText="Action" />

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

    <%-- Table Js and css  --%>
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

        var pageUrl = '<%=ResolveUrl("ReturnSalesList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var Regno = $('#<%=txt_ToId.ClientID%>').val();
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            var Sessionid = $('#<%=txt_FromId.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: pageUrl + '/DataTable',
                data: '{Regno: "' + Regno + '", min: "' + min + '", max: "' + max + '", Sessionid: "' + Sessionid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var T_NoOFProduct = 0, T_Actual_Qty = 0, T_DP = 0, T_SGST = 0, T_CGST = 0, T_IGST = 0, T_CourierCharges = 0, T_DPWithTax = 0;
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        var Invoice = '<a href="../Common/ReturnInv.aspx?id=' + data.d[i].srno_Encript + '" style="color: #727272; font-weight: bold;">' + data.d[i].InvoiceNo + '</a>';
                        var Print = '<a href="../Common/ReturnInv.aspx?id=' + data.d[i].srno_Encript + '" style="color: #727272; font-weight: bold;"> <i class="fa fa-print" aria-hidden="true"></i> </a>';

                        T_NoOFProduct = parseInt(T_NoOFProduct) + parseInt(data.d[i].NoOFProduct);
                        T_Actual_Qty = parseInt(T_Actual_Qty) + parseInt(data.d[i].Actual_Qty);
                        T_DP = parseFloat(T_DP) + parseFloat(data.d[i].DP);
                        T_SGST = parseFloat(T_SGST) + parseFloat(data.d[i].SGST);
                        T_CGST = parseFloat(T_CGST) + parseFloat(data.d[i].CGST);
                        T_IGST = parseFloat(T_IGST) + parseFloat(data.d[i].IGST);
                        T_DPWithTax = parseFloat(T_DPWithTax) + parseFloat(data.d[i].DPWithTax);
                        T_CourierCharges = parseFloat(T_CourierCharges) + parseFloat(data.d[i].CourierCharges);



                        json.push([i + 1,
                        data.d[i].Date,
                            Invoice,
                        data.d[i].SellerUserId,
                        data.d[i].SellerName,
                        data.d[i].BuyerUserId,
                        data.d[i].BuyerName,
                        '<div style="text-align:center;">' + data.d[i].NoOFProduct + '</div>',
                        '<div style="text-align:center;">' + data.d[i].Actual_Qty + '</div>',
                        '<div style="text-align:right;">' + data.d[i].DP + '</div>',
                        '<div style="text-align:right;">' + data.d[i].SGST + '</div>',
                        '<div style="text-align:right;">' + data.d[i].CGST + '</div>',
                        '<div style="text-align:right;">' + data.d[i].IGST + '</div>',
                        '<div style="text-align:right;">' + data.d[i].DPWithTax + '</div>',
                        '<div style="text-align:right;">' + data.d[i].Courier_Charges + '</div>',

                        data.d[i].InvoiceValue,
                        data.d[i].StatusText,
                        data.d[i].Dispatch_Status,
                        data.d[i].PayMode,
                        data.d[i].PAN,
                        data.d[i].GSTN,
                        data.d[i].Dispatch_Date,
                        data.d[i].Dispatch_Details,
                            Print,
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
                            { title: "Date" },
                            { title: "Stock Transfer No." },

                            { title: "From (Franchise ID)" },
                            { title: "From (Franchise Name)" },
                            { title: "To (Franchise ID)" },
                            { title: "To (Franchise Name)" },
                            { title: "No of Prod" },
                            { title: "Billed Qty." },
                            { title: "DP Value after Discount" },

                            { title: "SGST" },
                            { title: "CGST" },
                            { title: "IGST" },
                            { title: "DP with Tax" },
                            { title: "Courier Charges" },
                            { title: "Invoice Value" },
                            { title: "Invoice Status" },
                            { title: "Dispatch Status" },

                            { title: "Payment Mode" },
                            { title: "PAN" },
                            { title: "GSTN" },
                            { title: "Dispatch Date" },
                            { title: "Dispatch Details" },
                            { title: "Print" },

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) {
                                return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0;
                            };

                            // Total over all pages
                            $(api.column(1).footer()).html('Total:');

                            //$(api.column(12).footer()).html(T_NoOFProduct.toFixed(0));
                            //$(api.column(13).footer()).html(T_Actual_Qty.toFixed(0));
                            //$(api.column(14).footer()).html(T_grossAmt.toFixed(2));
                            //$(api.column(15).footer()).html(T_SGST.toFixed(2));
                            //$(api.column(16).footer()).html(T_CGST.toFixed(2));
                            //$(api.column(17).footer()).html(T_IGST.toFixed(2));

                            //$(api.column(18).footer()).html(T_Amt.toFixed(2));
                            //$(api.column(19).footer()).html(T_CourierCharges.toFixed(2));
                            //$(api.column(20).footer()).html(T_netAmt.toFixed(2));
                            //$(api.column(21).footer()).html(T_BV.toFixed(2));
                            //$(api.column(22).footer()).html(T_PV.toFixed(2));

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

