<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="UploadExcelFile.aspx.cs" Inherits="secretadmin_UploadExcelFile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Upload Excel File</h4>
    </div>
    <div class="col-md-12">


        <div class="row">
            <div class="col-md-4">
                <a href="images/Diamond Achievers Format.csv" class="btn btn-success">Diamond Achievers Format &nbsp; <i class="fa fa-download" style="font-size: 16px; color: white"></i></a>
            </div>
            <div class="col-md-4">
                <a href="images/Tour Achievers Format.csv" class="btn btn-success">Tour Achievers Format &nbsp; <i class="fa fa-download" style="font-size: 16px; color: white"></i></a>
            </div>
            <div class="col-md-4">
                <a href="images/Offer Achievers Format.csv" class="btn btn-success">Offer Achievers Format &nbsp; <i class="fa fa-download" style="font-size: 16px; color: white"></i></a>
            </div>
            <%--<div class="col-md-3">
                        <a href="images/Topper Reward Achievers Format.csv" class="btn btn-success">Topper Reward Achievers Format &nbsp; <i class="fa fa-download" style="font-size: 16px; color: white"></i></a>
                    </div>--%>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="alert alert-primary alert-dismissible fade show">
            <strong>Note:</strong> Only CSV file allowed
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
            </button>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">
                Upload CSV File 
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="FileUpload1"
                    SetFocusOnError="true" Display="None" ErrorMessage="Only  csv files are allowed !!!"
                    Font-Size="10pt" ForeColor="#C00000" ValidationExpression="(.*\.([cC][sS][vV])$)"
                    ValidationGroup="C"></asp:RegularExpressionValidator>
                <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="C" HeaderText="Please Check the following..." />
            </div>

        </div>
        <div class="clearfix"></div>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                Select Type
            </label>
            <div class="col-md-6">
                <asp:DropDownList ID="ddl_ExcelType" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">Select Type</asp:ListItem>
                    <asp:ListItem Value="AddExcel_Diamond">Diamond Achievers</asp:ListItem>
                    <asp:ListItem Value="AddExcel_Tour">Tour Achievers</asp:ListItem>
                    <asp:ListItem Value="AddExcel_Offer">Offer Achievers</asp:ListItem>
                    <%--<asp:ListItem Value="AddExcel_TopperReward">Topper Reward Achievers</asp:ListItem>--%>
                </asp:DropDownList>
            </div>
        </div>



        <div class="form-group">

            <div class="col-md-6">
                <asp:Button ID="btnbulkcopy" runat="server" Text="Upload Data" ValidationGroup="C" CssClass="btn btn-success"
                    OnClick="btnbulkcopy_Click" OnClientClick="javascript:return Validation();" />
                &nbsp;&nbsp;&nbsp;&nbsp;
                        <%--<a href="UploadExcelFile.aspx" class="btn btn-danger">Reset Data</a> --%>
                <input type="button" class="btn btn-danger" value="Reset Data" onclick="ResetData();" />
                &nbsp;&nbsp;&nbsp;&nbsp;

                        <input type="button" class="btn btn-info" value="Search Data" onclick="GetTable();" />
                <br />
                <asp:Label ID="lbl_Msg" runat="server" ForeColor="Green"></asp:Label>
            </div>

        </div>
        <div class="clearfix">
        </div>
        <hr />
    </div>
    <div class="form-group">
        <%-- <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" CssClass="table table-hover mygrd"
                    Width="100%" EmptyDataText="No Data Found">
                </asp:GridView>--%>
        <div class="col-md-2"></div>

        <label id="lbl_Header" class="col-sm-4 control-label" style="font-size: larger; font-weight: 600;"></label>
        <div id="div_Daimond">
            <table id="tblDaimond" class="table table-striped table-hover display" style="width: 100%"></table>
        </div>
        <div id="div_Tour">
            <table id="tblTourAchiever" class="table table-striped table-hover display" style="width: 100%"></table>
        </div>
        <div id="div_Offer">
            <table id="tblOfferAchiever" class="table table-striped table-hover display" style="width: 100%"></table>
        </div>
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
    <script type="text/javascript">
        var $JDT = $.noConflict(true);
        var URL = '<%=ResolveUrl("UploadExcelFile.aspx")%>';

        function ResetData() {
            var ExcelType = $('#<%=ddl_ExcelType.ClientID%>').val();
            if (ExcelType == '') {
                alert('Please select type.');
                return;
            }

            if (ExcelType == 'AddExcel_Diamond') {
                if (!confirm('Danger: Are you sure you want to delete all diamond previous data in system.?')) {
                    return false;
                }
            }
            else if (ExcelType == 'AddExcel_Tour') {
                if (!confirm('Danger: Are you sure you want to delete all tour previous data in system.?')) {
                    return false;
                }
            }
            else if (ExcelType == 'AddExcel_Offer') {
                if (!confirm('Danger: Are you sure you want to delete all offer previous data in system.?')) {
                    return false;
                }
            }

            $.ajax({
                type: "POST",
                url: URL + '/ResetData',
                data: '{ ExcelType: "' + ExcelType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        if (ExcelType == 'AddExcel_Diamond') {
                            GetDaimond();
                        }
                        else if (ExcelType == 'AddExcel_Tour') {
                            GetTour();
                        }
                        else if (ExcelType == 'AddExcel_Offer') {
                            GetOffer();
                        }
                    }
                },
                error: function (result) { }
            });



        };


        function GetTable() {
            var ExcelType = $('#<%=ddl_ExcelType.ClientID%>').val();
            if (ExcelType == '') {
                alert('Please select type.');
                return;
            }

            if (ExcelType == 'AddExcel_Diamond') {
                GetDaimond();
            }
            else if (ExcelType == 'AddExcel_Tour') {
                GetTour();
            }
            else if (ExcelType == 'AddExcel_Offer') {
                GetOffer();
            }

        };


        function GetDaimond() {
            $.ajax({
                type: "POST",
                url: URL + '/Get_Daimond',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var Userid = '"AddExcel_Diamond","' + data.d[i].UserId + '"';
                        var IsShowHide = data.d[i].IsHideDiamond == "0" ? "<a href='javascript:void' onclick='GetClick(" + Userid + ");'><i class='fa fa-toggle-on' style='font-size:24px; color:green'></i> </a>" : "<a href='javascript:void' onclick='GetClick(" + Userid + ");'> <i class='fa fa-toggle-off' style='font-size:24px; color:red');'></i> </a>";
                        json.push([i + 1,
                        data.d[i].UserId,
                            IsShowHide,
                        data.d[i].UserName,
                        data.d[i].DOB,
                        data.d[i].Achievement_Month,
                        data.d[i].Rank,
                        data.d[i].District,
                        data.d[i].State,
                        ]);
                    }
                    $('#lbl_Header').text("Diamond Achievers");
                    $('#div_Daimond').show();
                    $('#div_Tour').hide();
                    $('#div_Offer').hide();

                    $JDT('#tblDaimond').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['csv', 'excel'],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            { title: "Name" },
                            { title: "Show/Hide" },
                            { title: "User Name" },
                            { title: "DOB" },
                            { title: "Achievement Month" },
                            { title: "Rank" },
                            { title: "District" },
                            { title: "State" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 10,
                        "bDestroy": true,
                        "bPaginate": false,
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function GetClick(AddExcel, Userid) {
            var IsHideDiamond = "-1";
            var IsHideTour = "-1";
            var IsHideOffer = "-1";

            if (AddExcel == "AddExcel_Diamond") { IsHideDiamond = "1"; }
            if (AddExcel == "AddExcel_Tour") { IsHideTour = "1"; }
            if (AddExcel == "AddExcel_Offer") { IsHideOffer = "1"; }

            $.ajax({
                type: "POST",
                url: URL + '/Update_ShowHide',
                data: '{ Userid: "' + Userid + '", IsHideDiamond: "' + IsHideDiamond
                    + '", IsHideTour: "' + IsHideTour + '", IsHideOffer: "' + IsHideOffer + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        GetTable();
                    }
                },
                error: function (result) { }
            });


        }

        function GetTour() {
            $.ajax({
                type: "POST",
                url: URL + '/Get_TourAchiever',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var Userid = '"AddExcel_Tour","' + data.d[i].UserId + '"';
                        var IsShowHide = data.d[i].IsHideTour == "0" ? "<a href='javascript:void' onclick='GetClick(" + Userid + ");'><i class='fa fa-toggle-on' style='font-size:24px; color:green'></i> </a>" : "<a href='javascript:void' onclick='GetClick(" + Userid + ");'> <i class='fa fa-toggle-off' style='font-size:24px; color:red');'></i> </a>";
                        json.push([i + 1,
                        data.d[i].UserId,
                            IsShowHide,
                        data.d[i].UserName,
                        data.d[i].Period,
                        data.d[i].Month,
                        data.d[i].Offer_Tour,
                        data.d[i].District,
                        data.d[i].State,
                        ]);
                    }
                    $('#lbl_Header').text("Tour Achievers");
                    $('#div_Daimond').hide();
                    $('#div_Tour').show();
                    $('#div_Offer').hide();

                    $JDT('#tblTourAchiever').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['csv', 'excel'],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            { title: "Name" },
                            { title: "Show/Hide" },
                            { title: "User Name" },
                            { title: "Period" },
                            { title: "Month" },
                            { title: "Offer Tour" },
                            { title: "District" },
                            { title: "State" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 10,
                        "bDestroy": true,
                        "bPaginate": false,
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function GetOffer() {
            $.ajax({
                type: "POST",
                url: URL + '/Get_OfferAchiever',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var Userid = '"AddExcel_Offer","' + data.d[i].UserId + '"';
                        var IsShowHide = data.d[i].IsHideOffer == "0" ? "<a href='javascript:void' onclick='GetClick(" + Userid + ");'><i class='fa fa-toggle-on' style='font-size:24px; color:green'></i> </a>" : "<a href='javascript:void' onclick='GetClick(" + Userid + ");'> <i class='fa fa-toggle-off' style='font-size:24px; color:red');'></i> </a>";
                        json.push([i + 1,
                        data.d[i].UserId,
                            IsShowHide,
                        data.d[i].UserName,
                        data.d[i].Period,
                        data.d[i].Month,
                        data.d[i].Offer_Reward,
                        data.d[i].District,
                        data.d[i].State,
                        ]);
                    }
                    $('#lbl_Header').text("Offer Achievers");
                    $('#div_Daimond').hide();
                    $('#div_Tour').hide();
                    $('#div_Offer').show();

                    $JDT('#tblOfferAchiever').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['csv', 'excel'],
                        data: json,
                        columns: [
                            { title: "SNo." },
                            { title: "Name" },
                            { title: "Show/Hide" },
                            { title: "User Name" },
                            { title: "Period" },
                            { title: "Month" },
                            { title: "Offer Reward" },
                            { title: "District" },
                            { title: "State" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 10,
                        "bDestroy": true,
                        "bPaginate": false,
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function Validation() {
            var file = $('input[type=file]').val(),
                ExcelType = $('#<%=ddl_ExcelType.ClientID%>').val();

            var MSG = "";
            if (!file) {
                MSG += "\n Please Select CSV File !!!";
            }
            if (ExcelType == "") {
                MSG += "\n Please Select Type !!!";
            }
            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to upload this file.？')) {
                return false;
            }
        }
    </script>
</asp:Content>



