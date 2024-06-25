<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="modyfypayment.aspx.cs" Inherits="admin_modyfypayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        var specialKeys = new Array();
        specialKeys.push(8);
        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
            return ret;
        }

        function Calculation() {
            var DirectInc = $('#<%=txtdirectincome.ClientID%>').val() == "" ? "0" : $('#<%=txtdirectincome.ClientID%>').val();




            var B1 = $('#<%=txtMatchingIncome.ClientID%>').val() == "" ? "0" : $('#<%=txtMatchingIncome.ClientID%>').val();
            var B2 = $('#<%=txtSClub.ClientID%>').val() == "" ? "0" : $('#<%=txtSClub.ClientID%>').val();
            var B3 = $('#<%=txtroyalstar.ClientID%>').val() == "" ? "0" : $('#<%=txtroyalstar.ClientID%>').val();
            var B4 = $('#<%=txtPClub.ClientID%>').val() == "" ? "0" : $('#<%=txtPClub.ClientID%>').val();
            var B5 = $('#<%=txtRClub.ClientID%>').val() == "" ? "0" : $('#<%=txtRClub.ClientID%>').val();
            var Royalty = $('#<%=txt_royalty.ClientID%>').val() == "" ? "0" : $('#<%=txt_royalty.ClientID%>').val();

            var TF = $('#<%=txtLB3.ClientID%>').val() == "" ? "0" : $('#<%=txtLB3.ClientID%>').val();
            var CF = $('#<%=txtLB1.ClientID%>').val() == "" ? "0" : $('#<%=txtLB1.ClientID%>').val();
            var HF = $('#<%=txtLB2.ClientID%>').val() == "" ? "0" : $('#<%=txtLB2.ClientID%>').val();

            var TDS_PER = $('#<%=ddltdstype.ClientID%>').val() == "" ? "0" : $('#<%=ddltdstype.ClientID%>').val();


            var TotalEarning = (parseFloat(B1) + parseFloat(B2) + parseFloat(B3) + parseFloat(B4) + parseFloat(B5) + parseFloat(Royalty) +
            parseFloat(TF) + parseFloat(CF) + parseFloat(HF));

            var TDSAMT = (parseInt(TotalEarning) * parseInt(TDS_PER) / 100);
            var AdminCharage = (parseInt(TotalEarning) * 5 / 100);

            $('#<%=txtTotalEarning.ClientID%>').val(TotalEarning.toFixed(0));
            $('#<%=txtTDS.ClientID%>').val(TDSAMT.toFixed(0));
            $('#<%=txtHandlingChrgs.ClientID%>').val(AdminCharage.toFixed(0));

            $('#<%=txtDispatch.ClientID%>').val(((parseFloat(TotalEarning) + parseFloat(ReleaseAmt)) - (parseFloat(TDSAMT) + parseFloat(AdminCharage))).toFixed(0));
           
            
        }
    </script>

    <div style="padding: 15px 0px 0px 15px;">
        <h2 class="head">
            <i class="fa fa-edit" aria-hidden="true"></i>&nbsp;Modify Payment</h2>
    </div>

    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
        <tr class="form-group">
            <td class="col-sm-2 control-label">Display
            </td>
            <td>
                <asp:DropDownList ID="ddlDisplay" runat="server" CssClass="form-control" Width="170px">
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">User ID
            </td>
            <td>
                <asp:TextBox ID="txtUserId" runat="server" MaxLength="1" Enabled="False" CssClass="form-control"
                    Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserId" runat="server" ControlToValidate="txtUserId"
                    Display="Dynamic" ErrorMessage="User Id is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">User Name
            </td>
            <td>
                <asp:TextBox ID="txtUserName" runat="server" Enabled="False" CssClass="form-control"
                    Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName"
                    Display="Dynamic" ErrorMessage="Username is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr class="form-group" style="display: none;">
            <td class="col-sm-2 control-label">Refferal Income
            </td>
            <td>
                <asp:TextBox ID="txtdirectincome" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDI" runat="server" ControlToValidate="txtdirectincome"
                    Display="Dynamic" ErrorMessage="Direct Income is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revDI" runat="server" ControlToValidate="txtdirectincome"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Binary 1
            </td>
            <td>
                <asp:TextBox ID="txtMatchingIncome" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMI" runat="server" ControlToValidate="txtMatchingIncome"
                    Display="Dynamic" ErrorMessage="Matching Income is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revMI" runat="server" ControlToValidate="txtMatchingIncome"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp; 
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Binary 2
            </td>
            <td>
                <asp:TextBox ID="txtSClub" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()" onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSClub" runat="server" ControlToValidate="txtSClub"
                    Display="Dynamic" ErrorMessage="Silver Club is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revSClub" runat="server" ControlToValidate="txtSClub"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>

        <tr class="form-group">
            <td class="col-sm-2 control-label">Binary 3
            </td>
            <td>
                <asp:TextBox ID="txtroyalstar" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtroyalstar"
                    Display="Dynamic" ErrorMessage=" Royal Star Income is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtroyalstar"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>

        <tr class="form-group">
            <td class="col-sm-2 control-label">Binary 4
            </td>
            <td>
                <asp:TextBox ID="txtPClub" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()" onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPClub" runat="server" ControlToValidate="txtPClub"
                    Display="Dynamic" ErrorMessage="Platinum Club is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPClub" runat="server" ControlToValidate="txtPClub"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Binary 5
            </td>
            <td>
                <asp:TextBox ID="txtRClub" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()" onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRClub" runat="server" ControlToValidate="txtRClub"
                    Display="Dynamic" ErrorMessage="Royal Club is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revRClub" runat="server" ControlToValidate="txtRClub"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>

        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Royalty 
            </td>
            <td>
                <asp:TextBox ID="txt_royalty" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPI" runat="server" ControlToValidate="txt_royalty"
                    Display="Dynamic" ErrorMessage="Pool Income is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPI" runat="server" ControlToValidate="txt_royalty"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>


        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">TF
            </td>
            <td>
                <asp:TextBox ID="txtLB3" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()" onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvtxtLB3" runat="server" ControlToValidate="txtLB3"
                    Display="Dynamic" ErrorMessage="LB3 is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revtxtLB3" runat="server" ControlToValidate="txtLB3"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>

        <tr>
            <td>&nbsp; 
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">CF
            </td>
            <td>
                <asp:TextBox ID="txtLB1" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()" onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLB1" runat="server" ControlToValidate="txtLB1"
                    Display="Dynamic" ErrorMessage="LB1 is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revLB1" runat="server" ControlToValidate="txtLB1"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">HF
            </td>
            <td>
                <asp:TextBox ID="txtLB2" runat="server" CssClass="form-control" Width="170px" onchange="return Calculation()" onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLB2" runat="server" ControlToValidate="txtLB2"
                    Display="Dynamic" ErrorMessage="LB2 is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revLB2" runat="server" ControlToValidate="txtLB2"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>


        <%--  


         <tr class="form-group">
            <td class="col-sm-2 control-label">
                Star Royalty
            </td>
            <td>
                <asp:TextBox ID="txtstarroyalty" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtstarroyalty"
                    Display="Dynamic" ErrorMessage="Star Royalty Income is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtstarroyalty"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>

        
         <tr class="form-group">
            <td class="col-sm-2 control-label">
               Super Star
            </td>
            <td>
                <asp:TextBox ID="txtsuperstar" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtsuperstar"
                    Display="Dynamic" ErrorMessage="Super Star Income is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtsuperstar"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>

          <tr class="form-group">
            <td class="col-sm-2 control-label">
               Diamond Star
            </td>
            <td>
                <asp:TextBox ID="txtdiamondstar" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtdiamondstar"
                    Display="Dynamic" ErrorMessage="Diamond Star Income is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtdiamondstar"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>

        <tr class="form-group">
            <td class="col-sm-2 control-label">
              Level 2
            </td>
            <td>
                <asp:TextBox ID="txtlevel2" runat="server" CssClass="form-control" Width="170px" onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTF" runat="server" ControlToValidate="txtlevel2" Display="Dynamic"
                    ErrorMessage="Level 2 is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revTF" runat="server" ControlToValidate="txtlevel2"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                Level 3 
            </td>
            <td>
                <asp:TextBox ID="txtlevel3" runat="server" CssClass="form-control" Width="170px" onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLB" runat="server" ControlToValidate="txtlevel3" Display="Dynamic"
                    ErrorMessage="Level 3 is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revLB" runat="server" ControlToValidate="txtlevel3"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>--%>
        <%-- <tr><td>&nbsp;</td></tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
             Salary
            </td>
            <td>
                <asp:TextBox ID="txtsalary" runat="server" CssClass="form-control" Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPI" runat="server" ControlToValidate="txtPI" Display="Dynamic"
                    ErrorMessage="PI is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPI" runat="server" ControlToValidate="txtPI"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>--%>
        <%-- <tr><td>&nbsp;</td></tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
              ZM
            </td>
            <td>
                <asp:TextBox ID="txtZM" runat="server" CssClass="form-control" Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvZM" runat="server" ControlToValidate="txtZM" Display="Dynamic"
                    ErrorMessage="ZM is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revZM" runat="server" ControlToValidate="txtZM"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                GM
            </td>
            <td>
                <asp:TextBox ID="txtGM" runat="server" CssClass="form-control" Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvGM" runat="server" ControlToValidate="txtGM" Display="Dynamic"
                    ErrorMessage="GM is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revGM" runat="server" ControlToValidate="txtGM"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                CM
            </td>
            <td>
                <asp:TextBox ID="txtCM" runat="server" CssClass="form-control" Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCM" runat="server" ControlToValidate="txtCM" Display="Dynamic"
                    ErrorMessage="CM is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revCM" runat="server" ControlToValidate="txtCM"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                TI
            </td>
            <td>
                <asp:TextBox ID="txtTI" runat="server" CssClass="form-control" Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTI" runat="server" ControlToValidate="txtTI" Display="Dynamic"
                    ErrorMessage="TI is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revTI" runat="server" ControlToValidate="txtTI"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>--%>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Select TDS Type
            </td>
            <td>
                <asp:DropDownList ID="ddltdstype" runat="server" CssClass="form-control" Width="170px"
                    onchange="return Calculation()">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    <asp:ListItem Value="5">5</asp:ListItem>
                    <asp:ListItem Value="20">20</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddltdstype"
                    InitialValue="0" Display="Dynamic" ErrorMessage="Tax Type is required."
                    ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">TDS
            </td>
            <td>
                <asp:TextBox ID="txtTDS" runat="server" Enabled="False" CssClass="form-control" Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTDS" runat="server" ControlToValidate="txtTDS"
                    Display="Dynamic" ErrorMessage="TDS is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Admin Charges
            </td>
            <td>
                <asp:TextBox ID="txtHandlingChrgs" runat="server" CssClass="form-control" Width="170px"
                    Enabled="false" onkeypress="return IsNumeric(event);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvHandlingChrgs" runat="server" Display="None" ErrorMessage="Admin Charges is required."
                    ValidationGroup="pp" ControlToValidate="txtHandlingChrgs"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Total Earning
            </td>
            <td>
                <asp:TextBox ID="txtTotalEarning" runat="server" Enabled="False" CssClass="form-control"
                    Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTotalEarning" runat="server" ControlToValidate="txtTotalEarning"
                    Display="None" ErrorMessage="Total Earning is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Dispatched
            </td>
            <td>
                <asp:TextBox ID="txtDispatch" runat="server" Enabled="False" CssClass="form-control"
                    Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDispatch" runat="server" Display="None" ErrorMessage="Dispatch is required."
                    ValidationGroup="pp" ControlToValidate="txtDispatch"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Other Charges
            </td>
            <td>
                <asp:TextBox ID="txtothercharges" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="None"
                    ErrorMessage="Dispatch is required." ValidationGroup="pp" ControlToValidate="txtothercharges"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">Remark
            </td>
            <td>
                <asp:TextBox ID="txtremark" runat="server" CssClass="form-control" Width="170px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="None"
                    ErrorMessage="Dispatch is required." ValidationGroup="pp" ControlToValidate="txtremark"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td colspan="2">
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label"></td>
            <td>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" ValidationGroup="pp"
                    CssClass="btn btn-success" />
                <a href="#" class="btn btn-success" onclick="window.history.back();"><span><strong>Back</strong></span></a>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
