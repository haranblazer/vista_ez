<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="PriceList.aspx.cs" Inherits="User_PriceList" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Price List</h4>
    <div class="row">
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-sm-3">
            <asp:TextBox ID="txt_Barcode" runat="server" CssClass="form-control" placeholder="Select Product..."></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-1">
        </div>
    </div>

    <hr />
    <div class="clearfix"></div>

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

    </div>
    <div id="divProductcode" style="display: none;" runat="server"></div>

    <script src="assets/js/jquery.autocomplete.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script type="text/javascript">
        var $JA = $.noConflict(true);
        $JA(function () {
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
            $JA('#<%=txt_Barcode.ClientID%>').autocomplete({ source: Productcode });
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
    <script type="text/javascript">
        var $JDT = $.noConflict(true);
        var pageUrl = '<%=ResolveUrl("PriceList.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {
            var CatId = $('#<%=ddlCategory.ClientID%>').val();
            var ProductName = $('#<%=txt_Barcode.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{CatId: "' + CatId + '", ProductName: "' + ProductName + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                        data.d[i].CatName,
                        data.d[i].ProductCode,
                        data.d[i].ProductName,
                        data.d[i].MRP,
                        data.d[i].AP,
                        data.d[i].RPV,
                       // data.d[i].TPV,
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
                            { title: "Cat Name" },
                            { title: "Product Code" },
                            { title: "Product Name" },
                            { title: "MRP" },
                            { title: "DP" },
                            { title: "" + '<%=method.PV%>' },
                            //{ title: "TPV" },
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
    </script>
</asp:Content>


