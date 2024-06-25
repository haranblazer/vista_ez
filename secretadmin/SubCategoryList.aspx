<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" 
    CodeFile="SubCategoryList.aspx.cs" Inherits="secretadmin_SubCategoryList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Sub Category List</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row"> 
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_isDeleted" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Active</asp:ListItem>
                <asp:ListItem Value="1">In Active</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>

        <div class="col-sm-10"></div>

        <div class="col-sm-2 text-right pull-right">
            <a href="AddSubCategory.aspx" class="btn btn-link">Add Sub Category</a>
        </div>

    </div>
    <hr />

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%"></table>
    </div>
    <div class="clearfix">
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
        var pageUrl = '<%=ResolveUrl("SubCategoryList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let isDeleted = $('#<%=ddl_isDeleted.ClientID%>').val(); 
            <%--let Category = $('#<%=ddlCategory.ClientID%>').val();--%>
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{isDeleted: "' + isDeleted + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];


                    for (var i = 0; i < data.d.length; i++) {

                        var SubCatId = data.d[i].SubCatId;
                        let imagename = '';
                        let IconImg = '';
                        let isDeleted = '';

                        var Edit = '<a target="_blank" href="AddSubCategory.aspx?id=' + SubCatId + '"><i class="fa fa-edit"></i> </a>';

                        if (data.d[i].isDeleted == "False") {
                            isDeleted = '<a href="#/" onclick="UpdateStatus(' + SubCatId + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            isDeleted = '<a href="#/" onclick="UpdateStatus(' + SubCatId + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }

                      
                        json.push([i + 1,
                            data.d[i].CatId,
                            data.d[i].SubCatId,
                            Edit,
                            isDeleted,
                            data.d[i].CatName,
                        data.d[i].SubCatName,
                           
                        data.d[i].PriorityDispaly,
                          
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
                            { title: "Sys Cat Id" },
                            { title: "Sys Sub Cat Id" },
                            { title: "Edit" },
                            { title: "Status" },
                            { title: "Category" },
                            { title: "Sub Category" },
                            { title: "Display Priority" },
                           
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,

                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }


        function UpdateStatus(SubCatId) {

            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{SubCatId: "' + SubCatId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    BindTable();
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        }

    </script>
</asp:Content>

