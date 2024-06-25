<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="TotalBalance.aspx.cs" Inherits="secretadmin_TotalBalance" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Company Balance List</h4>
    </div>

   <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <%-- <div class="col-sm-2 col-xs-6 text-right">
        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif" OnClick="imgbtnExcel_Click" />
    </div>--%>

    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>


        <%--  <asp:GridView ID="GridView1" EmptyDataText="No record found" runat="server" AutoGenerateColumns="false" CellPadding="4"
                CellSpacing="1" CssClass="table table-striped table-hover" Width="100%" DataKeyNames="IsLink, LinkName"
                OnRowCommand="GridView1_RowCommand">
                <Columns>

                    <asp:TemplateField HeaderText="Details of Wallet Generation">
                        <ItemTemplate>
                            <%# Eval("Name")%>
                        </ItemTemplate>
                    </asp:TemplateField>
 

                    <asp:TemplateField HeaderText="Points">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkPoints" runat="server" Text='<%# Eval("Points")%>'
                                Enabled='<%#Eval("IsLink").ToString()=="0" ? false : true %>'
                                CssClass='<%#Eval("IsLink").ToString()=="0" ? "disabled " : "" %>'  
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                CommandName="Details"> </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField> 

                </Columns>
            </asp:GridView>--%>
    </div>
    <div class="clearfix">
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
        var pageUrl = '<%=ResolveUrl("TotalBalance.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        var Link = '';
                        if (data.d[i].IsLink == "0") {
                            Link = '<a style="color:blue;" href="javascript: void(0)">' + data.d[i].Points + '</a>';
                        }
                        else {
                            Link = '<a style="color:blue;" href="../secretadmin/WalletDetails.aspx?Id=' + data.d[i].LinkName + '">' + data.d[i].Points + '</a>';
                        }

                        json.push([
                            data.d[i].Name,
                            Link,
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
                            { title: "Details of Wallet Generation" },
                            { title: "Points" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,

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


