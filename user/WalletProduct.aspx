<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="WalletProduct.aspx.cs" Inherits="User_WalletProduct" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product Wallet Passbook</h4>
    <div class="row">
        <div class="col-md-3 control-label">
            Product Wallet Balance
        </div>
        <div class="col-md-1 control-label">
            <asp:Label ID="lblewallet" runat="server"></asp:Label>
        </div>
        <div class="col-md-1 control-label">
            From :
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-1 control-label">
            To:
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-1">
            <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
        </div>
        <div class="col-sm-1">
        </div>
    </div>
    <hr />
    <div class="clearfix"></div>


    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%"></table>
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
        var pageUrl = '<%=ResolveUrl("WalletProduct.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                        data.d[i].doe,
                        data.d[i].Userid,
                        data.d[i].UserName,
                        data.d[i].Credit,
                        data.d[i].Debit,
                        data.d[i].Balance,
                        data.d[i].descrip,
                        data.d[i].Transactiontype,
                        data.d[i].Reason,
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
                            { title: "Date" },
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "Credit" },
                            { title: "Debit" },
                            { title: "Balance" },
                            { title: "Description" },
                            { title: "Transaction Type" },
                            { title: "Remark" },
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

