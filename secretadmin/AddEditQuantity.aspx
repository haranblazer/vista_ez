<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AddEditQuantity.aspx.cs" Inherits="secretadmin_AddEditQuantity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="Javascript" type="text/javascript">

        function onlyNos(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                }
                else if (e) {
                    var charCode = e.which;
                }
                else { return true; }
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            }
            catch (err) {
                alert(err.Description);
            }
        }


        function CalculateDP() {
            var GST = $('#<%=ddlGST.ClientID%>').val();
            var DPWithTax = $('#<%=txtDPWithTax.ClientID%>').val();
            DPWithTax = parseFloat((DPWithTax == '' || DPWithTax == null || isNaN(parseFloat(DPWithTax))) ? 0 : DPWithTax);
            if (parseFloat(DPWithTax) > 0 && parseInt(GST) > 0) {
                var DP = (DPWithTax * 100 / (parseInt(GST) + 100));
                $('#<%=txtDP.ClientID%>').val(DP.toFixed(2));
            }
            else {
                if (parseFloat(DPWithTax) > 0) {
                    $('#<%=txtDP.ClientID%>').val(DPWithTax);
                } else {
                    $('#<%=txtDP.ClientID%>').val(0);
                }
            }
        }



        function Validation() {
            var PID = $('#<%=ddlproductname.ClientID%>').val(),
                Add_Subs = $('#<%=ddltype.ClientID%>').val(),
                Qty = $('#<%=txtqty.ClientID%>').val(),
                batchno = $('#<%=txtbatchno.ClientID%>').val(),
                mfgmonth = $('#<%=ddlmfgmonth.ClientID%>').val(),
                mfgyear = $('#<%=ddlmfgyear.ClientID%>').val(),

                MRP = $('#<%=txt_MRP.ClientID%>').val(),
                DPWithTax = $('#<%=txtDPWithTax.ClientID%>').val(),
                DP = $('#<%=txtDP.ClientID%>').val();

            var MSG = "";
            if (PID == "0") {
                MSG += "\n Please Select Product.!";
            }
            if (Add_Subs == "0") {
                MSG += "\n Please Select Mode.!";
            }
            if (Qty == "0" || Qty == "") {
                MSG += "\n Please Enter update Quantity.!";
            }
            if (batchno == "") {
                MSG += "\n Please Enter Batch No.!";
            }
            if (mfgmonth == "0") {
                MSG += "\n Please Select Mfg Date.!";
            }
            if (mfgyear == "0") {
                MSG += "\n Please Select Mfg Date.";
            }

            if (MRP == "0" || MRP == "") {
                MSG += "\n Please Enter MRP.!";
            }
            if (DPWithTax == "0" || DPWithTax == "") {
                MSG += "\n Please Enter DP With GST.!";
            }


            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to save your details.？')) {
                return false;
            }
        }



    </script>


    <h2 class="head">
        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;Update Quantity</h2>
    <div class="panel panel-default">
        <div class="col-md-12">
            <br />
            <div class="row">

                <asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="updatepnl" runat="server">
                    <ContentTemplate>
                        <div class="col-lg-12 col-md-12">

                            <div class="form-group">
                                <div class="col-sm-2">
                                    Select Product :<span style="color: Red">*</span>
                                </div>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlproductname" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlproductname_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    Mfg Doe:<span style="color: Red">*</span>
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-6" style="padding-right: 1px">
                                    <asp:DropDownList ID="ddlmfgmonth" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                        <asp:ListItem>Jan</asp:ListItem>
                                        <asp:ListItem>Feb</asp:ListItem>
                                        <asp:ListItem>March</asp:ListItem>
                                        <asp:ListItem>April</asp:ListItem>
                                        <asp:ListItem>May</asp:ListItem>
                                        <asp:ListItem>June</asp:ListItem>
                                        <asp:ListItem>July</asp:ListItem>
                                        <asp:ListItem>August</asp:ListItem>
                                        <asp:ListItem>Sep</asp:ListItem>
                                        <asp:ListItem>Oct</asp:ListItem>
                                        <asp:ListItem>Nov</asp:ListItem>
                                        <asp:ListItem>Dec</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-6" style="padding-left: 0px;">
                                    <asp:DropDownList ID="ddlmfgyear" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>

                            </div>
                            <div class="clearfix">
                            </div>
                            <br />

                            <div class="form-group">
                                <div class="col-sm-2">
                                    Batch No:<span style="color: Red">*</span>
                                </div>
                                <div class="col-sm-2">
                                    <asp:DropDownList ID="ddl_BatchNo" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_BatchNo_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txtbatchno" runat="server" CssClass="form-control" placeholder="Enter Batch No." MaxLength="20"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    update Quantity:<span style="color: Red">*</span>
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-6" style="padding-right: 1px">
                                    <asp:DropDownList ID="ddltype" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="11">Increase/Add</asp:ListItem>
                                        <asp:ListItem Value="12">Decrease</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-6" style="padding-left: 0px;">
                                    <asp:TextBox ID="txtqty" runat="server" CssClass="form-control" placeholder="Enter Quantity" MaxLength="10" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                                </div>

                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                            <hr />
                            <div class="form-group">
                                <div class="col-sm-2">
                                    MRP:<span style="color: Red">*</span>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <asp:TextBox ID="txt_MRP" runat="server" CssClass="form-control" placeholder="Enter MRP" MaxLength="10" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                                </div>

                                <div class="col-sm-2">
                                    GST:<span style="color: Red">*</span>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <asp:DropDownList ID="ddlGST" runat="server" CssClass="form-control" onchange="CalculateDP();">
                                        <asp:ListItem>0</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                        <asp:ListItem>12</asp:ListItem>
                                        <asp:ListItem>18</asp:ListItem>
                                        <asp:ListItem>28</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>


                            <div class="clearfix">
                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-2">
                                    DP With GST:<span style="color: Red">*</span>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <asp:TextBox ID="txtDPWithTax" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter DP With GST" onchange="CalculateDP();" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                                </div>

                                <div class="col-sm-2">
                                    Dp: 
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <asp:TextBox ID="txtDP" runat="server" CssClass="form-control" placeholder="Enter DP" MaxLength="10" Enabled="false" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />

                            <div class="form-group">
                                <div class="col-sm-2">
                                    PV: 
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <asp:TextBox ID="txtPV" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter PV" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    BV: 
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <asp:TextBox ID="txtBV" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter BV" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />

                               

                            <div class="form-group">
                                <div class="col-sm-2">
                                </div>
                                <div class="col-sm-2">
                                    <a href="BatchList.aspx" class="btn btn-link">Product Batch List</a>
                                </div>
                                <div class="col-sm-2 text-right">
                                    <asp:Label id="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                                    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-success"
                                        OnClientClick="javascript:return Validation();" />
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

        </div>
        <div class="clearfix"></div>
    </div>



</asp:Content>
