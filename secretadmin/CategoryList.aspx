<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="CategoryList.aspx.cs" Inherits="secretadmin_CategoryList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Category List</h4>
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

        <div class="col-sm-7"></div>

        <div class="col-sm-2">
            <a href="AddEditCategory.aspx" class="btn btn-link">Add Category</a>
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
        var pageUrl = '<%=ResolveUrl("CategoryList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let isDeleted = $('#<%=ddl_isDeleted.ClientID%>').val();

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

                        var CatId = data.d[i].CatId;
                        let imagename = '';
                        let IconImg = '';
                        let isDeleted = '';

                        var Edit = '<a target="_blank" href="AddEditCategory.aspx?id=' + CatId + '"><i class="fa fa-edit"></i> </a>';

                        if (data.d[i].isDeleted == "False") {
                            isDeleted = '<a href="#/" onclick="UpdateStatus(' + CatId + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            isDeleted = '<a href="#/" onclick="UpdateStatus(' + CatId + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }

                        imagename = '<a href="../images/product/icon/' + data.d[i].imagename + '" data-fancybox="gallery"> <img src="../images/product/icon/' + data.d[i].imagename + '" alt="img" Width="120px" Height="75px">  </a>';

                        IconImg = '<a href="../images/product/icon/' + data.d[i].IconImg + '" data-fancybox="gallery"> <img src="../images/product/icon/' + data.d[i].IconImg + '" alt="img" Width="85px" Height="85px">  </a>';

                        json.push([i + 1,
                            data.d[i].CatId,
                            Edit,
                            isDeleted,
                        data.d[i].CatName,
                            imagename,
                            IconImg,
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
                            { title: "Edit" },
                            { title: "Status" },
                            { title: "Category Name" },
                            { title: "Banner Img" },
                            { title: "Icon Img" },
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


        function UpdateStatus(CatId) {

            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{CatId: "' + CatId + '"}',
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

    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
</asp:Content>

