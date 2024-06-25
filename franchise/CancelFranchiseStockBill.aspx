<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="CancelFranchiseStockBill.aspx.cs" Inherits="franchise_CancelFranchiseStockBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../d2000admin/js/jquery-1.4.2.js" type="text/javascript"></script>
    <link rel="Stylesheet" type="text/css" href="../datepick/jquery.datepick.css"></link>
    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../datepick/jquery.datepick.js"></script>
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
    <style>
        td, th
        {
            padding: 5px 5px;
            border-color: #ddd;
        }
    </style>

   
    <h2 class="head"> <i class="fa fa-ban" aria-hidden="true"></i> List Of Cancelled Product Bills </h2>
   
    <div class="clearfix"></div> <br /><br />


    <div>
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
            Bill Date From:
        </label>
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div>
        <label for="MainContent_myForm_txtCcode" class="col-sm-1 control-label">
           To:
        </label>
        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div>
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
           InvoiceNo/ User ID/ Name/ Amount:
        </label>
        <div class="col-sm-3" style="margin-bottom:15px;">
           <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div>
        <div class="col-sm-2">
            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Search" OnClick="btnSearch_Click" />
        </div>
    </div>
     <div>
        <div class="col-sm-3">
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CssClass="form-control"
                    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Visible="false">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    <asp:ListItem Value="1">Admin</asp:ListItem>
                    <asp:ListItem Value="2">Franchise</asp:ListItem>
                </asp:DropDownList>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <table style="width: 100%">
        
        <tr>
            <td colspan="3">
                <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        
    </table>
    <div class="clearfix"> </div> <br />
    <div class="table-responsive">
        <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="mygrd" AutoGenerateColumns="false"
                    DataKeyNames="srno,monthname" PageSize="50" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowCommand="GridView1_RowCommand"
                    OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Invoice No." DataField="invoiceno" />
                        <asp:BoundField HeaderText="Seller ID" DataField="saleby" />
                        <asp:BoundField HeaderText="Seller Name" DataField="salebyname" />
                        <asp:BoundField HeaderText="Buyer ID" DataField="soldto" />
                        <asp:BoundField HeaderText="Buyer Name" DataField="SoldToName" />
                        <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                        <asp:BoundField HeaderText="Amount" DataField="amt" />
                        <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                        <asp:BoundField HeaderText="Tax Amount" DataField="tax" />
                        <asp:BoundField HeaderText="Delivery Charge(%)" DataField="DelCharge" />
                        <asp:BoundField HeaderText="Discount(%)" DataField="Discount" />
                        <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                        <%--  <asp:BoundField HeaderText="Delivery Address" ItemStyle-Width="300px" DataField="adrs" />--%>
                        <asp:TemplateField HeaderText="Detail">
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
                        <%--BillingForm.aspx?i={0}&n={1}&s={2}--%>
                        <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="srno,status,taxtype"
                            Text="Print" DataNavigateUrlFormatString="StockPrintBill.aspx?id={0}&st={1}&ttype={2}" />
                    </Columns>
                </asp:GridView>
    </div>
    <div class="clearfix"> </div> <br />    
</asp:Content>
