<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="payoutlist1.aspx.cs" Inherits="admin_payoutlist1" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Monthly Payout List</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-md-2" style="display: none;">
            <asp:DropDownList ID="ddl_Payout_Fillter" runat="server" CssClass="form-control">
                <%--<asp:ListItem Selected="True" Value="1">Dispatch & Release</asp:ListItem>
                        <asp:ListItem Value="0">Hold Payout</asp:ListItem>
                        <asp:ListItem Value="2">Release</asp:ListItem>--%>
                <asp:ListItem Value="-1">All Payout</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2" style="display: none;">
            <asp:TextBox ID="txt_Userid" runat="server" MaxLength="30" CssClass="form-control" placeholder="Enter UserId"></asp:TextBox>
        </div>

        <div class="col-sm-3">
            <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>


        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_KYC" runat="server" CssClass="form-control">
                <asp:ListItem Selected="True" Value="-1">All KYC</asp:ListItem>
                <asp:ListItem Value="1">KYC</asp:ListItem>
                <asp:ListItem Value="0">NON KYC</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Rank" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>

        <div class="col-sm-1">
            <asp:RadioButtonList ID="rdoReqTypeSponsor_list" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True" Value=">=">>=</asp:ListItem>
                <asp:ListItem Value="=">=</asp:ListItem>
                <asp:ListItem Value="<="><=</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_Condition" runat="server" CssClass="form-control" Text="0" Placeholder="Enter Condition"></asp:TextBox>
        </div>
        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
        <div class="clearfix"></div>

    </div>

    <hr />


    <div class="clearfix"></div>
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
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
        var pageUrl = '<%=ResolveUrl("payoutlist1.aspx")%>';
        $JDT(function () {
            BindTable();
            BindTable();
            //$('#tblList').DataTable().autoAdjustColumnsOnResize();
            // $($.fn.dataTable.tables(true)).DataTable().columns.adjust();

            //$('#tblList').DataTable({        
            //    "initComplete": function (settings, json) {
            //        $("#tblList").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");
            //    },
            //});

        });


        function BindTable() {
            let payoutno = $('#<%=ddlDateRange.ClientID%>').val(),
                Payout_Fillter = $('#<%=ddl_Payout_Fillter.ClientID%>').val(),
                UserId = $('#<%=txt_Userid.ClientID%>').val(),
                IsKYC = $('#<%=ddl_KYC.ClientID%>').val(),
                RankId = $('#<%=ddl_Rank.ClientID%>').val(),
                ReqTypeSponsor = $("input[name='<%=rdoReqTypeSponsor_list.UniqueID%>']:radio:checked").val(),
                Condition = $('#<%=txt_Condition.ClientID%>').val();
            if (Condition == "") {
                Condition = "0";
            }
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ payoutno: "' + payoutno + '", Payout_Fillter: "' + Payout_Fillter + '", UserId: "' + UserId + '", IsKYC: "' + IsKYC + '", RankId: "' + RankId + '" , ReqTypeSponsor: "' + ReqTypeSponsor + '", Condition: "' + Condition + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        //let Download = '';
                        //if (parseInt(data.d[i].Tlper) <= 7)
                        //    Download = '<a href="Template_Starter_fund.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&UN=' + data.d[i].User_Name + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + data.d[i].PIN + '&RN=' + data.d[i].Dispatch_Amount + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename + '"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>';


                        json.push([i + 1,
                        data.d[i].Payout_Date,
                        '<a href="payoutstatementreport.aspx?n=' + data.d[i].Encode_Payout + '&id=' + data.d[i].Encode_Userid + '&uid=' + data.d[i].Encode_Appmstid + '"  class="btn btn-link"  style="padding: 0.175rem 0.687rem !important; color: blue;" target="_blank">' + data.d[i].appmstregno + '</a>',
                        data.d[i].User_Name,
                        data.d[i].Status,
                        data.d[i].Mobile,
                        ////data.d[i].Profit_Level,
                        data.d[i].PIN,
                        data.d[i].PAN,
                        data.d[i].Bank,
                        data.d[i].Branch,
                        data.d[i].Account_No,
                        data.d[i].IFSC_Code,

                        data.d[i].PPV,
                        data.d[i].GPV,
                        data.d[i].Matched,
                        data.d[i].Inc1,
                        data.d[i].Inc2,
                        data.d[i].Inc3,
                        data.d[i].Inc4,
                        data.d[i].Inc5,
                        data.d[i].Inc6,
                        data.d[i].Inc7,
                        //data.d[i].FSI,
                        //data.d[i].leadershipamt,
                        //data.d[i].ZM, 
                        //data.d[i].TF,
                        //data.d[i].HF,
                        //data.d[i].CF,

                        //data.d[i].RB,
                        //data.d[i].PR,
                        //data.d[i].PB, 
                        //data.d[i].GrowthAmt, 
                        data.d[i].Total_Income,
                        data.d[i].TDS,
                        data.d[i].PC,
                        data.d[i].Dispatch_Amount,
                        data.d[i].Remark,
                        data.d[i].PP,

                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        sScrollXInner: "100%",
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel'],
                        data: json,
                        columns: [
                            { title: "#" },
                            { title: "Payout<br> Date" },
                            { title: "User ID" },
                            // { title: "User Name" },
                            { title: "<div style='width:180px;'>User Name</div>" },

                            //{ title: "Status" },
                            //{ title: "Mobile" },
                            //Rank{ title: "Rank" },

                            { title: "<div style='width:60px;'>Status</div>" },
                            { title: "<div style='width:60px;'>Mobile</div>" },
                            { title: "<div style='width:60px;'>Rank</div>" },

                            { title: "PAN No." },
                            { title: "Bank" },
                            { title: "Branch" },

                            { title: "A/c No" },
                            { title: "IFSC" },
                            { title: "<div style='width:50px;'><%=method.PV%></div>" },
                            { title: "<div style='width:50px;'><%=method.GBV%></div>" },
                            { title: "Matched" },

                           // { title: "<%=method.PV%>" },
                            //{ title: "<%=method.GBV%>" },

                            { title: "Startup<br>Bonus" },
                            { title: "Performance<br>Bonus" },
                            { title: "Lifestyle<br>Bonus" },
                            { title: "Prime Club<br>Bonus" },
                            { title: "Leadership<br>Bonus" },
                            { title: "Royalty<br>Club Bonus" },
                            { title: "Self Purchase<br>Bonus" },
                            //{ title: "Self Rep.<br>Bonus" },
                            //{ title: "S.Matching<br>Bonus" },
                            //{ title: "StartUp<br>Bonus" }, 
                            //{ title: "Performace<br>Fund" },
                            //{ title: "Lifestyle<br>Fund" },
                            //{ title: "Prime Club<br>Bonus" },
                            //{ title: "Leadership<br>Bonus" },
                            //{ title: "Royalty<br>Club Bonus" },
                            //{ title: "DDD<br>Club Bonus" },

                            //{ title: "A<br>Club Bonus" }, 
                            { title: "Total<br>Income" },
                            { title: "TDS" },
                            { title: "Admin<br>Charges" },
                            { title: "Dispatch<br>Amount" },
                            { title: "Remark" },
                            { title: "Partial<br>Paid/Paid" },
                        ],
                        "lengthMenu": [[15, 50, 100, -1], [15, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages
                            $(api.column(12).footer()).html(api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(13).footer()).html(api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(14).footer()).html(api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(15).footer()).html(api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(16).footer()).html(api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(17).footer()).html(api.column(17).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(18).footer()).html(api.column(18).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(19).footer()).html(api.column(19).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(20).footer()).html(api.column(20).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(0));
                            $(api.column(21).footer()).html(api.column(21).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(0));
                            $(api.column(22).footer()).html(api.column(22).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(0));
                            $(api.column(23).footer()).html(api.column(23).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0).toFixed(0));
                            $(api.column(24).footer()).html(api.column(24).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(25).footer()).html(api.column(25).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            //$(api.column(26).footer()).html(api.column(26).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            //$(api.column(27).footer()).html(api.column(27).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                        }
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
