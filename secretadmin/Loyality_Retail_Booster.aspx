<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="Loyality_Retail_Booster.aspx.cs" Inherits="Loyality_Retail_Booster" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Retail Loyalty Booster Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <asp:Panel ID="pnlUtility" runat="server">

        <div class="row"> 
            <div class="col-sm-2">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                    placeholder="From"></asp:TextBox>
            </div> 
            <div class="col-sm-2"> 
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                    placeholder="To"></asp:TextBox>
            </div> 
            <div class="col-md-2">
                <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control">
                </asp:DropDownList>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-2"></div>
            <div class="col-md-2">
                <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
            </div>

        </div>
    </asp:Panel>


    <hr />


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
                </tr>
            </tfoot>
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
        var pageUrl = '<%=ResolveUrl("Loyality_Retail_Booster.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let Regno = $('#<%=txt_Userid.ClientID%>').val(),
                Payoutno = $('#<%=ddlDateRange.ClientID%>').val();
            var FromDate = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var ToDate = dateFormate($('#<%=txtToDate.ClientID%>').val());

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ FromDate: "' + FromDate + '", ToDate: "' + ToDate + '", Regno: "' + Regno + '", Payoutno: "' + Payoutno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        var regno = "'" + data.d[i].appmstregno + "'";
                        var payoutno = "'" + data.d[i].payoutno + "'";

                        var View = '<a href="javascript: void()" onclick="openPopup(' + payoutno + ',' + regno + ')" style="color:blue;">View</a>';

                        json.push([i + 1,
                        data.d[i].Dates,
                        data.d[i].appmstregno,
                        data.d[i].UserName,
                        data.d[i].Mobile,
                        data.d[i].District,
                        data.d[i].State,
                        data.d[i].LoyalityInc,
                        data.d[i].NoOfQualfy,
                            View,
                        '<a href="Template_Retail_Booster.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&UN=' + data.d[i].UserName + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].LoyalityInc + '&RN=' + data.d[i].LoyalityInc + '&Month=' + data.d[i].Dates + '&Img=' + data.d[i].imagename + '"  class="btn btn-link" target="_blank">Download</a>',
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
                            { title: "Payout Period" },
                            { title: "UserId" },
                            { title: "UserName" },
                            { title: "Mobile" },
                            { title: "District" },
                            { title: "State" },
                            { title: "Amt" },
                            { title: "QLFY" },
                            { title: "View" },
                            { title: "Download" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages

                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                        }
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
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 100%;">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">View Loyality Report</h4>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table id="tblListDetail" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%; border-collapse: collapse;"></table>
                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>
        </div>
    </div>



    <%--  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>--%>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">

        function openPopup(Payoutno, Regno) {

            $("#myModal").modal('show');
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetLoyalityData',
                data: '{Payoutno: "' + Payoutno + '", Regno: "' + Regno + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblListDetail').empty().append("<thead><tr>");
                    $('#tblListDetail').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SNo</th>");
                    $('#tblListDetail').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Date</th>");
                    $('#tblListDetail').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>UserId</th>");
                    //$('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Mobile</th>");
                    //$('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>District</th>");
                    //$('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>State</th>");

                    $('#tblListDetail').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>InvoiceNo</th>");
                    $('#tblListDetail').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Amount</th>");
                    $('#tblListDetail').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Status</th>");
                    $('#tblListDetail').append("</tr></thead>");

                    var tbl = '<tbody>';
                    for (var i = 0; i < data.d.length; i++) {
                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        tbl += '<td>' + data.d[i].Doe + '</td>';
                        tbl += '<td>' + data.d[i].SoldTo + '</td>';
                        //tbl += '<td>' + data.d[i].Mobile + '</td>';
                        //tbl += '<td>' + data.d[i].District + '</td>';
                        //tbl += '<td>' + data.d[i].State + '</td>';
                        tbl += '<td>' + data.d[i].InvoiceNo + '</td>';
                        tbl += '<td>' + data.d[i].Amount + '</td>';
                        tbl += '<td stye=>' + data.d[i].Status + '</td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    $('#tblListDetail').append(tbl);
                    if (data.d.length == 0) {
                        $('#tblListDetail').text('Data Not Found.....');
                        return false;
                    }
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    return false;
                }
            });
        }
    </script>


</asp:Content>
