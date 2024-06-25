<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="StockScheme.aspx.cs" 
    Inherits="secretadmin_StockScheme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Scheme Report     </h4>
    <div class="row">
          
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                </div>
               
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-6">
                     <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                    Search
                </button>
                   <%-- <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-success" /> &nbsp; &nbsp;--%>
                   
                </div>
                   <div class="col-sm-1 col-xs-6 text-right pull-right">
        <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                        Width="25px" />--%>
        </div>
            </div>
    
    
            <div class="clearfix">
            </div>
         
            <div class="table-responsive">
                <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>
               <%-- <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="1" CssClass="table table-striped table-hover"
                    Font-Names="Arial" Font-Size="Small" PageSize="500" AutoGenerateColumns="true"
                    EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="dglst_PageIndexChanging">
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
        var pageUrl = '<%=ResolveUrl("StockScheme.aspx")%>';
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
                            data.d[i].Productcode,
                            data.d[i].ProductName,
                            data.d[i].Sold_Free_Prod,
                            data.d[i].Sold_Prod,
                            data.d[i].Sold_Amount,
                            data.d[i].Free_Stock_In,
                            data.d[i].Stock_In,
                            data.d[i].Stock_In_With_Amount, 
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
                            { title: "Product Code" },
                            { title: "Product Name" }, 
                            { title: "Sold-Free-Prod" },
                            { title: "Sold-Prod" },
                            { title: "Sold-Amount" },
                            { title: "Free-Stock-In" },
                            { title: "Stock_In" },
                            { title: "Stock-In-With-Amount" },
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


