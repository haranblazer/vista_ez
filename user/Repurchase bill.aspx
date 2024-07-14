<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="Repurchase bill.aspx.cs" Inherits="user_Repurchase_bill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <script>
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(14)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(14)").each(function () {
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
    <style type="text/css">
        .form-group
        {
            margin-bottom: 0px;
        }
    </style>
    <div class="site-content">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-list" aria-hidden="true"></i>&nbsp;My Purchase Bills
            </div>
            <div class="panel-body">
                <div class="clearfix">
                </div>
                <br />
                <div class="form-group">
                    <label for="MainContent_txtPassword" class="col-md-2 col-xs-3 control-label">
                        Bill Date From :</label>
                    <div class="col-md-3 col-xs-9">
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="form-group">
                    <label for="MainContent_txtPassword" class="col-md-2 col-xs-3 control-label">
                        To :</label>
                    <div class="col-md-3 col-xs-9">
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="form-group">
                    <label for="MainContent_txtPassword" class="col-md-2 col-xs-3 control-label">
                        InvoiceNo/ User ID/ Name/ Amount:</label>
                    <div class="col-md-3 col-xs-9">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox><br />
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success ladda-button"
                            Text="Search" OnClick="btnSearch_Click" />
                        &nbsp;
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"
                            Visible="false">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="1">Admin</asp:ListItem>
                            <asp:ListItem Value="2">Franchise</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="form-group">
                    <div class="col-md-12 col-xs-12 pull-left">
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="table-responsive">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <table style="width: 100%">
                            <tr>
                                <td colspan="3">
                                    <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
                                        AutoGenerateColumns="false" DataKeyNames="srno,appmstid,monthname" PageSize="50"
                                        Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                                        OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SrNo.">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Invoice No." DataField="srno" />
                                            <asp:BoundField HeaderText="User ID" DataField="regno" />
                                            <asp:BoundField HeaderText="Name" DataField="fname" />
                                            <asp:BoundField HeaderText="Bill By" DataField="salesrep" ItemStyle-CssClass="hidden"
                                                HeaderStyle-CssClass="hidden" />
                                            <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                                            <asp:BoundField HeaderText="Amount" DataField="amt" />
                                            <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                                            <asp:BoundField HeaderText="Tax Amount" DataField="tax" />
                                            <asp:BoundField HeaderText="Delivery Charge(%)" DataField="DelCharge" />
                                            <asp:BoundField HeaderText="Discount(%)" DataField="Discount" />
                                            <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                                            <asp:BoundField HeaderText="Delivery Address" ItemStyle-Width="300px" DataField="adrs"
                                                ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                            <asp:BoundField HeaderText="Bill Date" DataField="doe" />
                                            <asp:TemplateField HeaderText="Detail">
                                                <ItemTemplate>
                                                    <%--to bind the product detail--%>
                                                    <span id="tblPrd" style="display: none;">
                                                        <%#Eval("tbl") %>
                                                    </span><a href="javascript:void" style="color: Blue;">View Detail</a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--BillingForm.aspx?i={0}&n={1}&s={2}--%>
                                            <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="srno,status"
                                                Text="Print" DataNavigateUrlFormatString="PrintBill.aspx?id={0}&st={1}" Visible="false" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
</asp:Content>
