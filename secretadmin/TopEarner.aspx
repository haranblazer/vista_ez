<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="TopEarner.aspx.cs" Inherits="secretadmin_TopEarner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form id="myClientForm">  <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
  <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
  <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
  <script> 
      var $JD = $.noConflict(true);
      $JD(function () {
          $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
      $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
    });
  </script>
</form>


     

        <h4 class="fs-20 font-w600  me-auto float-left mb-0"><i class="fa fa-line-chart" aria-hidden="true"></i>&nbsp;Top Earner</h4>
      
     <div class="clearfix">
    </div>
    <div class="row">
        <div class="col-sm-2 control-label">
    No. Of Earners
</div>
<div class="col-sm-2">
    <asp:DropDownList ID="ddl_NOE" runat="server" CssClass="form-control">
        <asp:ListItem Value="10">10</asp:ListItem>
        <asp:ListItem Value="25">25</asp:ListItem>
        <asp:ListItem Value="50">50</asp:ListItem>
        <asp:ListItem Value="100">100</asp:ListItem>
    </asp:DropDownList>
</div>
      <div class="col-sm-1 control-label">
      From
  </div>
  <div class="col-sm-2">
      <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
          placeholder="From"></asp:TextBox>
  </div>
 <div class="col-sm-1 control-label">
      To
  </div>
 <div class="col-sm-2">

      <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
          placeholder="To"></asp:TextBox>

  </div>

         <div class="clearfix">
</div>
 <div class="col-sm-2 control-label">
      State
  </div>
  <div class="col-sm-2">
      <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control">
      </asp:DropDownList>
  </div> 
   
    <div class="col-sm-2"><asp:Button runat="server" ID="btn_Search" onclick="btn_Search_Click" Text="Search" CssClass="btn btn-success"/></div>
    
<div class="form-group" style="margin-bottom:15px;"> 
    <div class="col-md-1">  <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="23px" />
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />
    </div>
     </div>    
        <hr />
<div class="clearfix"></div>
<div class="table-responsive">
     
    <asp:GridView ID="grdviewdata" runat="server" ShowFooter="true" CssClass="table table-striped table-hover display dataTable nowrap cell-border">
        <Columns>
            <asp:TemplateField HeaderText="#">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                   <%-- <asp:Label ID="lblserial" runat="server"></asp:Label>--%>
                </ItemTemplate>
            </asp:TemplateField> 
        </Columns>
    </asp:GridView>
</div>
        </div>
<%--    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
<link href="../Grid_js_css/buttons.dataTables.css" rel="stylesheet" />
<script src="../Grid_js_css/jquery-3.5.1.js" type="text/javascript"></script>
<script src="../Grid_js_css/jquery.dataTables.js" type="text/javascript"></script>
<script src="../Grid_js_css/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="../Grid_js_css/jszip.min.js" type="text/javascript"></script>
<script src="../Grid_js_css/pdfmake.min.js" type="text/javascript"></script>
<script src="../Grid_js_css/vfs_fonts.js" type="text/javascript"></script>
<script src="../Grid_js_css/buttons.html5.min.js" type="text/javascript"></script>
<script src="../Grid_js_css/buttons.print.min.js" type="text/javascript"></script>
<script> var $JDT = $.noConflict(true); </script>
<script type="text/javascript">
    $JDT(document).ready(function () {

      
        //$JD('.6').show();
        $JDT("#<%=grdviewdata.ClientID %>").prepend($("<thead></thead>").append($("#<%=grdviewdata.ClientID %>").find("tr:first"))).DataTable(
            {
                "bLengthChange": true,
                "dom": 'Blfrtip',
                "buttons": [
                    'excelHtml5',
                    'csvHtml5',
                    'pdfHtml5'
                ],
                "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                "pageLength": 25,
                "bDestroy": true,
                "bSort": true,
                "bFilter": true,
                "bPaginate": true
            });
    });

</script>--%>
</asp:Content>

