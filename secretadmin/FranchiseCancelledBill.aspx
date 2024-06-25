<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="FranchiseCancelledBill.aspx.cs" Inherits="secretadmin_FranchiseCancelledBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <script>
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(13)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(13)").each(function () {
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
    <h2 class="head">
        <i class="fa fa-times-circle-o" aria-hidden="true"></i>&nbsp; Franchise Cancelled
        Bill</h2>
        <br />
    <div class="clearfix">
    </div>
    <div class="form-group">
        <label for="MainContent_txtPassword" class="col-sm-1 control-label">
            From</label>
        <div class="col-sm-2 ">
            <div class="input-group">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                    placeholder="From"></asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>
        <label for="MainContent_txtPassword" class="col-sm-1 control-label">
            To</label>
        <div class="col-sm-2 ">
            <div class="input-group">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                    placeholder="To"></asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>
        <label for="MainContent_txtPassword" class="col-sm-2 control-label">
            InvNo/UserID/Name</label>
        <div class="col-sm-3">
            <asp:TextBox ID="TxtSponsorId" runat="server" MaxLength="30" CssClass="form-control"
                placeholder="Search By InvNo/UserID/Name" onchange="return CallVal(this);" CausesValidation="True"
                ValidationGroup="NJ"></asp:TextBox>
            <div class="clearfix">
            </div>
            <br />
        </div>
        <div class="col-sm-1 col-xs-2">
            <button id="btnSearch" runat="server" class="btn btn-success" title="Search" onserverclick="btnSearch_Click">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>
    </div>
    <div style="display: none">
        <label for="MainContent_txtPassword" class="col-sm-1 col-xs-3 control-label">
            Bill Type</label>
        <div class="col-sm-2 " style="margin-bottom: 15px;">
            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control">
                <%-- <asp:ListItem Value="0" Selected="True">All </asp:ListItem>--%>
                <asp:ListItem Value="0" Selected="True">Repurchase </asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <%--    <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>--%>
    <div>
        <div class="col-sm-1" id="divUserID" style="display: none;" runat="server">
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <table style="width: 100%">
        <tr>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"
                    Visible="false">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    <asp:ListItem Value="1">Admin</asp:ListItem>
                    <asp:ListItem Value="2">Franchise</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="form-group">
                    <div class="col-md-12" style="text-align: right;">
                        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                            Width="25px" />
                        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                            Style="margin-left: 0px" Width="26px" />
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div class="table-responsive">
        <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
            AutoGenerateColumns="false" DataKeyNames="invoiceno,monthname" PageSize="50"
            Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit"
            OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound" EmptyDataText="No Data Found"
            EmptyDataRowStyle-ForeColor="Red">
            <Columns>
                <asp:TemplateField HeaderText="SrNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataTextField="invoiceno" HeaderText="Invoice No." DataNavigateUrlFields="srno,status"
                    Text="Print" DataNavigateUrlFormatString="PrintBill.aspx?id={0}&st={1}" />
                <%-- <asp:BoundField HeaderText="Invoice No." DataField="invoiceno" />--%>
                <asp:BoundField HeaderText="Seller ID" DataField="saleby" />
                <asp:BoundField HeaderText="Seller Name" DataField="salebyname" />
                <asp:BoundField HeaderText="Buyer ID" DataField="soldto" />
                <asp:BoundField HeaderText="Buyer Name" DataField="SoldToName" />
                <%--<asp:BoundField HeaderText="Sponsor ID" DataField="sponsorid" />
                        <asp:BoundField HeaderText="Sponsor Name" DataField="Sponsorname" />--%>
                <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                <asp:BoundField HeaderText="Amount" DataField="amt" />
                <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                <asp:BoundField HeaderText="Tax Amount" DataField="tax" />
                <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                <%-- <asp:TemplateField HeaderText="Detail" Visible="false">
                            <ItemTemplate>
                               
                                <span id="tblPrd" style="display: none;">
                                    <%#Eval("tbl") %>
                                </span><a href="javascript:void" style="color: Blue;">Detail</a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="status" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Bill Date" DataField="doe" />
                <%--BillingForm.aspx?i={0}&n={1}&s={2}--%>
                <%-- <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="srno,status"
                            Text="Print" DataNavigateUrlFormatString="PrintBill.aspx?id={0}&st={1}" />--%>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
