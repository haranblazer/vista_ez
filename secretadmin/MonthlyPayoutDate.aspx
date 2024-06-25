<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="MonthlyPayoutDate.aspx.cs" Inherits="secretadmin_MonthlyPayoutDate" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
    <h4 class="fs-20 font-w600  me-auto">Monthly Payout Date</h4>
    </div>

 
    <!-- TitleActions -->
    <div class="table-responsive">
        <asp:GridView ID="dgr" runat="server" OnRowCommand="dgr_RowCommand" AutoGenerateColumns="False"
            EmptyDataText="Payout date not found." CssClass="mygrd table table-striped table-hover"
            OnRowDataBound="dgr_RowDataBound" DataKeyNames="payoutno,status">
            <Columns>
                <asp:TemplateField HeaderText="SrNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="payoutno" HeaderText="Payout No"></asp:BoundField>
                <asp:BoundField DataField="PayFromDate" HeaderText="From Date"></asp:BoundField>
                <%--<asp:HyperLinkField DataTextField="PayToDate" DataNavigateUrlFields="PayToDate" DataNavigateUrlFormatString="adminpayout2.aspx?n={0}"
                    HeaderText="To Date" />--%>

                <asp:TemplateField HeaderText="To Date">
                    <ItemTemplate>
                        <%# Eval("PayToDate") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("status").ToString() != "0" ? "<i class='fa fa-toggle-on' style='font-size:24px;color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px;color:red'></i>"%>;
                                <asp:LinkButton ID="lnk_Status" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="SH" Visible="false"> 
                                    &nbsp;<%# Eval("status").ToString() != "0" ? "<i class='fa fa-toggle-on' style='font-size:24px;color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px;color:red'></i>"%></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Send SMS">
                    <ItemTemplate>
                        <%# Eval("sentsms") %>
                        <asp:LinkButton ID="linkButton1" runat="server" Text='<%# Eval("sentsms") %>' CommandName="s"
                            CommandArgument='<%# Eval("payoutno") %>' Visible="false"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Send Wallet">
                    <ItemTemplate>
                        <%# Eval("sendwallet") %>
                        <asp:LinkButton ID="lnkbtnsendwallet" runat="server" Text='<%# Eval("sendwallet") %>' CommandName="SW"
                            CommandArgument='<%# Eval("payoutno") %>' Visible="false"></asp:LinkButton>
                        <asp:Label ID="lblispaid" runat="server" Visible="false" Text='<%#Eval("isPaid") %>'>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <script type="text/javascript">
        $(document).ready(

     function () {

         $('.3').show();
     }
    );
    </script>
     
</asp:Content>

