<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="SMS_RemCat.aspx.cs" Inherits="secretadmin_SMS_RemCat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="row">
    <div class="col-6">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Add Category</h4>
        </div>
          <div class="col-6 text-end">
 <button type="button" title="Search" class="btn btn-primary" onclick="ShowModel()">Add Category</button>
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
        var pageUrl = '<%=ResolveUrl("SMS_RemCat.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                        data.d[i].ReminderName,
                        data.d[i].Category,
                        '<a href="javascript:void(0)"> <span onclick="Update(' + data.d[i].RCID + ');"> <i class="fa fa-pencil" aria-hidden="true"></i> </span> </a>' + ' &nbsp; &nbsp; ' +
                        '<a href="javascript:void(0)"> <span style="color:Red;" onclick="Delete(' + data.d[i].RCID + ');"> <i class="fa fa-trash" aria-hidden="true"></i> </span> </a> '
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
                            { title: "Reminder Type" },
                            { title: "Category" },
                            { title: "Action" },
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
            $('#<%=hnd_Id.ClientID %>').val('');
        }


        function Popup_Close() {
            $('#Popup_Reminder').hide();
            $('#<%=hnd_Id.ClientID %>').val('');
        }


        function Save() {
            $('#LoaderImg').show();
            let RCID = $('#<%=hnd_Id.ClientID %>').val();
            let RemId = $('#<%=ddl_ReminderType.ClientID %>').val();
            let Category = $('#<%=txt_Cat.ClientID %>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Save',
                contentType: "application/json; charset=utf-8",
                data: '{RCID: "' + RCID + '", RemId: "' + RemId + '", Category: "' + Category + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d == '1') {
                        $('#<%=hnd_Id.ClientID %>').val('');
                        $('#Popup_Reminder').hide();
                        $('#<%=txt_Cat.ClientID %>').val('');
                        $('#<%=ddl_ReminderType.ClientID %>').val('0');
                        BindTable();
                    }
                    else { alert(data.d); }
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Update(RCID) {
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDetail',
                contentType: "application/json; charset=utf-8",
                data: '{RCID: "' + RCID + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    $('#<%=ddl_ReminderType.ClientID %>').val(data.d[0].RemId);
                    $('#<%=txt_Cat.ClientID %>').val(data.d[0].Category);
                    $('#<%=hnd_Id.ClientID %>').val(RCID);
                    $('#Popup_Reminder').show();
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Delete(RCID) {
            if (!confirm('Are you sure you want to delete？')) { return false; }

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Delete',
                contentType: "application/json; charset=utf-8",
                data: '{RCID: "' + RCID + '"}',
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
    </script>

    <div id="Popup_Reminder" class="modal fade show" tabindex="-1" style="padding-right: 17px; background: #000000ab;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;Add Reminder</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="Popup_Close()"></button>
                </div>

                <div class="modal-body">
                    <div class="form-group row mt-2">
                        <div class="col-sm-3 label-control ">
                            Reminder type  
                        </div>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddl_ReminderType" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group row mt-2">
                        <div class="col-sm-3 label-control ">
                            Category  
                        </div>
                        <div class="col-sm-5">
                            <asp:TextBox ID="txt_Cat" runat="server" MaxLength="100" CssClass="form-control"
                                placeholder="Enter Category"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-3">
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

