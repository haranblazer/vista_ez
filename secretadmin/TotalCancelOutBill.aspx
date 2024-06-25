<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="TotalCancelOutBill.aspx.cs" Inherits="secretadmin_TotalCancelOutBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>   
    
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(6)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(6)").each(function () {
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
        <i class="fa fa-product-hunt" aria-hidden="true"></i>&nbsp;
         <asp:Label ID="lblheader" runat="server" Text=""></asp:Label>
        
        </h2>
         <div class="panel panel-default">
  <div class="col-md-12">
    <br />
    <div class="clearfix"></div>

    <div class="col-md-7">
    <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
   </div>
    <div class="col-md-1">
    Page Size :
    </div>
     <div class="col-md-2">
       <asp:DropDownList 
            ID="ddlPageSize" runat="server" AutoPostBack="True" 
            CssClass="form-control" 
             onselectedindexchanged="ddlPageSize_SelectedIndexChanged">
            <asp:ListItem Value="25">25</asp:ListItem>
            <asp:ListItem Value="50">50</asp:ListItem>
            <asp:ListItem Value="100">100</asp:ListItem>
            <asp:ListItem Value="All">All</asp:ListItem>
        </asp:DropDownList>
     </div>
   <div class="col-md-2" style="text-align:right;">
     <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" 
           Width="25px" onclick="imgbtnExcel_Click" />
     <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" 
           Style="margin-left: 0px" Width="26px" onclick="imgbtnWord_Click" />
   </div> <div class="clearfix"> </div>
    <div class="col-md-12">
      <div class="table-responsive">
            <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
                AutoGenerateColumns="false" DataKeyNames="invoiceno,srno,status" PageSize="50"
                Width="100%" EmptyDataText="No Data Found" 
                EmptyDataRowStyle-ForeColor="Red" onrowdatabound="GridView1_RowDataBound" onpageindexchanging="GridView1_PageIndexChanging" 
             >
                <Columns>
                    <asp:TemplateField HeaderText="SrNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
            <asp:HyperLinkField DataTextField="invoiceno" HeaderText="Invoice No." DataNavigateUrlFields="srno,status" 
                        Text="Print" DataNavigateUrlFormatString="GSTBill.aspx?id={0}&st={1}" ControlStyle-ForeColor="Blue" Target="_blank"/>
                           <asp:HyperLinkField HeaderText="Invoice No." DataTextField="InvoiceNo" DataNavigateUrlFields="srno,status,taxtype"
                    DataNavigateUrlFormatString="StockGSTBill.aspx?id={0}&st={1}&ttype={2}" Target="_blank"/>
             
                           <asp:TemplateField HeaderText="" Visible="false">
                             <ItemTemplate>
                            <asp:Label ID="lbltype" runat="server" Text='<%#Eval("PageName") %>'></asp:Label>
                        </ItemTemplate>
                      </asp:TemplateField>
                    <asp:BoundField HeaderText="Amount" DataField="Amount" />
                    <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                    <asp:BoundField HeaderText="GST" DataField="tax" />
                    <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                    <asp:TemplateField HeaderText="Detail">
                        <ItemTemplate>
                            <span id="tblPrd" style="display: none;">
                                <%#Eval("tbl") %>
                            </span><a href="javascript:void" style="color: Blue;">Detail</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Bill Date" DataField="doe" />
                  
                </Columns>
            </asp:GridView>
        </div></div></div>
        <div class="clearfix"> </div>
        </div>
</asp:Content>

