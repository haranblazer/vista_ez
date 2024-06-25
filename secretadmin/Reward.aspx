<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    EnableEventValidation="false" AutoEventWireup="true" CodeFile="Reward.aspx.cs"
    Inherits="secretadmin_Reward" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript"> var $JD = $.noConflict(true); </script>
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
        var pageUrl = '<%=ResolveUrl("Reward.aspx")%>';
        $JDT(function () {
            alert();
            debugger;

            bindtable();
        });

        function bindtable() {
            $('#LoaderImg').show();
            var fromDate = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var toDate = dateFormate($('#<%=txtToDate.ClientID%>').val());
            var RewardList = $('#<%=ddlRewardList.ClientID%>').val();

            $.ajax({

                type: "POST",
                url: pageUrl + '/bindtable',
                data: '{fromDate:"' + fromDate + '",toDate:"' + toDate + '",RewardList:"' + RewardList + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        let SubmitButton = '', srno = '', RemarksTextbox = '', TranNo_Textbox = '';
                        srno =  data.d[i].srno;
                        if (data.d[i].TStatus == "1") {
                            SubmitButton = '<input type="button" value="Submitted" class="btn btn-success"/ >';
                            RemarksTextbox = data.d[i].Remarks;
                            TranNo_Textbox = data.d[i].Tran_No;

                        }
                        else {
                            RemarksTextbox = '<input type="text" id="txt_remark' + srno + '" class="form-control" />';
                            TranNo_Textbox = '<input type="text" id="txt_tran_no' + srno + '" class="form-control" />';
                            SubmitButton = '<input type="button" value="Submit" class="btn btn-success" onclick="Submit(' + srno + ')">';
                        }
                        json.push([i + 1,
                        //'<a target="_blank" href="purchaseorderbill.aspx?id=' + data.d[i].srno + '" >' + data.d[i].Order_No + '</a>',

                        //  LoginStatus


                        // data.d[i].Login,

                        data.d[i].User_ID,
                        data.d[i].User_Name,
                        data.d[i].Reward,
                        data.d[i].Doe,
                        data.d[i].L_point,
                        data.d[i].R_point,
                            TranNo_Textbox,
                            //data.d[i].Tran_No,
                            // data.d[i].Remarks
                            RemarksTextbox,
                            SubmitButton

                        ]);
                    }
                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "#" },


                            { title: "User ID" },
                            { title: "User Name" },
                            { title: "Reward" },
                            { title: "Doe" },
                            { title: "L point" },
                            { title: "R point" },
                            { title: "Tran No." },
                            { title: "Remarks" },
                            { title: "Delivered" }

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    (result);
                }
            });
        }
        function Submit(srno) {
            var Remarks = $('#txt_remark' + srno).val();
            var Tran_No = $('#txt_tran_no' + srno).val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Submit',
                data: '{srno:"' + srno + '",Remarks:"' + Remarks + '",Tran_No:"' + Tran_No + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        bindtable();
                    }
                   
                },
                error: function (result) {
                    (result);
                }
            });
        }


    </script>

    <%-- <script type="text/javascript">
        $JDT(document).ready(function () {
            $JDT("#<%=gridlist.ClientID %>").prepend($("<thead></thead>").append($("#<%=gridlist.ClientID %>").find("tr:first"))).DataTable(
            {
            "bLengthChange": true,
            "dom": 'Blfrtip',
            "buttons": [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5'
            ],
            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
            "pageLength": 25,
            "bDestroy": true,
            "bSort": true,
            "bFilter": true,
            "bPaginate": true
            });
        });
    </script>--%>

    <div class="card">
        <div class="card-header">
            <h4 class="card-title">Reward List</h4>
        </div>

        <div class="card-body">


            <div class="row">
                <div class="col-sm-1 control-label">
                    From
                </div>
                <div class="col-sm-2">

                    <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                        MaxLength="10" CssClass="form-control" title="From date should be as dd/mm/yyyy"
                        required="required"></asp:TextBox>
                </div>
                <div class="col-sm-1 control-label">
                    To
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                        MaxLength="10" CssClass="form-control" title="To date should be as dd/mm/yyyy"
                        required="required"></asp:TextBox>
                </div>

                 <div class="col-sm-3">
                    <asp:DropDownList ID="ddlRewardList" runat="server" CssClass="form-control">
                       <%-- <asp:ListItem Value="0">--Select Reward--</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>

                <div class="col-sm-1"> 
<input type="button" value="Search" class="btn btn-success" onclick="bindtable()" />
                </div>
               
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="control-label" Font-Bold="true"></asp:Label>
            <hr />
            <div class="table table-responsive">
                <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
                </table>
                <%--  <asp:GridView ID="gridlist" runat="server" CssClass="table table-striped table-hover mygrd" 
                        DataKeyNames="srno,TransactionID,remarks, TStatus"
                        PageSize="50" AutoGenerateColumns="false" Width="100%" EmptyDataText=" "
                        OnPageIndexChanging="gridlist_PageIndexChanging"
                        OnRowDataBound="gridlist_RowDataBound" OnRowCommand="gridlist_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="userid" HeaderText="User ID" />
                            <asp:BoundField DataField="name" HeaderText="User Name" />
                            <asp:BoundField DataField="reward" HeaderText="Reward" />
                            <asp:BoundField DataField="doe" HeaderText="Doe" />
                            <asp:BoundField DataField="leftpoint" HeaderText="left point" />
                            <asp:BoundField DataField="rightpoint" HeaderText="Right point" />

                            <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                HeaderText="Transaction No.">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtdraftno" runat="server" CssClass="form-control" Text='<%# Eval("transactionid")%>' Style="max-width: 220px; min-width: 180px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtcomment" runat="server" CssClass="form-control" Text='<%# Eval("remarks") %>' Style="max-width: 220px; min-width: 180px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delivered">
                                <ItemTemplate>
                                   <asp:Label ID="lbl_Delivere" runat="server"></asp:Label>
                                    <asp:LinkButton ID="lnkbtnDelivere" CommandName="Delivere" Text="Submit"
                                        CommandArgument='<%#((GridViewRow)Container).RowIndex %>' runat="server" ReadOnly="True" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>--%>
            </div>
            <%--                <asp:Button ID="btnupdate" runat="server" OnClick="btnupdate_Click" Text="Update" CssClass="btn btn-success" Visible="false" />--%>
            <%--                                      <button type="button"  tabindex="3" title="Search" class="btn btn-success" onclick="bindtable()">Search</button>--%>
        </div>
    </div>
</asp:Content>
