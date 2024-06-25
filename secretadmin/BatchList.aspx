<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="BatchList.aspx.cs" Inherits="secretadmin_BatchList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Product Batch List</h4>
    </div>




    <div class="row">
         
        <div class="col-sm-4">
            <asp:DropDownList ID="ddlproductname" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Expired" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Active</asp:ListItem>
                <asp:ListItem Value="1">Expired</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-4">
          <%--  <asp:Button ID="btn_Search" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btn_Search_Click" />--%>
        </div>
        <div class="col-sm-2 ">
              <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
           <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif" OnClick="imgbtnExcel_Click" />--%>
        </div>
    </div>

    <hr />


    <div class="table-responsive">

          <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table> 
    </div>


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
        var pageUrl = '<%=ResolveUrl("BatchList.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {
            let pid = $('#<%=ddlproductname.ClientID%>').val(),
                Expired = $('#<%=ddl_Expired.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{pid: "' + pid + '", Expired: "' + Expired + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var Id = data.d[i].Id;

                        json.push([i + 1,
                            //data.d[i].Batchid,
                            data.d[i].ProductCode,
                            data.d[i].productname,
                            data.d[i].BatchNo,
                            data.d[i].Batchdate,
                            data.d[i].ExpiryDate,
                            data.d[i].MRP,
                            data.d[i].Total_DP,
                            data.d[i].Total_DPWithTax,
                            //data.d[i].DpStock,
                            //data.d[i].DpStockWithTax,

                            //data.d[i].CompRate,
                            //data.d[i].CompWithTax,

                            //data.d[i].PORate,
                            //data.d[i].POWithTax,
                            data.d[i].Tax,
                           // data.d[i].BVAmt,
                            data.d[i].pbvamt,
                          //  data.d[i].FPV,
                            //data.d[i].APV,
                            
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel'],
                        data: json,
                        columns: [
                            { title: "#" },
                           // { title: "Sys_Id" },
                            { title: "PCode" },
                            { title: "P Name" },
                            { title: "Batch <br> No" },
                            { title: "Mfg" },
                            { title: "Expiry" },
                            { title: "MRP" },
                            { title: "DP <br> Rate" },
                            { title: "DP <br> With <br> Tax" },
                            //{ title: "Fran <br> Sale" },
                            //{ title: "Fran <br> With <br> Tax" },

                            //{ title: "Comp <br> Rate" },
                            //{ title: "Comp <br> With <br>Tax" },
                            

                            //{ title: "Order <br> DP <br> Rate" },
                            //{ title: "Order <br> Billing <br> Rate" },
                            { title: "GST" },
                           // { title: "TPV" },
                            { title: "<%=method.GBV%>" },
                            //{ title: "FPV" },
                            //{ title: "APV" },

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

