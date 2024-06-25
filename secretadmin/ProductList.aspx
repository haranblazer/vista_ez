<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="ProductList.aspx.cs" Inherits="admin_ProductList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Product List</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div> 
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_isDeleted" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="0" Selected="True">Active</asp:ListItem>
                <asp:ListItem Value="1">Deactive</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%"></table>
    </div>
    <div class="clearfix">
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
        var pageUrl = '<%=ResolveUrl("ProductList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let CatId = $('#<%=ddlCategory.ClientID%>').val(),
                isDeleted = $('#<%=ddl_isDeleted.ClientID%>').val();

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ CatId: "' + CatId + '", isDeleted: "' + isDeleted + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];


                    for (var i = 0; i < data.d.length; i++) {
                        var flag = "";
                        var Pid = data.d[i].Productid;

                        let Img = '';
                        let Img_Banner = '';
                        let Packed = '';
                        let isDeleted = '';
                        let IsRedeem = '';
                        let IsPO = '';
                        let IsWebDisplay = '';
                        let isFeatured = '';
                        let MaxLoyalty = '';
                        let NewArrival = '';


                        var SaleType = '<select id="ddl_SaleType' + Pid + '" onchange="SaleType(' + Pid + ')" class="form-control" style="height: 29px; float: left; padding:0px;">';


                        if (data.d[i].IsProdImg == "0") {
                            Img = '<a target="_blank" href="EditProductImage.aspx?n=' + Pid + '" class="text-danger"> <i class="fa fa-picture-o" aria-hidden="true"></i> </a>';
                        }
                        else {
                            Img = '<a target="_blank" href="EditProductImage.aspx?n=' + Pid + '" class="text-success"> <i class="fa fa-picture-o" aria-hidden="true"></i> </a>';
                        }

                        if (data.d[i].IsProdImg == "0") {
                            Img_Banner = '<a target="_blank" href="AddProductBanner.aspx?n=' + Pid + '" class="text-danger"> <i class="fa fa-picture-o" aria-hidden="true"></i> </a>';
                        }
                        else {
                            Img_Banner = '<a target="_blank" href="AddProductBanner.aspx?n=' + Pid + '" class="text-success"> <i class="fa fa-picture-o" aria-hidden="true"></i> </a>';
                        }

                        if (data.d[i].IsComboPack == "1") {
                            Packed = '<a target="_blank" href="ComboProduct.aspx?pid=' + Pid + '"> Packed </a>';
                        }
                        else {
                            Packed = '<a target="_blank" href="ComboProduct.aspx?pid=' + Pid + '"> </a>';
                        }

                        var Edit = '<a target="_blank" href="AddEditProduct.aspx?id=' + Pid + '"><i class="fa fa-edit"></i> </a>';


                        flag = "'IsActive'";
                        if (data.d[i].isDeleted == "False") {
                            isDeleted = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            isDeleted = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }

                        flag = "'IsRedeem'";
                        if (data.d[i].IsRedeem == "1") {
                            IsRedeem = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            IsRedeem = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }

                        flag = "'IsPO'";
                        if (data.d[i].IsPO == "1") {
                            IsPO = '<a href="#/" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            IsPO = '<a href="#/" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }


                        flag = "'IsWebDisplay'";
                        if (data.d[i].IsWebDisplay == "1") {
                            IsWebDisplay = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            IsWebDisplay = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }

                        flag = "'isFeatured'";
                        if (data.d[i].isFeatured == "1") {
                            isFeatured = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            isFeatured = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }

                        if (data.d[i].MaxLoyalty == "0") {
                            MaxLoyalty = '<span class="dotGrey">0</span>';
                        }
                        else {
                            MaxLoyalty = '<span class="dotGrey">' + data.d[i].MaxLoyalty + '</span>';
                        }

                        if (data.d[i].SaleType == "0") {
                            SaleType += '<option value="0" selected="selected">All</option>';
                            //SaleType += '<option value="1">First Purchase</option>';
                            //SaleType += '<option value="3">Generation</option> </select>';
                        }
                        else if (data.d[i].SaleType == "1") {
                            SaleType += '<option value="0">All</option>';
                            //// SaleType += '<option value="1" selected="selected">First Purchase</option>';
                            SaleType += '<option value="3">Generation</option> </select>';
                        }
                        else if (data.d[i].SaleType == "3") {
                            SaleType += '<option value="0">All</option>';
                            // SaleType += '<option value="1">First Purchase</option>';
                            //SaleType += '<option value="3" selected="selected">Generation</option> </select>';
                        }


                        flag = "'NewArrival'";
                        if (data.d[i].NewArrival == "1") {
                            NewArrival = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            NewArrival = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Pid + ', ' + flag + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }



                        json.push([i + 1,
                            Edit,
                            Img,
                            Img_Banner,
                            isDeleted,
                            //  IsRedeem,
                            // IsPO,
                            IsWebDisplay,

                        data.d[i].CatName,
                            data.d[i].SubCat,
                            data.d[i].BrandName,

                        data.d[i].ProductCode,
                        data.d[i].ProductName,
                            data.d[i].IsVariant == "True" ? "<center><i class='fa fa-check' style='color: green'></i></center>" : "<center><i class='fa fa-times' style='color: red'></i></center>",
                        data.d[i].HSNCode,
                        data.d[i].Tax,
                        data.d[i].weight,
                        data.d[i].CaseSize,
                        data.d[i].Price,
                        data.d[i].TagName,
                        data.d[i].Prod_Display,


                            MaxLoyalty,
                            isFeatured,
                            NewArrival,
                            Packed,
                            data.d[i].Length,
                            data.d[i].Height,
                            data.d[i].Width ,
                            // SaleType,
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
                            { title: "<i class='fa fa-edit'></i>" },
                            { title: "<i class='fa fa-picture-o' aria-hidden='true'></i>" },
                            { title: "<i class='fa fa-picture-o' aria-hidden='true'></i><br>Banner" },

                            { title: "On/<br> Off" },
                            //{ title: "Is<br> Redm" },
                            //{ title: "Is<br>Order" },
                            { title: "Web<br> Dsp" },

                            { title: "Category" },
                            { title: "Sub Category" },
                            { title: "Brand" },
                            { title: "Prod<br> Code" },
                            { title: "Product Name" },
                            { title: "Variant" },
                            { title: "HSN Code" },

                            { title: "GST" },
                            { title: "Weight" },
                            { title: "Case Size" },
                            { title: "Price" },
                            { title: "Tag Line" },
                            { title: "Display Name" },

                            { title: "Max<br> LOY" },
                            { title: "Is <br>Offer" },
                            { title: "New<br>Arrvl" },
                            { title: "Is<br> PKD" },
                            { title: "Length" },
                            { title: "Height" },
                            { title: "Width" },
                            // { title: "Sale<br> Type" },

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


        function UpdateStatus(Pid, flag) {

            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{Pid: "' + Pid + '", flag: "' + flag + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    BindTable();
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        }

        function SaleType(Pid) {
            var SaleType = $('#ddl_SaleType' + Pid).val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateSaleType',
                data: '{Pid: "' + Pid + '", SaleType: "' + SaleType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    BindTable();
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        }

    </script>




    <%--  
    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
    <%--  <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>

    
    <script type="text/javascript">
        $(function () {
            $.noConflict(true);
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
            $('#<%=txt_Barcode.ClientID%>').autocomplete(Productcode);
        });
        
    </script>--%>
    <style>
        .dotGreen {
            height: 25px;
            width: 25px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
            color: white;
        }

        .dotGrey {
            height: 25px;
            width: 25px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
            color: white;
            padding: 5px;
            line-height: 15px;
            text-align: center;
        }
    </style>
</asp:Content>
