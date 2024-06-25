<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="BillingList.aspx.cs" Inherits="user_OrderList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="datepick/jquery.datepick.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(15)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(15)").each(function () {
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
    <div class="panel panel-default" style="font-size: smaller">


        <h2 class="head">
            <i class="fa fa-list" aria-hidden="true"></i>Invoice List</h2>
        <br />


        <div class="row">

            <div class="col-sm-2">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-sm-2">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-sm-2">
                <asp:DropDownList ID="ddl_DispatchStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Value="-1">All Invoice</asp:ListItem>
                    <asp:ListItem Value="1">Dispatched</asp:ListItem>
                    <asp:ListItem Value="0">Pending</asp:ListItem>
                </asp:DropDownList>

            </div>
            <div class="col-sm-2">
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Value="-1">All</asp:ListItem>
                    <asp:ListItem Value="0">Cancelled</asp:ListItem>
                    <asp:ListItem Value="1">Sumbit</asp:ListItem>

                </asp:DropDownList>
            </div>

            <label class="col-sm-1 control-label">InvoiceNo/ UserID</label>

            <div class="col-sm-2">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-sm-1 text-left">
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Search"
                    OnClick="btnSearch_Click" />
            </div>

        </div>
        <div class="clearfix"></div>
        <br />
        <div class="row">
            <div class="col-sm-10">
            </div>
            <div class="col-sm-2">
                <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif"
                    OnClick="imgbtnExcel_Click" />
                <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/user/images/word.jpg"
                    OnClick="imgbtnWord_Click" />
            </div>
        </div>
        <div class="clearfix"></div>
        <br />
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="green"></asp:Label>
            </div>
        </div>
        <div class="table-responsive">
            <asp:GridView AllowPaging="true" ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover mygrd"
                HeaderStyle-BackColor="#546e7a" HeaderStyle-ForeColor="#ffffff" EmptyDataText="No Data Found"
                PageSize="100" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" DataKeyNames="InvoiceNo"
                OnRowDataBound="GridView1_RowDataBound" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating" ShowFooter="True">
                <Columns>
                    <asp:TemplateField HeaderText="SNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField HeaderText="Date" DataField="doe" />
                    <asp:HyperLinkField DataNavigateUrlFields="srno_Encript" HeaderText="Invoice No."
                        DataTextField="InvoiceNo" DataNavigateUrlFormatString="../Common/Invoice.aspx?id={0}" />


                    <asp:TemplateField HeaderText="Cancel">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtn_Cancel" Text='Cancel' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                CommandName="cancel" runat="server" OnClientClick="return confirm('Are you sure you want to cancel this bill?');" Style="text-align: center; color: Blue;" />
                            <%--Invoice Status --%>
                            <asp:Label ID="lbl_cancelled" runat="server" Style="color: Red"></asp:Label>
                            <asp:HiddenField ID="hdn_status" runat="server" Value='<%#Eval("status") %>' />
                            <asp:HiddenField ID="hnd_Del_Status" runat="server" Value='<%#Eval("Del_Status") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            Total:
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:BoundField HeaderText="Buyer UserId" DataField="BuyerUserId" />
                    <asp:BoundField HeaderText="Buyer Name" DataField="BuyerName" />

                    <asp:BoundField HeaderText="Buyer State" DataField="BuyerState" />
                    <asp:BoundField HeaderText="Buyer District" DataField="BuyerDistrict" />
                    <asp:BoundField HeaderText="Buyer Mobile No" DataField="BuyerMobileNo" />

                    <asp:BoundField HeaderText="DP" DataField="grossAmt" />
                    <asp:BoundField HeaderText="GST" DataField="tax" />
                    <asp:BoundField HeaderText=" DP with GST" DataField="grossAmt" />

                    <asp:BoundField HeaderText="Discount" DataField="Discount" />
                    <asp:BoundField HeaderText="Courier Charges" DataField="CourierCharges" />

                    <asp:BoundField HeaderText="Invoice Value" DataField="netAmt" />
                    <asp:BoundField HeaderText="TPV " DataField="BV" />
                    <asp:BoundField HeaderText="RPV " DataField="PV" />
                    <asp:BoundField HeaderText="Invoice Type" DataField="InvoiceType" />
                      <asp:BoundField HeaderText="Billing Type" DataField="Subdistype" />

                    <asp:TemplateField HeaderText="Dispatch Status">
                        <ItemTemplate>
                            <%#Eval("DStatus") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:TemplateField HeaderText="Dispatch Details">
                        <ItemTemplate>
                            <%#Eval("DispatchDetails") %>
                        </ItemTemplate>
                    </asp:TemplateField>--%>


                    <%-- <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />--%>

                    <%-- <asp:TemplateField HeaderText="Delivery Address">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%#Eval("adrs")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>



                    <asp:BoundField HeaderText="Dispatch Date" DataField="DispatchDate" />
                    <asp:TemplateField HeaderText="Transport">
                        <ItemTemplate>
                            <asp:TextBox ID="txtTransport" runat="server" Text='<%#Eval("Transport") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tracking">
                        <ItemTemplate>
                            <asp:TextBox ID="txtTracking" runat="server" Text='<%#Eval("Tracking") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="E Way Bill">
                        <ItemTemplate>
                            <asp:TextBox ID="txt_EWayBill" runat="server" Text='<%#Eval("EWayBill") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtcom" runat="server" Text='<%#Eval("Del_Remarks") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Deliver">
                        <ItemTemplate>
                            <asp:Button ID="btnSubmit" runat="server" Text="Dispatch" CommandName="update" CommandArgument="<%#((GridViewRow)Container).RowIndex %>"
                                CssClass="btn btn-success" OnClientClick="return confirm('Are you sure you want to dispatch this items...?');" />
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Detail" Visible="false">
                        <ItemTemplate>
                            <span id="tblPrd">
                                <%#Eval("tbl") %></span> <a href="javascript:void" style="color: Blue;">Detail</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
</asp:Content>
