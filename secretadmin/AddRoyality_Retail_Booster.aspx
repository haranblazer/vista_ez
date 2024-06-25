<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="AddRoyality_Retail_Booster.aspx.cs" Inherits="AddRoyality_Retail_Booster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Loyalty Retail Booster Offer Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-md-8"></div>
        <div class="col-md-4 ">
            <a href="AddRoyality_Retail_Booster_Details.aspx" class="btn btn-link pull-right">Add Loyalty Retail Booster Offer</a>
        </div>
    </div>
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

                </tr>
            </tfoot>
        </table>

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
        var pageUrl = '<%=ResolveUrl("AddRoyality_Retail_Booster.aspx")%>';
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

                        var MId = "'" + data.d[i].MId + "'";
                        let Edit = '<a href="AddRoyality_Retail_Booster_Details.aspx?Mid=' + data.d[i].MId + '" style="color: blue; font-weight: bold;"><i class="fa fa-edit"></i> </a>';
                        var ACTV_DEACT = '';

                        if (data.d[i].IsActive == "1") {
                            ACTV_DEACT = '<a href="javascript:Void()" onclick="ACTV_DEACT(' + MId + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            ACTV_DEACT = '<a href="javascript:Void()" onclick="ACTV_DEACT(' + MId + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }

                        json.push([i + 1,
                            Edit,
                            ACTV_DEACT,
                        data.d[i].StartDate,
                        data.d[i].EndDate,
                        data.d[i].BV_Point,
                        data.d[i].MaxRoyalty,
                        data.d[i].RoyaltyType,
                            ACTV_DEACT,
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
                            { title: "Edit" },
                            { title: "ACTV./DEACT." },
                            { title: "Start Date" },
                            { title: "Exp Date" },
                            { title: "Invoice <br>value(Rs)" },
                            { title: "Max Loyalty <br> in month" },
                            { title: "Loyalty Offer" },
                           
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


        function ACTV_DEACT(MId) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/ACTV_DEACT',
                data: '{MId: "' + MId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        BindTable();
                    }
                    else {
                        alert(data.d);
                    }
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        } 
    </script>
    
     <style>
        .dotGreen {
            height: 25px;
            width: 25px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 25px;
            width: 25px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>


</asp:Content>
