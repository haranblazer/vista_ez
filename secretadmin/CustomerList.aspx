<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="CustomerList.aspx.cs" Inherits="secretadmin_CostReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     
      <h4 class="fs-20 font-w600  me-auto float-left mb-0"><%=method.Associate%></h4>
     <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
   
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txt_name" runat="server" CssClass="form-control" placeholder="Enter Customer Name"></asp:TextBox>
        </div>
        </div>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" CssClass="form-control"
                placeholder="Enter Mobile No"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_State" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
         <input type="button" value="Search" class="btn btn-success" onclick="bindtable()" />
            </div>
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
        var pageUrl = '<%=ResolveUrl("CustomerList.aspx")%>';
        $JDT(function () {
            bindtable();
        });



        function bindtable() {
            $('#LoaderImg').show();


            
            var From = $('#<%=txtFromDate.ClientID%>').val();
            var To = $('#<%=txtToDate.ClientID%>').val();
            var CustName = $('#<%=txt_name.ClientID%>').val();
            var Mobile = $('#<%=txtMobileNo.ClientID%>').val();
            var State = $('#<%=ddl_State.ClientID%>').val();
            



            $.ajax({

                type: "POST",
                url: pageUrl + '/bindtable',
                data: '{From:"' + From + '",To:"' + To + '",CustName:"' + CustName + '",Mobile:"' + Mobile + '",State:"' + State + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();

                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                           
                            
                            data.d[i].User_Id,
                            data.d[i].Name,
                            data.d[i].Email,
                            data.d[i].MobileNo,
                            data.d[i].State,
                            data.d[i].City,
                            data.d[i].Address,
                            data.d[i].DOE,
                            data.d[i].District


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
                            { title: "User ID" },
                            { title: "Name" },
                            { title: "Email" },
                            { title: "Mobile No" },
                            { title: "State" },
                            { title: "City" },
                            { title: "Address" },
                            { title: "DOE" },
                            { title: "District" },
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

    </script>

    <div class="table-responsive">
                <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
                </table>
        </div>
   


</asp:Content>

