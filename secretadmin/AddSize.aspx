<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="AddSize.aspx.cs" Inherits="secretadmin_old_AddSize" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>Size Detail</h1>
    <div class="col-md-3 ">
        <input type="button" data-bs-toggle="modal" data-bs-target="#Model_Popup" value="Add Size" class="btn btn-success" />
    </div>
    <hr />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>
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
        var pageUrl = '<%=ResolveUrl("AddSize.aspx")%>';
        $JDT(function () {
            bindtable();



        });


        function bindtable() {
            $('#LoaderImg').show();
            $.ajax({

                type: "POST",
                url: pageUrl + '/bindtable',
                // data: '{User_Id:"' + User_Id + '",Name:"' + Name + '",City:"' + City + '",State:"' + State + '",Mobile:"' + Mobile + '",Pan_No:"' + Pan_No + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();

                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        let Size_Id = data.d[i].Size_Id;
                        var Status = '';
                        if (data.d[i].Status == 'True') {
                            Status = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Size_Id + ')"> <i class="fa fa-toggle-on" style="font-size:24px; color:green"></i> </a>';
                        }
                        else {
                            Status = '<a href="javascript:void(0)" onclick="UpdateStatus(' + Size_Id + ')"> <i class="fa fa-toggle-off" style="font-size:24px; color:red"></i> </a>';
                        }
                        json.push([i + 1,

                        '<a href="javascript: void(0)" data-bs-toggle="modal" data-bs-target="#Model_Popup" class="gridViewToolTip" onclick="openPopup(' + Size_Id + ')" ><i class="fa fa-edit" style="color: blue; font-weight: bold"></i></a>',

                       /* data.d[i].Size_Id,*/
                        data.d[i].Size,
                            Status, 
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
                           /* { title: "Size Id" },*/
                            { title: "Size" },
                            { title: "Status" },

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
        function openPopup(Size_Id) {
            $('#<%=hdn_Size_ID.ClientID %>').val(Size_Id);
       
            $.ajax({
                type: "POST",
                url: pageUrl + '/openPopup',
                data: '{Size_Id:"' + Size_Id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) { 
                    $('#txt_size').val(data.d.Size); 
                },
                error: function (result) {
                    (result);
                }
            });

        }

        function UpdateStatus(Size_Id) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateStatus',
                data: '{Size_Id:"' + Size_Id + '"}',
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

        function Save() {

            let Size_ID = $('#<%=hdn_Size_ID.ClientID %>').val();
            let Size = $('#txt_size').val();
            if (Size == "") {
                alert("Please Enter Size!!");
                return false;
            } 

            $.ajax({
                type: "POST",
                url: pageUrl + '/Save',
                data: '{Size_ID:"' + Size_ID + '",Size:"' + Size + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '2') {
                        alert("This Size Already Exist.Please enter other Size.");
                    }
                    
                    $('#<%=hdn_Size_ID.ClientID %>').val('');
                    $('#txt_size').val('');
                    $('#Model_Popup').modal('hide');

                    bindtable();


                },
                error: function (result) {
                    (result);
                }
            });


        }
    </script>
    <asp:HiddenField ID="hdn_Size_ID" runat="server" Value="" />

    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script> 
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/jquery-ui.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/themes/start/jquery-ui.css" />



    <div id="Model_Popup" class="modal fade show" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;Colours Detail</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup_Model()">
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3 pb-2">Size</div>
                        <div class="col-sm-9 pb-2">
                            <input type="text" id="txt_size" name="Size" />
                        </div>

                        

                        <div class="col-sm-9">
                            <button type="button" onclick="Save()" class="btn btn-success">Submit</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

