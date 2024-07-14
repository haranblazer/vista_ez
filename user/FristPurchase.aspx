<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="FristPurchase.aspx.cs" Inherits="user_FristPurchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(10)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(10)").each(function () {
                        $(this).find('a').css("display", "block");
                        $(this).find('span').css("display", "none");
                    });
                    //show specific span tag
                    $(this).parent().find('span').css("display", "block");
                    $(this).css("display", "none");
                });
            });
        });
 
    </script>
    <div class="site-content">
        <div class="panel panel-default">
            <div class="panel-heading" style="background: #546e7a; border-radius: 4px; color: #fff;
                padding: 10px; font-size: 16px">
                <i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp;Purchase Bill
            </div>
            <div class="panel-body">
                <div class="clearfix">
                </div>
                <br />
                <div>
                    <div>
                        <label for="MainContent_txtPassword" class="col-sm-2 control-label">
                            Bill Date From</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                            <div class="clearfix">
                            </div>
                            <br />
                        </div>
                    </div>
                    <div>
                        <label for="MainContent_txtPassword" class="col-sm-1 control-label">
                            To</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                            <div class="clearfix">
                            </div>
                            <br />
                        </div>
                    </div>
                    <div>
                        <div class="col-sm-2">
                            <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <div class="col-sm-2" id="divUserID" style="display: none;" runat="server">
                        </div>
                    </div>
                    <div>
                        <div class="col-sm-1">
                            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Search"
                                OnClick="btnSearch_Click" />
                        </div>
                    </div>

                    <div class="pull-right" style="text-align: right;">
                                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                        Width="25px" />
                                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                        Style="margin-left: 0px" Width="26px" />
                                </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <table style="width: 100%">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="#6D609E"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-group">
                                
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-group">
                                <div class="clearfix">
                                </div>
                                <br />
                        </td>
                    </tr>
                </table>
                <div class="table-responsive">
                    <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
                        AutoGenerateColumns="false" DataKeyNames="srno,monthname" PageSize="50" Width="100%"
                        OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                        OnRowDataBound="GridView1_RowDataBound" HeaderStyle-BackColor="#546e7a" HeaderStyle-ForeColor="white">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:HyperLinkField DataTextField="invoiceno" HeaderText="Invoice No." DataNavigateUrlFields="srno,status"
                                Text="Print" DataNavigateUrlFormatString="GSTBill.aspx?id={0}&st={1}" />
                            <%--  <asp:BoundField HeaderText="Invoice No." DataField="invoiceno" />--%>
                            <asp:BoundField HeaderText="Seller ID" DataField="sellerID" />
                            <asp:BoundField HeaderText="Seller Name" DataField="sellername" />
                            <asp:BoundField HeaderText="Buyer ID" DataField="buyerID" />
                            <asp:BoundField HeaderText="Buyer Name" DataField="Buyername" />
                            <asp:BoundField HeaderText="No.Of Product" DataField="qty" />
                            <asp:BoundField HeaderText="Amount" DataField="netamt" />
                            <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                            <asp:BoundField HeaderText="Tax Amount" DataField="taxrs" />
                            <asp:TemplateField HeaderText="Detail">
                                <ItemTemplate>
                                    <%--to bind the product detail--%>
                                    <span id="tblPrd" style="display: none;">
                                        <%#Eval("tbl") %>
                                    </span><a href="javascript:void" style="color: Blue;">Detail</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="Cancel" Visible="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnEdit1" Text="Cancel" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    CommandName="cancel" runat="server" OnClientClick="return confirm('Are you sure you want to delete this bill?');"
                                    Style="text-align: center" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="status" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Bill Date" DataField="billdoe" />
                            <asp:BoundField HeaderText="Bill Type" DataField="billtype" />
                            <%--BillingForm.aspx?i={0}&n={1}&s={2}--%>
                            <%--        <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="srno,status"
                            Text="Print" DataNavigateUrlFormatString="PrintBill.aspx?id={0}&st={1}" />--%>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
</asp:Content>
