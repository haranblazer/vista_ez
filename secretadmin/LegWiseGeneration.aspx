<%@ Page Title="Group Sales" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="LegWiseGeneration.aspx.cs" Inherits="LegWiseGeneration" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Super 20 Report</h4>
      <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">
        <div class="col-sm-1 control-label">Month</div>
        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddl_Month" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>
         <div class="col-sm-2 ">
            <asp:TextBox ID="txt_Userid" CssClass="form-control" runat="server" placeholder="Enter UserId."></asp:TextBox>
            
        </div>
        <div class="col-sm-1">
            <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
        </div>
    </div>

    <hr />

    <div class="clearfix"></div>
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
    <script type="text/javascript">
        var $JDT = $.noConflict(true);
        var pageUrl = '<%=ResolveUrl("LegWiseGeneration.aspx")%>';
        //$JDT(function () {
        //    BindTable();
        //});


        function BindTable() {
            var Months = $('#<%=ddl_Month.ClientID%>').val(),
                Userid = $('#<%=txt_Userid.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Userid: "' + Userid+'", Months: "' + Months + '", Typ: "ADMIN"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                   
                    for (var i = 0; i < data.d.length; i++) {

                        var Userid = "'" + data.d[i].Userid + "'";
                        let RPV_Count = '<a href="javascript: void()" onclick="DL_User(' + Userid + ')" style="color:blue;">' + data.d[i].RPV_Count1 + '</a>';

                        json.push([i + 1,
                            data.d[i].Userid,
                            data.d[i].UserName,
                            data.d[i].AppMstState,
                            data.d[i].distt,
                            data.d[i].AppMstMobile, 
                            data.d[i].PBVAmt,
                            RPV_Count,
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
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "State" },
                            { title: "District" },  
                            { title: "Mobile No." },
                            { title: "RPV" },
                            { title: "750 Count" },
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


        function DL_User(Userid) {
            var Months = $('#<%=ddl_Month.ClientID%>').val();
            $("#DL_Table_Modal").modal('show');
            $('#div_DL_Table').empty().append('');
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Userid: "' + Userid + '", Months: "' + Months + '", Typ: "USER"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var tbl = "";
                    tbl += '<table class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">';
                    tbl += '<thead>';
                    tbl += '<tr>';
                    tbl += '<th scope="col">User Id </th>';
                    tbl += '<th scope="col">User Name </th>';
                    tbl += '<th scope="col">RPV</th>';
                    tbl += '<th scope="col">750 Count</th>';
                    tbl += '</tr>';
                    tbl += '</thead>';
                    tbl += '<tbody>';

                    for (var i = 0; i < data.d.length; i++) {
                        if (data.d[i].Userid != Userid) {
                            var UseridVal = "'" + data.d[i].Userid + "'";
                            let RPV_Count = '';

                            if (data.d[i].RPV_Count1 != '0') {
                                RPV_Count = '<a href="javascript: void()" onclick="DL_User_16(' + UseridVal + ')" style="color:blue;">' + data.d[i].RPV_Count1 + '</a>';
                            }
                            else {
                                RPV_Count = '<a href="javascript: void()" style="color:black;">' + data.d[i].RPV_Count1 + '</a>';
                            }
                             
                            tbl += '<tr>';
                            tbl += '<td>' + data.d[i].Userid + '</td>';
                            tbl += '<td>' + data.d[i].UserName + '</td>';
                            tbl += '<td>' + data.d[i].PBVAmt + '</td>';
                            tbl += '<td>' + RPV_Count + '</td>';

                            tbl += '</tr>';
                        }
                    }
                    tbl += '</tbody>';
                    tbl += '</table>';
                    $('#div_DL_Table').empty().append(tbl);
                },
                error: function (result) {
                    alert(result);
                }
            });
        }



        function DL_User_16(Userid) {
            var Months = $('#<%=ddl_Month.ClientID%>').val();
            $("#DL_Table_Modal_16").modal('show');
            $('#div_DL_Table_16').empty().append('');
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Userid: "' + Userid + '", Months: "' + Months + '", Typ: "USER"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var tbl = "";
                    tbl += '<table class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">';
                    tbl += '<thead>';
                    tbl += '<tr>';
                    tbl += '<th scope="col">User Id </th>';
                    tbl += '<th scope="col">User Name </th>';
                    tbl += '<th scope="col">RPV</th>';
                    tbl += '</tr>';
                    tbl += '</thead>';
                    tbl += '<tbody>';

                    for (var i = 0; i < data.d.length; i++) {
                        if (data.d[i].Userid != Userid) {  
                            tbl += '<tr>';
                            tbl += '<td>' + data.d[i].Userid + '</td>';
                            tbl += '<td>' + data.d[i].UserName + '</td>';
                            tbl += '<td>' + data.d[i].PBVAmt + '</td>';
                            tbl += '</tr>';
                        }
                    }
                    tbl += '</tbody>';
                    tbl += '</table>';
                    $('#div_DL_Table_16').empty().append(tbl);
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Modal HTML -->
    <div id="DL_Table_Modal" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="div_DL_Table" class="product-descr"></div>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal HTML -->
    <div id="DL_Table_Modal_16" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="div_DL_Table_16" class="product-descr"></div>
                </div>
            </div>
        </div>
    </div>



</asp:Content>
