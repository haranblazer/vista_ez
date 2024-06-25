<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="normalSearch.aspx.cs" EnableEventValidation="false" Inherits="admin_normalSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
    <h4 class="fs-20 font-w600  me-auto float-left mb-0"><%=method.Associate %></h4>
     <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtid" runat="server" CssClass="form-control" placeholder="Enter UserId"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtfname" runat="server" CssClass="form-control" placeholder="Enter User Name"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" CssClass="form-control"
                placeholder="Enter Mobile No"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_State" CssClass="form-control" runat="server" onchange="GetDistrict();">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">

            <asp:DropDownList ID="ddl_District" CssClass="form-control" runat="server">
                <asp:ListItem Value="">Select District</asp:ListItem>
            </asp:DropDownList>

        </div>

        <div class="col-sm-2 d-none">
            <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" placeholder="Enter City"></asp:TextBox>
        </div>

        <div class="col-sm-2 ">
            <asp:TextBox ID="txtPan" runat="server" MaxLength="10" CssClass="form-control" placeholder="Enter PAN No"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_PaidUnpaid" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Paid</asp:ListItem>
                <asp:ListItem Value="0">Unpaid</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Active" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="0">Inactive</asp:ListItem>
                <asp:ListItem Value="2">Permanently Blocked</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_IsTopper" runat="server" style="display: none;" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">First Purchase </asp:ListItem>
                <asp:ListItem Value="0">Non First Purchase</asp:ListItem>
            </asp:DropDownList>
        </div>
        
        
        <div class="col-sm-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>

    </div>

    <hr />


    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
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
                   <%-- <th></th>--%>
                </tr>
            </tfoot>
        </table>


    </div>



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
        var pageUrl = '<%=ResolveUrl("normalSearch.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                regno = $('#<%=txtid.ClientID%>').val(),
                AppMstFName = $('#<%=txtfname.ClientID%>').val(),
                AppMstMobile = $('#<%=txtMobileNo.ClientID%>').val(),
                District = $('#<%=ddl_District.ClientID%>').val() == "" ? "" : $("#<%=ddl_District.ClientID %> option:selected").text(),
                AppMstCity = $('#<%=txtcity.ClientID%>').val(),
                AppMstState = $('#<%=ddl_State.ClientID%>').val() == "" ? "" : $("#<%=ddl_State.ClientID %> option:selected").text(),
                panno = $('#<%=txtPan.ClientID%>').val(),
                IsPaid = $('#<%=ddl_PaidUnpaid.ClientID%>').val(),
                IsActive = $('#<%=ddl_Active.ClientID%>').val(),
                IsTopper = $('#<%=ddl_IsTopper.ClientID%>').val();


            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", regno: "' + regno + '", AppMstFName: "' + AppMstFName + '", AppMstMobile: "' + AppMstMobile
                    + '", District: "' + District + '", AppMstCity: "' + AppMstCity + '", AppMstState: "' + AppMstState
                    + '", panno: "' + panno + '", IsPaid: "' + IsPaid + '", IsActive: "' + IsActive + '", IsTopper: "' + IsTopper + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        var RegNo = "'" + data.d[i].RegNo + "'";
                        var Name = "'" + data.d[i].User_Name + "'";
                        var Mobile = "'" + data.d[i].User_Mobile_No + "'";

                        let Edit = '<a href="Edit.aspx?n=' + data.d[i].RegNo + '" style="color: blue; font-weight: bold;"><i class="fa fa-edit"></i> </a>';
                        let RegeneratePwd = ' <a href="#/" onclick="RegeneratePwd(' + RegNo + ',' + Name + ',' + Mobile + ')" style="color: blue;">RE-GENR PWD</a> ';

                        json.push([i + 1,
                            Edit,
                        data.d[i].User_ID,
                        data.d[i].User_Name,
                        data.d[i].Sponsor_ID,

                        data.d[i].Sponsor_Name,
                        data.d[i].User_Mobile_No,
                        data.d[i].User_Email_Id,
                        data.d[i].User_District,
                        data.d[i].User_State,

                        data.d[i].Paid_Status,
                        data.d[i].Topper_Status,
                        data.d[i].ID_Status,
                        data.d[i].Profit_Level,
                       // data.d[i].Generation_PIN,

                        data.d[i].Topper_PIN,
                            RegeneratePwd,
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
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Sponsor Id" },
                            { title: "Sponsor Name" },
                            { title: "Mobile No" },
                            { title: "Email Id" },
                            { title: "District" },
                            { title: "State" },
                            { title: "Paid Status" },
                            { title: "Status" },
                            { title: "ID Status" },
                            { title: "Profit Level" },
                            { title: "Rank" },
                            { title: "RE-GENR PWD" },
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

        function RegeneratePwd(RegNo, Name, Mobile) {
            $.ajax({
                type: "POST",
                url: pageUrl + '/RegeneratePwd',
                data: '{RegNo: "' + RegNo + '", Name: "' + Name + '", Mobile: "' + Mobile + '"}',
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


        function GetDistrict() {
            $('#<%=ddl_District.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
            $.ajax({
                type: "POST",
                url: pageUrl +'/GetDistrict',
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

</asp:Content>
