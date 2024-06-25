<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="SMS_ContactList.aspx.cs" Inherits="secretadmin_SMS_ContactList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
                      
                   

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Contact List</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="clearfix"></div>


    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txt_userName" runat="server" placeholder="Enter User Name"
                MaxLength="50" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_Mobile" runat="server" placeholder="Enter Mobile No."
                MaxLength="10" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txt_Email" runat="server" placeholder="Enter Email Id"
                MaxLength="50" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>

        <div class="col-md-3 text-end">
            <button type="button" title="Search" class="btn btn-primary" onclick="ShowModel()">Add Contact List</button>
        </div>

    </div>
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
        var pageUrl = '<%=ResolveUrl("SMS_ContactList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            $('#LoaderImg').show();
            let UserName = $('#<%=txt_userName.ClientID %>').val();
            let Email = $('#<%=txt_Email.ClientID %>').val();
            let MobileNo = $('#<%=txt_Mobile.ClientID %>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{UserName: "' + UserName + '", Email: "' + Email + '", MobileNo: "' + MobileNo + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        let Isactive = '';
                        let S_UserId  ="'"+ data.d[i].S_UserId +"'";
                        if (data.d[i].Isactive == "1") {
                            Isactive = '<a href="javascrpit:void(0)" onclick="UpdateStatus(' + S_UserId + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            Isactive = '<a href="javascrpit:void(0)" onclick="UpdateStatus(' + S_UserId + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }

                        json.push([i + 1,
                            '<a href="javascript:void(0)"> <span style="font-size:12pt;" onclick="Update(' + data.d[i].S_UserId + ');"> <i class="fa fa-pencil" aria-hidden="true"></i> </span> </a>',
                           // '<a href="SMS_ReminderList.aspx?id=' + data.d[i].S_UserId + '" style="font-size:14pt;" class="text-success"> <i class="fa fa-plus-circle" aria-hidden="true"></i> </a>',
                            data.d[i].UserName,
                            data.d[i].MobileNo,
                            data.d[i].Email,
                            Isactive, 
                            '<a href="javascript:void(0)"> <span style="color:Red; font-size:12pt;" onclick="Delete(' + data.d[i].S_UserId + ');"> <i class="fa fa-trash" aria-hidden="true"></i> </span> </a> '
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
                            { title: "Edit" },
                            //{ title: "Add <br>Reminder" },
                            { title: "Contact Name" },
                            { title: "Mobile No." },
                            { title: "Email Id" },
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
            $('#Popup_Contact').show();
            $('#<%=hnd_Id.ClientID %>').val('');
        }


        function Popup_Close() {
            $('#Popup_Contact').hide();
            $('#<%=hnd_Id.ClientID %>').val('');
        }


        function Save() {
            $('#LoaderImg').show();
            let S_UserId = $('#<%=hnd_Id.ClientID %>').val();
            let UserName = $('#<%=txt_m_Username.ClientID %>').val();
            let Email = $('#<%=txt_m_Email.ClientID %>').val();
            let MobileNo = $('#<%=txt_m_Mobile.ClientID %>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Save',
                contentType: "application/json; charset=utf-8",
                data: '{S_UserId: "' + S_UserId + '", UserName: "' + UserName + '", Email: "' + Email + '", MobileNo: "' + MobileNo + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d == '1') {
                        $('#<%=hnd_Id.ClientID %>').val('');
                        $('#Popup_Contact').hide();
                        $('#<%=txt_m_Username.ClientID %>').val('');
                        $('#<%=txt_m_Mobile.ClientID %>').val('');
                        $('#<%=txt_m_Email.ClientID %>').val('');

                        BindTable();
                    }
                    else { alert(data.d); }
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Update(S_UserId) {
            $('#LoaderImg').show();

            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDetail',
                contentType: "application/json; charset=utf-8",
                data: '{S_UserId: "' + S_UserId + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    $('#<%=txt_m_Username.ClientID %>').val(data.d[0].UserName);
                    $('#<%=txt_m_Mobile.ClientID %>').val(data.d[0].MobileNo);
                    $('#<%=txt_m_Email.ClientID %>').val(data.d[0].Email);
                    $('#<%=hnd_Id.ClientID %>').val(S_UserId);
                    $('#Popup_Contact').show();
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Delete(S_UserId) {
            if (!confirm('Are you sure you want to delete？')) { return false; }
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Delete',
                contentType: "application/json; charset=utf-8",
                data: '{S_UserId: "' + S_UserId + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d == "1") {
                        $('#Popup_Contact').hide();
                        BindTable();
                    } else {
                        alert(data.d);
                    }
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }

        function UpdateStatus(S_UserId) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{S_UserId: "' + S_UserId + '"}',
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

    <div id="Popup_Contact" class="modal fade show" tabindex="-1" style="padding-right: 17px; background: #000000ab;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;Add Reminder</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="Popup_Close()"></button>
                </div>

                <div class="modal-body">
                    <div class="form-group row mt-2">
                        <div class="col-sm-4 label-control">
                            Enter User Name
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txt_m_Username" runat="server" placeholder="Enter User Name"
                                MaxLength="50" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row mt-2">
                        <div class="col-sm-4 label-control ">
                            Enter Mobile No.
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txt_m_Mobile" runat="server" placeholder="Enter Mobile No."
                                MaxLength="10" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row mt-2">
                        <div class="col-sm-4 label-control ">
                            Enter Email Id
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txt_m_Email" runat="server" placeholder="Enter Email Id"
                                MaxLength="50" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>


                    <div class="form-group row">
                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-8">
                            <input type="button" class="btn btn-primary" onclick="Save()" value="Submit" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>


