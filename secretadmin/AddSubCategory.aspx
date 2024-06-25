<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    EnableEventValidation="false" AutoEventWireup="true" CodeFile="AddSubCategory.aspx.cs" Inherits="secretadmin_AddSubCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Add / Edit SubCategory</h4>
    <hr />
    <div class="row">
        <div class="col-sm-2 control-label">Category</div>
        <div class="col-sm-4">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="clearfix"></div>
        <div class="col-sm-2 control-label">Sub Category</div>
        <div class="col-sm-4">
            <asp:TextBox ID="txt_SubCat" runat="server" MaxLength="30" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="clearfix"></div>

        <div class="col-sm-2 control-label">Display Priority</div>
        <div class="col-sm-4">
            <asp:TextBox ID="txt_priority" runat="server" MaxLength="2" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="clearfix"></div>

        <div class="col-sm-2 "></div>
        <div class="col-sm-4">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
        </div>
        <div class="clearfix"></div>

        <div class="col-sm-10"></div>
        <div class="col-sm-2 text-right pull-right">
            <a href="SubCategoryList.aspx" class="btn btn-link">Sub Category List</a>
        </div>

        <div class="clearfix"></div>
    </div>

</asp:Content>

