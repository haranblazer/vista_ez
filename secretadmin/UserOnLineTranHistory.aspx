<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="UserOnLineTranHistory.aspx.cs" Inherits="secretadmin_UserOnLineTranHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {

            $('#<%=txtFromDate.ClientID%>').datepick({ maxDate: '0', dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ maxDate: '0', dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtDispatchDate.ClientID %>').datepick({ maxDate: '0', dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <script type="text/javascript">
        function ValidateDispatch() {
            var ddlCollect = document.getElementById("<%=ddlOrderStatus.ClientID%>");
            var selectedvalue = ddlCollect.options[ddlCollect.selectedIndex].value;

            if (selectedvalue == '0') {
                document.getElementById("<%=txtCourierName.ClientID%>").disabled = true;
                document.getElementById("<%=txtDocketNumer.ClientID%>").disabled = true;
                document.getElementById("<%=txtDispatchDate.ClientID%>").disabled = true;
                document.getElementById("<%=txtDesc.ClientID %>").disabled = true;
                alert("Please Select Collect Type.");
                return false;
            }
            if (selectedvalue == '1') {
                document.getElementById("<%=txtCourierName.ClientID%>").disabled = true;
                document.getElementById("<%=txtDocketNumer.ClientID%>").disabled = true;
                document.getElementById("<%=txtDispatchDate.ClientID%>").disabled = true;
                document.getElementById("<%=txtDesc.ClientID %>").disabled = true;
            }
            if (selectedvalue == '2') {
                document.getElementById("<%=txtCourierName.ClientID%>").disabled = false;
                document.getElementById("<%=txtDocketNumer.ClientID%>").disabled = false;
                document.getElementById("<%=txtDispatchDate.ClientID%>").disabled = false;
                document.getElementById("<%=txtDesc.ClientID %>").disabled = false;
            }
        }
    </script>
    <script type="text/javascript">
        function ValidateOnSubmit() {
            var ddlCollect = document.getElementById("<%=ddlOrderStatus.ClientID%>");
            var selectedvalue = ddlCollect.options[ddlCollect.selectedIndex].value;
            var chk = document.getElementById('<%=chkIsDispatch.ClientID%>').checked;


            var CourierCName = document.getElementById("<%=txtCourierName.ClientID%>").value;
            var DocketNo = document.getElementById("<%=txtDocketNumer.ClientID%>").value;
            var DispatchDate = document.getElementById("<%=txtDispatchDate.ClientID%>").value;
            var desc = document.getElementById("<%=txtDesc.ClientID %>").value;

            if (selectedvalue == '0') {
                alert("Please Select Collect Type.");
                return false;
            }
            if (selectedvalue == '1') {
                if (chk == false) {
                    alert("Please Select Dispatch.");
                    document.getElementById('<%=chkIsDispatch.ClientID%>').focus();
                    return false;
                }
            }
            if (selectedvalue == '2') {

                if (desc == '') {
                    alert("Please Enter Description.");
                    return false;
                }

                if (CourierCName == '') {
                    alert("Please Enter Courier Name.");
                    return false;
                }
                if (DocketNo == '') {
                    alert("Please Enter Docket No.");
                    return false;
                }
                if (DispatchDate == '') {
                    alert("Please Enter Dispatch Date.");
                    return false;
                }
                if (chk == false) {
                    alert("Please Select Dispatch.");
                    return false;
                }
            }
        }
    </script>
    <script type="text/javascript" charset="utf-8">
        function ConfirmSubmit() {
            if (confirm("Are you sure want to proceed for payment?")) {
                return true;
            }
            return false;
        }
    </script>
    <div class="col-sm-12">
        <h2 class="head">
            <i class="fa fa-history" aria-hidden="true"></i>&nbsp;Transaction History</h2>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-1">
                From
            </div>
            <div class="col-sm-2">
                <div class="input-group">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"
                        autocomplete="off" placeholder="DD/MM/YYYY" ToolTip="DD/MM/YYYY"></asp:TextBox>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-sm-1">
                To
            </div>
            <div class="col-sm-2">
                <div class="input-group">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"
                        autocomplete="off" placeholder="DD/MM/YYYY" ToolTip="DD/MM/YYYY"></asp:TextBox>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-sm-2">
                <asp:TextBox ID="txtUserSearch" runat="server" CssClass="form-control" placeholder="Search By User Id"
                    ToolTip="Search By User Id"></asp:TextBox>
            </div>
            <div class="col-sm-1">
                <strong><span style="font-size: 10pt; font-family: Verdana">Status</span></strong>
            </div>
            <div class="col-sm-2">
                <asp:DropDownList ID="ddlTranType" runat="server" CssClass="form-control">
                    <asp:ListItem Value="-1">All</asp:ListItem>
                    <asp:ListItem Value="1">Success</asp:ListItem>
                    <asp:ListItem Value="2">Failed</asp:ListItem>
                    <asp:ListItem Value="0">Pending</asp:ListItem>
                </asp:DropDownList>
                <div class="clearfix">
                </div>
                <br />
            </div>
            <div class="col-sm-1">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"
                    OnClick="btnSearch_Click" />
            </div>
        </div>
        <div class="form-group">
            <p>
                <span class="badge badge-primary" style="background-color: #f4fef4; border: 1px solid #333;
                    color: #333; font-size: small">Success &nbsp;</span> <span style="background-color: #FCFFF0;
                        border: 1px solid #333; color: #333; font-size: small" class="badge badge-primary">
                        Pending&nbsp;</span> <span style="background-color: #ffcccc; border: 1px solid #333;
                            color: #333; font-size: small" class="badge badge-primary">Failed&nbsp;</span>
            </p>
        </div>
        <div class="table-responsive">
            <asp:GridView ID="POTranHistoryOnline" EmptyDataText="No Record Found." CssClass="table table-striped table-hover mygrd"
                runat="server" AllowPaging="true" AutoGenerateColumns="false" PageSize="25" OnPageIndexChanging="POTranHistoryOnline_PageIndexChanging"
                OnRowDataBound="POTranHistoryOnline_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User ID">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Visible="false" Text='<%#Eval("srno") %>'></asp:Label>
                            <asp:Label ID="lblUID" runat="server" Text='<%#Eval("appmstid") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Invoice No.">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkGetInvoice" runat="server" 
                                OnClick="lnkGetInvoice_Click">  <%#Eval("InvoiceNo")%> </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="name" HeaderText="Name" />
                    <asp:BoundField DataField="mobile" HeaderText="Mobile" />
                    <asp:TemplateField HeaderText="Product Details">
                        <ItemTemplate>
                            <%-- Bind The Product Detail(s)--%>
                            <span id="tblPrd">
                                <%#Eval("tbl") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="amount" HeaderText="Amount" />
                    <asp:BoundField DataField="paymentstatus" HeaderText="Status" />
                    <asp:BoundField DataField="doe" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy}" />
                    
                   <%-- <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkGetInvoice" runat="server" CssClass="btn btn-success btn-xs"
                                OnClick="lnkGetInvoice_Click"><i class="fa fa-print"></i>&nbsp;Invoice</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDispatchProduct" runat="server" CssClass="btn btn-success btn-xs"
                                OnClick="lnkDispatchProduct_Click"><i class="fa fa-cubes" aria-hidden="true"></i>&nbsp;Dispatch</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div runat="server" id="dialog" class="col-sm-offset-1 col-sm-10 col-sm-offset-1 modal-content"
            style="position: absolute; z-index: 999; width: 750px; top: 15%; left: 20%;"
            visible="false">
            <div class="head">
                <strong><i class="fa fa-truck" aria-hidden="true"></i>&nbsp;Dispatch Details</strong>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-3">
                    User ID</div>
                <div class="col-sm-8">
                    <strong>
                        <asp:Label ID="lblUserID" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lbsrno" runat="server" Text="" Visible="false"></asp:Label>
                    </strong>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-3">
                    Collect Type</div>
                <div class="col-sm-8">
                    <asp:DropDownList ID="ddlOrderStatus" onchange="return ValidateDispatch();" runat="server"
                        CssClass="form-control">
                        <asp:ListItem Value="0" Selected="True">--Select--</asp:ListItem>
                        <asp:ListItem Value="1">Self Collect</asp:ListItem>
                        <asp:ListItem Value="2">Courier Dispatch</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-3">
                    Description</div>
                <div class="col-sm-8">
                    <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" placeholder="Enter Description"></asp:TextBox></div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-3">
                    Courier Company</div>
                <div class="col-sm-8">
                    <asp:TextBox ID="txtCourierName" runat="server" CssClass="form-control" placeholder="Enter Courier Company"></asp:TextBox></div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-3">
                    Docket Number</div>
                <div class="col-sm-8">
                    <asp:TextBox ID="txtDocketNumer" runat="server" CssClass="form-control" placeholder="Enter Docket Number"></asp:TextBox></div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-3">
                    Dispatch Date
                </div>
                <div class="col-sm-8">
                    <asp:TextBox ID="txtDispatchDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                        ToolTip="DD/MM/YYYY" /></div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-3">
                </div>
                <div class="col-sm-8">
                    <asp:CheckBox ID="chkIsDispatch" runat="server" />&nbsp;Delivered</div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-3">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success"
                        OnClick="btnSubmit_Click" OnClientClick="return ValidateOnSubmit();" />&nbsp;
                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-success"
                        OnClick="btnClose_Click" />
                </div>
                <div class="clearfix">
                </div>
                <br />
            </div>
        </div>
    </div>
</asp:Content>
