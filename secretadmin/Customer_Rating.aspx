<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Customer_Rating.aspx.cs" Inherits="secretadmin_Customer_Rating" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product Rating</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>


    <div class="row">
        <div class="col-sm-2 control-label">
            Category
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2 control-label">
            Product
        </div>
        <div class="col-sm-6">
            <asp:TextBox ID="txt_Barcode" runat="server" CssClass="form-control" placeholder="Select Product..."></asp:TextBox>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-2 control-label">
            Min Rate:
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_min" runat="server" CssClass="form-control">0</asp:TextBox>

        </div>
        <div class="col-sm-2 control-label">
            Max Rate:
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_max" runat="server" CssClass="form-control">5</asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Search" CssClass="form-control" runat="server">
                <asp:ListItem Value="-1" Selected="True">All</asp:ListItem>
                <asp:ListItem Value="1">Approved</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
                <asp:ListItem Value="2">Rejected</asp:ListItem>

            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <input type="button" value="Search" class="btn btn-success" onclick="bindtable()" />
        </div>

    </div>
    <div class="clearfix"></div>
    <hr />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>
    </div>



    <div id="divProductcode" style="display: none;" runat="server"></div>
    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script> var $J = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $J(function () {
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
            $J('#<%=txt_Barcode.ClientID%>').autocomplete({ source: Productcode });
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
        var pageUrl = '<%=ResolveUrl("Customer_Rating.aspx")%>';
        $JDT(function () {
            bindtable();
        });



        function bindtable() {

            var Category = $('#<%=ddlCategory.ClientID%>').val();
            var Product = $('#<%=txt_Barcode.ClientID%>').val();
            var Min_Rate = $('#<%=txt_min.ClientID%>').val();
            var Max_Rate = $('#<%=txt_max.ClientID%>').val();
            var Status = $('#<%=ddl_Search.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/bindtable',
                data: '{Category:"' + Category + '",Product:"' + Product + '",Min_Rate:"' + Min_Rate + '",Max_Rate:"' + Max_Rate + '",Status:"' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();

                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        let Comm = "'" + data.d[i].Comments + "'";
                        let Fid = data.d[i].Fid;
                        let Comments = '<textarea id="txt_Comments' + Fid + '" rows="4" style="width:350px;">' + data.d[i].Comments + '</textarea>'
                        let Status = '';
                        if (data.d[i].Status == "1") {
                            Status = '<span style="color:green">Approved</span>'
                        }
                        else if (data.d[i].Status == "0") {
                            Status = '<span style="color:blue">Pending</span>'
                        }
                        else {
                            Status = '<span style="color:red">Rejected</span>'

                        }
                        let App_Rej = "";
                        if (data.d[i].Status == "1") {
                            App_Rej = '<select id="ddl_Status' + Fid + '" class="form-control"><option value="1" selected>Approve</option><option value="2">Reject</option><option value="0">Pending</option></select>'
                        }
                        else if (data.d[i].Status == "2") {
                            App_Rej = '<select id="ddl_Status' + Fid + '" class="form-control"><option value="1">Approve</option><option value="2" selected>Reject</option><option value="0">Pending</option></select>'
                        }
                        else if (data.d[i].Status == "0") {
                            App_Rej = '<select id="ddl_Status' + Fid + '" class="form-control"><option value="1">Approve</option><option value="2">Reject</option><option value="0" selected>Pending</option></select>'

                        }
                        let Update = '<button type="button" onclick="UpdateComments(' + Fid + ')" class="btn btn-success">Submit</button>'


                        json.push([i + 1,
                        data.d[i].ProductCode,
                        data.d[i].ProductName,
                        data.d[i].Rate,
                            Comments,
                        data.d[i].Doe,
                            Status,
                            ' <a href="../User/PaymentSlip/' + data.d[i].Img1 + '" data-fancybox="gallery"> <img src="../User/PaymentSlip/' + data.d[i].Img1 + '" height="70px" width="70px;" /> </a>',
                        data.d[i].InvoiceNo,
                        data.d[i].Userid,
                        data.d[i].UserName,
                            App_Rej,
                            Update
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
                            { title: "P Code" },
                            { title: "Product Name" },
                            { title: "Rate" },
                            { title: "Comments" },
                            { title: "Doe" },
                            { title: "Status" },
                            { title: "Image" },
                            { title: "Invoice No" },
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "APPD/RJCT" },
                            { title: "Submit" },
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



        function UpdateComments(Fid) {
            var Comment = $('#txt_Comments' + Fid).val();
            var Approve_Reject = $('#ddl_Status' + Fid).val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateComments',
                data: '{Fid:"' + Fid + '",Comment:"' + Comment + '",Approve_Reject:"' + Approve_Reject + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    bindtable();
                },
                error: function (result) {
                    (result);
                }
            });
        }


    </script>

    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>

</asp:Content>

