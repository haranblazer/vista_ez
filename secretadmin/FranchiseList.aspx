<%@ Page Title="" Language="C#" AutoEventWireup="true"
    MasterPageFile="MasterPage.master" CodeFile="FranchiseList.aspx.cs" Inherits="d2000admin_FranchiseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Franchise List</h4>
      <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>


    <div class="form-group card-group-row row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search By Id / Name"></asp:TextBox>
        </div>

        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddl_State" CssClass="form-control" runat="server" onchange="GetDistrict();">
            </asp:DropDownList>
        </div>

        <div class="col-sm-2 ">

            <asp:DropDownList ID="ddl_District" CssClass="form-control" runat="server">
            </asp:DropDownList>

        </div>

        <div class="col-sm-2 ">
            <asp:TextBox ID="txt_City" runat="server" CssClass="form-control" placeholder="Search By City"></asp:TextBox>
        </div>

        <div class="col-sm-2 ">
            <asp:TextBox ID="txt_PIN" runat="server" CssClass="form-control" placeholder="Search By Pin Code"></asp:TextBox>
        </div>

        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddl_Type" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>

        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddl_IsActive" CssClass="form-control" runat="server">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="0">InActive</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2 ">
            <asp:TextBox ID="txt_PanNo" runat="server" CssClass="form-control" placeholder="Search By Pan No."></asp:TextBox>
        </div>

        <div class="col-sm-2 ">
            <asp:TextBox ID="txt_GST" runat="server" CssClass="form-control" placeholder="Search By GST"></asp:TextBox>
        </div>


        <div class="col-sm-2 ">
            <asp:TextBox ID="txt_Mob" runat="server" CssClass="form-control" placeholder="Search By Mobile No"></asp:TextBox>

        </div>
        <div class="col-sm-2 col-xs-3 text-right pull-right">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>

    <hr />

    <div class="clearfix"></div>
    <div class="table-responsive">

        <table id="tblList" class="display" style="width: 100%">
            <tfoot align="right">
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>

                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>

                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                     <th></th>
                   
                </tr>
            </tfoot>
        </table>


    </div>


    <asp:HiddenField ID="hnd_FranchiseId" runat="server" Value="0" />

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



    <%-- Table Js and css  --%>
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

        var pageUrl = '<%=ResolveUrl("FranchiseList.aspx")%>';
        $JDT(function () {
            BindTable();
        });




        function BindTable() {

            var fromDate = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                toDate = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                Name = $('#<%=txtSearch.ClientID%>').val(),

                State = $('#<%=ddl_State.ClientID%>').val() == "" ? "" : $('#<%=ddl_State.ClientID%> option:selected').text(),
                District = $('#<%=ddl_District.ClientID%>').val() == "" ? "" : $('#<%=ddl_District.ClientID%> option:selected').text(),

                City = $('#<%=txt_City.ClientID%>').val(),
                PIN = $('#<%=txt_PIN.ClientID%>').val(),
                FranType = $('#<%=ddl_Type.ClientID%>').val(),
                appmstActivate = $('#<%=ddl_IsActive.ClientID%>').val(),
                mobile = $('#<%=txt_Mob.ClientID%>').val(),
                PanNo = $('#<%=txt_PanNo.ClientID%>').val(),
                GST = $('#<%=txt_GST.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{fromDate: "' + fromDate + '", toDate: "' + toDate + '",Name: "' + Name + '" ,State: "' + State + '" ,District: "' + District
                    + '",City: "' + City + '" ,PIN: "' + PIN + '" ,FranType: "' + FranType + '" ,appmstActivate: "' + appmstActivate + '" ,mobile: "' + mobile
                    + '",PanNo: "' + PanNo + '" ,GST: "' + GST + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        var FID = data.d[i].FranchiseID;
                        var Name = "'" + data.d[i].FranchiseName + "'";
                        var Mobile = "'" + data.d[i].MobileNo + "'";
                        var UL = "'UL'";
                        var FS = "'FS'";


                        var Edit = '<a href="CreateFranchise.aspx?n=' + data.d[i].FranchiseID + '" style="color: blue; font-weight: bold;"><i class="fa fa-edit"></i> </a>';
                        var LoginId = '<a href="#/" onclick="FranLogin(' + FID + ',' + data.d[i].FranType + ',' + Name + ',' + UL + ')" style="color: blue;">' + FID + '</a> ';
                        var Status = '';
                        var RegeneratePwd = ' <a href="#/" onclick="RegeneratePwd(' + FID + ',' + Name + ',' + Mobile + ')" style="color: blue;">Regenerate Pwd</a> ';
                        var VendorAuthorization = "";
                        var IsReturn = "";

                        var SampleAllow = "";
                        var StockMntInc = "";
                        var PackedUnpacked = "";

                        var franchiseStock = '<a href="#/" onclick="FranLogin(' + FID + ',' + data.d[i].FranType + ',' + Name + ',' + FS + ')" style="color: blue;">View Stock</a> ';
                        var DPwithTaxValue = '<span id="lbl_FranStock' + FID + '"> <a href="#/" onclick="ViewBalance(' + FID + ')" style="color: blue;">View Value</a> </span>';
                        var flag = "''";

                        flag = "'ACT_DEA'";
                        if (data.d[i].Status == "1") {
                            Status = '<a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            Status = '<a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }


                        flag = "'VendorAuthorization'";
                        if (data.d[i].IsVendorAuth == "1") {
                            VendorAuthorization = '<a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            VendorAuthorization = '<a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }


                        flag = "'IsReturn'";
                        if (data.d[i].IsReturn == "1") {
                            IsReturn = '<a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            IsReturn = '<a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }


                        flag = "'SampleAllow'";
                        if (data.d[i].SampleAllowed == "1") {
                            SampleAllow = '<a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            SampleAllow = '<a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }


                        flag = "'StockMntInc'";
                        if (data.d[i].IsStockMNT_Inc == "1") {
                            StockMntInc = '<div style="display:none">true</div> <a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            StockMntInc = '<div style="display:none">false</div> <a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }

                        flag = "'IsPacked'";
                        if (data.d[i].IsPacked == "1") {
                            PackedUnpacked = '<div style="display:none">true</div> <a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            PackedUnpacked = '<div style="display:none">false</div> <a href="#/" onclick="UpdateStatus(' + FID + ', ' + flag + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:red"></i> </a>';
                        }

                        var Pan_img = "'" + data.d[i].Pan_img + "'";
                        var Bank_img = "'" + data.d[i].Bank_img + "'";
                        var GST_img = "'" + data.d[i].GST_img + "'";
                        var Aadhar_B_img = "'" + data.d[i].Aadhar_B_img + "'";
                        var Aadhar_F_img = "'" + data.d[i].Aadhar_F_img + "'";
                        var Pan_VFYD = "'" + data.d[i].Pan_VFYD + "'";
                        var Bank_VFYD = "'" + data.d[i].Bank_VFYD + "'";
                        var GST_VFYD = "'" + data.d[i].GST_VFYD + "'";
                        var AADHAR_VFYD = "'" + data.d[i].AADHAR_VFYD + "'";
                        var Slip_img = "'" + data.d[i].Slip + "'";

                        var View = '<button type="button" onclick="View(' + FID + ' ,' + Pan_img + ',' + Bank_img + ',' + GST_img + ',' + Aadhar_B_img + ',' + Aadhar_F_img + ',' + Pan_VFYD + ',' + Bank_VFYD + ',' + GST_VFYD + ',' + AADHAR_VFYD + ',' + Slip_img + ')" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg"><i class="fa fa-eye" aria-hidden="true"></i></button>';

                        json.push([Edit,
                            Status,
                            LoginId,
                            data.d[i].FranchiseName,
                            data.d[i].Type,
                            data.d[i].ContactPerson,
                            data.d[i].MobileNo,
                            data.d[i].State,
                            data.d[i].District,
                            data.d[i].City,

                            data.d[i].PIN,
                            data.d[i].Address,
                            data.d[i].PAN,
                            data.d[i].BankName,
                            data.d[i].AccountNo,
                            data.d[i].IFSCCode,
                            data.d[i].RegistrationDate,
                            data.d[i].IS_OPTIN == "1" ? '<sapn style="color:green;"> <i class="fa fa-check" aria-hidden="true"></i> </span>' : '<sapn style="color:red;"> <i class="fa fa-times" aria-hidden="true"></i> </span>',
                            data.d[i].SponsorID,
                            data.d[i].SponsorName,

                            data.d[i].OpeningAmount,
                            data.d[i].MinStkAmt,

                            data.d[i].LeaderId,
                            data.d[i].LeaderName,


                           // RegeneratePwd,
                            VendorAuthorization,
                            IsReturn,
                            SampleAllow,
                            StockMntInc,
                            PackedUnpacked,
                            franchiseStock,
                            DPwithTaxValue,
                            View,
                            data.d[i].PSWRD,

                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'print'],
                        data: json,
                        columns: [
                            { title: "Edit" },
                            { title: "Status" },
                            { title: "Fran. Id" },
                            { title: "<div style='width:250px;'> Fran. Name </div>" },
                            { title: "Type" },
                            { title: "Partner/ Director Name" },
                            { title: "Mobile No." },
                            { title: "State" },
                            { title: "District" },
                            { title: "City" },

                            { title: "PIN" },
                            { title: "<div style='width:350px;'> Address </div>" },
                            { title: "PAN" },
                            { title: "<div style='width:150px;'> Bank Name </div>" },
                            { title: "Account No." },
                            { title: "IFSC" },
                            { title: "REG. Date" },
                            { title: "OPTIN" },
                            { title: "Sponsor Id" },
                            { title: "Sponsor Name" },

                            { title: "Opening Amount" },
                            { title: "Min. Stk. Amt" },
                            { title: "LeaderId" },
                            { title: "Leader Name" },
                           // { title: "Regenerate Pwd" },
                            { title: "Vendor Auth." },
                            { title: "Is Return" },
                            { title: "Sample Allow" },
                            { title: "MG" },
                            { title: "Is Packed" },
                            { title: "fran. Stock" },
                            { title: "DPwithTax Value" },
                            { title: "KYC" },
                            { title: "Password" },
                        ],
                        "lengthMenu": [[15, 100, -1], [15, 100, "All"]],
                        "pageLength": 10,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }


        function dateFormate(datevalue) {
            var date_arr = "";
            var newformat = "";
            date_arr = datevalue.split('/');
            if (date_arr.length > 0) {
                newformat = date_arr[1] + '/' + date_arr[0] + '/' + date_arr[2];
            }
            if (datevalue == "") {
                newformat = '';
            }
            return newformat;
        }





        function View(FranchiseID, Pan_img, Bank_img, GST_img, Aadhar_B_img, Aadhar_F_img, Pan_VFYD, Bank_VFYD, GST_VFYD, AADHAR_VFYD, Slip_img) {
            $('#<%=hnd_FranchiseId.ClientID%>').val(FranchiseID);

            $('#lbl_PanImg').html('<a href="../images/Slip/' + Pan_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Pan_img + '" width="200px" height="200px"> </a>');
            $('#lbl_BankImg').html('<a href="../images/Slip/' + Bank_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Bank_img + '" width="200px" height="200px"> </a>');
            $('#lbl_GSTImg').html('<a href="../images/Slip/' + GST_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + GST_img + '" width="200px" height="200px"> </a>');
            $('#lbl_AadharFrontImg').html('<a href="../images/Slip/' + Aadhar_F_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Aadhar_F_img + '" width="200px" height="200px"> </a>');
            $('#lbl_AadharBackImg').html('<a href="../images/Slip/' + Aadhar_B_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Aadhar_B_img + '" width="200px" height="200px"> </a>');
            $('#lbl_Slipimg').html('<a href="../images/Slip/' + Slip_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Slip_img + '" width="200px" height="200px"> </a>');


            if (Pan_VFYD == '1' || Pan_VFYD == '2') {
                if (Pan_VFYD == '1') {
                    $('#btn_Pan_A').val('Approved');
                    $('#btn_Pan_A').css('background-color', 'Green');

                    $("#btn_Pan_R").css("display", "none");
                    //$("#uploadimg_Pan").css("display", "none");
                }
                $("#btn_Pan_A").removeAttr('enabled');
                $("#btn_Pan_A").attr('disabled', 'disabled');

                if (Pan_VFYD == '2') {
                    $('#btn_Pan_R').val('Rejected');
                    $("#btn_Pan_A").css("display", "none");
                }
                $("#btn_Pan_R").removeAttr('enabled');
                $("#btn_Pan_R").attr('disabled', 'disabled');
            }



            if (Bank_VFYD == '1' || Bank_VFYD == '2') {
                if (Bank_VFYD == '1') {
                    $('#btn_BANK_A').val('Approved');
                    $('#btn_BANK_A').css('background-color', 'Green');

                    $("#btn_BANK_R").css("display", "none");
                    //$("#uploadimg_Bank").css("display", "none");
                }
                $("#btn_BANK_A").removeAttr('enabled');
                $("#btn_BANK_A").attr('disabled', 'disabled');

                if (Bank_VFYD == '2') {
                    $('#btn_BANK_R').val('Rejected');

                    $("#btn_BANK_A").css("display", "none");
                }
                $("#btn_BANK_R").removeAttr('enabled');
                $("#btn_BANK_R").attr('disabled', 'disabled');
            }



            if (GST_VFYD == '1' || GST_VFYD == '2') {
                if (GST_VFYD == '1') {
                    $('#btn_GST_A').val('Approved');
                    $('#btn_GST_A').css('background-color', 'Green');

                    $("#btn_GST_R").css("display", "none");
                    //$("#uploadimg_GST").css("display", "none");
                }
                $("#btn_GST_A").removeAttr('enabled');
                $("#btn_GST_A").attr('disabled', 'disabled');

                if (GST_VFYD == '2') {
                    $('#btn_GST_R').val('Rejected');
                    $("#btn_GST_A").css("display", "none");
                }
                $("#btn_GST_R").removeAttr('enabled');
                $("#btn_GST_R").attr('disabled', 'disabled');
            }


            if (AADHAR_VFYD == '1' || AADHAR_VFYD == '2') {
                if (AADHAR_VFYD == '1') {
                    $('#btn_AADHAR_A').val('Approved');
                    $('#btn_AADHAR_A').css('background-color', 'Green');

                    $("#btn_AADHAR_R").css("display", "none");
                    // $("#uploadimg_Aadhar").css("display", "none");
                }
                $("#btn_AADHAR_A").removeAttr('enabled');
                $("#btn_AADHAR_A").attr('disabled', 'disabled');

                if (AADHAR_VFYD == '2') {
                    $('#btn_AADHAR_R').val('Rejected');

                    $("#btn_AADHAR_A").css("display", "none");
                }
                $("#btn_AADHAR_R").removeAttr('enabled');
                $("#btn_AADHAR_R").attr('disabled', 'disabled');
            }

        }



        function UpdateApprove(flag) {

            if (!confirm('Are you sure you want to Approve.!!')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateApprove',
                data: '{ FranchiseID: "' + $('#<%=hnd_FranchiseId.ClientID%>').val() + '", flag: "' + flag + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {

                        if (flag == "PAN") {
                            $('#btn_Pan_A').val('Approved');
                            $('#btn_Pan_A').css('background-color', 'Green');

                            $("#btn_Pan_A").removeAttr('enabled');
                            $("#btn_Pan_A").attr('disabled', 'disabled');

                            $("#btn_Pan_R").css('display', 'none');
                            //$("#uploadimg_Pan").css("display", "none");
                        }
                        if (flag == "BANK") {
                            $('#btn_BANK_A').val('Approved');
                            $('#btn_BANK_A').css('background-color', 'Green');

                            $("#btn_BANK_A").removeAttr('enabled');
                            $("#btn_BANK_A").attr('disabled', 'disabled');

                            $("#btn_BANK_R").css('display', 'none');
                            //$("#uploadimg_Bank").css("display", "none");
                        }
                        if (flag == "GST") {
                            $('#btn_GST_A').val('Approved');
                            $('#btn_GST_A').css('background-color', 'Green');

                            $("#btn_GST_A").removeAttr('enabled');
                            $("#btn_GST_A").attr('disabled', 'disabled');

                            $("#btn_GST_R").css('display', 'none');
                            // $("#uploadimg_GST").css("display", "none");
                        }
                        if (flag == "AADHAR") {
                            $('#btn_AADHAR_A').val('Approved');
                            $('#btn_AADHAR_A').css('background-color', 'Green');

                            $("#btn_AADHAR_A").removeAttr('enabled');
                            $("#btn_AADHAR_A").attr('disabled', 'disabled');

                            $("#btn_AADHAR_R").css('display', 'none');
                            //$("#uploadimg_Aadhar").css("display", "none");
                        }
                        BindTable();

                    } else {
                        alert(data.d.Error);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        }


        function UpdateReject(flag) {
            if (!confirm('Are you sure you want to Reject.!!')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateReject',
                data: '{ FranchiseID: "' + $('#<%=hnd_FranchiseId.ClientID%>').val() + '", flag: "' + flag + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        if (flag == "PAN") {
                            $('#btn_Pan_R').val('Rejected');
                            $("#btn_Pan_R").removeAttr('enabled');
                            $("#btn_Pan_R").attr('disabled', 'disabled');

                            $('#btn_Pan_A').css("display", "none");
                            $('#lbl_PanImg').html('<a href="#" data-fancybox="gallery"> <img src="" width="200px" height="250px"> </a>');
                        }
                        if (flag == "BANK") {
                            $('#btn_BANK_R').val('Rejected');
                            $("#btn_BANK_R").removeAttr('enabled');
                            $("#btn_BANK_R").attr('disabled', 'disabled');

                            $('#btn_BANK_A').css("display", "none");
                            $('#lbl_BankImg').html('<a href="#" data-fancybox="gallery"> <img src="" width="200px" height="250px"> </a>');
                        }


                        if (flag == "GST") {
                            $('#btn_GST_R').val('Rejected');
                            $("#btn_GST_R").removeAttr('enabled');
                            $("#btn_GST_R").attr('disabled', 'disabled');

                            $('#btn_GST_A').css("display", "none");
                            $('#lbl_GSTImg').html('<a href="#" data-fancybox="gallery"> <img src="" width="200px" height="250px"> </a>');
                        }
                        if (flag == "AADHAR") {
                            $('#btn_AADHAR_R').val('Rejected');
                            $("#btn_AADHAR_R").removeAttr('enabled');
                            $("#btn_AADHAR_R").attr('disabled', 'disabled');

                            $('#btn_AADHAR_A').css("display", "none");
                            $('#lbl_AadharFrontImg').html('<a href="#" data-fancybox="gallery"> <img src="" width="200px" height="250px"> </a>');
                            $('#lbl_AadharBackImg').html('<a href="#" data-fancybox="gallery"> <img src="" width="200px" height="250px"> </a>');
                        }
                        BindTable();

                    } else {
                        alert(data.d.Error);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }



        function FranLogin(FId, frantype, Name, Type) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/FranLogin',
                data: '{FranchiseId: "' + FId + '", frantype: "' + frantype + '", Name: "' + Name + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {

                        if (Type == 'UL') {
                            window.location = "../franchise/welcome.aspx";
                        }
                        if (Type == 'FS') {
                            window.location = "../franchise/ClosingStock.aspx";
                        }

                    }
                    else if (data.d == "SessionOut") {
                        window.location = "logout.aspx";
                    }

                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        }


        function ViewBalance(FranchiseId) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/ViewBalance',
                data: '{FranchiseId: "' + FranchiseId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#lbl_FranStock' + FranchiseId).text(data.d);
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        }


        function RegeneratePwd(FranchiseId, Name, Mobile) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/RegeneratePwd',
                data: '{FranchiseId: "' + FranchiseId + '", Name: "' + Name + '", Mobile: "' + Mobile + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        alert("Password regenerated successfully.!!");
                    }
                    else {
                        alert(data.d);
                    }
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        }




        function UpdateStatus(FranchiseId, flag) {

            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{FranchiseId: "' + FranchiseId + '", flag: "' + flag + '"}',
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





    <div class="modal fade bd-example-modal-lg" tabindex="-1" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">KYC Approve</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal">
                    </button>
                </div>
                <div class="modal-body p-1">
                    <div class="table-responsive">
                        <table class="table table-striped  text-center table-hover primary-table-bordered ">
                            <thead>
                                <tr style="background: #fe6a00; color: #fff;">
                                    <td>Pan</td>
                                    <td>Bank</td>
                                    <td>GST</td>
                                    <td>Aadhar Card Front</td>
                                    <td>Aadhar Card Back</td>
                                    <td>Payment Slip</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div id="lbl_PanImg"></div>


                                        <br />
                                        <input type="file" id="img_Pan" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Pan();" style="display: none;" />
                                        <label for="img_Pan" title="Pan Card" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>

                                        <br />
                                        <input type="button" id="btn_Pan_A" onclick="UpdateApprove('PAN')" value="Approve" class="btn btn-success" />
                                        <input type="button" id="btn_Pan_R" onclick="UpdateReject('PAN')" value="Reject" class="btn btn-danger" />
                                    </td>
                                    <td>
                                        <div id="lbl_BankImg"></div>

                                        <br />
                                        <input type="file" id="img_Bank" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Bank();" style="display: none;" />
                                        <label for="img_Bank" title="Bank" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                        <br />
                                        <input type="button" id="btn_BANK_A" onclick="UpdateApprove('BANK')" value="Approve" class="btn btn-success" />
                                        <input type="button" id="btn_BANK_R" onclick="UpdateReject('BANK')" value="Reject" class="btn btn-danger" />
                                    </td>
                                    <td>
                                        <div id="lbl_GSTImg"></div>


                                        <br />
                                        <input type="file" id="img_Gst" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_GST();" style="display: none;" />
                                        <label for="img_Gst" title="GST" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                        <br />
                                        <input type="button" id="btn_GST_A" onclick="UpdateApprove('GST')" value="Approve" class="btn btn-success" />
                                        <input type="button" id="btn_GST_R" onclick="UpdateReject('GST')" value="Reject" class="btn btn-danger" />
                                    </td>

                                    <td>
                                        <div id="lbl_AadharFrontImg"></div>


                                        <br />
                                        <input type="file" id="img_Aadhar_Front" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Aadhar_Front();" style="display: none;" />
                                        <label for="img_Aadhar_Front" title="Aadhar Card Front" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                    </td>
                                    <td>
                                        <div id="lbl_AadharBackImg"></div>


                                        <br />
                                        <input type="file" id="img_Aadhar_Back" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Aadhar_Back();" style="display: none;" />
                                        <label for="img_Aadhar_Back" title="Aadhar Card Back" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                        <br />
                                        <input type="button" id="btn_AADHAR_A" onclick="UpdateApprove('AADHAR')" value="Approve" class="btn btn-success" />
                                        <input type="button" id="btn_AADHAR_R" onclick="UpdateReject('AADHAR')" value="Reject" class="btn btn-danger" />
                                    </td>
                                    <td>
                                        <div id="lbl_Slipimg"></div>

                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>



                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger light" data-bs-dismiss="modal">Close</button>
                    <%--  <button type="button" class="btn btn-primary">Save changes</button>--%>
                </div>
            </div>
        </div>
    </div>



    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>



    <script type="text/javascript">

        $(function () {

            $("[id*=img_Pan]").change(function () {

                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#lbl_PanImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="100%"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Pan').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Bank]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#lbl_BankImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="100%"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Bank').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Aadhar_Front]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#lbl_AadharFrontImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="100%"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Aadhar_Front').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Aadhar_Back]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#lbl_AadharBackImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="100%"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Aadhar_Back').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Gst]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#lbl_GSTImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="100%"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Gst').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });

        });


        function Upload_Pan() {

            var fileUpload = $("#img_Pan").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FPan" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Pan = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {


                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{ FranchiseID: "' + $('#<%=hnd_FranchiseId.ClientID%>').val() + '", flag: "PAN", ImgName: "' + ImgName_Pan + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#btn_Pan_A').val('Approved');
                                    $('#btn_Pan_A').css('background-color', 'Green');

                                    $("#btn_Pan_A").removeAttr('enabled');
                                    $("#btn_Pan_A").attr('disabled', 'disabled');
                                    $("#btn_Pan_A").css('display', 'block');

                                    $("#btn_Pan_R").css('display', 'none');
                                    BindTable();
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });


                    },
                    error: function (err) { }
                });
            }
        }




        function Upload_Bank() {

            var fileUpload = $("#img_Bank").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FBank" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Bank = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{ FranchiseID: "' + $('#<%=hnd_FranchiseId.ClientID%>').val() + '", flag: "BANK", ImgName: "' + ImgName_Bank + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#btn_BANK_A').val('Approved');
                                    $('#btn_BANK_A').css('background-color', 'Green');

                                    $("#btn_BANK_A").removeAttr('enabled');
                                    $("#btn_BANK_A").attr('disabled', 'disabled');
                                    $("#btn_BANK_A").css('display', 'block');

                                    $("#btn_BANK_R").css('display', 'none');
                                    BindTable();
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });
                    },
                    error: function (err) { }
                });
            }
        }

        function Upload_Aadhar_Front() {

            var fileUpload = $("#img_Aadhar_Front").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FAadhar_Front" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Aadhar_Front = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{ FranchiseID: "' + $('#<%=hnd_FranchiseId.ClientID%>').val() + '", flag: "AADHARFRONT", ImgName: "' + ImgName_Aadhar_Front + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#btn_AADHAR_A').val('Approved');
                                    $('#btn_AADHAR_A').css('background-color', 'Green');

                                    $("#btn_AADHAR_A").removeAttr('enabled');
                                    $("#btn_AADHAR_A").attr('disabled', 'disabled');
                                    $("#btn_AADHAR_A").css('display', 'block');

                                    $("#btn_AADHAR_R").css('display', 'none');
                                    BindTable();
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });

                    },
                    error: function (err) { }
                });
            }
        }

        function Upload_Aadhar_Back() {

            var fileUpload = $("#img_Aadhar_Back").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FAadhar_Back" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Aadhar_Back = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{ FranchiseID: "' + $('#<%=hnd_FranchiseId.ClientID%>').val() + '", flag: "AADHARBACK", ImgName: "' + ImgName_Aadhar_Back + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#btn_AADHAR_A').val('Approved');
                                    $('#btn_AADHAR_A').css('background-color', 'Green');

                                    $("#btn_AADHAR_A").removeAttr('enabled');
                                    $("#btn_AADHAR_A").attr('disabled', 'disabled');
                                    $("#btn_AADHAR_A").css('display', 'block');

                                    $("#btn_AADHAR_R").css('display', 'none');
                                    BindTable();
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });

                    },
                    error: function (err) { }
                });
            }
        }

        function Upload_GST() {

            var fileUpload = $("#img_Gst").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FGST" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    GST_img = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{ FranchiseID: "' + $('#<%=hnd_FranchiseId.ClientID%>').val() + '", flag: "GST", ImgName: "' + GST_img + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#btn_GST_A').val('Approved');
                                    $('#btn_GST_A').css('background-color', 'Green');

                                    $("#btn_GST_A").removeAttr('enabled');
                                    $("#btn_GST_A").attr('disabled', 'disabled');
                                    $("#btn_GST_A").css('display', 'block');

                                    $("#btn_GST_R").css('display', 'none');
                                    BindTable();
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });

                    },
                    error: function (err) { }
                });
            }
        }



        function GetDistrict() {
            $('#<%=ddl_District.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDistrict',
                data: "{'StateId':'" + $("#<%=ddl_State.ClientID%>").val() + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     $("#<%=ddl_District.ClientID %>").empty().append($("<option></option>").val('').html('Select District'));
                    PopulateControl(response.d, $("#<%=ddl_District.ClientID%>"));
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function PopulateControl(list, control) {
            if (list.length > 0) {
                control.removeAttr("disabled");
                $.each(list, function () {
                    control.append($("<option></option>").val(this['Value']).html(this['Text']));
                });
            }
            else {
                control.empty().append('<option selected="selected" value="0">Not available<option>');
            }
        }



    </script>
    <style>
        @media (min-width: 992px) {
            .modal-lg, .modal-xl {
                max-width: 1500px;
            }
        }

        .table tbody tr td {
            vertical-align: top;
            border-color: #e3d3d3;
        }
    </style>

</asp:Content>
