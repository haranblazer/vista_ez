<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="Edit_Profile.aspx.cs" Inherits="secretadmin_Edit_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js?v=0.1" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtDOB.ClientID%>').datepick({
                dateFormat: 'dd/mm/yyyy',
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:-18',
            });

         <%--   $JD('#<%=txt_DOJ.ClientID%>').datepick({
                dateFormat: 'dd/mm/yyyy',
                changeMonth: true,
                changeYear: true,
            });--%>
            $JD('#<%=txtAddress.ClientID%>').keypress(function (e) {
                if (e.which == 92) { return false; }
            });
        });
    </script>


    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Edit Registration
        Information</h4>
    </div>
    <div class="" id="user-activity1">
        <div class="card-header border-0 p-0 pb-4">
            <div class="card-action coin-tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active " data-bs-toggle="tab" href="#personal_details" role="tab" aria-selected="true">Personal Details</a>
                    </li>
                    <%-- <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#nominee_details " role="tab" aria-selected="false">Nominee Details </a>
            </li>--%>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#pan_details" role="tab" aria-selected="false">Pan Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#bank_details" role="tab" aria-selected="false">Bank Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#aadhar_details" role="tab" aria-selected="false">Aadhar Details</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane d-block">
                    <div class="row">
                        <div class="col-sm-1 control-label">
                            <label>UserId</label>
                        </div>
                        <div class="col-sm-4">
                            <asp:Label ID="lblid" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                        <div class="col-sm-2 control-label text-center">
                            User Name 
                        </div>
                        <div class="col-sm-4">
                            <asp:Label ID="lbl_username" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade active show" id="personal_details">
                    <div class="panel-heading">
                        <h3 class="panel-title"><font style=""><strong>&nbsp;Sponsor Details (Step -1)</strong> </font></h3>
                    </div>
                    <div class="row">
                        <div class="col-md-6 row">
                            <div class="col-sm-3 control-label">
                                <label class="txt">Sponsor Id</label>
                            </div>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtSPID" runat="server" Enabled="False" MaxLength="20" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group row">
                                <div class="col-sm-2 control-label">
                                    <label>Status </label>
                                    <asp:Label ID="lblIndicator" runat="server" Height="15px" Width="15px"></asp:Label>
                                </div>
                                <div class="col-sm-8 control-label">
                                    <asp:RadioButtonList ID="rbtnlstActivate" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="1">Active</asp:ListItem>
                                        <asp:ListItem Value="0">Inactive</asp:ListItem>
                                        <asp:ListItem Value="2">Blocked</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font style=""><strong>&nbsp;Personal Details (Step -2)</strong></font></h3>
                    </div>
                    <div class="row">
                        <div class="col-md-6 card-group-row row">
                            <div class="col-sm-3 control-label">
                                <label> Name<span style="color: Red">*</span> </label>
                            </div>  
                            <div class="col-sm-9">
                                <div class="d-flex">
                                   <%-- <div class="col-sm-2 col-xs-4" style="margin-right: 0px; padding-right: 0px">
                                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="Mr.">Mr.</asp:ListItem>
                                            <asp:ListItem Value="Mrs.">Mrs.</asp:ListItem>
                                            <asp:ListItem Value="Ms.">Ms.</asp:ListItem>
                                            <asp:ListItem Value="Dr.">Dr.</asp:ListItem>
                                            <asp:ListItem Value="Md.">Md.</asp:ListItem>
                                            <asp:ListItem Value="M/S">M/S</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>--%>
                                    <div class="col-sm-9" style="margin-left: 0px; padding-left: 0px">
                                        <asp:TextBox ID="txtfname" runat="server" MaxLength="50" Rows="50" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div style="display: none;" class="col-md-6 card-group-row row">
      <div class="col-md-3 control-label">
          Display Name<span style="color: Red">*</span>
      </div>
      <div class="col-md-8">
          <asp:TextBox ID="txt_DisplayName" runat="server" onpaste="return false" CssClass="form-control">
          </asp:TextBox>
      </div>
  </div>
                  <%--      <div class="col-md-6 card-group-row row">
                            <div class="col-sm-3 control-label">
                                Father/Husband's
                            </div>
                            <div class="col-sm-9">
                                <div class="d-flex">
                                    <div class="col-sm-2 col-xs-4">
                                        <asp:DropDownList ID="ddlGtitle" runat="server" CssClass="form-control" Style="max-width: 100%;">
                                            <asp:ListItem>S/O</asp:ListItem>
                                            <asp:ListItem>D/O</asp:ListItem>
                                            <asp:ListItem>W/O</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtGName" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-sm-3 control-label">
                                <label class="txt">Gender<span style="color: Red">*</span></label>
                            </div>
                            <div class="col-md-8 control-label">
                                <asp:RadioButtonList ID="RdoGenderNew" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem class="txt" Value="0">Male</asp:ListItem>
                                    <asp:ListItem class="txt" Value="1">Female</asp:ListItem>
                                    <asp:ListItem class="txt" Value="2">Others</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Date Of Birth <span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtDOB" runat="server" ReadOnly="true" MaxLength="10" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Mobile<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtMobile" runat="server" MaxLength="10" CssClass="form-control"
                                    onkeypress="return onlyNumbers(event,this);" ToolTip="Mobile no. should be 10 digits!">
                                </asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6 card-group-row row" >
                            <div class="col-md-3 control-label">
                             State<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txt_Alt_MobNo" runat="server" MaxLength="10" style="display: none;" CssClass="form-control"
                                    onkeypress="return onlyNumbers(event,this);" ToolTip="Mobile no. should be 10 digits!">
                                </asp:TextBox>
                                <asp:DropDownList ID="ddlState" runat="server" onchange="GetDistrict()" CssClass="form-control" Enabled="true"></asp:DropDownList>
                            </div>
                        </div>
                        <%--                        <div class="col-md-6 card-group-row row">
             <div class="col-md-3 control-label">
                 Email
             </div>
             <div class="col-md-8">
                 <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
             </div>
         </div>--%>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                District<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <%--   <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                <%--<asp:DropDownList ID="ddl_Countries" runat="server" CssClass="form-control" onchange="Getstate();">
                                    <asp:ListItem Value="">Select Country</asp:ListItem>
                                </asp:DropDownList>--%>
                               <%--<asp:DropDownList ID="ddlState" runat="server" onchange="GetDistrict()" CssClass="form-control" Enabled="true">
</asp:DropDownList>--%>
                                                                <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" TabIndex="7">
</asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                City<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                 <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--  <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" TabIndex="7">
  </asp:DropDownList>--%>


                                <%-- <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" TabIndex="7">
                         </asp:DropDownList>--%>
                               <%-- <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" onchange="CityList();">
                                    <asp:ListItem Value="">Select State</asp:ListItem>
                                </asp:DropDownList>--%>

                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Address<span style="colorzzz: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                 <%-- <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                <%--<asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" Enabled="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                 </asp:DropDownList>--%>
                                <%--<asp:DropDownList ID="ddl_City" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">Select City</asp:ListItem>
                                </asp:DropDownList>--%>
                                 <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" ValidationGroup="v"
     CssClass="form-control" Height="50px">
 </asp:TextBox>
                            </div>
                        </div>  
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Pin Code<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                                            <asp:TextBox ID="txtpincode" runat="server" ValidationGroup="v" CssClass="form-control"
onkeypress = "return onlyNumbers(event,this);" ToolTip="Please Enter  Number Only!" MaxLength="6"></asp:TextBox>
                               <%-- <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" ValidationGroup="v"
                                    CssClass="form-control" Height="50px">
                                </asp:TextBox>--%>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Email<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                 <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:TextBox ID="txtpincode" runat="server" ValidationGroup="v" CssClass="form-control"
                                    onkeypress="return onlyNumbers(event,this);" MaxLength="6" ToolTip="Please Enter  Number Only!">
                                </asp:TextBox>--%>
                                <%-- <asp:TextBox ID="txtpincode" runat="server" ValidationGroup="v" CssClass="form-control"
     onkeypress = "return onlyNumbers(event,this);" ToolTip="Please Enter  Number Only!" MaxLength="6"></asp:TextBox>--%>
                                 <%-- <input type="text" id="txtpincode" maxlength="6" class="form-control"
           onkeypress="return onlyNumbers(event,this);" >--%>
       <%--<a href="javascript:void(0)">Verify</a>
       <span id="div_City" style="color: blue"></span>--%>
                            </div>
                        </div>

                                           <div class="col-md-6 card-group-row row">
                       <div class="col-md-3 control-label">
                           Password<span style="color: Red">*</span>
                       </div>
                       <div class="col-md-8">
                            <asp:TextBox ID="txt_PSWRD" runat="server" CssClass="form-control"></asp:TextBox>
                       </div>
                   </div>

                         

                        <div class="col-md-6 card-group-row row" style="display: none;">
                            <div class="col-md-3 control-label" style="display: none;">
                                 Date of join<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                           <asp:TextBox ID="txt_DOJ" style="display: none;" runat="server" CssClass="form-control" MaxLength="10" ToolTip="dd/mm/yyyy"></asp:TextBox>

                               <%-- <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>--%>
                            </div>
                        </div>
                       <%-- <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Date of join<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                              <asp:TextBox ID="" runat="server" Enabled="false" CssClass="form-control" MaxLength="10" ToolTip="dd/mm/yyyy"></asp:TextBox>
                            </div>
                        </div>--%>

                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Nominee Details (Step -3) </strong>
                        </font></h3>
                    </div>

                                             

                    <div class="form-group row">
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Nominee Name
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtnomniName" runat="server" CssClass="form-control"
                                    MaxLength="30" placeholder="Enter Nominee Name">
                                </asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Relation
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtrelation" runat="server" CssClass="form-control" MaxLength="30"
                                    placeholder="Enter Nominee Relation">
                                </asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12 card-group-row" style="margin: 0px;">
                            <div class="col-md-9"></div>
                            <div class="col-md-3">
