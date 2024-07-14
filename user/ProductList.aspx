<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="ProductList.aspx.cs" Inherits="user_ProductList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
<section class="page--header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6">
                            <!-- Page Title Start -->
                            <h2 class="page--title h5"> My Shopping</h2>
                            <!-- Page Title End -->
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item active"><span>Product List</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>   
    <section class="main--content">
             <br />
            
            <div class=" gutter-20">
            <div class="col-md-12">
        <div class="panel panel-default">
           
            <div class="panel-body">
              <div>
                <div>
                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                </div>
            </div>
                <div class="table-responsive">
                    <asp:GridView ID="dglst" EmptyDataText="No Record Found." runat="server" AllowPaging="true"
                        AutoGenerateColumns="false" OnPageIndexChanging="dglst_PageIndexChanging" CellPadding="4"
                        CellSpacing="1" CssClass="table" PageSize="50">
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
                            <asp:BoundField DataField="mrp" HeaderText="MRP">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DistributorPrice" HeaderText="Distributor Price">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pbvamt" HeaderText="PV (Binary)">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pv" HeaderText="PV (Repurchase)" Visible="false">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    </div>
    
    </section>
</asp:Content>
