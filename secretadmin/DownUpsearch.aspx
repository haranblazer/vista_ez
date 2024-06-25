<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="DownUpsearch.aspx.cs" Inherits="user_downstatus" Title="Down Up Search"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" charset="utf-8">
        function Validate() {
            var uid = document.getElementById('<%=txtUserId.ClientID %>').value;
            var expid = /^[a-zA-Z0-9]*$/;
          if (uid == '') {
                alert("Please Enter User Id.");
                document.getElementById('<%=txtUserId.ClientID %>').focus();
                return false;
            }
            if (!expid.test(uid)) {
                alert("User Id Contains AlphaNumeric Value Without Space.");
                document.getElementById('<%=txtUserId.ClientID %>').focus();
                return false;
            }
        }
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Repurchase Downline or Upline Report</h4>
    
   
    <div class="row">
         <div class="col-sm-12">
         <%--<div id="LoaderImg" style="width: 100%; text-align:center; position:absolute; z-index:99999; display: none;">
            <img src="../images/toptime-logo-new.gif" alt="" style="height:200px" />
        </div>--%>
             </div>
        <div class="col-sm-3">
            <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="Enter User ID"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddlDOWNUP" runat="server" CssClass="form-control">
                <asp:ListItem Value="DOWN">Downline</asp:ListItem>
                <asp:ListItem Value="UP">Upline</asp:ListItem>
            </asp:DropDownList>
            <div class="clearfix">
            </div>

        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Paid" runat="server" CssClass="form-control">
                 <asp:ListItem Value="2">Paid & Active</asp:ListItem>
                <asp:ListItem Value="1">Paid</asp:ListItem>
                <asp:ListItem Value="0">Unpaid</asp:ListItem>
                <asp:ListItem Value="-1">All</asp:ListItem>
            </asp:DropDownList>
            <div class="clearfix">
            </div>

        </div>

        <div class="col-sm-1 col-xs-6">
          <%--  <button type="button" title="Search" class="btn btn-success" onclick="BindTable()">Search</button>--%>
            <input type="button" title="Search" value="Search" class="btn btn-success" onclick="BindTable()" />
            <%-- <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                OnClick="btnSearch_Click" />--%>
        </div>
        <div class="col-md-1 col-xs-6 text-right pull-right">
            <%--  <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                OnClick="ibtnExcelExport_Click" />
            <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
           <asp:ImageButton ID="ibtnPDFExport" runat="server" ImageUrl="images/pdf.gif" OnClick="ibtnPDFExport_Click" TabIndex="10" />--%>
        </div>
    </div>



    <hr />



    <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
    <div class="clearfix">
    </div>
    <br />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
            <tfoot align="right">
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
                    <%--<th></th>--%>
                </tr>
            </tfoot>
        </table>

        <%-- <asp:GridView ID="GridView1" runat="server" AllowPaging="true" EmptyDataText="No Record Found"
            AutoGenerateColumns="false" OnPageIndexChanging="GridView1_PageIndexChanging"
            PageSize="50" Width="100%" CellPadding="4" CellSpacing="1" CssClass="table table-striped table-hover mygrd" AllowSorting="true" OnSorting="OnSorting">
            <PagerSettings PageButtonCount="25" />
            <RowStyle ForeColor="#333333" />
            <Columns>
                <asp:TemplateField HeaderText="Sr.no">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="UserId" HeaderText="User ID" SortExpression="UserId" />
                <asp:BoundField DataField="UserName" HeaderText="Name" SortExpression="UserName" />
                <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" SortExpression="Mobile" />
                <asp:TemplateField HeaderText="Sponsor detail" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Left" SortExpression="SponsorId">
                    <ItemTemplate>
                        <%# Eval("SponsorName")!=null ? Eval("SponsorName")+" "+"("+ Eval("SponsorId")+")":"NONE"%>
                    </ItemTemplate>
                </asp:TemplateField> 
                <asp:BoundField DataField="PBV" HeaderText="PBV" SortExpression="PBV" />
                <asp:BoundField DataField="GBV" HeaderText="GBV" SortExpression="GBV" />
                <asp:BoundField DataField="Total_PBV" HeaderText="Total PBV" SortExpression="Total_PBV" />
                <asp:BoundField DataField="Total_Gbv" HeaderText="Total GBV" SortExpression="Total_Gbv" />
                <asp:BoundField DataField="TPV" HeaderText="TPV" SortExpression="TPV" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />

                <asp:BoundField DataField="MobileNo" HeaderText="MobileNo" SortExpression="MobileNo" />
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Left" HeaderText="Is Paid" SortExpression="IsPaid">
                    <ItemTemplate>
                        <%# Eval("IsPaid").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                    </ItemTemplate>
                </asp:TemplateField>


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
    <script> var $JDT = $.noConflict(true); </script>

    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("DownUpsearch.aspx")%>';
        $JDT(function () {
          //  BindTable();
        });


        function BindTable() {
            
            var UserId = $('#<%=txtUserId.ClientID%>').val(),
                DOWNUP = $('#<%=ddlDOWNUP.ClientID%>').val(),
                Paid = $('#<%=ddl_Paid.ClientID%>').val();

            if (UserId == "") {
                alert("Please enter userid.");
                return false;
            }
            else {
                Validate();
               /* return false;*/
            };
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ UserId: "' + UserId + '", DOWNUP: "' + DOWNUP + '", Paid: "' + Paid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        var IsPaid = "<span class='dotGrey' title='Not Optin'></span>";
                        if (data.d[i].IsPaid == "1")
                            IsPaid = "<span class='dotGreen' title='Is Optin'></span>";

                        json.push([
                            i + 1,
                            data.d[i].UserId,
                            data.d[i].UserName,
                            data.d[i].MobileNo,
                            data.d[i].SponsorName + ' (' + data.d[i].SponsorId + ')',

                            data.d[i].PBV,
                            data.d[i].GBV,
                            data.d[i].Total_PBV,
                            data.d[i].Total_Gbv,
                            //data.d[i].TPV,
                            data.d[i].RePurchase_rankName,
                            data.d[i].Status,
                            IsPaid,
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
                            { title: "Mobile No." },
                            { title: "Sponsor detail" },

                            { title: "Current<br> <%=method.PV%>" },
                            { title: "<%=method.GBV%>" },
                            { title: "Total Current <br><%=method.PV%>" },
                            { title: "Total <br> <%=method.GBV%>" },
                           // { title: "TPV" },
                            { title: "Gen. PIN" },
                            { title: "Status" },
                            { title: "Is Paid" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            //    // Total over all pages
                            $(api.column(1).footer()).html('Total:');
                            $(api.column(5).footer()).html(api.column(5).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
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

    <style>
        .dotGreen {
            height: 25px;
            width: 25px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 25px;
            width: 25px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>

</asp:Content>
