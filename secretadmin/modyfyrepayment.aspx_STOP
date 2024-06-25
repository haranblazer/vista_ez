<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="modyfyrepayment.aspx.cs" Inherits="secretadmin_modyfyrepayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 <script type="text/javascript">
     var specialKeys = new Array();
     specialKeys.push(8);
     function IsNumeric(e) {
         var keyCode = e.which ? e.which : e.keyCode
         var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
         return ret;
     }
    </script>
    <div id="title" class="b2">
        <h2>
            Modify Payment</h2>
    </div>
    <br />
    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                Display
            </td>
            <td>
                <asp:DropDownList ID="ddlDisplay" runat="server" CssClass="form-control" Width="170px">
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                User ID
            </td>
            <td>
                <asp:TextBox ID="txtUserId" runat="server" MaxLength="1" Enabled="False" CssClass="form-control"
                    Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserId" runat="server" ControlToValidate="txtUserId"
                    Display="Dynamic" ErrorMessage="User Id is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                User Name
            </td>
            <td>
                <asp:TextBox ID="txtUserName" runat="server" Enabled="False" CssClass="form-control"
                    Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName"
                    Display="Dynamic" ErrorMessage="Username is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
               PI
            </td>
            <td>
                <asp:TextBox ID="txtpi" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDI" runat="server" ControlToValidate="txtpi"
                    Display="Dynamic" ErrorMessage="Direct Income is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revDI" runat="server" ControlToValidate="txtpi"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
              Tour Fund
            </td>
            <td>
                <asp:TextBox ID="txttf" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMI" runat="server" ControlToValidate="txttf"
                    Display="Dynamic" ErrorMessage="Matching Income is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revMI" runat="server" ControlToValidate="txttf"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                car fund
            </td>
            <td>
                <asp:TextBox ID="txtcf" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPI" runat="server" ControlToValidate="txtcf"
                    Display="Dynamic" ErrorMessage="Pool Income is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPI" runat="server" ControlToValidate="txtcf"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>


         <tr class="form-group">
            <td class="col-sm-2 control-label">
                Beffy fund
            </td>
            <td>
                <asp:TextBox ID="txtbf" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtbf"
                    Display="Dynamic" ErrorMessage="Pool Income is required ." ValidationGroup="pp"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtbf"
                    Display="None" ErrorMessage="Please Enter Numeric or Decimal Value. " SetFocusOnError="True"
                    ValidationExpression="^(?:\d{1,})?(?:\.\d{1,5})?$" ValidationGroup="pp"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <%--  <tr class="form-group">
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
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                Select TDS Type
            </td>
            <td>
                <asp:DropDownList ID="ddltdstype" runat="server" CssClass="form-control" Width="170px"
                    OnSelectedIndexChanged="ddltdstype_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Value="Select">Select</asp:ListItem>
                    <asp:ListItem Value="1">5</asp:ListItem>
                    <asp:ListItem Value="0">20</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddltdstype"
                    InitialValue="Select" Display="Dynamic" ErrorMessage="Tax Type is required."
                    ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                TDS
            </td>
            <td>
                <asp:TextBox ID="txtTDS" runat="server" Enabled="False" CssClass="form-control" Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTDS" runat="server" ControlToValidate="txtTDS"
                    Display="Dynamic" ErrorMessage="TDS is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                Total Earning
            </td>
            <td>
                <asp:TextBox ID="txtTotalEarning" runat="server" Enabled="False" CssClass="form-control"
                    Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTotalEarning" runat="server" ControlToValidate="txtTotalEarning"
                    Display="None" ErrorMessage="Tatal Earning is required." ValidationGroup="pp"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                Dispatched
            </td>
            <td>
                <asp:TextBox ID="txtDispatch" runat="server" Enabled="False" CssClass="form-control"
                    Width="170px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDispatch" runat="server" Display="None" ErrorMessage="Dispatch is required."
                    ValidationGroup="pp" ControlToValidate="txtDispatch"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                Other Charges
            </td>
            <td>
                <asp:TextBox ID="txtothercharges" runat="server" CssClass="form-control" Width="170px"
                    onkeypress="return IsNumeric(event);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="None"
                    ErrorMessage="Dispatch is required." ValidationGroup="pp" ControlToValidate="txtothercharges"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr class="form-group">
            <td class="col-sm-2 control-label">
                Remark
            </td>
            <td>
                <asp:TextBox ID="txtremark" runat="server" CssClass="form-control" Width="170px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="None"
                    ErrorMessage="Dispatch is required." ValidationGroup="pp" ControlToValidate="txtremark"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td colspan="2">
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group" style="display: none">
            <td colspan="2">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" ValidationGroup="pp"
                    CssClass="btn btn-success" Enabled="false" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="form-group">
            <td colspan="2">
                <a href="javascript:window.close()"><span><strong>Close windows</strong></span></a>
            </td>
        </tr>
    </table>


</asp:Content>

