<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="DebitUserFranchise.aspx.cs"
    EnableEventValidation="false" Inherits="secretadmin_DebitUserFranchise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function enterNumeric(txt) {
            var sText = txt.value
            validText = sText.substring(0, sText.length - 1)
            var ValidChars = "0123456789";
            var Char;
            for (i = 0; i < sText.length; i++) {
                Char = sText.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    txt.value = validText
                }
            }
        } </script>
    <script type="text/javascript">
        function alphanumeric(alphane) {
            var numaric = alphane;
            for (var j = 0; j < numaric.length; j++) {
                var alphaa = numaric.charAt(j);
                var hh = alphaa.charCodeAt(0);
                if ((hh > 47 && hh < 58) || (hh > 64 && hh < 91) || (hh > 96 && hh < 123)) {
                }
                else {
                    alert("Your Alpha Numeric Test Failed");
                    return false;
                }
            }
            alert("Your Alpha Numeric Test Passed");
            return true;
        }
    </script>
    <style type="text/css">
        .dr {
            color: Red;
        }

        .cr {
            color: green;
        }
    </style>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Debit/Credit from Associate</h4>
    </div>



    <div id="divall" runat="server" visible="true">
        <div class="row">
            <div class="col-md-2 control-label">
                User Type : <span style="color: Red; font-weight: bold;">*</span>
            </div>
            <div class="col-md-4 control-label">
                <asp:RadioButtonList ID="rdobtn" runat="server" RepeatDirection="Horizontal" AutoPostBack="true"
                    OnSelectedIndexChanged="rdobtn_SelectedIndexChanged">
                    <asp:ListItem Selected="True" Value="0">Associate</asp:ListItem>
                   <%-- <asp:ListItem Value="1">Franchise</asp:ListItem>--%>

                </asp:RadioButtonList>
            </div>
            <div class="clearfix"></div>

            <div class="col-md-2 control-label">
                User ID :<span style="color: Red; font-weight: bold;">*</span>
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtUserid" runat="server" CssClass="form-control" AutoPostBack="false"
                    OnTextChanged="txtUserid_TextChanged"></asp:TextBox>
                <asp:TextBox ID="txtusername" runat="server" ReadOnly="true" BorderStyle="None" Style="border-style: none; background-color: Transparent; color: Black;"></asp:TextBox>
            </div>
            <div class="col-md-1">
                <asp:Button ID="btnsearch" runat="server" CssClass="btn btn-primary" Text="Search"
                    OnClick="btnsearch_Click" />
            </div>
        </div>
        <div class="clearfix">
        </div>

        <div id="divABal" runat="server" visible="false">
            <div class="col-md-2">
                Wallet Type :
            </div>
            <div class="col-md-3">
                <asp:DropDownList ID="ddlwallettype" runat="server" AutoPostBack="true" CssClass="form-control"
                    OnSelectedIndexChanged="ddlwallettype_SelectedIndexChanged">
                    <asp:ListItem Value="1">Company Wallet</asp:ListItem>
                    <%--<asp:ListItem Value="2">Payout Wallet</asp:ListItem>
                    <asp:ListItem Value="4">Loyalty Wallet</asp:ListItem>
                    <asp:ListItem Value="6">R Wallet</asp:ListItem>--%>
                </asp:DropDownList>
            </div>
            <div class="clearfix">
            </div>
            <div class="col-md-2">
                Type :
            </div>
            <div class="col-md-3">
                <asp:RadioButtonList ID="rbltype" runat="server" RepeatDirection="Horizontal" AutoPostBack="true"
                    Width="150px" OnSelectedIndexChanged="rbltype_SelectedIndexChanged">
                    <asp:ListItem class="dr" Selected="True" Value="0">Debit</asp:ListItem>
                    <asp:ListItem class="cr" Value="1">Credit</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="clearfix">
            </div>
            <div class="col-md-2">
                Available Amount :
            </div>
            <div class="col-md-3">
                <asp:Label ID="lbldrBal" runat="server"></asp:Label>
                <asp:Label ID="lblcrBal" Visible="false" runat="server"></asp:Label>
            </div>
            <div class="clearfix">
            </div>
            <div class="col-md-2">
                Amount :<span style="color: Red; font-weight: bold;">*</span>
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" MaxLength="15"
                    onkeyup="javascript:return enterNumeric(this);"></asp:TextBox>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="col-md-2">
                Remarks :
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtRemark" runat="server" Rows="3" ValidationGroup="S" MaxLength="100"
                    placeholder="Maximum 100 characters allowed with space" CssClass="form-control"
                    TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                    ControlToValidate="txtRemark" ErrorMessage="Remark Contains Alphabetic Value!"
                    ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9\s]*$" ValidationGroup="S"></asp:RegularExpressionValidator>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="col-md-2">
                E-Password :
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtepassword" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="col-md-2">
            </div>
            <div class="col-md-3">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="S" CssClass="btn btn-success"
                    OnClick="btnSubmit_Click" OnClientClick="return confirm('Are you sure you want to Debit/Credit Wallet ?');" />
            </div>
        </div>

    </div>

    <div class="form-group">
        <div id="divePassconf" runat="server" visible="false">
            <div class="col-md-2">
                <asp:Label ID="lblcrdr" runat="server" Visible="false" Text=""></asp:Label>
            </div>
            <div class="col-md-3">
                <asp:Label ID="lbldrcramt" Visible="false" runat="server" Text=""></asp:Label>
            </div>
            <div class="clearfix">
            </div>
            <div class="col-md-2">
                E-Password
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtepasswordold" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnok" runat="server" ValidationGroup="S" CssClass="btn btn-success"
                    Text="Ok" OnClick="btnok_Click" />
                <asp:Button ID="btnback" runat="server" Visible="false" ValidationGroup="S" CssClass="btn btn-success"
                    Text="<< Back" OnClick="btnback_Click" />
            </div>
            <div class="col-md-2">
            </div>
        </div>
    </div>


</asp:Content>

