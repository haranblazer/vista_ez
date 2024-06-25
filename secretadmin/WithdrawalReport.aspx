<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" EnableEventValidation="false"
    CodeFile="WithdrawalReport.aspx.cs" Inherits="admin_WithdrawalReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Cash withdrawal report </h4>
    <div id="LoaderImg" style="width: 100%; text-align: center; position: absolute; z-index: 99999; display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="form-group card-group-row row">
        <div class="col-md-3">
            <span style="color: Red">Note : Only CSV file allowed</span>
        </div>

        <div class="col-md-4">
            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-file-input form-control" accept=".csv" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="FileUpload1"
                SetFocusOnError="true" Display="None" ErrorMessage="Only  csv files are allowed !!!"
                Font-Size="10pt" ForeColor="#C00000" ValidationExpression="(.*\.([cC][sS][vV])$)"
                ValidationGroup="C"></asp:RegularExpressionValidator>
            <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="C" HeaderText="Please Check the following..." />
        </div>

        <div class="col-md-3">
            <asp:Button ID="btnbulkcopy" runat="server" Text="Upload" ValidationGroup="C" CssClass="btn btn-primary"
                OnClick="btnbulkcopy_Click" OnClientClick="javascript:return Validation();" />
            &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="WithdrawalReport.aspx" class="btn btn-danger">Reset</a>
        </div>
        <div class="clearfix"></div>
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="col-md-2" style="display: none;">
            <asp:DropDownList ID="ddlReqType" runat="server" CssClass="form-control">
                <asp:ListItem Value="1" runat="server">User</asp:ListItem>
                <%-- <asp:ListItem Value="2" runat="server">Franchise</asp:ListItem>--%>
            </asp:DropDownList>
        </div>

        <div class="col-md-2 col-xs-6">
            <asp:TextBox ID="txt_userid" runat="server" CssClass="form-control" Placeholder="Enter User Id."></asp:TextBox>
        </div>

         <div class="col-md-2 col-xs-6">
            <asp:TextBox ID="txt_TranId" runat="server" CssClass="form-control" Placeholder="Enter Tran Id."></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>

        <%--<div class="col-md-2 col-xs-12 pull-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />
        </div>--%>
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


        <%-- <asp:GridView ID="GrdWithdraw" EmptyDataText="No record found !" border="1" runat="server" AllowPaging="True" CellPadding="4" Font-Names="Arial"
            Font-Size="Small" PageSize="50" AutoGenerateColumns="False" OnPageIndexChanging="dgrd_PageIndexChanging" Width="100%"
            CssClass="table" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <FooterTemplate>Total:</FooterTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="withdrawid" HeaderText="TranId" />
                <asp:BoundField DataField="userId" HeaderText="User ID" />
                <asp:BoundField DataField="fname" HeaderText=" UserName" />
                <asp:BoundField DataField="WAmount" HeaderText="Withdrawal Amount" />
                <asp:BoundField DataField="Additions" HeaderText="Additions" />
                <asp:BoundField DataField="Deductions" HeaderText="Deductions" />
                <asp:BoundField DataField="Dispatch" HeaderText="Net Amount" />
                <asp:BoundField DataField="withdrawdate" HeaderText="Withdrawal Date" />
                <asp:BoundField DataField="RequestType" HeaderText="Request Type" />
                <asp:BoundField DataField="Bankname" HeaderText="Bank Name" />
                <asp:BoundField DataField="Branch" HeaderText="Branch" />
                <asp:BoundField DataField="AccountNo" HeaderText="Account No." />
                <asp:BoundField DataField="IFSCode" HeaderText="IFS Code" />
                <asp:BoundField DataField="panno" HeaderText="PAN" /> 
                <asp:BoundField DataField="PaymentDate" HeaderText="PaymentDate" />
                <asp:BoundField DataField="PaymentDetail" HeaderText="PaymentDetail" />
                <asp:BoundField DataField="Narration" HeaderText="Narration" />
                <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
            </Columns>
        </asp:GridView>--%>
    </div>
    <div class="clearfix"></div>

     <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function Validation() {
            var file = $('input[type=file]').val();
            var MSG = "";
            if (!file) {
                MSG += "\n Please Select CSV File !!!";
            }
            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to upload this file.？')) {
                return false;
            }
        }
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
        var pageUrl = '<%=ResolveUrl("WithdrawalReport.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                ReqType = $('#<%=ddlReqType.ClientID%>').val(), 
                TranId = $('#<%=txt_TranId.ClientID%>').val(),
                userid = $('#<%=txt_userid.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", ReqType: "' + ReqType + '", userid: "' + userid + '", TranId: "' + TranId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                        data.d[i].withdrawid,
                        data.d[i].userId,
                        data.d[i].fname,
                        data.d[i].WAmount,

                        data.d[i].Additions,
                        data.d[i].Deductions,
                        data.d[i].Dispatch,
                        data.d[i].withdrawdate,
                        data.d[i].RequestType,

                        data.d[i].Bankname,
                        data.d[i].Branch,
                        data.d[i].AccountNo,
                        data.d[i].IFSCode,
                        data.d[i].panno,

                        data.d[i].PaymentDate,
                        data.d[i].PaymentDetail,
                        data.d[i].Narration,
                        data.d[i].Remarks,
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
                            { title: "TranId" },
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Withdrawal Amount" },

                            { title: "Additions" },
                            { title: "Deductions" },
                            { title: "Net Amount" },
                            { title: "Withdrawal Date" },
                            { title: "Request Type" },

                            { title: "Bank Name" },
                            { title: "Branch" },
                            { title: "Account No." },
                            { title: "IFS Code" },
                            { title: "PAN" },

                            { title: "PaymentDate" },
                            { title: "PaymentDetail" },
                            { title: "Narration" },
                            { title: "Remarks" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            // Total over all pages
                            $(api.column(4).footer()).html(api.column(4).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(6).footer()).html(api.column(6).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(7).footer()).html(api.column(7).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
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
