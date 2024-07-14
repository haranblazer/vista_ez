<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="TrainRequest.aspx.cs" Inherits="User_TrainRequest" %>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Training Request</h4>
    <div class="form-group card-group-row row">
                        <div class="col-md-1">
                            <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                                State:<span style="color: Red">*</span></label>
                        </div>
                        <div class="col-md-2">
                            <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="ContryExp" runat="server" ControlToValidate="DdlState"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000"
                                InitialValue="0" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-1">
                            <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                                City:<span style="color: Red">*</span></label>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Enter your City"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                                Display="None" ErrorMessage="Please Enter City!" ForeColor="#C00000" ValidationGroup="NJ"
                                SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-1">
                            <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                                Type:<span style="color: Red">*</span></label>
                        </div>
                        <div class="col-md-2">
                            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <%--<asp:ListItem Value="1">Associate</asp:ListItem>--%>
                                <asp:ListItem Value="2">Trainer</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DdlState"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000"
                                InitialValue="0" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                            <div class="clearfix">
                            </div>

                        </div>

                        <div class="col-md-1">
                            <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                                Training<span style="color: Red">*</span></label>
                        </div>
                        <div class="col-md-2">
                            <asp:DropDownList ID="ddlttype" runat="server" CssClass="form-control">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">Training Business</asp:ListItem>
                                <asp:ListItem Value="2">Product Training</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DdlState"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000"
                                InitialValue="0" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                            <div class="clearfix">
                            </div>

                        </div>

                        <div class="col-md-1">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
    
    
   <hr />

     <div class="clearfix"></div>
  
    <asp:Panel ID="Panel1" runat="server"> 

        <div class="table-responsive">
              <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

           <%-- <asp:GridView ID="gridTrnReq" EmptyDataText="No Record Found." CssClass="table table-striped table-hover" HeaderStyle-BackColor="#fe6a00" HeaderStyle-ForeColor="#ffffff"
                runat="server" AllowPaging="true" AutoGenerateColumns="false" PageSize="25" OnPageIndexChanging="gridTrnReq_PageIndexChanging"
                OnRowDataBound="gridTrnReq_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="appmstregno" HeaderText="UserId" />
                    <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                    <asp:BoundField DataField="State" HeaderText="State" />
                    <asp:BoundField DataField="City" HeaderText="City" />
                    <asp:BoundField DataField="typeofrequest" HeaderText="Type Of Request" />
                    <asp:BoundField DataField="trainingtype" HeaderText="Training Type" />
                    <asp:BoundField DataField="requestdate" HeaderText="Request Date" DataFormatString="{0:dd/MM/yyyy}" />
                   
                </Columns>
            </asp:GridView>--%>
        </div>

    </asp:Panel>


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
        var pageUrl = '<%=ResolveUrl("TrainRequest.aspx")%>';
        $JDT(function () {
           // $.noConflict(true);
            BindTable();
        });


        function BindTable() { 
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                //data: '{Months: "' + Months + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = []; 
                    for (var i = 0; i < data.d.length; i++) {
                        json.push([i + 1,
                            data.d[i].appmstregno,
                            data.d[i].appmstfname,
                            data.d[i].State,
                            data.d[i].City,
                            data.d[i].typeofrequest,
                            data.d[i].trainingtype,
                            data.d[i].requestdate, 
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "SNo" },
                            { title: "UserId" },
                            { title: "User Name" },
                            { title: "State" },
                            { title: "City" },
                            { title: "Type Of Request" },
                            { title: "Training Type" },
                            { title: "Request Date" }, 
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
    </script>



</asp:Content>
