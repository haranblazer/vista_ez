<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="InsuranceList.aspx.cs" 
    EnableEventValidation="false" Inherits="secretadmin_InsuranceList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Insurance List</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="clearfix"></div>


    <div class="row">

         <div class="col-md-4">
            <span style="color: Red">Note : Only CSV file allowed</span><br />
            <span style="color: Red">Date should be 25-01-2022 (dd-mm-yyyy)</span>
        </div>

        <div class="col-md-3">
            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-file-input form-control" accept=".csv" /> 
        </div>

        <div class="col-md-3">
            <asp:Button ID="btnbulkcopy" runat="server" Text="Upload" CssClass="btn btn-primary"
            OnClick="btnbulkcopy_Click" OnClientClick="javascript:return Validation();" />
           
        </div>
        <div class="col-md-2">
             <a href="../images/InsuranceFormet.csv" class="btn btn-success">Import CSV Format &nbsp; <i class="fa fa-download" style="font-size: 16px; color: white"></i></a>
        </div>
        <div class="clearfix"></div>
        <hr />

        <div class="col-md-2">
            <asp:TextBox ID="txt_Userid" runat="server" placeholder="Enter Userid."
                MaxLength="30" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_userName" runat="server" placeholder="Enter User Name"
                MaxLength="50" CssClass="form-control"></asp:TextBox>
        </div>
         
        <div class="col-md-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
        <div class="col-md-4">
        </div>
        <div class="col-md-2 pull-right">
            <button type="button" title="Search" class="btn btn-primary" onclick="ShowModel()">Add Policy</button>
        </div>

    </div>
    <hr />



    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>
    </div>
    <div class="clearfix"></div>
    <asp:HiddenField ID="hnd_Id" runat="server" Value="" />


    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txt_I_StartDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txt_I_EndDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
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
        var pageUrl = '<%=ResolveUrl("InsuranceList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            $('#LoaderImg').show();
            let UserName = $('#<%=txt_userName.ClientID %>').val();
            let Userid = $('#<%=txt_Userid.ClientID %>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{UserName: "' + UserName + '", Userid: "' + Userid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        json.push([i + 1,
                        '<a href="javascript:void(0)"> <span style="font-size:12pt;" onclick="Update(' + data.d[i].IID + ');"> <i class="fa fa-pencil" aria-hidden="true"></i> </span> </a>',
                        data.d[i].UserId,
                        data.d[i].UserName,
                        data.d[i].PolicyNo,
                        data.d[i].SumInsured,
                        data.d[i].StartDate,
                        data.d[i].EndDate,
                        '<a href="javascript:void(0)"> <span style="color:Red; font-size:12pt;" onclick="Delete(' + data.d[i].IID + ');"> <i class="fa fa-trash" aria-hidden="true"></i> </span> </a> '
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
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "Policy No." },
                            { title: "Sum Insured" },
                            { title: "Start Date" },
                            { title: "End Date" },
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
            let IID = $('#<%=hnd_Id.ClientID %>').val();
            let UserId = $('#<%=txt_I_Userid.ClientID %>').val();
            let PolicyNo = $('#<%=txt_I_PolicyNo.ClientID %>').val();
            let SumInsured = $('#<%=txt_I_SumInsured.ClientID %>').val();
            let StartDate = dateFormate($('#<%=txt_I_StartDate.ClientID %>').val());
            let EndDate = dateFormate($('#<%=txt_I_EndDate.ClientID %>').val());
            $.ajax({
                type: "POST",
                url: pageUrl + '/Save',
                contentType: "application/json; charset=utf-8",
                data: '{IID: "' + IID + '", UserId: "' + UserId + '", PolicyNo: "' + PolicyNo + '", SumInsured: "' + SumInsured + '", StartDate: "' + StartDate + '", EndDate: "' + EndDate + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d == '1') {
                        $('#<%=hnd_Id.ClientID %>').val('');
                        $('#Popup_Contact').hide();
                        $('#<%=txt_I_Userid.ClientID %>').val('');
                        $('#<%=txt_I_PolicyNo.ClientID %>').val('');
                        $('#<%=txt_I_SumInsured.ClientID %>').val('');
                        $('#<%=txt_I_StartDate.ClientID %>').val('');
                        $('#<%=txt_I_EndDate.ClientID %>').val('');

                        BindTable();
                    }
                    else if (data.d == '2') {
                        alert("Invalid Userid.!!");
                    }
                    else { alert(data.d); }
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Update(IID) {
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDetail',
                contentType: "application/json; charset=utf-8",
                data: '{IID: "' + IID + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    $('#<%=txt_I_Userid.ClientID %>').val(data.d[0].UserId);
                    $('#<%=txt_I_PolicyNo.ClientID %>').val(data.d[0].PolicyNo);
                    $('#<%=txt_I_SumInsured.ClientID %>').val(data.d[0].SumInsured);
                    $('#<%=txt_I_StartDate.ClientID %>').val(data.d[0].StartDate);
                    $('#<%=txt_I_EndDate.ClientID %>').val(data.d[0].EndDate);
 
                    $('#<%=hnd_Id.ClientID %>').val(IID);
                    $('#Popup_Contact').show();
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Delete(IID) {
            if (!confirm('Are you sure you want to delete？')) { return false; }
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Delete',
                contentType: "application/json; charset=utf-8",
                data: '{IID: "' + IID + '"}',
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


    <div id="Popup_Contact" class="modal fade show" tabindex="-1" style="padding-right: 17px; background: #000000ab;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content" style="overflow-y: scroll; max-height: 767px;">

                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;Add Insurance</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="Popup_Close()"></button>
                </div>

                <div class="modal-body">
                    <div class="form-group row mt-2">
                        <div class="col-sm-4 label-control">Enter Userid</div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txt_I_Userid" runat="server" placeholder="Enter Userid"
                                MaxLength="50" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row mt-2">
                        <div class="col-sm-4 label-control">Enter Policy No.</div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txt_I_PolicyNo" runat="server" placeholder="Enter Policy No."
                                MaxLength="30" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row mt-2">
                        <div class="col-sm-4 label-control ">
                            Sum Insured
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txt_I_SumInsured" runat="server" placeholder="Enter Sum Insured"
                                MaxLength="50" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row mt-2">
                        <div class="col-sm-4 label-control ">Start Date </div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txt_I_StartDate" runat="server" placeholder="Enter Start Date"
                                MaxLength="20" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row mt-2">
                        <div class="col-sm-4 label-control ">End Date</div>
                        <div class="col-sm-6">
                            <asp:TextBox ID="txt_I_EndDate" runat="server" placeholder="Enter End Date"
                                MaxLength="20" CssClass="form-control"></asp:TextBox>
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
    <style>
        .datepick-popup {
            z-index: 9999;
        }
    </style>
</asp:Content>

