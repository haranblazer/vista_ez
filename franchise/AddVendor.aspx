<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="AddVendor.aspx.cs" Inherits="secretadmin_AddVendor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            color: #268ddd; /* background-color: #268ddd;*/
        }

        nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link {
            color: #268ddd; /* background-color: #268ddd;*/
        }

        span.label-text.col-md-4.col-form-label {
            margin-bottom: 20px;
        }
    </style>


    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto" runat="server" id="vendhead">New Vendor </h4>
    </div>
    <div>

        <!-- Form Group Start -->
        <div class="form-group row">
            <span class="label-text col-md-2 col-form-label">Primary Contact</span>
            <div class="col-md-1">
                <asp:DropDownList ID="ddl_Title" runat="server" CssClass="form-control">
                    <asp:ListItem>Mr.</asp:ListItem>
                    <asp:ListItem>Ms.</asp:ListItem>
                    <asp:ListItem>Mrs.</asp:ListItem>
                    <asp:ListItem>M/S.</asp:ListItem>
                    <asp:ListItem>Dr.</asp:ListItem>
                    <asp:ListItem>Md.</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="Txt_FName" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="First Name"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txt_LName" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="Last Name"></asp:TextBox>
            </div>
        </div>
        <div class="form-group row">
            <span class="label-text col-md-2 col-form-label ">Company Name</span>
            <div class="col-md-3">
                <asp:TextBox ID="txt_ComName" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="Company Name"></asp:TextBox>
            </div>
        </div>
        <div class="form-group row">
            <span class="label-text col-md-2 col-form-label " style="color: Red;">Vendor Display
                        Name *</span>
            <div class="col-md-3">
                <asp:TextBox ID="txt_VenderDisplayName" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="Vendor Display Name"></asp:TextBox>
            </div>
        </div>
        <div class="form-group row">
            <span class="label-text col-md-2 col-form-label " style="color: Red;">Vendor RegisterNo
                         *</span>
            <div class="col-md-3">
                <asp:TextBox ID="txt_regno" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="Vendor RegisterNo"></asp:TextBox>
            </div>
        </div>
        <div class="form-group row">
            <span class="label-text col-md-2 col-form-label">Vendor Email</span>
            <div class="col-md-3">
                <asp:TextBox ID="txt_venderEmail" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="Vendor Email"></asp:TextBox>
            </div>
        </div>
        <div class="form-group row">
            <span class="label-text col-md-2 col-form-label">Vendor Phone</span>
            <div class="col-md-2">
                <asp:TextBox ID="txt_VendorPhone" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="Vendor Phone"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txt_VendorMobile" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="Vendor Mobile"></asp:TextBox>
            </div>
            <div class="col-md-2 col-form-label">
                <a id="hrefAddMore" href="#/" onclick="ShowAddMore()">+ Add more details</a>
            </div>
        </div>
        <div id="Div_AddMoreVen" style="display: none;">
            <div class="form-group row">
                <span class="label-text col-md-2 col-form-label">Skype Name/Number</span>
                <div class="col-md-3">
                    <div class="input-group">
                        <div class="input-group-prepend" style="position: absolute; z-index: 999; background: #eceaea; height: 34px; padding: 5px; font-size: 25px;">
                            <span class="input-group-text" style="color: #00a6ff;"><i class="fa fa-skype"></i>
                            </span>
                        </div>
                        <asp:TextBox ID="txt_SkypeName" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Skype Name/Number" Style="padding-left: 35px;"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <span class="label-text col-md-2 col-form-label">Designation</span>
                <div class="col-md-3">
                    <asp:TextBox ID="txt_Designation" runat="server" CssClass="form-control" MaxLength="50"
                        placeholder="Designation"></asp:TextBox>
                </div>
            </div>
            <div class="form-group row">
                <span class="label-text col-md-2 col-form-label">Department</span>
                <div class="col-md-3">
                    <asp:TextBox ID="txt_Department" runat="server" CssClass="form-control" MaxLength="50"
                        placeholder="Department"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="form-group row">
            <span class="label-text col-md-2 col-form-label">Web Site</span>
            <div class="col-md-3">
                <asp:TextBox ID="txt_VendorWebSite" runat="server" CssClass="form-control" MaxLength="50"
                    placeholder="Web Site"></asp:TextBox>
            </div>
        </div>
        <ul class="nav nav-tabs" id="myTab">
            <li class="active"><a href="#tab10" data-bs-toggle="tab" class="nav-link">Order Details</a>
            </li>
            <li class="nav-item"><a href="#tab11" data-bs-toggle="tab" class="nav-link">Address</a>
            </li>
            <li class="nav-item"><a href="#tab12" data-bs-toggle="tab" class="nav-link">Conatact Person</a>
            </li>
            <li class="nav-item"><a href="#tab13" data-bs-toggle="tab" class="nav-link">Custom Fields</a>
            </li>
            <li class="nav-item"><a href="#tab14" data-bs-toggle="tab" class="nav-link">Reporting Tags</a>
            </li>
            <li class="nav-item"><a href="#tab15" data-bs-toggle="tab" class="nav-link">Remarks</a>
            </li>
        </ul>
        <div class="tab-content">
            <!-- Tab Pane Start -->
            <div class="tab-pane fade active show" id="tab10">
                <br />
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label" style="color: Red;">GST Treatment*</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_GST" runat="server" CssClass="form-control" onchange="GST_Select()">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label " style="color: Red;"><span id="lbl_GSTIN_GST">GSTIN / UIN </span>* </span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_GSTIN_PAN" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label" style="color: Red;">Source Of Supply*</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_SourceOfSupply" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label" style="color: Red;">Currency*</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_Currency" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Opening Balance</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_OpeningBal" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Opening Balance"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Payment Terms</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_PaymentTerm" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">TDS</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_TDS" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Facebook</span>
                    <div class="col-md-3">
                        <div class="input-group">
                            <div class="input-group-prepend" style="position: absolute; z-index: 999; background: #eceaea; height: 34px; padding: 5px; font-size: 25px;">
                                <span class="input-group-text" style="color: #44619d;"><i class="fa fa-facebook-square"></i></span>
                            </div>
                            <asp:TextBox ID="txt_Facebook" runat="server" CssClass="form-control" MaxLength="50"
                                placeholder="Facebook" Style="padding-left: 35px;"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">twitter</span>
                    <div class="col-md-3">
                        <div class="input-group">
                            <div class="input-group-prepend" style="position: absolute; z-index: 999; background: #eceaea; height: 34px; padding: 5px; font-size: 25px;">
                                <span class="input-group-text" style="color: #00a6ff;"><i class="fa fa-twitter-square"></i></span>
                            </div>
                            <asp:TextBox ID="txt_twitter" runat="server" CssClass="form-control" MaxLength="50"
                                placeholder="twitter" Style="padding-left: 35px;"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="tab11">
                <br />

                <span class="label-text col-md-4 col-form-label">BILLING ADDRESS</span>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Attention</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_BAttention" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Attention"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Country</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_BCountry" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Address</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_BAddress1" runat="server" CssClass="form-control" MaxLength="500"
                            placeholder="Address 1" Height="50px"></asp:TextBox>
                    </div>
                    <%-- <span class="label-text col-md-4 col-form-label"></span>
                            <div class="col-md-6">
                                <asp:TextBox ID="txt_BAddress2" runat="server" CssClass="form-control" MaxLength="500"
                                    placeholder="Address 2" Height="50px"></asp:TextBox>
                            </div>
                            <div class="clearfix">
                            </div>--%>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">State</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_BState" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        <%-- <asp:TextBox ID="txt_BState" runat="server" CssClass="form-control" MaxLength="50"
                                    placeholder="State"></asp:TextBox>--%>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">City</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_BCity" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="City"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Zip Code</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_BZipCode" runat="server" CssClass="form-control" MaxLength="20"
                            placeholder="Zip Code"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Phone</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_BPhone" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Phone"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Fax</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_BFax" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Fax"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">SHIPPING ADDRESS</span>
                    <div class="col-md-3">
                        <a id="A1" href="#/" onclick="CopyBillingAdd()" class="form-control">Copy billing address <span class="fa fa-download"></span></a>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Attention</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_SAttention" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Attention"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>

                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Country</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_SCountry" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Address</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_SAddress1" runat="server" CssClass="form-control" MaxLength="500"
                            placeholder="Address 1" Height="50px"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <%--<span class="label-text col-md-4 col-form-label text-md-center"></span>
                            <div class="col-md-6">
                                <asp:TextBox ID="txt_SAddress2" runat="server" CssClass="form-control" MaxLength="500"
                                    placeholder="Address 1" Height="50px"></asp:TextBox>
                            </div>
                            <div class="clearfix">
                            </div>--%>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">State</span>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_SState" runat="server" CssClass="form-control">
                        </asp:DropDownList>

                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">City</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_SCity" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="City"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Zip Code</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_SZipCode" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Zip Code"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Phone</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_SPhone" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Phone"></asp:TextBox>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Fax</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_SFax" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Fax"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="tab12">
                <br />
                <table class="table table-condensed">
                    <thead>
                        <tr>
                            <th>Salutation
                            </th>
                            <th>First Name
                            </th>
                            <th>Last Name
                            </th>
                            <th>Email Address
                            </th>
                            <th>Work Phone
                            </th>
                            <th>Mobile
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <!-- Tab Pane End -->
            <div class="tab-pane fade" id="tab13">
                <br />
                <div class="col-md-8">
                    <br />
                    <center>
                        Start adding custom fields for your contacts by going to Settings Preferences Customers
                                and Vendors. You can add as many as Ten extra fields, as well as refine the address
                                format of your customers from there.
                    </center>
                </div>
            </div>
            <!-- Tab Pane End -->
            <div class="tab-pane fade" id="tab14">
                <div class="col-md-8">
                    <br />
                    <center>
                        You've not created any Reporting Tags.<br />
                        Start creating reporting tags by going to More Settings Reporting Tags
                    </center>
                </div>
            </div>
            <!-- Tab Pane End -->
            <div class="tab-pane fade" id="tab15">
                <br />
                <div class="form-group row">
                    <span class="label-text col-md-6 col-form-label">Remarks (For Internal Use)</span><br />
                    <div class="clearfix">
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txt_Remarks" runat="server" CssClass="form-control" MaxLength="500"
                            placeholder="Remarks" Height="50px"></asp:TextBox>
                    </div>
                </div>
            </div>
            <!-- Tab Pane End -->
        </div>

        <div class="clearfix">
        </div>
        <hr />
        <div class="col-md-12">
            <div class="col-md-6 pull-right">
                <asp:Button ID="Btn_AddVender" runat="server" Text="Save Details" CssClass="btn btn-primary"
                    OnClientClick="javascript:return Validation()" OnClick="Btn_AddVender_Click" />
                <%-- <asp:Button ID="Btn_Cancel" runat="server" Text="Cancel" CssClass="btn btn-info" />--%>

                <a href="Vendorlist.aspx" class="btn btn-link">Vendor list</a>
            </div>
            <div class="col-md-6">
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
    </div>
    <!-- Panel End -->

    <div class="clearfix">
    </div>

    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <%--<script> var $J = $.noConflict(true); </script>--%>

    <script type="text/javascript">

        $(function () {
            GST_Select();

            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                localStorage.setItem('activeTab', $(e.target).attr('href'));
            });
            var activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                $('#myTab a[href="' + activeTab + '"]').tab('show');
            }
        });


        function ShowAddMore() {
            $("#hrefAddMore").hide();
            $("#Div_AddMoreVen").show();
        };


        function CopyBillingAdd() {
            $('#<%=txt_SAttention.ClientID%>').val($('#<%=txt_BAttention.ClientID%>').val());
                $('#<%=ddl_SCountry.ClientID%>').val($('#<%=ddl_BCountry.ClientID%>').val());
                $('#<%=txt_SAddress1.ClientID%>').val($('#<%=txt_BAddress1.ClientID%>').val());
                $('#<%=ddl_SState.ClientID%>').val($('#<%=ddl_BState.ClientID%>').val());
                $('#<%=txt_SCity.ClientID%>').val($('#<%=txt_BCity.ClientID%>').val());
                $('#<%=txt_SZipCode.ClientID%>').val($('#<%=txt_BZipCode.ClientID%>').val());
                $('#<%=txt_SPhone.ClientID%>').val($('#<%=txt_BPhone.ClientID%>').val());
                $('#<%=txt_SFax.ClientID%>').val($('#<%=txt_BFax.ClientID%>').val());
        };


        function GST_Select() {
            if ($('#<%=ddl_GST.ClientID%>').val() == "3") {
                $('#lbl_GSTIN_GST').text('PAN');
            }
            else {
                $('#lbl_GSTIN_GST').text('GSTIN / UIN');
            }
        }


        function Validation() {
            var MSG = "";
            if ($('#<%=txt_VenderDisplayName.ClientID%>').val() == "") {
                    MSG += "\n Please Enter Vender Display Name.!";
                    $('#<%=txt_VenderDisplayName.ClientID%>').focus();
                }
                <%--if ($('#<%=txt_regno.ClientID%>').val() == "") {
                    MSG += "\n Please Enter Vendor Registration no.!";
                    $('#<%=txt_regno.ClientID%>').focus();
                }--%>
                if ($('#<%=ddl_GST.ClientID%>').val() == "0") {
                    MSG += "\n Please Select GST Treatment.!";
                    $('#<%=ddl_GST.ClientID%>').focus();
                }
                if ($('#<%=txt_GSTIN_PAN.ClientID%>').val() == "") {
                    MSG += "\n Please Enter GSTIN/ PAN.!";
                    $('#<%=txt_GSTIN_PAN.ClientID%>').focus();
                }
                if ($('#<%=ddl_SourceOfSupply.ClientID%>').val() == "0") {
                    MSG += "\n Please Select Source Of Supply.!";
                    $('#<%=ddl_SourceOfSupply.ClientID%>').focus();
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (confirm('Are You Sure to Save Vendor Details?')) {
                return true;
            } else {
                return false;
            }

        }
    </script>
    <style>
        .input-group {
            position: relative;
            display: table;
            border-collapse: separate;
            width: 100%;
        }
    </style>
</asp:Content>
