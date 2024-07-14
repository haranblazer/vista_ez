<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="Change_Profile.aspx.cs" Inherits="user_Change_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Change Your Profile</h4>
        <a href="Dashboard.aspx" class="btn btn-primary pull-right">Dashboard</a>
    </div>

    <div class="" id="user-activity1">
        <div class="card-header border-0 p-0">
            <div class="card-action coin-tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active " data-bs-toggle="tab" href="#personal_details" role="tab" aria-selected="true">Personal Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#pan_details" role="tab" aria-selected="false">Pan Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#bank_details" role="tab" aria-selected="false">Bank Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#aadhar_details" role="tab" aria-selected="false">Aadhar Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#gst_details" role="tab" aria-selected="false">GST Details </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="card-body p-0">
        <div class="tab-content" id="myTabContent">

            <div class="tab-pane d-block">
                <div class="col-sm-9 text-center" id="confirm" style="display: none;" runat="server">
                    <div class="alert alert-warning alert-dismissible" role="alert"><strong>Alert! </strong>You will not be able Update Personal details again. Thanks for updating or Refresh the page.</div>
                </div>

                <div class="row">

                    <div class="col-md-6 card-group-row row">
                        <div class="col-md-3 control-label">
                            Type 
                        </div>
                        <div class="col-md-8">
                            <asp:RadioButtonList ID="rdo_Indiv_Comp" runat="server" CssClass="form-control"
                                RepeatDirection="Horizontal" onchange="GetIndiv_Comp();" Enabled="false">
                                <asp:ListItem Value="0" Selected="True">Individual &nbsp;</asp:ListItem>
                                <asp:ListItem Value="1">Company /Firm</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>


                    <div class="col-md-6 card-group-row row">
                        <div class="col-md-3 control-label">
                            UserID 
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblid" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-6 card-group-row row">
                        <div class="col-md-3 control-label">
                            User  Name 
                        </div>

                        <div class="col-md-8">
                            <asp:Label ID="lbl_username" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div>

                </div>

            </div>


            <%-- personal details--%>
            <div class="tab-pane fade active show" id="personal_details">
                <div class="panel-heading">
                    <h3 class="panel-title"><font style=""><i class="fa fa-user-circle" aria-hidden="true"></i><strong>&nbsp;Personal
                        Details</strong></font></h3>
                </div>
                <div class="row">
                    <div class="col-md-6 card-group-row row  d-none">
                        <!-- Input Group Start -->
                        <div class="col-md-3 control-label">
                            Name<span style="color: Red">*</span>
                        </div>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>

                            <asp:DropDownList ID="title" runat="server" CssClass="form-control" Enabled="false"
                                Style="display: none; max-width: 100%;">
                                <asp:ListItem Value="Mr.">Mr.</asp:ListItem>
                                <asp:ListItem Value="Mrs.">Mrs.</asp:ListItem>
                                <asp:ListItem Value="Ms.">Ms.</asp:ListItem>
                                <asp:ListItem Value="Dr.">Dr.</asp:ListItem>
                                <asp:ListItem Value="Md.">Md.</asp:ListItem>
                                <asp:ListItem Value="M/S">M/S</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                </div>


                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        <span id="lbl_OwnerName"></span>
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox ID="txt_OwnerName" runat="server" Width="100%" CssClass="form-control"
                            placeholder="Enter Owner Name" MaxLength="30" autocomplete="off" Style="display: none;"></asp:TextBox>
                    </div>
                </div>


                <%--<div class="col-md-6 card-group-row row">
     <div class="col-md-3 control-label">
         Display Name<span style="color: Red">*</span>
     </div>
     <div class="col-md-8 control-label">
          <asp:TextBox ID="txt_DisplayName" onpaste="return false" runat="server" CssClass="form-control">
 </asp:TextBox>
     </div>
 </div>--%>

                <div class="col-md-6 card-group-row row" style="display: none;">
                    <div class="col-md-3 control-label">
                        Father Name<span style="color: Red;">*</span>
                    </div>

                    <div class="col-md-9">
                        <div class="d-flex">
                            <div class="col-md-2 col-xs-4">
                                <asp:DropDownList ID="ddlGtitle" runat="server" CssClass="form-control" Style="max-width: 100%;">
                                    <asp:ListItem>S/O</asp:ListItem>
                                    <asp:ListItem>D/O</asp:ListItem>
                                    <asp:ListItem>W/O</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-8 col-xs-8">

                                <asp:TextBox ID="txtGName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        <span id="lbl_dob">DOB <span style="color: Red">*</span></span>
                    </div>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtDOB" runat="server" ReadOnly="true" MaxLength="10" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        <span id="lbl_Genders">Gender <span style="color: red">*</span> </span>
                    </div>
                    <div class="col-md-8 control-label">
                        <asp:RadioButtonList ID="RdoGenderNew" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem class="txt" Selected="True" Value="0">Male</asp:ListItem>
                            <asp:ListItem class="txt" Value="1">Female</asp:ListItem>
                            <asp:ListItem class="txt" Value="2">Others</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>

                <div class="clearfix"></div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        Mobile<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtMobile" runat="server" MaxLength="10" Enabled="false" CssClass="form-control"
                            onkeypress="return onlyNumbers(event,this);" ToolTip="Mobile no. should be 10 digits!"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        Email
                    </div>
                    <div class="col-md-8">


                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        Address<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" ValidationGroup="v"
                            CssClass="form-control" onkeypress="return CheckPassword();" MaxLength="400"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        State<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-8">
                        <asp:DropDownList ID="ddlState" runat="server" onchange="GetDistrict()" CssClass="form-control" Enabled="true">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        City<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        District<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-8">

                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" TabIndex="7">
                        </asp:DropDownList>

                    </div>
                </div>
                <div class="clearfix"></div>

                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        Pin Code<span style="color: Red">*</span>
                    </div>

                    <div class="col-md-8">
                        <asp:TextBox ID="txtpincode" runat="server" ValidationGroup="v" CssClass="form-control"
                            onkeypress="return onlyNumbers(event,this);" ToolTip="Please Enter  Number Only!" MaxLength="6"></asp:TextBox>
                    </div>
                </div>


                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        Password<span style="color: Red">*</span>
                    </div>
                    <div class="col-md-8">
                        <asp:TextBox ID="txt_PSWRD" runat="server" CssClass="form-control">
                        </asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="panel-heading">
                <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Nominee Details </strong>
                </font></h3>
            </div>
            <div class="form-group row">
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        Nominee Name
                    </div>


                    <div class="col-md-8">
                        <asp:TextBox ID="txtnomniName" runat="server" CssClass="form-control"
                            MaxLength="30" placeholder="Enter Nominee Name"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-3 control-label">
                        Relation
                    </div>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtrelation" runat="server" CssClass="form-control" MaxLength="30"
                            placeholder="Enter Nominee Relation"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 card-group-row row">
                    <div class="col-md-8">
                        <input type="button" id="btn_submit" onclick="UpdatePersonal()" class="btn btn-primary" runat="server" value="Submit" />
                    </div>
                </div>
            </div>
            <%-- <div class="panel-heading">
                    <h3 class="panel-title"><font><i class="fa fa-lock" aria-hidden="true"></i><strong>&nbsp;Security Details </strong>
                    </font></h3>
                </div>

                <div class="form-group row">

                    <div class="clearfix"></div>
                    <div class="col-md-3 form-group">
                        <asp:TextBox ID="txtotp" runat="server" MaxLength="10" Style="background-color: transparent;" CssClass="form-control"
                            placeholder="Plz. Enter OTP"></asp:TextBox>
                    </div>
                    <div class="col-md-5 form-group">
                        <div runat="server" id="ottp">
                            <a id="btn_otp" href="#/" cssclass="btn btn-success" onclick="GetOTP()">Generate OTP</a>

                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" />
                        </div>
                    </div>

                    <a id="vOTP" style="display: none;" class="btn btn-outline-info" onclick="GetOTPverified()">Verify OTP</a>






                    <div class="clearfix">
                    </div>



                </div>--%>
        </div>


        <%-- pan card details--%>
        <div class="tab-pane fade" id="pan_details">
            <div class="panel-heading">
                <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;PAN Details </strong>
                </font></h3>
            </div>
            <div class="row">
                <div class="col-md-2 control-label">
                    Enter PAN No:<span style="color: Red">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPANDetails" runat="server" CssClass="form-control" placeholder="Enter PAN Number" MaxLength="10"></asp:TextBox>
                </div>
                <div class="col-sm-2 control-label">
                    Upload Image: 
                </div>
                <div class="col-sm-4">
                    <div class="input-group">
                        <div class="form-file">
                            <input type="file" id="img_Pan" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                            <label for="img_Pan" title="Pan Card" class="btn"><i class="fa fa-upload" aria-hidden="true"></i></label>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-6">
                        <div id="div_ImgPan" runat="server"></div>
                    </div>
                    <div class="col-md-4">
                        <div id="div_Pan_Status" runat="server" style="width: 200px; height: 200px; overflow: hidden; margin: 0 auto; text-align: center;"></div>
                    </div>
                    <div class="col-md-2">
                        <input type="button" id="btn_Pansubmit" value="Submit" onclick="Upload_Pan();" class="btn btn-success" />
                    </div>
                </div>
            </div>

        </div>
        <%--pan card details end--%>


        <%--Bank details --%>
        <div class="tab-pane fade" id="bank_details">
            <div class="panel-heading">
                <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Bank Details </strong>
                </font></h3>
            </div>
            <asp:Panel ID="Panel1" runat="server">
                <div class="form-group row">
                    <div class="col-md-6 card-group-row row">
                        <div class="col-sm-3 control-label">
                            Upload Cancel Cheque
                        </div>
                        <div class="col-md-9">
                            <div class="input-group">
                                <div class="form-file">
                                    <input type="file" id="img_Bank" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                                    <label for="img_Bank" title="Bank" class="btn"><i class="fa fa-upload" aria-hidden="true"></i></label>

                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-6 card-group-row row">
                        <div class="col-md-3 control-label">
                            Select Bank
                        </div>


                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-6 card-group-row row">
                        <div class="col-md-3 control-label">
                            A/C Type
                        </div>
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlAcType" runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                                <asp:ListItem Value="SAVING A/C">SAVING A/C</asp:ListItem>
                                <asp:ListItem Value="CURRENT A/C">CURRENT A/C</asp:ListItem>
                                <asp:ListItem Value="CC A/C">CC A/C</asp:ListItem>
                                <asp:ListItem Value="OD A/C">OD A/C</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-6 card-group-row row">
                        <div class="col-md-3 control-label">
                            A/C No.
                        </div>
                        <div class="col-md-9">
                            <div class="tooltiptest">
                                <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 card-group-row row">
                        <div class="col-md-3 control-label">
                            Branch
                        </div>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-6 card-group-row row">
                        <div class="col-sm-3 control-label">
                            IFS Code
                        </div>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtifs" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-sm-2"></div>

                    <div class="clearfix"></div>
                    <br />

                </div>

                <div class="col-sm-12">
                    <div class="card-group-row">
                        <div class="col-sm-6">
                            <div id="div_ImgBank" runat="server"></div>
                        </div>
                        <div class="col-md-4">
                            <div id="div_bankStatus" runat="server" style="width: 200px; height: 200px; overflow: hidden; margin: 0 auto; text-align: center;"></div>
                        </div>
                        <div class="col-sm-2">
                            <input type="button" id="btn_Banksubmit" value="Submit" onclick="Upload_Bank();" class="btn btn-success" />
                        </div>
                    </div>

                </div>

            </asp:Panel>
            <%-- bank details end--%>
        </div>


        <%--Aadhar Details start--%>

        <div class="tab-pane fade" id="aadhar_details">
            <div class="panel-heading">
                <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Address Details </strong>
                </font></h3>
            </div>

            <div class="alert alert-primary alert-dismissible fade show">

                <strong>&nbsp;Note:</strong> Please upload front as well as back image of Address Proof.
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                        </button>
            </div>



            <div class="col-sm-4 text-center" id="Div3" runat="server">
            </div>

            <div class="card-group-row row">
                <div class="col-md-6 row">
                    <div class="col-sm-3 control-label">
                        Address Proof ID:
                    </div>
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtAadharNo" runat="server" onkeypress="return onlyNumbers(event,this);" MaxLength="12" MinLength="12" CssClass="form-control"
                            placeholder="Please Enter Aadhar Number"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-6 row">
                    <div class="col-sm-3 control-label">
                        Front Image   
                    </div>
                    <div class="col-sm-9">
                        <div class="input-group">
                            <div class="form-file">
                                <input type="file" id="img_Aadhar_Front" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                                <label for="img_Aadhar_Front" title="Aadhar Card Front" class="btn"><i class="fa fa-upload" aria-hidden="true"></i></label>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div id="div_ImgAadharFront" runat="server"></div>
                    </div>
                </div>

                <div class="col-md-6 row">
                    <div class="col-sm-3 control-label">
                        Back Image    
                    </div>
                    <div class="col-sm-9">
                        <div class="input-group">
                            <div class="form-file">
                                <input type="file" id="img_Aadhar_Back" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                                <label for="img_Aadhar_Back" title="Aadhar Card Back" class="btn"><i class="fa fa-upload" aria-hidden="true"></i></label>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div id="div_ImgAadharBack" runat="server"></div>
                    </div>
                    <div id="div_AadharStatus" runat="server" style="width: 200px; height: 200px; overflow: hidden; margin: 0 auto; text-align: center;"></div>
                </div>
            </div>

            <div class="clearfix"></div>

            <br />
            <div class="card-group-row">
                <div class="col-sm-6">
                    <button type="button" id="btnreject2" runat="server" class="btn btn-danger" style="width: max-content; display: none;" onclick="btnRejectKYC_Click('3');">Remove Address Proof</button>
                </div>
                <div class="col-sm-2">
                    <input type="button" id="btn_Aadharsubmit" value="Submit" onclick="Upload_Aadhar();" class="btn btn-success" />
                </div>
            </div>
            <div class="clearfix"></div>
        </div>


        <%-- gst  details--%>
        <div class="tab-pane fade" id="gst_details">
            <div class="panel-heading">
                <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;GST Details </strong>
                </font></h3>
            </div>
            <asp:Panel ID="Panel4" runat="server">
                <div class="form-group row">
                    <div class="col-md-6 card-group-row" style="margin: 0px;">
                        <div class="col-md-4">
                            <label class="control-label" style="text-align: justify">
                                Enter GST No:<span style="color: Red">*</span></label>
                        </div>
                        <div class="col-md-10">
                            <asp:TextBox ID="txt_GSTNo" runat="server" CssClass="form-control" placeholder="Enter GST Number" 
                                onkeypress="return Alphanumeric(event,this);" MaxLength="15" style='text-transform:uppercase'></asp:TextBox>
 


                        </div>
                    </div>
                    <div class="col-md-6 card-group-row" style="margin: 0px;">
                        <div class="col-md-4 control-label">
                            Select Image File : 
                        </div>
                        <div class="col-md-10">
                            <div class="input-group">
                                <div class="form-file">
                                    <%--<asp:FileUpload ID="FU_GST" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.pdf" onchange="ShowImagePreview(this,4);" />--%>
                                    <input type="file" id="img_GST" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                                    <label for="img_GST" title="GST" class="btn">Upload GST Image<i class="fa fa-upload" aria-hidden="true"></i></label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />


                    <div class="col-md-6 card-group-row" style="margin: 0px; width: 480px; height: 500px;">
                        <%-- <asp:Image ID="Img_GST" runat="server" Width="450px" Height="267px" />--%>
                        <div id="div_GST" runat="server"></div>
                    </div>

                    <div class="col-md-6 card-group-row" style="margin: 0px;">
                        <div class="col-md-2">
                            <%--                                <img alt="" src="" runat="server" class="igte_rPayNet_ButtonImg" id="approveReject_GST_Img" style="width: 100px; height: 100px;" />--%>
                            <div id="div_GST_Status" runat="server" style="width: 200px; height: 200px; overflow: hidden; margin: 0 auto; text-align: center;"></div>

                        </div>
                        <%--<div class="col-md-3">
                                <button type="button" id="btn_Reject_GST" runat="server" style="width: max-content; display: none;" class="btn btn-danger" onclick="btnRejectKYC_Click('4');">Reject GST</button>
                            </div>--%>
                        <div class="col-md-4">
                            <input type="button" id="btn_GSTsubmit" value="Submit" onclick="Upload_GST();" class="btn btn-success" />

                        </div>
                        <%--<div class="col-md-4">
                     <button runat="server" id="Button5" onclientclick="return ValidateFile()" title="Crop & Save" class="btn btn-success"
                         validationgroup="vv" style="display: none;" onserverclick="Button5_Click">
                         <i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp;Crop & Submit
                     </button>
                 </div>--%>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </asp:Panel>
            <%--gst details end--%>
        </div>

    </div>

    </div>


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
        });
    </script>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("Change_Profile.aspx")%>';
        $(function () {
            GetDetail();
            $('#<%=txt_PSWRD.ClientID %>').keypress(function (e) {
                if ((e.which >= 48 && e.which <= 57) || (e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122)) { return true; }
                else { return false; }
            });
        });


        function Alphanumeric(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if ((charCode >= 48 && charCode <= 57) || (charCode >= 65 && charCode <= 90)
                || (charCode >= 97 && charCode <= 122)) {
                return true;
            }
            return false;
        }



        function GetIndiv_Comp() {
            let Indiv_Comp = $("input[name='<%=rdo_Indiv_Comp.UniqueID%>']:radio:checked").val();
            if (Indiv_Comp == "0") {
                $('#lbl_OwnerName').html("");
                $('#<%=txt_OwnerName.ClientID%>').hide();
                $('#lbl_dob').html("DOB");
                $('#lbl_Genders').html("Gender <span style='color:red'>*</span>");
                $('#<%=RdoGenderNew.ClientID%>').show();
            } else {
                $('#lbl_OwnerName').html("Owner Name");
                $('#<%=txt_OwnerName.ClientID%>').show();
                $('#lbl_dob').html("Incorporation Date");
                $('#lbl_Genders').html("");
                $('#<%=RdoGenderNew.ClientID%>').hide();
            }
        }


        function GetDetail() {
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetUser',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                   <%-- if (data.d.isProUp == "1") {
                        $('#<%=ddlGtitle.ClientID%>').attr('disabled', true);
                        $('#<%=txtGName.ClientID%>').attr('disabled', true);
                        $('#<%=RdoGenderNew.ClientID%>').attr('disabled', true);
                        $('#<%=txtDOB.ClientID%>').attr('disabled', true);
                        $('#<%=txtEmail.ClientID%>').attr('disabled', true);
                        $('#<%=txtAddress.ClientID%>').attr('disabled', true);
                        $('#<%=ddlState.ClientID%>').attr('disabled', true);
                        $('#<%=txtCity.ClientID%>').attr('disabled', true);
                        $('#<%=ddlDistrict.ClientID%>').attr('disabled', true);
                        $('#<%=txtpincode.ClientID%>').attr('disabled', true);
                        $('#<%=txtnomniName.ClientID%>').attr('disabled', true);
                        $('#<%=txtrelation.ClientID%>').attr('disabled', true);
                        $("#confirm").css("display", "block");
                        $("#btn_submit").css("display", "none");
                    }
                   --%>
                    $('#<%=txt_OwnerName.ClientID%>').val(data.d.GName);

                    $('#<%=rdo_Indiv_Comp.ClientID %>').find("input[value='" + data.d.Indiv_Comp + "']").prop("checked", true);



                    $('#<%=lblid.ClientID%>').text(data.d.Id);
                    $('#<%=lbl_username.ClientID%>').text(data.d.UName);
                    $('#<%=title.ClientID%>').val(data.d.Title);
                    $('#<%=txtFirstName.ClientID%>').val(data.d.Name);
                    $('#<%=ddlGtitle.ClientID%>').val(data.d.GTitle);

                    $('#<%=RdoGenderNew.ClientID %>').find("input[value='" + data.d.Gender + "']").prop("checked", true);
                    $('#<%=txtDOB.ClientID%>').val(data.d.DOB);
                    $('#<%=txtMobile.ClientID%>').val(data.d.Mobile);
                    $('#<%=txtEmail.ClientID%>').val(data.d.Email);
                    $('#<%=txtAddress.ClientID%>').val(data.d.Address);
                    $('#<%=ddlState.ClientID%>').val(data.d.State);
                    $('#<%=ddlDistrict.ClientID%>').val(data.d.District);
                    $('#<%=txtCity.ClientID%>').val(data.d.City);
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
                    $('#<%=txt_GSTNo.ClientID%>').val(data.d.GST);
                    $('#<%=txt_PSWRD.ClientID%>').val(data.d.PSWRD);
                   <%-- $('#<%=txt_DisplayName.ClientID%>').val(data.d.DisplayName);--%>
                    if (data.d.PanImage == "") {
                        $('#<%=div_ImgPan.ClientID%>').css("display", "none");
                    }

                    //Pan
                    $('#<%=div_Pan_Status.ClientID%>').html("");
                    $("#btn_Pansubmit").css("display", "none");
                    $('#<%=div_ImgPan.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/PanImage/' + data.d.PanImage + '"> <img src="../images/KYC/PanImage/' + data.d.PanImage + '" style="width:350px; height:200px;"/> </a>');
                    if (data.d.PStatus == "1") {
                        $('#<%=div_Pan_Status.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Pansubmit").css("display", "block");
                    }
                    else if (data.d.PStatus == "2") {
                        $('#<%=div_Pan_Status.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
                        $("#btn_Pansubmit").css("display", "none");
                    }
                    else if (data.d.PStatus == "0") {
                        $('#<%=div_Pan_Status.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Pansubmit").css("display", "block");
                    }
                    else {
                        $('#<%=div_Pan_Status.ClientID%>').html('<img src="../images/KYC/PanImage/"' + data.d.PanImage + '"/>');
                        $("#btn_Pansubmit").css("display", "block");

                    }
                    //GST
                    //div_GST, div_GST_Status, btn_GSTsubmit
                    if (data.d.GST_Img == "") {
                        $('#<%=div_GST.ClientID%>').css("display", "none");
                    }

                    $('#<%=div_GST_Status.ClientID%>').html("");
                    $("#btn_GSTsubmit").css("display", "none");
                    $('#<%=div_GST.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/PanImage/' + data.d.GST_Img + '"> <img src="../images/KYC/PanImage/' + data.d.GST_Img + '" style="width:350px; height:200px;"/> </a>');
                    if (data.d.GST_Status == "1") {
                        $('#<%=div_GST_Status.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_GSTsubmit").css("display", "block");
                    }
                    else if (data.d.GST_Status == "2") {
                        $('#<%=div_GST_Status.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
                        $("#btn_GSTsubmit").css("display", "none");
                    }
                    else if (data.d.GST_Status == "0") {
                        $('#<%=div_GST_Status.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_GSTsubmit").css("display", "block");
                    }
                    else {
                        $('#<%=div_GST_Status.ClientID%>').html('<img src="../images/KYC/PanImage/"' + data.d.GST_Img + '"/>');
                        $("#btn_GSTsubmit").css("display", "block");

                    }
                    if (data.d.BankImage == "") {
                        $('#<%=div_ImgBank.ClientID%>').css("display", "none");
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
                        $("#btn_Banksubmit").css("display", "none");
                    }
                    else if (data.d.bankstatus == "0") {
                        $('#<%=div_bankStatus.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Banksubmit").css("display", "block");
                    }
                    else {
<%--                        $('#<%=div_Pan_Status.ClientID%>').html('<img src="../images/KYC/PanImage/"' + data.d.PanImage + '"/>');--%>
                        $('#<%=div_bankStatus.ClientID%>').html('<img src="../images/KYC/BankImage/"' + data.d.BankImage + '"/>');
                        $("#btn_Banksubmit").css("display", "block");
                    }

                    if (data.d.AadharFront == "" && data.d.AadharBack == "") {

                        $('#<%=div_ImgAadharFront.ClientID%>').css("display", "none");
                        $('#<%=div_ImgAadharBack.ClientID%>').css("display", "none");
                    }
                    // div_AadharStatus, div_ImgAadharBack, div_ImgAadharFront, btn_Aadharsubmit
                    $('#<%=div_AadharStatus.ClientID%>').html("");
                    $("#btn_Aadharsubmit").css("display", "none");
                    $('#<%=div_ImgAadharFront.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/AadharImage/Front/' + data.d.AadharFront + '"> <img src="../images/KYC/AadharImage/Front/' + data.d.AadharFront + '" style="width:350px; height:200px;"/> </a>');
                    $('#<%=div_ImgAadharBack.ClientID%>').html('<a data-fancybox="gallery" href="../images/KYC/AadharImage/Back/' + data.d.AadharBack + '"> <img src="../images/KYC/AadharImage/Back/' + data.d.AadharBack + '" style="width:350px; height:200px;"/> </a>');

                    if (data.d.AaStatus == "1") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/pendingStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                    }
                    else if (data.d.AaStatus == "2") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/ApproveGreen.png" style="width:50px; height:50px;"/>');
                        $("#btn_Aadharsubmit").css("display", "none");
                    }
                    else if (data.d.AaStatus == "0") {
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/rejectStamp.png" style="width:50px; height:50px;"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                    }
                    else {
<%--                        $('#<%=div_bankStatus.ClientID%>').html('<img src="../images/KYC/BankImage/"' + data.d.BankImage + '"/>');--%>

                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/KYC/AadharImage/Front/"' + data.d.AadharFront + '"/>');
                        $('#<%=div_AadharStatus.ClientID%>').html('<img src="../images/KYC/AadharImage/Back/"' + data.d.AadharBack + '"/>');
                        $("#btn_Aadharsubmit").css("display", "block");
                    }
                    /* 
                     data.d.PanImage 
                     data.d.bankstatus
                     data.d.BankImage
                     data.d.AadharFront
                     data.d.AadharBack
                     data.d.AaStatus
                     */

                    GetDistrict(data.d.did);

                    GetIndiv_Comp();
                },
                error: function (response) {
                }
            });
        }


        async function UpdatePersonal() {

            let Title = $('#<%=title.ClientID%>').val();
            GTitle = $('#<%=ddlGtitle.ClientID%>').val();
            GName = $('#<%=txt_OwnerName.ClientID%>').val();
            Gender = $('#<%=RdoGenderNew.ClientID %> input[type=radio]:checked').val();

            Mobile = $('#<%=txtMobile.ClientID%>').val();
            DOB = $('#<%=txtDOB.ClientID%>').val();

            Email = $('#<%=txtEmail.ClientID%>').val();
            Address = $('#<%=txtAddress.ClientID%>').val();
            State = $('#<%=ddlState.ClientID%> option:selected').text();
            City = $('#<%=txtCity.ClientID%>').val();
            District = $('#<%=ddlDistrict.ClientID%> option:selected').text();
            PinCode = $('#<%=txtpincode.ClientID%>').val();
            Nom_Name = $('#<%=txtnomniName.ClientID%>').val();
            Relation = $('#<%=txtrelation.ClientID%>').val();
            PSWRD = $('#<%=txt_PSWRD.ClientID%>').val();

            Indiv_Comp = $("input[name='<%=rdo_Indiv_Comp.UniqueID%>']:radio:checked").val();


            if (Gender == "") {
                alert("Please Enter Gender.!!")
                return false;
            }
            if (DOB == "") {
                alert("Please Enter Date Of Birth.!!")
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
                url: pageUrl + '/UpdatePersonal',
                data: '{ Title: "' + Title + '", GTitle: "' + GTitle + '", GName: "' + GName + '", Gender: "' + Gender
                    + '", DOB: "' + DOB + '", Email: "' + Email
                    + '", Address: "' + Address + '", State: "' + State + '", City: "' + City
                    + '", District: "' + District + '", PinCode: "' + PinCode + '", Nom_Name: "' + Nom_Name
                    + '", Relation: "' + Relation + '", PSWRD: "' + PSWRD + '", Mobile: "' + Mobile
                    + '", Indiv_Comp: "' + Indiv_Comp + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == '1') {
                        alert("Profile Edited Successfully.!!");
                        GetDetail();
                    }
                },
                failure: function (response) { alert(response.d); },
            });
            // },},

            //  });



        }



        async function Upload_Pan() {
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
                    url: 'Change_Profile.aspx/Upload_Pan',
                    data: '{PANNo: "' + PANNo + '", ImgName_Pan: "' + ImgName_Pan + '"}',
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
                                alert("Pan Details Uploaded Successfully.!!");
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
                    url: 'Change_Profile.aspx/Upload_Bank',

                    data: '{ ImgName_Bank: "' + ImgName_Bank + '",Bank_Name: "' + Bank_Name + '", Acc_Type: "' + Acc_Type + '", Acc_No: "' + Acc_No + '",IFSC: "' + IFSC + '", Branch: "' + Branch + '" }',
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
                                alert("Bank Details Uploaded Successfully.!!");
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

                    $.ajax({
                        type: "POST",
                        url: 'Change_Profile.aspx/Upload_Aadhar',

                        data: '{ImgName_Aadhar_Front: "' + ImgName_Aadhar_Front + '", ImgName_Aadhar_Back: "' + ImgName_Aadhar_Back + '", AdhaarNo: "' + AdhaarNo + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alert("Aadhaar Details Uploaded Successfully.!!");
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
        async function Upload_GST() {

            var GST_No = $('#<%=txt_GSTNo.ClientID%>').val();
            var fileUpload = $("#img_GST").get(0);
            var files = fileUpload.files;
            let GST = "";
            if (GST_No == "") {
                alert('Please Enter GST No.');
                return false;
            }
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 99999999);
                random = "GST" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    GST = random + '.' + ext;
                }
                $.ajax({
                    type: "POST",
                    url: 'Change_Profile.aspx/Upload_GST',
                    //public string GST_Detail(string GSTNo, string UsrId, string filename, string modifiedBy)
                    data: '{ GST_No: "' + GST_No + '",GST: "' + GST + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (resp) {
                        var _URL = window.URL || window.webkitURL;
                        $.ajax({
                            url: "../Upload_Pan.ashx",
                            type: "POST",
                            data: data,
                            async: "false",
                            contentType: false,
                            processData: false,
                            success: function (result) { return 1; },
                            error: function (err) { return 0; }
                        });
                        if (resp.d == "1") {
                            alert("Your detail save successfully.!!");
                            GetDetail();
                        }
                    }
                });
            }
        }
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


    <%--    $("[id*=img_Pan]").change(function () {
            alert();
            debugger;
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_ImgPan.ClientID%>');
                dvPreview.html("");
                var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    if (regex.test(file[0].name.toLowerCase())) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img />");
                            img.attr("style", "height:150px;width: 100%");
                            img.attr("src", e.target.result);
                            dvPreview.append(img);
                        }
                        reader.readAsDataURL(file[0]);
                    }
                    else {
                        alert(file[0].name + " is not a valid image file.");
                        dvPreview.html("");
                        $('#img_Pan').val('');
                        return false;
                    }
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });--%>
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


    <%--    $("[id*=img_Bank]").change(function () {
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_ImgBank.ClientID%>');
                dvPreview.html("");
               // var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    //if (regex.test(file[0].name.toLowerCase())) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img />");
                            img.attr("style", "height:150px;width: 100%");
                            img.attr("src", e.target.result);
                            dvPreview.append(img);
                        }
                        reader.readAsDataURL(file[0]);
                   // }
                    //else {
                    //    alert(file[0].name + " is not a valid image file.");
                    //    dvPreview.html("");
                    //    $('#img_Bank').val('');
                    //    return false;
                    //}
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });--%>
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

       <%-- $("[id*=img_Aadhar_Front]").change(function () {
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_ImgAadharFront.ClientID%>');
                dvPreview.html("");
              //  var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    //if (regex.test(file[0].name.toLowerCase())) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img />");
                            img.attr("style", "height:150px;width: 100%");
                            img.attr("src", e.target.result);
                            dvPreview.append(img);
                        }
                        reader.readAsDataURL(file[0]);
                   // }
                    //else {
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


        $("[id*=img_Aadhar_Back]").change(function () {
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_ImgAadharBack.ClientID%>');
                dvPreview.html("");
              //  var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                $($(this)[0].files).each(function () {
                    var file = $(this);
                  //  if (regex.test(file[0].name.toLowerCase())) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img />");
                            img.attr("style", "height:150px;width: 100%");
                            img.attr("src", e.target.result);
                            dvPreview.append(img);
                        }
                        reader.readAsDataURL(file[0]);
                    //}
                    //else {
                    //    alert(file[0].name + " is not a valid image file.");
                    //    dvPreview.html("");
                    //    $('#img_Aadhar_Back').val('');
                    //    return false;
                    //}
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });--%>

        $("[id*=img_GST]").change(function () {
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $('#<%=div_GST.ClientID%>');
                dvPreview.html("");
                // var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    //  if (regex.test(file[0].name.toLowerCase())) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var img = $("<img />");
                        img.attr("style", "height:150px;width: 100%");
                        img.attr("src", e.target.result);
                        dvPreview.append(img);
                    }
                    reader.readAsDataURL(file[0]);
                    // }
                    //else {
                    //    alert(file[0].name + " is not a valid image file.");
                    //    dvPreview.html("");
                    //    $('#img_GST').val('');
                    //    return false;
                    //}
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });

        function GetOTP() {
            $('#confirm').show();
            $(".alert-warning").fadeTo(4000, 800).slideUp(500, function () {
                $(".alert-warning").slideUp(800);
            });
            $.ajax({
                type: "POST",
                url: pageUrl + '/generateOTP',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '0') {
                        $('#btn_otp').html('Re-Generate OTP');
                        $('#vOTP').show();
                    }
                },
                error: function (response) { }
            });
        }



        function GetDistrict(District) {
            $('#<%=ddlDistrict.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
            $.ajax({
                type: "POST",
                url: 'Change_Profile.aspx/GetDistrict',
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
    <script type="text/javascript">
        $(function () {
            $('#<%=txtAddress.ClientID%>').keypress(function (e) {
                if (e.which == 92) { return false; }
            });
        });
    </script>

    <style>
        label {
            margin-bottom: 0px;
            margin-left: 5px;
        }

        h3.panel-title {
            color: #444;
            margin: 0px;
        }

        .panel-heading {
            font-size: 24px;
            padding: 7px;
            background: #f1f1f1;
            color: #fff;
            margin: 10px 0;
        }

        .panel-default > .panel-heading {
            background: #ffecfa;
            border: none;
            color: #fff;
            /* font-weight: bold; */
            padding: 10px;
            font-size: 18px;
            margin-bottom: 10px;
        }

        table tr:last-child td, table tr:last-child th {
            border-bottom: none;
        }

        table td {
            border: none;
            margin-bottom: 0px;
        }

        .panel-default > .panel-heading h3 {
            color: #fff;
            font: 600 23px/23px "Raleway", sans-serif;
            margin-bottom: 0px;
        }

        .coin-tabs .nav-tabs .nav-item .nav-link {
            width: 100%;
            border: 1px solid #000 !important;
        }


        @media (min-width: 1024px) {
            .row > .col-md-2 {
                height: auto;
                width: 16.6667% !important;
            }

            .row > .col-md-7 {
                height: auto;
                width: 58.3333% !important;
            }
        }
    </style>


    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
</asp:Content>

