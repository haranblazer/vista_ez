<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="GenLevelReport.aspx.cs" Inherits="User_GenLevelReport" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Generation Level Report</h4>
      <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="form-group card-group-row row">

        <div class="col-md-1 control-label">
            Level:
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_level" runat="server" CssClass="form-control" 
                onkeypress="return onlyNumbers(event,this);" MaxLength="10">0</asp:TextBox>
           <%-- <asp:DropDownList ID="ddl_level" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">All</asp:ListItem>
                <asp:ListItem Value="1" Selected="True">L1</asp:ListItem>
                <asp:ListItem Value="2">L2</asp:ListItem>
                <asp:ListItem Value="3">L3</asp:ListItem>
            </asp:DropDownList>--%>
        </div>
        <div class="col-md-1">
            <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
        </div>
    </div>
    <hr />
    <div class="clearfix"></div>
     
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%"></table>
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

        var pageUrl = '<%=ResolveUrl("GenLevelReport.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var level = $('#<%=txt_level.ClientID%>').val();
            if (level == '')
                level = 0;

            if (parseInt(level) > 50) {
                //$('#<%=txt_level.ClientID%>').val(50);
                alert("Maximum 50 levels allowed.");
                return;
            }
                
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{level: "' + level + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                        data.d[i].appmstregno,
                            data.d[i].fname,
                            "L " + data.d[i].Level,
                        data.d[i].SponsorId,
                        /*data.d[i].SponsorName,*/
                        data.d[i].status,
                        data.d[i].CurrentRPV,
                        data.d[i].CurrentGBV,
                        data.d[i].GenerationRank,
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
                            { title: "SNo" },
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Level" },
                            { title: "Sponsor Id" },
                            //{ title: "Sponsor Name" },
                            { title: "Status" },
                            { title: "Cur." + '<%=method.PV%>' },
                            { title: "Cur." + '<%=method.GBV%>' },
                            { title: "Rank" },
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


        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }

    </script>

</asp:Content>
