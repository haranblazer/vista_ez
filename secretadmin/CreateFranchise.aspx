<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="CreateFranchise.aspx.cs" Inherits="CreateFranchise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>


    <script language="javascript" type="text/javascript">
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function Bind_MinMntStock() {
            var FranType = $('#<%=ddltype.ClientID%>').val();
               if (window.location.search.split('?').length > 1) {
                   FranType = 0;
               }
               else {
                   if (FranType == "3") {
                       $('#<%=txt_MinStkAmt.ClientID%>').val(2500000);
                }
                else if (FranType == "4") {
                    $('#<%=txt_MinStkAmt.ClientID%>').val(1000000);
                }
                else if (FranType == "5") {
                    $('#<%=txt_MinStkAmt.ClientID%>').val(50000);
                }
                else {
                    $('#<%=txt_MinStkAmt.ClientID%>').val(0);
                }
            }
        }
        function GetUserName() {

            var FranType = $('#<%=ddltype.ClientID%>').val();
            var fMappingId = $('#<%=txt_fMappingId.ClientID%>').val();

            if (FranType == "0") {
                $('#lbl_fMappingId').text("Please Select Franchise Type.!!");
                return false;
            }
            if (fMappingId == "") {
                $('#lbl_fMappingId').text("Please Enter Franchise Mapping Id.!!");
                return false;
            }
            $('#lbl_fMappingId').text("");
            $.ajax({
                type: "POST",
                url: 'CreateFranchise.aspx/GetUser',
                data: '{fMappingId: "' + fMappingId + '", FranType: "' + FranType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#lbl_fMappingId').text(data.d.UserName);
                        $('#lbl_fMappingId').css('color', 'Blue');
                    }
                    else {
                        $('#<%=txt_fMappingId.ClientID%>').val('');
                        $('#lbl_fMappingId').text(data.d.Error);
                        $('#lbl_fMappingId').css('color', 'red');
                    }
                },
                error: function (response) {
                    $('#lbl_fMappingId').text("Server error. Time out.!!");
                    $('#lbl_fMappingId').css('color', 'red');
                }
            });
        }



        function GetLeaderName() {
            var LeaderId = $('#<%=txt_LeaderId.ClientID%>').val();
               if (LeaderId == "") {
                   alert("Please Enter LeaderId.!!");
                   return false;
               }
               $.ajax({
                   type: "POST",
                   url: 'CreateFranchise.aspx/GetLeaderName',
                   data: '{LeaderId: "' + LeaderId + '"}',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (data) {
                       if (data.d.Error == "") {
                           $('#<%=txt_LeaderName.ClientID%>').val(data.d.UserName); 
                       }
                       else {
                           alert(data.d.Error);
                           $('#<%=txt_LeaderName.ClientID%>').val("");
                           $('#<%=txt_LeaderId.ClientID%>').val("");
                    }
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });
        }





    </script>
    <script language="javascript" type="text/javascript">
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function Bind_MinMntStock() {
            var FranType = $('#<%=ddltype.ClientID%>').val();
            if (window.location.search.split('?').length > 1) {
                FranType = 0;
            }
            else {
                if (FranType == "3") {
                    $('#<%=txt_MinStkAmt.ClientID%>').val(2500000);
                }
                else if (FranType == "4") {
                    $('#<%=txt_MinStkAmt.ClientID%>').val(1000000);
                }
                else if (FranType == "5") {
                    $('#<%=txt_MinStkAmt.ClientID%>').val(50000);
                }
                else {
                    $('#<%=txt_MinStkAmt.ClientID%>').val(0);
                }
            }
        }
        function GetUserName() {

            var FranType = $('#<%=ddltype.ClientID%>').val();
            var fMappingId = $('#<%=txt_fMappingId.ClientID%>').val();

            if (FranType == "0") {
                $('#lbl_fMappingId').text("Please Select Franchise Type.!!");
                return false;
            }
            if (fMappingId == "") {
                $('#lbl_fMappingId').text("Please Enter Franchise Mapping Id.!!");
                return false;
            }
            $('#lbl_fMappingId').text("");
            $.ajax({
                type: "POST",
                url: 'CreateFranchise.aspx/GetUser',
                data: '{fMappingId: "' + fMappingId + '", FranType: "' + FranType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#lbl_fMappingId').text(data.d.UserName);
                        $('#lbl_fMappingId').css('color', 'Blue');
                    }
                    else {
                        $('#<%=txt_fMappingId.ClientID%>').val('');
                        $('#lbl_fMappingId').text(data.d.Error);
                        $('#lbl_fMappingId').css('color', 'red');
                    }
                },
                error: function (response) {
                    $('#lbl_fMappingId').text("Server error. Time out.!!");
                    $('#lbl_fMappingId').css('color', 'red');
                }
            });
        }
    </script>

    <style type="text/css">
        .form-group {
            margin-bottom: 0px;
        }

        .style2 {
            width: 238px;
            height: 188px;
        }

        .style6 {
            height: 188px;
        }

        .style7 {
            color: #FF0066;
        }

        .style8 {
            color: #FF3300;
        }

        .style9 {
            color: #FF0000;
        }

        .panel-body {
            padding: 5px;
        }

        .head {
            font-size: 13px;
            padding: 7px;
            background: #f3f3f3;
            color: #000;
            margin-bottom: 0;
        }

        .panel-default {
            border-color: #ffffff;
        }
    </style>


    <div class="panel panel-default">
        <div class="col-md-12">
            <div class="clearfix"></div>

            <%--<asp:Panel ID="PnlConfirmation" DefaultButton="btnConfirm" runat="server" Visible="false"
                Style="background-color: rgb(239,249,200); color: black; border-radius: 5px;">
                <div class="Title">
                    <h2 class="head">Confirmation</h2>
                </div>
                <div class="clearfix">
                </div>

                <div class="row">
                    <div class="col-sm-2">
                        Franchise Type :
                    </div>
                    <div class="col-sm-4 ">
                        <asp:Label class="txt2" ID="lblFranType" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>

                <div class="row">
                    <div class="col-sm-2">
                        Franchise Sponsor Id :
                    </div>
                    <div class="col-sm-4 ">
                        <asp:Label class="txt2" ID="lblFranSponId" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>

                <div class="form-group" style="display: none;">
                    <div class="col-sm-2">
                        Sponsor Name :
                    </div>
                    <div class="col-sm-4">
                        <asp:Label class="txt2" ID="lblFranSponName" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="row">
                    <div class="col-sm-2">
                        Franchise Name :
                    </div>
                    <div class="col-sm-4">
                        <asp:Label class="txt2" ID="lblFranName" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="row">
                    <div class="col-sm-2">
                        Mobile No :
                    </div>
                    <div class="col-sm-4">
                        <asp:Label class="txt2" ID="lblMobileNo" runat="server" Text=""></asp:Label>

                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="row">
                    <div class="col-sm-2">
                        Email Id :
                    </div>
                    <div class="col-sm-4">
                        <asp:Label class="txt2" ID="lblEmail" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="form-group">
                    <div class="col-sm-2">
                        User Id :
                    </div>
                    <div class="col-sm-4">
                        <asp:Label class="txt2" ID="lblUserID" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="form-group">
                    <div class="col-sm-2">
                        Password :
                    </div>
                    <div class="col-sm-4">
                        <asp:Label class="txt2" ID="lblpassword" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="form-group">
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-4">
                        <asp:Button ID="btnConfirm" runat="server" CausesValidation="true" CssClass="btn btn-success"
                            Text="Confirm" OnClick="btnConfirm_Click" />
                        &nbsp;
                                    <asp:Button ID="btnEdit" runat="server" CausesValidation="true" CssClass="btn btn-success"
                                        Text="Edit" OnClick="btnEdit_Click" />
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
            </asp:Panel>--%>

            <asp:Panel ID="CreateFran" DefaultButton="btnSubmit" runat="server">
                <div style="padding-top: 0px;">
                    <div class="IP_Addres">
                        <%-- Your current IP address --%>
                        <h2 class="head">
                            <i class="fa fa-podcast" aria-hidden="true"></i>&nbsp;Create Franchise</h2>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="col-sm-12" style="margin: 0px; padding: 0px;">
                        <div class="form-horizontal text-center" style="margin: 0px; padding: 0px;">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <div class="col-sm-12 ">
                                            <asp:Label ID="lbl_Success" runat="server" ForeColor="Green"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-horizontal" style="margin: 0px; padding: 0px;">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-2 control-label" style="text-align: left">
                                            Franchise Type:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4 ">
                                            <asp:DropDownList ID="ddltype" runat="server" TabIndex="1" CssClass="form-control" onchange="Bind_MinMntStock()">
                                            </asp:DropDownList>

                                        </div>

                                        <label class="col-sm-2  control-label" style="text-align: left">
                                            Franchise Mapping Id:
                                        </label>
                                        <div class="col-sm-4 ">

                                            <asp:TextBox ID="txt_fMappingId" runat="server" MaxLength="20" CssClass="form-control"
                                                placeholder="Enter Franchise Mapping Id" onchange="GetUserName();"></asp:TextBox>
                                            <span id="lbl_fMappingId"></span>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-horizontal">
                            <div class="panel panel-default">
                                <h2 class="head" style="margin-top: -5px;">
                                    <i class="fa fa-address-book-o" aria-hidden="true"></i>&nbsp;Franchise Personal
                                    Details
                                </h2>
                                <div class="panel-body">
                                    <div class="clearfix">
                                    </div>

                                    <div class="row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            SponsorId:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:UpdatePanel ID="UpdatePanelFran" runat="server">
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="txtsponsorid" EventName="TextChanged" />
                                                </Triggers>
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtsponsorid" runat="server" MaxLength="10" TabIndex="2" CssClass="form-control"
                                                        placeholder="Enter Franchise Sponsor ID" AutoPostBack="true" OnTextChanged="txtsponsorid_TextChanged"></asp:TextBox>
                                                    <asp:Label ID="lblFranSpon" runat="server"></asp:Label>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>

                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            LeaderId:
                                        </label>
                                        <div class="col-sm-2">
                                            <asp:TextBox ID="txt_LeaderId" runat="server" MaxLength="50" TabIndex="2" CssClass="form-control"
                                                placeholder="Enter LeaderId" onchange="GetLeaderName();"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-2">
                                            <asp:TextBox ID="txt_LeaderName" runat="server" MaxLength="50" TabIndex="2" CssClass="form-control"
                                                placeholder="LeaderName" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>

                                    <div class="row">

                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Franchise Name:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtName" class="searchbox" runat="server" TabIndex="3" CssClass="form-control"
                                                placeholder="Enter Your Name"></asp:TextBox>
                                        </div>

                                        <label class="col-sm-2 control-label" style="text-align: left;">
                                            Contact Person:
                                        </label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtContactPerson" runat="server" TabIndex="10" CssClass="form-control"
                                                placeholder="Enter Contact Person Name"></asp:TextBox>

                                        </div>


                                        <%--  <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label"
                                            style="text-align: left;">
                                            User ID:<span style="color: Red"></span></label>
                                        <div class="col-sm-4 col-xs-9">
                                            <asp:TextBox ID="txtUserName" Enabled="false" runat="server" TabIndex="11" CssClass="form-control"
                                                placeholder="Enter User ID" ToolTip="Default Create User Id " onchange="return CallVal(this);"></asp:TextBox>
                                            <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
                                        </div>--%>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Mobile No:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" TabIndex="4" CssClass="form-control"
                                                placeholder="Enter 10 Digits Mobile No"></asp:TextBox>
                                            <div style="background: #c3ffca; padding: 4px; border-radius: 10px;">
                                                <asp:CheckBox ID="CheckBox2" runat="server" />
                                                <span class="txt">Allow Notifications on
                                                    <img src="images/whatsapp-2.png" style="width: 25px; margin-top: -2px;">
                                                    whatsapp <%-- <a class="txt" href="terms-and-condition.aspx" target="_blank"
                                            style="color: #551e00; text-align: justify;"></a>--%></span>


                                            </div>
                                            <p style="font-size: 12px;">We respect privacy and your information is secure with us</p>
                                        </div>
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            E-Mail Id:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtEMailId" runat="server" TabIndex="5" CssClass="form-control"
                                                placeholder="Enter E-mail Id"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2  control-label"
                                            style="text-align: left">
                                            Address:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" TabIndex="8" CssClass="form-control"
                                                placeholder="Enter Address"></asp:TextBox>
                                        </div>
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            State:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" TabIndex="6"
                                                OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            District:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4">
                                            <asp:UpdatePanel ID="UpdateDistrictPanel" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" TabIndex="7">
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlState" EventName="SelectedIndexChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            City:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtCity" runat="server" TabIndex="8" CssClass="form-control" placeholder="Enter City"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2  control-label"
                                            style="text-align: left">
                                            Pin Code:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtPinCode" runat="server" MaxLength="6" TabIndex="9" CssClass="form-control"
                                                placeholder="Enter Pin Code"></asp:TextBox>
                                        </div>
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            CIN No:</label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtCinNo" class="searchbox" runat="server" TabIndex="13" CssClass="form-control"
                                                placeholder="Enter CIN No"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-2 control-label" style="text-align: left">Pan No: </label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtPanNo" class="searchbox" runat="server" TabIndex="12" CssClass="form-control"
                                                placeholder="Enter PAN No"></asp:TextBox>
                                        </div>

                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Sample Allowed:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4 control-label">
                                            <asp:RadioButtonList ID="rblsampleal" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>

                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            GST No: 
                                        </label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtGSTNo" class="searchbox" runat="server" TabIndex="14" CssClass="form-control"
                                                placeholder="Enter GST No"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-2" style="text-align: left">
                                            Opening Amount
                                        </label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txt_OpeningAmount" class="searchbox" runat="server" TabIndex="14" CssClass="form-control"
                                                onKeyPress="return onlyNumbers(this);" placeholder="Enter Opening Amount" MaxLength="20">0</asp:TextBox>
                                        </div>

                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Min Stock Maintenance amount
                                        </label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txt_MinStkAmt" class="searchbox" runat="server" TabIndex="15" CssClass="form-control"
                                                onKeyPress="return onlyNumbers(this);" placeholder="Enter Min Stock Maintenance amount" MaxLength="20">0</asp:TextBox>
                                        </div>
                                        <label class="col-sm-2" style="text-align: left">
                                        </label>
                                        <div class="col-sm-4">
                                        </div>

                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group" style="display: none;">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Franchise Limit:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtflimit" class="searchbox" runat="server" TabIndex="14" CssClass="form-control"
                                                onKeyPress="return onlyNumbers(this);" placeholder="Enter Franchise limit" MaxLength="7">0</asp:TextBox>
                                        </div>
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Franchise Commission:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtfcom" class="searchbox" runat="server" TabIndex="14" CssClass="form-control"
                                                onKeyPress="return onlyNumbers(this);" placeholder="Enter Franchise commission"
                                                MaxLength="2">0</asp:TextBox>
                                            <label class="col-sm-5  control-label"
                                                style="text-align: left">
                                                <span style="color: Red">* Up to 99 %</span></label>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-horizontal">
                            <div class="panel panel-default">
                                <div class="head">
                                    <i class="fa fa-university"></i>&nbsp;Bank Details
                                </div>
                                <div class="panel-body">
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Bank Name:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlbankname" runat="server" CausesValidation="True" CssClass="form-control"
                                                ValidationGroup="C">
                                            </asp:DropDownList>
                                        </div>
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Branch:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtbranch" runat="server" CausesValidation="True" CssClass="form-control"
                                                placeholder="Branch" MaxLength="50" ValidationGroup="C"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            A/C:<span style="color: Red">*</span></label>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtaccountno" runat="server" ValidationGroup="C" CssClass="form-control"
                                                placeholder="Account Number" MaxLength="20" CausesValidation="True"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" SetFocusOnError="true"
                                                ErrorMessage="please Enter Account No Maximum 20 Alphanumeric Values are allowed in Account Number"
                                                Display="None" ValidationExpression="^[a-zA-Z0-9]{1,20}$" ControlToValidate="txtaccountno"
                                                ForeColor="#CC0000" ValidationGroup="cp"> please Enter Account No Maximum 20 Alphanumeric values are allowed in Account Number</asp:RegularExpressionValidator>
                                        </div>
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            A/C Type:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlactype" runat="server" CssClass="form-control">

                                                <asp:ListItem>CURRENT A/C</asp:ListItem>
                                                <asp:ListItem>SAVING A/C</asp:ListItem>
                                                <asp:ListItem>OD A/C</asp:ListItem>
                                                <asp:ListItem>CC A/C</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            IFSC:<span style="color: Red">*</span></label>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtifsc" runat="server" CssClass="form-control" CausesValidation="True"
                                                placeholder="IFSC Code" MaxLength="11"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator22" runat="server"
                                                SetFocusOnError="true" ControlToValidate="txtifsc" Display="None" ValidationGroup="C"
                                                ErrorMessage="please Enter IFS code  11 Characters Alpha Numeric Value  Allowed!"
                                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[A-Za-z0-9]{1,11}$">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-horizontal">
                            <div class="panel panel-default">
                                <h2 class="head" style="margin-top: -5px;">
                                    <i class="fa fa-lock" aria-hidden="true"></i>&nbsp;Security Details</h2>
                                <div class="panel-body">
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Password:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtConfirmPassword" class="searchbox" runat="server" TabIndex="15"
                                                placeholder="Enter Password" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Confirm Password:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtPassword" class="searchbox" runat="server" TabIndex="16" CssClass="form-control"
                                                placeholder="Enter Confirm Password" ></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row">

                                        <div class="col-sm-2 ">
                                            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"
                                                ValidationGroup="C" CssClass="btn btn-primary" TabIndex="17" OnClientClick="return confirm('Are you sure you want to Save？')" />
                                            <br />
                                            <asp:Label ID="lbl_Msg" runat="server" ForeColor="Red"></asp:Label>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <asp:RequiredFieldValidator ID="rfvFType" runat="server" ErrorMessage="Please select franchise type."
                            ControlToValidate="ddltype" InitialValue="0" Display="None" SetFocusOnError="true"
                            ValidationGroup="C"></asp:RequiredFieldValidator>
                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Enter Franchise Sponsor ID."
                            ControlToValidate="txtsponsorid" Display="None" SetFocusOnError="true" ValidationGroup="C"></asp:RequiredFieldValidator>--%>
                        <asp:RequiredFieldValidator ID="fnamExp" runat="server" SetFocusOnError="true" ControlToValidate="txtName"
                            Display="None" ErrorMessage="Please enter name !" Font-Bold="False" ForeColor="#C00000"
                            Style="z-index: 100; left: 20px; position: relative; top: 0px; width: 95px;"
                            ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="addExp0" runat="server" ControlToValidate="txtMobileNo"
                            SetFocusOnError="true" Display="None" ErrorMessage="Please enter mobile no!"
                            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server"
                            SetFocusOnError="true" ControlToValidate="txtMobileNo" Display="None" ErrorMessage="Please enter valid mobile number !"
                            ForeColor="#C00000" ValidationExpression="^[6-9][0-9]{9}$" ValidationGroup="C"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEMailId"
                            SetFocusOnError="true" Display="None" ErrorMessage="Please enter email id!" ForeColor="#C00000"
                            ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEMailId"
                            SetFocusOnError="true" Display="None" ValidationGroup="C" ErrorMessage="Email should be like abc@xyz.com !"
                            ForeColor="#C00000" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlState"
                            SetFocusOnError="true" Display="None" ErrorMessage="Please Select State" ForeColor="#C00000"
                            ValidationGroup="C" InitialValue="0"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlDistrict"
                            SetFocusOnError="true" Display="None" ErrorMessage="Please Select District."
                            ForeColor="#C00000" ValidationGroup="C" InitialValue="0"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="cityExp" runat="server" ControlToValidate="txtCity"
                            SetFocusOnError="true" Display="None" ErrorMessage="Please enter city !" ForeColor="#C00000"
                            ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator19" runat="server"
                            SetFocusOnError="true" ControlToValidate="txtCity" Display="None" ErrorMessage="Only alphabets are allowed in city"
                            ValidationExpression="^[a-zA-Z][a-zA-Z\s]*$" ValidationGroup="C"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="addExp" runat="server" ControlToValidate="txtAddress"
                            SetFocusOnError="true" Display="None" ErrorMessage="Please enter address!" ForeColor="#C00000"
                            ValidationGroup="C"></asp:RequiredFieldValidator>
                        &nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" SetFocusOnError="true" runat="server"
                            ControlToValidate="txtPinCode" Display="None" ErrorMessage="Please enter pin code!"
                            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator16" SetFocusOnError="true"
                            runat="server" ControlToValidate="txtPinCode" Display="None" ErrorMessage="Please enter numeric 6 digit valid pin code !"
                            ForeColor="#C00000" ValidationExpression="^[1-8][0-9]{5}$" ValidationGroup="C"></asp:RegularExpressionValidator>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" SetFocusOnError="true"
                            ControlToValidate="txtContactPerson" Display="None" ErrorMessage="Please Enter Contact Person Name!"
                            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
                        &nbsp;
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtContactPerson"
                            SetFocusOnError="true" Display="None" ErrorMessage="Contact Person Name Contains Alphabetic Value Only. !"
                            ForeColor="#C00000" ValidationExpression="^[A-Za-z][A-Za-z\s]*$" ValidationGroup="C"></asp:RegularExpressionValidator>
                        &nbsp;--%>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                            SetFocusOnError="true" ControlToValidate="txtPanNo" Display="None" ErrorMessage="Please enter valid PAN No.!"
                            ForeColor="#C00000" ValidationExpression="^[a-zA-Z]{3}(p|P|c|C|h|H|f|F|a|A|t|T|b|B|l|L|j|J|g|G)[a-zA-Z][0-9]{4}[a-zA-Z]$"
                            ValidationGroup="C"></asp:RegularExpressionValidator>
                        <%--   <asp:RequiredFieldValidator ID="rfvGSTNo" runat="server" ErrorMessage="Please Enter GST NO."
                            ControlToValidate="txtGSTNo" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>--%>
                        <!--Ragh Use Validation Bank 06/07/2019--->
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" InitialValue="0"
                            ErrorMessage="Please Seelct Bank" ControlToValidate="ddlbankname" SetFocusOnError="true"
                            Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Enter Bank Brach Name"
                            ControlToValidate="txtbranch" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter A/c No."
                            ControlToValidate="txtaccountno" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Please Enter IFSC Code"
                            ControlToValidate="txtifsc" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Please Enter Franchise limit"
                            ControlToValidate="txtflimit" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Please Enter Franchise Commission"
                            ControlToValidate="txtfcom" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>--%>
                        <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtConfirmPassword"
                            SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Password !"
                            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="rfvConfirmpwd" runat="server" ControlToValidate="txtPassword"
                            SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Confirm Password !"
                            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revConfirmPass" SetFocusOnError="true" runat="server"
                            ControlToValidate="txtPassword" Display="None" ErrorMessage="Password should be minimum of 6 characters mix of alphanumeric!"
                            ForeColor="#C00000" ValidationExpression="^[A-Za-z0-9]{6,16}$" ValidationGroup="C"></asp:RegularExpressionValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword"
                            ControlToValidate="txtConfirmPassword" ErrorMessage="Password Mismatch !" Font-Bold="True"
                            ForeColor="#C00000" Style="left: 0px; position: relative" ValidationGroup="C"
                            Display="None" SetFocusOnError="True"></asp:CompareValidator>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            HeaderText="Please check the following..." ShowSummary="False" ValidationGroup="C"
                            Width="209px" />
                    </div>
                </div>
            </asp:Panel>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>
