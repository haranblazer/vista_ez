<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="AddEditQuantity.aspx.cs" EnableEventValidation="false" Inherits="secretadmin_AddEditQuantity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto" runat="server" id="vendhead">Add Batch</h4>
    </div>

    <asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="updatepnl" runat="server">
        <ContentTemplate>

            <div class="col-lg-12 col-md-12">

                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label">
                        Select Product :<span style="color: Red">*</span>
                    </div>
                    <div class="col-sm-4">
                        <asp:DropDownList ID="ddlproductname" runat="server" CssClass="form-control"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlproductname_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2 control-label">
                        Batch No:<span style="color: Red">*</span>
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_BatchNo" runat="server" CssClass="form-control" AutoPostBack="true"
                            OnSelectedIndexChanged="ddl_BatchNo_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2 ">
                        <asp:TextBox ID="txtbatchno" runat="server" CssClass="form-control" placeholder="Enter Batch No." MaxLength="20"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix"></div>

                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label">
                        Size: 
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_Size" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>

                    <div class="col-sm-2 control-label">
                        <div id="div_variant" runat="server"></div>
                    </div>
                    <div class="col-sm-2 control-label">
                        Color: 
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_color" runat="server" CssClass="form-control" onchange="GetColor();">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2 control-label">
                        <div id="div_colorCode" runat="server"></div>
                    </div>
                </div>
                <div class="clearfix">
                </div>


                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label">
                        Mfg Doe: 
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-6" style="padding-right: 1px">
                        <asp:DropDownList ID="ddlmfgmonth" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="Jan">Jan</asp:ListItem>
                            <asp:ListItem Value="Feb">Feb</asp:ListItem>
                            <asp:ListItem Value="Mar">Mar</asp:ListItem>
                            <asp:ListItem Value="Apr">Apr</asp:ListItem>
                            <asp:ListItem Value="May">May</asp:ListItem>
                            <asp:ListItem Value="Jun">Jun</asp:ListItem>
                            <asp:ListItem Value="Jul">Jul</asp:ListItem>
                            <asp:ListItem Value="Aug">Aug</asp:ListItem>
                            <asp:ListItem Value="Sep">Sep</asp:ListItem>
                            <asp:ListItem Value="Oct">Oct</asp:ListItem>
                            <asp:ListItem Value="Nov">Nov</asp:ListItem>
                            <asp:ListItem Value="Dec">Dec</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-6" style="padding-left: 0px;">
                        <asp:DropDownList ID="ddlmfgyear" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2 control-label">
                        Expiry Date: 
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-6" style="padding-right: 1px">
                        <asp:DropDownList ID="ddl_ExpiryMonth" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="Jan">Jan</asp:ListItem>
                            <asp:ListItem Value="Feb">Feb</asp:ListItem>
                            <asp:ListItem Value="Mar">Mar</asp:ListItem>
                            <asp:ListItem Value="Apr">Apr</asp:ListItem>
                            <asp:ListItem Value="May">May</asp:ListItem>
                            <asp:ListItem Value="Jun">Jun</asp:ListItem>
                            <asp:ListItem Value="Jul">Jul</asp:ListItem>
                            <asp:ListItem Value="Aug">Aug</asp:ListItem>
                            <asp:ListItem Value="Sep">Sep</asp:ListItem>
                            <asp:ListItem Value="Oct">Oct</asp:ListItem>
                            <asp:ListItem Value="Nov">Nov</asp:ListItem>
                            <asp:ListItem Value="Dec">Dec</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-6" style="padding-left: 0px;">
                        <asp:DropDownList ID="ddl_ExpiryYear" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>

                </div>
                <div class="clearfix"></div>

                <hr />
                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label">
                        MRP:<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txt_MRP" runat="server" CssClass="form-control" placeholder="Enter MRP" MaxLength="10"
                            onchange="CalculateDP();" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>

                    <div class="col-sm-2 control-label">
                        Discount Value:<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txt_Disc_Perc_Val" runat="server" CssClass="form-control" placeholder="Discount Value" MaxLength="10"
                            onchange="CalculateDP();" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>

                    <div class="col-sm-2 control-label">
                        GST:<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:DropDownList ID="ddlGST" runat="server" CssClass="form-control" onchange="CalculateDP();">
                            <asp:ListItem Value="0">0</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="12">12</asp:ListItem>
                            <asp:ListItem Value="18">18</asp:ListItem>
                            <asp:ListItem Value="28">28</asp:ListItem>
                        </asp:DropDownList>
                    </div> 
                </div>
                <div class="clearfix"></div>

                <div class="form-group card-group-row row">

                    <div class="col-sm-2 control-label">
                        DP With GST:<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txtDPWithTax" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter DP With GST" Enabled="false"
                            onchange="CalculateDP();" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-sm-2 control-label">
                        Dp: 
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txtDP" runat="server" CssClass="form-control" placeholder="Enter DP" MaxLength="10" Enabled="false" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>


                    <div class="col-sm-2 control-label d-none">
                        PERC/FLAT
                    </div>
                    <div class="col-md-4 col-sm-4 d-none">
                        <asp:DropDownList ID="ddl_PERC_FLAT" runat="server" CssClass="form-control" onchange="return Calculation_BV_ON();">
                            <asp:ListItem Value="PERC">PERC(%)</asp:ListItem>
                            <asp:ListItem Value="FLAT">FLAT</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                </div>
                <div class="clearfix"></div>



                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label">
                        <%=method.Franchise%> With GST: <span style="color: Red">*</span>
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txt_DpStockWithTax" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter Franchise Sale With GST" Enabled="false"
                            onchange="CalculateDP();" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-sm-2 control-label">
                        <%=method.Franchise%>: 
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txt_DpStock" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter Franchise Sale" Enabled="false" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="form-group card-group-row row d-none">
                    <div class="col-sm-2 control-label">
                        Customer With GST: <span style="color: Red">*</span>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <asp:TextBox ID="txt_CustomerWithGST" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter Customer With GST" Enabled="false"
                            onchange="CalculateDP();" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-sm-2 control-label">
                        Customer Rate: 
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <asp:TextBox ID="txt_CustomerRate" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter Customer Rate"
                            Enabled="false" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="form-group card-group-row row d-none">
                    <div class="col-sm-2 control-label">
                        Company Rate With GST: <span style="color: Red">*</span>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <asp:TextBox ID="txt_CompanyRateWithGST" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter Com Rate With GST"
                            onchange="CalculateDP();" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-sm-2 control-label">
                        Company Rate: 
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <asp:TextBox ID="txt_CompanyRate" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter Company Rate" Enabled="false" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix"></div>


                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label">
                        PO Billing Rate: <span style="color: Red">*</span>
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txt_PORateWithGST" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter PO Rate With GST" Enabled="false"
                            onchange="CalculateDP();" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-sm-2 control-label">
                        PO DP Rate: 
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txt_PORate" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter PO Rate"
                            Enabled="false" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                </div>






                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label d-none">
                        Select <%=method.PV %> Mode
                    </div>
                    <div class="col-md-4 col-sm-4 d-none">
                        <asp:DropDownList ID="ddl_BV_ON" runat="server" CssClass="form-control" onchange="return Calculation_BV_ON();">
                            <asp:ListItem Value="DP">DP</asp:ListItem>
                            <asp:ListItem Value="MRP">MRP</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                </div>


                <div class="clearfix"></div>

                <div class="form-group card-group-row row">
                    <div class="col-sm-2 control-label d-none">
                        Enter <%=method.PV %>
                    </div>
                    <div class="col-md-4 col-sm-4 d-none">
                        <asp:TextBox ID="txt_BV_Value_Base" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter Net Value"
                            onkeypress="return onlyNos(event,this);" onchange="return Calculation_BV_ON();"></asp:TextBox>
                    </div>

                    <div class="col-sm-2 control-label">
                        <%=method.REPURCHASE_PV %> :
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <asp:TextBox ID="txtPV" runat="server" CssClass="form-control" MaxLength="10" placeholder="Repurchase Point"
                            onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-sm-2 control-label d-none">
                        <%=method.BINARY_PV %>  : 
                    </div>
                    <div class="col-md-4 col-sm-4 d-none">
                        <asp:TextBox ID="txtBV" runat="server" CssClass="form-control" MaxLength="10" placeholder="Binary Point" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>


                <div class="form-group card-group-row row d-none">
                    <div class="col-sm-2 control-label">
                        FPV :
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <asp:TextBox ID="txt_FPV" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter FPV" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-sm-2 control-label">
                        APV : 
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <asp:TextBox ID="txt_APV" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter APV" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                    </div>
                </div>


                <div class="form-group card-group-row row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-4 text-right pull-right">
                        <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-success"
                            OnClientClick="javascript:return Validation();" />
                    </div>
                    <div class="col-sm-2"></div>
                    <div class="col-sm-4 control-label text-right pull-right">
                        <a href="BatchList.aspx" class="btn btn-link">Product Batch List</a>
                    </div>


                </div>
                <div class="clearfix">
                </div>

            </div>

        </ContentTemplate>
    </asp:UpdatePanel>


    <script language="Javascript" type="text/javascript">

        function onlyNos(e, t) {
            if (window.event) {
                var charCode = window.event.keyCode;
            }
            else if (e) {
                var charCode = e.which;
            }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) {
                return false;
            }
            return true;
        }


        function CalculateDP() {
            //***************** DP Calculation
            var GST = $('#<%=ddlGST.ClientID%>').val();

            var MRP = $('#<%=txt_MRP.ClientID%>').val();
            MRP = parseFloat((MRP == '' || MRP == null || isNaN(parseFloat(MRP))) ? 0 : MRP);
            
            var DPWithTax = $('#<%=txtDPWithTax.ClientID%>').val();
            DPWithTax = parseFloat((DPWithTax == '' || DPWithTax == null || isNaN(parseFloat(DPWithTax))) ? 0 : DPWithTax);
            
            var Disc_Perc_Val = $('#<%=txt_Disc_Perc_Val.ClientID%>').val();
            Disc_Perc_Val = parseFloat((Disc_Perc_Val == '' || Disc_Perc_Val == null || isNaN(parseFloat(Disc_Perc_Val))) ? 0 : Disc_Perc_Val);

            if (parseFloat(Disc_Perc_Val) > 100) {
                Disc_Perc_Val = 100;
                $('#<%=txt_Disc_Perc_Val.ClientID%>').val(100);
                alert("Maximum Discount allowed 100%."); 
            }

            DPWithTax = (parseFloat(MRP) - (parseFloat(MRP) * Disc_Perc_Val / 100));

            $('#<%=txtDPWithTax.ClientID%>').val(DPWithTax);
            $('#<%=txt_DpStockWithTax.ClientID%>').val(DPWithTax); 
            $('#<%=txt_PORateWithGST.ClientID%>').val(DPWithTax);
           

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


            //***************** Franchise Calculation
            var DpStockWithTax = $('#<%=txt_DpStockWithTax.ClientID%>').val();
            DpStockWithTax = parseFloat((DpStockWithTax == '' || DpStockWithTax == null || isNaN(parseFloat(DpStockWithTax))) ? 0 : DpStockWithTax);
            if (parseFloat(DpStockWithTax) > 0 && parseInt(GST) > 0) {
                var DpStock = (DpStockWithTax * 100 / (parseInt(GST) + 100));
                $('#<%=txt_DpStock.ClientID%>').val(DpStock.toFixed(2));
            }
            else {
                if (parseFloat(DpStockWithTax) > 0) {
                    $('#<%=txt_DpStock.ClientID%>').val(DpStockWithTax);
                 } else {
                     $('#<%=txt_DpStock.ClientID%>').val(0);
                }
            }


            //***************** Company Calculation
            var CompanyRateWithGST = $('#<%=txt_CompanyRateWithGST.ClientID%>').val();
            CompanyRateWithGST = parseFloat((CompanyRateWithGST == '' || CompanyRateWithGST == null || isNaN(parseFloat(CompanyRateWithGST))) ? 0 : CompanyRateWithGST);
            if (parseFloat(CompanyRateWithGST) > 0 && parseInt(GST) > 0) {
                var DpStock = (CompanyRateWithGST * 100 / (parseInt(GST) + 100));
                $('#<%=txt_CompanyRate.ClientID%>').val(DpStock.toFixed(2));
            }
            else {
                if (parseFloat(CompanyRateWithGST) > 0) {
                    $('#<%=txt_CompanyRate.ClientID%>').val(CompanyRateWithGST);
                 } else {
                     $('#<%=txt_CompanyRate.ClientID%>').val(0);
                }
            }



            //***************** PO Calculation
            var PORateWithTax = $('#<%=txt_PORateWithGST.ClientID%>').val();
            PORateWithTax = parseFloat((PORateWithTax == '' || PORateWithTax == null || isNaN(parseFloat(PORateWithTax))) ? 0 : PORateWithTax);
            if (parseFloat(PORateWithTax) > 0 && parseInt(GST) > 0) {
                var PORate = (PORateWithTax * 100 / (parseInt(GST) + 100));
                $('#<%=txt_PORate.ClientID%>').val(PORate.toFixed(2));
            }
            else {
                if (parseFloat(PORateWithTax) > 0) {
                    $('#<%=txt_PORate.ClientID%>').val(PORateWithTax);
                 } else {
                     $('#<%=txt_PORate.ClientID%>').val(0);
                }
            }

            

            //***************** Customer Calculation
            var CustomerWithGST = $('#<%=txt_CustomerWithGST.ClientID%>').val();
            CustomerWithGST = parseFloat((CustomerWithGST == '' || CustomerWithGST == null || isNaN(parseFloat(CustomerWithGST))) ? 0 : CustomerWithGST);
            if (parseFloat(CustomerWithGST) > 0 && parseInt(GST) > 0) {
                var CustomerRate = (CustomerWithGST * 100 / (parseInt(GST) + 100));
                $('#<%=txt_CustomerRate.ClientID%>').val(CustomerRate.toFixed(2));
            }
            else {
                if (parseFloat(CustomerWithGST) > 0) {
                    $('#<%=txt_CustomerRate.ClientID%>').val(CustomerWithGST);
                 } else {
                     $('#<%=txt_CustomerRate.ClientID%>').val(0);
                }
            }
        }


        function CalculateStockDP() {
            var GST = $('#<%=ddlGST.ClientID%>').val();
        }


        function Validation() {
            var PID = $('#<%=ddlproductname.ClientID%>').val(),

                batchno = $('#<%=txtbatchno.ClientID%>').val(),
                mfgmonth = $('#<%=ddlmfgmonth.ClientID%>').val(),
                mfgyear = $('#<%=ddlmfgyear.ClientID%>').val(),

                ExpiryMonth = $('#<%=ddl_ExpiryMonth.ClientID%>').val(),
                ExpiryYear = $('#<%=ddl_ExpiryYear.ClientID%>').val(),

                MRP = $('#<%=txt_MRP.ClientID%>').val(),
                DPWithTax = $('#<%=txtDPWithTax.ClientID%>').val(),
                DP = $('#<%=txtDP.ClientID%>').val(),
                DpStockWithTax = $('#<%=txt_DpStockWithTax.ClientID%>').val(),
                CompanyRateWithGST = $('#<%=txt_CompanyRateWithGST.ClientID%>').val(),
                PORateWithGST = $('#<%=txt_PORateWithGST.ClientID%>').val();

            var MSG = "";
            if (PID == "0") {
                MSG += "\n Please Select Product.!";
            }

            if (batchno == "") {
                MSG += "\n Please Enter Batch No.!";
            }
            //if (mfgmonth == "0") {
            //    MSG += "\n Please Select Mfg Month.!";
            //}
            //if (mfgyear == "0") {
            //    MSG += "\n Please Select Mfg Year.";
            //}
            //if (ExpiryMonth == "0") {
            //    MSG += "\n Please Select Expiry Month.!";
            //}
            //if (ExpiryYear == "0") {
            //    MSG += "\n Please Select Expiry Year.!";
            //}

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


        function GetColor() {
            $.ajax({
                type: "POST",
                url: 'AddEditQuantity.aspx/GetColor',
                data: "{'CLRId':'" + $("#<%=ddl_color.ClientID%>").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#<%=div_colorCode.ClientID%>").css({ "height": "20px", "width": "20px", "background-color": response.d, "display": "inline-block", "border-radius": "50%" });
                },
                failure: function (response) { }
            });
        }
    </script>
</asp:Content>
