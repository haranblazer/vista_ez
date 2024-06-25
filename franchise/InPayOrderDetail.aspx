<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="InPayOrderDetail.aspx.cs" Inherits="franchise_InPayOrderDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <title>Order List</title>

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
              $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(16)").each(function () {
                  $(this).find('a').click(function () {
                      //hide all spanded tag
                      $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(16)").each(function () {
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
 
  
<h1 class="head"> <i class="fa fa-arrow-right" aria-hidden="true"></i> View In PO </h1>

<div class="clearfix"> </div> <br /><br />



 <div class="form-group">
             <label for="MainContent_myForm_txtCcode" class="col-sm-1 col-xs-2 control-label">
                from
                   </label>
                   <div class="col-sm-3 col-xs-10">
                   <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                   </div>
                   </div>
               <div class="clearfix"></div><br />
                   <div class="form-group">
             <label for="MainContent_myForm_txtCcode" class="col-sm-1 col-xs-2 control-label">
              To:
                   </label>
                   <div class="col-sm-3 col-xs-10">
                   <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                   </div>
                   </div>
                   <div class="clearfix"></div><br />

                   <div class="form-group">
                 <div class="col-sm-1 col-xs-2"> </div>
                 <div class="col-sm-3 col-xs-10">
<asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" onclick="btnSearch_Click"  />
    
   <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
      <div id="divUserID" style="display: none;" runat="server">
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
    <asp:BoundField HeaderText="PO From(ID)" DataField="orderby" />
       <asp:BoundField HeaderText="PO From(Name)" DataField="orderbyname" />
    <asp:BoundField HeaderText="PO TO(ID)" DataField="orderto" />
    <asp:BoundField HeaderText="PO TO(Name)" DataField="ordertoname" /> 
    <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />

    <asp:BoundField HeaderText="Mode" DataField="mode" />
    <asp:BoundField HeaderText="Bank" DataField="bank" />
     <asp:BoundField HeaderText="A/C" DataField="accno" />
    <asp:BoundField HeaderText="Branch" DataField="branch" />
      <asp:BoundField HeaderText="IFS" DataField="ifs" />
        <asp:BoundField HeaderText="Amt" DataField="depositedamt" />

            <asp:BoundField HeaderText="Remarks" DataField="remarks" />

    <asp:BoundField HeaderText="Doe" DataField="doe" />
        <asp:BoundField HeaderText="PayDate" DataField="paydate" />

    <asp:TemplateField HeaderText="Detail">
    <ItemTemplate>
    <%--to bind the product detail--%>
    <span id="tblPrd" style="display: none;">
    <%#Eval("tbl") %>
    </span>
    <a href="javascript:void" style="color:Blue;" >View Detail</a>
    </ItemTemplate>
    </asp:TemplateField>

    <asp:HyperLinkField DataNavigateUrlFields="srno" Text="View PO" DataNavigateUrlFormatString="Purchaseorderbill.aspx?id={0}"  />
    </Columns>
    </asp:GridView>
</td>
</tr>
</table>
</div>
</asp:Content>

