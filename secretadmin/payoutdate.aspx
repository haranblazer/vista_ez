<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="payoutdate.aspx.cs" Inherits="admin_payoutdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto"><%=method.BINARY %> Date</h4>
    </div>


    <!-- TitleActions -->
    <div class="table-responsive">
        <asp:GridView ID="dgr" runat="server" OnRowCommand="dgr_RowCommand" AutoGenerateColumns="False"
            EmptyDataText="Payout date not found." CssClass="mygrd table table-striped table-hover"
            OnRowDataBound="dgr_RowDataBound" DataKeyNames="payoutno,status">
            <Columns>
                <asp:TemplateField HeaderText="#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="payoutno" HeaderText="Payout No"></asp:BoundField>
                <asp:BoundField DataField="PayFromDate" HeaderText="From Date"></asp:BoundField>
                <asp:HyperLinkField DataTextField="PayToDate" DataNavigateUrlFields="PayToDate" DataNavigateUrlFormatString="adminpayout2.aspx?n={0}"
                    HeaderText="To Date" ControlStyle-ForeColor="Blue" />
                <%--  <asp:ButtonField CommandName="Show" Text="Show"  CommandName="s" CommandArgument='<%# Eval("payoutno") %>'/>
                        <asp:ButtonField CommandName="Hide" Text="Hide"  CommandName="s" CommandArgument='<%# Eval("payoutno") %>'/>--%>
                <%-- <asp:TemplateField HeaderText="Show">
                            <ItemTemplate>
                                <asp:LinkButton ID="linkButton2" runat="server" Text="Show" CommandName="Show" CommandArgument='<%# Eval("payoutno") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hide">
                            <ItemTemplate>
                                <asp:LinkButton ID="linkButton3" runat="server" Text="Hide" CommandName="Hide" CommandArgument='<%# Eval("payoutno") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                <%-- <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkStatus" runat="server" CommandName="SH" CommandArgument='<%# Eval("payoutno") %>'
                                    Text='<%# Eval("pstatus") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Status" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_Status" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="SH" > 
                                    &nbsp;<%# Eval("status").ToString() != "0" ? "<i class='fa fa-toggle-on' style='font-size:24px;color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px;color:red'></i>"%></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Send SMS" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="linkButton1" runat="server" Text='<%# Eval("sentsms") %>' CommandName="s" 
                            CommandArgument='<%# Eval("payoutno") %>' ForeColor="Blue"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Send Wallet"  Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnsendwallet" runat="server" Text='<%# Eval("sendwallet") %>' CommandName="SW" 
                            CommandArgument='<%# Eval("payoutno") %>'></asp:LinkButton>
                        <asp:Label ID="lblispaid" runat="server" Visible="false" Text='<%#Eval("isPaid") %>'>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
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
