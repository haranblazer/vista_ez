<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="BatchList.aspx.cs" Inherits="secretadmin_BatchList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="accordion accordion-rounded-stylish accordion-bordered" id="accordion-eleven">
        <div class="accordion-item mb-0 row">
            <div class="col-md-6">
                 <div class="accordion-header rounded-lg collapsed" id="accord-11One" data-bs-toggle="collapse" data-bs-target="#collapse11One" aria-controls="collapse11One" aria-expanded="false" role="button">
                <span class="accordion-header-icon"></span> 
                <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product List</h4>
                <span class="fa fa-sort-desc plus float-left"></span>
                </div>
            </div>
            <%-- <div class="col-md-6">
                <div class="pull-right ">
                    <div>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-word-o me-2"></i>Word</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-excel-o me-2"></i>Excel</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-pdf-o me-2"></i>PDF</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-print me-2"></i>Print</a>
                    </div>
                </div>
            </div>--%>
            <div class="clearfix"></div>
             <div id="collapse11One" class="accordion__body collapse" aria-labelledby="accord-11One" data-bs-parent="#accordion-eleven" style="">
            <div class="accordion-body-text">
                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label">
                        Select Product :<span style="color: Red">*</span>
                    </div>
                    <div class="col-sm-4">
                        <asp:DropDownList ID="ddlproductname" runat="server" CssClass="form-control" onchange="BindTable()">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-4">
                        <%-- <input type="button" value="Search" onclick="BindTable()" class="btn btn-success" />--%>
                    </div>
                    <div class="col-sm-2"></div>
                </div>
            </div>
             </div>
        </div>
    </div>
    <div class="clearfix"></div>
 
    <div class="table-responsive">
        <table id="tblList" class="display" style="width: 100%"></table>

        <%-- <asp:GridView ID="dglst" runat="server" AutoGenerateColumns="False" EmptyDataText="Record not found."
            CssClass="table table-striped table-hover table-bordered verticle-middle dataTable no-footer" Width="100%" ShowFooter="false">
            <Columns>
                <asp:TemplateField HeaderText="SNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Product">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" Width="150" Height="100" ImageUrl='<%#Eval("ImageName")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ProductCode" HeaderText="Code"></asp:BoundField>
                <asp:BoundField DataField="productname" HeaderText="Name"></asp:BoundField>
                <asp:BoundField DataField="MRP" HeaderText="MRP"></asp:BoundField>
                <asp:BoundField DataField="DPWithTax" HeaderText="Associate Rate"></asp:BoundField>
                <asp:BoundField DataField="pbvamt" HeaderText="RPV"></asp:BoundField>
                <asp:BoundField DataField="BVAmt" HeaderText="TPV"></asp:BoundField>
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
    <script type="text/javascript">
        var $JDT = $.noConflict(true);
        var pageUrl = '<%=ResolveUrl("BatchList.aspx")%>';
        $JDT(function () {
            //$.noConflict(true);
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
                            data.d[i].ImageName,
                            data.d[i].ProductCode,
                            data.d[i].productname,
                            data.d[i].MRP,
                            data.d[i].DPWithTax,
                            data.d[i].pbvamt,
                            data.d[i].BVAmt,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "350px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            {
                                 title: "Product",
                                 render: function (data, type, full, meta) {
                                     return '<img class="avatar-img rounded-circle" width="50" src="' + data + '" />';
                                 }
                             },

                            { title: "Code" },
                            { title: "Name" },
                            { title: "MRP" },
                            { title: "Associate Rate" },
                            { title: "RPV" },
                            { title: "TPV" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 10,
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

