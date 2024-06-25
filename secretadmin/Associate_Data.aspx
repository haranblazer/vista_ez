<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Associate_Data.aspx.cs" Inherits="secretadmin_Associate_Data" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0"><%=method.Associate %> Data</h4>
    <div id="LoaderImg" style="width: 100%; text-align: center; position: absolute; z-index: 99999; display: none;">
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
            <asp:TextBox ID="txtid" runat="server" CssClass="form-control" placeholder="Search By UserId"></asp:TextBox>
        </div>


        <div class="col-sm-2">
            <asp:TextBox ID="txtfname" runat="server" CssClass="form-control" placeholder="Search By User Name"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" CssClass="form-control"
                placeholder="Search By Mobile No"></asp:TextBox>
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

        <%-- <div class="col-sm-2">
            <asp:DropDownList ID="ddl_State" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddl_State_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Value="">State</asp:ListItem>
            </asp:DropDownList>
        </div>



        <div class="col-sm-2">
            <asp:UpdatePanel ID="UpdateDistrictPanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:DropDownList ID="ddl_District" CssClass="form-control" runat="server">
                        <asp:ListItem Value="">District</asp:ListItem>
                    </asp:DropDownList>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddl_State" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>--%>



        <div class="col-sm-2">
            <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" placeholder="Search By Bank Name"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtPan" runat="server" MaxLength="10" CssClass="form-control" placeholder="Search By PAN No"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtAccno" runat="server" CssClass="form-control" placeholder="Search By Acc No"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtifscode" runat="server" CssClass="form-control" placeholder="Search IFSC"></asp:TextBox>
        </div>


        <%-- <div class="col-sm-2">
            <asp:DropDownList ID="ddl_PaidUnpaid" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Paid</asp:ListItem>
                <asp:ListItem Value="0">Unpaid</asp:ListItem>
            </asp:DropDownList>
        </div> --%>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Active" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="0">Inactive</asp:ListItem>
                <asp:ListItem Value="2">Permanently Blocked</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_PanAPIStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">Pan Status</asp:ListItem>
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:DropDownList>
        </div>



        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_PanStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">Pan Status</asp:ListItem>
                <asp:ListItem Value="2">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_BankStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">Bank Status</asp:ListItem>
                <asp:ListItem Value="2">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_AadharStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">Aadhar Status</asp:ListItem>
                <asp:ListItem Value="2">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:DropDownList>
        </div>
         <div class="col-sm-2">
             <asp:DropDownList ID="ddl_order" runat="server" CssClass="form-control">
                
                </asp:DropDownList>
             </div>


        <div class="col-sm-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>
        <%-- <div class="col-sm-1 pull-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/secretadmin/images/excel.gif"
                OnClick="imgbtnExcel_Click" Width="25px" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/secretadmin/images/word.jpg"
                OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
        </div>--%>

        <%-- <div class="col-sm-2">
            <button title="Search" runat="server" id="Button1" class="btn btn-primary" onserverclick="Button1_Click">
                <i class="fa fa-search" aria-hidden="true"></i>&nbsp;Search
            </button>
        </div>--%>
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
                    <th></th>
                    <th></th> 
                </tr>
            </tfoot>

        </table>
    </div>


    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script>        var $JD = $.noConflict(true); </script>
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
    <script>        var $JDT = $.noConflict(true); </script>

    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("Associate_Data.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {

            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                regno = $('#<%=txtid.ClientID%>').val(),
                AppMstFName = $('#<%=txtfname.ClientID%>').val(),
                AppMstState = $('#<%=ddl_State.ClientID%>').val() == "" ? "" : $("#<%=ddl_State.ClientID %> option:selected").text(),
                District = $('#<%=ddl_District.ClientID%>').val() == "" ? "" : $("#<%=ddl_District.ClientID %> option:selected").text(),
                AppMstMobile = $('#<%=txtMobileNo.ClientID%>').val(),
                panno = $('#<%=txtPan.ClientID%>').val(),
                bankname = $('#<%=txtBankName.ClientID%>').val(),
                accountno = $('#<%=txtAccno.ClientID%>').val(),
                ifscode = $('#<%=txtifscode.ClientID%>').val(),
                OnlinePanVerify = $('#<%=ddl_PanAPIStatus.ClientID%>').val(),
                PanStatus = $('#<%=ddl_PanStatus.ClientID%>').val(),
                BankStatus = $('#<%=ddl_BankStatus.ClientID%>').val(),
                AadharStatus = $('#<%=ddl_AadharStatus.ClientID%>').val(),
                IsActive = $('#<%=ddl_Active.ClientID%>').val();
                Cust_Type = $('#<%=ddl_order.ClientID%>').val();
            

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", regno: "' + regno + '", AppMstFName: "' + AppMstFName + '", AppMstState: "' + AppMstState + '", District: "' + District + '", AppMstMobile: "' + AppMstMobile
                    + '", panno: "' + panno + '",  BankName: "' + bankname + '",  AccountNo: "' + accountno + '",  IFSCCode: "' + ifscode + '", IsActive: "' + IsActive
                    + '", OnlinePanVerify: "' + OnlinePanVerify + '", PanStatus: "' + PanStatus + '", BankStatus: "' + BankStatus + '", AadharStatus: "' + AadharStatus + '",Cust_Type:"' + Cust_Type +'"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        let PanStatus = '';
                        let BankStatus = '';
                        let AadharStatus = '';

                        if (data.d[i].PStatus == '0' || data.d[i].PStatus == '1') {
                            PanStatus = '<span style="color:red;">No</span>';
                        }
                        else if (data.d[i].PStatus == '2') {
                            PanStatus = '<span style="color:green;">Yes</span>';
                        }

                        if (data.d[i].bankstatus == '0' || data.d[i].bankstatus == '1') {
                            BankStatus = '<span style="color:red;">No</span>';
                        }
                        else if (data.d[i].bankstatus == '2') {
                            BankStatus = '<span style="color:green;">Yes</span>';
                        }

                        if (data.d[i].AaStatus == '0' || data.d[i].AaStatus == '1') {
                            AadharStatus = '<span style="color:red;">No</span>';
                        }
                        else if (data.d[i].AaStatus == '2') {
                            AadharStatus = '<span style="color:green;">Yes</span>';
                        }

                        json.push([i + 1,
                       
                        data.d[i].User_ID,
                        data.d[i].User_Name,
                        data.d[i].PanApiName,
                            data.d[i].OnlinePanVerify == '1' ? '<span style="color:green;">Yes</span>' : '<span style="color:red;">No</span>',
                            data.d[i].DOJ,
                            data.d[i].Address,
                            data.d[i].City,
                            data.d[i].User_District,

                            data.d[i].User_State,
                            
                            data.d[i].AppMstPinCode,
                           
                        data.d[i].User_Mobile_No,
                        data.d[i].User_Pan_No,
                            
                        
                        data.d[i].User_Bank_Name,
                        data.d[i].User_Acc_No,
                            data.d[i].User_IFSC,
                            data.d[i].Pswrd,
                        data.d[i].ID_Status,

                            PanStatus,
                            BankStatus,
                            AadharStatus,
                            data.d[i].Customer_Type == "False" ? "<span><%=method.Associate%></span>" : "<span><%=method.Customer%> </span>"
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
                            
                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Pan Name" },
                            { title: "Pan Status" },
                            { title: "DOJ" },
                            { title: "Address" },
                            { title: "City" },
                            { title: "District" },
                            { title: "State" },
                            { title: "Pin Code" },
                            { title: "Mobile No" },
                            { title: "Pan No" },
                            { title: "Bank Name" },
                            { title: "Acc No" },
                            { title: "IFSC" },
                            { title: "Password" },
                            { title: "ID Status" },
                            { title: "Pan VFY." },
                            { title: "Bank VFY." },
                            { title: "Aadhar VFY." },
                            { title: "Customer Type" },

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



        function GetDistrict() {
            $('#<%=ddl_District.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDistrict',
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

