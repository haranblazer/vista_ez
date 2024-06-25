<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="AssociatePackageBill.aspx.cs" EnableEventValidation="false"
    Inherits="secretadmin_AssociatePackageBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Associate Invoice List</h4>

      <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>

    <div class="row">

        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                placeholder="From"></asp:TextBox>
        </div>

        <div class="col-sm-2">

            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                placeholder="To"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="ddl_RoleWise" runat="server" CssClass="form-control" placeholder="Enter Franchise Id"></asp:TextBox>
        </div>

        <%--<div class="col-sm-2">
                            <label class="control-label">
                                Package Type</label>
                        </div>--%>
        <div class="col-sm-2">
            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control">
                <asp:ListItem Value="0" Selected="True">All </asp:ListItem>
                <asp:ListItem Value="1">First Purchase</asp:ListItem>
                <asp:ListItem Value="3">Generation</asp:ListItem>
                <asp:ListItem Value="4">Consistency</asp:ListItem>
                <asp:ListItem Value="5">Free Sample</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="TxtSponsorId" runat="server" MaxLength="30" CssClass="form-control"
                ToolTip="InvNo/UserID/Name" placeholder="InvNo/UserID/Name"></asp:TextBox>
        </div>
        <%-- <div class="col-sm-2">
                            <label class="control-label">
                                Invoice Status</label>
                        </div>--%>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="-1">All </asp:ListItem>
                <asp:ListItem Value="0">Cancelled</asp:ListItem>
            </asp:DropDownList>
        </div>

        <%-- <div class="col-sm-2">
                            <label class="control-label">
                                Pay Mode</label>
                        </div>--%>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_paymode" runat="server" CssClass="form-control">
                <asp:ListItem Value="" Selected="True">All </asp:ListItem>
                <asp:ListItem Value="Cash">Cash</asp:ListItem>
                <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                <asp:ListItem Value="Net Banking">Net Banking</asp:ListItem>
                <asp:ListItem Value="DD">DD</asp:ListItem>
                <asp:ListItem Value="Wallet">Wallet</asp:ListItem>

                <asp:ListItem Value="BankTran">C Wallet</asp:ListItem>
                <%--<asp:ListItem Value="PTran80">G Wallet</asp:ListItem>
                        <asp:ListItem Value="RedeemWallet">Loyalty Wallet</asp:ListItem>
                        <asp:ListItem Value="PTran20">T Wallet</asp:ListItem>
                        <asp:ListItem Value="RewardWallet">R Wallet</asp:ListItem>--%>
                <asp:ListItem Value="Paytm">Online Paytm</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2" style="display: none;">
            <label class="control-label">Package Type</label>
        </div>
        <div class="col-sm-2" style="display: none;">
            <asp:DropDownList ID="ddlcvtype" runat="server" CssClass="form-control">
                <asp:ListItem Value="0" Selected="True">All </asp:ListItem>
                <asp:ListItem Value="1">PV</asp:ListItem>
                <asp:ListItem Value="3">RPV</asp:ListItem>
            </asp:DropDownList>
        </div>
        <%--  <div class="col-sm-2">
                            <label class="control-label">
                                User Type</label>
                        </div>--%>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control" onchange="GetSelectedTextValue(this)">
                <asp:ListItem Value="0" Selected="True">All </asp:ListItem>
                <asp:ListItem Value="1">User </asp:ListItem>
                <asp:ListItem Value="2">Team</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <label class="control-label">
                Invoice Status
            </label>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txtcvlimit" runat="server" onkeypress="number()" CssClass="form-control">0</asp:TextBox>
        </div>
        <div class="col-sm-2 control-label">

            <asp:RadioButton ID="RadioButton1" runat="server" GroupName="p" Text="<" CssClass="radios" />&nbsp; 
                    <asp:RadioButton ID="RadioButton2" runat="server" GroupName="p" Text="=" CssClass="radios" />&nbsp; 
                    <asp:RadioButton ID="RadioButton3" runat="server" GroupName="p" Text=">" CssClass="radios" />&nbsp; 
                    <asp:RadioButton ID="RadioButton4" runat="server" ForeColor="White" GroupName="p"
                        Text="." CssClass="radios" Checked="True" />&gt;=&nbsp; 
                    <asp:RadioButton ID="RadioButton5" runat="server" ForeColor="White" GroupName="p"
                        Text="." CssClass="radios" />&lt;=&nbsp;    
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Del_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1" Selected="True">All </asp:ListItem>
                <asp:ListItem Value="1">Delivered</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
                <asp:ListItem Value="2">Dispatched</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_order" runat="server" CssClass="form-control">
                
                </asp:DropDownList>
            </div>
        <div class="col-sm-2 col-xs-8">
            <%-- <button title="Search" id="btnSearch" runat="server" class="btn btn-success" onserverclick="btnSearch_Click"
                        validationgroup="Show">
                        <i class="fa fa-search"></i>Search
                    </button>--%>
            <%-- <input type="button" value="Search" onclick="FuDownline()" class="btn btn-success" /--%>

            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                Search
            </button>

            <button type="button" title="reset" class="btn btn-danger" onclick="Reser()">
                Reset
            </button>
        </div>
    </div>



    <hr />

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
            <tfoot align="center">
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
                    <th></th>
                    <th></th>
                    <th></th>
                  
                </tr>
            </tfoot>

        </table>

        <%-- <asp:GridView AllowPaging="true" ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mygrd"
                    EmptyDataText="No Data Found" PageSize="100" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" DataKeyNames="InvoiceNo"
                    OnRowDataBound="GridView1_RowDataBound" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating" ShowFooter="True">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                                <asp:HiddenField ID="hnd_Del_Status" runat="server" Value='<%#Eval("Del_Status") %>' />
                                <asp:HiddenField ID="hnd_status" runat="server" Value='<%#Eval("status") %>' />
                            </ItemTemplate>
                            <FooterTemplate>
                                Total:
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Date" DataField="Date" />
                        <asp:HyperLinkField DataNavigateUrlFields="srno_Encript" HeaderText="Invoice No."
                            DataTextField="InvoiceNo" DataNavigateUrlFormatString="../Common/Invoice.aspx?id={0}" />

                        <asp:BoundField HeaderText="Seller Id" DataField="SellerUserId" />
                        <asp:BoundField HeaderText="Seller Name" DataField="SellerName" />
                        <asp:BoundField HeaderText="Seller District" DataField="SellerState" />
                        <asp:BoundField HeaderText="Seller State" DataField="SellerDistrict" />
                     
                        <asp:BoundField HeaderText="Buyer Id" DataField="BuyerUserId" />
                        <asp:BoundField HeaderText="Buyer Name" DataField="BuyerName" />

                        <asp:BoundField HeaderText="Buyer State" DataField="BuyerState" />
                        <asp:BoundField HeaderText="Buyer District" DataField="BuyerDistrict" />
                        <asp:BoundField HeaderText="Buyer Mobile No" DataField="BuyerMobileNo" />
                        <asp:BoundField HeaderText="No of Products" DataField="NoOFProduct" />
                         <asp:BoundField HeaderText="Billed Qty." DataField="Actual_Qty" />

                        <asp:BoundField HeaderText="DP Value" DataField="grossAmt" />

                        <asp:BoundField HeaderText="SGST" DataField="SGST" />
                        <asp:BoundField HeaderText="CGST" DataField="CGST" />
                        <asp:BoundField HeaderText="IGST" DataField="IGST" />
                        <asp:BoundField HeaderText="Cess" DataField="Cess" />

                        <asp:BoundField HeaderText="DP with Tax" DataField="amt" />

                        <asp:BoundField HeaderText="Discount" DataField="Discount" />
                        <asp:BoundField HeaderText="Courier Charges" DataField="CourierCharges" />

                        <asp:BoundField HeaderText="Invoice Value" DataField="netAmt" />
                        <asp:BoundField HeaderText="TPV " DataField="BV" />
                        <asp:BoundField HeaderText="RPV " DataField="PV" />
                        <asp:BoundField HeaderText="FPV " DataField="TotalFPV" />

                        <asp:BoundField HeaderText="Billing Type" DataField="Subdistype" />
                        <asp:TemplateField HeaderText="Invoice Status">
                            <ItemTemplate>
                                <asp:Label ID="lbl_cancelled" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dispatch Status">
                            <ItemTemplate>
                                <asp:Label ID="lbl_DelStatus" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="PanNo" DataField="PanNo" />

                        <asp:BoundField HeaderText="GSTNo" DataField="GSTNo" />

                        <asp:BoundField HeaderText="Payment Mode" DataField="PayMode" />

                         <asp:HyperLinkField DataNavigateUrlFields="srno_Encript" HeaderText="Invoice No."
                            DataTextField="InvoiceNo" DataNavigateUrlFormatString="../Common/Invoice.aspx?id={0}" />
                        <asp:BoundField HeaderText="Dispatch Date" DataField="DispatchDate" />
                        <asp:TemplateField HeaderText="Transport">
                            <ItemTemplate>
                                <asp:TextBox ID="txtTransport" runat="server" Text='<%#Eval("Transport") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tracking">
                            <ItemTemplate>
                                <asp:TextBox ID="txtTracking" runat="server" Text='<%#Eval("Tracking") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="E Way Bill">
                            <ItemTemplate>
                                <asp:TextBox ID="txt_EWayBill" runat="server" Text='<%#Eval("EWayBill") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Remarks">
                            <ItemTemplate>
                                <asp:TextBox ID="txtcom" runat="server" Text='<%#Eval("Del_Remarks") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Deliver">
                            <ItemTemplate>
                                <asp:Button ID="btnSubmit" runat="server" Text="Dispatch" CommandName="update" CommandArgument="<%#((GridViewRow)Container).RowIndex %>"
                                    CssClass="btn btn-success" OnClientClick="return confirm('Are you sure you want to dispatch this items...?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
 
                         <asp:TemplateField HeaderText="Packing Slip">
                        <ItemTemplate>
                            <center> 
                                <a href="AssoPackingSlip.aspx?id=<%# Eval("InvoiceNo")%>">
                                     <%# Eval("Pack_Status").ToString() == "1" ? "<span style='color:green;'><i class='fa fa-gift' aria-hidden='true'></i></span>" : "<span style='color:red;'><i class='fa fa-gift' aria-hidden='true'></i></span>"%>
                                </a>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>


                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnCancel" Text="cancel" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    CommandName="cancel" runat="server" OnClientClick="return confirm('Are you sure you want to cancel this bill?');" Style="color: blue;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>--%>
    </div>
    <div class="clearfix"></div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 100%;">
        <div class="modal-dialog" style="width: 50%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">View Dispatch</h4>
                </div>
                <div class="modal-body">

                    <div class="col-md-12">
                        <div class="row" style="padding-bottom: 10px;">
                            <div class="col-sm-6">
                                <label class="control-label">Invoice No</label>
                            </div>
                            <div class="col-sm-6">
                                <span id="lbl_Invoice"></span>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom: 10px;">
                            <div class="col-sm-6">
                                <label class="control-label">Transport</label>
                            </div>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txt_Transport" runat="server" MaxLength="30" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom: 10px;">
                            <div class="col-sm-6">
                                <label class="control-label">Tracking</label>
                            </div>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txt_Tracking" runat="server" MaxLength="30" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom: 10px;">
                            <div class="col-sm-6">
                                <label class="control-label">E Way Bill</label>
                            </div>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txt_EWay" runat="server" MaxLength="30" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom: 10px;">
                            <div class="col-sm-6">
                                <label class="control-label">Remarks</label>
                            </div>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txt_Remarks" runat="server" MaxLength="30" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom: 10px;">
                            <div class="col-sm-6">
                                <label class="control-label"></label>
                            </div>
                            <div class="col-sm-6">
                                <input type="button" onclick="Dispatched_Invice()" value="Dispatch" class="btn btn-success" />
                            </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
 
    <asp:HiddenField ID="hnd_Fran" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_Inv" runat="server" Value="" />


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



    <%-- Table Js and css  --%>
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

    <%--<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> --%>
    <script type="text/javascript">

        var pageUrl = '<%=ResolveUrl("AssociatePackageBill.aspx")%>';
        $JDT(function () {
           <%-- $.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });--%>

            BindTable();
        });


        function BindTable() {
            var cvlimitindx = "";
            if ($("#<%= RadioButton1.ClientID %>").is(":checked")) {
                cvlimitindx = "1";
            }
            else if ($("#<%= RadioButton2.ClientID %>").is(":checked")) {
                cvlimitindx = "2";
            }
            else if ($("#<%= RadioButton3.ClientID %>").is(":checked")) {
                cvlimitindx = "3";
            }
            else if ($("#<%= RadioButton4.ClientID %>").is(":checked")) {
                cvlimitindx = "4";
            }
            else if ($("#<%= RadioButton5.ClientID %>").is(":checked")) {
                cvlimitindx = "5";
            }


            var SponsorId = $('#<%=TxtSponsorId.ClientID%>').val();
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            var billtype = $('#<%=DropDownList2.ClientID%>').val();
            var status = $('#<%=ddl_Status.ClientID%>').val();
            var RoleWise = $('#<%=ddl_RoleWise.ClientID%> option:selected').text();
            var PaymentMode = $('#<%=ddl_paymode.ClientID%>').val();
            var cvtype = $('#<%=ddlcvtype.ClientID%>').val();
            var cvlimit = cvlimitindx;
            var cvlimitval = $('#<%=txtcvlimit.ClientID%>').val();
            var usertype = $('#<%=ddlUserType.ClientID%>').val();
            var Del_Status = $('#<%=ddl_Del_Status.ClientID%>').val();
            var FranType = $('#<%=hnd_Fran.ClientID%>').val(); 
            var Cust_Type = $('#<%=ddl_order.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindInvoice',
                data: '{SponsorId: "' + SponsorId + '", min: "' + min + '", max: "' + max + '", billtype: "' + billtype + '", status: "' + status
                    + '", RoleWise: "' + RoleWise + '", PaymentMode: "' + PaymentMode + '", cvtype: "' + cvtype + '", cvlimit: "' + cvlimit + '", cvlimitval: "' + cvlimitval
                    + '", usertype: "' + usertype + '", Del_Status: "' + Del_Status + '", FranType: "' + FranType + '", Cust_Type: "' + Cust_Type + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $('#LoaderImg').hide();
                    var T_NoOFProduct = 0, T_Actual_Qty = 0, T_grossAmt = 0, T_SGST = 0, T_CGST = 0, T_IGST = 0, T_Amt = 0, T_CourierCharges = 0, T_netAmt = 0, T_BV = 0, T_PV = 0;
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        let InvText = data.d[i].status == "1" ? "<span class='text-blue'>" + data.d[i].InvoiceNo + "</span>" : "<span class='text-red'>" + data.d[i].InvoiceNo + "</span>";
                        $('#TxtSponsorId').val();

                        let InvUrl = '';
                        if (data.d[i].Subdistype == 'Loyalty') {
                            InvUrl = 'LR_Invoice';
                        }
                        else {
                            InvUrl = 'Invoice';
                        }
                       
                        var Invoice = '<a target="_blank" href="../Common/' + InvUrl + '.aspx?id=' + data.d[i].srno_Encript + '" style="font-weight: bold;">'+ InvText +'</a>';

                        var srno = data.d[i].srno;


                        var Packing = '';
                        if (data.d[i].Pack_Status == '1') {
                            Packing = '<a href="AssoPackingSlip.aspx?id=' + data.d[i].InvoiceNo + '"><span style="color:green;"> <i class="fa fa-gift" aria-hidden="true"></i> </span></a>';
                        }
                        else {
                            Packing = '<a href="AssoPackingSlip.aspx?id=' + data.d[i].InvoiceNo + '"><span style="color:red;"> <i class="fa fa-gift" aria-hidden="true"></i></span></a>';
                        }


                        var Transport = '<input type="text" id="txt_Transport' + srno + '" value="' + data.d[i].Transport + '" class="form-control"></input>';
                        var Tracking = '<input type="text" id="txt_Tracking' + srno + '" value="' + data.d[i].Tracking + '" class="form-control"></input>';
                        var EWay = '<input type="text" id="txt_EWay' + srno + '" value="' + data.d[i].EWayBill + '" class="form-control"></input>';
                        var Remarks = '<input type="text" id="txt_Remarks' + srno + '" value="' + data.d[i].Del_Remarks + '" class="form-control"></input>';

                        var inv = "'" + data.d[i].InvoiceNo + "'";

                        var Deliver = '';
                        if (data.d[i].Del_Status == '1') {
                            //Deliver = '<input type="button" value="Dispatched" class="btn btn-success">';
                            Deliver = '<a href="javascript:void(0)" onclick="Deliver_Invice(' + inv + ',' + data.d[i].srno + ')" class="btn btn-success">Dispatched</a>';
                        }
                        else {//data-bs-toggle="modal" data-bs-target="#myModal"
                            Deliver = '<a href="javascript:void(0)" onclick="Deliver_Invice(' + inv + ',' + data.d[i].srno + ')" class="btn btn-success">Dispatch</a>';
                        }
                        var Img1Color = "style=color:blue;";
                        if (data.d[i].Img1 != "")
                            Img1Color = "style=color:green;";

                        var Img2Color = "style=color:blue;";
                        if (data.d[i].Img2 != "")
                            Img2Color = "style=color:green;";

                        var Upload_lr1 = '<input type="file" id="img_lr1' + srno + '" onChange="javascript:UploadImg_lr1(' + srno + ');" accept=".png,.jpg,.jpeg,.gif" style="display:none;"> <label for="img_lr1' + srno + '" title="Upload LR Image 1"> <i class="fa fa-upload"></i> </label>  &nbsp;&nbsp;&nbsp;&nbsp; <a href="../images/Slip/' + data.d[i].Img1 + '" data-fancybox="gallery" ' + Img1Color + '"> <i class="fa fa-eye" title="View Image 1"></i> </a>';
                        var Upload_lr2 = '<input type="file" id="img_lr2' + srno + '" onChange="javascript:UploadImg_lr2(' + srno + ');" accept=".png,.jpg,.jpeg,.gif" style="display:none;"> <label for="img_lr2' + srno + '" title="Upload LR Image 2"> <i class="fa fa-upload"></i> </label>  &nbsp;&nbsp;&nbsp;&nbsp; <a href="../images/Slip/' + data.d[i].Img2 + '" data-fancybox="gallery" ' + Img2Color + '"> <i class="fa fa-eye" title="View Image 2"></i> </a>';

                        var SMS = "'SMS'";
                        var WHATSAPP = "'WHATSAPP'";

                        var SMS_BuyerUserId = "'" + data.d[i].BuyerUserId + "'";
                        var SMS_BuyerName = "'" + data.d[i].BuyerName + "'";
                        var SMS_Disp_Date = "'" + data.d[i].DispatchDate + "'";
                        var SMS_Docket = "'" + data.d[i].Tracking + "'";
                        var SMS_Transport = "'" + data.d[i].Transport + "'";
                        var SMS_MobileNo = "'" + data.d[i].BuyerMobileNo + "'";
                        var SMS_IMG_LR1 = "'" + data.d[i].Img1 + "'";


                        var Send_sms = '<span class="dotBlue" title="SMS Count">' + data.d[i].SendMsg + '</span> <a href="#/" onclick="SendSms(' + SMS + ',' + srno + ',' + SMS_BuyerUserId + ',' + SMS_BuyerName + ',' + inv + ',' + SMS_Disp_Date + ',' + SMS_Docket + ',' + SMS_Transport + ',' + SMS_MobileNo + ',' + SMS_IMG_LR1 + ')"  class="btn btn-success" style="" title="Send Message"> <i class="fa fa-send-o"></i> </a>';
                        var Send_Whats_sms = '<span class="dotBlue" title="SMS Count">' + data.d[i].SendWhatsApp + '</span> <a href="#/" onclick="SendSms(' + WHATSAPP + ',' + srno + ',' + SMS_BuyerUserId + ',' + SMS_BuyerName + ',' + inv + ',' + SMS_Disp_Date + ',' + SMS_Docket + ',' + SMS_Transport + ',' + SMS_MobileNo + ',' + SMS_IMG_LR1 + ')" class="btn btn-success" style="" title="Send Whats App Message"> <i class="fa fa-whatsapp"></i> </a>';
                        var IS_OPTIN = "<span class='dotGrey' title='Not Optin'></span>";
                        if (data.d[i].IS_OPTIN == "1")
                            var IS_OPTIN = "<span class='dotGreen' title='Is Optin'></span>";

                        var Action = '<input type="button" onclick="Cancel_Invice(' + inv + ')" value="Cancel" class="btn btn-link">';

                        T_NoOFProduct = parseInt(T_NoOFProduct) + parseInt(data.d[i].NoOFProduct);
                        T_Actual_Qty = parseInt(T_Actual_Qty) + parseInt(data.d[i].Actual_Qty);
                        T_grossAmt = parseFloat(T_grossAmt) + parseFloat(data.d[i].grossAmt);
                        T_SGST = parseFloat(T_SGST) + parseFloat(data.d[i].SGST);
                        T_CGST = parseFloat(T_CGST) + parseFloat(data.d[i].CGST);
                        T_IGST = parseFloat(T_IGST) + parseFloat(data.d[i].IGST);
                        T_Amt = parseFloat(T_Amt) + parseFloat(data.d[i].Amt);
                        T_CourierCharges = parseFloat(T_CourierCharges) + parseFloat(data.d[i].CourierCharges);
                        T_netAmt = parseFloat(T_netAmt) + parseFloat(data.d[i].NetAmt);
                        T_BV = parseFloat(T_BV) + parseFloat(data.d[i].BV);
                        T_PV = parseFloat(T_PV) + parseFloat(data.d[i].PV);
                        var DStatus = '';
                        DStatus += '<select id="ddl_status' + srno + '" class="form-control" style="width: 100px">';
                        if (data.d[i].Del_Status == 0) {
                            DStatus += '<option value="0" selected>Pending</option><option value="1">Delivered</option><option value="2">Dispatched</option>'
                        } else if (data.d[i].Del_Status == 1) { DStatus += '<option value="0">Pending</option><option value="1" selected>Delivered</option><option value="2">Dispatched</option>' }
                        else if (data.d[i].Del_Status == 2) { DStatus += '<option value="0">Pending</option><option value="1">Delivered</option><option value="2" selected>Dispatched</option>'; }
                        else { DStatus += '<option value="-1" selected>Select</option><option value="0">Pending</option><option value="1">Delivered</option><option value="2">Dispatched</option>' }

                        DStatus += '</select>';
                       

                        json.push([i + 1,
                        data.d[i].Date,
                            Invoice,
                            data.d[i].BuyerUserId,
                            data.d[i].BuyerName,
                            data.d[i].BuyerState,
                            data.d[i].BuyerDistrict,
                            data.d[i].BuyerMobileNo,
                            '<div style="text-align:right;">' + data.d[i].grossAmt + '</div>',
                            '<div style="text-align:right;">' + data.d[i].SGST + '</div>',
                            '<div style="text-align:right;">' + data.d[i].CGST + '</div>',
                            '<div style="text-align:right;">' + data.d[i].IGST + '</div>',
                            '<div style="text-align:right;">' + data.d[i].Amt + '</div>',
                            '<div style="text-align:right;">' + data.d[i].CourierCharges + '</div>',
                            '<div style="text-align:right;">' + data.d[i].NetAmt + '</div>',
                            '<div style="text-align:right;">' + data.d[i].PV + '</div>',
                            data.d[i].PayMode,
                        data.d[i].SellerUserId,
                        data.d[i].SellerName,
                        data.d[i].SellerState,
                        data.d[i].SellerDistrict,
                        '<div style="text-align:center;">' + data.d[i].NoOFProduct + '</div>',
                        '<div style="text-align:center;">' + data.d[i].Actual_Qty + '</div>',
                        data.d[i].Subdistype,
                        data.d[i].status == "0" ? "<span style='color:red'>Cancelled </span>" : "Submit",
                        data.d[i].Del_Status == "0" ? "<span style='color:red'>Pending</span>" : "Delivered",
                            Invoice,
                        data.d[i].DispatchDate,
                            Transport,
                            Tracking,
                            EWay,
                            Remarks,
                            DStatus,
                            Deliver,
                            Upload_lr1,
                            Upload_lr2,
                            Packing,
                            Send_sms,
                        Send_Whats_sms + ' ' + IS_OPTIN,
                            data.d[i].status == "0" ? "<span style='color:red'>Cancelled </span>" : Action,
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
                            { title: "Date" },
                            { title: "Invoice No." },
                            { title: "Id" },
                            { title: "Name" },
                            { title: "State" },
                            { title: "District" },
                            { title: "Mobile" },
                            { title: "<%=method.DP%><br>Value" },
                            { title: "SGST" },
                            { title: "CGST" },
                            { title: "IGST" },
                            { title: "<%=method.DP%><br>with Tax" },
                            { title: "Courier" },
                            { title: "Invoice" },
                            //{ title: "PV" },
                            { title: "<%=method.PV%>" },
                            { title: "Payment<br>Mode" },
                            { title: "Seller Id" },
                            { title: "Seller Name" },
                            { title: "Seller State" },
                            { title: "Seller District" },
                            { title: "No of Prod" },
                            { title: "Billed Qty." },
                            { title: "Billing Type" },
                            { title: "Invoice Status" },
                            { title: "Dispatch Status" },
                            { title: "Invoice No." },
                            { title: "Dispatch Date" },
                            { title: "Transport" },
                            { title: "Tracking" },
                            { title: "E Way Bill" },
                            { title: "Remarks" },
                         { title: "Status" },
                            { title: "Deliver" },
                            { title: "Img LR1" },
                            { title: "Img LR1" },
                            { title: "Packing" },
                            { title: "SMS" },
                            { title: "Whatsapp" },
                            { title: "Action" },
                            { title: "Customer Type" },

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) {
                                return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0;
                            };

                            // Total over all pages
                            $(api.column(1).footer()).html('Total:');
                            
                            $(api.column(21).footer()).html(T_NoOFProduct.toFixed(0));
                            $(api.column(22).footer()).html(T_Actual_Qty.toFixed(0));
                            $(api.column(8).footer()).html(T_grossAmt.toFixed(2));
                            $(api.column(9).footer()).html(T_SGST.toFixed(2));
                            $(api.column(10).footer()).html(T_CGST.toFixed(2));
                            $(api.column(11).footer()).html(T_IGST.toFixed(2));

                            $(api.column(12).footer()).html(T_Amt.toFixed(2));
                            $(api.column(13).footer()).html(T_CourierCharges.toFixed(2));
                            $(api.column(14).footer()).html(T_netAmt.toFixed(2));
                            $(api.column(15).footer()).html(T_BV.toFixed(2));

                        }
                    });

                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }


        function Deliver_Invice(Invoice, srno) {
            var Transport = $('#txt_Transport' + srno).val();
            var Tracking = $('#txt_Tracking' + srno).val();
            var EWay = $('#txt_EWay' + srno).val();
            var Remarks = $('#txt_Remarks' + srno).val();
            var D_Status = $('#ddl_status' + srno).val();

            if (!confirm('Are you sure you want to dispatch？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/Dispatch_Inv',
                data: '{ Invoice: "' + Invoice + '", Transport: "' + Transport + '", Tracking: "' + Tracking + '", EWay: "' + EWay + '", Remarks: "' + Remarks + '", D_Status: "' + D_Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Deliver Updated Successfully");
                        BindTable();
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
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


        function Cancel_Invice(Invoice) {
            if (!confirm('Are you sure you want to cancel invoice？')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/Cancel_Invoice',
                data: '{Invoice: "' + Invoice + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Invoice Cancelled Successfully");
                        GetBinaryDownline()
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


    </script>


    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
    <script> var $JJ = $.noConflict(true); </script>
    <script type="text/javascript">


        function SendSms(SMSTYPE, srno, UserId, Name, Inv, Date, Docket, Transport, Mobile, Img_Lr1) {
            if (!confirm('Are you sure you want to send message？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/SendSms',
                data: '{SMSTYPE: "' + SMSTYPE + '", srno: "' + srno + '", UserId: "' + UserId + '", Name: "' + Name
                    + '", Inv: "' + Inv + '", Date: "' + Date + '", Docket: "' + Docket + '",Transport: "' + Transport
                    + '", Mobile: "' + Mobile + '", Img_Lr1: "' + Img_Lr1 + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Message Sent Successfully");
                        BindTable();
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }



        function UploadImg_lr1(srno) {
            var ImgName = "";
            var fileUpload = $JJ("#img_lr1" + srno).get(0);
            var files = fileUpload.files;
            var data = new FormData();
            var random = Math.floor(1000 + Math.random() * 9000);
            random = "b1" + random;
            for (var i = 0; i < files.length; i++) {
                //data.append(random + files[i].name, files[i]);
                //ImgName = random + files[i].name;
                var ext = files[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data.append(random + '.' + ext, files[i]);
                ImgName = random + '.' + ext;
            }
            var _URL = window.URL || window.webkitURL;
            $.ajax({
                url: "../FranchiseHandler.ashx",
                type: "POST",
                data: data,
                contentType: false,
                processData: false,
                success: function (result) {
                    $.ajax({
                        type: "POST",
                        url: pageUrl + '/UpdateImage',
                        data: '{IMGTYPE: "1", srno: "' + srno + '", ImgName: "' + ImgName + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == '1') {
                                alert("Image Updated Successfully");
                                BindTable();
                            } else {
                                alert(data.d);
                                return
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });


                },
                error: function (err) {
                    //alert(err.statusText)
                }
            });
        }



        function UploadImg_lr2(srno) {
            var ImgName = "";
            var fileUpload = $JJ("#img_lr2" + srno).get(0);
            var files = fileUpload.files;
            var data = new FormData();
            var random = Math.floor(1000 + Math.random() * 9000);
            random = "b2" + random;
            for (var i = 0; i < files.length; i++) {
                //data.append(random + files[i].name, files[i]);
                //ImgName = random + files[i].name;
                var ext = files[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data.append(random + '.' + ext, files[i]);
                ImgName = random + '.' + ext;
            }
            var _URL = window.URL || window.webkitURL;
            $.ajax({
                url: "../FranchiseHandler.ashx",
                type: "POST",
                data: data,
                contentType: false,
                processData: false,
                success: function (result) {
                    $.ajax({
                        type: "POST",
                        url: pageUrl + '/UpdateImage',
                        data: '{IMGTYPE: "2", srno: "' + srno + '", ImgName: "' + ImgName + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == '1') {
                                alert("Image Updated Successfully");
                                BindTable();
                            } else {
                                alert(data.d);
                                return
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                },
                error: function (err) {
                }
            });
        }
    </script>



    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }

        .dotBlue {
            height: 20px;
            width: 20px;
            background-color: #96DED1;
            display: inline-block;
            border-radius: 50%;
            text-align: center;
            padding: 1px;
        }
    </style>


</asp:Content>
