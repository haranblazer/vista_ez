<%@ Page Title="Group Sales" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="GroupSales.aspx.cs" Inherits="user_GroupSales" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Generation Downline/ Upline</h4>
    <div class="row">

        <div class="col-md-2">
            <asp:DropDownList ID="ddlMemberType" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All Status</asp:ListItem>
                <asp:ListItem Value="1">Paid</asp:ListItem>
                <asp:ListItem Value="0">UnPaid</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_Rank" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" MaxLength="20" placeholder="Userid"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_UpDown" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Downline</asp:ListItem>
                <asp:ListItem Value="1">Upline</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-1 col-xs-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
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
                    <th></th>
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

    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
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

        var pageUrl = '<%=ResolveUrl("GroupSales.aspx")%>';

        function BindTable() {
            let MemberType = $('#<%=ddlMemberType.ClientID%>').val(),
                Rank = $('#<%=ddl_Rank.ClientID%>').val(),
                Userid = $('#<%=txt_Userid.ClientID%>').val(),
                UpDown = $('#<%=ddl_UpDown.ClientID%>').val();
            if (Userid == "") {
                alert("Please Enter User Id.");
                return;
            }
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ MemberType: "' + MemberType + '", Rank: "' + Rank + '", Userid: "' + Userid + '", UpDown: "' + UpDown + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    
                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                        data.d[i].UserId,
                        data.d[i].UserName,
                        data.d[i].SponsorId,
                        data.d[i].SponsorName,
                        data.d[i].User_Mobile,
                        data.d[i].District,
                        data.d[i].State,
                        data.d[i].IsPaid == "1" ? "Paid" : "Unpaid",
                        data.d[i].TopperStatus,

                        data.d[i].IDStatus,
                        data.d[i].PBV,
                        data.d[i].GBV,
                        data.d[i].TPV,
                        data.d[i].CumulativeGBVPV,
                        data.d[i].RankPer,
                        data.d[i].RankName,
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
                            { title: "User" },
                            { title: "User Name" },
                            { title: "Sponsor ID" },
                            { title: "Sponsor Name" },
                            { title: "Mobile No" },
                            { title: "District" },
                            { title: "State" },
                            { title: "Paid <br> Status" },
                            { title: "Topper <br> Status" },

                            { title: "ID <br> Status" },
                            { title: "Curr.<br> RPV" },
                            { title: "Curr.<br> GPV" },
                            { title: "Curr.<br> TPV" },
                            { title: "Cumu.<br> GPV+TPV" },
                            { title: "Profit <br> Level" },
                            { title: "Gen <br> PIN" },

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        //"footerCallback": function (row, data, start, end, display) {
                        //    var api = this.api(), data;
                        //    // Remove the formatting to get integer data for summation
                        //    var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                        //    // Total over all pages 
                        //    $(api.column(0).footer()).html("Total:");
                        //    $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                        //}
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
