<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="UserLog.aspx.cs" Inherits="secretadmin_UserLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Users KYC Modification</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="form-group card-group-row row">

        <div class="col-sm-2">

            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                title="Date should be correct in format ex:- 'dd/mm/yyyy'." required="required"
                placeholder="dd/mm/yyyy"></asp:TextBox>
        </div>

        <div class="col-sm-2">

            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                title="Date should be correct in format ex:- 'dd/mm/yyyy'." required="required"
                placeholder="dd/mm/yyyy"></asp:TextBox>
        </div>
 
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Enter User Id"></asp:TextBox>
        </div>
       
        <div class="col-sm-2">
            <asp:TextBox ID="txt_ModifyBy" runat="server" CssClass="form-control" placeholder="Enter Modify By"></asp:TextBox>
        </div>
 
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_reason" runat="server" CssClass="form-control">
                <asp:ListItem Value="">All</asp:ListItem>
                <asp:ListItem Value="Approved Pan">Approved Pan</asp:ListItem>
                <asp:ListItem Value="Approved Bank">Approved Bank</asp:ListItem>
                <asp:ListItem Value="Approved Aadhar">Approved Aadhar</asp:ListItem>

                <asp:ListItem Value="Update PAN">Update PAN</asp:ListItem>
                <asp:ListItem Value="Update Bank">Update Bank</asp:ListItem>
                <asp:ListItem Value="Update Aadhar">Update Aadhar</asp:ListItem>

                <asp:ListItem Value="Reject Pan">Reject Pan</asp:ListItem>
                <asp:ListItem Value="Reject Bank">Reject Bank</asp:ListItem>
                <asp:ListItem Value="Reject Aadhar"></asp:ListItem>
                <asp:ListItem Value="Delete KYC">Delete KYC</asp:ListItem>
                <asp:ListItem Value="Update Profile">Update Profile</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>
    <div class="clearfix"> </div>
    <hr />
     

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%"></table>
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
        var pageUrl = '<%=ResolveUrl("UserLog.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                txt_Userid = $('#<%=txt_Userid.ClientID%>').val(),
                txt_ModifyBy = $('#<%=txt_ModifyBy.ClientID%>').val(),
                ddl_reason = $('#<%=ddl_reason.ClientID%>').val() ;

              
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", txt_Userid: "' + txt_Userid + '", txt_ModifyBy: "' + txt_ModifyBy + '", ddl_reason: "' + ddl_reason + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) { 
                        json.push([i + 1,
                            data.d[i].Userid,
                            data.d[i].Username,
                            
                            data.d[i].modifiedby,
                            data.d[i].Remarks,
                            data.d[i].Date,
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
                            { title: "Userid" },
                            { title: "Username" },
                            
                            { title: "Modified by" },
                            { title: "Remarks" },
                            { title: "Date" },
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
    </script>



</asp:Content>

