<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="FirstPurchase.aspx.cs" Inherits="user_FristPurchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $.noConflict();
        jQuery(document).ready(function ($) {
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

  <div class="container-fluid page__heading-container">
        <div class="page__heading d-flex align-items-center">
            <div class="flex">
                <nav aria-label="breadcrumb">
                   <ol class="breadcrumb mb-0">
                       <li class="breadcrumb-item"><a href="#"> My Shopping</a></li>
                       <li class="breadcrumb-item active" aria-current="page">Purchase Bill</li>
                   </ol>
                </nav>
                <h1 class="m-0">Purchase Bill</h1>
            </div>
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
</div>
<div class="container-fluid page__container">
        <div class="row panel card card-body">
            <div class="panel panel-default">
                <div class="form-group card-group-row row">
                <div class="col-lg-12 col-md-12">
                    <div class="card-group-row row form-group">

              
                        <div class="col-md-1">
                           From</div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>                           
                        </div>
                   
                        <div class="col-md-1">
                            To</div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>                            
                        </div>
                   
                 
                     <%--   <div class="col-sm-2">
                            <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
                        </div>--%>                  
                    <div class="col-md-1">
                            Status</div>
                        <div id="divUserID" style="display: block;" runat="server">
                        
                        <div class="col-md-12">
                            <asp:DropdownList ID="ddlStatus" runat="server" CssClass="form-control">
                             <asp:ListItem Value="-1">All</asp:ListItem>
                        <asp:ListItem Value="0">Cancelled</asp:ListItem>
                        <asp:ListItem Value="1">Not Cancelled</asp:ListItem>
                            
                            </asp:DropdownList>
                            <div class="clearfix">
                            </div>
                            <br />
                                    
                        </div>
                        </div>
                  
                        <div class="col-md-1">
                            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Search"
                                OnClick="btnSearch_Click" />
                        </div>
                  

                    <div class="col-md-2 pull-right" style="text-align: right;">
                                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                        Width="25px" />
                                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                        Style="margin-left: 0px" Width="26px" />
                                </div>
              
                <div class="clearfix">
                </div>
                <br />
              
                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="#6D609E"></asp:Label>
                       
                <div class="table-responsive">
                    <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table"
                        AutoGenerateColumns="false" DataKeyNames="srno,monthname" PageSize="50" Width="100%"
                        OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                        OnRowDataBound="GridView1_RowDataBound">
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
                         <%--   <asp:BoundField HeaderText="Bill Type" DataField="billtype" />--%>
                            <%--BillingForm.aspx?i={0}&n={1}&s={2}--%>
                            <%--        <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="srno,status"
                            Text="Print" DataNavigateUrlFormatString="PrintBill.aspx?id={0}&st={1}" />--%>
                        </Columns>
                    </asp:GridView>
                </div>
         
         </div>
         </div>
         </div>
         </div>
         </div>
         </div>
         </div>
</asp:Content>
