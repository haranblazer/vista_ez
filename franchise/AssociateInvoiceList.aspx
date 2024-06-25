<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="AssociateInvoiceList.aspx.cs" Inherits="user_OrderList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0"><%=method.Associate%> Invoice List</h4>
       <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_DispatchStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All Invoice</asp:ListItem>
                <asp:ListItem Value="1">Dispatched</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1" Selected="True">All</asp:ListItem>
                <asp:ListItem Value="0">Cancelled</asp:ListItem>
                <asp:ListItem Value="1">Submit</asp:ListItem>
            </asp:DropDownList>
        </div>
         <div class="col-sm-2">
        <asp:DropDownList ID="ddl_order" runat="server" CssClass="form-control">
                
                </asp:DropDownList>
             </div>
        <div class="col-sm-3">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="InvoiceNo/ UserID" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-sm-1  text-left">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                Search
            </button>
        </div>
    </div>

    <div class="clearfix"></div>
    <hr />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
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
                    <th></th>
                    <th></th>
                    <th></th> 
                </tr>
            </tfoot>
        </table>
    </div>

   

    <asp:HiddenField ID="hnd_Fran" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_Inv" runat="server" Value="" />

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

        var pageUrl = "AssociateInvoiceList.aspx";
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var SponsorId = $('#<%=txtSearch.ClientID%>').val();
                var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
                var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
                var SoldTo = "";
                var Del_Status = $('#<%=ddl_DispatchStatus.ClientID%>').val();
            var status = $('#<%=ddlStatus.ClientID%>').val();
            var Cust_Type = $('#<%=ddl_order.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindInvoice',
                data: '{SponsorId: "' + SponsorId + '", min: "' + min + '", max: "' + max + '", SoldTo: "' + SoldTo + '", Del_Status: "' + Del_Status + '", status: "' + status + '",Cust_Type:"' + Cust_Type +'"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    //$('#tblList').empty();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        let InvUrl = '';
                        if (data.d[i].Subdistype == 'Loyalty') {
                            InvUrl = 'LR_Invoice';
                        }
                        else {
                            InvUrl = 'Invoice';
                        }
                        var Invoice = '<a target="_blank" href="../Common/' + InvUrl + '.aspx?id=' + data.d[i].srno_Encript + '" style="color: blue; font-weight: bold;">' + data.d[i].InvoiceNo + '</a>';

                        var srno = data.d[i].srno;

                        var Transport = '<input type="text" id="txt_Transport' + srno + '" value="' + data.d[i].Transport + '" class="form-control"></input>';
                        var Tracking = '<input type="text" id="txt_Tracking' + srno + '" value="' + data.d[i].Tracking + '" class="form-control"></input>';
                        var EWay = '<input type="text" id="txt_EWay' + srno + '" value="' + data.d[i].EWayBill + '" class="form-control"></input>';
                        var Remarks = '<input type="text" id="txt_Remarks' + srno + '" value="' + data.d[i].Del_Remarks + '" class="form-control"></input>';

                        var inv = "'" + data.d[i].InvoiceNo + "'";

                        var Deliver = '';
                        if (data.d[i].Del_Status == '1') {
                            //Deliver = '<input type="button" value="Dispatched" class="btn btn-success disabled">';
                            Deliver = '<a href="#/" onclick="Deliver_Invice(' + inv + ',' + data.d[i].srno + ')" class="btn btn-success">Dispatched</a>';
                        }
                        else {//data-bs-toggle="modal" data-bs-target="#myModal"
                            Deliver = '<a href="#/" onclick="Deliver_Invice(' + inv + ',' + data.d[i].srno + ')" class="btn btn-success">Dispatch</a>';
                        }
                        var Img1Color = "style=color:blue;";
                        if (data.d[i].Img1 != "")
                            Img1Color = "style=color:green;";

                        var Img2Color = "style=color:blue;";
                        if (data.d[i].Img2 != "")
                            Img2Color = "style=color:green;";

                        var Upload_lr1 = '<input type="file" id="img_lr1' + srno + '" onChange="javascript:UploadImg_lr1(' + srno + ');" accept=".png,.jpg,.jpeg,.gif" style="display:none;"> <label for="img_lr1' + srno + '" title="Upload LR Image 1"> <i class="fa fa-upload"></i> </label>  <br> <a href="../images/Slip/' + data.d[i].Img1 + '" data-fancybox="gallery" ' + Img1Color + '"> <i class="fa fa-eye" title="View Image 1"></i> </a>';
                        var Upload_lr2 = '<input type="file" id="img_lr2' + srno + '" onChange="javascript:UploadImg_lr2(' + srno + ');" accept=".png,.jpg,.jpeg,.gif" style="display:none;"> <label for="img_lr2' + srno + '" title="Upload LR Image 2"> <i class="fa fa-upload"></i> </label>  <br> <a href="../images/Slip/' + data.d[i].Img2 + '" data-fancybox="gallery" ' + Img2Color + '"> <i class="fa fa-eye" title="View Image 2"></i> </a>';

                        var SMS = "'SMS'";
                        var WHATSAPP = "'WHATSAPP'";

                        var SMS_BuyerUserId = "'" + data.d[i].BuyerUserId + "'";
                        var SMS_BuyerName = "'" + data.d[i].BuyerName + "'";
                        var SMS_Disp_Date = "'" + data.d[i].DispatchDate + "'";
                        var SMS_Docket = "'" + data.d[i].Tracking + "'";
                        var SMS_Transport = "'" + data.d[i].Transport + "'";
                        var SMS_MobileNo = "'" + data.d[i].BuyerMobileNo + "'";
                        var SMS_IMG_LR1 = "'" + data.d[i].Img1 + "'";


                        var Send_sms = '<span class="dotBlue" title="SMS Count">' + data.d[i].SendMsg + '</span> <a href="#/" onclick="SendSms(' + SMS + ',' + srno + ',' + SMS_BuyerUserId + ',' + SMS_BuyerName + ',' + inv + ',' + SMS_Disp_Date + ',' + SMS_Docket + ',' + SMS_Transport + ',' + SMS_MobileNo + ',' + SMS_IMG_LR1 + ')"  class="btn btn-success" title="Send Message"> <i class="fa fa-send-o"></i> </a>';
                        var Send_Whats_sms = '<span class="dotBlue" title="SMS Count">' + data.d[i].SendWhatsApp + '</span> <a href="#/" onclick="SendSms(' + WHATSAPP + ',' + srno + ',' + SMS_BuyerUserId + ',' + SMS_BuyerName + ',' + inv + ',' + SMS_Disp_Date + ',' + SMS_Docket + ',' + SMS_Transport + ',' + SMS_MobileNo + ',' + SMS_IMG_LR1 + ')" class="btn btn-success" title="Send Whats App Message"> <i class="fa fa-whatsapp"></i> </a>';
                        var IS_OPTIN = "<span class='dotGrey' title='Not Optin'></span>";
                        if (data.d[i].IS_OPTIN == "1")
                            var IS_OPTIN = "<span class='dotGreen' title='Is Optin'></span>";


                        json.push([i + 1,
                        data.d[i].Date,
                            Invoice,
                        data.d[i].BuyerUserId,
                        data.d[i].BuyerName,
                        data.d[i].BuyerState,
                        data.d[i].BuyerDistrict,
                        data.d[i].BuyerMobileNo,
                        data.d[i].NoOFProduct,
                        data.d[i].Actual_Qty,

                        data.d[i].grossAmt,
                        data.d[i].SGST,
                        data.d[i].CGST,
                        data.d[i].IGST,
                        //data.d[i].Cess,
                        data.d[i].Amt,
                        //data.d[i].Discount,
                        data.d[i].CourierCharges,
                        data.d[i].NetAmt,
                        //data.d[i].BV,

                            data.d[i].PV,

                            data.d[i].WalletAmount,
                            data.d[i].secondaryAmount,
                             

                        //data.d[i].TotalFPV,
                        data.d[i].Subdistype,
                        data.d[i].status == "0" ? "<span style='color:red'>Cancelled </span>" : "Submit",
                        data.d[i].Del_Status == "0" ? "<span style='color:red'>Pending</span>" : "Delivered",
                        // data.d[i].PanNo,
                        //data.d[i].GSTNo,
                        data.d[i].PayMode,
                            Invoice,
                        data.d[i].DispatchDate,

                            Transport,
                            Tracking,
                            EWay,
                            Remarks,
                            Deliver,

                            Upload_lr1,
                            Upload_lr2,
                            Send_sms,
                            Send_Whats_sms + ' ' + IS_OPTIN,
                            data.d[i].Customer_Type == "False" ? "<span><%=method.Associate%></span>" : "<span><%=method.Customer%> </span>"


                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            { title: "Date" },
                            { title: "Invoice No." },
                            { title: "Buyer Id" },
                            { title: "Buyer Name" },
                            { title: "Buyer State" },
                            { title: "Buyer District" },
                            { title: "Buyer Mobile" },
                            { title: "No of Prod" },
                            { title: "Billed Qty." },

                            { title: "DP Value" },
                            { title: "SGST" },
                            { title: "CGST" },
                            { title: "IGST" },
                            // { title: "Cess" },
                            { title: "DP with Tax" },
                            //{ title: "Discount" },
                            { title: "Courier Charges" },
                            { title: "<%=method.Invoice_Amount%>" },
                          

                            { title: "<%=method.PV%>" },
                            { title: "Wallet <br> Amount" },
                            { title: "Secondary <br> Amount" },

                            { title: "Billing <br> Type" },
                            { title: "Invoice  <br>Status" },
                            { title: "Dispatch  <br> Status" },
                            //{ title: "PanNo" },
                            //{ title: "GSTNo" },
                            { title: "Payment<br> Mode" },
                            { title: "Invoice No." },
                            { title: "Dispatch<br> Date" },

                            { title: "Transport" },
                            { title: "Tracking" },
                            { title: "E Way Bill" },
                            { title: "Remarks" },
                            { title: "Deliver" },

                            { title: "Img LR1" },
                            { title: "Img LR1" },
                            { title: "SMS" },
                            { title: "Whatsapp" },
                            { title: "Customer Type" },

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) {
                                return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0;
                            };

                            // Total over all pages
                            $(api.column(1).footer()).html('Total:');

                            $(api.column(8).footer()).html(api.column(8).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                            $(api.column(9).footer()).html(api.column(9).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0));
                            $(api.column(10).footer()).html(api.column(10).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(11).footer()).html(api.column(11).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(12).footer()).html(api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(13).footer()).html(api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));

                            $(api.column(14).footer()).html(api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(15).footer()).html(api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(16).footer()).html(api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(17).footer()).html(api.column(17).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(18).footer()).html(api.column(18).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));
                            $(api.column(19).footer()).html(api.column(19).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0).toFixed(2));

                        }
                    });
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }


        function Deliver_Invice(Invoice, srno) {
            var Transport = $('#txt_Transport' + srno).val();
            var Tracking = $('#txt_Tracking' + srno).val();
            var EWay = $('#txt_EWay' + srno).val();
            var Remarks = $('#txt_Remarks' + srno).val();

            if (!confirm('Are you sure you want to dispatch？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/Dispatch_Inv',
                data: '{ Invoice: "' + Invoice + '", Transport: "' + Transport + '", Tracking: "' + Tracking + '", EWay: "' + EWay + '", Remarks: "' + Remarks + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Deliver Updated Successfully");
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


        function SendSms(SMSTYPE, srno, UserId, Name, Inv, Date, Docket, Transport, Mobile, Img_Lr1) {
            if (!confirm('Are you sure you want to send message？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: 'AssociateInvoiceList.aspx/SendSms',
                data: '{SMSTYPE: "' + SMSTYPE + '", srno: "' + srno + '", UserId: "' + UserId + '", Name: "' + Name
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



        function UploadImg_lr1(srno) {
            var ImgName = "";
            var fileUpload = $JJ("#img_lr1" + srno).get(0);
            var files = fileUpload.files;
            var data = new FormData();
            var random = Math.floor(1000 + Math.random() * 9000);
            random = "b1" + random;
            for (var i = 0; i < files.length; i++) {
                //data.append(random + files[i].name, files[i]);
                //ImgName = random + files[i].name;
                var ext = files[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data.append(random + '.' + ext, files[i]);
                ImgName = random + '.' + ext;
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
                        url: 'AssociateInvoiceList.aspx/UpdateImage',
                        data: '{IMGTYPE: "1", srno: "' + srno + '", ImgName: "' + ImgName + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == '1') {
                                alert("Image Updated Successfully");
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
                error: function (err) {
                    //alert(err.statusText)
                }
            });
        }



        function UploadImg_lr2(srno) {
            var ImgName = "";
            var fileUpload = $JJ("#img_lr2" + srno).get(0);
            var files = fileUpload.files;
            var data = new FormData();
            var random = Math.floor(1000 + Math.random() * 9000);
            random = "b2" + random;
            for (var i = 0; i < files.length; i++) {
                //data.append(random + files[i].name, files[i]);
                //ImgName = random + files[i].name;
                var ext = files[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data.append(random + '.' + ext, files[i]);
                ImgName = random + '.' + ext;
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
                        url: 'AssociateInvoiceList.aspx/UpdateImage',
                        data: '{IMGTYPE: "2", srno: "' + srno + '", ImgName: "' + ImgName + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == '1') {
                                alert("Image Updated Successfully");
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
                error: function (err) {
                }
            });
        }
    </script>



    <style>
        .dotGreen {
            height: 17px;
            width: 17px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }

        .dotBlue {
            height: 20px;
            width: 20px;
            background-color: #96DED1;
            display: inline-block;
            border-radius: 50%;
            padding-top: 2px;
            text-align: center;
        }
    </style>
</asp:Content>
