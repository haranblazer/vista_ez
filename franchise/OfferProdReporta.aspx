<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" 
    CodeFile="OfferProdReporta.aspx.cs" Inherits="franchise_OfferProdReporta" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Offer Product Report </h4>
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
                <asp:TextBox ID="txt_BuyerId" runat="server" CssClass="form-control" placeholder="Enter BuyerId"></asp:TextBox>

            </div>

            <div class="col-sm-1 col-xs-6">
                <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                Search
            </button>
               <%-- <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-success" />
                &nbsp; &nbsp;--%>
                  
            </div>
            <div class="col-sm-1 col-xs-6 text-right pull-right">
               <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />--%>
            </div>
        </div>

    <hr />
        <div class="clearfix">
        </div>
        
        <div class="table-responsive">
             <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

           <%-- <asp:GridView  ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover mygrd"
                EmptyDataText="No Data Found" PageSize="100" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" 
                OnRowCommand="GridView1_RowCommand" DataKeyNames="Srno, OFFERID" ShowFooter="True" AllowPaging="true">
                <Columns>
                    <asp:TemplateField HeaderText="SNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                   								 		
                    <asp:BoundField HeaderText="Date" DataField="Date" />
                     <asp:BoundField HeaderText="Invoice Number" DataField="InvoiceNumber" />
                     <asp:BoundField HeaderText="Invoice Amount" DataField="InvoiceAmount" />
                     <asp:BoundField HeaderText="SellerID" DataField="SellerID" />
                     <asp:BoundField HeaderText="Seller Name" DataField="SellerName" />
                     <asp:BoundField HeaderText="BuyerID" DataField="BuyerID" /> 
                     <asp:BoundField HeaderText="Buyer Name" DataField="BuyerName" />
                     <asp:BoundField HeaderText="Billing Type" DataField="BillingType" />
                     <asp:BoundField HeaderText="Product code" DataField="Productcode" /> 
                     <asp:BoundField HeaderText="Product Name" DataField="ProductName" />
                     <asp:BoundField HeaderText="Product Qty" DataField="ProductQty" />
                     <asp:TemplateField HeaderText="Dispatch">
                         <ItemTemplate>
                             <asp:LinkButton ID="btn_Dispatch" runat="server" Text='<%# Eval("DispatchStatus").ToString() == "0" ? "Dispatch" : "Dispatched"%>' 
                             Enabled='<%#Eval("DispatchStatus").ToString()=="0" ? true : false %>' 
                             CssClass='<%#Eval("DispatchStatus").ToString()=="0" ? "btn btn-success btn-sm" : "btn btn-success disabled btn-sm" %>'
                             CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Dispatch"
                                 OnClientClick="return confirm('Are you sure you want to proceed？')"/>
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
            var pageUrl = '<%=ResolveUrl("OfferProdReporta.aspx")%>';
            $JDT(function () {
                BindTable();
            });


            function BindTable() {
                var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
                var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
                var SoldTo = $('#<%=txt_BuyerId.ClientID%>').val();
                $.ajax({
                    type: "POST",
                    url: pageUrl + '/BindTable',
                    data: '{min: "' + min + '", max: "' + max + '", SoldTo: "' + SoldTo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var json = [];
                        for (var i = 0; i < data.d.length; i++) { 
                            json.push([i + 1,
                                 data.d[i].Date,
                                 data.d[i].InvoiceNumber,
                                 data.d[i].InvoiceAmount,
                                 data.d[i].SellerID,
                                 data.d[i].SellerName,
                                 data.d[i].BuyerID, 
                                 data.d[i].BuyerName,
                                 data.d[i].BillingType,
                                 data.d[i].Productcode,
                                 data.d[i].ProductName,
                                 data.d[i].ProductQty, 
                                 data.d[i].DispatchStatus == '1' ? '<input type="button" value="Dispatched" class="btn btn-primary disabled">' : '<a href="#/" onclick="Fn_Dispatched(' + data.d[i].srno + ',' + data.d[i].OFFERID + ')" class="btn btn-success">Dispatch</a>',

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
                                { title: "SNo" },

                                { title: "Date" },
                                { title: "Invoice Number" },
                                { title: "<%=method.Invoice_Amount%>" },
                                { title: "Seller ID" },
                                { title: "Seller Name" },
                                { title: "Buyer ID" },
                                { title: "Buyer Name" },
                                { title: "Billing Type" },
                                { title: "Product code" },
                                { title: "Product Name" },
                                { title: "Product Qty" },
                                { title: "Dispatch" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": 15,
                            "bDestroy": true,

                        });
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }


            function Fn_Dispatched(srno, OFFERID) {
                var TransferTo = $('#txt_Transfer' + srno).val();
                $.ajax({
                    type: "POST",
                    url: pageUrl + '/Dispatched',
                    data: '{srno: "' + srno + '", OFFERID: "' + OFFERID + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == '1') {
                            alert("Offer dispatch save successfully.!!");
                            BindTable();
                        } else {
                            alert("This user not in your downline.!!");
                            return
                        }
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

