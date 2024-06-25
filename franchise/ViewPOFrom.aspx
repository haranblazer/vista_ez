<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="ViewPOFrom.aspx.cs" Inherits="franchise_ViewPOFrom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


  <%--<script src="../d2000admin/js/jquery-1.4.2.js" type="text/javascript"></script>--%>
    <title>Order List</title>
    <%--by <S>--%>
    <%--end date picker link--%>
    <script src="js/jquery-1.4.2.js" type="text/javascript"></script>
    <link rel="Stylesheet" type="text/css" href="datepick/jquery.datepick.css"></link>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="datepick/jquery.datepick.js"></script>
    
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });   
    </script>
    <script type="text/javascript">
        debugger;
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(9)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(9)").each(function () {
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


<h2 class="head"> <i class="fa fa-check-square" aria-hidden="true"></i> View PO </h1>

<div class="clearfix"> </div>
<br /><br />
    <div class="row">
    <div class="container">


       <div class="col-md-4">
                  <div class="col-xs-4">
              <label for="MainContent_myForm_txtCcode" class="control-label">
                from
                   </label>
                   </div>

                   <div class=" col-xs-8">
                   <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                   </div>
                 <div class="clearfix"></div><br />
                   </div>
           

           <div class="col-md-4">
              
               <div class="col-xs-4">
             <label for="MainContent_myForm_txtCcode" class=" control-label">
              To:</label>

              </div>
                   <div class="col-xs-8">
                   <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                   </div>
                   <div class="clearfix"></div><br />
                   </div>
            

                  
                  <div class="col-md-4">

                     
            
               
                   <div class="col-sm-3 col-xs-10">
                <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn2" CssClass="btn btn-success" 
                onclick="btnSearch_Click" />
    
   <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
      <div id="divUserID" style="display: none;" runat="server">
                   </div>
                   </div>

      

         </div>
         </div>
         </div>

         <div class="clearfix"></div><br />
          <div class="table-responsive">          
  <table class="table">
  <tr>
  <td>
    <asp:GridView AllowPaging="true"  ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover" PageSize ="50"
        Width="100%" onpageindexchanging="GridView1_PageIndexChanging">
    <Columns>
    <asp:TemplateField HeaderText="SrNo.">
    <ItemTemplate>
    <%#Container.DataItemIndex+1 %>
    </ItemTemplate>
    </asp:TemplateField>
    <asp:BoundField HeaderText="Order No" DataField="orderno" />

     <asp:BoundField HeaderText="PO From(ID)" DataField="regno" />
    <asp:BoundField HeaderText="PO From(Name) " DataField="fname" /> 

    <asp:BoundField HeaderText="PO To(ID) " DataField="orderto" />
    <asp:BoundField HeaderText="PO To(Name)" DataField="ordertoname" />
   
    <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
    <asp:BoundField HeaderText="Amount" DataField="amt" />
    <asp:BoundField HeaderText="Delivery Address" DataField="adrs" />
    <asp:TemplateField HeaderText="Detail">
    <ItemTemplate>
    <%--to bind the product detail--%>
    <span id="tblPrd" style="display: none;">
    <%#Eval("tbl") %>
    </span>
    <a href="javascript:void" style="color:Blue;" >View Detail</a>
    </ItemTemplate>
    </asp:TemplateField>
    <asp:BoundField HeaderText="Order Date" DataField="doe" />
    <asp:HyperLinkField DataNavigateUrlFields="regno,fname,srno" Text="View PO" DataNavigateUrlFormatString="Purchaseorderbill.aspx?i={0}&n={1}&id={2}"  />
    </Columns>
    </asp:GridView>
</td>
</tr>
</table>
</div>



</asp:Content>

