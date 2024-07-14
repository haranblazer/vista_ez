<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="LegWiseMonthlyReport.aspx.cs" Inherits="User_LegWiseMonthlyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Legwise Report</h4>


    <%--<asp:LinkButton ID="imgbtnExcel" runat="server" OnClick="imgbtnExcel_Click">
                          <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-excel-o me-2"></i>Excel</a>
                        </asp:LinkButton>--%>
    <%--   <asp:LinkButton ID="imgbtnWord" runat="server" OnClick="imgbtnWord_Click">
                         <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-word-o me-2"></i>Word</a>
                        </asp:LinkButton>--%>


    <%--<a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-pdf-o me-2"></i>PDF</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-print me-2"></i>Print</a>--%>
    <%--<asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                Width="25px" />
                            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                Style="margin-left: 0px" Width="26px" />--%>

    <div class="form-group card-group-row row">
        <div class="col-md-3">
            <asp:DropDownList ID="ddl_RequestType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_RequestType_SelectedIndexChanged">
                <asp:ListItem Value="GPV">Net Value</asp:ListItem>
               <%-- <asp:ListItem Value="TPV">PV Report</asp:ListItem> --%>
            </asp:DropDownList>
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

