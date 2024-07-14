<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="brancheslist.aspx.cs" Inherits="user_branches_list" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       <h4 class="fs-20 font-w600  me-auto float-left mb-0">Franchise List</h4>
<div class="row">

                        <div class="col-sm-2">
                            <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="Search By Franchise ID/Name"></asp:TextBox>
                        </div>

                        <div class="col-sm-2 ">
                            <asp:DropDownList ID="ddl_State" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>

                        <div class="col-sm-2 ">
                            <asp:DropDownList ID="ddl_Type" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <input type="button" value="Search" onclick="BindTable()" class="btn btn-primary" />
                            <%-- <button id="btnSearch" runat="server" class="btn btn-primary" title="Search" onserverclick="btnSearch_Click">
                                <i class="fa fa-search"></i>&nbsp;Search
                            </button>--%>
                        </div>

                        <div class="col-sm-2">
                            <%--<asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                                OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                                <asp:ListItem>25</asp:ListItem>
                                <asp:ListItem>50</asp:ListItem>
                                <asp:ListItem>100</asp:ListItem>
                                <asp:ListItem>All</asp:ListItem>
                            </asp:DropDownList>--%>
                        </div>
                        <div class="col-md-2 text-right">
                            <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Style="margin-left: 0px" Width="20px" />
                            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                Style="margin-left: 0px" Width="23px" />--%>
                            <%--<asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif" 
                    onclick="imgbtnPdf_Click" />--%>
                        </div>

                    </div>


    <hr />


    <div class="col-sm-8" style="display: none">
        <asp:Label ID="lblCount" runat="server" Font-Bold="true"></asp:Label>
    </div>
    <div class="clearfix"></div>
  
    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

        <%--   <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover" HeaderStyle-BackColor="#fe6a00" HeaderStyle-ForeColor="#ffffff"
            EmptyDataText="record not found." AllowPaging="True"
            OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5">
            <Columns> 
                <asp:BoundField HeaderText="Franchise Id" DataField="FranchiseId"></asp:BoundField>
                <asp:BoundField HeaderText="Franchise Name" DataField="FranchiseName"></asp:BoundField>
                <asp:BoundField HeaderText="Type" DataField="Type"></asp:BoundField>
                <asp:TemplateField HeaderText="Status" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("Status").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField HeaderText="State" DataField="State"></asp:BoundField>
                <asp:BoundField HeaderText="District" DataField="District"></asp:BoundField>
                <asp:BoundField HeaderText="City" DataField="City"></asp:BoundField>
                <asp:BoundField HeaderText="PIN" DataField="PIN"></asp:BoundField>
                <asp:BoundField HeaderText="Address" DataField="Address"></asp:BoundField>

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
        var pageUrl = '<%=ResolveUrl("brancheslist.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var Name = $('#<%=txtSearch.ClientID%>').val();
            var State = $('#<%=ddl_State.ClientID%>').val()== "" ? "" :$('#<%=ddl_State.ClientID%> option:selected').text() ;
            var FranType = $('#<%=ddl_Type.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Name: "' + Name + '", State: "' + State + '", FranType: "' + FranType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = []; 
                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                               data.d[i].FranchiseId,
                               data.d[i].FranchiseName,
                               data.d[i].Type,
                               data.d[i].Status == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>",
                               data.d[i].State,
                               data.d[i].District,
                               data.d[i].City,
                               data.d[i].PIN,
                               data.d[i].Address,
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
                            { title: "Franchise Id" },
                            { title: "Franchise Name" },
                            { title: "Type" },
                            { title: "Status" },
                            { title: "State" },
                            { title: "District" },
                            { title: "City" },
                            { title: "PIN" },
                            { title: "Address" },
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

    <%--   <script type="text/javascript">
        var GridId = "<%=GridView1.ClientID %>";
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
