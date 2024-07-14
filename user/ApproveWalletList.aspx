<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="ApproveWalletList.aspx.cs" Inherits="user_ApproveWalletList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
       
        #tooltip {
            position: absolute;
            border: 2px solid red;
            background-color: #FFFFE1;
            padding: 2px 5px;
            text-align: left;
            font-family: arial;
            font-size: 12px;
            color: #000000;
            display: none;
            width: auto;
            height: auto;
        }
    </style>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Wallet Request Report List</h4>
    <div class="row">
                    <div class="col-md-2 control-label">
                        Request Type :
                    </div>
                    <div class="col-sm-2 control-label">
                        <asp:RadioButtonList ID="rdbtn1" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="0" Selected="True"> Wallet Request List</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <div class="col-sm-1 control-label">
                        From :
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtFromdate" runat="server" CausesValidation="True" ToolTip="dd/mm/yyyy"
                            ValidationGroup="a" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-1 control-label">
                        To :
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtTodate" runat="server" CausesValidation="True" ToolTip="dd/mm/yyyy"
                            ValidationGroup="a" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-1">
                        <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
                        <%-- <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" OnClick="Button1_Click"
                            Text="SHOW" ValidationGroup="a" />--%>
                    </div>
                </div>

    <%--  <div class="col-md-12 text-right">

        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
            Height="30px" />
        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
            Style="margin-left: 0px" Height="30px" />
        <asp:LinkButton ID="LinkButton3" OnClick="imgbtnPdf_Click" CssClass="btn" runat="server"
            Visible="false"><i class="icol-doc-pdf"></i> PDF Export</asp:LinkButton>
        <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="images/print.png" OnClientClick="printpage()"
            Style="margin-left: 0px" Height="30px" />
    </div>--%>
    <hr />
     <div class="clearfix"></div>
    
    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

        <%--<div class="col-md-12" style="text-align: justify">
            <asp:Label ID="LblTotalRecord" runat="server" Font-Bold="True" EnableViewState="False"
                Font-Size="Larger"></asp:Label>
            <asp:Label ID="LblAmount" runat="server" Font-Bold="True" EnableViewState="False"
                Font-Size="Larger"></asp:Label><br />
        </div>
        <br />
        <asp:GridView ID="GridView1" DataKeyNames="srno" EmptyDataText="No data found." runat="server"
            AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-striped table-hover mygrd"
            Width="100%" OnPageIndexChanging="dglst_PageIndexChanging" PageSize="50" Font-Size="9pt"
            OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" Height="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="userid" HeaderText="UserId" />
                <asp:BoundField DataField="fname" HeaderText="Name" />
                <asp:BoundField DataField="amt" HeaderText="Amount" />
                <asp:BoundField DataField="redate" HeaderText="Request Date" />
                <asp:BoundField DataField="status" HeaderText="Status" />
                <asp:BoundField DataField="apdate" HeaderText="Approved Date" />
                <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkbtnView" ToolTip='<%#Eval("payDetail") %>' Text="Payment Details"
                            CssClass="tooltip" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            runat="server">Payment</asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
               
            </Columns>
        </asp:GridView>--%>
    </div>
     <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 

    <script> var $JD = $.noConflict(true); </script>
     <script type="text/javascript"> 
         $JD(function () { 
             $JD('#<%=txtFromdate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
             $JD('#<%=txtTodate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' }); 
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

        var pageUrl = '<%=ResolveUrl("ApproveWalletList.aspx")%>';
        $JDT(function () {
            BindTable(); 
        });


        function BindTable() {
            var fromdate = dateFormate($('#<%=txtFromdate.ClientID%>').val());
            var Todate = dateFormate($('#<%=txtTodate.ClientID%>').val());
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{fromdate: "' + fromdate + '", Todate: "' + Todate + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                            data.d[i].userid,
                            data.d[i].fname,
                            data.d[i].amt,
                            data.d[i].redate,
                            data.d[i].status,
                            data.d[i].apdate,
                            data.d[i].Remarks,
                            data.d[i].payDetail,
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
                            { title: "SNo" },
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "Amount" },
                            { title: "Request Date" },
                            { title: "Status" },
                            { title: "Approved Date" },
                            { title: "Remarks" },
                            { title: "Payment Details" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                    });
                },
                error: function (result) {
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
