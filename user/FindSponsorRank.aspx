<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="FindSponsorRank.aspx.cs"
    Inherits="secretadmin_FindSponsorRank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Team <%=method.PV%> Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="form-group card-group-row row">
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Month" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>

        <div class="col-sm-1 control-label">Self <%=method.PV%></div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_SelfRPV" runat="server" CssClass="form-control" placeholder="Enter Self RPV"
                onkeypress="return onlyNumbers(event,this);" MaxLength="10">1</asp:TextBox>
        </div>

        <div class="col-sm-1 control-label">No Of Sponsor</div>
        <div class="col-sm-1">
            <asp:TextBox ID="txt_Sponsor" runat="server" CssClass="form-control" placeholder="Enter No Of Sponsor"
                onkeypress="return onlyNumbers(event,this);" MaxLength="10">0</asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_D_GPV_RPV" runat="server" CssClass="form-control">
                <asp:ListItem Value="GPV">Downline Group Net Value>=</asp:ListItem>
                <asp:ListItem Value="RPV">Downline Net Value>=</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_D_GPV_RPV" runat="server" CssClass="form-control" placeholder="Enter Net Value"  
                onkeypress="return onlyNumbers(event,this);" MaxLength="10">1</asp:TextBox>
        </div>
         
        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>

    <hr />
    <div class="clearfix"></div>
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>
    </div>
    <br />
    <div class="clearfix"></div>

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
        var pageUrl = '<%=ResolveUrl("FindSponsorRank.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {

            let Months = $('#<%=ddl_Month.ClientID%>').val(),
                Sponsor = $('#<%=txt_Sponsor.ClientID%>').val(),
                SelfRPV = $('#<%=txt_SelfRPV.ClientID%>').val(),
                GPV_RPV_Type = $('#<%=ddl_D_GPV_RPV.ClientID%>').val(),
                D_GPV_RPV = $('#<%=txt_D_GPV_RPV.ClientID%>').val();
           
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetSponsorData',
                data: '{Months: "' + Months + '", Sponsor: "' + Sponsor + '", SelfRPV: "' + SelfRPV + '", GPV_RPV_Type: "' + GPV_RPV_Type + '", D_GPV_RPV: "' + D_GPV_RPV + '", userid: "' +  <%=UserId%>  + '", Typ: ""}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        var UserId = "'" + data.d[i].UserId + "'";
                        let View = '<a href="javascript:void(0)" onclick="openPopup(' + UserId + ')">View</a>';

                        json.push([i + 1,
                            View,
                        data.d[i].UserId,
                       /* data.d[i].UserName,*/
                        data.d[i].RankName,
                      /*  data.d[i].Mobile,*/
                        data.d[i].UserState,
                        data.d[i].District,
                        data.d[i].SponsporId,
                       /* data.d[i].SponsorName,*/
                        data.d[i].RPV,
                        data.d[i].GPV,
                        data.d[i].NoOfSponsor,
                        //data.d[i].DiamondID,
                        //data.d[i].DiamondName,
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

                            { title: "View" },
                            { title: "UserId" },
                           /* { title: "User Name" },*/
                            { title: "Rank" },
                           /* { title: "Mobile" },*/
                            { title: "State" },
                            { title: "District" },
                            { title: "SponsporId" },
                            /* { title: "Sponsor Name" },*/
                            { title: "" + '<%=method.PV%>' },
                            { title: "Downline" + '<%=method.GBV%>' },
                            { title: "N.O.SP" },
                            //{ title: "Diamond Id" },
                            //{ title: "Diamond Name" },
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


    <!-- Modal -->
    <div id="myModal" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="CloseModel();">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">View Sponsor Report</h4>
                </div>

                <div class="modal-body">
                    <table id="tblListDetails" class="table" style="width: 100%; border-collapse: collapse;"></table>
                </div>
            </div>
        </div>
    </div>
     
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <script type="text/javascript">

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }

        function openPopup(userid) {
            $('#tblListDetails').text('');
            $("#myModal").modal('show');
            var Months = $('#<%=ddl_Month.ClientID%>').val(),
                Sponsor = $('#<%=txt_Sponsor.ClientID%>').val(),
                SelfRPV = $('#<%=txt_SelfRPV.ClientID%>').val(),
                GPV_RPV_Type = $('#<%=ddl_D_GPV_RPV.ClientID%>').val(),
                D_GPV_RPV = $('#<%=txt_D_GPV_RPV.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: 'FindSponsorRank.aspx/GetSponsorData',
                data: '{Months: "' + Months + '", Sponsor: "' + Sponsor + '", SelfRPV: "' + SelfRPV + '", GPV_RPV_Type: "' + GPV_RPV_Type + '", D_GPV_RPV: "' + D_GPV_RPV + '", userid: "' + userid + '", Typ: "Detail"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblListDetails').text('');
                    $('#tblListDetails').empty().append("<thead><tr>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SNo</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>UserId</th>");
                   /* $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>User Name</th>"); */
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Genaration Rank</th>");
                  /*  $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Mobile</th>");*/
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>State</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>District</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SponsporId</th>");
                  /* $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Sponsor Name</th>"); */
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>RPV</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Downline GPV</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>No Of Sponsor</th>");
                    $('#tblListDetails').append("</tr></thead>");
                    var tbl = '<tbody>';
                    for (var i = 0; i < data.d.length; i++) {
                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        tbl += '<td>' + data.d[i].UserId + '</td>';
                       /* tbl += '<td>' + data.d[i].UserName + '</td>'; */
                        tbl += '<td>' + data.d[i].RankName + '</td>';
                       /* tbl += '<td>' + data.d[i].Mobile + '</td>';*/
                        tbl += '<td>' + data.d[i].UserState + '</td>';
                        tbl += '<td>' + data.d[i].District + '</td>';
                        tbl += '<td>' + data.d[i].SponsporId + '</td>';
                       /*  tbl += '<td>' + data.d[i].SponsorName + '</td>'; */
                        tbl += '<td>' + data.d[i].RPV + '</td>';
                        tbl += '<td>' + data.d[i].GPV + '</td>';
                        tbl += '<td>' + data.d[i].NoOfSponsor + '</td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    $('#tblListDetails').append(tbl);
                    if (data.d.length == 0) {
                        $('#tblListDetails').text('Cart is empty.....');
                        return false;
                    }

                    $('#myModal').modal('show');
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    return false;
                }
            });
        }

        function CloseModel() {
            $("#myModal").modal('hide');
        }
    </script>

</asp:Content>
