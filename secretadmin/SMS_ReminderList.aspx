<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="SMS_ReminderList.aspx.cs" Inherits="secretadmin_SMS_ReminderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txt_Start_Date.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txt_Expiry_Date.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>

    <div class="row">
        <div class="col-6">
            <h4 class="fs-20 font-w600 me-auto float-left mb-0">Reminder List</h4>
        </div>
        <div class="col-6 text-end">
            <button type="button" title="Search" class="btn btn-primary" onclick="ShowModel()">Add Reminder</button>
        </div>
    </div>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="clearfix"></div>
    <hr />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>
    </div>
    <div class="clearfix"></div>
    <asp:HiddenField ID="hnd_Id" runat="server" Value="" />

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
        var pageUrl = '<%=ResolveUrl("SMS_ReminderList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            $('#LoaderImg').show();
            let S_UserId = "";
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{S_UserId: "' + S_UserId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        let Isactive = '';
                        if (data.d[i].Isactive == "1") {
                            Isactive = '<a href="javascrpit:void(0)" onclick="UpdateStatus(' + data.d[i].SId + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            Isactive = '<a href="javascrpit:void(0)" onclick="UpdateStatus(' + data.d[i].SId + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }

                        json.push([(i + 1) + ' &nbsp;&nbsp;' +
                            '<a href="javascript:void(0)"> <span style="font-size:12pt; color:Blue" onclick="Update(' + data.d[i].SId + ');"> <i class="fa fa-pencil" aria-hidden="true"></i> </span> </a>' + ' &nbsp; &nbsp; ',
                        data.d[i].UserList,
                        data.d[i].ReminderName,
                        data.d[i].DocName,
                        data.d[i].Category,
                        data.d[i].Start_Date,
                        data.d[i].Expiry_Date,
                        data.d[i].Duration,
                        data.d[i].Duration_type,
                        data.d[i].After_Before,
                        data.d[i].Remark,

                        (data.d[i].IsSMS == "1" ? "<span class='dotGreen'>" + data.d[i].SendSMS + "</span>" : "<span class='dotGrey'>" + data.d[i].SendSMS + "</span>"),
                        data.d[i].IsWhatsapp == "1" ? "<span class='dotGreen'>" + data.d[i].SendWhatsapp + "</span>" : "<span class='dotGrey'>" + data.d[i].SendWhatsapp + "</span>",
                        data.d[i].IsEmail == "1" ? "<span class='dotGreen'>" + data.d[i].SendEmail + "</span>" : "<span class='dotGrey'>" + data.d[i].SendEmail + "</span>",
                            Isactive,
                        '<a href="javascript:void(0)"> <span style="color:Red; font-size:12pt; color:red;" onclick="Delete(' + data.d[i].SId + ');"> <i class="fa fa-trash" aria-hidden="true"></i> </span> </a> '
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
                            { title: "Reminder To" },
                            { title: "Document <br>Type" },
                            { title: "Reminder <br>Type" },
                            { title: "Category" },
                            { title: "Start Date" },
                            { title: "Expiry Date" },
                            { title: "Duration" },
                            { title: "Duration <br>type" },
                            { title: "After <br>Before" },
                            { title: "Remark" },
                            { title: "SMS" },
                            { title: "Whats<br>app" },
                            { title: "Email" },
                            { title: "STA" },
                            { title: "DEL" },
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


        function ShowModel() {
            $('#Popup_Reminder').show();
            ResetControl();
        }


        function Popup_Close() {
            $('#Popup_Reminder').hide();
            ResetControl();
        }


        function ResetControl() {
            $('#<%=hnd_Id.ClientID %>').val('');
            $('#<%=ddl_DocumentType.ClientID %>').val('0');
            $('#<%=ddl_ReminderType.ClientID %>').val('0');
            $('#<%=ddl_RemCat.ClientID %>').val('0');
            $('#<%=txt_Start_Date.ClientID %>').val('');
            $('#<%=fuUpload.ClientID %>').val('');

            $('#<%=ddl_Duration_type.ClientID %>').val('DAYS');
            $('#<%=ddl_After_Before.ClientID %>').val('BEFORE');

            $('#<%=chk_SMS.ClientID %>').attr('checked', false);
            $('#<%=chk_Whatsapp.ClientID %>').attr('checked', false);
            $('#<%=chk_Email.ClientID %>').attr('checked', false);

            $('#<%=txt_Expiry_Date.ClientID %>').val('');
            $('#<%=txt_Remark.ClientID %>').val('');
            $('#<%=txt_SendSMS.ClientID %>').val('');
            $('#<%=txt_SendWhatsapp.ClientID %>').val('');
            $('#<%=txt_SendEmail.ClientID %>').val('');


            $("[id*=chk_Userlist] input:checkbox").prop('checked', false);
        }


        function Save() {
            $('#LoaderImg').show();
            let SId = $('#<%=hnd_Id.ClientID %>').val();
            let DocId = $('#<%=ddl_DocumentType.ClientID %>').val();
            let RemId = $('#<%=ddl_ReminderType.ClientID %>').val();
            let RCID = $('#<%=ddl_RemCat.ClientID %>').val();

            let Start_Date = dateFormate($('#<%=txt_Start_Date.ClientID %>').val());
            let FileName = $('#<%=fuUpload.ClientID %>').val();

            let Duration_type = $('#<%=ddl_Duration_type.ClientID %>').val();
            let After_Before = $('#<%=ddl_After_Before.ClientID %>').val();
            let IsSMS = $('#<%=chk_SMS.ClientID %>').is(":checked") == true ? 1 : 0;
            let IsWhatsapp = $('#<%=chk_Whatsapp.ClientID %>').is(":checked") == true ? 1 : 0;
            let IsEmail = $('#<%=chk_Email.ClientID %>').is(":checked") == true ? 1 : 0;

            let Expiry_Date = dateFormate($('#<%=txt_Expiry_Date.ClientID %>').val());
            let Remark = $('#<%=txt_Remark.ClientID %>').val();
            let SendSMS = $('#<%=txt_SendSMS.ClientID %>').val();
            let SendWhatsapp = $('#<%=txt_SendWhatsapp.ClientID %>').val();
            let SendEmail = $('#<%=txt_SendEmail.ClientID %>').val();

            let UserList = "";
            var checked_checkboxes = $("[id*=chk_Userlist] input:checked");
            checked_checkboxes.each(function () { UserList += $(this).val() + ","; });

            $.ajax({
                type: "POST",
                url: pageUrl + '/Save',
                contentType: "application/json; charset=utf-8",
                data: '{SId: "' + SId + '", DocId: "' + DocId + '", RemId: "' + RemId
                    + '", RCID: "' + RCID + '", Expiry_Date: "' + Expiry_Date + '", FileName: "' + FileName + '", Duration_type: "' + Duration_type
                    + '", After_Before: "' + After_Before + '", IsSMS: "' + IsSMS + '", IsWhatsapp: "' + IsWhatsapp + '", IsEmail: "' + IsEmail
                    + '", UserList: "' + UserList + '" , Start_Date: "' + Start_Date + '" , Remark: "' + Remark
                    + '", SendSMS: "' + SendSMS + '", SendWhatsapp: "' + SendWhatsapp + '", SendEmail: "' + SendEmail + '" }',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d == '1') {
                        $('#Popup_Reminder').hide();
                        ResetControl();
                        BindTable();
                    }
                    else { alert(data.d); }
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Update(SId) {
            $('#LoaderImg').show();
            var UserCtrl = $('#<%=chk_Userlist.ClientID%> input');
            UserCtrl.each(function (index) {
                item = $(this);
                //item.attr('checked', false);
                item.removeAttr('checked');
            });

            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDetail',
                contentType: "application/json; charset=utf-8",
                data: '{SId: "' + SId + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    $('#Popup_Reminder').show();

                    $('#<%=ddl_DocumentType.ClientID %>').val(data.d[0].DocId);
                    $('#<%=ddl_ReminderType.ClientID %>').val(data.d[0].RemId);

                    $('#<%=txt_Expiry_Date.ClientID %>').val(data.d[0].Expiry_Date);
                    $('#<%=fuUpload.ClientID %>').val(data.d[0].FileName);

                    $('#<%=ddl_Duration_type.ClientID %>').val(data.d[0].Duration_type);
                    $('#<%=ddl_After_Before.ClientID %>').val(data.d[0].After_Before);

                    $('#<%=txt_Start_Date.ClientID %>').val(data.d[0].Start_Date);
                    $('#<%=txt_Remark.ClientID %>').val(data.d[0].Remark);
                    $('#<%=txt_SendSMS.ClientID %>').val(data.d[0].SendSMS);
                    $('#<%=txt_SendWhatsapp.ClientID %>').val(data.d[0].SendWhatsapp);
                    $('#<%=txt_SendEmail.ClientID %>').val(data.d[0].SendEmail);

                    if (data.d[0].IsSMS == "1")
                        $('#<%=chk_SMS.ClientID %>').attr('checked', true);
                    else
                        $('#<%=chk_SMS.ClientID %>').attr('checked', false);

                    if (data.d[0].IsWhatsapp == "1")
                        $('#<%=chk_Whatsapp.ClientID %>').attr('checked', true);
                    else
                        $('#<%=chk_Whatsapp.ClientID %>').attr('checked', false);

                    if (data.d[0].IsEmail == "1")
                        $('#<%=chk_Email.ClientID %>').attr('checked', true);
                    else
                        $('#<%=chk_Email.ClientID %>').attr('checked', false);

                    $('#<%=hnd_Id.ClientID %>').val(SId);
                    var UserList = data.d[0].UserList;
                    GetReminderCategory(data.d[0].RCID);

                    UserCtrl.each(function (index) {
                        item = $(this);
                        if (UserList.indexOf(item.val()) != -1) { item.attr('checked', true); }
                    });

                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Delete(SId) {
            if (!confirm('Are you sure you want to delete？')) { return false; }
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Delete',
                contentType: "application/json; charset=utf-8",
                data: '{SId: "' + SId + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d == "1") {
                        $('#Popup_Reminder').hide();
                        BindTable();
                    } else {
                        alert(data.d);
                    }
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function UpdateStatus(SId) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{SId: "' + SId + '"}',
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


        async function GetReminderCategory(RCID) {
            $('#<%=ddl_RemCat.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetReminderCategory',
                data: "{'RemId':'" + $('#<%=ddl_ReminderType.ClientID %>').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#<%=ddl_RemCat.ClientID %>").empty().append($("<option></option>").val(0).html('Select Category'));
                    PopulateControl(response.d, $("#<%=ddl_RemCat.ClientID%>"));
                    if (RCID != '') {
                        $("#<%=ddl_RemCat.ClientID %>").val(RCID);
                    }
                    return;
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


        function dateFormate(datevalue) {
            var date_arr = "";
            var newformat = "";
            date_arr = datevalue.split('/');
            if (date_arr.length > 0) { newformat = date_arr[1] + '/' + date_arr[0] + '/' + date_arr[2]; }
            if (datevalue == "") { newformat = ''; }
            return newformat;
        }

    </script>


    <div id="Popup_Reminder" class="modal fade show" tabindex="-1" style="padding-right: 17px; background: #000000ab; overflow-y: scroll;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content" style="overflow-y: scroll; max-height: 767px;">

                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;Add Reminder</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="Popup_Close()"></button>
                </div>

                <div class="modal-body">


                    <div class="row mt-2">
                        <div class="col-md-6 row">
                            <div class="col-sm-4 control-label">Document Type</div>
                            <div class="col-sm-8">
                                <asp:DropDownList ID="ddl_DocumentType" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>

                            <div class="col-sm-4 control-label">Reminder type</div>
                            <div class="col-sm-8">
                                <asp:DropDownList ID="ddl_ReminderType" runat="server" CssClass="form-control" onchange="GetReminderCategory('');"></asp:DropDownList>
                            </div>

                            <div class="col-sm-4 control-label">Reminder Category </div>
                            <div class="col-sm-8">
                                <asp:DropDownList ID="ddl_RemCat" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>

                            <div class="col-sm-4 control-label">Start Date</div>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txt_Start_Date" runat="server"
                                    MaxLength="20" CssClass="form-control" placeholder="dd/mm/yyyy"></asp:TextBox>
                            </div>

                            <div class="col-sm-4 control-label">Expiry Date</div>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txt_Expiry_Date" runat="server"
                                    MaxLength="20" CssClass="form-control" placeholder="dd/mm/yyyy"></asp:TextBox>
                            </div>

                            <%--  <div class="col-sm-4 label-control ">Duration </div>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txt_Duration" runat="server" placeholder="Enter Duration"
                                    CssClass="form-control" MaxLength="5"></asp:TextBox>
                            </div>--%>

                            <div class="col-sm-4 control-label">After/ Before</div>
                            <div class="col-sm-8">
                                <asp:DropDownList ID="ddl_After_Before" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="BEFORE">Before expiration date</asp:ListItem>
                                    <asp:ListItem Value="AFTER">After expiration date</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-sm-4 control-label">Duration Type </div>
                            <div class="col-sm-8">
                                <asp:DropDownList ID="ddl_Duration_type" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="DAYS">Days(s)</asp:ListItem>
                                    <asp:ListItem Value="WEEK">Week(s)</asp:ListItem>
                                    <asp:ListItem Value="MONTH">Month(s)</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-sm-4 control-label">Remark </div>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txt_Remark" runat="server" placeholder="Enter Remark"
                                    CssClass="form-control" MaxLength="500" TextMode="MultiLine" Height="150px"></asp:TextBox>
                            </div>

                        </div>


                        <div class="col-md-6 row">

                            <div class="col-sm-4 control-label">Select File</div>
                            <div class="col-sm-8">
                                <asp:FileUpload ID="fuUpload" runat="server" CssClass="form-control" accept=".png,.jpg,.jpeg,.pdf" />
                            </div>
                            <hr />
                            <div class="col-sm-4 control-label">Notification </div>
                            <div class="col-sm-3 control-label">
                                <asp:CheckBox ID="chk_SMS" runat="server" Text="Text SMS"></asp:CheckBox>
                            </div>

                            <div class="col-sm-1">
                            </div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_SendSMS" runat="server" placeholder="No Of Send SMS"
                                    CssClass="form-control" MaxLength="5"></asp:TextBox>
                            </div>

                            <div class="col-sm-4 control-label"></div>
                            <div class="col-sm-3 control-label">
                                <asp:CheckBox ID="chk_Whatsapp" runat="server" Text="Whats App"></asp:CheckBox>
                            </div>
                            <div class="col-sm-1">
                            </div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_SendWhatsapp" runat="server" placeholder="No Of Send Whatsapp"
                                    CssClass="form-control" MaxLength="5"></asp:TextBox>
                            </div>

                            <div class="col-sm-4"></div>
                            <div class="col-sm-3 control-label">
                                <asp:CheckBox ID="chk_Email" runat="server" Text="Email"></asp:CheckBox>
                            </div>
                            <div class="col-sm-1">
                            </div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_SendEmail" runat="server" placeholder="No Of Send Email"
                                    CssClass="form-control" MaxLength="5"></asp:TextBox>
                            </div>
                            <hr />
                            <div class="col-sm-4 ">User List</div>
                            <div class="col-sm-8" style="height: 250px; overflow-y: scroll;">
                                <asp:CheckBoxList ID="chk_Userlist" runat="server" RepeatDirection="Vertical" RepeatColumns="1">
                                </asp:CheckBoxList>
                            </div>

                            <div class="col-sm-8">
                                <input type="button" class="btn btn-primary" onclick="Save()" value="Submit" />
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>


    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
            color: white;
            padding: 1px;
            text-align: center;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
            color: white;
            padding: 1px;
            text-align: center;
        }

        .datepick-popup {
            z-index: 9999;
        }
    </style>

</asp:Content>

