<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="LoyaltyWallet.aspx.cs" Inherits="User_LoyaltyWallet" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Loyalty Wallet Passbook</h4>
    <div class="row">
                    <div class="col-md-3 control-label">
                        Loyalty Wallet Balance
                    </div>
                    <div class="col-md-1 control-label">
                        <asp:Label ID="lblewallet" runat="server"></asp:Label>
                    </div>
                    <div class="col-md-1 control-label">
                        From :
                    </div>
                    <div class="col-md-2">
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-1 control-label">
                        To:
                    </div>
                    <div class="col-md-2">
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-1">
                        <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
                        <%--<asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-primary" />&nbsp;&nbsp;--%>
                    </div>
                    <div class="col-sm-1">
                        <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif"
                                OnClick="imgbtnExcel_Click" />--%>
                    </div>
                </div>
    <hr />
    <div class="clearfix"></div>
  

    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

        <%-- <asp:GridView ID="dglst" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            CssClass="table table-striped table-hover" HeaderStyle-BackColor="#fe6a00" HeaderStyle-ForeColor="#ffffff" Width="100%" OnPageIndexChanging="dglst_PageIndexChanging" PageSize="50" Style="margin-bottom: 0px;">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" Height="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="doe" HeaderText="Date" />
                <asp:BoundField DataField="Userid" HeaderText="User Id" />
                <asp:BoundField DataField="UserName" HeaderText="User Name" />

                <asp:BoundField DataField="Credit" HeaderText="Credit" />
                <asp:BoundField DataField="Debit" HeaderText="Debit" />
                <asp:BoundField DataField="Balance" HeaderText="Balance" />
                 
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <asp:Label ID="lbldesc" runat="server" Text='<%# Eval("descrip") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Transactiontype" HeaderText="Transaction Type" ItemStyle-Width="10%"></asp:BoundField>

                <asp:TemplateField HeaderText="Remark" ControlStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblremark" Width="150px" runat="server" Text='<%# Eval("Reason") %>'></asp:Label>
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
        var pageUrl = '<%=ResolveUrl("LoyaltyWallet.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                            data.d[i].doe,
                            data.d[i].Userid,
                            data.d[i].UserName,
                            data.d[i].Credit,
                            data.d[i].Debit,
                            data.d[i].Balance,
                            data.d[i].descrip,
                            data.d[i].Transactiontype,
                             data.d[i].Reason,
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
                            { title: "Date" },
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "Credit" },
                            { title: "Debit" },
                            { title: "Balance" },
                            { title: "Description" },
                            { title: "Transaction Type" },
                            { title: "Remark" },
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



    <%--  <script type="text/javascript">
        var GridId = "<%=dglst.ClientID %>";
        var ScrollHeight = 400;
        window.onload = function () {
            debugger;
            var grid = document.getElementById(GridId);
            var gridWidth = grid.offsetWidth;
            var gridHeight = grid.offsetHeight;
            var headerCellWidths = new Array();
            for (var i = 0; i < grid.getElementsByTagName("TH").length; i++) {
                headerCellWidths[i] = grid.getElementsByTagName("TH")[i].offsetWidth;
            }
            grid.parentNode.appendChild(document.createElement("div"));
            var parentDiv = grid.parentNode;

            var table = document.createElement("table");
            for (i = 0; i < grid.attributes.length; i++) {
                if (grid.attributes[i].specified && grid.attributes[i].name != "id") {
                    table.setAttribute(grid.attributes[i].name, grid.attributes[i].value);
                }
            }
            table.style.cssText = grid.style.cssText;
            table.style.width = gridWidth + "px";
            table.appendChild(document.createElement("tbody"));
            table.getElementsByTagName("tbody")[0].appendChild(grid.getElementsByTagName("TR")[0]);
            var cells = table.getElementsByTagName("TH");

            var gridRow = grid.getElementsByTagName("TR")[0];
            for (var i = 0; i < cells.length; i++) {
                var width;
                if (headerCellWidths[i] > gridRow.getElementsByTagName("TD")[i].offsetWidth) {
                    width = headerCellWidths[i];
                }
                else {
                    width = gridRow.getElementsByTagName("TD")[i].offsetWidth;
                }
                cells[i].style.width = parseInt(width) + "px";
                gridRow.getElementsByTagName("TD")[i].style.width = parseInt(width) + "px";
            }
            parentDiv.removeChild(grid);

            var dummyHeader = document.createElement("div");
            dummyHeader.appendChild(table);
            parentDiv.appendChild(dummyHeader);
            var scrollableDiv = document.createElement("div");
            if (parseInt(gridHeight) > ScrollHeight) {
                gridWidth = parseInt(gridWidth) + 17;
            }
            scrollableDiv.style.cssText = "overflow:auto;height:" + ScrollHeight + "px;width:" + gridWidth + "px";
            scrollableDiv.appendChild(grid);
            parentDiv.appendChild(scrollableDiv);
        }
    </script>
    <style>
        .table {
            margin-bottom: 0px;
        }

        th {
            border: none;
        }
    </style>--%>
</asp:Content>
