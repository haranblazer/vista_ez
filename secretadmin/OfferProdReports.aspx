<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="OfferProdReports.aspx.cs" 
    EnableEventValidation="false" Inherits="secretadmin_OfferProdReports" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
             $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
         });
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Offer Product Report</h4>

   
            <div class="row">
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txt_SellerId" runat="server" CssClass="form-control" placeholder="Enter SellerId"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txt_BuyerId" runat="server" CssClass="form-control" placeholder="Enter BuyerId"></asp:TextBox>
                </div>
          
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_OfferType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">All</asp:ListItem>
                        <asp:ListItem Value="1">Offer</asp:ListItem>
                        <asp:ListItem Value="-111">Loyalty</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Scheme" runat="server" CssClass="form-control"  
                        AutoPostBack="true" OnSelectedIndexChanged="ddl_Scheme_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <div class="col-sm-2">
                    <asp:UpdatePanel ID="UpdatePanelFran" runat="server">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddl_Scheme" EventName="SelectedIndexChanged" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:DropDownList ID="ddl_OfferItem" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>


                <div class="col-sm-1">
                    <asp:Button ID="Button1" runat="server" Text="Show"  UseSubmitBehavior="true" OnClick="Button1_Click" CssClass="btn btn-primary" />
                </div>
                <div class="col-sm-3 text-right pull-right">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />
                </div>

            </div>
    <hr />
            <div class="clearfix">
            </div>

            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover mygrd"
                    EmptyDataText="No Data Found" PageSize="100" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowCommand="GridView1_RowCommand" DataKeyNames="Srno, OFFERID" ShowFooter="True" AllowPaging="true">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Date" DataField="Date" />
                        <asp:BoundField HeaderText="Invoice Number" DataField="InvoiceNumber" />
                        <asp:BoundField HeaderText="Payable Sales" DataField="InvoiceAmount" />
                        <asp:BoundField HeaderText="SellerID" DataField="SellerID" />
                        <asp:BoundField HeaderText="Seller Name" DataField="SellerName" />
                        <asp:BoundField HeaderText="BuyerID" DataField="BuyerID" />
                        <asp:BoundField HeaderText="Buyer Name" DataField="BuyerName" />
                        <asp:BoundField HeaderText="Billing Type" DataField="BillingType" />
                        <asp:BoundField HeaderText="Scheme" DataField="Scheme" />
                        <asp:BoundField HeaderText="Item Name" DataField="ItemName" />
                        <asp:BoundField HeaderText="Product code" DataField="Productcode" />
                        <asp:BoundField HeaderText="Product Name" DataField="ProductName" />
                        <asp:BoundField HeaderText="Product Qty" DataField="ProductQty" />

                        <asp:TemplateField HeaderText="Dispatch" Visible="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="btn_Dispatch" runat="server" Text='<%# Eval("DispatchStatus").ToString() == "0" ? "Dispatch" : "Dispatched"%>'
                                    Enabled='<%#Eval("DispatchStatus").ToString()=="0" ? true : false %>'
                                    CssClass='<%#Eval("DispatchStatus").ToString()=="0" ? "btn btn-success btn-sm" : "btn btn-success disabled btn-sm" %>'
                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Dispatch"
                                    OnClientClick="return confirm('Are you sure you want to proceed？')" />
                            </ItemTemplate>
                        </asp:TemplateField>



                    </Columns>
                </asp:GridView>
            </div>

           
</asp:Content>

