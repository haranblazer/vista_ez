<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="GSTReports.aspx.cs" Inherits="secretadmin_GSTReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <h4 class="fs-20 font-w600  me-auto float-left mb-0">GST Report   </h4>

   <div class="row">
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddl_State" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">Seller State</asp:ListItem>
                    </asp:DropDownList>
                    <div class="clearfix">
                    </div>
                </div>
                
               <%-- <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Franchise" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <div class="clearfix">
                    </div>
                </div>--%>
                <div class="col-sm-4">
                    <asp:DropDownList ID="ddltype" runat="server" CssClass="form-control">
                        <asp:ListItem Value="GST-SALE-REPORT">GST SALE REPORT</asp:ListItem>
                        <asp:ListItem Value="STN-REPORT">STN REPORT</asp:ListItem>
                        <asp:ListItem Value="DETAILS-OF-SALES-MADE-TO-REGISTRED-DEALERS">Details of sales made to registered dealers</asp:ListItem>
                        <asp:ListItem Value="DETAILS-OF-SALES-MADE-TO-UNREGISTRED-DEALERS">Details of  Interstate sales made to unregistered dealers invoice value is > 250000</asp:ListItem>
                        <asp:ListItem Value="INTERSTATE-SALES-MADE-TO-UNREGISTRED-DEALERS">Details of Interstate & Intrastate sales made to unregistered dealers invoice value is up to  250000</asp:ListItem>
                        <asp:ListItem Value="DETAILS-HSN-SUMMARY">Details of HSN Summary</asp:ListItem>
                       <%-- <asp:ListItem Value="SUMMARY-OF-DOCUMENT-ISSUED">Summary of documents issued</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>
                
                <div class="col-sm-1 col-xs-6">
                    <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-primary" /> &nbsp; &nbsp;
                  
                </div>
                 <div class="col-sm-1 col-xs-6 text-right pull-right">
          <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                        Width="25px" />
        </div>
            </div>
            <div class="clearfix">
            </div>
            
            <div class="table-responsive">
                <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="1" CssClass="table table-striped table-hover"
                    Font-Names="Arial" Font-Size="Small" PageSize="500" AutoGenerateColumns="true"
                    EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="dglst_PageIndexChanging">
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
    </script>
       <script type = "text/javascript">
           var GridId = "<%=dglst.ClientID %>";
           var ScrollHeight = 400;
           window.onload = function () {
               debugger;
               var grid = document.getElementById(GridId);
               var gridWidth = grid.offsetWidth;
               var gridHeight = grid.offsetHeight;
               var headerCellWidths = new Array();
               for (var i = 0; i < grid.getElementsByTagName("TH").length; i++) {
                   headerCellWidths[i] = grid.getElementsByTagName("TH")[i].offsetWidth;
               }
               grid.parentNode.appendChild(document.createElement("div"));
               var parentDiv = grid.parentNode;

               var table = document.createElement("table");
               for (i = 0; i < grid.attributes.length; i++) {
                   if (grid.attributes[i].specified && grid.attributes[i].name != "id") {
                       table.setAttribute(grid.attributes[i].name, grid.attributes[i].value);
                   }
               }
               table.style.cssText = grid.style.cssText;
               table.style.width = gridWidth + "px";
               table.appendChild(document.createElement("tbody"));
               table.getElementsByTagName("tbody")[0].appendChild(grid.getElementsByTagName("TR")[0]);
               var cells = table.getElementsByTagName("TH");

               var gridRow = grid.getElementsByTagName("TR")[0];
               for (var i = 0; i < cells.length; i++) {
                   var width;
                   if (headerCellWidths[i] > gridRow.getElementsByTagName("TD")[i].offsetWidth) {
                       width = headerCellWidths[i];
                   }
                   else {
                       width = gridRow.getElementsByTagName("TD")[i].offsetWidth;
                   }
                   cells[i].style.width = parseInt(width) + "px";
                   gridRow.getElementsByTagName("TD")[i].style.width = parseInt(width) + "px";
               }
               parentDiv.removeChild(grid);

               var dummyHeader = document.createElement("div");
               dummyHeader.appendChild(table);
               parentDiv.appendChild(dummyHeader);
               var scrollableDiv = document.createElement("div");
               if (parseInt(gridHeight) > ScrollHeight) {
                   gridWidth = parseInt(gridWidth) + 17;
               }
               scrollableDiv.style.cssText = "overflow:auto;height:" + ScrollHeight + "px;width:" + gridWidth + "px";
               scrollableDiv.appendChild(grid);
               parentDiv.appendChild(scrollableDiv);
           }
</script>
<style>
.table {    
    margin-bottom: 0px;border: #000;
}

th
{ border:none;
    }
</style>
</asp:Content>
