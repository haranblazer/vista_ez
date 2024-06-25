<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="SponsorDatewise.aspx.cs" Inherits="admin_SponsorDatewise" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--  <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>--%>
    <%--end date picker link--%>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Sponsor Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <%-- <asp:Panel ID="pnlUtility" runat="server" DefaultButton="Button2">--%>
    <div class="form-group card-group-row row">

        <div class="col-sm-2">

            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                title="Date should be correct in format ex:- 'dd/mm/yyyy'." required="required"
                placeholder="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">

            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                title="Date should be correct in format ex:- 'dd/mm/yyyy'." required="required"
                placeholder="dd/mm/yyyy"></asp:TextBox>
        </div>


        <%--  <div class="col-sm-2">
                <asp:DropDownList ID="ddlPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                    <asp:ListItem Value="25">25</asp:ListItem>
                    <asp:ListItem Value="50">50</asp:ListItem>
                    <asp:ListItem Value="100">100</asp:ListItem>
                    <asp:ListItem>All</asp:ListItem>
                </asp:DropDownList>
            </div>--%>



        <div class="col-sm-2 control-label">No Of Pairs</div>
        <div class="col-sm-1">
            <asp:TextBox ID="txt_NoOfPair" runat="server" CssClass="form-control" onkeypress="return onlyNumbers(event,this);">1</asp:TextBox>
        </div>

        <div class="col-sm-2 control-label">
            <asp:RadioButtonList ID="rdoReqTypePair" runat="server" CssClass="radios" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True" Value=">=">>=</asp:ListItem>
                <asp:ListItem Value="=">=</asp:ListItem>
                <asp:ListItem Value="<="><=</asp:ListItem>
            </asp:RadioButtonList>
        </div>

          <div class="clearfix">
    </div>
        <div class="col-sm-2 control-label">
            No Of Sponsors
        </div>
        <div class="col-sm-1">
            <asp:TextBox ID="txtNoOfSponsor" runat="server" CssClass="form-control" onkeypress="return onlyNumbers(event,this);">1</asp:TextBox>
        </div>

        <div class="col-sm-2 control-label">
            <asp:RadioButtonList ID="rdoReqTypeSponsor_list" runat="server" CssClass="radios" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True" Value=">=">>=</asp:ListItem>
                <asp:ListItem Value="=">=</asp:ListItem>
                <asp:ListItem Value="<="><=</asp:ListItem>
            </asp:RadioButtonList>
        </div>

        <div class="col-sm-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
            <%--<asp:Button ID="Button2" runat="server" OnClick="Button1_Click" Text="Show" CssClass="btn btn-primary"
                    ValidationGroup="Show" />--%>
        </div>
    </div>

    <%-- <div class="pull-right">
            <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                OnClick="ibtnExcelExport_Click" />
            <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />

        </div>--%>
    <%-- </asp:Panel>--%>
    <%-- <div class="form-group">
        <asp:Label ID="lblcount" runat="server" Font-Bold="True"></asp:Label>
        <strong><span style="font-size: 10pt; font-family: Arial">Total Sponsor:</span>
            <asp:Label ID="lblTotalSponsor" runat="server" Text="0" Font-Names="Arial" Font-Size="Small"></asp:Label>
        </strong>
    </div>--%>

    <hr />


    <div class="clearfix">
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
                </tr>
            </tfoot>
        </table>


        <%-- <cc1:PagingGridView ID="dgr" runat="server" AllowPaging="True" PageSize="50" AutoGenerateColumns="False"
            EmptyDataText="No record found." OnPageIndexChanging="dgr_PageIndexChanging"
            CssClass="table table-striped table-hover " Width="100%" ShowFooter="True" OnRowDataBound="dgr_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="SR.No.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" Height="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="AppMstregno" HeaderText="User Id" />
                <asp:BoundField DataField="Name" HeaderText="Name">
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="appmstmobile" HeaderText="Mobile No" />
                <asp:BoundField DataField="sponsorid" HeaderText="Sponsor Id" />
                <asp:BoundField DataField="sponsorname" HeaderText="Sponsor Name" />
                 
                <asp:TemplateField HeaderText="Total Sponsor">
                    <ItemTemplate>
                        <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("AppMstSponsorTotal").ToString()%>'>
                        </asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="No Of Pairs">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Pair" runat="server" Text='<%#Eval("TotalPair").ToString()%>'>
                        </asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalPair" runat="server" Font-Bold="True"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                 
                <asp:BoundField DataField="AppPaidDateTime" HeaderText="Date Of Paid" />
                <asp:BoundField DataField="AppMstCity" HeaderText="City">
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="AppMstState" HeaderText="State">
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
            </Columns>
        </cc1:PagingGridView>--%>
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
        var pageUrl = '<%=ResolveUrl("SponsorDatewise.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                sponsortotal = $('#<%=txtNoOfSponsor.ClientID%>').val(),
                ReqTypeSponsor = $("input[name='<%=rdoReqTypeSponsor_list.UniqueID%>']:radio:checked").val(),
                NoOfPair = $('#<%=txt_NoOfPair.ClientID%>').val(),
                    ReqTypePair = $("input[name='<%=rdoReqTypePair.UniqueID%>']:radio:checked").val();


            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", sponsortotal: "' + sponsortotal + '", ReqTypeSponsor: "' + ReqTypeSponsor + '", NoOfPair: "' + NoOfPair + '", ReqTypePair: "' + ReqTypePair + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                        data.d[i].AppMstregno,
                        data.d[i].Name,
                        data.d[i].appmstmobile,
                        data.d[i].sponsorid,
                        data.d[i].sponsorname,
                        data.d[i].AppMstSponsorTotal,
                        data.d[i].TotalPair,
                        data.d[i].AppPaidDateTime,
                        data.d[i].AppMstCity,
                        data.d[i].AppMstState,
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
                            { title: "User Id" },
                            { title: "Name" },
                            { title: "Mobile No" },
                            { title: "Sponsor Id" },

                            { title: "Sponsor Name" },
                            { title: "Total Sponsor" },
                            { title: "No Of Pairs" },
                            { title: "Date Of Paid" },
                            { title: "City" },
                            { title: "State" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages

                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b) }, 0));

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
