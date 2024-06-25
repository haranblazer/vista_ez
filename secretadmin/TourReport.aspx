<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="TourReport.aspx.cs" Inherits="secretadmin_TourReport" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Event Tour Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
        </div>
        <div class="col-md-2 d-none">
            <asp:DropDownList ID="ddl_Tour"  runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txt_userid" runat="server" CssClass="form-control" placeholder="Enter User Id." MaxLength="30"></asp:TextBox>
        </div>

        <div class="col-md-2">
             <a href="ScanCode.aspx" class="btn btn-primary" target="_blank">Manual Scan</a>
        </div>
        <div class="col-md-2">
            <a href="ScanCodeNew.aspx" class="btn btn-primary" target="_blank">Auto Scan</a>
        </div>

    </div>
    <div class="row">

        <div class="col-md-4">
            <asp:TextBox ID="txt_QRCode" runat="server" CssClass="form-control" placeholder="Enter Scan Code." MaxLength="30"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:DropDownList ID="ddl_IsScaned" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="0">Not Scaned</asp:ListItem>
                <asp:ListItem Value="1">Scaned</asp:ListItem>
            </asp:DropDownList>
        </div>


        <div class="col-md-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>


    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>

    </div>


<%--    <button type="button" onclick="Reset()" class="btn btn-danger mb-2 disabled" disabled="disabled">Reset</button>--%>


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
        var pageUrl = '<%=ResolveUrl("TourReport.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                Regno = $('#<%=txt_userid.ClientID%>').val(),
                Tid = $('#<%=ddl_Tour.ClientID%>').val(),
                QRCode = $('#<%=txt_QRCode.ClientID%>').val(),
                IsScaned = $('#<%=ddl_IsScaned.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{min: "' + min + '", max: "' + max + '", Regno: "' + Regno + '", Tid: "' + Tid + '", QRCode: "' + QRCode + '", IsScaned: "' + IsScaned + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var Id = data.d[i].Id;

                        json.push([i + 1,
                        data.d[i].AppMstRegNo,
                        data.d[i].AppMstFName,
                        data.d[i].TourName,
                        data.d[i].QRCode,
                        data.d[i].Qualify_date,
                        data.d[i].IsScaned == "0" ? "<span class='dotGrey'></span>" : "<span class='dotGreen'></span>",
                        data.d[i].Scan_date,
                        data.d[i].Remark,
                        data.d[i].UpdateBy,
                            '<button type="button" onclick="Reset(' + Id + ')" class="btn btn-danger mb-2">Reset</button>'
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
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Tour Name" },
                            { title: "Scan Code" },
                            { title: "Qualify Date" },

                            { title: "Is Scaned" },
                            { title: "Scan Date" },
                            { title: "Remark" },
                            { title: "UpdateBy" },
                            { title: "Action" }
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


        function Reset(Id) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/Reset',
                data: '{Id: "' + Id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        BindTable();
                    }
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
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

    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>
</asp:Content>
