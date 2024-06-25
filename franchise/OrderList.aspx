<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="OrderList.aspx.cs" Inherits="user_OrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <style>
        td, th
        {
            padding: 5px 5px;
            border-color: #ddd;
            font-size: 13px;</style>
   
  
    <h1 class="head">
      <i class="fa fa-id-badge" aria-hidden="true"></i>   View PO
    </h1>
    
    <div class="clearfix"> </div><br />
    <br />

    <div class="container">
    <div class="row">
    

        <div class="col-md-4">

        <div class="col-xs-4">
        <label for="MainContent_myForm_txtCcode" class=" control-label">
            From
        </label>
        </div>

        <div class="col-xs-8">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="clearfix"></div><br />
    </div>
  

  
   

    <div class="col-md-4">
    
        
        <div class="xs-4">
         <label for="MainContent_myForm_txtCcode" class="col-xs-4 control-label">
            To
        </label>
        </div>

        <div class="col-xs-8">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


    </div>



   

   
    

    <div class="col-md-4">
    <div class="form-group">

        
       
        
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnSearch_Click" />
           
           
         </div>
 
</div>

 <div class="col-md-12">
    <div class="form-group">
     <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="green"></asp:Label>
        </div>

        </div>
    <div class="col-md-12" style="text-align: right;">
        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
            Width="25px" />
        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
            Style="margin-left: 0px" Width="26px" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="table-responsive">
        <table class="table">
            <tr>
                <td>
                    <asp:GridView AllowPaging="true" ID="GridView1" runat="server" AutoGenerateColumns="false"
                        PageSize="50" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:BoundField HeaderText="Order Date" DataField="doe" />

                               <asp:TemplateField HeaderText="Order No">
                                <ItemTemplate>

                              <asp:HyperLink ID="hlnkDetails" Text='<%#Eval("orderno") %>' NavigateUrl='<%#string.Format("PurchaseOrderBill.aspx?id={0}",  base64Encode(Eval("srno").ToString())) %>'
                        runat="server" />
                </ItemTemplate>

                </asp:TemplateField>

                        
                            <asp:BoundField HeaderText="PO From(ID)" DataField="regno" />
                            <asp:BoundField HeaderText="PO From(Name)" DataField="fname" />
                            <asp:BoundField HeaderText="PO TO(ID)" DataField="orderto" />
                            <asp:BoundField HeaderText="PO TO(Name)" DataField="ordertoname" />
                            <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                            <asp:BoundField HeaderText="Amount" DataField="amt" />
                          
                             <asp:TemplateField HeaderText="Address">
                                <ItemTemplate>
                                   <asp:Label ID="lbladdress" runat="server" Text='<%#Eval("adrs") %>' ></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                           


                            <asp:TemplateField HeaderText="Detail">
                                <ItemTemplate>
                                    <%--to bind the product detail--%>
                                    <span id="tblPrd" style="display: none;">
                                        <%#Eval("tbl") %>
                                    </span><a href="javascript:void" style="color: Blue;">View Detail</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                           
                       
                     
                
                       
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
    <div class="clearfix"> </div> <br />
</asp:Content>
