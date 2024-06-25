<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AssociatePurchases.aspx.cs" Inherits="secretadmin_AssociatePurchases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Associate Purchases Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="form-group card-group-row row">
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Month" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Userid"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_RPV_Rs" runat="server" CssClass="form-control">
               <%-- <asp:ListItem Value="RPV">RPV</asp:ListItem>--%>
                <asp:ListItem Value="Rs">Rs</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Values" runat="server" CssClass="form-control" placeholder="Enter Values"
                onkeypress="return onlyNumbers(event,this);" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>

    <hr />
    <div class="clearfix"></div>
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
            <tfoot align="center">
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
        var pageUrl = '<%=ResolveUrl("AssociatePurchases.aspx")%>';

        function BindTable() {
            let Months = $('#<%=ddl_Month.ClientID%>').val(),
                Userid = $('#<%=txt_Userid.ClientID%>').val(),
                RPV_Rs = $('#<%=ddl_RPV_Rs.ClientID%>').val(),
                Values = $('#<%=txt_Values.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetData',
                data: '{Months: "' + Months + '", Userid: "' + Userid + '", RPV_Rs: "' + RPV_Rs + '", Values: "' + Values + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                        data.d[i].UserId,
                        data.d[i].UserName,
                        data.d[i].Mobile,
                        data.d[i].UserState,
                        data.d[i].District,
                        data.d[i].RankName,
                        data.d[i].Amount,
                        data.d[i].TotalBV,
                        //data.d[i].DiamondID,
                        //data.d[i].DiamondName,
                        data.d[i].DOB,
                        data.d[i].Gender,
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
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "Mobile" },
                            { title: "State" },
                            { title: "District" },
                            { title: "Rank" },
                            { title: "Invoice <br> Values" },
                            { title: "RPV" },
                            //{ title: "Diamond <br> Id" },
                            //{ title: "Diamond <br> Name" },
                            { title: "DOB" },
                            { title: "Gender" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };

                            // Total over all pages
                            $(api.column(1).footer()).html('Total:');

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


</asp:Content>

