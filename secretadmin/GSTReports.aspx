<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="GSTReports.aspx.cs" Inherits="secretadmin_GSTReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">GST Report</h4>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>

        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_State" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Seller State</asp:ListItem>
            </asp:DropDownList>

        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Franchise" runat="server" CssClass="form-control">
            </asp:DropDownList>

        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddltype" runat="server" CssClass="form-control">
                <asp:ListItem Value="GST-SALE-REPORT">GST SALE REPORT</asp:ListItem>
                <asp:ListItem Value="STN-REPORT">STN REPORT</asp:ListItem>
                <asp:ListItem Value="DETAILS-OF-SALES-MADE-TO-REGISTRED-DEALERS">Details of sales made to registered dealers</asp:ListItem>
                <asp:ListItem Value="DETAILS-OF-SALES-MADE-TO-UNREGISTRED-DEALERS">Details of  Interstate sales made to unregistered dealers invoice value is > 250000</asp:ListItem>
                <asp:ListItem Value="INTERSTATE-SALES-MADE-TO-UNREGISTRED-DEALERS">Details of Interstate & Intrastate sales made to unregistered dealers invoice value is up to  250000</asp:ListItem>
                <asp:ListItem Value="DETAILS-HSN-SUMMARY">Details of HSN Summary</asp:ListItem>
                <asp:ListItem Value="SUMMARY-OF-DOCUMENT-ISSUED">Summary of documents issued</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-1 col-xs-6">
            <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-primary" />

        </div>
        <div class="col-sm-1 col-xs-6 pull-right text-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="25px" />
        </div>
    </div>
 
    <hr />
    <div class="table-responsive">
        <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="1" CssClass="table table-striped table-hover display dataTable nowrap cell-border cell-border"
            Font-Names="Arial" Font-Size="Small" PageSize="500" AutoGenerateColumns="true"
            EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="dglst_PageIndexChanging">
        </asp:GridView>
    </div>


       <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../Grid_js_css/buttons.dataTables.css" rel="stylesheet" />
  
   <%-- <style>
        .table {
            margin-bottom: 0px;
        }

        th {
            border: none;
        }
    </style>--%>
</asp:Content>
