<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ReturnDispatch.aspx.cs" Inherits="franchise_ReturnDispatch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
          
            $('#<%=txt_DispatchDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txt_Deliverydate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txt_TallyDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

        });

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }


        function CalculateDP() {
            //***************** Calculation Total Expenses 
            var Freight = $('#<%=txt_Freight.ClientID%>').val(),
                FuelCharges = $('#<%=txt_FuelCharges.ClientID%>').val(),
                FOVChages = $('#<%=txt_FOVChages.ClientID%>').val(),
                DocketCharges = $('#<%=txt_DocketCharges.ClientID%>').val(),
                HandlingCharges = $('#<%=txt_HandlingCharges.ClientID%>').val(),
                ODA = $('#<%=txt_ODA.ClientID%>').val(),
                OtherChages = $('#<%=txt_OtherChages.ClientID%>').val(),
                TotalExpenses = 0;

            Freight = parseFloat((Freight == '' || Freight == null || isNaN(parseFloat(Freight))) ? 0 : Freight);
            FuelCharges = parseFloat((FuelCharges == '' || FuelCharges == null || isNaN(parseFloat(FuelCharges))) ? 0 : FuelCharges);
            FOVChages = parseFloat((FOVChages == '' || FOVChages == null || isNaN(parseFloat(FOVChages))) ? 0 : FOVChages);
            DocketCharges = parseFloat((DocketCharges == '' || DocketCharges == null || isNaN(parseFloat(DocketCharges))) ? 0 : DocketCharges);
            HandlingCharges = parseFloat((HandlingCharges == '' || HandlingCharges == null || isNaN(parseFloat(HandlingCharges))) ? 0 : HandlingCharges);
            ODA = parseFloat((ODA == '' || ODA == null || isNaN(parseFloat(ODA))) ? 0 : ODA);
            OtherChages = parseFloat((OtherChages == '' || OtherChages == null || isNaN(parseFloat(OtherChages))) ? 0 : OtherChages);
            TotalExpenses = (Freight + FuelCharges + FOVChages + DocketCharges + HandlingCharges + ODA + OtherChages);
            $('#<%=txt_TotalExpenses.ClientID%>').val(TotalExpenses);

        }



        function Validation() {

            var DispatchStatus = $('#<%=ddl_DispatchStatus.ClientID%>').val(),
                Transporter = $('#<%=ddl_Transporter.ClientID%>').val(),
                Mode = $('#<%=ddl_Mode.ClientID%>').val(),
                DocketNo = $('#<%=txt_DocketNo.ClientID%>').val(),
                Freight = $('#<%=txt_Freight.ClientID%>').val(),
                Weight = $('#<%=txt_Weight.ClientID%>').val(),
                TotalExpenses = $('#<%=txt_TotalExpenses.ClientID%>').val();

            var MSG = "";
            if (DispatchStatus == "0") {
                MSG += "\n Please Select Dispatch Status.!";
            }

            if (Transporter == "0") {
                MSG += "\n Please Select Transporter Name.!";
            }

            if (Mode == "0") {
                MSG += "\n Please Select Transporter Mode.!";
            }

            if (DocketNo == "") {
                MSG += "\n Please Enter Docket No.!";
            }
            if (Freight == "" || Freight == "0") {
                MSG += "\n Please Enter Freight.!";
            }
            if (Weight == "" || Weight == "0") {
                MSG += "\n Please Enter Weight.";
            }

            if (TotalExpenses == "0" || TotalExpenses == "") {
                MSG += "\n Please Enter Expenses.!";
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to save details.？')) {
                return false;
            }
        }
         
         
        $(function () { 
            $("[id*=fuUpload]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=dvPreview.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:112px;width: 105px");
                                img.attr("src", e.target.result);
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#<%=fuUpload.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });
        });


    </script>

    <asp:HiddenField ID="hnd_img" runat="server" Value="" />
    <h2 class="head">
        <i class="fa fa-file-text-o"></i>&nbsp;Return Item Dispatch System
       
    </h2>
    <div class="panel">
        <asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="updatepnl" runat="server">
            <ContentTemplate>
                <div class="form-group">
                     
                    <label class="col-md-2">Month</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_Month" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div> 
                    <label class="col-md-2">Depo</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_Depo" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>

                    

                    <label class="col-md-2">PO Date</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_PODate" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">PO Number</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_PONo" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div> 
                    <div class="clearfix"></div>


                    <label class="col-md-2">Cust. ID</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_CustId" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Name of Party</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_CustName" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div> 
                    <div class="clearfix"></div>
                    

                    <label class="col-md-2">Location</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_Location" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div> 
                    <label class="col-md-2">State</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_State" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>
                      <hr />


                     <label class="col-md-2">Web Invoice No</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_InvoiceNo" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Amount</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_InvoiceAmount" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>


                     <label class="col-md-2">Date</label>
                    <div class="col-md-3">
                        <label>
                            <asp:Label ID="lbl_Date" runat="server"></asp:Label>
                        </label>
                    </div>
                    <div class="col-md-1"></div>
                     <div class="clearfix"></div>

                  
                    <hr />


                    <label class="col-md-2">Dispatch Status</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_DispatchStatus" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Dispatch Date</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_DispatchDate" runat="server" CssClass="form-control" placeholder="Select Date" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>


                    <label class="col-md-2">Delivery date</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_Deliverydate" runat="server" CssClass="form-control" placeholder="Select Delivery date" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Duration days</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_Durationdays" runat="server" CssClass="form-control" MaxLength="10"
                            onkeypress="return onlyNumbers(event,this);">0</asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>

                    <div class="clearfix"></div>


                    <label class="col-md-2">Transporter Name</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_Transporter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_Transporter_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Transport Mode</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddl_Mode" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>



                    <label class="col-md-2">Confirm With</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_ApprovedBy" runat="server" CssClass="form-control" placeholder="Enter Confirm With" MaxLength="50"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">E-way Bill No.</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_EwayNo" runat="server" CssClass="form-control" placeholder="Enter E-way Bill No." MaxLength="50"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>


                    <label class="col-md-2">Docket No</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_DocketNo" runat="server" CssClass="form-control" placeholder="Enter Docket No" MaxLength="30"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Remarks</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_Remarks" runat="server" CssClass="form-control" placeholder="Enter Remarks" MaxLength="500"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>


                    <label class="col-md-2">No. Boxes</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_Boxes" runat="server" CssClass="form-control" placeholder="Enter No. Boxes"
                            MaxLength="50" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Weight KG</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_Weight" runat="server" CssClass="form-control" placeholder="Enter Weight KG"
                            MaxLength="50" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>
                    <hr />

                    <label class="col-md-2">Freight</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_Freight" runat="server" CssClass="form-control" placeholder="Enter Freight"
                            MaxLength="50" onchange="CalculateDP();" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Fuel Charges</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_FuelCharges" runat="server" CssClass="form-control" placeholder="Enter Fuel Charges"
                            MaxLength="50" onchange="CalculateDP();" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>


                    <label class="col-md-2">FOV Chages</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_FOVChages" runat="server" CssClass="form-control" placeholder="Enter FOV Chages"
                            MaxLength="50" onchange="CalculateDP();" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Docket Charges</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_DocketCharges" runat="server" CssClass="form-control" placeholder="Enter Docket Charges"
                            MaxLength="50" onchange="CalculateDP();" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>

                    <label class="col-md-2">Handling Charges</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_HandlingCharges" runat="server" CssClass="form-control" placeholder="Enter Handling Charges"
                            MaxLength="50" onchange="CalculateDP();" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">ODA</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_ODA" runat="server" CssClass="form-control" placeholder="Enter ODA"
                            MaxLength="50" onchange="CalculateDP();" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>


                    <label class="col-md-2">Other Chages </label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_OtherChages" runat="server" CssClass="form-control" placeholder="Enter Other Chages"
                            MaxLength="50" onchange="CalculateDP();" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Total Expenses</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_TotalExpenses" runat="server" CssClass="form-control" placeholder="Total Expenses."
                            ReadOnly="true" MaxLength="50"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>


                      <hr />


                    <label class="col-md-2">TallyDate</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_TallyDate" runat="server" CssClass="form-control" placeholder="Select Tally Date" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <label class="col-md-2">Tally Invoice No</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_TallyInvoice" runat="server" CssClass="form-control" placeholder="Enter Tally Invoice NO." MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>


                    <label class="col-md-2">Tally Amount</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_TallyAmount" runat="server" CssClass="form-control" placeholder="Enter Tally Amount"
                            MaxLength="20" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="clearfix"></div>

                    <label class="col-md-2">Slip</label>
                    <div class="col-md-3">
                        <asp:FileUpload ID="fuUpload" runat="server" multiple="multiple" />
                        <div id="dvPreview" runat="server"></div> 
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-3"> <asp:Label ID="lbl_msg" runat="server"></asp:Label> </div>
                    <div class="col-md-3">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success"
                            OnClick="btnSubmit_Click" OnClientClick="javascript:return Validation();" />
                    </div>
                    <div class="clearfix"></div>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div class="clearfix">
    </div>



</asp:Content>
