<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="GenTourList.aspx.cs" Inherits="secretadmin_GenTourList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Generation Tour User List</h4>

    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">

        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                MaxLength="10" CssClass="form-control" title="From date should be as dd/mm/yyyy"
                required="required"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                MaxLength="10" CssClass="form-control" title="To date should be as dd/mm/yyyy"
                required="required"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txt_userid" runat="server" placeholder="Enter UserId"
                MaxLength="25" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:DropDownList ID="ddl_Tour" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_Rank" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-md-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
      
    </div>





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
        var pageUrl = '<%=ResolveUrl("GenTourList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                Userid = $('#<%=txt_userid.ClientID%>').val(),
                Tid = $('#<%=ddl_Tour.ClientID%>').val(),
                RankId = $('#<%=ddl_Rank.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", Userid: "' + Userid + '", Tid: "' + Tid + '", RankId: "' + RankId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        let Download = '';
                        if (data.d[i].TourName == "4") {
                            Download = '<a href="Template_QualiStar.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&UN=' + data.d[i].UserName + '&State=' + data.d[i].Satate + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].TourType + '&RN=' + data.d[i].DisplayName + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '" class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>';
                        } else {
                            Download = '<a href="Template_Tour.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&UN=' + data.d[i].UserName + '&State=' + data.d[i].Satate + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].TourType + '&RN=' + data.d[i].DisplayName + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '" class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>';
                        }

                        json.push([i + 1,
                        data.d[i].Date,
                        data.d[i].UserId,
                        data.d[i].UserName,
                        data.d[i].MobileNumber,

                        data.d[i].GenerationPIN,
                        data.d[i].District,
                        data.d[i].Satate,
                        data.d[i].Matching,
                        data.d[i].GPV,
                        data.d[i].TourName,
                            Download,
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
                            { title: "Mobile No." },

                            { title: "Generation PIN" },
                            { title: "District" },
                            { title: "State" },
                            { title: "Condition" },
                            { title: "Maximum GPV" },
                            { title: "Tour Name" },
                            { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        //"footerCallback": function (row, data, start, end, display) {
                        //    var api = this.api(), data;

                        //    // Remove the formatting to get integer data for summation
                        //    var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                        //    // Total over all pages

                        //    $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                        //    $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));

                        //}
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


