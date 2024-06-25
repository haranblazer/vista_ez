<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="BusinessInformation.aspx.cs" Inherits="BusinessInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Total Income Report</h4>
    </div>

    <div class="row">

        <div class="col-md-2">
            <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" Placeholder="Enter User Id."></asp:TextBox>
        </div>
        
        <div class="col-md-1 control-label text-center">
            >=
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_ConditionFrom" runat="server" CssClass="form-control" Text="1000" Placeholder="Enter >= Values"></asp:TextBox>
        </div>

         <div class="col-md-1 control-label text-center">
            <=
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_ConditionTo" runat="server" CssClass="form-control" Text="500000000" Placeholder="Enter <= Values"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable();">Search</button>
        </div>

        <%--<div class="col-md-1">
        </div>
        <div class="col-md-2">
            <button type="button" class="btn btn-primary d-none" onclick="AllDownload()">All Download</button>
        </div>--%>

    </div>
    <div class="clearfix"></div>
    <br />
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
        var pageUrl = '<%=ResolveUrl("BusinessInformation.aspx")%>';
        var DownloadArray = [];
        //$JDT(function () {
        //    BindTable();
        //});

        function BindTable() {
            let Userid = $('#<%=txt_Userid.ClientID%>').val(),
                Month = $('#<%=ddlDateRange.ClientID%>').val(),
                ConditionFrom = $('#<%=txt_ConditionFrom.ClientID%>').val(),
                ConditionTo = $('#<%=txt_ConditionTo.ClientID%>').val();
            
            if (ConditionFrom == "") {
                ConditionFrom = "0";
            }
            if (ConditionTo == "") {
                ConditionTo = "0";
            }
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ Userid: "' + Userid + '", Month: "' + Month + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    DownloadArray.lenght = 0;
                    DownloadArray = [];
                   
                    for (var i = 0; i < data.d.length; i++) {
                        var Statement = '<a stye="color:blue;" href="TotalMonthlyIncStatment.aspx?m=' + data.d[i].Month_Encode + '"><i class="fa fa-print"></i></a>';
                        let Download = '';
                        let WhatsApp = '';
                        let Checkstr = '';
                        if (parseFloat(data.d[i].TotalAmount) >= parseFloat(ConditionFrom) && parseFloat(data.d[i].TotalAmount) <= parseFloat(ConditionTo)) {
                            DownloadArray.push({
                                UserId: data.d[i].appmstregno,
                                UserName: data.d[i].UserName,
                                State: data.d[i].State,
                                DIST: data.d[i].District,
                                Rank: data.d[i].TotalAmount,
                                Month: data.d[i].Month,
                                Img: data.d[i].imagename
                            });


                            Download = '<a href="Template_Total_Income.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=Download&UN=' + data.d[i].UserName + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].TotalAmount + '&RN=' + data.d[i].TotalAmount + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>';
                            WhatsApp = '<a href="Template_Total_Income.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&Typ=WhatsApp&UN=' + data.d[i].UserName + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].TotalAmount + '&RN=' + data.d[i].TotalAmount + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-whatsapp" aria-hidden="true"></i></a>';

                            Checkstr = '<input type="checkbox" id="chk_' + data.d[i].appmstregno + '">'; // onclick="CheckSingle(' + data.d[i].appmstregno + ');"
                        } else {
                            Download = '<a href="Javascript:void(0)"  class="btn btn-danger" target="_blank">Not eligible</a>';
                            Checkstr = '';
                        }

                        json.push([i + 1,
                        data.d[i].Month,
                        data.d[i].appmstregno,
                        data.d[i].UserName,
                        data.d[i].State,
                        data.d[i].District,

                        data.d[i].MatchingIncome,
                        data.d[i].TopperFund,
                        data.d[i].RepurchaseIncome,
                        data.d[i].AnnualRoyalty,
                        data.d[i].TotalAmount,
                            Statement,
                            Download,

                            WhatsApp,
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
                            { title: "SNo." },
                            { title: "Month" },
                            { title: "UserId" },
                            { title: "UserName" },
                            { title: "State" },
                            { title: "District" },

                            { title: "Matching Income" },
                            { title: "Topper Fund" },
                            { title: "Repurchase Income" },
                            { title: "Annual Royalty" },
                            { title: "Total Amount" },
                            { title: "Print" },
                            { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
                            { title: "<i class='fa fa-whatsapp' aria-hidden='true'></i>" }, //<input type='checkbox' id='chk_All' onclick='CheckAll();'>

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        'columnDefs': [{
                            "targets": [0, 13],
                            "orderable": false
                        }],
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };

                            //Total over all pages 

                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(0));
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                        }
                    });
                },
                error: function (result) { alert('1'); alert(result); $('#LoaderImg').hide(); }
            });
        }


        function CheckAll() {
            for (var i = 0; i < DownloadArray.length; i++) {
                if ($('#chk_All').is(':checked')) {
                    document.getElementById('chk_' + DownloadArray[i].UserId).checked = true;
                } else {
                    document.getElementById('chk_' + DownloadArray[i].UserId).checked = false;
                }
            }
        }

        function AllDownload() {
            for (var i = 0; i < DownloadArray.length; i++) {
                if ($('#chk_' + DownloadArray[i].UserId).is(':checked')) {
                    let Url = "Template_Total_Income.aspx?UN=" + DownloadArray[i].UserName + "&State=" + DownloadArray[i].State + "&DIST=" + DownloadArray[i].DIST + "&Rank=" + DownloadArray[i].Rank + "&RN=" + DownloadArray[i].Rank + "&Month=" + DownloadArray[i].Month + "&Img=" + DownloadArray[i].Img;
                    UrlClick(Url);
                }
            }
        }


        async function UrlClick(Url) {
            let UrlPromise = new Promise((resolve, reject) => {
                setTimeout(function () {
                    window.open(Url, '_blank');
                }, 10000);
            })
            let x = await UrlPromise;
        }

    </script>

</asp:Content>

