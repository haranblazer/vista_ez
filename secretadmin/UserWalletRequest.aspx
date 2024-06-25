<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="UserWalletRequest.aspx.cs" Inherits="secretadmin_UserWalletRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromdate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtTodate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });


        function Validation() {
            var Pwd = $('#<%=txtPwd.ClientID%>').val();
            var MSG = "";
            if (Pwd == "") {
                MSG += "\n Please Enter e-password.!!";
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to approve request?')) {
                return false;
            }
        }

    </script>

    <%-- function openPopup( WalletRequestId, userid, fname, amt, redate, TransactionNo, Remarks, DepositorName, DepositorPhone, slip)
        {
            
           // var row = UserLink.parentNode.parentNode;


            $('#<%=hnd_Id.ClientID%>').val(WalletRequestId);
            $('#<%=hnd_userid.ClientID%>').val(userid);
            $('#<%=hnd_amt.ClientID%>').val(amt);
            $('#lbl_Userid').text(userid);
            $('#lbl_Name').text(fname);
            $('#lbl_amt').text(amt);

            $('#lbl_redate').text(redate);
            $('#lbl_TransactionNo').text(TransactionNo);
            $('#lbl_Remarks').text(Remarks);
            $('#lbl_DepositorPhone').text(DepositorName);
            $('#lbl_DepositorName').text(DepositorPhone);

            $('#lblPanImg').html('<img id="theImg" src="' + slip + '" style="width:100%; height:170px;" />');
            $('#myModal').modal('show');
            /*bindtable();*/
        }
    --%>




    <style type="text/css">
        #tooltip {
            position: absolute;
            border: 2px solid red;
            background-color: #FFFFE1;
            padding: 2px 5px;
            text-align: left;
            font-family: arial;
            font-size: 12px;
            color: #000000;
            display: none;
            width: auto;
            height: auto;
        }
    </style>

    <div class="card">
        <div class="card-header">
            <h4 class="card-title">Cash wallet request  </h4>
        </div>

        <div class="card-body">
            <div class="row">
                <div class="col-sm-1 control-label">
                    From:
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromdate" runat="server" CausesValidation="True" ToolTip="dd/mm/yyyy"
                        CssClass="form-control" ValidationGroup="a"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" ControlToValidate="txtFromdate"
                        ErrorMessage="From date require." SetFocusOnError="True" ValidationGroup="a"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-1 control-label">
                    To:
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtTodate" runat="server" CausesValidation="True" ToolTip="dd/mm/yyyy"
                        CssClass="form-control" ValidationGroup="a"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvToDate" runat="server" ControlToValidate="txtTodate"
                        Display="Dynamic" ErrorMessage="To date require." ValidationGroup="a"></asp:RequiredFieldValidator>
                    <div class="clearfix">
                    </div>

                </div>
                
                    <%--<asp:Button ID="Button1" runat="server" CssClass="btn btn-success" OnClick="Button1_Click"
                        Text="SHOW" ValidationGroup="tv" />&nbsp;--%>
                    <%--<asp:Button ID="btnShowall" runat="server" CssClass="btn" OnClick="btnShowall_Click"
                    Text="SHOW ALL" ValidationGroup="tv" />--%>
                
                 <div class="col-sm-2">
                     <asp:DropDownList ID="ddl_Active" runat="server" CssClass="form-control">
                        <asp:ListItem Value="1">Approved</asp:ListItem>
                        <asp:ListItem Value="0">Pending</asp:ListItem>
                         <asp:ListItem Value="2">Rejected</asp:ListItem>
                        <asp:ListItem Selected="True" Value="-1">All</asp:ListItem>
                    </asp:DropDownList>
                     </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="Enter Userid">
                    </asp:TextBox>
                     </div>
                <div class="col-md-2 pull-right text-right" style="display: none;">
                    <%--<asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />&nbsp;
        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />&nbsp;
        <asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif" OnClick="imgbtnPdf_Click" />--%>
                </div>
                <div class="col-sm-1">
                    <input type="button" value="Search" class="btn btn-success" onclick="bindtable()" />

            </div>
            <div class="form-group">
                <asp:Label ID="LblTotalRecord" runat="server" Font-Bold="True"></asp:Label>
                <asp:Label ID="LblAmount" runat="server" Font-Bold="True"></asp:Label>
            </div>
            <hr />

            <div class="table-responsive">
                <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
                </table>
            </div>
            <div class="table-responsive">
                <%-- <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromdate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtTodate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>--%>
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
                    var pageUrl = '<%=ResolveUrl("UserWalletRequest.aspx")%>';
                    $JDT(function () {
                        bindtable();
                    });



                    function bindtable() {
                        $('#LoaderImg').show();
                        var From = $('#<%=txtFromdate.ClientID%>').val();
                        var To = $('#<%=txtTodate.ClientID%>').val();
                        var Status = $('#<%=ddl_Active.ClientID%>').val();
                        var Id = $('#<%=txtUser.ClientID%>').val();




                        $.ajax({

                            type: "POST",
                            url: pageUrl + '/bindtable',
                            data: '{From:"' + From + '",To:"' + To + '",Status:"' + Status + '",Id:"' + Id + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                $('#LoaderImg').hide();

                                var json = [];
                                for (var i = 0; i < data.d.length; i++) {
                                    //'<a href="#" data-toggle="modal" data-target="#myModal" onclick="openPopup(' + userid + '); return false;">View Details</a>',
                                    let userid = "'" + data.d[i].User_ID + "'";
                                    let Name = "'" + data.d[i].Name + "'";
                                    let Req_Date = "'" + data.d[i].Request_Date + "'";
                                    let Tran_No = "'" + data.d[i].Tran_No + "'";
                                    let Remarks = "'" + data.d[i].Remarks + "'";
                                    let Depositor_Name = "'" + data.d[i].Depositor_Name + "'";
                                    let Depositor_Phone = "'" + data.d[i].Depositor_Phone + "'";
                                    let Slip = "'" + data.d[i].slip + "'";
                                    let Id = "'" + data.d[i].Wallet_Req_Id + "'";
                                    let Amt = "'" + data.d[i].Amount + "'";
                                    if (data.d[i].Status == "0") {
                                        var view = '<a href="javascript:void(0)" data-toggle="modal" data-target="#Model_Popup" onclick="openPopup(' + Id + ',' + userid + ',' + Name + ',' + Amt + ',' + Req_Date + ',' + Tran_No + ',' + Remarks + ',' + Depositor_Name + ',' + Depositor_Phone + ',' + Slip + ')" > View</a>';
                                    }
                                    else if (data.d[i].Status == "1") {
                                        view = '<span style="color:green">Approved</span>';
                                    }
                                    else {
                                        view = '<span style="color:red">Rejected</span>';
                                    }
                                    var Image = '<a href="javascript: void(0)" data-toggle="modal" data-target="#myModal" onclick="open_Popup(' + Slip + ')" > Slip</a>';

                                    json.push([i + 1,

                                    data.d[i].User_ID,
                                    data.d[i].Name,
                                    data.d[i].Amount,
                                    data.d[i].Request_Date,
                                    /*data.d[i].Payment,*/
                                    data.d[i].Tran_No,
                                    data.d[i].Remarks,
                                    //data.d[i].Depositor_Name,
                                    //data.d[i].Depositor_Phone,
                                    data.d[i].Approved_Date,
                                    data.d[i].Mode_of_Payment,

                                        Image,



                                        view

                                        //'<input type="button" value="Received" onclick="UpdateCourierDetails(' + data.d[i].sno + ')" class="btn btn-primary btn-sm" />',
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

                                        { title: "S.No" },
                                        { title: "User ID" },
                                        { title: "Name" },
                                        { title: "Amount" },
                                        { title: "Request Date" },
                                        /* { title: "Payment" },*/
                                        { title: "Tran No" },
                                        { title: "Remarks" },
                                        //{ title: "Depositor Name" },
                                        //{ title: "Depositor Phone" },
                                        { title: "Approved Date" },
                                        { title: "Mode of Payment" },

                                        { title: "Image" },

                                        { title: "View" },






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
                    function open_Popup(slip) {

                        $('#lbl_PanImg').html('<img id="theImg" src="../images/PaymentSlip/' + slip + '" style="width:100%; height:200px;" />');
                        $('#myModal').modal('show');
                    }
                    function openPopup(srno, userid, fname, amt, redate, TransactionNo, Remarks, DepositorName, DepositorPhone, slip) {
                        alert();
                        debugger;
                        $("#Model_Popup").modal('show');
                        // var row = UserLink.parentNode.parentNode;

                        $('#<%=hnd_srno.ClientID%>').val(srno);
                        $('#<%=hnd_regno.ClientID%>').val(userid);
                        $('#<%=hnd_coment.ClientID%>').val(Remarks);
<%--                        $('#<%=hnd_e_password.ClientID%>').val(epassword);--%>
<%--                        $('#<%=hnd_status.ClientID%>').val(status);--%>

                        <%--$('#<%=hnd_Id.ClientID%>').val(WalletRequestId);
                        $('#<%=hnd_userid.ClientID%>').val(userid);--%>
                        $('#<%=hnd_amt.ClientID%>').val(amt);
                        $('#lbl_Userid').html(userid);
                        $('#lbl_Name').html(fname);
                        $('#lbl_amt').html(amt);

                        $('#lbl_redate').html(redate);
                        $('#lbl_TransactionNo').html(TransactionNo);
                        $('#lbl_Remarks').html(Remarks);
                        $('#lbl_DepositorPhone').html(DepositorName);
                        $('#lbl_DepositorName').html(DepositorPhone);

                        $('#lblPanImg').html("<a href='../images/PaymentSlip/" + slip + "' data-fancybox='gallery' style='min-height:267px; min-height:450px;' > <img src='" + slip + "' Width='450px' Height='267px'> </a>");
                        /*bindtable();*/
                    }
                    function App_Rej(status) {
                        let srno = $('#<%=hnd_srno.ClientID %>').val();
                        let regno = $('#<%=hnd_regno.ClientID %>').val();
                        let coment = $('#<%=hnd_coment.ClientID %>').val();
                        let epwd = $('#<%=txtPwd.ClientID %>').val();
                        let Amt = $('#<%=hnd_amt.ClientID %>').val();
                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/App_Rej',
                            data: '{srno:"' + srno + '",regno:"' + regno + '",coment:"' + coment + '",epwd:"' + epwd + '",status:"' + status + '",Amt:"' + Amt + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {

                                if (data.d == "1") {

                                    if (status == 1) {
                                        alert("Request Approved Successfully.");
                                    }
                                    else {
                                        alert("Request Rejected Successfully.");
                                    }

                                    $("#Model_Popup").modal('hide');
                                    bindtable();
                                }
                                else {
                                    alert(data.d);
                                }


                            },
                            error: function (result) {
                                (result);
                            }
                        });
                    }
                    //}

                </script>
                <asp:HiddenField ID="hnd_srno" runat="server" />
                <asp:HiddenField ID="hnd_Id" runat="server" />
                <asp:HiddenField ID="hnd_userid" runat="server" />
                <asp:HiddenField ID="hnd_amt" runat="server" />
                <asp:HiddenField ID="hnd_coment" runat="server" />
                <asp:HiddenField ID="hnd_e_password" runat="server" />
                <asp:HiddenField ID="hnd_regno" runat="server" />
                <asp:HiddenField ID="hnd_status" runat="server" />

                <%--<asp:GridView ID="GridView1" DataKeyNames="WalletRequestId" EmptyDataText=" "
                    runat="server"  AutoGenerateColumns="False" CssClass="table table-striped table-hover"
                    OnPageIndexChanging="dglst_PageIndexChanging" Font-Size="9pt">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="userid" HeaderText="UserId" />
                        <asp:BoundField DataField="fname" HeaderText="Name" />
                        <asp:BoundField DataField="amt" HeaderText="Amount" />
                        <asp:BoundField DataField="redate" HeaderText="Request Date" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink3" ToolTip='<%#Eval("payDetail") %>' runat="server" CssClass="tooltip">
                              <b> Payment</b> 
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TransactionNo" HeaderText="Tran No" />
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                        <asp:BoundField DataField="DepositorName" HeaderText="Depositor Name" />
                        <asp:BoundField DataField="DepositorPhone" HeaderText="Depositor Phone" />

                        <asp:TemplateField HeaderText="View">
                            <ItemTemplate>
                                <a href="#" data-toggle="modal" data-target="#myModal"
                                    onclick='openPopup(this, "<%# Eval("WalletRequestId")%>","<%# Eval("userid")%>","<%# Eval("fname")%>",
                                    "<%# Eval("amt")%>","<%# Eval("redate")%>","<%# Eval("TransactionNo")%>",
                                    "<%# Eval("Remarks")%>","<%# Eval("DepositorName")%>","<%# Eval("DepositorPhone")%>",

                                    "<%# Eval("Slip","../images/PaymentSlip/{0}")%>");return false;'>View</a>
                            </ItemTemplate>
                        </asp:TemplateField>

                --%>        <%--<asp:TemplateField HeaderText="E-Password" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:TextBox ID="txtPwd" runat="server" MaxLength="20" TextMode="Password" CssClass="form-control"
                            placeholder="Enter E-Password" Style="max-width: 160px; min-width: 140px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="LinkButton1" CommandName="Aprove" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                        runat="server" TabIndex="1" Text="Approve" CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure to approve the user?')"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="LinkButton2" CommandName="Reject" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                        TabIndex="2" runat="server" CssClass="btn btn-danger" Text="Reject" OnClientClick="return confirm('Are you sure to reject the user?')"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:TemplateField>--%>

                <%--</Columns>--%>

                <headerstyle font-size="9pt" />

                <%-- </asp:GridView>--%>
            </div>
        </div>
    </div>




    <div id="Model_Popup" class="modal fade show" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;PAN Documents</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup_Model()">
                    </button>
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3 pb-2">UserId</div>
                        <div class="col-sm-9 pb-2">
                            <div id="lbl_Userid"></div>
                        </div>

                        <div class="col-sm-3 pb-2">Name</div>
                        <div class="col-sm-9 pb-2">
                            <div id="lbl_Name"></div>
                        </div>

                        <div class="col-sm-3 pb-2">Amount</div>
                        <div class="col-sm-9">
                            <div id="lbl_amt"></div>
                        </div>

                        <div class="col-sm-3 pb-2">Request Date</div>
                        <div class="col-sm-9">
                            <div id="lbl_redate"></div>
                        </div>

                        <div class="col-sm-3 pb-2">Tran No</div>
                        <div class="col-sm-9">
                            <div id="lbl_TransactionNo" style="width: 100%;"></div>
                        </div>

                        <div class="col-sm-3 pb-2">Remarks</div>
                        <div class="col-sm-9">
                            <div id="lbl_Remarks" style="width: 100%;"></div>
                        </div>

                        <div class="col-sm-3 pb-2">Depositor Name</div>
                        <div class="col-sm-9">
                            <div id="lbl_DepositorName" style="width: 100%;"></div>
                        </div>

                        <div class="col-sm-3 pb-2">Depositor Phone</div>
                        <div class="col-sm-9">
                            <div id="lbl_DepositorPhone" style="width: 100%;"></div>
                        </div>
                        <div class="col-sm-3 pb-2">E-Password</div>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtPwd" runat="server" MaxLength="20" TextMode="Password" CssClass="form-control"
                                placeholder="Enter E-Password"></asp:TextBox>

                        </div>
                        <div class="col-sm-3 pb-2">Slip</div>

                        <br />

                        <div class="col-sm-12 pb-2">
                            <div id="lblPanImg"></div>
                        </div>
                        <br />


                        <div class="col-sm-3 pb-2">
                            <button type="button" onclick="App_Rej(1)" class="btn btn-success">Approve</button>

                        </div>
                        <div class="col-sm-9">
                            <button type="button" onclick="App_Rej(2)" class="btn btn-danger">Reject</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                           
                           
                            <h4 class="modal-title" id="myModalLabel">Payment Slip</h4>
                             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label id="lbl_PanImg" style="width: 100%;"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
    <!-- Modal -->
    <%--        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                           
                            <h4 class="modal-title" id="myModalLabel">View Pin request</h4>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                        </div>
                        <div class="modal-body">

                            <asp:HiddenField ID="hnd_Id" runat="server" />
                            <asp:HiddenField ID="hnd_userid" runat="server" />
                            <asp:HiddenField ID="hnd_amt" runat="server" />
                            <div class="form-group row">
                                <div class="col-md-4">UserId</div>
                                <div class="col-md-8">
                                    <label id="lbl_Userid" style="width: 100%;"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="form-group row">
                                <div class="col-md-4">Name</div>
                                <div class="col-md-8">
                                    <label id="lbl_Name" style="width: 100%;"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="form-group row">
                                <div class="col-md-4">Amount</div>
                                <div class="col-md-8">
                                    <label id="lbl_amt" style="width: 100%;"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="form-group row">
                                <div class="col-md-4">Request Date</div>
                                <div class="col-md-8">
                                    <label id="lbl_redate" style="width: 100%;"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="form-group row">
                                <div class="col-md-4">Tran No</div>
                                <div class="col-md-8">
                                    <label id="lbl_TransactionNo" style="width: 100%;"></label>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                            <div class="form-group row">
                                <div class="col-md-4">Remarks</div>
                                <div class="col-md-8">
                                    <label id="lbl_Remarks" style="width: 100%;"></label>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                            <div class="form-group">
                                <div class="col-md-4">Depositor Name</div>
                                <div class="col-md-8">
                                    <label id="lbl_DepositorName" style="width: 100%;"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="form-group row">
                                <div class="col-md-4">Depositor Phone</div>
                                <div class="col-md-8">
                                    <label id="lbl_DepositorPhone" style="width: 100%;"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="form-group row">
                                <div class="col-md-4">E-Password</div>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtPwd" runat="server" MaxLength="20" TextMode="Password" CssClass="form-control"
                                        placeholder="Enter E-Password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clearfix"></div>



                            <div class="form-group row">
                                <div class="col-md-4">Slip</div>
                                <div class="col-md-8">
                                    <label id="lblPanImg" style="width: 100%;"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <asp:Button ID="Btn_Approve" runat="server" CssClass="btn btn-success" Text="Approve" OnClick="Btn_Approve_Click"
                                OnClientClick="javascript:return Validation();" />

                            <asp:Button ID="Btn_Reject" runat="server" CssClass="btn btn-danger" Text="Reject" OnClick="Btn_Reject_Click"
                                OnClientClick="return confirm('Are you sure you want to reject request?')" />
                        </div>
                    </div>
                </div>
            </div>--%>

    <%-- <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript"> var $JD = $.noConflict(true); </script>--%>
    <%-- <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
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
        $JDT(document).ready(function () {


            //$JD('.6').show();
            $JDT("#<%=GridView1.ClientID %>").prepend($("<thead></thead>").append($("#<%=GridView1.ClientID %>").find("tr:first"))).DataTable(
                {
                    "bLengthChange": true,
                    "dom": 'Blfrtip',
                    "buttons": [
                        'excelHtml5',
                        'csvHtml5',
                        'pdfHtml5'
                    ],
                    "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                    "pageLength": 25,
                    "bDestroy": true,
                    "bSort": true,
                    "bFilter": true,
                    "bPaginate": true
                });
        });

    </script>--%>
</asp:Content>
