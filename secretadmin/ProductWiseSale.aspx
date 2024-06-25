<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ProductWiseSale.aspx.cs"
    EnableEventValidation="false" Inherits="secretadmin_ProductWiseSale" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <div class="accordion accordion-rounded-stylish accordion-bordered" id="accordion-eleven">
        <div class="accordion-item mb-0 row">
            <div class="col-md-6">
                 <div class="accordion-header rounded-lg collapsed" id="accord-11One" data-bs-toggle="collapse" data-bs-target="#collapse11One" aria-controls="collapse11One" aria-expanded="false" role="button">
                    <span class="accordion-header-icon"></span>
                <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product Wise Associate Sale</h4>
                  <span class="fa fa-sort-desc plus float-left"></span>
                </div>
            </div>
            
            <div class="clearfix"></div>
            <div id="collapse11One" class="accordion__body collapse" aria-labelledby="accord-11One" data-bs-parent="#accordion-eleven" style="">
            <div class="accordion-body-text">
                <div class="form-group card-group-row row">
                   <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
                </div>
                
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
                </div>
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_PackeType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">All</asp:ListItem>
                        <asp:ListItem Value="1">Topper</asp:ListItem>
                        <asp:ListItem Value="3">Generation</asp:ListItem>
                        <asp:ListItem Value="4">Loyalty</asp:ListItem>
                        <asp:ListItem Value="5">Free Sample</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-sm-1">
                    <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-success"
                        OnClick="btnSearchByDate_Click" />
                </div>

            
            <div class="pull-right">
                <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                    OnClick="imgbtnExcel_Click" />
            </div>
                </div>
            </div>
            </div> 
        </div>
    </div>


    
            <hr />
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                    Font-Names="Arial" Font-Size="Small" PageSize="50" AutoGenerateColumns="False"
                    EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="GridView1_PageIndexChanging"
                     FooterStyle-HorizontalAlign="Right">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Product Code" DataField="ProductCode" />
                        <asp:BoundField HeaderText="Product Name" DataField="ProductName" />
                        <asp:BoundField HeaderText="Topper Qty" DataField="TopperQty" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Generation Qty" DataField="GenerationQty" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField HeaderText="Free Samples Qty" DataField="FreeSamplesQty" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField HeaderText="Loyalty Qty" DataField="LoyaltyQty" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField HeaderText="Offer Qty" DataField="OfferQty" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField HeaderText="Total Qty" DataField="TotalQty" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField HeaderText="Purchase Rate" DataField="PurchaseRate" ItemStyle-HorizontalAlign="right"/>
                        <asp:BoundField HeaderText="Purchase value" DataField="Purchasevalue" ItemStyle-HorizontalAlign="right"/>
                    </Columns>
                </asp:GridView>
            </div>

     
</asp:Content>

