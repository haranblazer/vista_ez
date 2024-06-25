<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="BDM_Associates.aspx.cs" Inherits="secretadmin_BDM_Associates" %>


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
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">BDM Associates</h4>
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
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" placeholder="Search By City"></asp:TextBox>
        </div>


        <div class="col-sm-2">
            <asp:TextBox ID="txtPan" runat="server" MaxLength="10" CssClass="form-control" placeholder="Search By PAN No"></asp:TextBox>
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
            <asp:DropDownList ID="ddl_IsTopper" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Topper</asp:ListItem>
                <asp:ListItem Value="0">Non Topper</asp:ListItem>
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
                </tr>
            </tfoot>
        </table>


     <%--   <asp:Panel ID="Panel1" runat="server">
            <asp:GridView ID="dglst" class="gridd" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover mygrd"
                PageSize="100" EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" DataKeyNames="AppMstid"
                AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging" OnRowCommand="dglst_RowCommand">
                <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                <Columns> 
                    <asp:TemplateField HeaderText="Sl No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User ID">
                        <ItemTemplate>
                            <%# Eval("[User ID]") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="User Name">
                        <ItemTemplate>
                            <%# Eval("[User Name]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sponsor ID">
                        <ItemTemplate>
                            <%# Eval("[Sponsor ID]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sponsor Name">
                        <ItemTemplate>
                            <%# Eval("[Sponsor Name]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User Mobile No">
                        <ItemTemplate>
                            <%# Eval("[User Mobile No]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User Email Id">
                        <ItemTemplate>
                            <%# Eval("[User Email Id]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User District">
                        <ItemTemplate>
                            <%# Eval("[User District]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User State">
                        <ItemTemplate>
                            <%# Eval("[User State]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Paid Status">
                        <ItemTemplate>
                            <%# Eval("[Paid Status]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Topper Status">
                        <ItemTemplate>
                            <%# Eval("[Topper Status]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ID Status">
                        <ItemTemplate>
                            <%# Eval("[ID Status]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Profit Level">
                        <ItemTemplate>
                            <%# Eval("[Profit Level]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Generation PIN">
                        <ItemTemplate>
                            <%# Eval("[Generation PIN]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Topper PIN">
                        <ItemTemplate>
                            <%# Eval("[Topper PIN]") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                     
                </Columns>
            </asp:GridView>
        </asp:Panel>--%>
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
        var pageUrl = '<%=ResolveUrl("BDM_Associates.aspx")%>';
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
                       
                        json.push([i + 1, 
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
                        data.d[i].Generation_PIN,

                        data.d[i].Topper_PIN, 
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
                            { title: "Sponsor Id" },
                            { title: "Sponsor Name" },
                            { title: "Mobile No" },
                            { title: "Email Id" },
                            { title: "District" },
                            { title: "State" },
                            { title: "Paid Status" },
                            { title: "Topper Status" },
                            { title: "ID Status" },
                            { title: "Profit Level" },
                            { title: "Generation PIN" },
                            { title: "Topper PIN" }, 
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

