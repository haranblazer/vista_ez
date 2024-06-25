<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="ProductWiseFranchiseSales.aspx.cs" Inherits="secretadmin_ProductWiseFranchiseSales" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function () {
            $.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <h1 class="head">
        <i class="fa fa-hand-o-right" aria-hidden="true"></i>Product Wise Franchise Sale
    </h1>
    <div class="panel">
        <div class="col-md-12">

            <div class="clearfix">
            </div>
            <br />
            <div class="row">
                <div class="col-sm-1">From  </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
                </div>
                <div class="col-sm-1">To </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
                </div>

                <div class="col-sm-1">
                    <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-success"
                        OnClick="btnSearchByDate_Click" />
                </div>

            </div>
            <div class="pull-right">
                <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                    OnClick="imgbtnExcel_Click" />
            </div>

            <div class="clearfix"></div>
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
                        <asp:BoundField HeaderText="Sales Qty" DataField="SalesQty" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Free Samples Qty" DataField="FreeSamplesQty" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Total Qty" DataField="TotalQty" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Purchase Rate" DataField="PurchaseRate" ItemStyle-HorizontalAlign="right" />
                        <asp:BoundField HeaderText="Purchase value" DataField="Purchasevalue" ItemStyle-HorizontalAlign="right" />
                    </Columns>
                </asp:GridView>
            </div>

        </div>
        <div class="clearfix">
        </div>
        <br />
    </div>
</asp:Content>

