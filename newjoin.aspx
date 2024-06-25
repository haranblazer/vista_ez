<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" EnableEventValidation="true" ValidateRequest="true" CodeFile="newjoin.aspx.cs" Inherits="newjoin" %>

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
                yearRange: 'c-100:c+0'
            });
        });
    </script>
    <style>
        .breadcrumb-item a, .breadcrumb-item {
            color: #040404;
            font-size: 26px;
        }
    </style>


    <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list d-block text-center">

                <li class="breadcrumb-item"><a href="#">Become a Direct Seller</a></li>
            </ol>
        </div>
    </div>

    <div class="container-fluid">

        <%--  <div id="LoaderImg" style="width: 100%; text-align: center; position: relative; z-index: 99999; display: none;">
                            <img src="../images/toptime-logo-new.gif" alt="" style="height: 200px" />
                        </div>--%>
        <div class="col-md-12" style="display: none;">
            <div class="form-group" style="padding-top: 15px;">
                <div class="col-md-6">
                    <input class="form-check-input" type="checkbox" value="" id="chk_Sponsor" onclick="GetDefaultSponsorId()" />
                    <label class="form-check-label" for="chk_Sponsor">I don't have a sponsor Id</label>
                </div>
            </div>
        </div>

        <div id="Step1" class="d-none">
            <div class="clearfix"></div>
            <div class="m-auto">

                <div class="col-md-4 m-auto">
                    <img src="images/pan_card.jpg" class="w-100" />
                </div>
                <div class="col-md-2 m-auto">

                    <asp:RadioButtonList ID="rdo_Pan" runat="server" RepeatDirection="Horizontal" Width="100%" CssClass="m-0" onclick="javascript:PanShowHide();">
                        <asp:ListItem Value="1" Selected="True">Yes</asp:ListItem>
                        <asp:ListItem Selected="True" Value="0">No</asp:ListItem>
                    </asp:RadioButtonList>

                </div>
                <div class="col-md-4 m-auto text-center">

                    <%-- <asp:TextBox ID="txt_Pan" runat="server" CssClass="form-control" placeholder="Enter Pan Card No."
                                    AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>--%>
                    <span id="lbl_PanNote" style="color: red; display: none;"><b>20 % TDS will be deducted from all payout.</b></span>
                </div>
                <div class="col-md-4 m-auto mt-2">
                    <div class="row m-12">
                        <div class="col-md-6 m-auto">
                            <input type="button" id="btn_PanVerify" value="Pan card Verify" onclick="javascript:PanVerify();" class="btn mt-2 mb-2" />
                        </div>
                        <div class="col-md-6 m-auto">
                            <input type="button" id="btn_Step1" style="display: none;" value="Next" class="btn" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>
            <div class="m-auto">
                <div class="col-md-4 m-auto"></div>
                <div class="col-md-4 m-auto text-center">
                    <div id="div_PanVerifyMsg"></div>
                </div>
                <div class="col-md-4 m-auto">
                </div>
            </div>

            <div class="m-auto d-none">

                <div class="col-md-4 m-auto">
                    <img src="images/adhaar_card.jpg" class="w-100" />
                </div>
                <div class="col-md-2 m-auto">
                    <asp:RadioButtonList ID="rdo_Aadhar" runat="server" RepeatDirection="Horizontal" CssClass="m-0" onclick="javascript:AadharShowHide();">
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="col-md-4 m-auto">
                    <div class="row m-12">
                        <div class="col-md-9 ">
                            <input type="button" id="btn_DigilockerVerify" value="Aadhar card Verify (Digilocker)" onclick="javascript:DigilockerVerify();" class="btn" />
                        </div>

                        <div class="col-md-3">
                        </div>
                    </div>
                </div>
            </div>


            <hr />
        </div>
        <h4 class="billing-cart">Sponsor Detail </h4>
        <div class="clearfix"></div>
        <div class="row">
            <div class="col-md-2 control-label">Sponsor Id <span style="color: red;">*</span> </div>
            <div class="col-md-4">
                <div id="div_sponsor">
                    <asp:TextBox ID="txt_Sponsor" runat="server" Width="100%" CssClass="form-control" onchange="GetSponsorName();"
                        placeholder="Enter Your Sponsor Id *" MaxLength="30" autocomplete="off"></asp:TextBox>&nbsp;
              <span id="lbl_sponsorname" runat="server"></span>
                </div>
            </div>
            <div class="col-md-2 control-label">Position <span style="color: red;">*</span> </div>
            <div class="col-md-4" id="div_Position">
                <asp:DropDownList ID="ddlposition" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">A</asp:ListItem>
                    <asp:ListItem Value="1">B</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div id="Step2">
            <h4 class="billing-cart">Personal Detail</h4>

            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-2 control-label">Name <span style="color: red">*</span></div>
                <div class="col-md-4">
                    <asp:TextBox ID="TxtName" runat="server" CssClass="form-control" MaxLength="50" placeholder="Enter Your Name *"
                        AutoCompleteType="Disabled" autocomplete="nope"></asp:TextBox>
                </div>

                <div class="col-md-6 d-none">
                    <asp:TextBox ID="txtGName" runat="server" MaxLength="50" CssClass="form-control"
                        placeholder="Enter Your Father Name *" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>

                <div class="clearfix"></div>
                <div class="col-md-2 control-label">Gender <span style="color: red">*</span></div>
                <div class="col-md-4 control-label">
                    <asp:RadioButtonList ID="RdoGenderNew" runat="server" RepeatDirection="Horizontal" CssClass="mb-0">
                        <asp:ListItem Selected="True" Value="0"> Male</asp:ListItem>
                        <asp:ListItem Value="1"> Female</asp:ListItem>
                        <asp:ListItem Value="2"> Others</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2 control-label">DOB <span style="color: red">*</span></div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtDOB" placeholder="DOB *" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>

                <div class="clearfix"></div>
                <div class="col-md-2 control-label">Mobile No. <span style="color: red">*</span></div>
                <div class="col-md-4">
                    <asp:TextBox ID="Txt_Mobile" runat="server" CssClass="form-control" Width="100%" placeholder="Enter Your Mobile Number *"
                        MaxLength="10" onchange="MobileVerify()" onkeypress="return onlyNumbers(event,this);" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>

                    <div id="lbl_Right_Worng"></div>

                </div>

                <div class="col-md-2 control-label">Email ID <span style="color: red">*</span></div>
                <div class="col-md-4">
                    <asp:TextBox ID="txt_Email" runat="server" CssClass="form-control" MaxLength="50"
                        placeholder="Enter Your Email *" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>

                <div class="clearfix"></div>
                <div class="col-md-2 control-label">Address <span style="color: red">*</span></div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtAddress" placeholder="Address *" runat="server" TextMode="MultiLine" Height="60px" Width="100%"
                        CssClass="form-control" MaxLength="400" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>
                <div class="col-md-2 control-label">City <span style="color: red">*</span></div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCity" placeholder="City *" runat="server" CssClass="form-control" MaxLength="50"
                        AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>

                <div class="clearfix"></div>
                <div class="col-md-2 control-label">State <span style="color: red">*</span></div>
                <div class="col-md-4">
                    <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control" onchange="GetDistrict();">
                        <asp:ListItem Value="">Select State</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 control-label">District <span style="color: red">*</span></div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">Select District</asp:ListItem>
                    </asp:DropDownList>

                </div>



                <div class="clearfix"></div>
                <div class="col-md-2 control-label">Pin Code <span style="color: red">*</span></div>
                <div class="col-md-4">

                    <asp:TextBox ID="txt_Pincode" placeholder="Pin Code *" onkeypress="return onlyNumbers(event,this);" runat="server" CssClass="form-control" MaxLength="6"
                        AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>

                </div>

                <div class="col-md-6 d-none">
                    <div class="col-md-12">

                        <img src="images/whatsapp-2.png" style="width: 25px; margin-right: 3px; margin-top: -4px;">
                        <asp:CheckBox ID="chk_Notify" runat="server" />
                        <span style="font-size: 18px; left: 3px;">Allow Notifications
                              <div style="font-size: 18px; color: #a5a5ad;">We respect privacy and your information is secure with us       </div>
                        </span>

                    </div>

                </div>
                <div class="clearfix"></div>
                <div class="col-md-6 pull-right">
                    <%-- <div class="col-md-4 ml-3">
                                        <div class="form-group">
                                            <input type="button" value="Back" onclick="javascript:Back(1);" class="btn" />
                                        </div>
                                    </div>--%>

                    <input type="button" value="Next" style="display: none;" onclick="javascript:Step(2);" class="btn" />
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <div class="col-md-6 text-left">
                        </div>
                        <div class="col-md-12" id="trOTPGen" style="padding-top: 5px; display: none;">
                            <a href="#\" onclick="OPTGenerate(1)" class="btn btn-default">Generate OTP</a>
                        </div>
                        <div class="form-group">
                            <div id="trOTPVerify" style="display: none">
                                ENTER OTP :
                                            <div class="clearfix"></div>
                                <div>
                                    <asp:TextBox ID="txtOTP" runat="server" MaxLength="10" CssClass="form-control" Style="width: 120px; float: left"></asp:TextBox>
                                </div>
                                <div class="clearfix"></div>
                                <a href="#\" onclick="OPTVerift()" class="btn btn-success" style="float: left">Verify</a>
                                <div class="clearfix"></div>
                                <span id="lblOTPMSG"></span>
                                <div id="divRegenerate">
                                    <a href="#\" class="btn btn-info" onclick="OPTGenerate(2)">Re-Generate OTP</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br />
        </div>

        <div id="Step3">

            <h4 class="billing-cart">Nominee Detail</h4>
            <div class="row">
                <div class="col-md-2 control-label">Nominee Name </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtnomniName" runat="server" CssClass="form-control" placeholder="Enter Your Nominee Name" MaxLength="50"
                        AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>

                <div class="col-md-2 control-label">Relation </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtrelation" runat="server" CssClass="form-control" placeholder="Enter Your Relation" MaxLength="50"
                        AutoCompleteType="Disabled" autocomplete="off"> 
                    </asp:TextBox>
                </div>

                <div class="clearfix"></div>
            </div>

            <h4 class="billing-cart">Bank Detail</h4>

            <div class="clearfix"></div>
            <div class="row">

                <div class="col-md-2 control-label">Bank Name </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 control-label">Bank Type </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlAcType" runat="server" CssClass="form-control">
                        <asp:ListItem Selected="True" Value="">Select Type</asp:ListItem>
                        <asp:ListItem>SAVING A/C</asp:ListItem>
                        <asp:ListItem>CURRENT A/C</asp:ListItem>
                        <asp:ListItem>CC A/C</asp:ListItem>
                        <asp:ListItem>OD A/C</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="clearfix"></div>
                <div class="col-md-2 control-label">Account No. </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control" placeholder="Enter Your A/C No."
                        AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>
                <div class="col-md-2 control-label">Branch </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control" placeholder="Enter Your Branch"
                        AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-2 control-label">IFSC Code </div>
                <div class="col-md-4">

                    <asp:TextBox ID="txtifs" runat="server" CssClass="form-control" placeholder="Enter Your IFSC Code"
                        AutoCompleteType="Disabled" autocomplete="off" MaxLength="11"></asp:TextBox>
                </div>
                <div class="col-md-2 control-label">Aadhar Card </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txt_Aadhar" runat="server" CssClass="form-control" placeholder="Enter Aadhar Card No."
                        AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>
                <div class="col-md-2 control-label">Pan Card No. </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txt_Pan" runat="server" CssClass="form-control" placeholder="Enter Pan Card No."
                        AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>

            </div>
            <h4 class="billing-cart" style="display: none;">Upload KYC  </h4>
            <div class="row" style="display: none;">

                <div class="col-md-3">
                    <input type="file" id="img_Pan" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                    <label for="img_Pan" title="Pan Card" class="btn">Upload Pan</label>
                </div>

                <div class="col-md-3">
                    <input type="file" id="img_Bank" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                    <label for="img_Bank" title="Bank" class="btn">Upload Bank </label>
                </div>
                <div class="col-md-3">
                    <input type="file" id="img_Aadhar_Front" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                    <label for="img_Aadhar_Front" title="Aadhar Card Front" class="btn">Upload Aadhar Front</label>
                </div>
                <div class="col-md-3">
                    <input type="file" id="img_Aadhar_Back" accept=".png,.jpg,.jpeg,.gif" style="display: none;" />
                    <label for="img_Aadhar_Back" title="Aadhar Card Back" class="btn">Upload Aadhar Back</label>
                </div>

            </div>
            <div class="row" style="display: none;">

                <div class="col-md-3">
                    <div id="div_ImgPan" runat="server"></div>
                </div>

                <div class="col-md-3">
                    <div id="div_ImgBank" runat="server"></div>
                </div>
                <div class="col-md-3">
                    <div id="div_ImgAadharFront" runat="server"></div>
                </div>
                <div class="col-md-3">
                    <div id="div_ImgAadharBack" runat="server"></div>
                </div>
            </div>

            <div class="clearfix"></div>
            <hr />
            <div class="row">
                <div class="col-md-2 control-label">
                    <strong>Digit&nbsp;Sum&nbsp;(&nbsp;<asp:Label ID="lbl_Digit1" runat="server">0</asp:Label>&nbsp;+&nbsp;<asp:Label ID="lbl_Digit2" runat="server">0</asp:Label>&nbsp;)&nbsp;=
                    </strong>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txt_Digit" runat="server" CssClass="form-control"
                        placeholder="Sum of digit *" autocomplete="off"></asp:TextBox>
                </div>
                <div class="col-md-2 control-label">Password <span style="color: red;">*</span> </div>
                <div class="col-md-4">
                    <asp:TextBox ID="TxtPassword" runat="server" CssClass="form-control" MaxLength="15"
                        TextMode="Password" placeholder="Enter Your Password"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2 control-label"></div>
                <div class="col-md-4 mt-1">
                    <asp:CheckBox ID="CheckBox1" runat="server" Width="20px" />
                    <span class="txt" style="font-size: 18px;">Please Accept <a class="txt" href="terms_and_condition.aspx" target="_blank"
                        style="color: #551e00; text-align: justify;">Terms &amp; Conditions </a></span>
                </div>
            </div>

            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-2 control-label"></div>
                <div class="col-md-4 mt-2">
                    <div class="form-group">
                        <%--<input type="button" value="Back" onclick="javascript:Back(2);" class="btn" />--%>
                        <input type="button" value="Submit" onclick="javascript:Step();" class="btn" />
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <hr />
    </div>

    <div id="Step4" style="display: none;">
        <div class="clearfix"></div>
        <h4 class="billing-cart">Verify Information</h4>
        <div class="row">
            <div class="col-md-4">
                <div class="table-responsive">
                    <table class="table table-bordered table-fixed" style="width: 100%; background: #fbfbfb; border-bottom: 1px solid #ffffffb0;">

                        <tr style="display: none;">
                            <td>Aadhar Card No. </td>
                            <td><span id="lbl_AadharNo"></span></td>
                        </tr>
                        <tr>
                            <td>Sponsor Id : </td>
                            <td><span id="lbl_sponsorid"></span></td>
                        </tr>
                        <tr>
                            <td>Position : </td>
                            <td><span id="lbl_Position"></span></td>
                        </tr>
                        <tr>
                            <td>User Name : </td>
                            <td><span id="lbl_UserName"></span></td>
                        </tr>

                        <tr class="d-none">
                            <td>Guardian's Name : </td>
                            <td><span id="lbl_Guardian"></span></td>
                        </tr>
                        <tr>
                            <td>Gender : </td>
                            <td><span id="lbl_Gender"></span></td>
                        </tr>
                        <tr>
                            <td>DOB : </td>
                            <td><span id="lbl_DOB"></span></td>
                        </tr>
                        <tr>
                            <td>Address : </td>
                            <td><span id="lbl_Address"></span></td>
                        </tr>
                        <tr>
                            <td>City : </td>
                            <td><span id="lbl_City"></span></td>
                        </tr>

                        <tr>
                            <td>State : </td>
                            <td><span id="lbl_State"></span></td>
                        </tr>


                    </table>
                </div>

            </div>
            <div class="col-md-4">
                <div class="table-responsive">
                    <table class="table table-bordered table-fixed" style="width: 100%; background: #fbfbfb; border-bottom: 1px solid #ffffffb0;">


                        <tr style="display: none">
                            <td>District : </td>
                            <td><span id="lbl_District"></span></td>
                        </tr>
                        <tr>
                            <td>Pin Code : </td>
                            <td><span id="lbl_PinCode"></span></td>
                        </tr>
                        <tr>
                            <td>Email-Id : </td>
                            <td><span id="lbl_Email"></span></td>
                        </tr>

                        <tr>
                            <td>Mobile No. : </td>
                            <td><span id="lbl_Mobile"></span></td>

                        </tr>
                        <tr>

                            <td>Nominee Name : </td>
                            <td><span id="lbl_NomineeName"></span></td>
                        </tr>
                        <tr>
                            <td>Your Relation :  </td>
                            <td><span id="lbl_Relation"></span></td>
                        </tr>
                        <tr>

                            <td>Bank : </td>
                            <td><span id="lbl_Bank"></span></td>
                        </tr>
                        <tr>
                            <td>Bank Type : </td>
                            <td><span id="lbl_BankType"></span></td>
                        </tr>

                    </table>
                </div>
            </div>
            <div class="col-md-4">
                <div class="table-responsive">
                    <table class="table table-bordered table-fixed" style="width: 100%; background: #fbfbfb; border-bottom: 1px solid #ffffffb0;">

                        <tr>
                            <td>Account No. : </td>
                            <td><span id="lbl_AcNo"></span></td>
                        </tr>
                        <tr>
                            <td>Branch : </td>
                            <td><span id="lbl_Branch"></span></td>
                        </tr>
                        <tr>
                            <td>IFSC Code : </td>
                            <td><span id="lbl_IFSC"></span></td>
                        </tr>
                        <tr>
                            <td>Aadhar No. : </td>
                            <td><span id="lbl_Aadhar"></span></td>
                        </tr>
                        <tr>
                            <td width="50%">Pan Card No. :</td>
                            <td><span id="lbl_PanNo"></span></td>
                        </tr>
                        <tr>
                            <td>Password : </td>
                            <td><span id="lbl_Password"></span></td>
                        </tr>
                    </table>
                </div>
            </div>


            <div class="clearfix"></div>
            <br />
            <div class="row">
                <div class="col-md-6">
                    <div class="row">
                        <div class="col">
                            <input type="button" value="Back" onclick="javascript:Back(3);" class="btn" />
                        </div>
                        <div class="col">
                            <input type="button" id="btn_submit" value="Submit" onclick="Validation();" class="btn" />
                        </div>
                    </div>
                </div>

            </div>
            <div class="clearfix"></div>
            <br />
        </div>

    </div>

    </div>

    <asp:HiddenField ID="hnd_MobileVerify" runat="server" Value="0" />

    <asp:HiddenField ID="hnd_PanVerify" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_AadharVerify" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_PanDetails" runat="server" Value="" />
    <asp:HiddenField ID="hnd_AadharDetails" runat="server" Value="" />
    <asp:HiddenField ID="hnd_DigilockerVerify" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_DigilockerDetails" runat="server" Value="" />

    <%--<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>

    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>--%>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


    <%--<script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtDOB.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: '0' });
        });
    </script>--%>
    <style>
        /*select, input[type="text"], input[type="email"], input[type="url"], input[type="password"], input[type="search"], input[type="number"], input[type="tel"], input[type="range"], input[type="date"], input[type="month"], input[type="week"], input[type="time"], input[type="datetime"], input[type="datetime-local"], input[type="color"] {
            display: block;
            width: 100%;*/
        /* height: 64px; */
        /*padding: 0px 8px;
            font-size: 0.75rem;
            font-weight: 600;*/
        /* background-color: #ffffff; */
        /*color: #000000;
        }*/

        .datepick-month-year option {
            text-align: center;
        }

        /* .datepick-month-header {
            display: flex;
        }*/

        /*    .datepick-month-header select, .datepick-month-header input {
                height: 2.4em;
            }*/
       .datepick-month-header option {
            background: #ff0041 none repeat scroll 0 0;
            padding: 5px 0 5px 10px;
        }

            

   
    </style>

    <script type="text/javascript">
        var URL = "newjoin.aspx";
        var ImgName_Pan = "";
        var ImgName_Bank = "";
        var ImgName_Aadhar_Front = "";
        var ImgName_Aadhar_Back = "";
        var District = "";
        $(function () {

            $('#<%=lbl_Digit1.ClientID%>').text(parseInt(Math.random().toFixed(1) * 10));
            $('#<%=lbl_Digit2.ClientID%>').text(parseInt(Math.random().toFixed(1) * 10));

            if ($('#<%=Txt_Mobile.ClientID%>').val() != '') { MobileVerify(); }


            $(":input").attr("autocomplete", "off");



            $('#<%=txt_Sponsor.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 90 || e.which > 122) && (e.which < 48 || e.which > 57)) { return false; }
                if (e.which == 91 || e.which == 93 || e.which == 94 || e.which == 95 || e.which == 96) { return false; }
            });

            $('#<%=TxtName.ClientID %>').keypress(function (e) {
                if ((e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122) || (e.which == 32)) { return true; } else { return false; }
                if (e.which == 91 || e.which == 93 || e.which == 94 || e.which == 95 || e.which == 96) { return false; }
            });
            $('#<%=txtGName.ClientID %>').keypress(function (e) {
                if ((e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122) || (e.which == 32)) { return true; } else { return false; }
                if (e.which == 91 || e.which == 93 || e.which == 94 || e.which == 95 || e.which == 96) { return false; }
            });

            $('#<%=txt_Email.ClientID %>').keypress(function (e) {
                if ((e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122) || (e.which >= 48 && e.which <= 57) || (e.which == 46) || (e.which == 64) || (e.which == 95)) { return true; } else { return false; }
            });

            $('#<%=Txt_Mobile.ClientID%>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) { return false; }
            });

            if ($('#<%=txt_Sponsor.ClientID%>').val() != '') {
                GetSponsorName();
            }


        });


        function Validation() {

            Step();
            var SponsorId = $('#<%=txt_Sponsor.ClientID%>').val(),
                Position = $('#<%=ddlposition.ClientID%>').val(),
                Title = "",
                Name = $('#<%=TxtName.ClientID%>').val(),
                state = $('#<%=DdlState.ClientID%> option:selected').text(),
                Gtitle = "",
                GName = $('#<%=txtGName.ClientID%>').val(),
                Mobile = $('#<%=Txt_Mobile.ClientID%>').val(),
                Email = $('#<%=txt_Email.ClientID%>').val(),
                Password = $('#<%=TxtPassword.ClientID%>').val(),
                District = $('#<%=ddlDistrict.ClientID%> option:selected').text(),
                City = $('#<%=txtCity.ClientID%>').val(),
                Pincode = $('#<%=txt_Pincode.ClientID%>').val(),
                Address = $('#<%=txtAddress.ClientID%>').val(),

                Gender = $("input[name='<%=RdoGenderNew.UniqueID%>']:radio:checked").val(),
                DOB = $('#<%=txtDOB.ClientID%>').val(),
                Relation = $('#<%=txtrelation.ClientID%>').val(),
                NomineeName = $('#<%=txtnomniName.ClientID%>').val(),
                Bank = $('#<%=ddlBankName.ClientID%> option:selected').text(),
                ACType = $('#<%=ddlAcType.ClientID%> option:selected').text(),
                ACNo = $('#<%=txtAccNo.ClientID%>').val(),
                Branch = $('#<%=txtbranch.ClientID%>').val(),
                IFSC = $('#<%=txtifs.ClientID%>').val(),
                Aadhar = $('#<%=txt_Aadhar.ClientID%>').val(),
                PAN = $('#<%=txt_Pan.ClientID%>').val(),
                Whats_Notify = $('#<%=chk_Notify.ClientID%>').is(':checked') == true ? 1 : 0,

                Digit1 = $('#<%=lbl_Digit1.ClientID%>').text(),
                Digit2 = $('#<%=lbl_Digit2.ClientID%>').text(),
                Digit = $('#<%=txt_Digit.ClientID%>').val(),
                PanVerify = $('#<%=hnd_PanVerify.ClientID%>').val(),
                AadharVerify = $('#<%=hnd_AadharVerify.ClientID%>').val(),
                DigilockerVerify = $('#<%=hnd_DigilockerVerify.ClientID%>').val(),
                PanDetails = $('#<%=hnd_PanDetails.ClientID%>').val(),
                AadharDetails = $('#<%=hnd_AadharDetails.ClientID%>').val(),
                DigilockerDetails = $('#<%=hnd_DigilockerDetails.ClientID%>').val();

            if ($('#<%=ddlBankName.ClientID%>').val() == "") {
                Bank = "";
            }

            if ($('#<%=ddlAcType.ClientID%>').val() == "") {
                ACType = "";
            }


            if (!confirm('Are you sure you want to save your details？')) {
                return false;
            }


            $('#btn_submit').removeAttr("enabled");
            $('#btn_submit').attr("disabled", "disabled");
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: URL + '/UserRegistration',
                data: '{SponsorId: "' + SponsorId + '", Position: "' + Position + '",  Title: "' + Title + '", Name: "' + Name + '", state: "' + state + '", Gtitle: "' + Gtitle
                    + '", GName: "' + GName + '", Mobile: "' + Mobile + '", Email: "' + Email + '", Password: "' + Password
                    + '", epassword: "' + Password + '", District: "' + District + '", City: "' + City + '", Pincode: "' + Pincode + '", Address: "' + Address
                    + '", Gender: "' + Gender + '", DOB: "' + DOB + '", Relation: "' + Relation + '", NomineeName: "' + NomineeName
                    + '", Bank: "' + Bank + '", ACType: "' + ACType + '", ACNo: "' + ACNo + '", Branch: "' + Branch
                    + '", IFSC: "' + IFSC + '", PAN: "' + PAN + '", Aadhar: "' + Aadhar + '", Whats_Notify: "' + Whats_Notify
                    + '", PanVerify: "' + PanVerify + '", AadharVerify: "' + AadharVerify
                    + '", PanDetails: "' + PanDetails + '", AadharDetails: "' + AadharDetails
                    + '", DigilockerVerify: "' + DigilockerVerify + '", DigilockerDetails: "' + DigilockerDetails
                    + '"}',


                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d.Error == "") {

                        $('#<%=txt_Sponsor.ClientID%>').val('');
                        $('#<%=TxtName.ClientID%>').val('');
                        $('#<%=DdlState.ClientID%>').val('');
                        $('#<%=txtGName.ClientID%>').val('');
                        $('#<%=Txt_Mobile.ClientID%>').val('');
                        $('#<%=txt_Email.ClientID%>').val('');
                        $('#<%=TxtPassword.ClientID%>').val('');
                        $('#<%=CheckBox1.ClientID%>').attr('checked', false);



                        Upload_Pan().then(function () {
                            Upload_Bank().then(function () {
                                Upload_Aadhar_Front().then(function () {
                                    Upload_Aadhar_Back().then(function () {


                                        if (ImgName_Pan == null || ImgName_Bank == null || ImgName_Aadhar_Front == null || ImgName_Aadhar_Back == null) {

                                            if (data.d.IsCart == "1") {
                                                window.location = "CheckOut.aspx?uid=" + data.d.Regno;
                                            }
                                            else {
                                                window.location = "Thanks.aspx?i=" + data.d.Regno + "&n=" + data.d.Name + "&sid=" + data.d.Sponsorid
                                                    + "&mob=" + data.d.Mobile + "&em=" + data.d.Email + "&pass=" + data.d.Password;
                                            }
                                        } else {
                                            var IsCart = data.d.IsCart, CheckOut_Url = "CheckOut.aspx?uid=" + data.d.Regno,
                                                Thanks_Url = "Thanks.aspx?i=" + data.d.Regno + "&n=" + data.d.Name + "&sid=" + data.d.Sponsorid
                                                    + "&mob=" + data.d.Mobile + "&em=" + data.d.Email + "&pass=" + data.d.Password;
                                            $.ajax({
                                                type: "POST",
                                                url: URL + '/UpdateImg',
                                                async: "false",
                                                data: '{Regno: "' + data.d.AppmstRegno + '", ImgName_Pan: "' + ImgName_Pan + '", ImgName_Bank: "' + ImgName_Bank
                                                    + '", ImgName_Aadhar_Front: "' + ImgName_Aadhar_Front + '", ImgName_Aadhar_Back: "' + ImgName_Aadhar_Back + '"}',
                                                contentType: "application/json; charset=utf-8",
                                                dataType: "json",
                                                success: function (data) {
                                                    if (IsCart == "1") {
                                                        window.location = CheckOut_Url;
                                                    }
                                                    else {
                                                        window.location = Thanks_Url;
                                                    }
                                                },
                                                error: function (response) { }
                                            });
                                        }
                                    });
                                });
                            });
                        });

                    }
                    else {
                        $('#btn_submit').removeAttr("disabled");
                        $('#btn_submit').attr("enabled", "enabled");
                        alert(data.d.Error);
                        return false;
                    }
                },
                error: function (response) {
                    $('#btn_submit').removeAttr("disabled");
                    $('#btn_submit').attr("enabled", "enabled");
                    alert("Server error. Time out.!!");
                }
            });
        }



        $(function () {

            $("[id*=img_Pan]").change(function () {
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
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Pan').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Bank]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=div_ImgBank.ClientID%>');
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
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Bank').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Aadhar_Front]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=div_ImgAadharFront.ClientID%>');
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
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Aadhar_Front').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Aadhar_Back]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=div_ImgAadharBack.ClientID%>');
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
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Aadhar_Back').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });

        });


        async function Upload_Pan() {
            var fileUpload = $("#img_Pan").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 99999999);
                random = "Pan" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Pan = random + '.' + ext;
                }
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
            }
        }

        async function Upload_Bank() {
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
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../Upload_Bank.ashx",
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



        async function Upload_Aadhar_Front() {
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



        function isValidEmailAddress(emailAddress) {
            let pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
            return pattern.test(emailAddress);
        };

        function isValid_IFSC(IFSC) {
            let pattern = new RegExp(/[A-Z|a-z]{4}[0][a-zA-Z0-9]{6}$/);
            return pattern.test(IFSC);
        };


        function PanShowHide() {
            var radioValue = $('#<%=rdo_Pan.ClientID %> input[type=radio]:checked').val();
            if (radioValue == "1") {
                $('#<%=txt_Pan.ClientID%>').css("display", "block");
                $('#btn_PanVerify').css("display", "block");
                $('#lbl_PanNote').css("display", "none");
                //$('#btn_Step1').css("display", "none");
            }
            else {
                $('#<%=txt_Pan.ClientID%>').css("display", "none");
                $('#btn_PanVerify').css("display", "none");
                $('#lbl_PanNote').css("display", "block");
                //$('#btn_Step1').css("display", "block");
            }
        }

        function AadharShowHide() {
            var radioValue = $('#<%=rdo_Aadhar.ClientID %> input[type=radio]:checked').val();
            if (radioValue == "1") {
                //$('#<%=txt_Aadhar.ClientID%>').css("display", "block");
                $('#btn_DigilockerVerify').css("display", "block");
            }
            else {
                //$('#<%=txt_Aadhar.ClientID%>').css("display", "none");
                $('#btn_DigilockerVerify').css("display", "none");
            }
        }

        function Step() {

            var SponsorId = $('#<%=txt_Sponsor.ClientID%>').val(),
                Position = $('#<%=ddlposition.ClientID%>').val(),
                Name = $('#<%=TxtName.ClientID%>').val(),
                state = $('#<%=DdlState.ClientID%> option:selected').text(),
                GName = $('#<%=txtGName.ClientID%>').val(),
                Mobile = $('#<%=Txt_Mobile.ClientID%>').val(),
                Email = $('#<%=txt_Email.ClientID%>').val(),
                Password = $('#<%=TxtPassword.ClientID%>').val(),
                District = $('#<%=ddlDistrict.ClientID%> option:selected').text(),
                City = $('#<%=txtCity.ClientID%>').val(),
                Pincode = $('#<%=txt_Pincode.ClientID%>').val(),
                Address = $('#<%=txtAddress.ClientID%>').val(),

                Gender = $("input[name='<%=RdoGenderNew.UniqueID%>']:radio:checked").val(),
                DOB = $('#<%=txtDOB.ClientID%>').val(),
                Relation = $('#<%=txtrelation.ClientID%>').val(),
                NomineeName = $('#<%=txtnomniName.ClientID%>').val(),
                Bank = $('#<%=ddlBankName.ClientID%> option:selected').text(),
                ACType = $('#<%=ddlAcType.ClientID%> option:selected').text(),
                ACNo = $('#<%=txtAccNo.ClientID%>').val(),
                Branch = $('#<%=txtbranch.ClientID%>').val(),
                IFSC = $('#<%=txtifs.ClientID%>').val(),
                Aadhar = $('#<%=txt_Aadhar.ClientID%>').val(),
                PAN = $('#<%=txt_Pan.ClientID%>').val(),

                Digit1 = $('#<%=lbl_Digit1.ClientID%>').text(),
                Digit2 = $('#<%=lbl_Digit2.ClientID%>').text(),
                Digit = $('#<%=txt_Digit.ClientID%>').val(),
                PanVerify = $('#<%=hnd_PanVerify.ClientID%>').val(),
                AadharVerify = $('#<%=hnd_AadharVerify.ClientID%>').val(),
                AadharVerify = $('#<%=hnd_AadharVerify.ClientID%>').val(),
                AadharDetails = $('#<%=hnd_AadharDetails.ClientID%>').val();


            var MSG = "";

            var radioPanValue = $('#<%=rdo_Pan.ClientID %> input[type=radio]:checked').val();

            if (radioPanValue == 1) {
                if ($('#<%=hnd_PanVerify.ClientID%>').val() == "0") {
                    alert("Please Verify Pan Card No.");
                    return;
                }
            }

            var radioAadharValue = $('#<%=rdo_Aadhar.ClientID %> input[type=radio]:checked').val();
            if (radioAadharValue == 1) {
                if ($('#<%=hnd_AadharVerify.ClientID%>').val() == "0") {
                    alert("Please Verify Aadhar Card No.");
                    return;
                }
            }


            //$('#Step1').css("display", "none");
            //$('#Step2').css("display", "block");
            //$('#Step3').css("display", "none");
            //$('#Step4').css("display", "none");
            if (SponsorId == "") {
                MSG += "\n Please Enter Sponsor Id.!!";
            }
            if (Name == "") {
                MSG += "\n Please Enter User Name.!!";
            }

            //if (GName == "") {
            //    MSG += "\n Please Enter Father Name.!!";
            //}
            if (DOB == "") {
                MSG += "\n Please Enter DOB.!!";
            }

            if (Mobile == "") {
                MSG += "\n Please Enter Mobile No.!!";
            }
            if (Mobile != '') {
                if (parseInt(Mobile.slice(0, 1)) <= 5) {
                    alert("Please Enter Valid Mobile Number.");
                    return false;
                }


            }

            if (Email == "") {
                MSG += "\n Please Enter Email Id.!!";
            }
            else if (!isValidEmailAddress(Email)) {
                MSG += "\n Please Enter Valid Email Id!!";
            }


            if ($('#<%=DdlState.ClientID%>').val() == "") {
                MSG += "\n Please Select User State.!!";
            }

            if ($('#<%=ddlDistrict.ClientID%>').val() == "") {
                MSG += "\n Please Select District.!!";
            }

            if (!OnlyAlphabets(state)) {
                MSG += "\n Please select valid state.!!";
            }

            if (!OnlyAlphabets(District)) {
                MSG += "\n Please select valid district.!!";
            }


            if (City == "") {
                MSG += "\n Please Enter City.!!";
            }
            if (Pincode == "") {
                MSG += "\n Please Enter Pincode.!!";
            }
            if (Pincode.slice(0, 1) == "0") {
                MSG += "\n Please Enter Valid Pincode.!!";
                //  Pincode = "";
                $('#<%=txt_Pincode.ClientID%>').val('');

            }

            if (Pincode.length != "6") {
                MSG += "\n Please Enter a Minimum of 6 Characters in Pincode.!!";
            }

            if (Address == "") {
                MSG += "\n Please Enter Address.!!";
            }

              <%--  if ($('#<%=hnd_MobileVerify.ClientID%>').val() != "1") {
                   /* MSG += "\n Please Enter valid Mobile No.!!";*/
                }--%>

            //if (MSG != "") {
            //    alert(MSG);
            //    return false;
            //}


            //$('#Step1').css("display", "none");
            //$('#Step2').css("display", "none");
            //$('#Step3').css("display", "block");
            //$('#Step4').css("display", "none");




            if ($('#<%=ddlBankName.ClientID%>').val() == "") {
                Bank = "";
            }

            if ($('#<%=ddlAcType.ClientID%>').val() == "") {
                ACType = "";
            }

            if (!OnlyAlphabets(Bank)) {
                MSG += "\n Please select valid Bank.!!";
            }

            if (!OnlyAlphabets(ACType)) {
                MSG += "\n Please select valid A/c Type.!!";
            }


            if (IFSC != "") {
                if (!isValid_IFSC(IFSC)) {
                    MSG += "\n Please Enter Valid IFSC Code!!";
                }
            }

            if (Password == "") {
                MSG += "\n Please Enter Password.!!";
            }
            else if (Password != "") {
                if (Password.length < 5)
                    MSG += "\n Password Length Can Be Minimum Of 5 Character.!!";
            }

            if ($('#<%=CheckBox1.ClientID%>').is(':checked') == false) {
                MSG += "\n Please select Terms & Conditions.!!";
            }
            if (Digit == "") {
                MSG += "\n Please enter sum of digit.!!";
            }
            if (Digit != '') {
                if ((parseInt(Digit1) + parseInt(Digit2)) != Digit)
                    MSG += "\n Please enter correct sum of digits !";
            }

            var radioValue = $('#<%=rdo_Pan.ClientID %> input[type=radio]:checked').val();
                 <%-- if (radioValue == "1") {
                    let Pan_Imgfile = $("#img_Pan").get(0);
                    var files = Pan_Imgfile.files;
                    if (files.length == 0) {
                        MSG += "\n Please upload pan image.!!";
                    }
                }
                if ($('#<%=ddlBankName.ClientID%>').val() != "") {
                    let Bank_Imgfile = $("#img_Bank").get(0);
                    var files = Bank_Imgfile.files;
                    if (files.length == 0) {
                        MSG += "\n Please upload bank image.!!";
                    }
                }
                if (Aadhar != "") {
                    let Aadhar_Front = $("#img_Aadhar_Front").get(0);
                    var files = Aadhar_Front.files;
                    if (files.length == 0) {
                        MSG += "\n Please upload aadhar front Image.!!";
                    }

                    let Aadhar_Back = $("#img_Aadhar_Back").get(0);
                    var files1 = Aadhar_Back.files;
                    if (files1.length == 0) {
                        MSG += "\n Please upload aadhar back Image.!!";
                    }
                } --%>


            if (MSG != "") {
                alert(MSG);
                return false;
            }

            $('#Step1').css("display", "none");
            $('#Step2').css("display", "none");
            $('#Step3').css("display", "none");
            $('#Step4').css("display", "block");


            var panIcon = ""; // "<i class='fa fa-times' style='color:red; font-size:larger;' aria-hidden='true'></i>";
            if (PanVerify == "1")
                panIcon = "<i class='fa fa-check-circle' style='color:green; font-size:larger;' aria-hidden='true'></i>";

            var AadharIcon = "<i class='fa fa-times' style='color:red; font-size:larger;' aria-hidden='true'></i>";
            if (AadharVerify == "1")
                AadharIcon = "<i class='fa fa-check-circle' style='color:green; font-size:larger;' aria-hidden='true'></i>";

            if (Gender == "0") {
                Gender = "Male";
            }
            else if (Gender == "1") {
                Gender = "Female";
            }
            else {
                Gender = "Others";
            }

            $('#lbl_PanNo').html(PAN + " " + panIcon);
            $('#lbl_AadharNo').html(Aadhar + " " + AadharIcon);
            $('#lbl_sponsorid').text(SponsorId);
            $('#lbl_Position').text(Position == "0" ? "A" : "B");
            $('#lbl_UserName').text(Name);
            $('#lbl_Guardian').text(GName);
            $('#lbl_Gender').text(Gender);
            $('#lbl_DOB').text(DOB);
            $('#lbl_Address').text(Address);

            $('#lbl_City').text(City);
            $('#lbl_State').text(state);
            $('#lbl_District').text(District);
            $('#lbl_PinCode').text(Pincode);
            $('#lbl_Email').text(Email);
            $('#lbl_Mobile').text(Mobile);
            $('#lbl_NomineeName').text(NomineeName);
            $('#lbl_Relation').text(Relation);
            $('#lbl_Bank').text(Bank);

            $('#lbl_BankType').text(ACType);
            $('#lbl_AcNo').text(ACNo);
            $('#lbl_Branch').text(Branch);
            $('#lbl_IFSC').text(IFSC);
            $('#lbl_Aadhar').text(Aadhar);
            $('#lbl_Password').text(Password);
        }




        function Back(BackId) {
            if (BackId == 1) {
                $('#Step1').css("display", "none");
                $('#Step2').css("display", "block");
                $('#Step3').css("display", "none");
                $('#Step4').css("display", "none");
            }
            else if (BackId == 2) {
                $('#Step1').css("display", "none");
                $('#Step2').css("display", "block");
                $('#Step3').css("display", "none");
                $('#Step4').css("display", "none");
            }
            else if (BackId == 3) {
                $('#Step1').css("display", "none");
                $('#Step2').css("display", "none");
                $('#Step3').css("display", "block");
                $('#Step4').css("display", "none");
            }
        }

        function GetSponsorName() {
            var SponsorId = $('#<%=txt_Sponsor.ClientID%>').val();
            if (SponsorId != "") {
                $.ajax({
                    type: "POST",
                    url: URL + '/GetSponsorName',
                    data: '{SponsorId: "' + SponsorId + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            $('#<%=lbl_sponsorname.ClientID%>').text(data.d);
                            $('#<%=lbl_sponsorname.ClientID%>').css("color", "blue");
                        }
                        else {
                            $('#<%=txt_Sponsor.ClientID%>').val('');
                            $('#<%=lbl_sponsorname.ClientID%>').text(SponsorId + " Sponsor not exists.");
                            $('#<%=lbl_sponsorname.ClientID%>').css("color", "red");
                        }

                    },
                    error: function (response) {
                        $('#<%=lbl_sponsorname.ClientID%>').text("");
                    }
                });
            }
        }


        function OPTGenerate(flag) {

            $('#<%=txtOTP.ClientID %>').val('');
            var Mobile = $('#<%=Txt_Mobile.ClientID%>').val();
            if (Mobile == "") {
                alert("Please Enter Mobile No.!!");
                $('#<%=Txt_Mobile.ClientID %>').focus();
                return;
            }
            $.ajax({
                type: "POST",
                url: URL + '/GenerateOTP',
                data: '{Mobile: "' + Mobile + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == '0') {
                        $('#trOTPGen').hide();
                        $('#trOTPVerify').show();
                        if (flag == "2") {
                            $('#lblOTPMSG').text("OTP RE-GENERATED.");
                            $('#lblOTPMSG').css('color', 'green');
                        }
                    }
                    else {
                        alert(response.d);
                        return false;
                    }
                },
                error: function (response) {
                }
            });
        }


        function OPTVerift() {
            var Mobile = $('#<%=Txt_Mobile.ClientID%>').val();
            var OTP = $('#<%=txtOTP.ClientID %>').val().trim();
            if (Mobile == '') {
                alert("Please Enter Mobile No.!!");
                $('#<%=Txt_Mobile.ClientID %>').focus();
                return;
            }
            $.ajax({
                type: "POST",
                url: URL + '/VerifyOTP',
                data: '{Mobile: "' + Mobile + '", OTP: "' + OTP + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == '0') {
                        $('#lblOTPMSG').text("OTP Verified succeessfully.");
                        $('#lblOTPMSG').css('color', 'green');
                        $('#divRegenerate').hide();
                        $('#trOTPGen').hide();
                        $('#trOTPVerify').show();
                        $('#<%=txtOTP.ClientID %>').attr('disabled', true);
                        $('#btn_submit').attr('disabled', false);
                        $('#<%=Txt_Mobile.ClientID%>').attr('disabled', true);
                    }
                    else {
                        $('#lblOTPMSG').text(response.d);
                        $('#lblOTPMSG').css('color', 'red');
                    }
                },
                error: function (response) {
                }
            });
        }



        function MobileVerify() {
            $('#<%=hnd_MobileVerify.ClientID%>').val('0');
            var Mobile = $('#<%=Txt_Mobile.ClientID%>').val();
            if (document.getElementById("<%=Txt_Mobile.ClientID%>").value.length == 10) {
                $.ajax({
                    type: "POST",
                    url: URL + '/MobileVerify',
                    data: '{Mobile: "' + Mobile + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == '1') {
                            $('#lbl_Right_Worng').html("<span style='font-size:15px; color:green;'>verified</span>");
                            $('#<%=hnd_MobileVerify.ClientID%>').val('1');
                        }
                        else {
                            $('#lbl_Right_Worng').html("<span style='font-size:15px; color:red;'>" + response.d + "</span>");
                            $('#<%=hnd_MobileVerify.ClientID%>').val('0');
                            $('#<%=Txt_Mobile.ClientID%>').val('');
                        }
                    },
                    error: function (response) {
                    }
                });
            }
            else {
                // $('#trOTPGen').hide();
                $('#lbl_Right_Worng').html("<span style='font-size:15px; color:red;'>Enter 10 digits Mobile No.!!</span>");
            }
        }


        function GetDefaultSponsorId() {

            if ($('#chk_Sponsor').is(":checked")) {
                $('#div_sponsor').hide();
                $('#div_Position').hide();
                $.ajax({
                    type: "POST",
                    url: URL + '/GetDefaultSponsorId',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $('#<%=txt_Sponsor.ClientID%>').val(data.d);
                    },
                    error: function (response) {
                    }
                });
            }
            else if ($('#chk_Sponsor').is(":not(:checked)")) {
                $('#<%=txt_Sponsor.ClientID%>').val('');
                $('#div_sponsor').show();
                $('#div_Position').show();
            }

        }


        function GetDistrict() {
            $('#<%=ddlDistrict.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
            $.ajax({
                type: "POST",
                url: 'newjoin.aspx/GetDistrict',
                data: "{'StateId':'" + $("#<%=DdlState.ClientID%>").val() + "'}",
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
                control.removeAttr("disabled");
                $.each(list, function () {
                    control.append($("<option></option>").val(this['Value']).html(this['Text']));
                });
            }
            else {
                control.empty().append('<option selected="selected" value="">Not available<option>');
            }
        }


    </script>





    <script type="text/javascript">
        $(function () {

            if ("<%=DigilockeMsg%>" == "") {
                if ("<%=DigilockerrequestId%>" != "") {


                    if (window.localStorage.getItem('hnd_PanVerify') == "1") {

                        $('#<%=hnd_PanVerify.ClientID%>').val("1");
                        //$('#btn_Step1').css("display", "block");
                        $('#<%=TxtName.ClientID%>').val(window.localStorage.getItem('Name'));
                        $('#<%=TxtName.ClientID%>').removeAttr('enabled');
                        $('#<%=TxtName.ClientID%>').attr('disabled', 'disabled');

                        $('#btn_PanVerify').val('Pan Verified');
                        $('#btn_PanVerify').css('background-color', 'Green');

                        $("#btn_PanVerify").removeAttr('enabled');
                        $("#btn_PanVerify").attr('disabled', 'disabled');

                        $('#<%=txt_Pan.ClientID%>').removeAttr('enabled');
                        $('#<%=txt_Pan.ClientID%>').attr('disabled', 'disabled');

                        $('#div_PanVerifyMsg').html('<div class="alert alert-success">  <strong>Success! </strong>Dear ' + window.localStorage.getItem('Name') + ' Your PAN Card Verification successful <strong><i class="fa fa-check" aria-hidden="true"></i></strong> </div>');

                        $('#<%=hnd_PanDetails.ClientID%>').val(window.localStorage.getItem('OnlineMsg'));

                        $('#<%=txt_Pan.ClientID%>').val(window.localStorage.getItem('PanNo'));
                        $('#<%=rdo_Pan.ClientID%>').val(window.localStorage.getItem('PanYesNo'));

                    }
                    else {
                        $('#div_PanVerifyMsg').html('<div class="alert alert-danger"> <strong>Danger!</strong> ' + window.localStorage.getItem('OnlineMsg') + '</div>');
                    }

                    DigilockerFinaltyGetData();
                }
            } else {
                alert("<%=DigilockeMsg%>");
            }

        });


        function PanVerify() {
            $('#<%=hnd_PanVerify.ClientID%>').val("0");
            $('#<%=hnd_PanDetails.ClientID%>').val("");
            window.localStorage.setItem('hnd_PanVerify', "0");
            window.localStorage.setItem('Name', "");

            let PanNo = $('#<%=txt_Pan.ClientID%>').val();
            if (PanNo.length != 10) {
                alert("Plese Enter Valid Pan No.!!");
                return;
            }
            else {

                $.ajax({
                    type: "POST",
                    url: 'newjoin.aspx/LoginCredentials',
                    data: '{Flag: "PAN", PanNo: "' + PanNo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d[0].IsExist == "1") {
                            alert('Your P.A.N. No ' + PanNo + ' Already Exists.');
                            $('#<%=txt_Pan.ClientID%>').val('');
                            return false;
                        }
                        var Login = {
                            "url": "https://signzy.tech/api/v2/patrons/login",
                            "method": "POST",
                            "timeout": 0,
                            "headers": { "Content-Type": "application/json", },
                            "data": JSON.stringify({ "username": data.d[0].username, "password": data.d[0].password }),
                        };
                        $.ajax(Login).done(function (response) {
                            var Settings = {
                                "url": "https://signzy.tech/api/v2/patrons/" + response.userId + "/panv2",
                                "method": "POST",
                                "headers": {
                                    "Content-Type": "application/json",
                                    "authorization": response.id
                                },
                                "data": JSON.stringify({ "task": "fetch", "essentials": { "number": PanNo } }),
                            }
                            let PanDetails = "";
                            $.ajax(Settings).done(function (PanResponse) {
                                console.log(PanResponse);
                                if (PanResponse.result.panStatusCode == "E") {
                                    $('#<%=hnd_PanVerify.ClientID%>').val("1");
                                    //$('#btn_Step1').css("display", "block");
                                    $('#<%=TxtName.ClientID%>').val(PanResponse.result.name);
                                    $('#<%=TxtName.ClientID%>').removeAttr('enabled');
                                    $('#<%=TxtName.ClientID%>').attr('disabled', 'disabled');

                                    $('#btn_PanVerify').val('Pan Verified');
                                    $('#btn_PanVerify').css('background-color', 'Green');

                                    $("#btn_PanVerify").removeAttr('enabled');
                                    $("#btn_PanVerify").attr('disabled', 'disabled');

                                    $('#<%=txt_Pan.ClientID%>').removeAttr('enabled');
                                    $('#<%=txt_Pan.ClientID%>').attr('disabled', 'disabled');

                                    $('#div_PanVerifyMsg').html('<div class="alert alert-success">  <strong>Success! </strong>Dear ' + PanResponse.result.name + ' Your PAN Card Verification successful <strong><i class="fa fa-check" aria-hidden="true"></i></strong> </div>');


                                    window.localStorage.setItem('hnd_PanVerify', "1");
                                    window.localStorage.setItem('Name', PanResponse.result.name);

                                    window.localStorage.setItem('PanNo', $('#<%=txt_Pan.ClientID%>').val());
                                    window.localStorage.setItem('PanYesNo', $('#<%=rdo_Pan.ClientID %> input[type=radio]:checked').val());

                                }


                                PanDetails = "";

                                PanDetails = 'name : ' + PanResponse.result.name
                                    + '^ number : ' + PanResponse.result.number
                                    + '^ typeOfHolder : ' + PanResponse.result.typeOfHolder
                                    + '^ status : ' + PanResponse.result.status
                                    + '^ isIndividual : ' + PanResponse.result.isIndividual
                                    + '^ isValid : ' + PanResponse.result.isValid
                                    + '^ firstName : ' + PanResponse.result.firstName
                                    + '^ middleName : ' + PanResponse.result.middleName
                                    + '^ lastName : ' + PanResponse.result.lastName
                                    + '^ title : ' + PanResponse.result.title
                                    + '^ panStatus : ' + PanResponse.result.panStatus
                                    + '^ panStatusCode : ' + PanResponse.result.panStatusCode
                                    + '^ aadhaarSeedingStatus : ' + PanResponse.result.aadhaarSeedingStatus
                                    + '^ aadhaarSeedingStatusCode : ' + PanResponse.result.aadhaarSeedingStatusCode
                                    + '^ lastUpdatedOn : ' + PanResponse.result.lastUpdatedOn;

                                $('#<%=hnd_PanDetails.ClientID%>').val(PanDetails);
                                window.localStorage.setItem('OnlineMsg', PanDetails);


                            }).fail(function (response) {
                                window.localStorage.setItem('OnlineMsg', response.responseJSON.error.message);

                                $('#div_PanVerifyMsg').html('<div class="alert alert-danger"> <strong>Danger!</strong> ' + response.responseJSON.error.message + '</div>');
                            });



                        });

                    },
                    error: function (response) {
                    }
                });
            }
        }


        function AadharVerify() {
            $('#<%=hnd_AadharVerify.ClientID%>').val("0");
            $('#<%=hnd_AadharDetails.ClientID%>').val("");
            let Aadhar = $('#<%=txt_Aadhar.ClientID%>').val();
            if (Aadhar.length != 12) {
                alert("Plese Enter Valid Pan No.!!");
                return;
            }
            else {

                $.ajax({
                    type: "POST",
                    url: 'newjoin.aspx/LoginCredentials',
                    data: '{Flag: "", PanNo: ""}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        var Login = {
                            "url": "https://signzy.tech/api/v2/patrons/login",
                            "method": "POST",
                            "timeout": 0,
                            "headers": { "Content-Type": "application/json", },
                            "data": JSON.stringify({ "username": data.d[0].username, "password": data.d[0].password }),
                        };

                        $.ajax(Login).done(function (response) {

                            var GetIdSettings = {
                                "url": "https://signzy.tech/api/v2/patrons/" + response.userId + "/identities",
                                "method": "POST",
                                "timeout": 0,
                                "headers": { "Content-Type": "application/json", "Authorization": response.id },
                                "data": JSON.stringify({
                                    "type": "aadhaar",
                                    "email": "dilip.jain@deltaspharma.com",
                                    "callbackUrl": "https://your-domain.com/your-callback-system",
                                    "images": []
                                }),
                            };

                            $.ajax(GetIdSettings).done(function (response) {

                                var settings = {
                                    "url": "https://signzy.tech/api/v2/snoops",
                                    "method": "POST",
                                    "timeout": 0,
                                    "headers": { "Content-Type": "application/json" },
                                    "data": JSON.stringify({
                                        "service": "Identity",
                                        "itemId": response.id,
                                        "task": "verifyAadhaar",
                                        "accessToken": response.accessToken,
                                        "essentials": { "uid": Aadhar }
                                    }),
                                };
                                let AadharDetails = "";
                                $.ajax(settings).done(function (response) {

                                    if (response["response"]["result"]["verified"] == "true") {
                                        $('#<%=hnd_AadharVerify.ClientID%>').val("1");

                                        $('#btn_AadharVerify').val('Aadhar Verified');
                                        $('#btn_AadharVerify').css('background-color', 'Green');

                                        $("#btn_AadharVerify").removeAttr('enabled');
                                        $("#btn_AadharVerify").attr('disabled', 'disabled');

                                        $('#<%=txt_Aadhar.ClientID%>').removeAttr('enabled');
                                        $('#<%=txt_Aadhar.ClientID%>').attr('disabled', 'disabled');


                                        if (response["response"]["result"]["gender"] == "MALE") {
                                            $('#<%=RdoGenderNew.ClientID%>').val("0");
                                        }
                                        else if (response["response"]["result"]["gender"] == "FEMALE") {
                                            $('#<%=RdoGenderNew.ClientID%>').val("1");
                                        }
                                        else {
                                            $('#<%=RdoGenderNew.ClientID%>').val("2");
                                        }
                                    }

                                    AadharDetails = "";

                                    AadharDetails = 'verified : ' + response["response"]["result"]["verified"]
                                        + '^ ageBand : ' + response["response"]["result"]["ageBand"]
                                        + '^ state : ' + response["response"]["result"]["state"]
                                        + '^ mobileNumber : ' + response["response"]["result"]["mobileNumber"]
                                        + '^ gender : ' + response["response"]["result"]["gender"];

                                    $('#<%=hnd_AadharDetails.ClientID%>').val(AadharDetails);

                                });

                            });

                        });

                    },
                    error: function (response) {
                    }
                });
            }
        }


        function DigilockerVerify() {

            $.ajax({
                type: "POST",
                url: 'newjoin.aspx/LoginCredentials',
                data: '{Flag: "", PanNo: ""}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var Login = {
                        "url": "https://signzy.tech/api/v2/patrons/login",
                        "method": "POST",
                        "timeout": 0,
                        "headers": { "Content-Type": "application/json", },
                        "data": JSON.stringify({ "username": data.d[0].username, "password": data.d[0].password }),
                    };
                    $.ajax(Login).done(function (response) {

                        window.localStorage.setItem('digilockerTokenid', response.id);
                        window.localStorage.setItem('digilockerUserId', response.userId);
                        var settings = {
                            "url": "https://signzy.tech/api/v2/patrons/" + response.userId + "/digilockers",
                            "method": "POST",
                            "timeout": 0,
                            "headers": {
                                "accept": "*/*",
                                "accept-language": "en-US,en;q=0.8",
                                "authorization": response.id,
                                "content-type": "application/json"
                            },
                            "data": JSON.stringify({
                                "task": "url",
                                "essentials": {
                                    "signup": "false",
                                    "redirectUrl": "<%=CallBackUrl%>",
                                    "redirectTime": "2",
                                    "callbackUrl": "<%=CallBackUrl%>"
                                }
                            }),
                        };
                        $.ajax(settings).done(function (response) {
                            window.location = response.result.url;
                        });
                    });
                },
                error: function (response) {
                }
            });

        }



        function DigilockerFinaltyGetData() {
            $('#<%=hnd_DigilockerVerify.ClientID%>').val("0");
            $('#<%=hnd_DigilockerDetails.ClientID%>').val("");
            $('#<%=hnd_AadharVerify.ClientID%>').val("0");
            var settings = {
                "url": "https://signzy.tech/api/v2/patrons/" + window.localStorage.getItem('digilockerUserId') + "/digilockers",
                "method": "POST",
                "timeout": 0,
                "headers": {
                    "Content-Type": "application/json",
                    "Authorization": window.localStorage.getItem('digilockerTokenid')
                },
                "data": JSON.stringify({
                    "task": "getDetails",
                    "essentials": { "requestId": "<%=DigilockerrequestId%>" }
                }),
            };
            let DigilockerDetails = "";
            $.ajax(settings).done(function (response) {
                //console.log(response);
                //alert("Success1");
                //debugger;
                //console.log(JSON.stringify(response.result.files));

                $('#<%=TxtName.ClientID%>').val(response.result.userDetails.name);
                $('#<%=txtDOB.ClientID%>').val(response.result.userDetails.dob);
                if (response.result.userDetails.gender == "M") {
                    $('#<%=RdoGenderNew.ClientID%>').val("0");
                }
                else if (response.result.userDetails.gender == "F") {
                    $('#<%=RdoGenderNew.ClientID%>').val("1");
                }
                else {
                    $('#<%=RdoGenderNew.ClientID%>').val("2");
                }

                $('#<%=hnd_DigilockerVerify.ClientID%>').val("1");
                $('#<%=hnd_AadharVerify.ClientID%>').val("1");
                $('#btn_DigilockerVerify').val(' Aadhar card Verified (Digilocker)');
                $('#btn_DigilockerVerify').css('background-color', 'Green');

                $("#btn_DigilockerVerify").removeAttr('enabled');
                $("#btn_DigilockerVerify").attr('disabled', 'disabled');


                DigilockerDetails = DigilockerDetails + 'digilockerid : ' + response.result.userDetails.digilockerid
                    + '^ name : ' + response.result.userDetails.name
                    + '^ dob : ' + response.result.userDetails.dob
                    + '^ gender : ' + response.result.userDetails.gender
                    + '^ digilockerid : ' + response.result.userDetails.digilockerid
                    + '^ eaadhaar : ' + response.result.userDetails.eaadhaar;



                var FileObj = JSON.parse(JSON.stringify(response.result.files));

                $.each(FileObj, function (key, Item) {

                    if (Item.doctype == "ADHAR") {

                        DigilockerDetails = DigilockerDetails + 'ADHAR : ADHAR ^ date : ' + Item.date
                            + '^ description : ' + Item.description
                            + '^ doctype : ' + Item.doctype
                            + '^ id : ' + Item.id
                            + '^ issuer : ' + Item.issuer
                            + '^ issuerid : ' + Item.issuerid
                            + '^ name : ' + Item.name
                            + '^ parent : ' + Item.parent
                            + '^ size : ' + Item.size
                            + '^ type : ' + Item.eaatypedhaar;


                        var settings = {
                            "url": "https://signzy.tech/api/v2/patrons/" + window.localStorage.getItem('digilockerUserId') + "/digilockers?",
                            "method": "POST",
                            "timeout": 0,
                            "headers": {
                                "Content-Type": "application/json",
                                "Authorization": window.localStorage.getItem('digilockerTokenid')
                            },
                            "data": JSON.stringify({
                                "task": "getEadhaar",
                                "essentials": { "requestId": "<%=DigilockerrequestId%>" }
                            }),
                        };

                        $.ajax(settings).done(function (response) {

                            $('#<%=txtAddress.ClientID%>').val(response.result.address);
                            $('#<%=txt_Aadhar.ClientID%>').val(response.result.uid);

                            var AddressArray = JSON.parse(JSON.stringify(response.result.splitAddress));

                            $('#<%=txt_Pincode.ClientID%>').val(AddressArray.pincode);
                            $('#<%=txtCity.ClientID%>').val(AddressArray.city);

                            var stateArr = AddressArray.state;

                            var state = stateArr[0];

                            DigilockerDetails = DigilockerDetails + 'address :  ^ address : ' + response.result.address
                                + '^ state : ' + state[0]
                                + '^ district : ' + AddressArray.district
                                + '^ city : ' + AddressArray.city
                                + '^ pincode : ' + AddressArray.pincode;

                            $('#<%=hnd_DigilockerDetails.ClientID%>').val(DigilockerDetails);

                            $.ajax({
                                type: "POST",
                                url: 'newjoin.aspx/GetStateId',
                                data: '{statename: "' + state[0] + '"}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {

                                    $('#<%=DdlState.ClientID%>').val(data.d);
                                    GetDistrict();

                                    $.ajax({
                                        type: "POST",
                                        url: 'newjoin.aspx/GetDistrictId',
                                        data: '{district: "' + AddressArray.district + '"}',
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (data) {
                                            $('#<%=ddlDistrict.ClientID%>').val(data.d);
                                        },
                                        error: function (response) {
                                        }
                                    });

                                },
                                error: function (response) {
                                }
                            });

                        });
                    }



                    if (Item.doctype == "PANCR") {

                        DigilockerDetails = DigilockerDetails + 'PANCR : PANCR ^ date : ' + Item.date
                            + '^ description : ' + Item.description
                            + '^ doctype : ' + Item.doctype
                            + '^ id : ' + Item.id
                            + '^ issuer : ' + Item.issuer
                            + '^ issuerid : ' + Item.issuerid
                            + '^ name : ' + Item.name
                            + '^ parent : ' + Item.parent
                            + '^ size : ' + Item.size
                            + '^ type : ' + Item.eaatypedhaar;

                        $('#<%=hnd_DigilockerDetails.ClientID%>').val(DigilockerDetails);

                        $('#<%=txt_Pan.ClientID%>').val(Item.id.substr(Item.id.length - 10));
                    }
                });
            });
        }

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }

        function OnlyAlphabets(key) {
            var regex = /^[ A-Za-z0-9_@/#)(]*$/
            if (regex.test(key)) { return true; }
            else { return false; }
        }


    </script>
    <style>
        .upload_doc {
            background: #9d9e9e;
            color: #000;
            font-size: 14px;
            width: 180px;
            text-align: center;
            font-weight: 100;
            border-radius: 5px;
            border: 1px solid #6c6c6c;
        }

        .btn-custom, .btn-custom-2 {
            position: static;
        }

        table {
            margin-bottom: 0px;
        }

        .btn {
            min-width: 180px;
            font-family: var(--font-family-heading);
            font-size: var(--font-16);
            font-weight: 700;
            line-height: 20px;
            text-transform: capitalize;
            text-align: center;
            overflow: hidden;
            display: inline-block;
            padding: 15px 30px;
            border: 0px solid transparent;
            border-radius: 5px;
            color: #fff;
            background-color: #ff0041;
        }

            .btn:hover {
                color: #fff;
                background-color: #ff0041;
                border-color: #ff0041;
            }

            .btn:before {
                background-color: #002e9e00 !important;
                color: var(--white-color) !important;
            }

        label {
            margin-bottom: 5px;
            font-weight: 500;
            font-size: 20px;
            color: #a5a5ad;
            margin-left: 5px;
        }

        .panel-default > .panel-heading {
            background: #ff0041;
            border: none;
            color: #fff;
            /* font-weight: bold; */
            padding: 10px;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .form-control {
            height: 50px !important;
            padding: 8px 15px;
            border-radius: 8px !important;
            border: 1px solid #dbd8d8 !important;
            width: 100%;
            color: #242323;
            border-color: #ff0041;
            background-color: #fff7f7;
            letter-spacing: 0.1px;
            font-size: 0.98rem !important;
            margin-bottom: 15px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .billing-cart {
            text-align: left;
            background: #ffe9e9;
            margin: 15px 0;
            padding: 10px;
            color: #161515;
            font-size: 25px;
        }

        table td {
            border: none;
            margin-bottom: 0px;
            font-size: 16px;
        }

        .panel-default > .panel-heading h3 {
            color: #fff;
            font: 600 23px/23px "Raleway", sans-serif;
            margin-bottom: 0px;
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

        input[type=checkbox] {
            /* Double-sized Checkboxes */
            -ms-transform: scale(2); /* IE */
            -moz-transform: scale(2); /* FF */
            -webkit-transform: scale(1.5);
            -o-transform: scale(2); /* Opera */
            padding: 10px;
        }

        .contact-form {
            margin-top: var(--space-5);
            padding: var(--space-10) var(--space-15);
        }

        .default-form textarea.form-control {
            padding-top: 8px;
        }

        .table-fixed {
            table-layout: fixed;
        }

        .control-label {
            padding-top: 12px;
        }
    </style>
</asp:Content>
