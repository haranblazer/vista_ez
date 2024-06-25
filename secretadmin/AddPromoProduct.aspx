<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AddPromoProduct.aspx.cs" Inherits="secretadmin_AddPromoProduct"

 EnableEventValidation="false"
    ValidateRequest="false" %>

    <%@ Register Assembly="RichTextEditor" Namespace="AjaxControls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">

     function doRteAction() {

         //H1 is the ASP HiddenField Control
         var elemo = document.getElementById("<%=H1.ClientID%>");
         elemo.value = richeditor.toHtmlString();

     }

    </script>
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

        <div style="padding-top:15px;">
    <h2 class="head">
        Add Promo Product</h2>
   </div>
   <div class="clearfix"> </div> <br />

    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Category</label>
        <div class="col-sm-3 col-xs-9">
            <asp:DropDownList ID="ddlCategory" runat="server" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"
                AutoPostBack="true" ValidationGroup="p" CssClass="form-control">
            </asp:DropDownList>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
   
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            *Title</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" MaxLength="50"
                ValidationGroup="p"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            *Product Name</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtProductName" runat="server" ValidationGroup="p" CausesValidation="True"
                MaxLength="50" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Pack Size</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtPack" runat="server" ValidationGroup="p" CssClass="form-control"></asp:TextBox>
            <asp:DropDownList ID="ddlPackSize" runat="server" onchange="showPackUnit(this)" ValidationGroup="p"
                CssClass="form-control">
            </asp:DropDownList>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            *MRP</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtMRP" runat="server" CssClass="form-control" ValidationGroup="p"
                CausesValidation="True"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            DP With Tax</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtDPWithTax" runat="server" ValidationGroup="p" CssClass="form-control"
                onblur="calculateDP();"></asp:TextBox>

        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Tax</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtDPTax" runat="server" ValidationGroup="p" CssClass="form-control" onblur="calculateDP();"
                        CausesValidation="True" ></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Tax for stock</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtStock" runat="server" ValidationGroup="p" onblur="calculateDP();" Enabled="false"  Text="0"
                CausesValidation="True" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
   <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            DP</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtDP" runat="server" ValidationGroup="p" CausesValidation="True"
                Enabled="False" CssClass="form-control"></asp:TextBox>
            <asp:TextBox ID="txtCalculatedDP" runat="server" BorderWidth="0px" ReadOnly="True"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            BV</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtBV" runat="server" ValidationGroup="p" CausesValidation="True"
                CssClass="form-control"></asp:TextBox>
            <asp:CheckBox ID="chkBV" runat="server" Text="In % Age" onclick="calBVPercentage('txtBV')" />
            <asp:TextBox ID="txtCalculatedBV" runat="server" BorderWidth="0px" ReadOnly="True"
                CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Weight</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtWeight" runat="server" ValidationGroup="p" CausesValidation="True" Text="0" Enabled="false"
                CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Max Allowed</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txt_MaxBilling" runat="server" Text="0" CssClass="form-control"  Enabled="false" 
                ValidationGroup="p" CausesValidation="True" MaxLength="4"></asp:TextBox>
            Zero(0) Means Unlimited.
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Stock in Quantity</label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtQuanty" runat="server" Text="0" CssClass="form-control" Enabled="false"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Upload Image</label>
        <div class="col-sm-3 col-xs-9">
            <asp:FileUpload ID="imgUpload" runat="server" ForeColor="Black" />
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Description</label>
        <div class="col-sm-3 col-xs-9">
            <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
            <asp:HiddenField ID="H1" runat="server" />
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            &nbsp;</label>
        <div class="col-sm-3 col-xs-9">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                ValidationGroup="p" CssClass="btn btn-success" OnClientClick="javascript:doRteAction();" />
            <asp:ValidationSummary ID="ValidationSummary4" runat="server" Height="20px" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="p" Width="194px" />
        </div>
    </div>
    <div class="clearfix"> </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            &nbsp;</label>
        <div class="col-sm-3 col-xs-9">
            <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="False" Font-Names="Arial"></asp:Label>
        </div>
    </div>
    <div class="clearfix"> </div>

    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
            &nbsp;</label>
        <div class="col-sm-3">
            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                Display="None" ErrorMessage="Please enter title !" ForeColor="#C00000" Style="left: 41px;
                position: static; top: -29px" ValidationGroup="p" SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="revProductName" runat="server" ControlToValidate="txtProductName"
                Display="None" ErrorMessage="Please enter product name !" ForeColor="#C00000"
                Style="left: 41px; position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMRP"
                Display="None" ErrorMessage="Please enter MRP !" ForeColor="#C00000" Style="left: 41px;
                position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtMRP"
                Display="None" ErrorMessage="Only numeric value without space is allowed in price !"
                Font-Bold="False" ForeColor="#C00000" Style="position: static" ValidationExpression="^[0-9.]*"
                ValidationGroup="p"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtWeight"
                Display="None" ErrorMessage="Please enter Weight !" ForeColor="#C00000" Style="left: 41px;
                position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtWeight"
                Display="None" ErrorMessage="Only numeric value without space is allowed in Weight !"
                Font-Bold="False" ForeColor="#C00000" Style="position: static" ValidationExpression="^[0-9.]*"
                ValidationGroup="p"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDPWithTax"
                Display="None" ErrorMessage="Please enter value in DP with tax!" ForeColor="#C00000"
                Style="left: 41px; position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtDPWithTax"
                Display="None" ErrorMessage="Only numeric value without space is allowed in DP with tax!"
                Font-Bold="False" ForeColor="#C00000" Style="position: static" ValidationExpression="^[0-9.]*"
                ValidationGroup="p"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtDPTax"
                Display="None" ErrorMessage="Please enter value in tax !" ForeColor="#C00000"
                Style="left: 41px; position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                ControlToValidate="txtDPTax" Display="None" ErrorMessage="Only numeric value without space is allowed in tax !"
                Font-Bold="False" ForeColor="#C00000" Style="position: static" ValidationExpression="^[0-9.]*"
                ValidationGroup="p"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtBV"
                Display="None" ErrorMessage="Please enter BV!" ForeColor="#C00000" Style="left: 41px;
                position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtBV"
                Display="None" ErrorMessage="Only numeric value without space is allowed in BV!"
                Font-Bold="False" ForeColor="#C00000" Style="position: static" ValidationExpression="^[0-9.]*"
                ValidationGroup="p"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="imgUpload"
                Display="None" ErrorMessage="Please enter JPEG or JPG extension file only!" Font-Size="10pt"
                ForeColor="#C00000" ValidationExpression="^.*\.(jpg|JPG|jpeg|JPEG|gif|GIF|PNG|png)$"
                ValidationGroup="p"></asp:RegularExpressionValidator>
           
            <asp:HiddenField ID="hdnCalculatedDP" runat="server" />
       
            <asp:HiddenField ID="hdnCalculatedBV" runat="server" />
        </div>
    </div>
    <div class="clearfix"> </div>
    
    <h2 class="head" >
        <asp:LinkButton ID="lnkbtnProductList" runat="server" style="color:#003C78; text-decoration:none;">Product List</asp:LinkButton></h2>

    <br />


    <div>
    <div class="form-group">
        <label for="MainContent_txtPassword" class="col-sm-1 control-label">
            Product</label>
        <div class="col-sm-2">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>



    <div class="form-group">
        <div class="col-sm-2">
            <asp:Button ID="btnSearch" runat="server" Text="Search" ValidationGroup="Search"
                OnClick="btnSearch_Click" CssClass="btn btn-success" />
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" AutoPostBack="True"
                OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                <asp:ListItem Value="0">Active</asp:ListItem>
                <asp:ListItem Value="1">In Active</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-2">
            <asp:Button ID="btnShowAll" runat="server" Text="Show All" OnClick="btnShowAll_Click"
                CssClass="btn btn-success" />
        </div>
    </div>

    <div class="form-group">
        <label for="MainContent_txtPassword" class="col-sm-1 control-label">
            Page Size</label>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" CssClass="form-control"
                OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                <asp:ListItem Value="25">25</asp:ListItem>
                <asp:ListItem Value="50">50</asp:ListItem>
                <asp:ListItem Value="100">100</asp:ListItem>
                <asp:ListItem>All</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>

    </div>



    <table id="tblProductList" runat="server" style="width: 100%;">
        <tr runat="server" id="search">
            <td runat="server" id="tdExport">
                <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                    OnClick="ibtnExcelExport_Click" Style="width: 24px" />
                <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
                <%--<asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="~/admin/images/pdf.gif"
                                    OnClick="imgbtnpdf_Click" />--%>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblMessage" runat="server" ForeColor="#C00000" Font-Bold="False" Font-Names="Arial"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="table-responsive">
        <asp:GridView ID="GridView1" OnRowDataBound="GridView1_RowDataBound" EmptyDataText="No Data Found !"
            Style="width: 100%" runat="server" AutoGenerateColumns="False" AllowPaging="True"
            OnRowCommand="GridView1_RowCommand" PageSize="3" CssClass="table table-striped table-hover mygrd"
            OnPageIndexChanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Id">
                    <ItemTemplate>
                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("productid") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Title" DataField="Title"></asp:BoundField>
                <asp:BoundField HeaderText="Name" DataField="ProductName"></asp:BoundField>
                <asp:BoundField HeaderText="MRP" DataField="MRP"></asp:BoundField>
                <asp:BoundField HeaderText="DP" DataField="DPAmt"></asp:BoundField>
                <asp:BoundField HeaderText="BV" DataField="BVAmt"></asp:BoundField>
              <%--  <asp:BoundField HeaderText="MaxAllowed" DataField="MaxAllowed"></asp:BoundField>--%>
               <%-- <asp:BoundField DataField="Qty" HeaderText="Stock in Qty"></asp:BoundField>--%>
                <asp:BoundField DataField="doe" HeaderText="Date" ReadOnly="True"></asp:BoundField>
               <%-- <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="imgStatus" runat="server" />
                    </ItemTemplate>
                    <ItemStyle />
                </asp:TemplateField>--%>
               
            </Columns>
        </asp:GridView>
    </div>
    <div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtSearch"
            ErrorMessage="Please enter product !" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000"
            ValidationGroup="Search" Display="None"></asp:RequiredFieldValidator>
        <br />
        <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="Search" Width="222px" />
    </div>
</asp:Content>

