<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="BatchList.aspx.cs" Inherits="secretadmin_BatchList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Product Batch List</h4>					
				</div>

  
    <div class=" panel">

        <div class="form-group">
            <div class="col-sm-2">
                Select Product :<span style="color: Red">*</span>
            </div>
            <div class="col-sm-4">
                <asp:DropDownList ID="ddlproductname" runat="server" CssClass="form-control" onchange="BindTable();">
                </asp:DropDownList>
            </div>
            <div class="col-sm-4"></div>
            <div class="col-sm-2 col-xs-6 text-right">
                <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif" OnClick="imgbtnExcel_Click" />--%>
            </div>
        </div>
        <div class="clearfix">
        </div>
     

        <div class="table-responsive">

            <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%"></table>

         
        </div>



        <div class="clearfix"></div>
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
        var pageUrl = '<%=ResolveUrl("BatchList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var pid = $('#<%=ddlproductname.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{pid: "' + pid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                            data.d[i].ProductCode,
                            data.d[i].productname,
                            data.d[i].BatchNo,
                            data.d[i].Batchdate,
                            data.d[i].ExpiryDate,

                            data.d[i].MRP,
                            data.d[i].Total_DP,
                            data.d[i].Total_DPWithTax,
                           // data.d[i].DpStock,
                           // data.d[i].DpStockWithTax,

                           //data.d[i].PORate,
                           //data.d[i].POWithTax,
                           //data.d[i].Tax + '%',
                           //data.d[i].BVAmt,
                           //data.d[i].pbvamt,

                           //data.d[i].FPV,
                           //data.d[i].APV,
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
                            { title: "P Code" },
                            { title: "P Name" },
                            { title: "BatchNo" },
                            { title: "Mfg" },
                            { title: "Expiry" },
                            { title: "MRP" },
                            { title: "DP Rate" },
                            { title: "DP With Tax" },
                            //{ title: "Franchise Sale" },
                            //{ title: "Franchise Sale With Tax" },
                            //{ title: "PO DP Rate" },
                            //{ title: "PO Billing Rate" },
                            //{ title: "GST" },
                            //{ title: "TPV" },
                            //{ title: "RPV" },
                            //{ title: "FPV" },
                            //{ title: "APV" },
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


    <%-- <script type="text/javascript">
        var GridId = "<%=dglst.ClientID %>";
        var ScrollHeight = 400;
        window.onload = function () {
            debugger;
            var grid = document.getElementById(GridId);
            var gridWidth = grid.offsetWidth;
            var gridHeight = grid.offsetHeight;
            var headerCellWidths = new Array();
            for (var i = 0; i < grid.getElementsByTagName("TH").length; i++) {
                headerCellWidths[i] = grid.getElementsByTagName("TH")[i].offsetWidth;
            }
            grid.parentNode.appendChild(document.createElement("div"));
            var parentDiv = grid.parentNode;

            var table = document.createElement("table");
            for (i = 0; i < grid.attributes.length; i++) {
                if (grid.attributes[i].specified && grid.attributes[i].name != "id") {
                    table.setAttribute(grid.attributes[i].name, grid.attributes[i].value);
                }
            }
            table.style.cssText = grid.style.cssText;
            table.style.width = gridWidth + "px";
            table.appendChild(document.createElement("tbody"));
            table.getElementsByTagName("tbody")[0].appendChild(grid.getElementsByTagName("TR")[0]);
            var cells = table.getElementsByTagName("TH");

            var gridRow = grid.getElementsByTagName("TR")[0];
            for (var i = 0; i < cells.length; i++) {
                var width;
                if (headerCellWidths[i] > gridRow.getElementsByTagName("TD")[i].offsetWidth) {
                    width = headerCellWidths[i];
                }
                else {
                    width = gridRow.getElementsByTagName("TD")[i].offsetWidth;
                }
                cells[i].style.width = parseInt(width) + "px";
                gridRow.getElementsByTagName("TD")[i].style.width = parseInt(width) + "px";
            }
            parentDiv.removeChild(grid);

            var dummyHeader = document.createElement("div");
            dummyHeader.appendChild(table);
            parentDiv.appendChild(dummyHeader);
            var scrollableDiv = document.createElement("div");
            if (parseInt(gridHeight) > ScrollHeight) {
                gridWidth = parseInt(gridWidth) + 17;
            }
            scrollableDiv.style.cssText = "overflow:auto;height:" + ScrollHeight + "px;width:" + gridWidth + "px";
            scrollableDiv.appendChild(grid);
            parentDiv.appendChild(scrollableDiv);
        }
    </script>
    <style>
        .table {
            margin-bottom: 0px;
            border: #000;
        }

        th {
            border: none;
        }
    </style>--%>
</asp:Content>

