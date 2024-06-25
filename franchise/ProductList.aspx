<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="ProductList.aspx.cs" Inherits="franchise_ProductList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        tr, th
        {
            color: #000;
            font-size: 17px;
        }
    </style>
     <h2 class="head">
                    <i class="fa fa-bars" aria-hidden="true"></i>Product List
                </h2>
            <div class="col-lg-12 col-md-12">
               
                <!-- TitleActions -->
                <div class="clearfix">
                </div>
                <br />
               
                <div class="table-responsive" style="border: none">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:GridView ID="dglst" EmptyDataText="No record found" runat="server" AllowPaging="true"
                                    AutoGenerateColumns="false" OnPageIndexChanging="dglst_PageIndexChanging" CellPadding="4"
                                    CellSpacing="1" CssClass="table table-striped table-hover" PageSize="50" Width="100%">
                                    <PagerSettings PageButtonCount="25" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr.No">
                                            <ItemStyle Height="20px" Font-Bold="True"></ItemStyle>
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Productid" HeaderText="Product ID">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="productname" HeaderText="Product Name">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="HSNCode" HeaderText="HSN Code">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="mrp" HeaderText="MRP">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TransferPrice" HeaderText="Transfer Price">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DistributorPrice" HeaderText="Distributor Price">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="pv" HeaderText="BV">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
       
    <div class="clearfix">
    </div>
    <br />
</asp:Content>
