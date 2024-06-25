<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="FranchisePending.aspx.cs" Inherits="admin_IncRegId" Title="Approvel Franchise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600 me-auto float-left mb-0">Approve Franchise</h4>
    <div class="form-group card-group-row row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" placeholder="From"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" placeholder="To"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="ddl_Mobile" runat="server" CssClass="form-control" placeholder="Enter Mobile No."></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Verified" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Pending</asp:ListItem>
                <asp:ListItem Value="2">Rejected</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>
    <hr />
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

                    <%-- <th></th>
                            <th></th>
                            <th></th>--%>
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

        var pageUrl = "FranchisePending.aspx";
        $JDT(function () {
            BindTable();
        });

        function BindTable() {
            var Mobile = $('#<%=ddl_Mobile.ClientID%>').val();
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            var Verified = $('#<%=ddl_Verified.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{min: "' + min + '", max: "' + max + '",Mobile: "' + Mobile + '",Verified: "' + Verified + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        var FranchiseID = data.d[i].FranchiseID;


                        var FranchiseType = '<select id="ddl_FranType' + FranchiseID + '" class="dropdown-select form-control">';
                        FranchiseType += '<option value="-1">Select Type</option>';
                        FranchiseType += '<option value="2">Company</option>';
                        FranchiseType += '<option value="3">Depo</option>';
                        FranchiseType += '<option value="4">TopCircle</option>';
                        FranchiseType += '<option value="5">TopPoint</option>';
                        FranchiseType += '<option value="6">TopShopee</option>';
                        FranchiseType += '</select>';

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


                        var View = '<button type="button" onclick="View(' + FranchiseID + ' ,' + Pan_img + ',' + Bank_img + ',' + GST_img + ',' + Aadhar_B_img + ',' + Aadhar_F_img + ',' + Pan_VFYD + ',' + Bank_VFYD + ',' + GST_VFYD + ',' + AADHAR_VFYD + ',' + Slip_img + ')" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg"><i class="fa fa-eye" aria-hidden="true"></i></button>';

                        var Action = '';
                        if (data.d[i].IsVerified == "1") {
                            Action = '<a href="#/" class="btn btn-success">Approved</a>';
                        }
                        else if (data.d[i].IsVerified == "2") {
                            Action = '<a href="#/" class="btn btn-danger">Rejected</a>';
                        }
                        else {
                            Action = '<a href="#/" onclick="SavaDetails(' + FranchiseID + ')" class="btn btn-success">Approved</a> <br> <a href="#/" onclick="RejectFran(' + FranchiseID + ')" class="btn btn-danger">Reject</a>';
                        }


                        json.push([i + 1,
                            View,
                        '<input type="text" id="txt_OpeningAmount' + FranchiseID + '" value="' + data.d[i].OpeningAmount + '" class="form-control"></input>',
                        '<input type="text" id="txt_MinStkAmt' + FranchiseID + '" value="' + data.d[i].MinStkAmt + '" class="form-control"></input>',
                        '<input type="text" id="txt_MappingId' + FranchiseID + '" value="' + data.d[i].MappingId + '" class="form-control"></input>',
                            FranchiseType,
                        '<input type="text" id="txt_Pwd' + FranchiseID + '" class="form-control"></input>',
                            Action,
                        data.d[i].RegistrationDate,
                        data.d[i].FranchiseName,
                        data.d[i].ContactPerson,
                        data.d[i].MobileNo,
                        //data.d[i].email,
                        //data.d[i].Address,
                        data.d[i].State,
                        // data.d[i].District, 
                        // data.d[i].City,
                        data.d[i].PIN,
                        data.d[i].BankName,
                        data.d[i].AccountNo,
                        data.d[i].IFSCCode,
                        data.d[i].GST,
                        data.d[i].CinNo,
                        data.d[i].PAN,
                        data.d[i].SponsorID,
                        data.d[i].SponsorName,
                        data.d[i].IS_OPTIN == "1" ? '<sapn style="color:green;"> <i class="fa fa-check" aria-hidden="true"></i> </span>' : '<sapn style="color:red;"> <i class="fa fa-times" aria-hidden="true"></i> </span>',

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
                            { title: "#" },


                            { title: "KYC" },
                            { title: "Open. Amt" },
                            { title: "Min Stk Amt" },
                            { title: "Map. Id" },
                            { title: "<div style='width:100px;'>Type </div>" },
                            { title: "Password" },
                            { title: "Action" },
                            { title: "Date" },
                            { title: "Franchise Name" },
                            { title: "Partner/ Director Name" },

                            { title: "Mobile No." },
                            //{ title: "Email" },
                            //{ title: "Address" },
                            { title: "State" },
                            // { title: "District" },
                            //{ title: "City" },
                            { title: "PIN" },

                            { title: "BankName" },
                            { title: "A/c No." },
                            { title: "IFSC" },
                            { title: "GST No." },
                            { title: "CIN No." },
                            { title: "PAN" },
                            { title: "Sponsor Id" },
                            { title: "Sponsor Name" },
                            { title: "Whatsapp OPTIN" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 10,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                    });
                },
                error: function (result) {
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



        function SavaDetails(FranchiseID) {
            var OpeningAmount = $('#txt_OpeningAmount' + FranchiseID).val();
            var MinStkAmt = $('#txt_MinStkAmt' + FranchiseID).val();
            var MappingId = $('#txt_MappingId' + FranchiseID).val();
            var FranType = $('#ddl_FranType' + FranchiseID).val();
            var Pwd = $('#txt_Pwd' + FranchiseID).val();
            if (Pwd == '') {
                alert("Please Enter Password..");
                return false;
            }

            if (FranType == '-1') {
                alert("Please Select Franchise Type.");
                return false;
            }

            if (!confirm('Are you sure you want to create franchise your existing system')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateFranDetails',
                data: '{ FranchiseID: "' + FranchiseID + '", OpeningAmount: "' + OpeningAmount + '", MinStkAmt: "' + MinStkAmt + '", MappingId: "' + MappingId
                    + '", FranType: "' + FranType + '", Pwd: "' + Pwd + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        alert("Thank You for Registration. Name: " + data.d.Name + " ID :" + data.d.FranchiseId + " PWD: " + Pwd);
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

        function RejectFran(FranchiseID) {

            if (!confirm('Are you sure you want to reject.')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/RejectFran',
                data: '{ FranchiseID: "' + FranchiseID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        alert("Rejected Successfully.");
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
        }



        function View(FranchiseID, Pan_img, Bank_img, GST_img, Aadhar_B_img, Aadhar_F_img, Pan_VFYD, Bank_VFYD, GST_VFYD, AADHAR_VFYD, Slip_img) {
            $('#<%=hnd_FranchiseId.ClientID%>').val(FranchiseID);



            $('#lbl_PanImg').html('<a href="../images/Slip/' + Pan_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Pan_img + '" width="200px" height="200px"> </a>');
            $('#lbl_BankImg').html('<a href="../images/Slip/' + Bank_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Bank_img + '" width="200px" height="200px"> </a>');
            $('#lbl_GSTImg').html('<a href="../images/Slip/' + GST_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + GST_img + '" width="200px" height="200px"> </a>');
            $('#lbl_AadharFrontImg').html('<a href="../images/Slip/' + Aadhar_F_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Aadhar_F_img + '" width="200px" height="200px"> </a>');
            $('#lbl_AadharBackImg').html('<a href="../images/Slip/' + Aadhar_B_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Aadhar_B_img + '" width="200px" height="200px"> </a>');
            $('#lbl_Slipimg').html('<a href="../images/Slip/' + Slip_img + '" data-fancybox="gallery"> <img src="../images/Slip/' + Slip_img + '" width="200px" height="200px"> </a>');
            //  uploadimg_Pan uploadimg_Bank  uploadimg_GST uploadimg_Aadhar

            if (Pan_VFYD == '1' || Pan_VFYD == '2') {
                if (Pan_VFYD == '1') {
                    $('#btn_Pan_A').val('Approved');
                    $('#btn_Pan_A').css('background-color', 'Green');

                    $("#btn_Pan_R").css("display", "none");
                    // $("#uploadimg_Pan").css("display", "none");

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
                    //$("#uploadimg_Aadhar").css("display", "none");
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
                        //  uploadimg_Pan uploadimg_Bank  uploadimg_GST uploadimg_Aadhar
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
                            // $("#uploadimg_Bank").css('display', 'none');
                        }
                        if (flag == "GST") {
                            $('#btn_GST_A').val('Approved');
                            $('#btn_GST_A').css('background-color', 'Green');

                            $("#btn_GST_A").removeAttr('enabled');
                            $("#btn_GST_A").attr('disabled', 'disabled');

                            $("#btn_GST_R").css('display', 'none');
                            // $("#uploadimg_GST").css('display', 'none');
                        }
                        if (flag == "AADHAR") {
                            $('#btn_AADHAR_A').val('Approved');
                            $('#btn_AADHAR_A').css('background-color', 'Green');

                            $("#btn_AADHAR_A").removeAttr('enabled');
                            $("#btn_AADHAR_A").attr('disabled', 'disabled');

                            $("#btn_AADHAR_R").css('display', 'none');
                            // $("#uploadimg_Aadhar").css('display', 'none');
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


    </script>

    <%-- <button type="button" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg">Large modal</button>--%>

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
                                <label id="uploadimg_Pan" for="img_Pan" title="Pan Card" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                <br />
                                <input type="button" id="btn_Pan_A" onclick="UpdateApprove('PAN')" value="Approve" class="btn btn-success" />
                                <input type="button" id="btn_Pan_R" onclick="UpdateReject('PAN')" value="Reject" class="btn btn-danger" /></td>
                <td>
<div id="lbl_BankImg"></div>
                                <br />
                                <input type="file" id="img_Bank" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Bank();" style="display: none;" />
                                <label id="uploadimg_Bank" for="img_Bank" title="Bank" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                <br />
                                <input type="button" id="btn_BANK_A" onclick="UpdateApprove('BANK')" value="Approve" class="btn btn-success" />
                                <input type="button" id="btn_BANK_R" onclick="UpdateReject('BANK')" value="Reject" class="btn btn-danger" />
                </td>
                    <td>
                        <div id="lbl_GSTImg"></div>
                                <br />
                                <input type="file" id="img_Gst" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_GST();" style="display: none;" />
                                <label id="uploadimg_GST" for="img_Gst" title="GST" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                <br />
                                <input type="button" id="btn_GST_A" onclick="UpdateApprove('GST')" value="Approve" class="btn btn-success" />
                                <input type="button" id="btn_GST_R" onclick="UpdateReject('GST')" value="Reject" class="btn btn-danger" /></td>
                   
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
                                <label id="uploadimg_Aadhar" for="img_Aadhar_Back" title="Aadhar Card Back" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                <br />
                                <input type="button" id="btn_AADHAR_A" onclick="UpdateApprove('AADHAR')" value="Approve" class="btn btn-success" />
                                <input type="button" id="btn_AADHAR_R" onclick="UpdateReject('AADHAR')" value="Reject" class="btn btn-danger" /></td>

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
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="200px" height="250px"> </a>');
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
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="200px" height="250px"> </a>');
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
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="200px" height="250px"> </a>');
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
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="200px" height="250px"> </a>');
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
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="200px" height="250px"> </a>');
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

    </script>
    <style>
        @media (min-width: 992px){
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

