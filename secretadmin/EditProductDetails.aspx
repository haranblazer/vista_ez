<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditProductDetails.aspx.cs"
    Inherits="d2000admin_EditProductDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">

        function calBVPercentage(input) {
            var letters = /^[0-9.]+$/;
            if (document.getElementById("chkBV").checked != false) {

                if (document.getElementById("txtMRP").value != "") {
                    if (document.getElementById("txtMRP").value.match(letters)) {
                        if (document.getElementById(input).value != "") {
                            if (document.getElementById(input).value.match(letters)) {
                                document.getElementById("txtCalculatedBV").value = (document.getElementById("txtMRP").value / 100) * document.getElementById(input).value;
                                document.getElementById("hdnCalculatedBV").value = (document.getElementById("txtMRP").value / 100) * document.getElementById(input).value;
                            } else {
                                alert("Please enter numeric BV value .");
                                document.getElementById("chkBV").checked = false;
                            }
                        }
                        else {
                            alert("Please enter BV value.");
                            document.getElementById("chkBV").checked = false;
                        }
                    }
                    else {
                        alert("Please enter numeric MRP .");
                        document.getElementById("chkBV").checked = false;
                    }
                }
                else {
                    alert("Please enter MRP .");
                    document.getElementById("chkBV").checked = false;
                }
            }
            else {
                document.getElementById("txtCalculatedBV").value = "";
                document.getElementById("hdnCalculatedBV").value = "";
            }
        }
    </script>
    <script type="text/javascript">
        function calculateDP() {

            var letters = /^[0-9.]+$/;
            if (document.getElementById("txtDPWithTax").value != "") {
                if (document.getElementById("txtDPWithTax").value.match(letters)) {
                    if (document.getElementById("txtDPTax").value == "") {
                        document.getElementById("txtDPTax").value = '0';
                        document.getElementById("txtDPWithTax").focus();
                    }
                    if (document.getElementById("txtDPTax").value.match(letters)) {

                        document.getElementById("txtDP").value = (parseFloat(document.getElementById("txtDPWithTax").value) * parseFloat(100)) / (parseFloat(document.getElementById("txtDPTax").value) + parseFloat(100));
                        document.getElementById("hdnCalculatedDP").value = (parseFloat(document.getElementById("txtDPWithTax").value) * parseFloat(100)) / (parseFloat(document.getElementById("txtDPTax").value) + parseFloat(100));
                    }
                    else {
                        alert("Please enter numeric DP tax.");
                    }

                }
                else {
                    alert("Please enter numeric DP with tax.");
                    document.getElementById("txtDPWithTax").focus();
                }
            }
            else {
                alert("Please enter DP with tax.");
                document.getElementById("txtDPWithTax").focus();
            }
        }</script>
    <style type="text/css">
        .style1
        {
            font-weight: bold;
            color: #FFFFFF;
        }
    </style>
