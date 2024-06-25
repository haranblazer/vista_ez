<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="CancelledStockBill.aspx.cs" Inherits="admin_CancelledStockBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        function CallVal(txt) {
            ServerSendValue(txt.value, "ctx");
        }
        function ServerResult(arg) {

            if (arg == "You cannot leave blank field here !") {
                document.getElementById("lblUser.ClientID").style.color = "Red";
                document.getElementById("lblUser.ClientID").innerHTML = arg;
            }
            else {
                document.getElementById("<%=lblUser.ClientID%>").style.color = "darkblue";
                document.getElementById("<%=lblUser.ClientID%>").innerHTML = arg;
            }
        }
        function ClientErrorCallback() {
        }
    </script>
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
    
        <h2 class="head">
            List Of Cancelled Stock</h2>
    <div class="panel panel-default">
  <div class="col-md-12">
    
    <div class="clearfix">
    </div>


  
 
  <br />
    <div class="container-fluid">
   
    <div class="row">

    <div class="col-md-3">

            <div class="col-xs-4">

        <label for="MainContent_myForm_txtCcode" class="control-label">
            From : </label>
            </div>
            <div class="col-xs-8">
              <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" Width="100%" ></asp:TextBox>
         
    </div>
   </div>

 


    <div class="col-md-3">
    
              <div class="col-xs-4">
        <label for="MainContent_myForm_txtCcode" class="control-label">
            To : </label>  </div> 
            
            <div class="col-xs-8">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
    </div>




   <div class="col-md-3">
    
    <div class="col-xs-4">
            <label for="MainContent_myForm_txtCcode" class=" control-label"> 
            Franchise ID    </label>
        </div> 

        <div class="col-xs-8">
            <asp:TextBox ID="TxtSponsorId" runat="server" MaxLength="30" CssClass="form-control"
                onchange="return CallVal(this);" Width="100%"></asp:TextBox> 
                </div>
               

            <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
            <div id="divUserID" style="display: none;" runat="server">
            </div>

         </div>
       
    <div class="col-md-3">
         <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Search"
          OnClick="btnSearch_Click" />

            <div class="pull-right">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="25px" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                Style="margin-left: 0px" Width="26px" />
        </div>
        </div>



    </div>
    
    </div>
    
 
   <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
    <div class="clearfix">
    </div>
  
    <div class="form-group">
      
        </div>
        <div class="col-sm-12" style="overflow: auto;">
            <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover"
                AutoGenerateColumns="false" PageSize="50" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
                DataKeyNames="invoiceno,regno,appmstid,status" EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red">
                <Columns >
                    <asp:TemplateField HeaderText="SrNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:HyperLinkField HeaderText="Invoice No." DataTextField="InvoiceNo" DataNavigateUrlFields="srno,status,taxtype"
                        DataNavigateUrlFormatString="StockPrintBill.aspx?id={0}&st={1}&ttype={2}"  />
                    <%--    <asp:BoundField HeaderText="Invoice No." DataField="InvoiceNo" />--%>
                    <asp:BoundField HeaderText="User ID" DataField="regno" />
                    <asp:BoundField HeaderText="Name" DataField="fname" />
                    <asp:BoundField HeaderText="State" DataField="state" />
                    <asp:BoundField HeaderText="Fran-Type" DataField="frantype" />
                    <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                    <asp:BoundField HeaderText="Amount" DataField="amt" />
                    <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                    <asp:BoundField HeaderText="Tax-Type" DataField="Taxtypes" />
                    <asp:BoundField HeaderText="Tax Amount" DataField="tax" />
                    <asp:BoundField HeaderText="Delivery Charge(%)" DataField="DelCharge" />
                    <asp:BoundField HeaderText="Discount(%)" DataField="Discount" />
                    <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                    <%-- <asp:BoundField HeaderText="Delivery Address" ItemStyle-Width="300px" DataField="adrs" />--%>
                    <asp:TemplateField HeaderText="Detail" >
                        <ItemTemplate>
                            <%--to bind the product detail--%>
                            <span id="tblPrd" style="display: none;">
                                <%#Eval("tbl") %>
                            </span><a href="javascript:void" style="color: Blue;">Detail</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Bill Date" DataField="doe" />
                    <%--BillingForm.aspx?i={0}&n={1}&s={2}--%>
                </Columns>
            </asp:GridView>
        </div>
        </div>
        <div class="clearfix"></div>
        </div>
</asp:Content>
