<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="LoyaltyReport.aspx.cs" Inherits="secretadmin_LoyaltyReport" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Loyalty Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_userid" runat="server" CssClass="form-control" placeholder="Enter User Id." MaxLength="30"></asp:TextBox>
        </div>

        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
            <%--<asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-primary"
                OnClick="btnSearchByDate_Click" />--%>
        </div>
       <%-- <div class="col-sm-1 pull-right">
            <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                OnClick="imgbtnExcel_Click" />
        </div>--%>
    </div>
    <hr />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>

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
        var pageUrl = '<%=ResolveUrl("LoyaltyReport.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {

            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                Regno = $('#<%=txt_userid.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{min: "' + min + '", max: "' + max + '", Regno: "' + Regno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                        data.d[i].Date,
                        data.d[i].AppMstRegNo,
                        data.d[i].AppMstFName,
                        data.d[i].LoyalityInc,
                        data.d[i].NoOfQualfy,
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
                            { title: "Date" },
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Loyalty Income" },
                            { title: "No Of Qualify" },
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