<%--                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" onclick="UpdatePersonal()" CssClass="btn btn-primary" />--%>
                                <input type="button" runat="server" id="btnSubmit" value="Submit" onclick="UpdatePersonal()" class="btn btn-primary" />
                                    </div>
                        </div>
                    </div>
                    <%-- <div class="form-group row">
                        <div class="col-sm-12" style="display: none">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtGName"
                                Display="None" ErrorMessage="Please Enter Guardian's Name !" Font-Bold="False"
                                ForeColor="#C00000" Style="position: static" ValidationGroup="cp" Width="181px"
                                Enabled="False">Please Enter Guardian's Name !</asp:RequiredFieldValidator><br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtGName"
                                Display="None" ErrorMessage="Father/Husband's Name COntains Alphabetic Value!"
                                Font-Bold="False" ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[A-Za-z. ]*"
                                ValidationGroup="cp" Width="434px" Enabled="False"></asp:RegularExpressionValidator><br />
                            <br />
                            <asp:RequiredFieldValidator ID="addExp" runat="server" ControlToValidate="txtAddress"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Address !" ForeColor="#C00000"
                                ValidationGroup="cp">Please Enter Address !</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server"
                                SetFocusOnError="true" ControlToValidate="txtAddress" Display="None" ErrorMessage="Maximum 400 Characters Are Allowed ! "
                                ForeColor="#C00000" ValidationExpression="^[\s\S]{0,400}$" ValidationGroup="cp"></asp:RegularExpressionValidator><br />
                            <asp:RequiredFieldValidator ID="RfvState" runat="server" ControlToValidate="ddlState"
                                Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000" InitialValue="0"
                                ValidationGroup="cp" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <%--<asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                 Display="None" ErrorMessage="Please Enter city!" ForeColor="#C00000" ValidationGroup="cp"
                 SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtpincode"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Pincode !" ForeColor="#C00000"
                                Style="left: 0px; position: relative" ValidationGroup="cp">Please Enter Pincode !</asp:RequiredFieldValidator><br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtpincode"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter 6 Digits valid Pin Code"
                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[1-8][0-9]{5}$" ValidationGroup="cp"
                                Width="298px"></asp:RegularExpressionValidator><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMobile"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter 10 Digits Mobile No !"
                                ForeColor="#C00000" ValidationGroup="cp"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtMobile"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter 10 Digits Valid Mobile No."
                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[6789][0-9]{9}$" ValidationGroup="cp"
                                Width="248px"></asp:RegularExpressionValidator><br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtEmail"
                                Display="None" ErrorMessage="Please Enter E-Mail Address In Correct Format As 'abc@xyz.com' !"
                                ForeColor="#C00000" Style="position: static" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ValidationGroup="cp">Please Enter E-Mail Id In Correct Format As 'abc@xyz.com' !</asp:RegularExpressionValidator><br />

                            <asp:ValidationSummary ID="ValidationSmry" runat="server" ShowMessageBox="true" ShowSummary="false"
                                ValidationGroup="cp" HeaderText="Please check the following..."></asp:ValidationSummary>
                        </div>
                    </div>--%>
                </div>
                <div class="tab-pane fade" id="pan_details">
                    <%-- pan card details--%>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;PAN Details </strong>
                        </font></h3>
                    </div>
                    <asp:Panel ID="Panel2" runat="server">
                        <div class="form-group row">
                             
                                <div class="col-md-2">
                                    <label class="control-label" style="text-align: justify">
                                        Enter PAN No:<span style="color: Red">*</span></label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtPANDetails" runat="server" CssClass="form-control" placeholder="Enter PAN Number" MaxLength="10"></asp:TextBox>
                                </div>
                           
                                <div class="col-md-2 control-label">
                                    Select Image File : 
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <div class="form-file">
                                            <%-- <asp:FileUpload ID="FU1" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg" onchange="ShowImagePreview(this,0);" />
                                            <input id="X" runat="server" type="hidden" />
                                            <input id="Y" runat="server" type="hidden" />
                                            <input id="W" runat="server" type="hidden" />
                                            <input id="H" runat="server" type="hidden" />--%>
                                            <input type="file" id="img_Pan" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                                            <label for="img_Pan" title="Pan Card" class="btn"><i class="fa fa-upload" aria-hidden="true"></i></label>
                                            
                                        </div>
                                    </div>
                                </div>


                            <div class="col-md-2 text-end">
                                    <div id="div_panstatus_img" runat="server"></div>
                                    <%--                                    <img alt="" src="" runat="server" class="igte_rPayNet_ButtonImg" id="approveRejectimg" style="width: 100px; height: 100px;" />--%>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <br />
                            <div class="row">
                                   <div class="col-md-5">
                                <%--<asp:Image ID="imgUpload" runat="server" Width="450px" Height="267px" />--%>
                                <div id="div_ImgPan" runat="server"></div>
                                       </div>
                           
                                <div class="col-md-2 col-4">
                                    <%--<button runat="server" id="Button1"  title="Crop & Save" class="btn btn-success"
                                        validationgroup="vv" style="display: none;">
                                        <i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp;Crop & Submit
                                    </button>--%>
                                    <input type="button" id="btn_Pansubmit" value="Submit" onclick="Upload_Pan();" class="btn btn-success" />
                                </div>
                                
                                
                                <div class="col-md-2 col-4">
                                    <input type="button" id="btn_Pan_A" value="Approve" onclick="javascript:btnApproveKYC_Click(1);" class="btn btn-green" style="display: none;" />
                                </div>
                                <div class="col-md-2 col-4">
                                    <button type="button" id="btnreject" style="display: none;" onclick="btnRejectKYC_Click('1');" class="btn btn-danger">Reject</button>
                                </div>
                          
                            <div class="clearfix"></div>
                        </div>
                         <div class="form-group ">
     <span id="div_PanVerifyMsg" class="text-black"></span> 
 </div>
                    </asp:Panel>
                    <%--pan card details end--%>
                </div>
                <div class="tab-pane fade" id="bank_details">

                    <%--Bank details --%>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Bank Details </strong>
                        </font></h3>
                    </div>
                    <asp:Panel ID="Panel1" runat="server">
                        <div class="form-group row">
                           
                             
                     
                     
                            <div class="col-md-2 control-label">
                                Select Bank
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlBankName"
                                        Display="None" ErrorMessage="Please Select Bank Name." ValidationGroup="aa" InitialValue=""
                                        SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                            </div>
                      
                       
                            <div class="col-md-2 control-label">
                                A/C Type
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddlAcType" runat="server" CssClass="form-control">
                                    <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                                    <asp:ListItem Value="SAVING A/C">SAVING A/C</asp:ListItem>
                                    <asp:ListItem Value="CURRENT A/C">CURRENT A/C</asp:ListItem>
                                    <asp:ListItem Value="CC A/C">CC A/C</asp:ListItem>
                                    <asp:ListItem Value="OD A/C">OD A/C</asp:ListItem>
                                </asp:DropDownList>
                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlAcType"
                                        InitialValue="" SetFocusOnError="true" Display="None" ErrorMessage="Please Select  A/C Type."
                                        ValidationGroup="aa"></asp:RequiredFieldValidator>--%>
                            </div>
                        
                            <div class="col-md-2 control-label">
                                A/C No.
                            </div>
                            <div class="col-md-4">
                                <div class="tooltiptest">
                                    <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control"></asp:TextBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtAccNo"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Please Enter A/C Number."
                                            ValidationGroup="aa"></asp:RequiredFieldValidator>--%>
                                    <%-- <asp:RegularExpressionValidator ID="revACNo" runat="server" Display="None" ForeColor="Red"
                                            ValidationGroup="aa" ValidationExpression="^#?[0-9-`]*$" SetFocusOnError="true"
                                            ErrorMessage="Account Number Contains Numeric Value Without Space." ControlToValidate="txtAccNo"></asp:RegularExpressionValidator>--%>
                                </div>
                            </div>
                        
                            <div class="col-md-2 control-label">
                                Branch
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtbranch"
                                        SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Branch." ValidationGroup="aa"></asp:RequiredFieldValidator>--%>
                            </div>
                      
                            <div class="col-sm-2 control-label">
                                IFS Code
                            </div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtifs" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtifs"
                                        SetFocusOnError="true" Display="None" ErrorMessage="Please Enter IFS Code." ValidationGroup="aa">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revIFSCode" runat="server" Display="None" ForeColor="Red"
                                        ValidationGroup="aa" ValidationExpression="^[A-Z]{4}0[A-Z0-9]{6}$" SetFocusOnError="true"
                                        ErrorMessage="IFS Code Contains AlphaNumeric Value Without Space." ControlToValidate="txtifs"></asp:RegularExpressionValidator>--%>
                            </div>

                               <div class="col-md-2 control-label">
                                    Upload Cancel Cheque
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <div class="form-file">
                                            <%--  <asp:FileUpload ID="fileCancelCq" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg" onchange="ShowImagePreview(this,1);" />
                                            <input id="X1" runat="server" type="hidden" />
                                            <input id="Y1" runat="server" type="hidden" />
                                            <input id="W1" runat="server" type="hidden" />
                                            <input id="H1" runat="server" type="hidden" />
                                            <input id="R" runat="server" type="hidden" />--%>
                                            <input type="file" id="img_Bank" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                                            <label for="img_Bank" title="Bank" class="btn"><i class="fa fa-upload" aria-hidden="true"></i></label>
                                        </div>
                                    </div>
                                </div>
                           
                         <div class="clearfix"></div>
                            <div class="col-sm-2 col-4">
                                <input type="button" id="btn_Banksubmit" value="Submit" onclick="Upload_Bank();" class="btn btn-success" />

                                <%--<button runat="server" id="btnInsert"  title="Crop & Save" class="btn btn-success"
                                        validationgroup="aa" style="display: none;" >
                                        Crop & Submit</button>--%>
                            </div>
                            <div class="col-sm-2 col-4">
                                <button type="button" id="btnreject1" onclick="btnRejectKYC_Click('2');" class="btn btn-danger" style="display: none;">Reject</button>
                            </div>
                            <div class="col-sm-2 col-4">
                                <input type="button" id="btn_BANK_A" onclick="javascript:btnApproveKYC_Click(2);" value="Approve" style="display: none;" class="btn btn-green" />
                            </div>
                        
                           
                             <div class="col-sm-6 text-end">
                                 <div id="div_bankstatus_img" runat="server"></div></div>
                            
                            <br />

                            <div class="col-md-9 card-group-row" style="margin: 0px; min-height: 300px;">
                                <%--                                <asp:Image ID="imgUpload1" runat="server" Style="width: 100%" />--%>

                                <div id="div_ImgBank" runat="server"></div>
                            </div>
                            <div class="col-md-3 card-group-row" style="margin: 0px;">
                                <div class="col-sm-2">
                                   
                                    <%--                                   <img alt="" src="" runat="server" class="igte_rPayNet_ButtonImg" id="approveRejectImg1" style="width: 100px; height: 100px;" />--%>
                                </div>
                            </div>
                        </div>
                          
                <div class="form-group ">
                    <span id="div_BankVerifyMsg" class="text-black"></span> 
                </div>
                    </asp:Panel>
                    <%-- bank details end--%>
                  </div>
                <div class="tab-pane fade" id="aadhar_details">

                    <%--Aadhar Details start--%>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Address Details </strong>
                        </font></h3>
                    </div>

                    <div class="alert alert-primary alert-dismissible fade show">
                        <strong>&nbsp;Note:</strong> Please upload front as well as back image of Address Proof.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close"></button>
                    </div>
                    <asp:Panel ID="Panel3" runat="server">
                        <div class="form-group row">

                            <div class="row">
                                <div class="col-md-2 control-label">
                                    Address Proof ID:
                                </div>
                                <div class="col-md-4">
                                    <asp:TextBox ID="txtAadharNo" runat="server" onkeypress="return onlyNumbers(event,this);" CssClass="form-control" MinLength="12" MaxLength="12"
                                        placeholder="Please Enter Aadhar Number">
                                    </asp:TextBox>
                                    <asp:Label ID="lblMsg2" runat="server" ForeColor="Red" />
                                </div>
                                <div class="col-md-6 text-end">
                                    <div id="div_AadharStatus" runat="server"></div>

                                    <%--                                    <img alt="" src="" runat="server" class="igte_rPayNet_ButtonImg" id="approveRejectImg2" style="width: 100px; height: 100px;" />--%>
                                </div>
                            </div>
                            <div class="clearfix"></div>


                            <div class="col-md-6 card-group-row row p-0" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Upload front image   
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <div class="form-file">
                                            <%--                                            <asp:FileUpload ID="FU2" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg" onchange="ShowImagePreview(this,2);" />--%>
                                            <input type="file" id="img_Aadhar_Front" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                                            <label for="img_Aadhar_Front" title="Aadhar Card Front" class="btn"><i class="fa fa-upload" aria-hidden="true"></i></label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            
                            <div class="col-md-6 card-group-row row p-0" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Upload back image    
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <div class="form-file">
                                            <%--  <asp:FileUpload ID="FU3" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg" onchange="ShowImagePreview(this,3);" />
                                            <input id="X2" runat="server" type="hidden" />
                                            <input id="Y2" runat="server" type="hidden" />
                                            <input id="W2" runat="server" type="hidden" />
                                            <input id="H2" runat="server" type="hidden" />

                                            <input id="X3" runat="server" type="hidden" />
                                            <input id="Y3" runat="server" type="hidden" />
                                            <input id="W3" runat="server" type="hidden" />
                                            <input id="H3" runat="server" type="hidden" />
                                            <input id="R1" runat="server" type="hidden" />--%>

                                            <input type="file" id="img_Aadhar_Back" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                                            <label for="img_Aadhar_Back" title="Aadhar Card Back" class="btn"><i class="fa fa-upload" aria-hidden="true"></i></label>

                                        </div>
                                    </div>
                                </div>
                                 
                            </div>

                            <div class="clearfix"></div>
                            <br />
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div id="div_ImgAadharFront" runat="server"></div>
                            </div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div id="div_ImgAadharBack" runat="server"></div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-md-6 card-group-row row" style="margin: 0px;">
                                <%--  <div class="col-md-4">
                            <input type="button" id="btn_editA" runat="server" value="Update" class="btn btn-success" />

                        </div>--%>
                                <div class="col-md-4 col-4">
     <%--  <button runat="server" id="Button6" title="Submit" class="btn btn-success"
         validationgroup="vv" style="display: none;" >
         <i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp;Crop & Submit
     </button>--%>
     <input type="button" id="btn_Aadharsubmit" value="Submit" onclick="Upload_Aadhar();" class="btn btn-success" />

 </div>
                                <div class="col-md-4 col-4">
                                    <button type="button" id="btnreject2" class="btn btn-danger" onclick="btnRejectKYC_Click('3');" style=" display: none;">Reject</button>
                                </div>
                                <div class="col-md-4 col-4">
                                    <input type="button" id="btn_AADHAR_A" onclick="javascript:btnApproveKYC_Click(3);" value="Approve" style="display: none;" class="btn btn-green" />
                                </div>
                               
                            </div>
                            
                        </div>
                        <div class="clearfix"></div>
                    </asp:Panel>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font style=""><strong>Remove KYC  &nbsp;<strong>Note:</strong> This action will Remove KYC details of user.</strong> </font></h3>
                    </div>
                    <div class="col-sm-3 center-block">
                        <%--                        <asp:Button ID="kycRej" runat="server" Text="Remove Pan, Bank & Aadhar KYC" CssClass="btn btn-danger" OnClientClick="return confirm('Are you sure you want to delete the current KYC Details?')" />--%>
                        <input type="button" id="kycRej" runat="server" value="Remove Pan, Bank & Aadhar KYC" class="btn btn-danger w-100" onclick="AllKYC_Reject()" />
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    
    <asp:HiddenField runat="server" ID="hdn_userid" />
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--%>
   <%--  <script> var $JDT = $.noConflict(true); </script>--%>
   <%-- <script src="../js/jquery-3.4.1.min.js"></script>--%>
    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("Edit_Profile.aspx")%>';
        $JD(function () {
           
            GetDetail();
            var URL = '~/Service.aspx';
            $('#<%=txt_DisplayName.ClientID %>').keypress(function (e) {
                if ((e.which >= 48 && e.which <= 57) || (e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122)) { return true; }
                else { return false; }
            });
            $('#<%=txt_PSWRD.ClientID %>').keypress(function (e) {
                if ((e.which >= 48 && e.which <= 57) || (e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122)) { return true; }
                else { return false; }
            });
        });

        //function Verify() {
           
        //    var Pincode = $('#txtpincode').val();
        //    if (Pincode.length == 6) {
        //        $.getJSON('https://api.postalpincode.in/pincode/' + Pincode, function (resp) {
        //            $.each(resp, function (key, val) {
        //                $.each(val, function (key1, val1) {
        //                    if (key1 == "PostOffice") {
        //                        if (val1 != null) {
        //                            $.each(val1, function (key2, val2) {
        //                                if (key2 == 0) {
        //                                    $('#div_City').html(val2.District);
        //                                    $("#txtpincode").removeAttr('enabled');
        //                                    $("#txtpincode").attr('disabled', 'disabled');
        //                                    $('#verify').text('Verified');

        //                                }
        //                            });
        //                        }
        //                        else {
        //                            $('#div_City').html('');
        //                            alert('Please Enter Valid Pincode.!!');
        //                            return false;
        //                        }
        //                    }
        //                });

        //            });
        //        });

        //    } else {
        //        alert('Please Enter Pincode.!!');
        //    }
        //}
 

        async function GetDetail() {
           
            let UId = $('#<%=hdn_userid.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetUser',
                data: '{ UId: "' + UId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                   
                    //if (data.d.PANDetail != "" || data.d.PANDetail != "undefined") {
                        
                    //    try {
                    //        var PANDetail = JSON.parse(data.d.PANDetail);
                    //        var aadhaarSeedingStatus = PANDetail.result.aadhaarSeedingStatus;
                    //        var aadhaarSeedingStatusCode = PANDetail.result.aadhaarSeedingStatusCode;
                    //    } catch (e) {
                    //        console.log("Error parsing JSON: " + e);
                    //    }
                    //}
                   
                    //if (data.d.BANKDetail != "" || data.d.BANKDetail != "undefined") {
                    //    try {
                    //    var BankDetail = JSON.parse(data.d.BANKDetail);
                    //    var bankTransfer = BankDetail.result.bankTransfer.bankRRN;
                    //    var NameScore = BankDetail.result.nameMatchScore;
                    //        var BankStatus = BankDetail.result.active;
                    //    } catch (e) {
                    //        console.log("Error parsing JSON: " + e);
                    //    }
                    //}
                   
                   
                  //  var PANDetail = jsonData.PANDetail;
                   
                    $('#<%=lblid.ClientID%>').text(UId);
                    $('#<%=lbl_username.ClientID%>').text(data.d.UName);

                    $('#<%=txtSPID.ClientID%>').val(data.d.SponsorId);
                  <%--  $('#<%=rbtnlstActivate.ClientID%>').val(data.d.SponsorStatus);--%>
                    $('#<%=rbtnlstActivate.ClientID %>').find("input[value='" + data.d.SponsorStatus + "']").prop("checked", true);

                    $('#<%=txt_Alt_MobNo.ClientID%>').val(data.d.Alt_MobNo);
                    $('#<%=txt_DOJ.ClientID%>').val(data.d.DOJ);

                   <%-- $('#<%=DropDownList1.ClientID%>').val(data.d.Title);--%>
                    $('#<%=txtfname.ClientID%>').val(data.d.Name);
                   <%-- $('#<%=ddlGtitle.ClientID%>').val(data.d.GTitle);
                    $('#<%=txtGName.ClientID%>').val(data.d.GName);--%>
                   <%-- $('#<%=RdoGenderNew.ClientID%>').val(data.d.Gender);--%>
                    $('#<%=txtDOB.ClientID%>').val(data.d.DOB);
                    $('#<%=txtMobile.ClientID%>').val(data.d.Mobile);
                    $('#<%=txtEmail.ClientID%>').val(data.d.Email);
                    $('#<%=txtAddress.ClientID%>').val(data.d.Address);
                    $('#<%=RdoGenderNew.ClientID %>').find("input[value='"+ data.d.Gender  +"']").prop("checked", true);
                    //$(function () {
                    //    // Get the RadioButtonList element
                    //    var radioList = $("#RadioButtonList1");

                    //    // Get the value of the RadioButton to be selected
                    //    var value = "2";

                    //    // Find the RadioButton with the specified value
                    //    var radio = radioList.find("input[value=" + value + "]");

                    //    // Select the RadioButton
                    //    radio.attr("checked", "checked");
                    //});
                    //, ddlState, ddl_City
                  <%--  $('#<%=ddlDistrict.ClientID%>').val(data.d.District);
                    $('#<%=txtCity.ClientID%>').val(data.d.City);--%>
                    /*$('#txtpincode').val(data.d.PinCode);*/
                    $('#<%=txtpincode.ClientID%>').val(data.d.PinCode);
                    $('#<%=txtnomniName.ClientID%>').val(data.d.Nominee);
                    $('#<%=txtrelation.ClientID%>').val(data.d.Relation);
                    $('#<%=txtPANDetails.ClientID%>').val(data.d.PAN);
                    $('#<%=ddlBankName.ClientID%>').val(data.d.Bank);
                    $('#<%=ddlAcType.ClientID%>').val(data.d.AccType);
                    $('#<%=txtAccNo.ClientID%>').val(data.d.AccNo);
                    $('#<%=txtbranch.ClientID%>').val(data.d.Branch);
                    $('#<%=txtifs.ClientID%>').val(data.d.IFSC);
                    $('#<%=txtAadharNo.ClientID%>').val(data.d.AadhaarNo);
                    $('#<%=ddlDistrict.ClientID%>').val(data.d.District); 
                    $('#<%=txt_PSWRD.ClientID%>').val(data.d.PSWRD);
                    <%--$('#<%=txt_DisplayName.ClientID%>').val(data.d.DisplayName);--%>
                    
                   <%-- $('#<%=txt_GSTNo.ClientID%>').val(data.d.GST);--%>

                    //img_Aadhar_Front  img_Aadhar_Back

                   

                    if (data.d.PanImage == "") {
                        $('#<%=div_ImgPan.ClientID%>').css("display", "none");
                    }

                    //Pan
                    $('#<%=div_panstatus_img.ClientID%>').html("");
                    $("#btn_Pansubmit").css("display", "none");
                    /* <img alt="" src="" runat="server" class="igte_rPayNet_ButtonImg" id="approveRejectimg" style="width: 100px; height: 100px;" />*/
                    $('#<%=div_ImgPan.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/PanImage/' + data.d.PanImage + '"> <img src="../images/KYC/PanImage/' + data.d.PanImage + '" style="width:430px; height:250px;"/> </a>');
                    if (data.d.PStatus == "1") {
                        $('#<%=div_panstatus_img.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');

                        $("#btn_Pansubmit").css("display", "block");
                        $("#btn_Pan_A").css("display", "block");
                        $("#btnreject").css("display", "block");

                    }
                    else if (data.d.PStatus == "2") {
                        //let Msg = 'Dear ' + data.d.UName + ' <br> ';
                        //Msg += 'Your PAN No. Successfully Verified.!! <i class="fa fa-check fw-bold" aria-hidden="true"></i><br> ';
                        //if (aadhaarSeedingStatusCode == "R") {
                        //    Msg += 'PAN Aadhaar Link <i class="fa fa-close" aria-hidden="true"></i> <br> ';
                        //}
                        //else {
                        //    Msg += 'PAN Aadhaar Link <i class="fa fa-check fw-bold" aria-hidden="true"></i> <br> ';
                        //}
                        
                       // Msg += 'PAN Status Valid<i class="fa fa-check fw-bold" aria-hidden="true"></i> <br> ';
                        /*$('#div_PanVerifyMsg').html('<div class="alert alert-success text-black row"> <div class="col-md-10">' + Msg + '</div> <div class="col-md-2 text-center"><img src="../images/verified.png" width="80px" /></div></div>');*/
<%--$('#<%=div_ImgPan.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/PanImage/' + data.d.PanImage + '"><img style="width:350px; height:300px;" src="../images/KYC/PanImage/' + data.d.PanImage + '"/></a>');--%>
                        $('#<%=div_panstatus_img.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
                        $("#btn_Pansubmit").css("display", "block");
                        $("#btn_Pan_A").css("display", "none");
                        $("#btnreject").css("display", "none");
                       <%-- if (data.d.OnlinePanVerify == "1") {
                            let Msg = 'Dear ' + data.d.UName + ' <br> ';
                            Msg += 'Your PAN No. Successfully Verified.!! <i class="fa fa-check fw-bold" aria-hidden="true"></i><br> ';
                            if (aadhaarSeedingStatusCode == "R") {
                                Msg += 'PAN Aadhaar Link <i class="fa fa-close" aria-hidden="true"></i> <br> ';
                            }
                            else {
                                Msg += 'PAN Aadhaar Link <i class="fa fa-check fw-bold" aria-hidden="true"></i> <br> ';
                            }

                            Msg += 'PAN Status Valid<i class="fa fa-check fw-bold" aria-hidden="true"></i> <br> ';
                            $('#div_PanVerifyMsg').html('<div class="alert alert-success text-black row"> <div class="col-md-10">' + Msg + '</div> <div class="col-md-2 text-center"><img src="../images/verified.png" width="80px" /></div></div>');
                            $('#<%=div_ImgPan.ClientID%>').html('<img src="../images/KYC/PanImage/"' + data.d.PanImage + '"/>');
                        $('#<%=div_panstatus_img.ClientID%>').html('<div>Online Verified<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/></div>');
                        $("#btn_Pansubmit").css("display", "none");
                    }--%>
                    } 
                    else if (data.d.PStatus == "0") {
                        $('#<%=div_panstatus_img.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Pansubmit").css("display", "block");
                        $("#btn_Pan_A").css("display", "none");
                        $("#btnreject").css("display", "none");
                    }
                    else {
<%--                        $('#<%=div_ImgPan.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/PanImage/' + data.d.PanImage + '"><img style="width:350px; height:300px;" src="../images/KYC/PanImage/' + data.d.PanImage + '"/></a>');--%>
                        $("#btn_Pansubmit").css("display", "block"); 
                    }


                    if (data.d.BankImage == "") {
                        $('#<%=div_ImgBank.ClientID%>').css("display", "none");
                    }
                    //img_Bank, div_ImgBank  div_bankstatus_img
                    // btn_BANK_A  btnreject1

                    $('#<%=div_bankstatus_img.ClientID%>').html("");
                    $("#btn_Banksubmit").css("display", "block");
                    $('#<%=div_ImgBank.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/BankImage/' + data.d.BankImage + '"> <img src="../images/KYC/BankImage/' + data.d.BankImage + '" style="width:430px; height:400px;"/> </a>');

                    if (data.d.bankstatus == "1") {
                       
                        $('#<%=div_bankstatus_img.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');
                        let bankstatus=$('#<%=div_bankstatus_img.ClientID%>').html()
                        $("#btn_Banksubmit").css("display", "block");
                        $("#btn_BANK_A").css("display", "block");
                        $("#btnreject1").css("display", "block");


                    }
                    else if (data.d.bankstatus == "2") {
                       
                        //let Msg = 'Dear ' + data.d.UName + ' <br> ';
                        //Msg += 'Your Bank A/c Verified Successfully.!! <i class="fa fa-check fw-bold" aria-hidden="true"></i> <br> ';
                        //if (BankStatus == "Yes") {
                        //    Msg += 'Active : Yes <br> ';
                        //}
                        //else {
                        //    Msg += 'Active : No <br> ';
                        //}
                        
                        //if (NameScore > 0.34) {
                        //    Msg += 'Name Match : Yes <br> ';
                        //} else {
                        //    Msg += 'Name Match : No <br> ';
                        //}
                        //Msg += 'Bank Response : Transaction Successful <br> ';

                        //$('#div_BankVerifyMsg').html('<div class="alert alert-success text-black row"> <div class="col-md-10">' + Msg + '</div> <div class="col-md-2 text-center"><img src="../images/verified.png" width="80px" /></div></div>');

                        $('#<%=div_bankstatus_img.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
<%--                        $('#<%=div_ImgBank.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/BankImage/' + data.d.BankImage + '"> <img src="../images/KYC/BankImage/' + data.d.BankImage + '" style="width:350px; height:200px;"/> </a>');--%>

                        $("#btn_Banksubmit").css("display", "block");
                        $("#btn_BANK_A").css("display", "none");
                        $("#btnreject1").css("display", "none");
                           
                        <%--if (data.d.OnlineBankVerify == "1") {
                           
                            let Msg = 'Dear ' + data.d.UName + ' <br> ';
                            Msg += 'Your Bank A/c Verified Successfully.!! <i class="fa fa-check fw-bold" aria-hidden="true"></i> <br> ';
                            if (BankStatus == "Yes") {
                                Msg += 'Active : Yes <br> ';
                            }
                            else {
                                Msg += 'Active : No <br> ';
                            }

                            if (NameScore > 0.34) {
                                Msg += 'Name Match : Yes <br> ';
                            } else {
                                Msg += 'Name Match : No <br> ';
                            }
                            Msg += 'Bank Response : Transaction Successful <br> ';

                            $('#div_BankVerifyMsg').html('<div class="alert alert-success text-black row"> <div class="col-md-10">' + Msg + '</div> <div class="col-md-2 text-center"><img src="../images/verified.png" width="80px" /></div></div>');

                            $('#<%=div_bankstatus_img.ClientID%>').html('<div>Online Verified  <img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/></div>');
                            $('#<%=div_ImgBank.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/BankImage/' + data.d.BankImage + '"> <img src="../images/KYC/BankImage/' + data.d.BankImage + '" style="width:350px; height:200px;"/> </a>');

                            $("#btn_Banksubmit").css("display", "none");
                          }--%>
                    }
                  
                    else if (data.d.bankstatus == "0" ) {
                        $('#<%=div_bankstatus_img.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Banksubmit").css("display", "block");
                        $("#btn_BANK_A").css("display", "none");
                        $("#btnreject1").css("display", "none");
                    }
                    else {
                        $('#<%=div_bankstatus_img.ClientID%>').html('<img src="../images/KYC/BankImage/' + data.d.BankImage + '"/>');
                        $("#btn_Banksubmit").css("display", "block");
                    }
                    //GST
                   // div_ImgAadharFront
                   // div_ImgAadharBack

                    if (data.d.AadharFront == "" && data.d.AadharBack == "") {
                        
                        $('#<%=div_ImgAadharFront.ClientID%>').css("display", "none");
                        $('#<%=div_ImgAadharBack.ClientID%>').css("display", "none");
                    }

                    //div_GST, div_GST_Status, btn_GSTsubmit
                    //div_ImgAadharFront  div_ImgAadharBack  btnreject2  btn_AADHAR_A  btn_Aadharsubmit  div_AadharStatus
                    $('#<%=div_AadharStatus.ClientID%>').html("");
                    $("#btn_Aadharsubmit").css("display", "none");
                    $('#<%=div_ImgAadharFront.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/AadharImage/Front/' + data.d.AadharFront + '"> <img src="../images/KYC/AadharImage/Front/' + data.d.AadharFront + '" style="width:430px; height:250px;"/> </a>');
                    $('#<%=div_ImgAadharBack.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/AadharImage/Back/' + data.d.AadharBack + '"> <img src="../images/KYC/AadharImage/Back/' + data.d.AadharBack + '" style="width:430px; height:250px;"/> </a>');

                    if (data.d.AaStatus == "1") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                        $("#btn_AADHAR_A").css("display", "block");
                        $("#btnreject2").css("display", "block");
                    }
                    else if (data.d.AaStatus == "2") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
                        $("#btn_Aadharsubmit").css("display", "block");      
                        $("#btn_AADHAR_A").css("display", "none");
                        $("#btnreject2").css("display", "none");
                    }
                    else if (data.d.AaStatus == "0") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                        $("#btn_AADHAR_A").css("display", "none");
                        $("#btnreject2").css("display", "none");
                    }
                    else {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img style="height:150px;width: 100%" src="../images/KYC/BankImage/' + data.d.BankImage + '"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                    }

                  <%--  $('#<%=div_GST_Status.ClientID%>').html("");
                    $("#btn_GSTsubmit").css("display", "none");
                    $('#<%=div_GST.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/PanImage/' + data.d.GST_Img + '"> <img src="../images/KYC/PanImage/' + data.d.GST_Img + '" style="width:350px; height:200px;"/> </a>');
                    if (data.d.GST_Status == "1") {
                        $('#<%=div_GST_Status.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_GSTsubmit").css("display", "block");
                    }
                    else if (data.d.GST_Status == "2") {
                        $('#<%=div_GST_Status.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
                    }
                    else if (data.d.GST_Status == "0") {
                        $('#<%=div_GST_Status.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_GSTsubmit").css("display", "block");
                    }
                    else {
                        $('#<%=div_GST_Status.ClientID%>').html('<img src="../images/KYC/PanImage/"' + data.d.GST_Img + '"/>');
                        $("#btn_GSTsubmit").css("display", "block");

                    }
                    // div_bankStatus, btn_Banksubmit
                    $('#<%=div_bankStatus.ClientID%>').html("");
                    $("#btn_Banksubmit").css("display", "none");
                    $('#<%=div_ImgBank.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/BankImage/' + data.d.BankImage + '"> <img src="../images/KYC/BankImage/' + data.d.BankImage + '" style="width:350px; height:200px;"/> </a>');

                    if (data.d.bankstatus == "1") {
                        $('#<%=div_bankStatus.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Banksubmit").css("display", "block");
                    }
                    else if (data.d.bankstatus == "2") {
                        $('#<%=div_bankStatus.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
                    }
                    else if (data.d.bankstatus == "0") {
                        $('#<%=div_bankStatus.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Banksubmit").css("display", "block");
                    }
                    else {
<%--                        $('#<%=div_Pan_Status.ClientID%>').html('<img src="../images/KYC/PanImage/"' + data.d.PanImage + '"/>');--%>
                       <%-- $('#<%=div_bankStatus.ClientID%>').html('<img src="../images/KYC/BankImage/"' + data.d.BankImage + '"/>');
                        $("#btn_Banksubmit").css("display", "block");
                    }--%>
                    // div_AadharStatus, div_ImgAadharBack, div_ImgAadharFront, btn_Aadharsubmit
                    <%--$('#<%=div_AadharStatus.ClientID%>').html("");
                    $("#btn_Aadharsubmit").css("display", "none");
                    $('#<%=div_ImgAadharFront.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/AadharImage/Front/' + data.d.AadharFront + '"> <img src="../images/KYC/AadharImage/Front/' + data.d.AadharFront + '" style="width:350px; height:200px;"/> </a>');
                    $('#<%=div_ImgAadharBack.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/AadharImage/Back/' + data.d.AadharBack + '"> <img src="../images/KYC/AadharImage/Back/' + data.d.AadharBack + '" style="width:350px; height:200px;"/> </a>');

                    if (data.d.AaStatus == "1") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                    }
                    else if (data.d.AaStatus == "2" || data.d.OnlineAadharVerify == "1") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
                    }
                    else if (data.d.AaStatus == "0") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                    }
                    else {--%>
<%--                        $('#<%=div_bankStatus.ClientID%>').html('<img src="../images/KYC/BankImage/"' + data.d.BankImage + '"/>');--%>

                       <%-- $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/KYC/AadharImage/Front/"' + data.d.AadharFront + '"/>');
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/KYC/AadharImage/Back/"' + data.d.AadharBack + '"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                    }--%>
                    /* 
                     data.d.PanImage 
                     data.d.bankstatus
                     data.d.BankImage
                     data.d.AadharFront
                     data.d.AadharBack
                     data.d.AaStatus
                     */

                    
                    <%--$('#<%=ddl_Countries.ClientID%>').val(data.d.did);--%>
                    $('#<%=ddlState.ClientID%>').val(data.d.State);
                    $('#<%=txtCity.ClientID%>').val(data.d.City);
                   // var StateVal = data.d.Statename;
                   // var CityVal = data.d.City;
                   
                    //Getstate(StateVal);
                    //CityList(CityVal);
                    GetDistrict(data.d.did);
                   <%-- await Getstate().then(function () {
                        debugger;

                        $('#<%=ddlState.ClientID%>').val(StateVal);
                        await CityList().then(function () {
                            debugger;
                            $('#<%=ddl_City.ClientID%>').text(CityVal);
                        });
                    }); --%>

                },
                error: function (response) {
                }
            });
        }
        // Getstate   ddlState  CityList  ddl_City

        function GetDistrict(District) {
            $('#<%=ddlDistrict.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
             $.ajax({
                 type: "POST",
                 url: 'Edit_Profile.aspx/GetDistrict',
                 data: "{'StateId':'" + $("#<%=ddlState.ClientID%>").val() + "'}",
         contentType: "application/json; charset=utf-8",
         dataType: "json",
         success: function (response) {
             $("#<%=ddlDistrict.ClientID %>").empty().append($("<option></option>").val('').html('Select District'));
             PopulateControl(response.d, $("#<%=ddlDistrict.ClientID%>"));
             if (District != '') {
                 $("#<%=ddlDistrict.ClientID%>").val(District);
             }
         },
         failure: function (response) {
             alert(response.d);
         }
     });
         }

        function btnRejectKYC_Click(id) {
            if (!confirm('Are you sure you want to delete the current KYC Details?')) {
                return false;
            }
            var Userid = $('#<%=lblid.ClientID%>').text();
            //div_ImgBank div_ImgAadharFront div_ImgAadharBack
            if ($('#<%=div_ImgPan.ClientID%>').attr('src') != '' || $('#<%=div_ImgBank.ClientID%>').attr('src') != '' || $('#<%=div_ImgAadharFront.ClientID%>').attr('src') != '' || $('#<%=div_ImgAadharBack.ClientID%>').attr('src') != '') {
                if (id == '1' || id == '2' || id == '3') {
                    $.ajax({
                        type: "POST",
                        url: 'Edit_Profile.aspx/UpdateReject',
                        data: '{kycid: "' + id + '", Userid: "' + Userid + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (id = '1') {
                                alert("Pan Rejected Successfully.")
                            }
                            else if (id == '2') {
                                alert("Bank Rejected Successfully.")
                            }
                            else if (id == '3') {
                                alert("Aadhaar Rejected Successfully.")
                            }
                           <%--  if (id == '1') {
                                 $('#<%=txtPANDetails.ClientID%>').val('');
                                 $('#<%=div_ImgPan.ClientID%>').val('');
                         $('#<%=FU1.ClientID%>').removeAttr('disabled');
                         $('#<%=imgUpload.ClientID%>').attr("src", "");
                         $('#<%=approveRejectimg.ClientID%>').attr("src", "../images/pendingStamp.png");
                         $('#<%=btnreject.ClientID%>').css('display', 'none');
                         $('#<%=btn_Pan_A.ClientID%>').css('display', 'none');
                         $('body').css('overflow', 'auto');
                     }
                     else if (id == '2') {
                         $('#<%=txtbranch.ClientID%>').val('');
                         $('#<%=txtifs.ClientID%>').val('');
                         $('#<%=txtAccNo.ClientID%>').val('');
                         $('#<%=ddlBankName.ClientID%>').val('');
                         $('#<%=ddlAcType.ClientID%>').val('');
                         $('#<%=fileCancelCq.ClientID%>').removeAttr('disabled');
                         $('#<%=imgUpload1.ClientID%>').attr("src", "");
                         $('#<%=approveRejectImg1.ClientID%>').attr("src", "../images/pendingStamp.png");
                         $('#<%=btnreject1.ClientID%>').css('display', 'none');
                         $('#<%=btn_BANK_A.ClientID%>').css('display', 'none');
                         $('body').css('overflow', 'auto');
                     }
                     else if (id == '3') {
                         $('#<%=txtAadharNo.ClientID%>').val('');
                         $('#<%=FU2.ClientID%>').removeAttr('disabled');
                         $('#<%=FU3.ClientID%>').removeAttr('disabled');
                         $('#<%=imgUpload2.ClientID%>').attr("src", "");
                         $('#<%=imgUpload3.ClientID%>').attr("src", "");
                         $('#<%=approveRejectImg2.ClientID%>').attr("src", "../images/pendingStamp.png");
                         $('#<%=btnreject2.ClientID%>').css('display', 'none');
                         $('#<%=btn_AADHAR_A.ClientID%>').css('display', 'none');
                         $('body').css('overflow', 'auto');
                     }--%>
                            /* window.location = window.location.href;*/
                            GetDetail();
                        },
                        error: function (response) {
                            alert("Server error. Time out.!!");

                        }
                    });
                }

            }
        }

        function btnApproveKYC_Click(id) {
            if (!confirm('Are you sure you want to approved.!!')) {
                return false;
            }
            if (id == '1' || id == '2' || id == '3') {
                regno = $('#<%=lblid.ClientID%>').html();
                name = $('#<%=txtfname.ClientID%>').html();
                mobile = $('#<%=txtMobile.ClientID%>').html();
                $.ajax({
                    type: "POST",
                    url: 'Edit_Profile.aspx/btnApproveKYC_Click',
                    data: '{kycid: "' + id + '",regno: "' + regno + '",name: "' + name + '",mobile: "' + mobile + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (id == '1') {
                            alert("Pan Approved Successfully.");
                           // GetDetail();
                            <%--$("#DivPA").css("display", "none");
                            $('#<%=txtPANDetails.ClientID%>').removeAttr('readonly');
                            $('body').css('overflow', 'auto');
                            $('.modal-backdrop.in').hide();--%>
                        }
                        else if (id == '2') {
                            alert("Bank Approved Successfully.");
                           <%-- $("#DivBA").css("display", "none");
                            $('#<%=txtbranch.ClientID%>').removeAttr('disabled');
                            $('#<%=txtifs.ClientID%>').removeAttr('disabled');
                            $('#<%=txtAccNo.ClientID%>').removeAttr('disabled');
                            $('#<%=ddlBankName.ClientID%>').removeAttr('disabled');
                            $('#<%=ddlAcType.ClientID%>').removeAttr('disabled');
                            $('body').css('overflow', 'auto');
                            $('.modal-backdrop.in').hide();--%>
                        }
                        else if (id == '3') {
                            alert("Aadhaar Approved Successfully.");
                            <%--$("#DivAa").css("display", "none");
                            $("#myModal").css("display", "none");
                            $('#<%=txtAadharNo.ClientID%>').removeAttr('disabled');
                            $('body').css('overflow', 'auto');
                            $('.modal-backdrop.in').hide();--%>
                        }
                        GetDetail();
                    },
                    error: function (response) {
                        $('.modal-backdrop.in').css("opacity", 0);
                    }
                });
            }
        }

        var ImgName_Aadhar_Back = "";
        var ImgName_Aadhar_Front = "";
        function Upload_Aadhar() {

            var AdhaarNo = $('#<%=txtAadharNo.ClientID%>').val();
            if (AdhaarNo == "") {
                alert('Please Enter Aadhaar No.');
                return false;
            }

            Upload_Aadhar_Front().then(function () {

                Upload_Aadhar_Back().then(function () {

                   

                    //public void insertAddressProof(string filename1, string filename2, string usrId, string aadharText, out string imgFront, out string imgBack, out string msg)
                    let Id = $('#<%=hdn_userid.ClientID%>').val();
                    $.ajax({
                        type: "POST",
                        url: 'Edit_Profile.aspx/Upload_Aadhar',

                        data: '{ImgName_Aadhar_Front: "' + ImgName_Aadhar_Front + '", ImgName_Aadhar_Back: "' + ImgName_Aadhar_Back + '", AdhaarNo: "' + AdhaarNo + '", Id: "' + Id + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alert("Aadhaar Details Updated Successfully.")
                            GetDetail();
                        },
                        failure: function (response) { alert(response.d); }
                    });
                });

            });
        }


        async function Upload_Aadhar_Front() {

            var AdhaarNo = $('#<%=txtAadharNo.ClientID%>').val();
            var fileUpload = $("#img_Aadhar_Front").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 99999999);
                random = "Aadhar_Front" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Aadhar_Front = random + '.' + ext;
                }

                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../Upload_Aadhar_Front.ashx",
                    type: "POST",
                    data: data,
                    async: "false",
                    contentType: false,
                    processData: false,
                    success: function (result) { return 1; },
                    error: function (err) { return 0; }
                });

            }
        }


        async function Upload_Aadhar_Back() {
            var fileUpload = $("#img_Aadhar_Back").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 99999999);
                random = "Aadhar_Back" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Aadhar_Back = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../Upload_Aadhar_Back.ashx",
                    type: "POST",
                    data: data,
                    async: "false",
                    contentType: false,
                    processData: false,
                    success: function (result) { return 1; },
                    error: function (err) { return 0; }
                });
            }
        }

        function AllKYC_Reject() {
            if (!confirm('Are you sure you want to reject KYC？')) {
                return false;

            }
            let UId = $('#<%=hdn_userid.ClientID%>').val();
            if (UId == "") {
                alert("There is  no User Id!!");
                return false;
            }
            $.ajax({
                type: "POST",
                url: 'Edit_Profile.aspx/AllKYC_Reject',
                data: '{UId: "' + UId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                   
                        alert(data.d);
                        
                    GetDetail();
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function UpdatePersonal() {

            
            //DropDownList1, txtfname, ddlGtitle, txtGName, RdoGenderNew, txtDOB, txtMobile, txt_Alt_MobNo, ddl_Countries,
           //    ddlState, ddl_City, txtAddress, txtpincode, txtEmail, txt_DOJ, txtnomniName, txtrelation
            let UId = $('#<%=hdn_userid.ClientID%>').val();
          <%--  let UTitle = $('#<%=DropDownList1.ClientID%>').val();--%>
            <%--GTitle = $('#<%=ddlGtitle.ClientID%>').val();
            GName = $('#<%=txtGName.ClientID%>').val(); --%>
            UName = $('#<%=txtfname.ClientID%>').val();
            Gender = $('#<%=RdoGenderNew.ClientID %> input[type=radio]:checked').val();
            <%--Gender = $('#<%=RdoGenderNew.ClientID%>').val();--%>
            DOB = $('#<%=txtDOB.ClientID%>').val();
            Mob = $('#<%=txtMobile.ClientID%>').val();
            Alt_Mob = $('#<%=txt_Alt_MobNo.ClientID%>').val();

            Email = $('#<%=txtEmail.ClientID%>').val();
            Address = $('#<%=txtAddress.ClientID%>').val();
            DOJ = $('#<%=txt_DOJ.ClientID%>').val();
            
            /*Country = '';*/
           <%-- Country = $('#<%=ddl_Countries.ClientID%> option:selected').text();--%>
            State = $('#<%=ddlState.ClientID%> option:selected').text();
            City = $('#<%=txtCity.ClientID%>').val();
            District = $('#<%=ddlDistrict.ClientID%> option:selected').text(); 
            PinCode = $('#<%=txtpincode.ClientID%>').val();
            /*PinArea = $('#div_City').text();*/
            Nom_Name = $('#<%=txtnomniName.ClientID%>').val();
            Relation = $('#<%=txtrelation.ClientID%>').val();
            PSWRD = $('#<%=txt_PSWRD.ClientID%>').val();
            Sponsor_Status = $('#<%=rbtnlstActivate.ClientID %> input[type=radio]:checked').val() 

            if (UName == "") {
                alert("Please Enter User Name.!!")
                return false;
            }
            if (Gender == "") {
                alert("Please Enter Gender.!!")
                return false;
            }
            if (DOB == "") {
                alert("Please Enter Date Of Birth.!!")
                return false;
            }
            if (Mob == "") {
                alert("Please Enter Mobile No..!!")
                return false;
            }
            if (Address == "") {
                alert("Please Enter Address.!!")
                return false;
            }
            if (State == "") {
                alert("Please Select State.!!")
                return false;
            }
            if (City == "") {
                alert("Please Enter City.!!")
                return false;
            }
            if (District == "") {
                alert("Please Select District.!!")
                return false;
            }
            if (PinCode == "") {
                alert("Please Enter PinCode.!!")
                return false;
            }
            if (Email == "") {
                alert("Please Enter Email Id.!!")
                return false;
            }
            if (PSWRD == "") {
                alert("Please Enter Password.!!")
                return false;
            }
           
            $.ajax({
                type: "POST", 
                url: 'Edit_Profile.aspx/UpdatePersonal',
                data: '{ UId: "' + UId + '", UName: "' + UName + '", Gender: "' + Gender
                    + '", DOB: "' + DOB + '", Email: "' + Email + '", Address: "' + Address + '", District: "' + District + '", State: "' + State
                    + '", City: "' + City + '", PinCode: "' + PinCode + '", Nom_Name: "' + Nom_Name + '", Relation: "' + Relation
                    + '", Mob: "' + Mob + '", Sponsor_Status: "' + Sponsor_Status + '", PSWRD: "' + PSWRD + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Profile edited successfully!");
                        GetDetail();
                    }
                },
                error: function (response) {
                }
            });


        }


       <%-- function Getstate(StateVal) {



            $('#<%=ddlState.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
            $.ajax({
                type: "POST",
                url: '../Service.aspx/Getstate',
                data: "{'CId':'" + $("#<%=ddl_Countries.ClientID%>").val() + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     
                     $("#<%=ddlState.ClientID %>").empty().append($("<option></option>").val('').html('Select State'));
                     PopulateControl(response.d, $("#<%=ddlState.ClientID%>"));
                     if (StateVal != '') {
                         $('#<%=ddlState.ClientID %> option:selected').text(StateVal);
                     }
                 },
                 failure: function (response) { alert(response.d); }
             });
        }--%>

   <%--     function CityList(CityVal) {
            $('#<%=ddl_City.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
            $.ajax({
                type: "POST",
                url: '../Service.aspx/GetCity',
                data: "{'SId':'" + $("#<%=ddlState.ClientID%>").val() + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                    
                     $("#<%=ddl_City.ClientID %>").empty().append($("<option></option>").val('').html('Select City'));
                     PopulateControl(response.d, $("#<%=ddl_City.ClientID%>"));
                     if (CityVal != '') {
                         $('#<%=ddl_City.ClientID %> option:selected').text(CityVal);
                     }
                 },
                 failure: function (response) { alert(response.d); }
             });
        }--%>


        $JD("[id*=img_Pan]").change(function () {
            $('#<%=div_ImgPan.ClientID%>').css("display", "block");
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_ImgPan.ClientID%>');
                dvPreview.html("");
                $($(this)[0].files).each(function () {
                    var file = $(this);
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img />");
                            img.attr("style", "height:250px;width:430px");
                            img.attr("src", e.target.result);
                            dvPreview.append(img);
                        }
                        reader.readAsDataURL(file[0]);
                   
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });


        $JD("[id*=img_Bank]").change(function () {
            $('#<%=div_ImgBank.ClientID%>').css("display", "block");
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_ImgBank.ClientID%>');
                dvPreview.html("");
                /*var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;*/
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    /*if (regex.test(file[0].name.toLowerCase())) {*/
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img />");
                            img.attr("style", "height:400px;width:430px");
                            img.attr("src", e.target.result);
                            dvPreview.append(img);
                        }
                        reader.readAsDataURL(file[0]);
                    //} else {
                    //    alert(file[0].name + " is not a valid image file.");
                    //    dvPreview.html("");
                    //    $('#img_Bank').val('');
                    //    return false;
                    //}
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });
       

        $JD("[id*=img_Aadhar_Front]").change(function () {
            $('#<%=div_ImgAadharFront.ClientID%>').css("display", "block");
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_ImgAadharFront.ClientID%>');
                dvPreview.html("");
               /* var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;*/
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    /*if (regex.test(file[0].name.toLowerCase())) {*/
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img />");
                            img.attr("style", "height:250px;width:430px");
                            img.attr("src", e.target.result);
                            dvPreview.append(img);
                        }
                        reader.readAsDataURL(file[0]);
                    //} else {
                    //    alert(file[0].name + " is not a valid image file.");
                    //    dvPreview.html("");
                    //    $('#img_Aadhar_Front').val('');
                    //    return false;
                    //}
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });


        $JD("[id*=img_Aadhar_Back]").change(function () {
            $('#<%=div_ImgAadharBack.ClientID%>').css("display", "block");
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_ImgAadharBack.ClientID%>');
                dvPreview.html("");
                /*var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;*/
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    /*if (regex.test(file[0].name.toLowerCase())) {*/
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img />");
                            img.attr("style", "height:250px;width:430px");
                            img.attr("src", e.target.result);
                            dvPreview.append(img);
                        }
                        reader.readAsDataURL(file[0]);
                    //} else {
                    //    alert(file[0].name + " is not a valid image file.");
                    //    dvPreview.html("");
                    //    $('#img_Aadhar_Back').val('');
                    //    return false;
                    //}
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });

        async function Upload_Pan() {
            let Id = $('#<%=hdn_userid.ClientID%>').val();
            var PANNo = $('#<%=txtPANDetails.ClientID%>').val();
            var fileUpload = $("#img_Pan").get(0);
            var files = fileUpload.files;
            let ImgName_Pan = "";
            if (PANNo == "") {
                alert('Please Enter PAN No.');
                return false;
            }
            if (PANNo != "") {
                if (!validatePAN(PANNo)) {
                    alert('Please Enter Valid PAN No.');
                    return false;
                }
            }
            if (files != null) {
                var data = new FormData();
                var random = "Pan" + Math.floor(100000 + Math.random() * 99999999);
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();
                    data.append(random + '.' + ext, files[i]);
                    ImgName_Pan = random + '.' + ext;
                }
                $.ajax({
                    type: "POST",
                    url: 'Edit_Profile.aspx/Upload_Pan',
                    data: '{PANNo: "' + PANNo + '", ImgName_Pan: "' + ImgName_Pan + '", Id: "' + Id + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        var _URL = window.URL || window.webkitURL;
                        $.ajax({
                            url: "../Upload_Pan.ashx",
                            type: "POST",
                            data: data,
                            async: "false",
                            contentType: false,
                            processData: false,
                            success: function (result) {
                                alert("Pan Details Updated Successfully.")
                                GetDetail();
                            },
                            error: function (err) { return 0; }
                        });
                    },
                    failure: function (response) { alert(response.d); }
                });
            }
            else {
                alert('Please Select PAN Image.');
                return false;
            }
        }

        async function Upload_Bank() {
           
            var ImgName_Bank = '';
            let Id = $('#<%=hdn_userid.ClientID%>').val();
            var Bank_Name = $('#<%=ddlBankName.ClientID%>').val();
            var Acc_Type = $('#<%=ddlAcType.ClientID%>').val();
            var Acc_No = $('#<%=txtAccNo.ClientID%>').val();
            var Branch = $('#<%=txtbranch.ClientID%>').val();
            var IFSC = $('#<%=txtifs.ClientID%>').val();
            if (Bank_Name == "") {
                alert('Please Select Bank Name');
                return false;
            }
            if (Acc_Type == "") {
                alert('Please Select Account Type');
                return false;

            }
            if (Acc_No == "") {
                alert('Please Enter Account No.');
                return false;
            }
            if (Branch == "") {
                alert('Please Enter Branch Name');
                return false;
            }
            if (IFSC == "") {
                alert('Please Enter IFSC Code');
                return false;
            }
            if (IFSC != "") {
                if (!isValid_IFSC(IFSC)) {
                    alert('Please Enter Valid IFSC Code');
                    return false;
                }
            }
            /* ddlBankName, ddlAcType, txtAccNo, txtbranch, txtifs*/
            var fileUpload = $("#img_Bank").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 99999999);
                random = "Bank" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Bank = random + '.' + ext;
                }

                $.ajax({
                    type: "POST",
                    url: 'Edit_Profile.aspx/Upload_Bank',

                    data: '{ ImgName_Bank: "' + ImgName_Bank + '",Bank_Name: "' + Bank_Name + '", Acc_Type: "' + Acc_Type + '", Acc_No: "' + Acc_No + '",IFSC: "' + IFSC + '", Branch: "' + Branch + '", Id: "' + Id + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {



                        var _URL = window.URL || window.webkitURL;
                        $.ajax({
                            url: "../Upload_Bank.ashx",
                            type: "POST",
                            data: data,
                            async: "false",
                            contentType: false,
                            processData: false,
                            success: function (result) {
                                alert("Bank Details Updated Successfully.")
                                GetDetail();
                            },
                            error: function (err) { return 0; }
                        });
                    },
                    failure: function (response) { alert(response.d); }
                });

            }
            else {
                alert('Please Select Bank Image.');
                return false;
            }
        }


        function PopulateControl(list, control) {
            if (list.length > 0) {

                $.each(list, function () {
                    control.append($("<option></option>").val(this['Value']).html(this['Text']));
                });
            }
            else { control.empty().append('<option selected="selected" value="">Not available<option>'); }
        }

        function validatePAN(pan) {
            var regex = /[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
            return regex.test(pan);
        }

        function isValid_IFSC(IFSC) {
            let pattern = new RegExp(/[A-Z|a-z]{4}[0][a-zA-Z0-9]{6}$/);
            return pattern.test(IFSC);
        };

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }
    </script>
     <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
 <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
 <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>

    <style>
        .btn {
    width: 120px;
}
        .btn-green {
    background: green;
    color: #fff;
}
        .btn-green:hover {
        color: #fff;
        }
        .form-group {
            margin-bottom: 0px;
        }

        .panel-default > .panel-heading {
            border-color: #e5e5e5;
            color: #fff;
        }


        #Div2:before {
            content: '';
            display: inline-block;
            height: 35%;
            vertical-align: middle;
        }

        #Div2-dialog {
            display: inline-block;
            vertical-align: middle;
        }

        #Div2 #Div2-content {
            padding: 20px 20px 20px 20px;
            -webkit-animation-name: modal-animation;
            -webkit-animation-duration: 0.5s;
            animation-name: modal-animation;
            animation-duration: 0.5s;
        }

        #Div1:before {
            content: '';
            display: inline-block;
            height: 55%;
            vertical-align: middle;
        }

        #Div1-dialog {
            display: inline-block;
            vertical-align: middle;
        }

        #Div1 #Div1-content {
            padding: 20px 20px 20px 20px;
            -webkit-animation-name: modal-animation;
            -webkit-animation-duration: 0.5s;
            animation-name: modal-animation;
            animation-duration: 0.5s;
        }

        [dir=ltr] .modal-backdrop {
            position: relative;
        }
        /* Styling modal */
        #myModal:before {
            content: '';
            display: inline-block;
            height: 80%;
            vertical-align: middle;
        }

        #myModal-dialog {
            display: inline-block;
            vertical-align: middle;
        }

        #myModal #myModal-content {
            padding: 20px 20px 20px 20px;
            -webkit-animation-name: modal-animation;
            -webkit-animation-duration: 0.5s;
            animation-name: modal-animation;
            animation-duration: 0.5s;
        }

        @-webkit-keyframes modal-animation {
            from {
                top: -100px;
                opacity: 0;
            }

            to {
                top: 0px;
                opacity: 1;
            }
        }

        @keyframes modal-animation {
            from {
                top: -100px;
                opacity: 0;
            }

            to {
                top: 0px;
                opacity: 1;
            }
        }

        .panel-heading {
            font-size: 24px;
            padding: 7px;
            background: #fcddc3;
            color: #fff;
            margin: 10px 0;
        }

        h3.panel-title {
            color: #444;
            margin: 0px;
        }
    </style>

    <style>
        .coin-tabs .nav-tabs .nav-item .nav-link {
            border: 0;
            border-radius: 0rem;
            font-size: 1rem;
            padding: 0.5rem 1rem;
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
            border: 1px solid #fe6a00;
            margin-right: 5px;
        }

        .fade {
            transition: opacity .2s linear;
        }
    </style>

</asp:Content>

