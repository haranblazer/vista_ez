<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="CancelOrderList.aspx.cs" Inherits="secretadmin_CancelOrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <title>Order List</title>
    <%--by <S>--%>
    <%--end date picker link--%>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script src="datepick/asptextb.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <script>
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
    <h1 class="head">
        <i class="fa fa-eye" aria-hidden="true"></i>&nbsp;Cancel Purchase Order
    </h1>
      <div class="panel panel-default">
  <div class="col-md-12">
    
    <div class="clearfix">
    </div>
    <div>
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-1 control-label">
                From</label>
            <div class="col-sm-2">
                
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="From"></asp:TextBox>
                
            </div>
        </div>
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-1 control-label">
                To</label>
            <div class="col-sm-2">
                
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="To"></asp:TextBox>
              
            </div>
        </div>
        <div class="form-group">
            <label for="MainContent_txtPassword" class="col-sm-2 control-label">
                InvoiceNo/ User ID/ Name/ Amount</label>
            <div class="col-sm-2">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-1">
                <button title="Search" id="btnSearch" runat="server" class="btn btn-success" onserverclick="btnSearch_Click">
                    <i class="fa fa-search"></i>&nbsp;Search
                </button>
            </div>
        </div>

              <div class="pull-right" style="text-align: right;">
                        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                            Width="25px" />
                        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                            Style="margin-left: 0px" Width="26px" />
                    </div>
      
    </div>

    <div class="clearfix">
    </div>
    <br />
    <table style="width: 100%">
        <tr>
            <td colspan="3">
                <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    
                </div>
            </td>
        </tr>
    </table>
    <div class=" table-responsive">
        <asp:GridView AllowPaging="true" ID="GridView1" runat="server" AutoGenerateColumns="false"
            CssClass="table table-striped table-hover mygrd" PageSize="50"  DataKeyNames="srno"
            Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" 
          >
            <Columns>
                    <asp:TemplateField HeaderText="SrNo.">
    <ItemTemplate>
    <%#Container.DataItemIndex+1 %>
    </ItemTemplate>
    </asp:TemplateField>
    

     <asp:BoundField HeaderText="Doe" DataField="doe" />
             
           <asp:HyperLinkField  DataNavigateUrlFields="srno,status"  HeaderText="Order No"   
                    DataTextField="orderno" DataNavigateUrlFormatString="orderbill.aspx?id={0}&st={1}" />
                
                <asp:BoundField HeaderText="PO ID" DataField="regno" />
                <asp:BoundField HeaderText="PO Name" DataField="fname" />
                <asp:BoundField HeaderText="PO-TO(ID)" DataField="orderto" />
                <asp:BoundField HeaderText="PO-TO(Name)" DataField="ordertoname" />
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
             
               <%--
                  <asp:TemplateField HeaderText="Remarks">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtcomment" runat="server" CssClass="form-control" Text='<%# Eval("remarks") %>' Enabled="false"
                                                Style="max-width: 220px; min-width: 180px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>

                                    
            </Columns>
        </asp:GridView>
    </div>
    </div>
    <div class="clearfix"></div>
    <//div>
</asp:Content>

