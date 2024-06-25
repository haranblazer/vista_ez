<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="FranchiseWiseStock.aspx.cs" Inherits="secretadmin_FranchiseWiseStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h1 class="head">
        <i class="fa fa-hand-o-right" aria-hidden="true"></i>&nbsp;Franchise Wise Stock
    </h1>
    <div class="panel panel-default">
        <div class="col-md-12">

            <div class="clearfix">
            </div>
            <br />
            <div class="pull-right">
                <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                    OnClick="imgbtnExcel_Click" />
                <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />
            </div>
            <div class="clearfix">
            </div>
            <br />

            <div class="col-sm-12" style="overflow: auto;">
                <asp:GridView ID="Grdreport" runat="server">
                </asp:GridView>
                <asp:GridView ID="GridView1" CssClass="table table-striped table-hover" runat="server">
                </asp:GridView>
            </div>
            <div id="divProduct" style="display: none;" runat="server">
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
    </div>
</asp:Content>

