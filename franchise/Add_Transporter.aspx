<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Add_Transporter.aspx.cs" Inherits="franchise_Add_Transportor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="Javascript" type="text/javascript">

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }


        function Validation() {

            var TransporterName = $('#<%=txt_TransporterName.ClientID%>').val(),
                Address = $('#<%=txt_Address.ClientID%>').val(),
                MobileNo = $('#<%=txt_MobileNo.ClientID%>').val(),
                Emailid = $('#<%=txt_Emailid.ClientID%>').val(),
                GSTNO = $('#<%=txt_GSTNO.ClientID%>').val();

            var MSG = "";
            if (TransporterName == "") {
                MSG += "\n Please Enter Transporter Name.!";
            }
            if (Address == "") {
                MSG += "\n Please Enter Address.!";
            }
            if (MobileNo == "") {
                MSG += "\n Please Enter Mobile No.!";
            }
            if (Emailid == "") {
                MSG += "\n Please Enter Emailid.!";
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

       <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add Transporter </h4>					
				</div>

 

            <asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="updatepnl" runat="server">
                <ContentTemplate>
                  

                       <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">Transporter Name </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_TransporterName" runat="server" CssClass="form-control" MaxLength="100"
                                    placeholder="Enter Transporter Name"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">Contact Person </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_ContactPerson" runat="server" CssClass="form-control" MaxLength="100"
                                    placeholder="Enter Contact Person"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>


                        <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">MobileNo </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_MobileNo" runat="server" CssClass="form-control" MaxLength="10"
                                    placeholder="Enter Mobile No." onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">Emailid </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_Emailid" runat="server" CssClass="form-control" placeholder="Enter Email Id"
                                    MaxLength="50"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>




                       <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">State </div>
                            <div class="col-md-4 col-sm-4">
                                 <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control" Enabled="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                        </asp:DropDownList>
                            </div>
                            <div class="col-sm-2 control-label">District</div>
                            <div class="col-md-4 col-sm-4">
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
                        </div>
                        <div class="clearfix"></div>

                       <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">Pincode</div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_Pincode" runat="server" CssClass="form-control" placeholder="Enter Pincode"
                                    MaxLength="6" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">Address</div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_Address" runat="server" CssClass="form-control" placeholder="Enter Address"
                                    MaxLength="100"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>


                        <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">Freight </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_Freight" runat="server" CssClass="form-control" MaxLength="10"
                                    placeholder="Enter Freight" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">Fuel Charges</div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_FuelCharges" runat="server" CssClass="form-control" placeholder="Enter Fuel Charges"
                                    MaxLength="10" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                        <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">FOV Charges </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_FOVChages" runat="server" CssClass="form-control" MaxLength="10"
                                    placeholder="Enter FOV Chages" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">Docket Charges</div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_DocketCharges" runat="server" CssClass="form-control" placeholder="Enter Docket Charges"
                                    MaxLength="10" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>


                      <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">Handling Charges </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_HandlingCharges" runat="server" CssClass="form-control" MaxLength="10"
                                    placeholder="Enter Handling Charges" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">ODA</div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_ODA" runat="server" CssClass="form-control" placeholder="Enter ODA"
                                    MaxLength="10" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                      <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">Other Charges </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_OtherChages" runat="server" CssClass="form-control" MaxLength="10"
                                    placeholder="Enter Other Chages" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">Name</div>
                            <div class="col-md-4 col-sm-4">
                                <asp:DropDownList ID="ddl_Isactive" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="1">Active</asp:ListItem>
                                    <asp:ListItem Value="0">Deactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="clearfix"></div>



                      <div class="form-group card-group-row row">
                            <div class="col-sm-2 control-label">GST</div>
                            <div class="col-md-4 col-sm-4">
                                <asp:TextBox ID="txt_GSTNO" runat="server" CssClass="form-control" MaxLength="20"
                                    placeholder="Enter GST"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">RoleMode </div>
                            <div class="col-md-4 col-sm-4">
                                <asp:CheckBoxList ID="chk_mode" runat="server" RepeatDirection="Horizontal">
                                </asp:CheckBoxList>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>

                     <div class="form-group card-group-row row">
                            <div class="col-sm-2">
                            </div>
                            <div class="col-sm-2 control-label">
                                <a href="TransporterList.aspx" class="btn btn-link">Transporter List</a>
                            </div>
                            <div class="col-sm-2 text-right">
                                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-primary"
                                    OnClientClick="javascript:return Validation();" />
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>

                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        

        <div class="clearfix"></div>
  



</asp:Content>

