<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="LegWiseMonthlyReport.aspx.cs" Inherits="secretadmin_LegWiseMonthlyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Legwise Report</h4>

    <div class="form-group card-group-row row">
        <div class="col-md-3">
            <asp:DropDownList ID="ddl_RequestType" runat="server" CssClass="form-control">
                <%--<asp:ListItem Value="GPV">GPV Report</asp:ListItem>
                <asp:ListItem Value="TPV">TPV Report</asp:ListItem>--%>
            </asp:DropDownList>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:Button ID="btn_Button" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btn_Button_Click"></asp:Button>
        </div>


        <div class="col-md-3">
            <button id="imgbtnExcel" runat="server" class="btn btn-primary btn-sm" onserverclick="imgbtnExcel_Click">
                <i class="fa fa-file-excel-o me-2"></i>Excel
            </button>

            <button id="imgbtnWord" runat="server" class="btn btn-primary btn-sm" onserverclick="imgbtnWord_Click">
                <i class="fa fa-file-word-o me-2"></i>Word
            </button>
        </div>
    </div>
    <div class="clearfix"></div>
    <hr />
    <div class="table-responsive">
        <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-hover text-left" ShowFooter="True">
        </asp:GridView>
    </div>
</asp:Content>