</head>
<body style="font-family: Arial; font-size: 10pt;">
    <form id="form1" runat="server">
    <div>
        <table style="width: 80%">
            <tr style="text-align: center; background-color: #2881A2; border-right: #000000 1px solid;
                border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid;
                height: 25px;">
                <td colspan="2" class="style1">
                    Edit Product Details
                </td>
            </tr>
        </table>
        <table border="0" runat="server" id="tblAddProduct" cellpadding="0" cellspacing="0"
            style="width: 100%">
            <tr style="display: none;">
                <td style="text-align: left" colspan="2" class="style15">
                    Product Information
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style9">
                    <span style="color: #000000"><span style="color: #b22222; text-align: left;">*</span>Title
                        :</span>
                </td>
                <td class="style3">
                    <asp:TextBox ID="txtTitle" runat="server" Width="350px" MaxLength="50"></asp:TextBox>
                    <br />
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style9">
                    <span style="color: #000000"><span style="color: #b22222; text-align: left;">*</span>Product
                        Name :</span>
                </td>
                <td class="style3">
                    <asp:TextBox ID="txtProductName" runat="server" Width="350px" MaxLength="50"></asp:TextBox>
                    <br />
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style8">
                    Pack Size:
                </td>
                <td class="style3">
                    <asp:TextBox ID="txtPack" runat="server" ValidationGroup="p" Width="286px"></asp:TextBox>
                    <asp:DropDownList ID="ddlPackSize" runat="server" onchange="showPackUnit(this)" ValidationGroup="p">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style10">
                    <span style="color: #b22222; text-align: left;">*</span>MRP :
                </td>
                <td class="style4">
                    <asp:TextBox ID="txtMRP" runat="server" Width="350px"></asp:TextBox>
                    <br />
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style8">
                    <span style="color: #000000"><span style="color: #b22222; text-align: left;">*</span>DP
                        With Tax</span>
                </td>
                <td class="style5" style="width: 70%">
                    <asp:TextBox ID="txtDPWithTax" runat="server" Width="350px" ValidationGroup="p" onblur="calculateDP();"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style8">
                    <span style="color: #000000"><span style="color: #b22222; text-align: left;">*</span>Tax:
                </td>
                <td class="style5" style="width: 70%">
                    <asp:TextBox ID="txtDPTax" runat="server" Width="350px" ValidationGroup="p" onblur="calculateDP();"
                        CausesValidation="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style8">
                    <span style="color: #000000"><span style="color: #b22222; text-align: left;">*</span>Tax
                    for Stock:
                </td>
                <td class="style5" style="width: 70%">
                    <asp:TextBox ID="txtSTTax" runat="server" Width="350px" ValidationGroup="p" CausesValidation="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style11">
                    <span style="color: #000000"><span style="color: #b22222">*</span></span>DP :
                </td>
                <td class="style5">
                    <asp:TextBox ID="txtDP" runat="server" Width="350px" ValidationGroup="p" CausesValidation="True"></asp:TextBox>
                    <asp:TextBox ID="txtCalculatedDP" runat="server" BorderWidth="0px" ReadOnly="True"></asp:TextBox>
                    <br />
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style11">
                    <span style="color: #000000"><span style="color: #b22222">*</span></span>BV :
                </td>
                <td class="style5">
                    <asp:TextBox ID="txtBV" runat="server" Width="350px" ValidationGroup="p" CausesValidation="True"></asp:TextBox>
                    <asp:CheckBox ID="chkBV" runat="server" Text="In % Age" onclick="calBVPercentage('txtBV')" />
                    <asp:TextBox ID="txtCalculatedBV" runat="server" BorderWidth="0px" ReadOnly="True"></asp:TextBox>
                    <br />
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style8">
                    <span style="color: #000000"><span style="color: #b22222; text-align: left;">*</span>QTY:
                </td>
                <td class="style5" style="width: 70%">
                    <asp:TextBox ID="txtQTY" runat="server" Width="350px" ValidationGroup="p" MaxLength="6"
                        CausesValidation="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style8">
                    <span style="color: #000000"><span style="color: #b22222; text-align: left;">*</span>Max
                    Allowed:
                </td>
                <td class="style5" style="width: 70%">
                    <asp:TextBox ID="txt_MaxAllowed" runat="server" Width="350px" ValidationGroup="p"
                        MaxLength="4" CausesValidation="True"></asp:TextBox>
                    Zero(0) Means Unlimited.
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style13">
                    <span style="color: firebrick"><span style="color: #000000"><span style="color: #b22222;
                        text-align: left;">*<span style="color: #000000">Description</span></span><span style="color: #000000">
                            :</span></span></span>
                </td>
                <td>
                    <asp:TextBox ID="txtDescription" runat="server" Width="350px" TextMode="MultiLine"></asp:TextBox>
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="False" Font-Names="Arial"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style13">
                </td>
                <td style="text-align: left">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                        ValidationGroup="ac" Style="width: 61px" CssClass="btn" />
                    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" />
                </td>
            </tr>
        </table>
        <asp:RequiredFieldValidator ID="vdl2" runat="server" ControlToValidate="txtTitle"
            Display="None" ErrorMessage="Please Enter Title !" ForeColor="#C00000" SetFocusOnError="True"
            ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="vdl" runat="server" ControlToValidate="txtProductName"
            Display="None" ErrorMessage="Please Enter Product Name !" ForeColor="#C00000"
            SetFocusOnError="True" ValidationGroup="ac">Please Enter Product Name !</asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMRP"
            Display="None" ErrorMessage="Please Enter MRP !" ForeColor="#C00000" SetFocusOnError="True"
            ValidationGroup="ac">Please Enter MRP !</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtMRP"
            Display="None" ErrorMessage="Only Numeric Value Without Space  Is Allowed !"
            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*" ValidationGroup="ac">Only Numeric Value Without Space Is Allowed !</asp:RegularExpressionValidator>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDP"
            Display="None" ErrorMessage="Please Enter DP!" ForeColor="#C00000" Style="left: 41px;
            position: static; top: -29px" ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDP"
            Display="None" ErrorMessage="Only Numeric Value Without Space  Is Allowed In DP!"
            Font-Bold="False" ForeColor="#C00000" Style="position: static" ValidationExpression="^[0-9.]*"
            ValidationGroup="ac"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtBV"
            Display="None" ErrorMessage="Please Enter BV!" ForeColor="#C00000" ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtBV"
            Display="None" ErrorMessage="Only Numeric Value Without Space  Is Allowed In BV!"
            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*" ValidationGroup="ac"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDescription"
            Display="None" ErrorMessage="Please Enter  Description!" ForeColor="#C00000"
            SetFocusOnError="True" ValidationGroup="ac"></asp:RequiredFieldValidator>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDPWithTax"
            Display="None" ErrorMessage="Please enter value in DP with tax!" ForeColor="#C00000"
            ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtDPWithTax"
            Display="None" ErrorMessage="Only numeric value without space is allowed in DP with tax!"
            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*" ValidationGroup="ac"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtDPTax"
            Display="None" ErrorMessage="Please enter value in tax !" ForeColor="#C00000"
            ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
            ControlToValidate="txtDPTax" Display="None" ErrorMessage="Only numeric value without space is allowed in tax !"
            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*" ValidationGroup="ac"></asp:RegularExpressionValidator><asp:RegularExpressionValidator
                ID="RegularExpressionValidator20" runat="server" ControlToValidate="txtPack"
                Display="None" ErrorMessage="Only numeric value without space is allowed in pack size !"
                Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9]*" ValidationGroup="ac"></asp:RegularExpressionValidator>
        <asp:HiddenField ID="hdnCalculatedDP" runat="server" />
        <asp:HiddenField ID="hdnCalculatedBV" runat="server" />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
            ShowSummary="false" ValidationGroup="ac" />
        <br />
    </div>
    </form>
</body>
</html>
