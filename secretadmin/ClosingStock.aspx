<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ClosingStock.aspx.cs" Inherits="franchise_ClosingStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto"> Closing Stock Statement</h4>					
				</div>
  
            <div class="row">
                <div class="col-md-2 control-label">Enter FranchiseId</div>
                <div class="col-md-2">
                    <asp:TextBox ID="txt_FranchiseId" runat="server" CssClass="form-control" placeholder="Search By Franchise Id"></asp:TextBox>
                </div>
                <div class="col-sm-2 col-xs-6">
                    <button id="btnSearch" runat="server" class="btn btn-primary" title="Search" onserverclick="btnSearch_Click">
                        Search
                    </button>
                </div>
              

         <div class="col-sm-2 col-xs-6 text-right pull-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" Width="23px" />
        </div>
                  </div>
            <div class="clearfix"></div>
            <br />
            <div class="table-responsive">
                <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="1" CssClass="table table-striped table-hover" AutoGenerateColumns="false"
                    Font-Names="Arial" Font-Size="Small" PageSize="500" EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="dglst_PageIndexChanging" AllowSorting="true" OnSorting="OnSorting">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate>
                                <b>
                                    <%#Container.DataItemIndex+1%>
                                </b>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ProductCode" HeaderText="Product Code" SortExpression="ProductCode"/>
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName"/>
                        <asp:BoundField DataField="BatchNo" HeaderText="Batch No" SortExpression="BatchNo"/>
                        <asp:BoundField DataField="Mfg" HeaderText="Mfg" SortExpression="Mfg"/>
                        <asp:BoundField DataField="Expiry" HeaderText="Expiry" SortExpression="Expiry"/>
                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty"/>
                        <%-- <asp:BoundField DataField="MRP" HeaderText="MRP" />--%>
                        <asp:BoundField DataField="Total_DP" HeaderText="DP Rate" SortExpression="Month"/>
                        <asp:BoundField DataField="Total_DPWithTax" HeaderText="DP With Tax" SortExpression="Total_DPWithTax"/>
                        <asp:BoundField DataField="Tax" HeaderText="GST" SortExpression="Tax"/>
                        <%-- <asp:BoundField DataField="AR" HeaderText="AR" />--%>
                        <asp:BoundField DataField="TPV" HeaderText="TPV" SortExpression="TPV"/>
                        <asp:BoundField DataField="RPV" HeaderText="RPV" SortExpression="RPV"/>
                        <%--Pid	Batchid				productname	ProductCode	MRP	DPAmt	Tax	DPWithTax	pbvamt	BVAmt	Total_DP	
                        Total_DPWithTax	DpStock	DpStockWithTax	casesize	qty--%>
                    </Columns>
                </asp:GridView>
            </div>
                <div class="clearfix"> </div>
   

    <div id="divProductcode" style="display: none;" runat="server">
    </div>

    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
     
    <script type="text/javascript">
        $(function () {
         
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
                $('#<%=txt_FranchiseId.ClientID%>').autocomplete(Productcode);
            });
    </script> 
</asp:Content>



