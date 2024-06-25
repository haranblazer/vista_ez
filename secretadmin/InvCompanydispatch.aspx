﻿<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="InvCompanydispatch.aspx.cs" EnableEventValidation="false" Inherits="secretadmin_InvCompanydispatch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Transport Report</h4>

      <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>


    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>
        <div class="col-md-2 ">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txt_Buyerid" runat="server" CssClass="form-control" placeholder="Enter Buyer Id"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="Txt_InvoiceNo" runat="server" MaxLength="30" CssClass="form-control" placeholder="Enter Invoice No."></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Del_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1" Selected="True">All </asp:ListItem>
                <asp:ListItem Value="7">Transit</asp:ListItem>
                <asp:ListItem Value="1">Dispatched</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-2 col-xs-2 text-right">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                Search
            </button>
        </div>
    </div>

    <hr />

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display nowrap cell-border" style="width: 100%">
            <tfoot align="left">
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
                </tr>
            </tfoot>
        </table>
    </div>





    <div class="clearfix"></div>

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function dateEvent(id) { $JD(id).datepick({ dateFormat: 'dd/mm/yyyy' }); }

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
        var pageUrl = '<%=ResolveUrl("InvCompanydispatch.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            var soldto = $('#<%=txt_Buyerid.ClientID%>').val();
            var invoiceno = $('#<%=Txt_InvoiceNo.ClientID%>').val();
            var Del_Status = $('#<%=ddl_Del_Status.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", soldto: "' + soldto + '", invoiceno: "' + invoiceno + '", Del_Status: "' + Del_Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    var Addevent = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var inv = "'" + data.d[i].InvoiceNo + "'";
                        var srno = data.d[i].srno;
                        var Type = "'" + data.d[i].Type + "'";

                        var InvoiceNo = '<a style="color: #727272; font-weight: bold;" href="../Common/StockTranBill.aspx?id=' + data.d[i].srno_Encode + '">' + data.d[i].InvoiceNo + '</a>';
                        if (data.d[i].Type == "USER")
                            InvoiceNo = '<a style="color: #727272; font-weight: bold;" href="../Common/Invoice.aspx?id=' + data.d[i].srno_Encode + '">' + data.d[i].InvoiceNo + '</a>';

                        var DispatchStatus = "";
                        if (data.d[i].Del_Status == "7") {
                            DispatchStatus = " <span style='color:orange'>Transit</<span>";
                        }
                        else if (data.d[i].Del_Status == "1") {
                            DispatchStatus = " <span style='color:green'>Delivered</<span>";
                        }
                        else if (data.d[i].Del_Status == "0") {
                            DispatchStatus = " <span style='color:red'>Pending</<span>";
                        }

                        var Deliver = "";
                        if (data.d[i].Del_Status == '1') {
                            Deliver = '<a href="#/" onclick="Deliver_Invice(' + Type + ',' + data.d[i].srno + ')" class="btn btn-success">Dispatched</a>';
                        }
                        else {
                            Deliver = '<a href="#/" onclick="Deliver_Invice(' + Type + ',' + data.d[i].srno + ')" class="btn btn-success">Transit</a>';
                        }

                        var Img1Color = "style=color:blue;";
                        if (data.d[i].Slip != "")
                            Img1Color = "style=color:green;";

                        var Img2Color = "style=color:blue;";
                        if (data.d[i].Img2 != "")
                            Img2Color = "style=color:green;";

                        var Upload_lr1 = '<input type="file" id="img_lr1' + srno + '" accept=".png,.jpg,.jpeg,.gif" style="display:none;"> <label for="img_lr1' + srno + '" title="Upload LR Image 1"> <i class="fa fa-upload"></i> </label>  <br> <a href="../images/Slip/' + data.d[i].Slip + '" data-fancybox="gallery" ' + Img1Color + '"> <i class="fa fa-eye" title="View Image 1"></i> </a>';
                        var Upload_lr2 = '<input type="file" id="img_lr2' + srno + '" accept=".png,.jpg,.jpeg,.gif" style="display:none;"> <label for="img_lr2' + srno + '" title="Upload LR Image 2"> <i class="fa fa-upload"></i> </label>  <br> <a href="../images/Slip/' + data.d[i].Img2 + '" data-fancybox="gallery" ' + Img2Color + '"> <i class="fa fa-eye" title="View Image 2"></i> </a>';

                        var SMS = "'SMS'";
                        var WHATSAPP = "'WHATSAPP'";

                        var SMS_BuyerUserId = "'" + data.d[i].BuyerUserId + "'";
                        var SMS_BuyerName = "'" + data.d[i].BuyerName + "'";
                        var SMS_Disp_Date = "'" + data.d[i].DispatchDate + "'";
                        var SMS_Docket = "'" + data.d[i].Tracking + "'";
                        var SMS_Transport = "'" + data.d[i].Transport + "'";
                        var SMS_MobileNo = "'" + data.d[i].BuyerMobileNo + "'";
                        var SMS_IMG_LR1 = "'" + data.d[i].Slip + "'";

                        var Send_sms = '<span class="dotBlue" title="SMS Count">' + data.d[i].SendMsg + '</span> <a href="#/" onclick="SendSms(' + SMS + ',' + Type + ',' + srno + ',' + SMS_BuyerUserId + ',' + SMS_BuyerName + ',' + inv + ',' + SMS_Disp_Date + ',' + SMS_Docket + ',' + SMS_Transport + ',' + SMS_MobileNo + ',' + SMS_IMG_LR1 + ')" class="btn btn-success" title="Send Message"> <i class="fa fa-send-o"></i> </a>';
                        var Send_Whats_sms = '<span class="dotBlue" title="SMS Count">' + data.d[i].SendWhatsApp + '</span> <a href="#/" onclick="SendSms(' + WHATSAPP + ', ' + Type + ',' + srno + ',' + SMS_BuyerUserId + ',' + SMS_BuyerName + ',' + inv + ',' + SMS_Disp_Date + ',' + SMS_Docket + ',' + SMS_Transport + ',' + SMS_MobileNo + ',' + SMS_IMG_LR1 + ')" class="btn btn-success" title="Send Whats App Message"> <i class="fa fa-whatsapp"></i> </a>';
                        var IS_OPTIN = "<span class='dotGrey' title='Not Optin'></span>";
                        if (data.d[i].IS_OPTIN == "1")
                            var IS_OPTIN = "<span class='dotGreen' title='Is Optin'></span>";

                        Addevent.push({ id: srno });
                        json.push([
                            i + 1,
                            data.d[i].Date,
                            InvoiceNo,
                            DispatchStatus,
                            data.d[i].BuyerUserId,
                            data.d[i].BuyerName,
                            data.d[i].BuyerState,
                            data.d[i].BuyerMobileNo,
                            data.d[i].netAmt,
                            data.d[i].ConfirmWith,

                            data.d[i].DurationDays,
                            data.d[i].DeliveryDate,

                            '<input type="text" id="txt_DispatchedDate' + srno + '" value="' + data.d[i].DispatchDate + '" onclick="dateEvent("txt_DispatchedDate"' + srno + '");" placeholder="dd/mm/yyyy" class="form-control"></input> <span style="display:none;">' + data.d[i].DispatchDate + '</span>',
                            '<input type="text" id="txt_Transport' + srno + '" value="' + data.d[i].Transport + '" class="form-control"></input> <span style="display:none;">' + data.d[i].Transport + '</span>',
                            '<input type="text" id="txt_Tracking' + srno + '" value="' + data.d[i].Tracking + '" class="form-control"></input> <span style="display:none;">' + data.d[i].Tracking + '</span>',
                            '<input type="text" id="txt_EWay' + srno + '" value="' + data.d[i].EwayNo + '" class="form-control"></input> <span style="display:none;">' + data.d[i].EwayNo + '</span>',
                            '<input type="text" id="txt_Boxes' + srno + '" value="' + data.d[i].No_Boxes + '" class="form-control"></input> <span style="display:none;">' + data.d[i].No_Boxes + '</span>',
                            '<input type="text" id="txt_Weight' + srno + '" value="' + data.d[i].Weight_KG + '" class="form-control"></input> <span style="display:none;">' + data.d[i].Weight_KG + '</span>',
                            '<input type="text" id="txt_Remarks' + srno + '" value="' + data.d[i].Del_Remarks + '" class="form-control"></input> <span style="display:none;">' + data.d[i].Del_Remarks + '</span>',

                            Upload_lr1,
                            Upload_lr2,
                            Deliver,
                            Send_sms,
                            Send_Whats_sms + ' ' + IS_OPTIN,
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
                            { title: "SNo" },
                            { title: "Date" },
                            { title: "Invoice No." },
                            { title: "Dispatch <br/>Status" },
                            { title: "Buyer ID" },
                            { title: "Buyer Name" },
                            { title: "Buyer State" },
                            { title: "Buyer Mobile No." },
                            { title: "DP with Tax" },
                            { title: "Confirm With" },

                            { title: "Duration days" },
                            { title: "Delivery date" },

                            { title: "Dispatch Date" },
                            { title: "Transport" },
                            { title: "Docket No" },
                            { title: "EWay Bill" },
                            { title: "No. Boxes" },
                            { title: "Weight KG" },
                            { title: "Remarks" },

                            { title: "Img LR1" },
                            { title: "Img LR2" },
                            { title: "Deliver" },
                            { title: "SMS" },
                            { title: "Whatsapp" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            //    // Total over all pages
                            $(api.column(1).footer()).html('Total:');
                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                        }
                    });

                    $.each(Addevent, function (index, value) {
                        dateEvent("#txt_DispatchedDate" + value.id);
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

    </script>

    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
    <script> var $JJ = $.noConflict(true); </script>
    <script type="text/javascript">



        function Deliver_Invice(Type, srno) {
            var Transport = $('#txt_Transport' + srno).val();
            var Tracking = $('#txt_Tracking' + srno).val();
            var EWay = $('#txt_EWay' + srno).val();
            var Remarks = $('#txt_Remarks' + srno).val();
            var Weight = $('#txt_Weight' + srno).val();
            var Boxes = $('#txt_Boxes' + srno).val();

            var DispatchedDate = $('#txt_DispatchedDate' + srno).val();
            if (DispatchedDate != "")
                DispatchedDate = dateFormate(DispatchedDate);


            if (!confirm('Are you sure you want to transit？')) {
                return false;
            }

            var ImgName1 = "";
            var fileUpload1 = $JJ("#img_lr1" + srno).get(0);
            var files1 = fileUpload1.files;
            var data1 = new FormData();

            var random1 = Math.floor(1000000 + Math.random() * 9000000);
            if (Type == "FRAN")
                random1 = "s1" + random1;
            if (Type == "USER")
                random1 = "b1" + random1;
            for (var i = 0; i < files1.length; i++) {
                var ext = files1[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data1.append(random1 + '.' + ext, files1[i]);
                ImgName1 = random1 + '.' + ext;
            }



            var ImgName2 = "";
            var fileUpload2 = $JJ("#img_lr2" + srno).get(0);
            var files2 = fileUpload2.files;
            var data2 = new FormData();

            var random2 = Math.floor(1000000 + Math.random() * 9000000);
            if (Type == "FRAN")
                random2 = "s2" + random2;
            if (Type == "USER")
                random2 = "b2" + random2;

            for (var i = 0; i < files2.length; i++) {
                var ext = files2[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data2.append(random2 + '.' + ext, files2[i]);
                ImgName2 = random2 + '.' + ext;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/Dispatch_Inv',
                data: '{ Type: "' + Type + '",srno: "' + srno + '", Transport: "' + Transport + '", Tracking: "' + Tracking + '", EWay: "' + EWay + '", Remarks: "' + Remarks
                    + '", Weight: "' + Weight + '", Boxes: "' + Boxes + '", ImgName1: "' + ImgName1 + '", ImgName2: "' + ImgName2 + '", DispatchedDate: "' + DispatchedDate + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Deliver Updated Successfully");

                        if (ImgName1 != "") {
                            var _URL = window.URL || window.webkitURL;
                            $.ajax({
                                url: "../FranchiseHandler.ashx",
                                type: "POST",
                                data: data1,
                                contentType: false,
                                processData: false,
                                success: function (result) { },
                                error: function (err) { }
                            });
                        }

                        if (ImgName2 != "") {
                            var _URL = window.URL || window.webkitURL;
                            $.ajax({
                                url: "../FranchiseHandler.ashx",
                                type: "POST",
                                data: data2,
                                contentType: false,
                                processData: false,
                                success: function (result) { },
                                error: function (err) { }
                            });
                        }

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



        function SendSms(SMSTYPE, Type, srno, UserId, Name, Inv, Date, Docket, Transport, Mobile, Img_Lr1) {
            if (!confirm('Are you sure you want to send message？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/SendSms',
                data: '{SMSTYPE: "' + SMSTYPE + '", Type: "' + Type + '", srno: "' + srno + '", UserId: "' + UserId + '", Name: "' + Name
                    + '", Inv: "' + Inv + '", Date: "' + Date + '", Docket: "' + Docket + '",Transport: "' + Transport
                    + '", Mobile: "' + Mobile + '", Img_Lr1: "' + Img_Lr1 + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Message Sent Successfully");
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



    </script>

    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
            vertical-align: inherit;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
            vertical-align: inherit;
        }

        .dotBlue {
            height: 20px;
            width: 20px;
            background-color: #96DED1;
            display: inline-block;
            border-radius: 50%;
            padding-left: 5px;
        }
    </style>
</asp:Content>

