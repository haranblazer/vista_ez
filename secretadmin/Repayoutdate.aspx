<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="Repayoutdate.aspx.cs" Inherits="secretadmin_Repayoutdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto"><%=method.REPURCHASE %> Payout Date</h4>
    </div>
 
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <asp:GridView ID="dgr" runat="server" OnRowCommand="dgr_RowCommand" AutoGenerateColumns="False"
                EmptyDataText="Payout date not found." CssClass="mygrd table table-striped table-hover"
                OnRowDataBound="dgr_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="payoutno" HeaderText="Payout No"></asp:BoundField>
                    <asp:BoundField DataField="PayFromDate" HeaderText="From Date"></asp:BoundField>
                    <asp:HyperLinkField DataTextField="PayToDate" DataNavigateUrlFields="PayToDate" DataNavigateUrlFormatString="adminpayout22.aspx?n={0}"
                        HeaderText="To Date" ControlStyle-ForeColor="Blue"/>
                    <%--  <asp:ButtonField CommandName="Show" Text="Show" />
                        <asp:ButtonField CommandName="Hide" Text="Hide" />--%>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkStatus" runat="server" CommandName="SH" CommandArgument='<%# Eval("payoutno") %>'
                                Text='<%# Eval("pstatus") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" Visible="false">
                        <ItemTemplate>
                            <asp:LinkButton ID="linkButton1" runat="server" Text='<%# Eval("sentsms") %>' CommandName="s"
                                CommandArgument='<%# Eval("payoutno") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </table>


        <div class="clearfix"></div>
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
        $JDT(document).ready(function () {

            $JDT("#<%=dgr.ClientID %>").prepend($("<thead></thead>").append($("#<%=dgr.ClientID %>").find("tr:first"))).DataTable(
                {
                    "bLengthChange": true,
                    "dom": 'Blfrtip',
                    "buttons": [
                        'copyHtml5',
                        'excelHtml5',
                        'csvHtml5'
                    ],
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "pageLength": 25,
                    "bDestroy": true,
                    "bSort": true,
                    "bFilter": true,
                    "bPaginate": true
                });
        });
    </script>
</asp:Content>
