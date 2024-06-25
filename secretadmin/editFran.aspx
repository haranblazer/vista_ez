<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="editFran.aspx.cs" Inherits="secretadmin_editFran" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtDOB.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <div>
        <h3 class="head">
             <i class="fa fa-podcast" aria-hidden="true"></i>&nbsp;Franchise Personal Details</h2>
        </h3>
    </div>
    <div class="clearfix">
    </div>
     <div class="panel panel-default">
      <div class="panel-body">
        <div class="form-group">
                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            Franchise SponsorID
                        </label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtFranSpon" runat="server" TabIndex="2"  Enabled="false" CssClass="form-control"></asp:TextBox>
                            </div>
                            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                    style="text-align: left">
                                    Franchise Type:</label>
                                      <div class="col-sm-3">
                                    <asp:DropDownList ID="ddltype" Enabled="false" runat="server" TabIndex="1" CssClass="form-control">
                                      <%--  <asp:ListItem Value="0">--Select--</asp:ListItem>
                                        <asp:ListItem Value="1">Mega</asp:ListItem>
                                        <asp:ListItem Value="2">Micro</asp:ListItem>
                                        <asp:ListItem Value="3">Mobile</asp:ListItem>--%>
                                        <%--     <asp:ListItem Value="1">Country Depo- BCD </asp:ListItem>
                                        <asp:ListItem Value="2">State- BSD</asp:ListItem>
                                        <asp:ListItem Value="3">Mega- BMG</asp:ListItem>--%>
                                        <%--      <asp:ListItem Value="4">Micro- BMC</asp:ListItem>--%>
                                    </asp:DropDownList></div>
                                    <div class="clearfix">
                        </div>
                        <br />
                         <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            Franchise Name:<span style="color: Red">*</span>
                        </label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtName" class="searchbox" runat="server" TabIndex="2" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            Mobile No:<span style="color: Red">*</span></label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" TabIndex="3" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                           <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            EMail Id:<span style="color: Red">*</span>
                        </label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtEMailId" runat="server" TabIndex="4" CssClass="form-control"></asp:TextBox>
                        </div>
                            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            Address:<span style="color: Red">*</span></label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" TabIndex="8" CssClass="form-control"></asp:TextBox>
                        </div>
                          <div class="clearfix">
                    </div>
                    <br />
                     <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            State:<span style="color: Red">*</span></label>
                        <div class="col-sm-3">
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" TabIndex="5"
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                         <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            City:<span style="color: Red">*</span>
                        </label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtCity" runat="server" TabIndex="7" CssClass="form-control"></asp:TextBox>
                        </div>
                     <div class="clearfix">
                    </div>
                    <br />
                      <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            Pin Code:<span style="color: Red">*</span></label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtPinCode" runat="server" MaxLength="6" TabIndex="9" CssClass="form-control"></asp:TextBox>
                        </div>
                         <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            GST No:<span style="color: Red">*</span>
                        </label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtGSTNo" class="searchbox" runat="server" TabIndex="14" CssClass="form-control"></asp:TextBox>
                        </div>
                         <div class="clearfix">
                    </div>
                    <br />
                     <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            Pan No:<span style="color: Red">*</span></label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtPanNo" class="searchbox" runat="server" TabIndex="12" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            CIN No:</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtCinNo" class="searchbox" runat="server" TabIndex="13" CssClass="form-control"></asp:TextBox>
                        </div>
                          <div class="clearfix">
                    </div>
                    <br />
                     <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                            Contact Person<span style="color: Red">*</span>
                        </label>
                     <div class="col-sm-3">
                            <asp:TextBox ID="txtContactPerson" runat="server" TabIndex="10" CssClass="form-control"></asp:TextBox>
                        </div>
                         <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label"
                                    style="text-align: left">
                                    Sample Allowed:<span style="color: Red">*</span></label>
                                <div class="col-sm-4 col-xs-9">
                                    <asp:RadioButtonList ID="rblsampleal" runat="server" RepeatDirection="Horizontal">
                                  <asp:ListItem Value="1" Selected="True">Yes</asp:ListItem>
                                  <asp:ListItem Value="0">No</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                  <div class="clearfix">
                    </div>
                    <br />
                     <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                    style="text-align: left">
                                    Franchise Limit:<span style="color: Red">*</span>
                                </label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtflimit" class="searchbox" runat="server" TabIndex="14" CssClass="form-control" onKeyPress="return onlyNumbers(this);"
                                        placeholder="Enter Franchise limit" MaxLength="7"></asp:TextBox>
                                </div>
                                  <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                    style="text-align: left">
                                    Franchise Commission:<span style="color: Red">*</span></label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtfcom" class="searchbox" runat="server" TabIndex="14" CssClass="form-control" onKeyPress="return onlyNumbers(this);"
                                        placeholder="Enter Franchise commission" MaxLength="2"></asp:TextBox>
                                           <label >
                                    <span style="color: Red">* Up to 99 %</span></label>
                                </div>
                                <div class="clearfix">
                    </div>
                    <br />
                                <label  for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                    style="text-align: left">
                                    Date Of Entry&nbsp;<span style="color: Red">*</span>
                                </label>
                                 <div class="col-sm-3">
                                <asp:TextBox ID="txtDOB" runat="server" CausesValidation="True" ToolTip="dd/mm/yyy"
                                    placeholder="dd/mm/yyyy" CssClass="form-control" ValidationGroup="n"></asp:TextBox>
                                    </div>
                                     <label  for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                    style="text-align: left">
                                    Status
                                </label>
                                  <div class="col-sm-4 col-xs-9">
                                    <asp:RadioButtonList ID="rbtnlstActivate" runat="server" RepeatDirection="Horizontal">
                                     <asp:ListItem  Value="1"  Selected="True">Activate</asp:ListItem>
                                    <asp:ListItem  Value="0">De Activate</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                 <div class="clearfix">
                    </div>
                    <br />
                    <label  for="MainContent_myForm_txtCcode" class="col-sm-2 control-label"
                                    style="text-align: left">
                                    District
                                </label>
                                 <div class="col-sm-3">
                                 <asp:TextBox ID="txtdistrict" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                 </div>

           </div>
     </div>
     <div class="clearfix">
    </div>
    <br />
     <div class="panel-body">
          <h2 class="head">
                        <i class="fa fa-university"></i>&nbsp;Bank Details</h2>
                        <div class="clearfix">
    </div>
    <br />
                        <div class="form-group">
                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                                        Bank Name:<span style="color: Red">*</span></label>
                              
                                <div class="col-sm-3">
                                    <asp:DropDownList ID="ddlbankname" runat="server" CausesValidation="True" CssClass="form-control"
                                        ValidationGroup="C">
                                    </asp:DropDownList>
                                </div>
                                 <label class="col-sm-2 control-label" style="text-align: justify">
                                        Branch:<span style="color: Red">*</span></label>
                               
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtbranch" runat="server" CausesValidation="True" CssClass="form-control"
                                        placeholder="Branch" MaxLength="50" ValidationGroup="C"></asp:TextBox>
                                </div>
                                                       <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label" style="text-align: justify">
                                     
                                        A/C:<span style="color: Red">*</span></label>
                                        <div class="col-sm-3">
                                    <asp:TextBox ID="txtaccountno" runat="server" ValidationGroup="C" CssClass="form-control"
                                        placeholder="Account Number" MaxLength="20" CausesValidation="True"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" SetFocusOnError="true"
                                        ErrorMessage="please Enter Account No Maximum 20 Alphanumeric Values are allowed in Account Number"
                                        Display="None" ValidationExpression="^[a-zA-Z0-9]{1,20}$" ControlToValidate="txtaccountno"
                                        ForeColor="#CC0000" ValidationGroup="cp"> please Enter Account No Maximum 20 Alphanumeric values are allowed in Account Number</asp:RegularExpressionValidator>
                                </div>
                                  <label class="col-sm-2 control-label" style="text-align: justify">
                                        A/CType:<span style="color: Red">*</span></label>
                                <div class="col-sm-3">
                                    <asp:DropDownList ID="ddlactype" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                        <asp:ListItem>SAVING A/C</asp:ListItem>
                                        <asp:ListItem>CURRENT A/C</asp:ListItem>
                                        <asp:ListItem>OD A/C</asp:ListItem>
                                        <asp:ListItem>CC A/C</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="clearfix">
                                </div>
                                <br />
                                 <label class="col-sm-2 control-label" style="text-align: justify">

                                        IFSC:<span style="color: Red">*</span></label>
                              
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtifsc" runat="server" CssClass="form-control" CausesValidation="True"
                                        placeholder="IFSC Code" MaxLength="20"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator22" runat="server"
                                        SetFocusOnError="true" ControlToValidate="txtifsc" Display="None" ValidationGroup="C"
                                        ErrorMessage="please Enter IFS code  20 Characters Alpha Numeric Value  Allowed!"
                                        ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[A-Za-z0-9]{1,20}$" Width="380px">please Enter IFS code  20 Characters Alpha Numeric Value  Allowed!</asp:RegularExpressionValidator>
                                </div>
                        </div>
                        <div class="form-group">
                                <div class="col-md-3">
                                 <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" ValidationGroup="sub"
                                            CssClass="btn btn-success" />&nbsp;
                                        <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server"  Text="Cancel"
                                            ValidationGroup="EP" CssClass="btn btn-success" />
                                    </div></div>
     </div>
     </div>
    <%--<div class="col-sm-12">
        <div class="form-horizontal">
            <div class="panel panel-default">
                <div class=" txt panel-heading">
                    <i class="fa fa-user-o" aria-hidden="true"></i>&nbsp; Sponsor Details (Step -1)</div>
                <div class="clearfix">
                </div>
                <br />
                <div class="panel-body">
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label class="txt">
                                    Sponsor Id</label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtSPID" runat="server" Enabled="False" MaxLength="20" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Id No.
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:Label ID="lblid" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3 ">
                                <label>
                                    Status
                                </label>
                                <asp:Label ID="lblIndicator" runat="server" Height="15px" Width="15px"></asp:Label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:RadioButtonList ID="rbtnlstActivate" runat="server" RepeatDirection="Horizontal"
                                    CssClass="form-control">
                                    <asp:ListItem class="txt" Value="1">Activate</asp:ListItem>
                                    <asp:ListItem class="txt" Value="0">De Activate</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <div class="form-horizontal">
            <div class="panel panel-default">
                <div class=" txt panel-heading">
                    <i class="fa fa-user" aria-hidden="true"></i>&nbsp;Personal Details (Step -2)</div>
                <div class="clearfix">
                </div>
                <br />
                <div class="panel-body">
                    <div class="clearfix">
                    </div>
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group" style="display: none">
                            <div class="col-sm-2">
                                <label>
                                    Total Left
                                </label>
                            </div>
                            <div class="col-sm-4">
                                <asp:Label ID="lbltleft" runat="server"></asp:Label>
                            </div>
                            <div class="col-sm-2">
                                <label>
                                    Total Right
                                </label>
                            </div>
                            <div class="col-sm-4">
                                <asp:Label ID="lbltright" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Title&nbsp;<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                    <asp:ListItem class="txt">MR.</asp:ListItem>
                                    <asp:ListItem class="txt">MRS</asp:ListItem>
                                    <asp:ListItem class="txt">MS.</asp:ListItem>
                                    <asp:ListItem class="txt">DR.</asp:ListItem>
                                    <asp:ListItem class="txt">MD.</asp:ListItem>
                                    <asp:ListItem class="txt">M/S.</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Father /Husband's
                                </label>
                            </div>
                            <div class="col-sm-2 col-xs-4" style="margin-right: 0px; padding-right: 0px">
                                <asp:DropDownList ID="ddlGtitle" runat="server" CssClass="form-control">
                                    <asp:ListItem class="txt">S/O</asp:ListItem>
                                    <asp:ListItem class="txt">D/O</asp:ListItem>
                                    <asp:ListItem class="txt">W/O</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-5 col-xs-5" style="margin-left: 0px; padding-left: 0px">
                                <asp:TextBox ID="txtGName" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group" style="display: none">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Occupation
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtOccupation" MaxLength="50" Rows="50" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <%-- <div class="clearfix">
                        </div>
                        <br />--%>
                        <%--<div class="form-group" style="display: none">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Marital Status
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:RadioButtonList ID="RdoMarital" runat="server" RepeatDirection="Horizontal"
                                    CssClass="form-control">
                                    <asp:ListItem class="txt" Selected="True" Value="0">Un-married</asp:ListItem>
                                    <asp:ListItem class="txt" Value="1">Married</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>--%>
                        <%-- <div class="clearfix">
                        </div>
                        <br />--%>
                        <%--<div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    City&nbsp;<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtcity" runat="server" MaxLength="50" CssClass="form-control"> </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtcity"
                                    Display="None" ErrorMessage="Please Enter City!" ForeColor="#C00000" ValidationGroup="sub"
                                    SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revCity" runat="server" ControlToValidate="txtcity"
                                    SetFocusOnError="true" Display="None" ErrorMessage="City Contains Alphabetic Value !"
                                    ValidationExpression="^[a-zA-Z][a-zA-Z\s]*$" ValidationGroup="sub"></asp:RegularExpressionValidator>
                            </div>
                        </div>--%>
                        <div class="clearfix">
                        </div>
                        <br />
                        <%--<div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    State&nbsp;<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="DdlState"
                                    Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000" InitialValue="0"
                                    ValidationGroup="sub" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                        </div>--%>
                        <div class="clearfix">
                        </div>
                        <br />
                       <%-- <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Pin Code&nbsp;<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtpocode" runat="server" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPinCode" runat="server" ControlToValidate="txtpocode"
                                    Display="None" ErrorMessage="Please Enter Pin Code!" ValidationGroup="sub" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPinCode" runat="server" ControlToValidate="txtpocode"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Valid Pin Code !"
                                    ValidationExpression="^[1-8][0-9]{5}$" ValidationGroup="sub"></asp:RegularExpressionValidator>
                            </div>
                        </div>--%>
                        <div class="clearfix">
                        </div>
                        <br />
                        <%--   <div class="clearfix">
                        </div>
                        <br />--%>
                    </div>
                   <%-- <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Name&nbsp;<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtfname" runat="server" MaxLength="50" Rows="50" CssClass="form-control"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvApplicantName" runat="server" ControlToValidate="txtfname"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Applicant Name!"
                                    ToolTip="NJ" ValidationGroup="sub"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revApplicantName" runat="server" ControlToValidate="txtfname"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Applicant Name Contains Alphabetic Value."
                                    ToolTip="NJ" ValidationExpression="^[A-Za-z ]{1,50}$" ValidationGroup="sub"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-group" style="display: none">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Mother's
                                </label>
                            </div>
                            <div class="col-sm-2 col-xs-4" style="margin-right: 0px; padding-right: 0px">
                                <asp:DropDownList ID="ddlMtitle" runat="server" CssClass="form-control">
                                    <asp:ListItem>S/O</asp:ListItem>
                                    <asp:ListItem>D/O</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-5 col-xs-5" style="margin-left: 0px; padding-left: 0px">
                                <asp:TextBox ID="txtMName" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <%--<div class="clearfix">
                        </div>
                        <br />--%>
                       <%-- <div class="form-group" style="display: none">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Gender
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:RadioButtonList ID="rbtnGender" runat="server" RepeatDirection="Horizontal"
                                    CssClass="form-control">
                                    <asp:ListItem class="txt" Selected="True" Value="0">Male</asp:ListItem>
                                    <asp:ListItem class="txt" Value="1">Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>--%>
                        </div>
                        <%--  <div class="clearfix">
                        </div>
                        <br />--%>
                       <%-- <div class="form-group">
                            <div class="col-sm-3 col-xs-3" style="text-align: justify">
                                <label>
                                    Date Of Birth&nbsp;<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtDOB" runat="server" CausesValidation="True" ToolTip="dd/mm/yyy"
                                    placeholder="dd/mm/yyyy" CssClass="form-control" ValidationGroup="n"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtDOB"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Date of Birth!"
                                    ToolTip="NJ" ValidationGroup="sub"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revDOB" runat="server" ControlToValidate="txtDOB"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Invalid Date of Birth!" ToolTip="NJ"
                                    ValidationExpression="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                                    ValidationGroup="sub"></asp:RegularExpressionValidator>
                            </div>
                        </div>--%>
                        <div class="clearfix">
                        </div>
                        <br />
                    <%--    <div class="form-group" style="display: none">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    District
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control">
                                </asp:DropDownList>--%>
                                <%--  <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" ControlToValidate="ddlDistrict"
                                    Display="None" ErrorMessage="Please Select District!" ForeColor="#C00000" InitialValue="0"
                                    ValidationGroup="sub" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                           <%-- </div>
                        </div>--%>
                        <div class="clearfix">
                        </div>
                        <%--<div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Address&nbsp;<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtaddress1" runat="server" Height="55px" TextMode="MultiLine" CssClass="form-control"
                                    MaxLength="200" Rows="500"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtaddress1"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Address!" ToolTip="NJ"
                                    ValidationGroup="sub"></asp:RequiredFieldValidator>
                            </div>
                        </div>--%>
                        <div class="clearfix">
                        </div>
                        <br />
                        <%--<div class="form-group" style="display: none">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Phone
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtphone" runat="server" MaxLength="20" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                        </div>--%>
                        <div class="clearfix">
                        </div>
                     <%--   <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Mobile<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtMobNo" runat="server" MaxLength="10" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMobileNo" runat="server" ControlToValidate="txtMobNo"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Mobile No!"
                                    ToolTip="NJ" ValidationGroup="sub"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revMobileNo" runat="server" ControlToValidate="txtMobNo"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter 10 Digits Valid Mobile No."
                                    ToolTip="NJ" ValidationExpression="^[6-9][0-9]{9}$" ValidationGroup="sub"></asp:RegularExpressionValidator>
                            </div>
                        </div>--%>
                        <div class="clearfix">
                        </div>
                        <br />
                       <%-- <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    E-mail
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtemail" runat="server" MaxLength="60" CssClass="form-control"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtemail"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Email like abc@xyz.com !"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="sub"></asp:RegularExpressionValidator>
                            </div>
                        </div>--%>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <%--<div class="form-horizontal">
            <div class="panel panel-default">
                <div class=" txt panel-heading">
                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp; Bank Details (Step -3)</div>
                <div class="clearfix">
                </div>
                <br />
                <div class="panel-body">
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Bank Name
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    A/C No
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtaccountno" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    IFSC Code
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="TxtIFSCODE" runat="server" MaxLength="20" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Aadhar No
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtAadharNo" runat="server" CssClass="form-control" MaxLength="12"
                                    placeholder="Please Enter Aadhar Number"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Branch
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    A/C Type
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:DropDownList ID="ddlAccType" runat="server" CssClass="form-control">
                                    <asp:ListItem class="txt">SAVING A/C</asp:ListItem>
                                    <asp:ListItem class="txt">CURRENT A/C</asp:ListItem>
                                    <asp:ListItem class="txt">OD A/C</asp:ListItem>
                                    <asp:ListItem class="txt">CC A/C</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Have Pan Card?
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:RadioButtonList ID="rbpanlist" runat="server" RepeatDirection="Horizontal" onclick="show(this)">
                                    <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                        <div class="form-group" runat="server" id="divid">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Pan No
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtPanNo" runat="server" MaxLength="10" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                </div>
                <div class="clearfix">
                </div>
            </div>
        </div>--%>
        <div class="clearfix">
        </div>
        <%--<div class="form-horizontal">
            <div class="panel panel-default">
                <div class=" txt panel-heading">
                    <i class="fa fa-user-o" aria-hidden="true"></i>&nbsp;Nominee Details (Step -4)</div>
                <div class="clearfix">
                </div>
                <br />
                <div class="panel-body">
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Nominee Name
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtnominame" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Nominee Relation
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtnomineerelation" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                </div>
            </div>
        </div>--%>
        <div class="clearfix">
        </div>
        <%--<div class="form-horizontal">
            <div class="panel panel-default">
                <div class=" txt panel-heading">
                    <i class="fa fa-lock"></i>&nbsp;Security Details (Step -4)</div>
                <div class="clearfix">
                </div>
                <br />
                <div class="panel-body">
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Password&nbsp;<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtpassword" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtpassword"
                                    ErrorMessage="Please Enter Password!" ValidationGroup="sub" ForeColor="#C00000"
                                    Display="None"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPass" runat="server" ControlToValidate="txtpassword"
                                    Display="None" ErrorMessage="Password should be mix of alphanumeric. " ForeColor="#C00000"
                                    ToolTip="NJ" ValidationExpression="^[0-9A-Za-z]*$" ValidationGroup="sub"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                          <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                    Reason To Modify<span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="TxtReason" runat="server" MaxLength="100" CssClass="form-control"
                                    TextMode="MultiLine"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="TxtReason"
                                    SetFocusOnError="true" ErrorMessage="Please Enter Reason!" ValidationGroup="sub"
                                    ForeColor="#C00000" Display="None"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6" style="margin: 0px; padding: 0px;">
                      
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                                <label>
                                  EPassword <span style="color: Red">*</span>
                                </label>
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:TextBox ID="txtepassword" runat="server"  CssClass="form-control"
                                    ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtepassword"
                                    SetFocusOnError="true" ErrorMessage="Please Enter E-Password !" ValidationGroup="sub"
                                    ForeColor="#C00000" Display="None"></asp:RequiredFieldValidator>
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtepassword"
                                    Display="None" ErrorMessage="E-Password should be mix of alphanumeric. " ForeColor="#C00000"
                                    ValidationExpression="^[0-9A-Za-z]*$" ValidationGroup="sub"></asp:RegularExpressionValidator>
                
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 col-xs-3">
                            </div>
                            <div class="col-sm-7 col-xs-9">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="sub" />
                                <br />
                                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" ValidationGroup="sub"
                                    CssClass="btn btn-success" />&nbsp;
                                <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel"
                                    ValidationGroup="EP" CssClass="btn btn-success" />
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                    </div>

                </div>
            </div>
        </div>--%>
    </div>--%>
    <div class="clearfix">
    </div>
    <br />
    <%--<div class="txt panel-heading">
        <h2 class="head">
            <i class="fa fa-money" aria-hidden="true"></i>&nbsp;Account Details
        </h2>
    </div>--%>
    <div class="clearfix">
    </div>
    <%--<div class="form-group">
        <div class="col-sm-2">
        </div>
        <div class="col-sm-4" runat="server" id="trModificationsSAVE">
        </div>
    </div>--%>
    <div class="clearfix">
    </div>
    <%--<div class="table table-responsive">
        <table style="width: 100%">
            <tr runat="server" id="trModificationsMsg">
                <td>
                    <asp:Label ID="lblModificationMsg" runat="server" Font-Bold="True" Font-Size="11pt"
                        ForeColor="#C00000" Text="Previous Modifications For This User: " Visible="false"></asp:Label>
                </td>
            </tr>
            <tr runat="server" id="trModifications">
                <td>
                    <asp:Panel ID="Panel1" Direction="LeftToRight" ScrollBars="Auto" Width="600px" HorizontalAlign="Left"
                        runat="server">
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="fsttable_a">
                    <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView1" runat="server" Width="100%"
                        DataKeyNames="appmstid,payoutno" AutoGenerateColumns="False" CellPadding="4"
                        CellSpacing="1" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle"
                        Style="text-align: center" EmptyDataText="Account details not found." CssClass="table table-striped table-hover mygrd"
                        OnRowCommand="GridView1_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                                <ItemStyle Height="20px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="tdate" ItemStyle-Width="150" HeaderText="Payout Date" />
                            <asp:BoundField DataField="totalearning" HeaderText="TOTAL EARNED AMOUNT" />
                            <asp:BoundField DataField="tds" HeaderText="TDS" />
                            <asp:BoundField DataField="handlingcharges" HeaderText="Courier Charges" />
                            <asp:BoundField DataField="Dispachedamt" HeaderText="Dispatched Amount" />
                            <asp:TemplateField HeaderText="Account Statement">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnAccountStatement" CommandName="AccountStatement" runat="server"
                                        Text="Print" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    </asp:GridView>
                </td>
            </tr>
            <tr runat="server" id="EarningDetails">
                <td class="fsttable_a" style="width: 100%">
                    <table class="mygrd" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;
                        border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                        border-bottom: #000000 1px solid; width: 100%;">
                        <tr>
                            <th colspan="4" style="height: 20px; padding-left: 15px; text-align: center; border-bottom: #000000 1px solid;">
                                Total Earning
                            </th>
                        </tr>
                        <tr>
                            <td class="heading_ba" style="text-align: center; border-bottom: #000000 1px solid;">
                                Total Amount
                            </td>
                            <td class="heading_ba" style="text-align: center; border-bottom: #000000 1px solid;
                                border-left: #000000 1px solid;">
                                TDS
                            </td>
                            <td class="heading_ba" style="text-align: center; border-bottom: #000000 1px solid;
                                border-left: #000000 1px solid;">
                                Courier Amount
                            </td>
                            <td class="heading_ba" style="text-align: center; border-bottom: #000000 1px solid;
                                border-left: #000000 1px solid;">
                                Dispatched Amount
                            </td>
                        </tr>
                        <tr>
                            <td class="backall" style="text-align: center">
                                <asp:Label ID="lblTotalTotalEarned" runat="server" Text="0" Font-Bold="True"></asp:Label>
                            </td>
                            <td class="backall" style="text-align: center; border-left: #000000 1px solid;">
                                <asp:Label ID="lblTotalTdsAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
                            </td>
                            <td class="backall" style="text-align: center; border-left: #000000 1px solid;">
                                <asp:Label ID="lblTotalhandlibgCharges" runat="server" Text="0" Font-Bold="True"></asp:Label>
                            </td>
                            <td class="backall" style="text-align: center; border-left: #000000 1px solid;">
                                <asp:Label ID="lblTotalDispatchedAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>--%>
    <div class="clearfix">
    </div>
    <br />
</asp:Content>

