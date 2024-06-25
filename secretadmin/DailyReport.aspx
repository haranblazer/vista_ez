<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
   EnableEventValidation="false" AutoEventWireup="true" CodeFile="DailyReport.aspx.cs" Inherits="secretadmin_DailyReport" %>

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
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Daily Bill Report</h4>
    <div class="row">
                   <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
  
        <div class="col-sm-2">
         
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="From"
                    ToolTip="dd/mm/yyyy"></asp:TextBox>
           
        </div>
   
   
     
        <div class="col-sm-2">            
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="From"
                    ToolTip="dd/mm/yyyy"></asp:TextBox> 
        </div>
    
  
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlseller" runat="server" CssClass="form-control">
            </asp:DropDownList>           
        </div>
    
  
        <div class="col-sm-2  pull-right text-right">
            <button id="btnSearch" runat="server" class="btn btn-primary" title="Search" onserverclick="btnSearch_Click">
                Search
            </button>
        </div>
                </div>
       
    <hr />
  <div class="table-responsive">
               <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
           
        </table>

  </div>
   <%-- <div class="table-responsive">
        <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
            AutoGenerateColumns="false" PageSize="50" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="SrNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="UserId" DataField="regno" />
                <asp:BoundField HeaderText="Name" DataField="name" />
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("net")%>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--   <asp:BoundField HeaderText="Amount" DataField="net" />--%>
           <%-- </Columns>
        </asp:GridView>
    </div>--%>
    
   
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
 
<link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
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
     var pageUrl = '<%=ResolveUrl("DailyReport.aspx")%>';
     $JDT(function () {
         BindTable();
     });


     function BindTable() {
         let min = $('#<%=txtFromDate.ClientID%>').val(),
             max = $('#<%=txtToDate.ClientID%>').val(),
             Seller = $('#<%=ddlseller.ClientID%>').val();
         $('#LoaderImg').show();
         $.ajax({
             type: "POST",
             url: pageUrl + '/BindTable',
             data: '{ min: "' + min + '", max: "' + max + '", Seller: "' + Seller + '"}',
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: function (data) {
                 $('#LoaderImg').hide();
                 var json = [];

                 for (var i = 0; i < data.d.length; i++) {

                     json.push([i + 1,
                     data.d[i].UserId,
                     data.d[i].Name,
                     data.d[i].Amount,
                         //data.d[i].T_Wallet,
                         //data.d[i].R_Wallet,
                         //data.d[i].TF_Wallet,

                     ]);
                 }

                 $JDT('#tblList').DataTable({
                     dom: 'Blfrtip',
                     scrollY: "500px",
                     scrollX: true,
                     scrollCollapse: true,
                     buttons: ['copy', 'csv', 'excel','pdf','print'],
                     data: json,
                     columns: [
                         { title: "#" },
                         { title: "UserId" },
                         { title: "Name" },
                         { title: "Amount" },
                         //{ title: "T Wallet" },
                         //{ title: "R Wallet" },
                         //{ title: "TF Wallet" },
                     ],
                     "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                     "pageLength": 15,
                     "bDestroy": true,
                    
                 });
             },
             error: function (result) {
                 $('#LoaderImg').hide();
                 alert(result);
             }
         });
     }

 </script>

</asp:Content>
