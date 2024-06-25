<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    EnableEventValidation="false" AutoEventWireup="true" CodeFile="ProductWise_Primary_sales_pivot.aspx.cs" Inherits="secretadmin_ProductWise_Primary_sales_pivot" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product Wise Primary Sales</h4>
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










<%--<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="css/Master.css" type="text/css" />
    <link rel="stylesheet" href="css/Mystyle.css" type="text/css" />
    <link rel="stylesheet" href="css/Registration.css" type="text/css" />
    <link rel="stylesheet" href="css/sb-admin-2.css" type="text/css" />
    <link rel="stylesheet" href="css/sb-admin-2.min.css" type="text/css" />
    <link rel="stylesheet" href="css/Site.css" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="card-header py-3 align-items-center justify-content-between">
            <h6 class="m-0 font-weight-bold text-primary">
                <center>Productwise Primary Sales</center>
            </h6>
        </div>
        <br />
        <br />
        <div class="row">
            <div class="col-sm-2.5 ">
               
            </div>


            <div class="col-sm-2 ">
                <asp:Button ID="ViewRepor" runat="server" Text="View Report" OnClick="ViewRepor_Click" BackColor="#24a0ed" ForeColor="White"></asp:Button>
            </div>
        </div>
        <div class="col-sm-6" style="width: 80%; text-align: right">
            <asp:Button ID="btnexcel" runat="server" Text="Download Excel" OnClick="btnexcel_Click" />
        </div>


        <br />

       

    </div>

</asp:Content>--%>

