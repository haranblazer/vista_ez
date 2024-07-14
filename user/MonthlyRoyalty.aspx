<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="MonthlyRoyalty.aspx.cs" Inherits="User_MonthlyRoyalty" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Monthly Loyalty Purchase </h4>
    <div class="form-group card-group-row row">


                    <div class="col-sm-1 control-label">Month</div>
                    <div class="col-sm-2 ">
                        <asp:DropDownList ID="ddl_Month" CssClass="form-control" runat="server">
                        </asp:DropDownList>
                    </div>


                    <div class="col-sm-1">
                        <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
                        <%-- <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-primary" />--%>
                    </div>

                    <div class="col-sm-6">
                    </div>
                    <div class="col-sm-2 pull-right">
                        <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                Width="25px" />
                            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                Style="margin-left: 0px" Width="26px" />--%>
                    </div>
                </div>

  <hr />
    <div class="clearfix"></div>
   


    <%-- <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>--%>
    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

        <%-- <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
            Font-Names="Arial" Font-Size="Small" PageSize="50" AutoGenerateColumns="False"
            EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="dglst_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="UserId" DataField="Appmstregno" />
                <asp:BoundField HeaderText="User Name" DataField="Appmstfname" />
                <asp:BoundField HeaderText="InvoiceNo" DataField="InvoiceNo" />
                <asp:BoundField HeaderText="Invoice Amount" DataField="Amount" />
                <asp:TemplateField HeaderText="Invoice Status" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("Status").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:BoundField HeaderText="Date" DataField="Doe" />
                <asp:TemplateField HeaderText="Royalty Status">
                    <ItemTemplate>
                        <%# Eval("RoyaltyStatus").ToString() == "1" ? "<span style='color:green;'>" + Eval("RStatus") + "</span>" : "<span style='color:red;'>"+ Eval("RStatus") +"</span>"%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField HeaderText="Royalty Type" DataField="RoyaltyType" />
            </Columns>
        </asp:GridView>--%>
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
    <script type="text/javascript">
        var $JDT = $.noConflict(true);
        var pageUrl = '<%=ResolveUrl("MonthlyRoyalty.aspx")%>';
        $JDT(function () {
           // $.noConflict(true);
            BindTable();
        });


        function BindTable() {
            var Months = $('#<%=ddl_Month.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Months: "' + Months + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = []; 
                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                            data.d[i].Appmstregno,
                            data.d[i].Appmstfname,
                            data.d[i].InvoiceNo,
                            data.d[i].Amount,
                            data.d[i].Status == '1' ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>",
                            data.d[i].Doe,
                            data.d[i].RoyaltyStatus == '1' ? "<span style='color:green;'>" + data.d[i].RStatus + "</span>" : "<span style='color:red;'>" + data.d[i].RStatus + "</span>",
                            data.d[i].RoyaltyType,
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
                            { title: "Invoice No." },
                            { title: "<%=method.Invoice_Amount%>" },
                            { title: "Invoice Status" },
                            { title: "Date" },
                            { title: "Royalty Status" },
                            { title: "Royalty Type" },
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
    </script>


    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>
</asp:Content>

