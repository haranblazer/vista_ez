<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ProductWise_Sec_Sale_Pivot.aspx.cs" Inherits="secretadmin_ProductWise_Sec_Sale_Pivot" %>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product Wise Secondary Sales</h4>
    <div class="form-group card-group-row row">
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-md-2 ">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>

        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txt_product" runat="server" CssClass="form-control" placeholder="Search Product....."></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearchByDate_Click" OnClientClick="javascript:return Validation()" />
        </div> 
        <div class="col-sm-2 col-xs-2 text-right pull-right">
            <asp:Button ID="ImageButton2" runat="server" Text="Excel" OnClick="imgbtnExcel_Click" class="btn btn-primary btn-sm" />
            <asp:Button ID="ImageButton4" runat="server" Text="CSV" OnClick="imgbtnCsv_Click" class="btn btn-primary btn-sm" />
        </div>
    </div>
    <hr />
    <div class="clearfix"></div>
    <div class="table-responsive">
        <asp:GridView ID="grdProductprimary" runat="server" OnRowDataBound="grdProductprimary_RowDataBound" ShowFooter="true" CssClass="table table-striped table-hover display dataTable nowrap cell-border">
            <Columns>
                <asp:TemplateField HeaderText="#">
                    <ItemTemplate>
                        <asp:Label ID="lblserial" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
     
     
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function Validation() {
            var MSG = "";
            if ($('#<%=txtFromDate.ClientID%>').val() == "") {
                MSG += "\n Please select date.!!";
                $('#<%=txtFromDate.ClientID%>').focus();
            }
            if ($('#<%=txtToDate.ClientID%>').val() == "") {
                MSG += "\n Please select date.!!";
                $('#<%=txtToDate.ClientID%>').focus();
            }
            if (MSG != "") {
                alert(MSG);
                return false;
            } else {
                return true;
            }
        }
    </script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script> var $J = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $J(function () {
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
            $J('#<%=txt_product.ClientID%>').autocomplete({ source: Productcode });
        });
    </script>
    <div id="divProductcode" style="display: none;" runat="server"></div>

</asp:Content>

