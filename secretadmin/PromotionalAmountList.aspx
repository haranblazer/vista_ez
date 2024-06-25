<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="PromotionalAmountList.aspx.cs" Inherits="secretadmin_PromotionalAmountList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Promotional Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-md-9"></div>
        <div class="col-md-3">
            <a href="AddPromotionAmt.aspx" class="btn btn-link pull-right">Add Promotional Amount</a>
        </div>
    </div>
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%"></table>
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
        var pageUrl = '<%=ResolveUrl("PromotionalAmountList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        let Edit = '<a href="AddPromotionAmt.aspx?Mid=' + data.d[i].MId + '" style="color: blue; font-weight: bold;"><i class="fa fa-edit"></i> </a>';
                        json.push([i + 1,
                            Edit,
                        data.d[i].Doe,
                        data.d[i].CurrentDate,
                        data.d[i].UserId,
                        data.d[i].UserName,

                        data.d[i].AppMstMobile,
                        data.d[i].AppMstState,
                        data.d[i].distt,
                        data.d[i].Amount,
                        data.d[i].Remark,
                        data.d[i].AdminId
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
                            { title: "<i class='fa fa-edit'></i>" },
                            { title: "Current Date" },
                            { title: "Given Date" },
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "Mobile" },
                            { title: "State" },
                            { title: "District" },
                            { title: "Amount" },
                            { title: "Remark" },
                            { title: "Update By" },
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
    </script>


</asp:Content>

