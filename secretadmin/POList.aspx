<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="POList.aspx.cs" Inherits="franchise_POList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Purchase Order Made</h4>
    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-md-2 ">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>

        </div>
        <div class="col-md-2 ">
            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
                <asp:ListItem Value="1">Approved</asp:ListItem>
            </asp:DropDownList>

        </div>
        <div class="col-md-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>

            <%--  <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search"
                        OnClick="btnSearch_Click" />--%>
        </div>
        <div class="col-md-2">
            <%-- <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                        Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="26px" />--%>
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
                </tr>
            </tfoot>
        </table>

        <%-- <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
                <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover"
                    AutoGenerateColumns="false" PageSize="50" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
                    DataKeyNames="invoiceno,regno,appmstid,status" OnRowCommand="GridView1_RowCommand"
                    OnRowDataBound="GridView1_RowDataBound"  
                    EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" ShowFooter="True">
                    <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField HeaderText="Invoice No." DataTextField="InvoiceNo" DataNavigateUrlFields="srno_Encript"
                            DataNavigateUrlFormatString="PO_BILL.aspx?id={0}" />
                         

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                 <asp:HiddenField ID="hnd_invoiceno" runat="server" Value='<%#Eval("invoiceno") %>' />
                                <asp:HiddenField ID="hnd_status" runat="server" Value='<%#Eval("Status") %>' />
                                <asp:Label ID="lbl_status" runat="server" Text='<%#Eval("Status_Text") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="PO Status">
                            <ItemTemplate>
                                 <asp:LinkButton ID="lnkIsPOClose" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='Status'>&nbsp;<%# Eval("Status").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:BoundField HeaderText="Buyer ID" DataField="regno" />
                        <asp:BoundField HeaderText="Buyer Name" DataField="fname" />
                        <asp:BoundField HeaderText="Seller ID" DataField="SalesRepId" />
                        <asp:BoundField HeaderText="Seller Name" DataField="SellerName" />

                        <asp:BoundField HeaderText="Bill Date" DataField="doe" />
                        
                        <asp:BoundField HeaderText="Vendor-Type" DataField="frantype" Visible="false" />
                        <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                         <asp:BoundField HeaderText="Billed Qty." DataField="Actual_Qty" />

                        <asp:BoundField HeaderText="Amount" DataField="amt" />
                        <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                        <asp:BoundField HeaderText="Tax Amount" DataField="tax" /> 
                        <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                        <asp:BoundField HeaderText="Source state" DataField="SellerState" />
                        <asp:BoundField HeaderText="Target State" DataField="PlaceOfSupply" />

                        <asp:TemplateField HeaderText="Detail">
                            <ItemTemplate>
                                
                                <span id="tblPrd" style="display: none;">
                                    <%#Eval("tbl") %>
                                </span><a href="javascript:void" style="color: Blue;">Detail</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="status" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField> 
                    </Columns>
                </asp:GridView>--%>
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
        var pageUrl = '<%=ResolveUrl("POList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            let status = $('#<%=ddl_Status.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", status: "' + status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        var inv = "'" + data.d[i].InvoiceNo + "'";

                        var InvoiceNo = '<a style="color:blue;" href="PO_BILL.aspx?id=' + data.d[i].srno_Encode + '">' + data.d[i].InvoiceNo + '</a>';
                        let Status = '';
                        if (data.d[i].Status == "1")
                            Status = '<a href="#/" onclick="UpdateStatus(' + inv + ')"><i class="fa fa-toggle-on" style="font-size:24px; color:green;"></i></a>';
                        else
                            Status = '<a href="#/" onclick="UpdateStatus(' + inv + ')"><i class="fa fa-toggle-off" style="font-size:24px; color:red"></i></a>';
                        
                        json.push([i + 1,
                            data.d[i].doe,

                            InvoiceNo,
                            Status,
                       // data.d[i].Status == "1" ? "<span style='color:green'>" + data.d[i].Status_Text + "</<span>" : "<span style='color:red'>" + data.d[i].Status_Text + "</<span>",

                          

                        data.d[i].regno,
                        data.d[i].fname,

                            data.d[i].SalesRepId,
                            data.d[i].SellerState,
                       // data.d[i].SellerName,
                       
                        data.d[i].NoOFProduct,
                        data.d[i].Actual_Qty,

                        data.d[i].grossAmt,
                        //data.d[i].amt,
                        data.d[i].tax,
                        data.d[i].netAmt,
                       
                        data.d[i].PlaceOfSupply,
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
                            { title: "Bill Date" },
                            { title: "Invoice No." },
                            { title: "Status" },
                            { title: "BuyerId" },
                            { title: "Buyer Name" },

                            { title: "SellerId" },
                           // { title: "Seller Name" },
                            { title: "Source state" },
                            { title: "NOP" },
                            { title: "Qty." },
                            { title: "Gross" },
                           // { title: "Amount" },

                            { title: "Tax Amt" },
                            { title: "Net Amt" },
                           
                            { title: "Target State" },
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
                           
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                           

                            $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(12).footer()).html(api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            
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


        function UpdateStatus(Invoice) { 
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{Invoice: "' + Invoice + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') { 
                        BindTable();
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


    </script>


</asp:Content>
