<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="vendor_stock_return.aspx.cs" Inherits="franchise_vendor_stock_return" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Vendor Return Stock</h4>
    </div>

    <div class="form-group row d-none">
        <div class="col-sm-2 control-label">
            Category
        </div>
        <div class="col-sm-4">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>

        <div class="col-sm-2 control-label">Sub Category</div>
        <div class="col-sm-4">
            <asp:DropDownList ID="ddl_Sub_Cat" runat="server" CssClass="form-control">
            </asp:DropDownList>

        </div>

        <div class="col-sm-4 control-label d-none">
            <asp:CheckBox ID="chk_IsComboPack" runat="server" Text="Packed Product" Style="width: 32px; font-size: 16px;" />
        </div>
    </div>

</asp:Content>

