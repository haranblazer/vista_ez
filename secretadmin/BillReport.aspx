<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="BillReport.aspx.cs" Inherits="secretadmin_BillReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
         <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
         
         <div class="clearfix">
        </div>
        <br />
       
        <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
            AutoGenerateColumns="false"  PageSize="50"
            Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
          EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red"
           >
            <Columns>
                <asp:TemplateField HeaderText="SrNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataTextField="invoiceno" HeaderText="Invoice No." DataNavigateUrlFields="srno,status"
                    Text="Print" DataNavigateUrlFormatString="GSTBill.aspx?id={0}&st={1}" />

                <asp:TemplateField HeaderText="Cancel" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnEdit1" Text="Cancel" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="cancel" runat="server" OnClientClick="return confirm('Are you sure you want to delete this bill?');"
                            Style="text-align: center" />
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- <asp:BoundField HeaderText="Invoice No." DataField="invoiceno" />--%>
                <asp:BoundField HeaderText="Seller ID" DataField="saleby" />
                <asp:BoundField HeaderText="Seller Name" DataField="salebyname" />
                <asp:BoundField HeaderText="Buyer ID" DataField="soldto" />
                <asp:BoundField HeaderText="Buyer Name" DataField="SoldToName" />
                <asp:BoundField HeaderText="Sponsor ID" DataField="sponsorid" />
                <asp:BoundField HeaderText="Sponsor Name" DataField="Sponsorname" />
                <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                <asp:BoundField HeaderText="Amount" DataField="amt" />
                <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                <asp:BoundField HeaderText="Tax Amount" DataField="tax" />
                <%--  <asp:BoundField HeaderText="Delivery Charge(%)" DataField="DelCharge" />
                        <asp:BoundField HeaderText="Discount(%)" DataField="Discount" />--%>
                <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                <%--  <asp:BoundField HeaderText="Delivery Address" ItemStyle-Width="300px" DataField="adrs" />--%>
                <asp:TemplateField HeaderText="Detail" Visible="false">
                    <ItemTemplate>
                        <%--to bind the product detail--%>
                        <span id="tblPrd" style="display: none;">
                            <%#Eval("tbl") %>
                        </span><a href="javascript:void" style="color: Blue;">Detail</a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="status" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Bill Date" DataField="doe" />
                
            </Columns>
        </asp:GridView>


</asp:Content>

