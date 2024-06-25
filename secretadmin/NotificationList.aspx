<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="NotificationList.aspx.cs" Inherits="secretadmin_NotificationList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Notification List</h4>
    <div class="form-group card-group-row row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddl_AdminAPRVD" CssClass="form-control" runat="server">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Approved</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2 ">
            <asp:TextBox ID="txt_UserId" runat="server" CssClass="form-control" placeholder="User Id"></asp:TextBox>

        </div>
        <div class="col-sm-2 col-xs-3 text-right pull-right">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>

    <hr />

    <div class="clearfix"></div>
    <div class="table-responsive">

        <table id="tblList" class="display" style="width: 100%"></table>

    </div>

    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
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



    <%-- Table Js and css  --%>
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

        var pageUrl = '<%=ResolveUrl("NotificationList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var fromDate = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                toDate = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                AdminAPRVD = $('#<%=ddl_AdminAPRVD.ClientID%>').val(),
                UserId = $('#<%=txt_UserId.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{fromDate: "' + fromDate + '", toDate: "' + toDate + '",AdminAPRVD: "' + AdminAPRVD + '" ,UserId: "' + UserId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var NId = data.d[i].NId;
                        let AdminAPRVD = '';
                        let Message = '';
                        let Delete = '<center><a href="javascript:void(0);"> <span style="color:Red; font-size:x-large;" onclick="DeleteNotif(' + NId + ');" title="Remove">&times;</span> </a> </center>';
                        if (data.d[i].AdminAPRVD == "True") {
                            AdminAPRVD = '<a href="#/" onclick="UpdateApprove(' + NId + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            AdminAPRVD = '<a href="#/" onclick="UpdateApprove(' + NId + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }
                        //data.d[i].Msg.split(/\s+/).slice(0, 5).join(" ") + 
                        Message = '<div class="clearfix"></div> <a href="javascript:void(0)" class="btn btn-xs btn-primary"  data-bs-toggle="modal" data-bs-target="#exampleModalLong" onclick="ReadMore(' + NId + ')"> <i class="fa fa-eye" aria-hidden="true"></i> </a> <input type="hidden" id="' + NId + '"  value="' + data.d[i].Msg + '"> ';


                        json.push([i + 1,
                        data.d[i].Doe,
                            AdminAPRVD,
                        data.d[i].UserId,
                        data.d[i].Appmstfname,
                        data.d[i].AppMstMobile,
                        data.d[i].AppMstState,
                        data.d[i].Distt,
                            Message,
                        data.d[i].GenRank,
                            Delete,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'print'],
                        data: json,
                        columns: [
                            { title: "#" },
                            { title: "Date" },
                            { title: "Status" },
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Mobile No." },
                            { title: "State" },
                            { title: "District" },
                            { title: "Message" },
                            { title: "Rank" },
                            { title: "<center><span style='color:Red; font-size:x-large;'>&times;</span></center>" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 10,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }


        function ReadMore(NId) {
            $('#Model_Notification_Msg').html($('#' + NId).val());
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


        function UpdateApprove(NId) {
            if (!confirm('Are you sure you want to Approve.!!')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateApprove',
                data: '{ NId: "' + NId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        BindTable();
                    } else { alert(data.d.Error); return; }
                },
                error: function (result) { alert(result); }
            });
        }

        function DeleteNotif(NId) {
            if (!confirm('Are you sure you want to delete.!!')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/DeleteNotification',
                data: '{ NId: "' + NId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        BindTable();
                    } else { alert(data.d.Error); return; }
                },
                error: function (result) { alert(result); }
            });
        }

 
       
         
    </script>


    <div class="modal fade" id="exampleModalLong" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Notifications</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal">
                    </button>
                </div>
                <div class="modal-body">
                    <span id="Model_Notification_Msg"></span>
                </div> 
            </div>
        </div>
    </div>



</asp:Content>

