<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="OffLinePayment.aspx.cs" Inherits="secretadmin_AddLeader" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">View Purchase Order</h4>
    <div class="row">
                   <div class="col-sm-2">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
            </div>

            <div class="col-sm-2">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
            </div>

            <div class="col-sm-2">
                <asp:TextBox ID="txt_userid" runat="server" placeholder="Enter Userid" CssClass="form-control" MaxLength="20"></asp:TextBox>
            </div>
            <div class="col-sm-2">
                <asp:TextBox ID="txt_Amount" runat="server" placeholder="Enter Amount" CssClass="form-control" MaxLength="20"></asp:TextBox>
            </div>



  

            <div class="col-sm-2">
                <asp:TextBox ID="txt_Orderid" runat="server" placeholder="Enter Order Id" CssClass="form-control" MaxLength="30"></asp:TextBox>
            </div>
            <div class="col-sm-2">
                <asp:TextBox ID="txt_Orderno" runat="server" placeholder="Enter Order No" CssClass="form-control" MaxLength="30"></asp:TextBox>
            </div>
            <div class="col-sm-2">
                <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                    <asp:ListItem Value="-1">All</asp:ListItem>
                    <asp:ListItem Value="1">Success</asp:ListItem>
                    <asp:ListItem Value="0">Fail</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-2">
                <input type="button" value="Search" class="btn btn-success" onclick="bindtable()" />
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
        var pageUrl = '<%=ResolveUrl("OffLinePayment.aspx")%>';
        $JDT(function () {
            bindtable();
        });



        function bindtable() {
            $('#LoaderImg').show();
            var From = $('#<%=txtFromDate.ClientID%>').val();
            var To = $('#<%=txtToDate.ClientID%>').val();
            var User_Id = $('#<%=txt_userid.ClientID%>').val();
            var Amount = $('#<%=txt_Amount.ClientID%>').val();
            var Order_Id = $('#<%=txt_Orderid.ClientID%>').val();
            var Order_No = $('#<%=txt_Orderno.ClientID%>').val();
            var Status = $('#<%=ddl_Status.ClientID%>').val();



            $.ajax({

                type: "POST",
                url: pageUrl + '/bindtable',
                data: '{From:"' + From + '",To:"' + To + '",User_Id:"' + User_Id + '",Amount:"' + Amount + '",Order_Id:"' + Order_Id + '",Order_No:"' + Order_No + '",Status:"' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();

                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        let Order_Id = data.d[i].Order_Id;
                        json.push([i + 1,
                           

                            data.d[i].Date,
                            data.d[i].Order_Id,
                            data.d[i].Order_No,
                            data.d[i].Payable_Amount,
                            data.d[i].Payment_Mode,
                            data.d[i].Transaction_Amount,
                            data.d[i].Payment_Status,
                            data.d[i].Online_Response,
                            data.d[i].Buyer_Id,
                            data.d[i].Buyer_Name,

                            '<center> <i id="I' + Order_Id + '" class="fa fa-eye" style="font-size:24px;" onclick="ShowHide(' + Order_Id + ')"></i> </center> <div id="divDetail_' + Order_Id + '" class="div_tbl_class" style="display:none;"> ' + data.d[i].tbl + '</div> ' + '<div style="display:none;">' + data.d[i].tbl + '</div>', 


                            //'<input type="button" value="Received" onclick="UpdateCourierDetails(' + data.d[i].sno + ')" class="btn btn-primary btn-sm" />',
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
                            { title: "S.No" },
                            { title: "Date" },
                            { title: "Order Id" },
                            { title: "Order No." },
                            { title: "Payable Amount" },
                            { title: "Payment Mode" },
                            { title: "Transaction Amount" },
                            { title: "Payment Status" },
                            { title: "Online Response" }, 
                            { title: "Buyer Id" },
                            { title: "Buyer Name" },
                            { title: "Detail" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 25,
                        "bDestroy": true,

                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }
        function ShowHide(Order_Id) {
            $(".div_tbl_class").each(function () {
                $(this).css("display", "none");
            });
            $("#divDetail_" + Order_Id).css("display", "block");
        }
    </script>
<div class="table-responsive">
                <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
                </table>
				</div>
</asp:Content>
