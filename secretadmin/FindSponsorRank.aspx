<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="FindSponsorRank.aspx.cs" Inherits="secretadmin_FindSponsorRank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <h4 class="fs-20 font-w600  me-auto float-left mb-0"> Sponsor Report </h4>
     <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="form-group card-group-row row">
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Month" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>

        <div class="col-sm-2 control-label">Self <%=method.GBV%></div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_SelfRPV" runat="server" CssClass="form-control" placeholder="Enter Self RPV"
                onkeypress="return onlyNumbers(event,this);" MaxLength="10">0</asp:TextBox>
        </div>

        <div class="col-sm-1 control-label">NOS</div>
        <div class="col-sm-1">
            <asp:TextBox ID="txt_Sponsor" runat="server" CssClass="form-control" placeholder="Enter No Of Sponsor"
                onkeypress="return onlyNumbers(event,this);" MaxLength="10">0</asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_D_GPV_RPV" runat="server" CssClass="form-control">
               <%-- <asp:ListItem Value="GPV">Downline GPV>=</asp:ListItem>
                <asp:ListItem Value="RPV">Downline RPV>=</asp:ListItem>--%>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_D_GPV_RPV" runat="server" CssClass="form-control" placeholder="Enter RPV/GPV"
                onkeypress="return onlyNumbers(event,this);" MaxLength="10">0</asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Userid"></asp:TextBox>
        </div>

        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
           <%-- <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CssClass="btn btn-primary" />--%>
        </div>


       <%-- <div class="col-sm-1 control-label">

            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="20px" />
        </div>--%>
    </div>


    <hr />
    <div class="clearfix"></div>
    <div class="table-responsive">
         <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>

       <%-- <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
            Font-Names="Arial" Font-Size="Small" PageSize="50" AutoGenerateColumns="False"
            EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="dglst_PageIndexChanging"
            OnRowDataBound="dglst_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="SNo">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="View" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <a href="#" data-toggle="modal" data-target="#myModal" onclick='openPopup("<%# Eval("userid")%>");return false;'>View Details</a>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField HeaderText="UserId" DataField="UserId" />
                <asp:BoundField HeaderText="User Name" DataField="UserName" />
                <asp:BoundField HeaderText="Genaration Rank" DataField="RankName" />
                <asp:BoundField HeaderText="Mobile" DataField="Mobile" />
                <asp:BoundField HeaderText="State" DataField="UserState" />
                <asp:BoundField HeaderText="District" DataField="District" />
                <asp:BoundField HeaderText="SponsporId" DataField="SponsporId" />
                <asp:BoundField HeaderText="Sponsor Name" DataField="SponsorName" />
                <asp:BoundField HeaderText="RPV" DataField="RPV" />
                <asp:BoundField HeaderText="Downline GPV" DataField="GPV" />
                <asp:BoundField HeaderText="No Of Sponsor" DataField="NoOfSponsor" />
            </Columns>
        </asp:GridView>--%>
    </div>
    <br />
    <div class="clearfix"></div>


    
  <%--   <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
   <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>--%>
   <%-- <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>--%>

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
        //$JDT(function () {
        //    BindTable();
        //});
        
        function BindTable() {
             
            let Months = $('#<%=ddl_Month.ClientID%>').val(),
                Sponsor = $('#<%=txt_Sponsor.ClientID%>').val(),
                 SelfRPV = $('#<%=txt_SelfRPV.ClientID%>').val(),
                GPV_RPV_Type = $('#<%=ddl_D_GPV_RPV.ClientID%>').val(),
                D_GPV_RPV = $('#<%=txt_D_GPV_RPV.ClientID%>').val(),
                Userid = $('#<%=txt_Userid.ClientID%>').val();
             
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetSponsorData',
                data: '{Months: "' + Months + '", Sponsor: "' + Sponsor + '", SelfRPV: "' + SelfRPV + '", GPV_RPV_Type: "' + GPV_RPV_Type + '", D_GPV_RPV: "' + D_GPV_RPV + '", userid: "' + Userid + '", Typ: ""}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        var UserId = "'" + data.d[i].UserId + "'";
                        let View = '<a href="#/" onclick="openPopup(' + UserId + ')">View</a>';
                         
                        json.push([i + 1,
                            View,
                            data.d[i].UserId,
                            data.d[i].UserName,
                            data.d[i].RankName,
                            data.d[i].Mobile,
                            data.d[i].UserState,
                            data.d[i].District,
                            data.d[i].SponsporId,
                            data.d[i].SponsorName,
                            data.d[i].RPV,
                            data.d[i].GPV, 
                            data.d[i].NoOfSponsor, 
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
                            { title: "User Name" },
                            { title: "Rank" },
                            { title: "Mobile" },
                            { title: "State" },
                            { title: "District" },
                            { title: "SponsporId" },
                            { title: "Sponsor Name" },
                            { title: "<%=method.PV%>" },
                            { title: "Downline <%=method.GBV%>" },
                            { title: "N.O.SP" },
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
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">View Sponsor Report</h4>
                </div>

                <div class="modal-body">
                    <table id="tblListDetails" class="table" style="width: 100%; border-collapse: collapse;"></table>
                </div>
            </div>
        </div>
    </div>

  <%--  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 100%;">
        <div class="modal-dialog modal-xl modal-dialog-centered" style="width: 80%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">View Sponsor Report</h4>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                       
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>--%>

    <%--  <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script> --%>

<%--    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>--%>

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
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>User Name</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Rank</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Mobile</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>State</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>District</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SponsporId</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Sponsor Name</th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'><%=method.PV%></th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Downline <%=method.GBV%></th>");
                    $('#tblListDetails').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>No Of Sponsor</th>");
                    $('#tblListDetails').append("</tr></thead>");
                    var tbl = '<tbody>';
                    for (var i = 0; i < data.d.length; i++) {
                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        tbl += '<td>' + data.d[i].UserId + '</td>';
                        tbl += '<td>' + data.d[i].UserName + '</td>';
                        tbl += '<td>' + data.d[i].RankName + '</td>';
                        tbl += '<td>' + data.d[i].Mobile + '</td>';
                        tbl += '<td>' + data.d[i].UserState + '</td>';
                        tbl += '<td>' + data.d[i].District + '</td>';
                        tbl += '<td>' + data.d[i].SponsporId + '</td>';
                        tbl += '<td>' + data.d[i].SponsorName + '</td>';
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
    </script>

</asp:Content>
