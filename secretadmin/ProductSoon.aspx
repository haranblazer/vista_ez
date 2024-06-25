<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="ProductSoon.aspx.cs" Inherits="secretadmin_ProductSoon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        tr, th
        {
            color: #000;
            font-size: 17px;
        }
    </style>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <div id="title" class="b2">
                    <h2>
                        Promo Product</h2>
                    <!-- TitleActions -->
                    <!-- /TitleActions -->
                </div>
                <asp:TextBox ID="txtproduct" runat="server" required  CssClass="form-control"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-success" />
                <h2>
                    Promo Product List</h2>
                <br />
                <div class="table-responsive" style="border: none">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr No.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Productname" HeaderText="Product Name" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
