<%@ Page Title="Group Sales" Language="C#" MasterPageFile="user.master" 
    AutoEventWireup="true" CodeFile="GroupSales.aspx.cs" Inherits="user_GroupSales" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .not-active {
            pointer-events: none;
            cursor: default;
            color: #999999;
        }
    </style>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Generation Downline</h4>


    <div class="form-group card-group-row row">

        <label class="col-md-1 control-label">Status</label>
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
            <asp:DropDownList ID="ddlMemberType" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Paid</asp:ListItem>
                <asp:ListItem Value="0">UnPaid</asp:ListItem>
            </asp:DropDownList>
        </div>

        <label class="col-md-1 control-label">Rank</label>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_Rank" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <label class="col-md-1 control-label">Userid</label>
        <div class="col-md-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <input type="button" value="Search" onclick="FuDownline()" class="btn btn-primary" />
        </div>
        
    </div>
    
    <hr />
     <span><button type="button" id="btn_Back" title="Back" class="btn btn-primary mt-0" style="display: none; padding: 0.125rem 0.762rem;" onclick="Back()">Back</button></span>
    <span id="div_Url" style="color: blue; font-size:12px;"></span>
   
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
    <script> var $JDT = $.noConflict(true); </script>
    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("GroupSales.aspx")%>';
        $JDT(function () {
            BindRepurchase();
        });


        function BindRepurchase() {
            var rank = $('#<%=ddl_Rank.ClientID%>').val();
            var paid = $('#<%=ddlMemberType.ClientID%>').val();
            var Userid = $('#<%=txt_Userid.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindRepurchase',
                data: '{rank: "' + rank + '", paid: "' + paid + '", Userid: "' + Userid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var BinaryData = [];

                    for (var i = 0; i < data.d.length; i++) {

                        var user = data.d[i].status == '0' ? ' </br> ' : ' </br> <input type="button" value="Status" onclick="FuStatus(' + data.d[i].UserId + ')" class="btn btn-primary btn-sm">';

                        BinaryData.push([i + 1,
                        //data.d[i].Img_Name,
                            data.d[i].UserId,
                            data.d[i].UserName,
                            user,

                       //data.d[i].UserId + "</br>" + data.d[i].UserName,
                       //     user,
 			data.d[i].SponsorId,
                        /* data.d[i].SponsorId + "</br>" + data.d[i].SponsorName,*/
                        data.d[i].PBV,
                        data.d[i].GBV,
                      /*  data.d[i].TPV,*/
                        data.d[i].TotalGBV,
                        data.d[i].OLDPBV,
                        data.d[i].OLDGBV,
                       /* data.d[i].OLDTVP,*/
                        data.d[i].CumulativeGBVPV,
                        data.d[i].RankName,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: BinaryData,
                        columns: [
                           
                            { title: "#" },
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Status" },
                          
                            { title: "Sponsor" },
                            { title: "Curr. m’th " + '<%=method.PV%>' },
                            { title: "Curr. m’th " + '<%=method.GBV%>' },
                            <%--{ title: "Curr. m’th " + '<%=method.BINARY_PV%>' },--%>
                            { title: "Cumulative " + '<%=method.GBV%>' },
                            { title: "Prev. m’th " + '<%=method.PV%>' },
                            { title: "Prev. m’th " + '<%=method.GBV%>' },
                           <%-- { title: "Prev. m’th TPV" + '<%=method.BINARY_PV%>' },--%>
                            { title: "Total<br> <%=method.Associate%>" },
                            { title: "Rank" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function Back() {
            $.ajax({
                type: "POST",
                url: pageUrl + '/Back',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d != '') { 
                        BindDownUser(data.d, "Status");
                        BindRepurchase();
                        StoreUser();
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function FuStatus(Userid) {
            BindDownUser(Userid, "Status");
        }
        function FuGOUP() {
            BindDownUser("", "GOUP");
        }
        function FuDownline() {
            var Userid = $('#<%=txt_Userid.ClientID%>').val();
            BindDownUser(Userid, "Downline");
        }

        function BindDownUser(Userid, Type) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/SetUserid',
                data: '{ Userid: "' + Userid + '", Type: "' + Type + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '') {
                        BindRepurchase();
                        StoreUser();
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }



        function StoreUser() {
            $.ajax({
                type: "POST",
                url: pageUrl + '/StoreUser',
                data: '{ Userid: ""}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var link = '';
                    $('#btn_Back').hide();
                    for (var i = 0; i < data.d.length; i++) {
                        if (data.d[i].Userid != "<%=Userid%>") {
                            $('#btn_Back').show();
                            var Userid = "'" + data.d[i].Userid + "'";
                            var Status = "'Status'";
                            if (link != '') {
                                link = link + '/ <a href="#/" onclick="BindDownUser(' + Userid + ',' + Status + ')" style="color:blue;  font-size:12px;">' + data.d[i].Userid + '</a>';
                            }
                            else {
                                link = '<a href="#/" onclick="BindDownUser(' + Userid + ',' + Status + ')" style="color:blue;  font-size:12px;">' + data.d[i].Userid + '</a>';
                            }
                        }
                    }
                   
                    $('#div_Url').html(link);
                },
                error: function (result) {
                    alert(result);
                }
            });
        }



    </script>


</asp:Content>
