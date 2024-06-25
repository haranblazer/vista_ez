<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" EnableEventValidation="true"
    CodeFile="AddFranchise.aspx.cs" Inherits="AddFranchise" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
       /* @media (min-width: 320px) {
            .col-xs-4 {
                width: 20% !important;
            }

            .col-xs-8 {
                width: 80% !important;
            }

            .col-md-3 {
                width: 100% !important;
            }
        }*/

       /* @media only screen and (min-width: 1240px) {
            .col-md-3 {
                width: 100% !important;
            }

            .col-md-4 {
                width: 16.66667% !important;
            }

            .col-md-5 {
                width: 41.66667% !important;
            }*/

            .cvt_rs {
                height: auto;
                width: 1170px !important;
            }
        }

        label {
            margin-bottom: 5px;
            font-weight: 100;
            font-size: 17px;
            color: #000;
            margin-left: 5px;
            margin-top: 10px;
        }

        .panel-default > .panel-heading {
            background: #0f4076;
            border: none;
            color: #fff;
            /* font-weight: bold; */
            padding: 10px;
            font-size: 18px;
            margin-bottom: 10px;
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
        .btn-custom, .btn-custom-2 {
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
        .breadcrumb-item a, .breadcrumb-item {
            color: #040404;
            font-size: 26px;
            
        }
    </style>
      <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list d-block text-center">
               
                <li class="breadcrumb-item"><a href="#">Become a Franchise</a></li>
            </ol>
        </div>
    </div>
   
    <div class="section checkout-sec cart-sec ">
        <div class="container-fluid">
            <div class="row">
                <div class="panel panel-default " style="background: #fff; width: 100%">

                    <div id="LoaderImg" style="width: 100%; text-align: center; position: relative; z-index: 99999; display: none;">
                        <img src="../images/toptime-logo-new.gif" alt="" style="height: 200px" />
                    </div>



                    <div id="Step1" style="display: none;">
                        <div class="clearfix"></div>
                        <div class="m-auto">

                            <div class="col-md-4 m-auto">
                                <img src="images/pan_card.jpg" class="w-100" />
                            </div>
                            <div class="col-md-2 m-auto">

                                <asp:RadioButtonList ID="rdo_Pan" runat="server" RepeatDirection="Horizontal" CssClass="m-0" onclick="javascript:PanShowHide();">
                                    <asp:ListItem Value="1" Selected="True">Yes</asp:ListItem>
                                    <asp:ListItem Value="0">No</asp:ListItem>
                                </asp:RadioButtonList>

                            </div>
                            <div class="col-md-4 m-auto text-center">

                               <%-- <asp:TextBox ID="txtPanNo" runat="server" CssClass="form-control" placeholder="Enter Pan Card No."></asp:TextBox>--%>
                                <span id="lbl_PanNote" style="color: red; display: none;"><b>20 % TDS will be deducted from all payout.</b></span>
                                <div id="div_PanVerifyMsg"></div>

                            </div>
                            <div class="col-md-4 m-auto">
                                <div class=" m-3">
                                    <div class="col-md-6 m-auto">

                                        <input type="button" id="btn_PanVerify" value="Verify Pan" onclick="javascript:PanVerify();" class="btn-custom btn-primary secondary btn-block" />
                                    </div>

                                    <div class="col-md-6 m-auto">
                                        <input type="button" id="btn_Step1" value="Next" onclick="javascript:Step(1);" class="btn-custom btn-primary secondary btn-block" style="display: none;" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- <div class="clearfix"></div>
                        <div class="m-auto">
                            <div class="col-md-4 m-auto"></div>
                            <div class="col-md-4 m-auto text-center">
                                <div id="div_PanVerifyMsg"></div>
                            </div>
                            <div class="col-md-4 m-auto"></div>--%>
                        </div>
                      
                    <div id="Step2" >
                        <h4 class="billing-cart">Franchise Details</h4>
                        <div class="clearfix"></div>

                        <div class="row">
                           
                            <div class="col-md-2">
                                <label>Asso. Sponsor ID <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:Label ID="lblFranSpon" runat="server"></asp:Label>
                                <asp:TextBox ID="txtsponsorid" runat="server" MaxLength="10" TabIndex="2" CssClass="form-control" placeholder="Enter Associates Sponsor ID" onchange="GetSponsorName();"></asp:TextBox>
                            </div>
                                                        <div class="col-md-2">
    <label>Franchise Type <span style="color: red;">*</span></label>
</div>
<div class="col-md-4">
  
<asp:DropDownList ID="ddltype" runat="server" TabIndex="1" CssClass="form-control" onchange="Bind_MinMntStock()">
</asp:DropDownList>
</div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="row">
                            <div class="col-md-2">
                                <label>Fran. / Firm Name <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtName" class="searchbox" runat="server" TabIndex="3" CssClass="form-control"
                                    placeholder="Enter Franchise/ Firm Name"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label>Proprietor/ Partner/ Director Name </label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtContactPerson" runat="server" TabIndex="10" CssClass="form-control"
                                    placeholder="Enter Proprietor/ Partner/ Director Name"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label>Address <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtAddress" placeholder="Address" runat="server" TextMode="MultiLine" Height="60px" Width="100%"
                                    CssClass="form-control" MaxLength="400"></asp:TextBox>
                            </div>

                            <div class="col-md-2">
                                <label>State <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control" onchange="GetDistrict();">
                                    <asp:ListItem Value="">Select State</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-2">
                                <label>District <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">Select District</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-2">
                                <label>City <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtCity" placeholder="City" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label>Pincode <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txt_Pincode" placeholder="Pin Code" runat="server" CssClass="form-control" MaxLength="6"></asp:TextBox>
                            </div>

                            <div class="col-md-2">
                                <label>Email ID <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtEMailId" runat="server" TabIndex="5" CssClass="form-control"
                                    placeholder="Enter E-mail Id"></asp:TextBox>
                            </div>
                             <div class="col-md-2"><label>PAN No. <span style="color: red;">*</span></label></div>
                            <div class="col-md-4">
                                <%--<div class="form-group">
                                    <div class="col-md-12">--%>
                                       <asp:TextBox ID="txtPanNo" class="searchbox" runat="server" TabIndex="12" CssClass="form-control"
                                            placeholder="Enter PAN No"></asp:TextBox>
                                   <%-- </div>
                                </div>--%>
                            </div>
                                                                                    <div class="col-md-2">
    <label>Aadhar No. <span style="color: red;">*</span></label>
</div>
<div class="col-md-4">
    <asp:TextBox ID="txtAdharNo" runat="server" onkeypress="return onlyNumbers(event,this);" MaxLength="12"  CssClass="form-control" Width="100%" placeholder="Enter Your Aadhaar Number"></asp:TextBox>

</div>
                           
                            <div class="col-md-2">
                                <label>GST No.<span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtGSTNo" class="searchbox" runat="server" TabIndex="14" CssClass="form-control"
                                    placeholder="Enter GST No"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label>Cin No.</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtCinNo" class="searchbox" runat="server" TabIndex="13" CssClass="form-control"
                                    placeholder="Enter CIN No"></asp:TextBox>
                            </div>

                            <div class="col-md-2">
                                <label>Mobile No. <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="Txt_Mobile" runat="server" onkeypress="return onlyNumbers(event,this);" CssClass="form-control" Width="100%" placeholder="Enter Your Mobile Number"
                                    MaxLength="10"></asp:TextBox>

                            </div>

                             <%--<div class="col-md-2">
     <label>PAN No. <span style="color: red;">*</span></label>
 </div>
 <div class="col-md-4">
     <asp:TextBox ID="txtPanNo" runat="server" CssClass="form-control" Width="100%" placeholder="Enter Your PAN Number"></asp:TextBox>

 </div>--%>

                                                     


                            <div class="col-md-6">
                                <%--onchange="MobileVerify()"--%>
                                <div class="col-md-12">
                                    <img src="images/whatsapp-2.png" style="width: 25px; margin-right: 3px; margin-top: -4px;">
                                    <asp:CheckBox ID="chk_Notify" runat="server" Checked="true"/>
                                    <span style="font-size: 18px; left: 3px;">Allow Notifications
                                        <div style="font-size: 18px; color: #a5a5ad;">We respect privacy and your information is secure with us       </div>
                                    </span>
                                </div>
                                <div id="lbl_Right_Worng"></div>
                            </div>



                            <div class="clearfix"></div>




                            <div class="col-md-6">
                                <div class="row" style="display: none;">
                                    <div class="col-md-4 ml-3">
                                        <input type="button" value="Back" onclick="javascript:Back(1);" class="btn-custom btn-primary secondary btn-block" />
                                    </div>
                                    <div class="col-md-4">
                                        <input type="button" id="btn_Step2" value="Next" onclick="javascript:Step(2);" class="btn-custom btn-primary secondary btn-block" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                       
                    </div>


                    <div id="Step5">
                        <h4 class="billing-cart">Upload KYC </h4>
                        <div class="clearfix"></div>
                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="file" id="img_Pan" accept=".png,.jpg,.jpeg,.gif,.pdf" style="display: none;" />
                                        <label for="img_Pan" title="Pan Card" class="btn-custom btn-primary secondary btn-block">Pan Card</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="file" id="img_Bank" accept=".png,.jpg,.jpeg,.gif,.pdf" style="display: none;" />
                                        <label for="img_Bank" title="Bank" class="btn-custom btn-primary secondary btn-block">Bank </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="file" id="img_Gst" accept=".png,.jpg,.jpeg,.gif,.pdf" style="display: none;" />
                                        <label for="img_Gst" title="GST" class="btn-custom btn-primary secondary btn-block">GST No.</label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="file" id="img_slip" accept=".png,.jpg,.jpeg,.gif,.pdf" style="display: none;" />
                                        <label for="img_slip" title="GST" class="btn-custom btn-primary secondary btn-block">Payment Slip.</label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="file" id="img_Aadhar_Front" accept=".png,.jpg,.jpeg,.gif,.pdf" style="display: none;" />
                                        <label for="img_Aadhar_Front" title="Aadhar Card Front" class="btn-custom btn-primary secondary btn-block">Aadhar Front</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="file" id="img_Aadhar_Back" accept=".png,.jpg,.jpeg,.gif,.pdf" style="display: none;" />
                                        <label for="img_Aadhar_Back" title="Aadhar Card Back" class="btn-custom btn-primary secondary btn-block">Aadhar Back</label>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="clearfix"></div>
                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div id="div_ImgPan" runat="server"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div id="div_ImgBank" runat="server"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div id="div_ImgGst" runat="server"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div id="div_slip" runat="server"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div id="div_ImgAadharFront" runat="server"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div id="div_ImgAadharBack" runat="server"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>

                    <div id="Step3">
                        <h4 class="billing-cart">Bank Details</h4>

                        <div class="clearfix"></div>
                        <div class="row">
                            <div class="col-md-2">
                                <label>Bank Name <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>

                           
                            <div class="col-md-2">
                                <label>Bank Type <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddlAcType" runat="server" CssClass="form-control">
                                    <asp:ListItem Selected="True" Value="">Select Type</asp:ListItem>
                                    <asp:ListItem>SAVING A/C</asp:ListItem>
                                    <asp:ListItem>CURRENT A/C</asp:ListItem>
                                    <asp:ListItem>CC A/C</asp:ListItem>
                                    <asp:ListItem>OD A/C</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            
                            <div class="col-md-2">
                                <label>A/C No. <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control" placeholder="Enter Your A/C No."></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label>Branch <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control" placeholder="Enter Your Branch"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label>IFSC Code <span style="color: red;">*</span></label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtifs" runat="server" CssClass="form-control" placeholder="Enter Your IFSC Code"></asp:TextBox>
                            </div>
                            <h4 class="billing-cart">Security Details</h4>
                             <div class="col-md-2">
     <label>Password <span style="color: red;">*</span></label>
 </div>
                            <div class="col-md-4">
                                
                                        <asp:TextBox ID="TxtPassword" runat="server" CssClass="form-control" MaxLength="15"
                                            TextMode="Password" placeholder="Enter Your Password"></asp:TextBox>
                            </div>
                          
                                                        <div class="col-md-2">
    <label>Confirm Password <span style="color: red;">*</span></label>
</div>
                           <div class="col-md-4">
                               
                           <input type="password" id="txtConfirmPSWRD" class="form-control" name="confirmPassword" placeholder="Confirm password" onkeyup="checkPassword()" />
                          <span id="passwordMatch"></span>
                               </div>
                            
                                                         <div class="col-md-2">
     <label>Wallet Password <span style="color: red;">*</span></label>
 </div>
                            <div class="col-md-4">
                                
                                        <asp:TextBox ID="txtEPSWRD" runat="server" CssClass="form-control" MaxLength="15"
                                            TextMode="Password" placeholder="Enter Your Password"></asp:TextBox>
                            </div>
                          
                                                        <div class="col-md-2">
    <label>Confirm Wallet Password <span style="color: red;">*</span></label>
</div>
                           <div class="col-md-4">
                              
                           <input type="password" id="txtConfirmEPSWRD" class="form-control" name="confirmPassword" placeholder="Confirm E Password" onkeyup="check_Password()" />
                          <span id="EpasswordMatch"></span>
                               </div>
                                                      
                            <div class="col-md-2">
                                <label>
                                    Digit&nbsp;Sum&nbsp;(&nbsp;<asp:Label ID="lbl_Digit1" runat="server">0</asp:Label>&nbsp;+&nbsp;<asp:Label ID="lbl_Digit2" runat="server">0</asp:Label>&nbsp;)&nbsp;=
                                    
                                    <span style="color:red;">*</span>
                                </label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txt_Digit" runat="server" CssClass="form-control m-0"
                                    placeholder="Sum of digit" autocomplete="off"></asp:TextBox>
                            </div>
                      <div class="col-md-2"></div>
                                <div class="col-md-4 ">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Width="20px" />
                                    <span class="txt" style="font-size: 18px;">Please Accept <a class="txt" href="terms_and_condition.aspx" target="_blank"
                                        style="color: #551e00; text-align: justify;">Terms &amp; Conditions </a></span>
                                </div>
                              
                                    <%--<div class="col-md-2">
                                        <input type="button" value="Back" onclick="javascript:Back(2);" class="btn-custom btn-btn-danger primary btn-block" />
                                    </div>--%>
                             <div class="clearfix"></div>
                             <div class="col-md-2"></div>
                                    <div class="col-md-4 mt-2">
                                        <input type="button" value="Submit" onclick="javascript:Step(3);" class="btn-custom btn-primary secondary btn-block" />
                                    </div>
                                </div>
                          </div>
                        </div>
                   
                    <div class="clearfix"></div>



            

                <div id="Step4" style="display: none;">

                    <div class="clearfix"></div>
                    <div class="col-md-6">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <%--<tr>
                                    <td width="50%">Pan Card No.</td>
                                    <td width="50%">
                                        <div id="lbl_PanNo"></div>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>Sponsor Id</td>
                                    <td><span id="lbl_sponsorid"></span></td>
                                </tr>
                                 <tr>
     <td>Franchise Type</td>
     <td><span id="lbl_FranType"></span></td>
 </tr>
                                <tr>
                                    <td>Franchise/ Firm Name</td>
                                    <td><span id="lbl_FrachiseName"></span></td>
                                </tr>
                                <tr>
                                    <td>Proprietor/ Partner/ Director Name</td>
                                    <td><span id="lbl_Propertor"></span></td>
                                </tr>
                                <tr>
                                    <td>Address</td>
                                    <td><span id="lbl_Address"></span></td>
                                </tr>
                                <tr>
                                    <td>City</td>
                                    <td><span id="lbl_City"></span></td>
                                </tr>
                                <tr>
                                    <td>State</td>
                                    <td><span id="lbl_State"></span></td>
                                </tr>
                                <tr>
                                    <td>District</td>
                                    <td><span id="lbl_District"></span></td>
                                </tr>
                                <tr>
                                    <td>Pin Code</td>
                                    <td><span id="lbl_PinCode"></span></td>
                                </tr>
                                <tr>
                                    <td>Email-Id</td>
                                    <td><span id="lbl_Email"></span></td>
                                </tr>
                                <tr>
                                    <td>CIN No.</td>
                                    <td><span id="lbl_CIN"></span></td>
                                </tr>
                                                                <tr>
    <td>PAN No.</td>
    <td><span id="lbl_PAN"></span></td>
</tr>
                                 <tr>
     <td>Aadhaar No.</td>
     <td><span id="lbl_Adhar"></span></td>
 </tr>
                                <tr>
                                    <td>GST No.</td>
                                    <td><span id="lbl_GST"></span></td>
                                </tr>
                                <tr>
                                    <td>Mobile No.</td>
                                    <td><span id="lbl_Mobile"></span></td>
                                </tr>
                                <tr>
                                    <td>Bank</td>
                                    <td><span id="lbl_Bank"></span></td>
                                </tr>
                                <tr>
                                    <td>Bank Type</td>
                                    <td><span id="lbl_BankType"></span></td>
                                </tr>
                                <tr>
                                    <td>Account No. </td>
                                    <td><span id="lbl_AcNo"></span></td>
                                </tr>
                                <tr>
                                    <td>Branch</td>
                                    <td><span id="lbl_Branch"></span></td>
                                </tr>
                                <tr>
                                    <td>IFSC Code</td>
                                    <td><span id="lbl_IFSC"></span></td>
                                </tr>
                                 <tr>
     <td>Password</td>
     <td><span id="lbl_Password"></span></td>
 </tr>
                                 <tr>
     <td>Wallet Password</td>
     <td><span id="lbl_EPassword"></span></td>
 </tr>

                            </table>
                        </div>
                    </div>

                    <div class="">
                        <div class="col-md-10">
                            <div class="row">
                                <div class="col-md-2">
                                    <input type="button" id="btn_Back3" value="Back" onclick="javascript:Back(3);" class="btn-custom btn-primary secondary btn-block" />
                                </div>
                                <div class="col-md-2">
                                    <input type="button" id="btn_submit" value="Submit" onclick="Validation();" class="btn-custom btn-primary secondary btn-block" />
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="clearfix"></div>
                    <div class="m-auto">
                        <div class="col-md-12 m-auto text-center">
                            <div id="div_SuccessMsg"></div>
                        </div>

                    </div>
                    <hr />
                </div>
                    <br />
                    <br />

                </div>
            </div>
        </div>
    </div>


    <%-- <asp:HiddenField ID="hnd_MobileVerify" runat="server" Value="0" />--%>
    <asp:HiddenField ID="hnd_PanVerify" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_PanDetails" runat="server" Value="" />

    <asp:HiddenField ID="hnd_AadharVerify" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_AadharDetails" runat="server" Value="" />

    <asp:HiddenField ID="hnd_DigilockerVerify" runat="server" Value="0" />
    <asp:HiddenField ID="hnd_DigilockerDetails" runat="server" Value="" />

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var URL = "AddFranchise.aspx";
        var District = "";
        var ImgName_Pan = "";
        var ImgName_Bank = "";
        var ImgName_Aadhar_Front = "";
        var ImgName_Aadhar_Back = "";
        var GST_img = "";
        var ImgName_Slip = "";
        $(function () {

            $('#<%=lbl_Digit1.ClientID%>').text(parseInt(Math.random().toFixed(1) * 10));
            $('#<%=lbl_Digit2.ClientID%>').text(parseInt(Math.random().toFixed(1) * 10));

          <%--  if ($('#<%=Txt_Mobile.ClientID%>').val() != '') { MobileVerify(); }--%>

            $(":input").attr("autocomplete", "off");

        });


        function Validation() {

            var MSG = "";
            var SponsorId = $('#<%=txtsponsorid.ClientID%>').val(),
                ContactPerson = $('#<%=txtContactPerson.ClientID%>').val(),
                Name = $('#<%=txtName.ClientID%>').val(),

                GSTNo = $('#<%=txtGSTNo.ClientID%>').val(),
                CinNo = $('#<%=txtCinNo.ClientID%>').val(),
                PAN = $('#<%=txtPanNo.ClientID%>').val(),
                Aadhaar = $('#<%=txtAdharNo.ClientID%>').val(),
                
                Mobile = $('#<%=Txt_Mobile.ClientID%>').val(),
                Email = $('#<%=txtEMailId.ClientID%>').val(),

                state = $('#<%=DdlState.ClientID%> option:selected').text(),

                District = $('#<%=ddlDistrict.ClientID%> option:selected').text(),
                City = $('#<%=txtCity.ClientID%>').val(),
                Pincode = $('#<%=txt_Pincode.ClientID%>').val(),
                Address = $('#<%=txtAddress.ClientID%>').val(),

                Bank = $('#<%=ddlBankName.ClientID%> option:selected').text(),
                ACType = $('#<%=ddlAcType.ClientID%> option:selected').text(),
                ACNo = $('#<%=txtAccNo.ClientID%>').val(),
                Branch = $('#<%=txtbranch.ClientID%>').val(),
                IFSC = $('#<%=txtifs.ClientID%>').val(),

                PanVerify = $('#<%=hnd_PanVerify.ClientID%>').val(),
                PanDetails = $('#<%=hnd_PanDetails.ClientID%>').val(),

                Whats_Notify = $('#<%=chk_Notify.ClientID%>').is(':checked') == true ? 1 : 0,
                Digit1 = $('#<%=lbl_Digit1.ClientID%>').text(),
                Digit2 = $('#<%=lbl_Digit2.ClientID%>').text(),
                Digit = $('#<%=txt_Digit.ClientID%>').val(),
                Password = $('#<%=TxtPassword.ClientID%>').val();
            CPSWRD = $('#txtConfirmPSWRD').val();
            EPassword = $('#<%=txtEPSWRD.ClientID%>').val();
            ECPSWRD = $('#txtConfirmEPSWRD').val();
            FranType = $('#<%=ddltype.ClientID%>').val();
            PSWRDMatch = document.getElementById('passwordMatch');
            EPSWRDMatch = document.getElementById('EpasswordMatch');
            
           // txtConfirmPSWRD, txtConfirmEPSWRD
            <%--ddlBankName, ddlAcType, txtAccNo, txtbranch, txtifs
            if ($('#<%=ddlBankName.ClientID%>').val() == "") {
                Bank = "";
            }

            if ($('#<%=ddlAcType.ClientID%>').val() == "") {
                ACType = "";
            }--%>
           
            //if (Password == "") {
            //    MSG += "\n Please Enter Password.!!";
            //}
            //else if (Password != "") {
            //    alert();
            //    if (Password.length < 5) {
            //        MSG += "\n Password Length Can Be Minimum Of 5 Character.!!";
            //    }
            //    if (CPSWRD == "" || PSWRDMatch == "Passwords do not match!") {
            //        MSG += "\n Please Confirm your Password first.!!";
            //    }
            //}
            //if (EPassword == "") {
            //    MSG += "\n Please Enter E Password.!!";
            //}
            //else if (EPassword != "") {
            //    if (EPassword.length < 5)
            //    {
            //        MSG += "\n Password Length Can Be Minimum Of 5 Character.!!";
            //    }
            //    if (ECPSWRD == "" || EPSWRDMatch == "Passwords do not match!") {
            //        MSG += "\n Please Confirm your E Password first.!!";
            //    }
            //}

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
            if (MSG != "") {
                alert(MSG);
                return false;
            }



            if (!confirm('Are you sure you want to save your details？')) {
                return false;
            }


            $('#btn_submit').removeAttr("enabled");
            $('#btn_submit').attr("disabled", "disabled");
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: URL + '/AddFran',
                data: '{SponsorId: "' + SponsorId + '", ContactPerson: "' + ContactPerson + '",  Name: "' + Name + '", Mobile: "' + Mobile + '", Email: "' + Email + '", state: "' + state
                    + '", District: "' + District + '", City: "' + City + '", Pincode: "' + Pincode + '", Address: "' + Address
                    + '", GSTNo: "' + GSTNo + '", CinNo: "' + CinNo + '", PAN: "' + PAN + '", Bank: "' + Bank + '", ACType: "' + ACType
                    + '", ACNo: "' + ACNo + '", Branch: "' + Branch + '", IFSC: "' + IFSC + '", Whats_Notify: "' + Whats_Notify
                    + '", Password: "' + Password + '", PanVerify: "' + PanVerify + '", PanDetails: "' + PanDetails + '", Aadhaar: "' + Aadhaar + '", EPassword: "' + EPassword + '", FranType: "' + FranType + '"}',
                
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d.Error == "") {

                        var Name = $('#<%=txtContactPerson.ClientID%>').val();


                        Upload_Pan().then(function () {
                            Upload_Bank().then(function () {
                                Upload_Aadhar_Front().then(function () {
                                    Upload_Aadhar_Back().then(function () {
                                        Upload_GST().then(function () {
                                            Upload_slip().then(function () {

                                                if (ImgName_Pan == null || ImgName_Bank == null || ImgName_Aadhar_Front == null || ImgName_Aadhar_Back == null || GST_img == null || ImgName_Slip == null) {
                                                    $('#div_SuccessMsg').html('<div class="alert alert-success">  <strong>Success! </strong>Dear ' + Name + ' Your details saved successfully. <strong><i class="fa fa-check" aria-hidden="true"></i></strong> </div>');
                                                    $('#btn_Back3').css('display', 'none');
                                                    $('#btn_submit').css('display', 'none');

                                                } else {

                                                    $.ajax({
                                                        type: "POST",
                                                        url: URL + '/UpdateImg',
                                                        data: '{franchiseid: "' + data.d.franchiseid + '", ImgName_Pan: "' + ImgName_Pan + '", ImgName_Bank: "' + ImgName_Bank
                                                            + '", ImgName_Aadhar_Front: "' + ImgName_Aadhar_Front + '", ImgName_Aadhar_Back: "' + ImgName_Aadhar_Back + '", GST_img: "' + GST_img + '", Slip: "' + ImgName_Slip + '"}',
                                                        contentType: "application/json; charset=utf-8",
                                                        dataType: "json",
                                                        success: function (data) {
                                                            $('#div_SuccessMsg').html('<div class="alert alert-success">  <strong>Success! </strong>Dear ' + Name + ' Your details saved successfully. <strong><i class="fa fa-check" aria-hidden="true"></i></strong> </div>');
                                                            $('#btn_Back3').css('display', 'none');
                                                            $('#btn_submit').css('display', 'none');
                                                        },
                                                        error: function (response) { }
                                                    });
                                                }

                                                $('#<%=txtsponsorid.ClientID%>').val('');
                                                $('#<%=txtName.ClientID%>').val('');
                                                $('#<%=DdlState.ClientID%>').val('');
                                                $('#<%=txtContactPerson.ClientID%>').val('');
                                                $('#<%=Txt_Mobile.ClientID%>').val('');
                                                $('#<%=txtEMailId.ClientID%>').val('');
                                                $('#<%=TxtPassword.ClientID%>').val('');

                                                $('#<%=txtCity.ClientID%>').val('');
                                                $('#<%=txt_Pincode.ClientID%>').val('');
                                                $('#<%=txtCinNo.ClientID%>').val('');
                                                $('#<%=txtPanNo.ClientID%>').val('');
                                                $('#<%=txtGSTNo.ClientID%>').val('');
                                                $('#<%=txtAccNo.ClientID%>').val('');
                                                $('#<%=txtbranch.ClientID%>').val('');
                                                $('#<%=txtifs.ClientID%>').val('');

                                                $('#<%=DdlState.ClientID%>').val('');
                                                $('#<%=ddlDistrict.ClientID%>').val('');
                                                $('#<%=ddlBankName.ClientID%>').val('');
                                                $('#<%=ddlAcType.ClientID%>').val('');
                                                $('#<%=CheckBox1.ClientID%>').attr('checked', false);

                                            });
                                        });
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



        function isValidEmailAddress(emailAddress) {
            var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
            return pattern.test(emailAddress);
        };

        function isValid_IFSC(IFSC) {
            let pattern = new RegExp(/[A-Z|a-z]{4}[0][a-zA-Z0-9]{6}$/);
            return pattern.test(IFSC);
        };


        function PanShowHide() {
            var radioValue = $('#<%=rdo_Pan.ClientID %> input[type=radio]:checked').val();
            if (radioValue == "1") {
                $('#<%=txtPanNo.ClientID%>').css("display", "block");
                $('#btn_PanVerify').css("display", "block");
                $('#lbl_PanNote').css("display", "none");
                $('#btn_Step1').css("display", "none");
            }
            else {
                $('#<%=txtPanNo.ClientID%>').css("display", "none");
                $('#btn_PanVerify').css("display", "none");
                $('#lbl_PanNote').css("display", "block");
                $('#btn_Step1').css("display", "block");
            }
        }



        function Step(StepId) {

            var SponsorId = $('#<%=txtsponsorid.ClientID%>').val(),
                ContactPerson = $('#<%=txtContactPerson.ClientID%>').val(),
                Name = $('#<%=txtName.ClientID%>').val(),
                Mobile = $('#<%=Txt_Mobile.ClientID%>').val(),
                Email = $('#<%=txtEMailId.ClientID%>').val(),
                state = $('#<%=DdlState.ClientID%> option:selected').text(),
                District = $('#<%=ddlDistrict.ClientID%> option:selected').text(),
                City = $('#<%=txtCity.ClientID%>').val(),
                Pincode = $('#<%=txt_Pincode.ClientID%>').val(),
                Address = $('#<%=txtAddress.ClientID%>').val(),

                GSTNo = $('#<%=txtGSTNo.ClientID%>').val(),
                CinNo = $('#<%=txtCinNo.ClientID%>').val(),
                PAN = $('#<%=txtPanNo.ClientID%>').val(),

                Aadhar = $('#<%=txtAdharNo.ClientID%>').val(),

                Bank = $('#<%=ddlBankName.ClientID%> option:selected').text(),
                ACType = $('#<%=ddlAcType.ClientID%> option:selected').text(),
                ACNo = $('#<%=txtAccNo.ClientID%>').val(),
                Branch = $('#<%=txtbranch.ClientID%>').val(),
                IFSC = $('#<%=txtifs.ClientID%>').val(),

                Whats_Notify = $('#<%=chk_Notify.ClientID%>').is(':checked') == true ? 1 : 0,
                Digit1 = $('#<%=lbl_Digit1.ClientID%>').text(),
                Digit2 = $('#<%=lbl_Digit2.ClientID%>').text(),
                Digit = $('#<%=txt_Digit.ClientID%>').val(),
                Password = $('#<%=TxtPassword.ClientID%>').val(),
                PanVerify = $('#<%=hnd_PanVerify.ClientID%>').val();
          
            CPSWRD = $('#txtConfirmPSWRD').val();
            EPassword = $('#<%=txtEPSWRD.ClientID%>').val();
 ECPSWRD = $('#txtConfirmEPSWRD').val();
 FranType = $('#<%=ddltype.ClientID%>').val();
 PSWRDMatch = document.getElementById('passwordMatch');
            EPSWRDMatch = document.getElementById('EpasswordMatch');
            Fran_Type = $('#<%=ddltype.ClientID%> option:selected').text();
// txtConfirmPSWRD, txtConfirmEPSWRD
 <%--ddlBankName, ddlAcType, txtAccNo, txtbranch, txtifs
 if ($('#<%=ddlBankName.ClientID%>').val() == "") {
     Bank = "";
 }

 if ($('#<%=ddlAcType.ClientID%>').val() == "") {
     ACType = "";
 }--%>


            

            var MSG = "";

           // if (StepId == 1) {
                var radioPanValue = $('#<%=rdo_Pan.ClientID %> input[type=radio]:checked').val();
              <%--  if (radioPanValue == 1) {
                    if ($('#<%=hnd_PanVerify.ClientID%>').val() == "0") {
                        alert("Please Verify Pan Card No.");
                        return;
                    }
                }--%>
            //    $('#Step1').css("display", "none");
            //    $('#Step2').css("display", "block");
            //    $('#Step3').css("display", "none");
            //    $('#Step4').css("display", "none");

            //}
            //else if (StepId == 2) {
            if (FranType == "0") {
                MSG += "\n Please Select Franchise Type.!!";
            }

                if (SponsorId == "") {
                    MSG += "\n Please Enter Sponsor Id.!!";
                }

                if (Name == "") {
                    MSG += "\n Please Enter Franchise/ Firm Name.!!";
                }
                if (Mobile == "") {
                    MSG += "\n Please Enter Mobile No.!!";
                }

               <%-- if ($('#<%=hnd_MobileVerify.ClientID%>').val() != "1") {
                    MSG += "\n Please Enter valid Mobile No.!!";
                }--%>

                if (Email == "") {
                    MSG += "\n Please Enter Email Id.!!";
                }
                else if (!isValidEmailAddress(Email)) {
                    MSG += "\n Please Enter Valid Email Id!!";
                }
                if ($('#<%=txtPanNo.ClientID%>').val() == "") {
                    MSG += "\n Please Enter PAN No.!!";
                }
                if ($('#<%=txtAdharNo.ClientID%>').val() == "") {
                    MSG += "\n Please Enter Aadhaar No.!!";
            }
                if ($('#<%=txtGSTNo.ClientID%>').val() == "") {
                    MSG += "\n Please Enter GST No.!!";
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

                if (Address == "") {
                    MSG += "\n Please Enter Address.!!";
                }

                //if (MSG != "") {
                //    alert(MSG);
                //    return false;
                //}

                //$('#Step1').css("display", "none");
                //$('#Step2').css("display", "none");
                //$('#Step3').css("display", "block");
                //$('#Step4').css("display", "none");

                //$('html, body').animate({
                //    scrollTop: $('#Step2').offset().top
                //}, 1000);

            //}
            //else if (StepId == 3) {
          

            if ($('#<%=ddlBankName.ClientID%>').val() == "") {
                MSG += "\n Please Select Bank Name.!!";
            }
            if ($('#<%=ddlAcType.ClientID%>').val() == "") {
                MSG += "\n Please Select Account Type.!!";
            }
            if (ACNo == "") {
                MSG += "\n Please Enter Account Number.!!";
            }
            if (Branch == "") {
                MSG += "\n Please Enter Branch.!!";
            }
            if (IFSC == "") {
                MSG += "\n Please Enter IFSC Code.!!";
            }
               <%-- if ($('#<%=ddlBankName.ClientID%>').val() == "") {
                    Bank = "";
                }

                if ($('#<%=ddlAcType.ClientID%>').val() == "") {
                    ACType = "";
                }--%>

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

            if (Password == "") {
                MSG += "\n Please Enter Password.!!";
            }
            else if (Password != "") {
                if (Password.length < 5) {
                    MSG += "\n Password Length Can Be Minimum Of 5 Character.!!";
                }
                else if (CPSWRD == "" || PSWRDMatch == "Passwords do not match!") {
                    MSG += "\n Please Confirm your Password first.!!";
                }
            }
            if (EPassword == "") {
                MSG += "\n Please Enter E Password.!!";
            }
            else if (EPassword != "") {
                if (EPassword.length < 5) {
                    MSG += "\n Password Length Can Be Minimum Of 5 Character.!!";
                }
                else if (ECPSWRD == "" || EPSWRDMatch == "Passwords do not match!") {
                    MSG += "\n Please Confirm your E Password first.!!";
                }
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
                }--%>
                //if (GSTNo != "") {
                //    let Gst_Imgfile = $("#img_Gst").get(0);
                //    var files = Gst_Imgfile.files;
                //    if (files.length == 0) {
                //        MSG += "\n Please upload GST Image.!!";
                //    }
                //}

                if (MSG != "") {
                    alert(MSG);
                    return false;
                }


                var panIcon = "<i class='fa fa-times' style='color:red; font-size:larger;' aria-hidden='true'></i>";
                if (PanVerify == "1")
                    panIcon = "<i class='fa fa-check-circle' style='color:green; font-size:larger;' aria-hidden='true'></i>";

            
            if (StepId == 3) { 
                $('#lbl_PanNo').html(PAN + " " + panIcon);

                $('#lbl_sponsorid').text(SponsorId);
                $('#lbl_FranType').text(Fran_Type);
                $('#lbl_FrachiseName').text(Name);
                $('#lbl_Propertor').text(ContactPerson);
                $('#lbl_Address').text(Address);
                $('#lbl_City').text(City);
                $('#lbl_State').text(state);
                $('#lbl_District').text(District);
                $('#lbl_PinCode').text(Pincode);
                $('#lbl_Email').text(Email);
                $('#lbl_Mobile').text(Mobile);
                $('#lbl_CIN').text(CinNo);
                $('#lbl_GST').text(GSTNo);
                $('#lbl_PAN').text(PAN);
                
                $('#lbl_Adhar').text(Aadhar);
                
                $('#lbl_Bank').text(Bank);
                $('#lbl_BankType').text(ACType);
                $('#lbl_AcNo').text(ACNo);
                $('#lbl_Branch').text(Branch);
                $('#lbl_IFSC').text(IFSC);
                $('#lbl_Password').text(Password);
                $('#lbl_EPassword').text(EPassword);
                
                $('#Step1').css("display", "none");
                $('#Step2').css("display", "none");
                $('#Step3').css("display", "none");
                $('#Step5').css("display", "none");
                $('#Step4').css("display", "block");
            }

        }



        function Back(BackId) {
            if (BackId == 1) {
                $('#Step1').css("display", "block");
                $('#Step2').css("display", "none");
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
                $('#Step2').css("display", "block");
                $('#Step3').css("display", "block");
                $('#Step4').css("display", "none");
                $('#Step5').css("display", "block");
            }
        }



        $(function () {

            $("[id*=img_Pan]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=div_ImgPan.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:()])+(.jpg|.jpeg|.gif|.png|.bmp|.pdf)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:100px;width: 100%");
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
                    var regex = /^([a-zA-Z0-9\s_\\.\-:()])+(.jpg|.jpeg|.gif|.png|.bmp|.pdf)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:100px;width: 100%");
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
                    var regex = /^([a-zA-Z0-9\s_\\.\-:()])+(.jpg|.jpeg|.gif|.png|.bmp|.pdf)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:100px;width: 100%");
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
                    var regex = /^([a-zA-Z0-9\s_\\.\-:()])+(.jpg|.jpeg|.gif|.png|.bmp|.pdf)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:100px;width: 100%");
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


            $("[id*=img_Gst]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=div_ImgGst.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:()])+(.jpg|.jpeg|.gif|.png|.bmp|.pdf)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:100px;width: 100%");
                                img.attr("src", e.target.result);
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Gst').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_slip]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=div_slip.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:()])+(.jpg|.jpeg|.gif|.png|.bmp|.pdf)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:100px;width: 100%");
                                img.attr("src", e.target.result);
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_slip').val('');
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
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FPan" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Pan = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
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
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FBank" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Bank = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
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
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FAadhar_Front" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Aadhar_Front = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
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
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FAadhar_Back" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Aadhar_Back = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) { return 1; },
                    error: function (err) { return 0; }
                });
            }
        }

        async function Upload_GST() {

            var fileUpload = $("#img_Gst").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FGST" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    GST_img = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) { return 1; },
                    error: function (err) { return 0; }
                });
            }
        }

        async function Upload_slip() {

            var fileUpload = $("#img_slip").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "Slip" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Slip = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) { return 1; },
                    error: function (err) { return 0; }
                });
            }
        }



        function GetSponsorName() {
            var SponsorId = $('#<%=txtsponsorid.ClientID%>').val();
            if (SponsorId != "") {
                $.ajax({
                    type: "POST",
                    url: URL + '/GetSponsorName',
                    data: '{SponsorId: "' + SponsorId + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            $('#<%=lblFranSpon.ClientID%>').text(data.d);
                            $('#<%=lblFranSpon.ClientID%>').css("color", "blue");
                        }
                        else {
                            $('#<%=lblFranSpon.ClientID%>').val('');
                            $('#<%=lblFranSpon.ClientID%>').text(SponsorId + " Sponsor not exists.");
                            $('#<%=lblFranSpon.ClientID%>').css("color", "red");
                        }
                    },
                    error: function (response) {
                        $('#<%=lblFranSpon.ClientID%>').text("");
                    }
                });
            }
        }



        <%--function MobileVerify() {
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
                        }
                    },
                    error: function (response) {
                    }
                });
            }
            else {
                $('#lbl_Right_Worng').html("<span style='font-size:15px; color:red;'>Enter 10 digits Mobile No.!!</span>");
            }
        }--%>


        function GetDistrict() {
            $('#<%=ddlDistrict.ClientID %>').empty().append('<option selected="selected" value="">Loading...</option>');
            $.ajax({
                type: "POST",
                url: 'AddFranchise.aspx/GetDistrict',
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
                control.empty().append('<option selected="selected" value="0">Not available<option>');
            }
        }


    </script>



    <script type="text/javascript">
       <%-- $(function () {

            if ("<%=DigilockeMsg%>" == "") {
                if ("<%=DigilockerrequestId%>" != "") {

                    if (window.localStorage.getItem('hnd_PanVerify') == "1") {

                        $('#<%=hnd_PanVerify.ClientID%>').val("1");
                        $('#btn_Step1').css("display", "block");

                        $('#<%=rdo_Pan.ClientID%>').css('display', 'none');
                        $('#<%=txtPanNo.ClientID%>').css('display', 'none');
                        $('#btn_PanVerify').css('display', 'none');
                        
                        $('#<%=txtContactPerson.ClientID%>').val(window.localStorage.getItem('Name'));
                        $('#<%=txtContactPerson.ClientID%>').removeAttr('enabled');
                        $('#<%=txtContactPerson.ClientID%>').attr('disabled', 'disabled');

                        $('#div_PanVerifyMsg').html('<div class="alert alert-success">  <strong>Success! </strong>Dear ' + window.localStorage.getItem('Name') + ' Your PAN Card Verification successful <strong><i class="fa fa-check" aria-hidden="true"></i></strong> </div>');

                        $('#<%=hnd_PanDetails.ClientID%>').val(window.localStorage.getItem('OnlineMsg'));

                        $('#<%=txtPanNo.ClientID%>').val(window.localStorage.getItem('PanNo'));
                        $('#<%=rdo_Pan.ClientID%>').val(window.localStorage.getItem('PanYesNo'));

                        Step(1);
                    }
                    else {
                        $('#div_PanVerifyMsg').html('<div class="alert alert-danger"> <strong>Danger!</strong> ' + window.localStorage.getItem('OnlineMsg') + '</div>');
                    }

                    DigilockerFinaltyGetData();
                }
            } else {
                alert("<%=DigilockeMsg%>");
            }

        });--%>


        function PanVerify() {
            $('#<%=hnd_PanVerify.ClientID%>').val("0");
            $('#<%=hnd_PanDetails.ClientID%>').val("");
            //window.localStorage.setItem('hnd_PanVerify', "0");
            //window.localStorage.setItem('Name', "");

            let PanNo = $('#<%=txtPanNo.ClientID%>').val();
            if (PanNo.length != 10) {
                alert("Plese Enter Valid Pan No.!!");
                return;
            }
            else {

                $.ajax({
                    type: "POST",
                    url: 'AddFranchise.aspx/LoginCredentials',
                    data: '{Flag: "PAN", PanNo: "' + PanNo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //if (data.d[0].IsExist == "1") {
                        //    alert('P.A.N. No Already Exists.');
                        //    return false;
                        //}
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
                                    $('#btn_Step1').css("display", "block");

                                    $('#<%=rdo_Pan.ClientID%>').css('display', 'none');
                                    $('#<%=txtPanNo.ClientID%>').css('display', 'none');
                                    $('#btn_PanVerify').css('display', 'none');

                                    $('#<%=txtContactPerson.ClientID%>').val(PanResponse.result.name);
                                    $('#<%=txtContactPerson.ClientID%>').removeAttr('enabled');
                                    $('#<%=txtContactPerson.ClientID%>').attr('disabled', 'disabled');


                                    $('#div_PanVerifyMsg').html('<div class="alert alert-success">  <strong>Success! </strong>Dear ' + PanResponse.result.name + ' Your PAN Card Verification successful <strong><i class="fa fa-check" aria-hidden="true"></i></strong> </div>');


                                  <%--  window.localStorage.setItem('hnd_PanVerify', "1");
                                    window.localStorage.setItem('Name', PanResponse.result.name);

                                    window.localStorage.setItem('PanNo', $('#<%=txtPanNo.ClientID%>').val());
                                    window.localStorage.setItem('PanYesNo', $('#<%=rdo_Pan.ClientID %> input[type=radio]:checked').val());--%>

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


         <%-- function AadharVerify() {
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
                    url: 'AddFranchise.aspx/LoginCredentials',
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
                url: 'AddFranchise.aspx/LoginCredentials',
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
                                   //"redirectUrl": "http://localhost:16565/AddFranchise.aspx",
                                    //"redirectUrl": "https://toptimenet.com/AddFranchise.aspx",
                                     "redirectUrl": "https://toptime.in/AddFranchise.aspx",
                                    "redirectTime": "2",
                                    //"callbackUrl": "http://localhost:16565/AddFranchise.aspx"
                                    //"callbackUrl": "https://toptimenet.com/AddFranchise.aspx"
                                    "callbackUrl": "https://toptime.in/AddFranchise.aspx"
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

                $('#<%=txtName.ClientID%>').val(response.result.userDetails.name);
                

                $('#<%=hnd_DigilockerVerify.ClientID%>').val("1");

                $('#btn_DigilockerVerify').val('Aadhar Verified');
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
                                url: 'AddFranchise.aspx/GetStateId',
                                data: '{statename: "' + state[0] + '"}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {

                                    $('#<%=DdlState.ClientID%>').val(data.d);
                                    GetDistrict();

                                    $.ajax({
                                        type: "POST",
                                        url: 'AddFranchise.aspx/GetDistrictId',
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

                        $('#<%=txtPanNo.ClientID%>').val(Item.id.substr(Item.id.length - 10));

                    }

                });

            });


          }--%> 

        function checkPassword() {
           // TxtPassword, txtConfirmPSWRD
           
            const password = $('#<%=TxtPassword.ClientID%>').val();
            const confirmPassword = $('#txtConfirmPSWRD').val();
            const passwordMatch = document.getElementById('passwordMatch');
            
            if (password === confirmPassword) {
                passwordMatch.innerHTML = "Passwords match!";
                passwordMatch.style.color = 'green';
            } else {
                passwordMatch.innerHTML = "Passwords do not match!";
                passwordMatch.style.color = 'red';
            }
        }

        function check_Password() {
            // TxtPassword, txtConfirmPSWRD

            const password = $('#<%=txtEPSWRD.ClientID%>').val();
            const confirmPassword = $('#txtConfirmEPSWRD').val();
            const passwordMatch = document.getElementById('EpasswordMatch');

            if (password === confirmPassword) {
                passwordMatch.innerHTML = "Passwords match!";
                passwordMatch.style.color = 'green';
            } else {
                passwordMatch.innerHTML = "Passwords do not match!";
                passwordMatch.style.color = 'red';
            }
        }
        function onlyNumbers(e, t) {
            var charCode = (typeof e.which === "number") ? e.which : e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode !== 46) {
                e.preventDefault();
            }
        }

        function OnlyAlphabets(key) {
            var regex = /^[ A-Za-z0-9_@/#()]*$/
            if (regex.test(key)) { return true; }
            else { return false; }
        }

    </script>
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>


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
      .billing-cart {
              text-align: left;
    background: #ffe9e9;
    margin: 15px 0;
    padding: 10px;
    color: #161515;
    font-size: 25px;
        }
    </style>


</asp:Content>
