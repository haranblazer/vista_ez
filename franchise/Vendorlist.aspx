<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="Vendorlist.aspx.cs" Inherits="secretadmin_Vendor_list" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">All Vendor </h4>
    <div class="row">
        <div class="col-sm-4">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search By Vendor Id or Name"></asp:TextBox>
        </div>
        <div class="col-sm-2 col-xs-6">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-2 col-xs-6 pull-right text-right">
            <a href="AddVendor.aspx" class="btn btn-link">Add Vendor</a>
        </div>
        <div class="col-sm-2 col-xs-6 pull-right text-right">
        </div>
    </div>
    <div class="clearfix"></div>
    <hr />

    <div class="table-responsive">
        <table id="tblList" class="display" style="width: 100%"></table>
    </div>
    <div class="clearfix">
    </div>

    <div id="divProductcode" style="display: none;" runat="server"></div>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script> var $J = $.noConflict(true); </script>
    <script type="text/javascript">
        $J(function () {
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
            $J('#<%=txtSearch.ClientID%>').autocomplete({ source: Productcode });
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
        var pageUrl = '<%=ResolveUrl("Vendorlist.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var Search = $('#<%=txtSearch.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Search: "' + Search + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var Action = '<a href="AddVendor.aspx?n=' + data.d[i].VID_Encode + '" style="color:blue;"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>';
                        json.push([i + 1,
                            Action,
                        data.d[i].V_regNo,
                        data.d[i].ComName,
                        //data.d[i].DisplayName,
                        data.d[i].V_Email,
                        data.d[i].Phone,
                        data.d[i].vendoraddress,
                        data.d[i].GSTNAME,
                        data.d[i].PAYABLES,

                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "400px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "#", },
                            { title: "Edit" },
                            { title: "Vendor Id" },
                            { title: "Vendor Name" },
                            //{ title: "Company Name" },
                            { title: "Email" },
                            { title: "Work Phone" },
                            { title: "<div style='width:450px;'> Address </div>" },
                            { title: "GST No" },
                            { title: "Payables" },

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
