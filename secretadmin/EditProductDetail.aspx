<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="EditProductDetail.aspx.cs" Inherits="admin_EditProductDetail"
    ValidateRequest="false" %>

<%@ Register Assembly="RichTextEditor" Namespace="AjaxControls" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtMfdDate.ClientID %>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });
        });
    
    
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
                        alert("Please enter numeric DP GST.");
                    }

                }
                else {
                    alert("Please enter numeric DP with GST.");
                    document.getElementById("txtDPWithTax").focus();
                }
            }
            else {
                alert("Please enter DP with GST.");
                document.getElementById("txtDPWithTax").focus();
            }






            if (document.getElementById("txtStockDpWithTax").value != "") {
                if (document.getElementById("txtStockDpWithTax").value.match(letters)) {
                    if (document.getElementById("ddlGST").value == "") {
                        document.getElementById("ddlGST").value = '0';
                        document.getElementById("txtStockDpWithTax").focus();
                    }
                    if (document.getElementById("ddlGST").value.match(letters)) {

                        document.getElementById("txtDPStock").value = (parseFloat(document.getElementById("txtStockDpWithTax").value) * parseFloat(100)) / (parseFloat(document.getElementById("ddlGST").value) + parseFloat(100));
                        document.getElementById("hdnCalculatedDPStk").value = (parseFloat(document.getElementById("txtStockDpWithTax").value) * parseFloat(100)) / (parseFloat(document.getElementById("ddlGST").value) + parseFloat(100));
                    }
                    else {
                        alert("Please enter numeric DP GST.");
                    }

                }
                else {
                    alert("Please enter numeric DP with GST.");
                    document.getElementById("txtStockDpWithTax").focus();
                }
            }
            else {
                alert("Please enter DP with GST.");
                document.getElementById("txtStockDpWithTax").focus();
            }
        }</script>
    <style type="text/css">
        .style1
        {
            font-weight: bold;
            color: #FFFFFF;
        }
    </style>
    <%--<script language="javascript" type="text/javascript">
        var maxLength = 200;
        $(document).ready(function () {
            $("#lblCharLeft").text(maxLength + " characters left.");

            $('#<%=txtDescription.ClientID %>').keydown(function () {
                var text = $(this).val();
                var textLength = text.length;
                if (textLength > maxLength) {
                    $(this).val(text.substring(0, (maxLength)));
                    alert("Sorry," + maxLength + " characters are allowed.");
                    return false;
                }
                else {
                    $("#lblCharLeft").text((maxLength - textLength) + " characters left.");
                }
            });
        });
    </script>--%>
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div id="title" class="b2">
                    <h4 class="head" style="color: #fff">
                        Edit Product Details
                    </h4>
                </div>
                <div class="clearfix">
                </div>
                <div class="form-horizontal">
                    <div class="form-group">
                        <%--<div class="col-sm-4">
                            <label>
                                Batch No:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtBatchNo" runat="server" CssClass="form-control" Visible="false" MaxLength="50"></asp:TextBox>
                        </div>--%>
                        <div class="col-sm-4">
                            <label>
                                Title:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <label>
                                Product Name:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <label>
                                Pack Size:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtPack" runat="server" ValidationGroup="p" CssClass="form-control"></asp:TextBox>
                            <asp:DropDownList ID="ddlPackSize" runat="server" CssClass="col-md-2 col-xs-4 form-control"
                                onchange="showPackUnit(this)" ValidationGroup="p">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <div class="col-sm-4">
                            <label>
                                MRP:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtMRP" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <label>
                                DP With GST:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtDPWithTax" runat="server" CssClass="form-control" ValidationGroup="p"
                                onblur="calculateDP();"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <label>
                                GST:<b><span style="color: Red">*</span></b>
                            </label>
                            <%--   <asp:TextBox ID="txtDPTax" runat="server" CssClass="form-control" ValidationGroup="p"
                                onblur="calculateDP();" CausesValidation="True"></asp:TextBox>--%>
                            <asp:DropDownList ID="ddlGST" runat="server" CssClass="form-control" onblur="calculateDP();">
                                <asp:ListItem>0</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                                <asp:ListItem>18</asp:ListItem>
                                <asp:ListItem>28</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <div class="col-sm-4">
                            <label>
                                DP Stock With GST:<b><span style="color: Red">*</span></b>
                            </label>
                            <asp:TextBox ID="txtStockDpWithTax" runat="server" CssClass="form-control" ValidationGroup="p"
                                CausesValidation="True" onblur="calculateDP();"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <label>
                                DP:<b><span style="color: Red">*</span></b>
                            </label>
                            <asp:TextBox ID="txtDP" runat="server" CssClass="form-control" ValidationGroup="p"
                                CausesValidation="True" Enabled="False" ></asp:TextBox>
                            <asp:TextBox ID="txtCalculatedDP" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                         <div class="col-sm-4">
                            <label>
                                DP Stock:<b><span style="color: Red">*</span></b>
                            </label>
                            <asp:TextBox ID="txtDPStock" runat="server" CssClass="form-control" ValidationGroup="p"
                                CausesValidation="True" Enabled="False" ></asp:TextBox>
                            <asp:TextBox ID="txtCalculatedDPStock" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                      
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                      <div class="col-sm-4">
                            <label>
                                BV:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtBV" runat="server" CssClass="form-control" ValidationGroup="p"
                                CausesValidation="True"></asp:TextBox>
                            <asp:CheckBox ID="chkBV" runat="server" Text="In % Age" onclick="calBVPercentage('txtBV')" />
                            <asp:TextBox ID="txtCalculatedBV" runat="server" BorderWidth="0px" ReadOnly="True"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <label>
                                PV:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtpvamt" runat="server" CssClass="form-control" ValidationGroup="p"
                                MaxLength="4" CausesValidation="True"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <label>
                                Max Allowed:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txt_MaxAllowed" runat="server" CssClass="form-control" ValidationGroup="p"
                                MaxLength="4" CausesValidation="True"></asp:TextBox>
                            Zero(0) Means Unlimited.
                        </div>
                      
                        <div class="col-sm-4">
                            <%-- <label>
                                Mfd Date:<b><span style="color: Red">*</span></b>
                            </label>--%>
                            <asp:TextBox ID="txtMfdDate" runat="server" Visible="false" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                      <div class="col-sm-4">
                            <label>
                                HSN Code:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txthsncode" runat="server" CssClass="form-control" ValidationGroup="p"
                                CausesValidation="True"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <label>
                                Cost Amount:<b><span style="color: Red">*</span></b></label>
                            <asp:TextBox ID="txtCostAmt" runat="server" CssClass="form-control" ValidationGroup="p"
                                CausesValidation="True"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <div class="col-sm-4">
                            <%--<label>
                              Description:<b><span style="color: Red">*</span></b>
                            </label>--%>
                            <asp:TextBox ID="txtDescription" runat="server" Visible="false" CssClass="form-control"
                                TextMode="MultiLine" Rows="5" Columns="50" MaxLength="200"></asp:TextBox>
                            <%--<label id="lblCharLeft">
                            </label>--%>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-4">
                            <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--
                    <cc3:Accordion ID="Accordion3" runat="server" SelectedIndex="-1" HeaderCssClass="accordionHeader"
        HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent"
        FadeTransitions="true" SuppressHeaderPostbacks="true" TransitionDuration="250"
        FramesPerSecond="40" RequireOpenedPane="false" AutoSize="None">
        <Panes>
            <cc3:AccordionPane ID="AccordionPane1" runat="server">
                <Header>
                    <a href="#" class="href" style="text-decoration: none;">Product  Description</a>
                </Header>
                <Content>
                <asp:Panel ID="Panel1" runat="server">--%>
    <div class="b2">
        <h4 class="head" style="color: #fff">
            Edit Product Description
        </h4>
    </div>
    <div class="clearfix">
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (1) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txttitle1" runat="server" placeholder="Description" CssClass="form-control"
            Rows="1"></asp:TextBox>
        <label id="Label20">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (1) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription1" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label21">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription1" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (2) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txttitle2" runat="server" placeholder="Composition " CssClass="form-control"
            Rows="1"></asp:TextBox>
        <label id="Label22">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (2) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription2" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label23">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription2" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (3) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtTitle3" runat="server" placeholder="Benefits " CssClass="form-control"
            Rows="1"></asp:TextBox>
        <label id="Label24">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (3) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription3" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label25">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription3" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (4) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtTitle4" runat="server" placeholder="How to use " CssClass="form-control"
            Rows="1"></asp:TextBox>
        <label id="Label26">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (4) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription4" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label27">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription4" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (5) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtTitle5" runat="server" CssClass="form-control" Rows="1"></asp:TextBox>
        <label id="Label28">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (5) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription5" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label29">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription5" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (6) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtTitle6" runat="server" CssClass="form-control" Rows="1"></asp:TextBox>
        <label id="Label30">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (6) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription6" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label31">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription6" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (7) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtTitle7" runat="server" CssClass="form-control" Rows="1"></asp:TextBox>
        <label id="Label32">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (7) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription7" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label33">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription7" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (8) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtTitle8" runat="server" CssClass="form-control" Rows="1"></asp:TextBox>
        <label id="Label34">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (8) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription8" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label35">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription8" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (9) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtTitle9" runat="server" CssClass="form-control" Rows="1"></asp:TextBox>
        <label id="Label36">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (9) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription9" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label37">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription9" ValidationGroup="ra" Visible="false"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (10) Title <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtTitle10" runat="server" CssClass="form-control" Rows="1"></asp:TextBox>
        <label id="Label38">
        </label>
    </div>
    <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
        (10) Text <b><span style="color: Red"></span></b>
    </label>
    <div class="col-sm-4">
        <%--  <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                                <asp:HiddenField ID="H1" runat="server" />--%>
        <asp:TextBox ID="txtDescription10" runat="server" placeholder="Description" TextMode="MultiLine"
            CssClass="form-control" Rows="3"></asp:TextBox>
        <label id="Label39">
        </label>
    </div>
    <div class="col-sm-1">
        <asp:Button runat="server" ID="btnDescription10" Visible="false" ValidationGroup="ra"
            Text="ok" CssClass="form-control" />
    </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
            &nbsp;</label>
        <%-- <div class="col-sm-4">
                                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                    ValidationGroup="p" CssClass="btn btn-success" />
                            </div>--%>
        <div class="col-sm-4">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                ValidationGroup="ac" CssClass="btn btn-success" />
            <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" CssClass="btn btn-success" />
        </div>
    </div>
    <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 1."
                                    ControlToValidate="txtDescription1" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.\"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 2."
                                    ControlToValidate="txtDescription2" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 3."
                                    ControlToValidate="txtDescription3" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator15" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 4."
                                    ControlToValidate="txtDescription4" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 5."
                                    ControlToValidate="txtDescription5" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 6."
                                    ControlToValidate="txtDescription6" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator18" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 7."
                                    ControlToValidate="txtDescription7" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator19" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 8."
                                    ControlToValidate="txtDescription8" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator20" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 9."
                                    ControlToValidate="txtDescription9" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator21" runat="server" ErrorMessage=" Accept Only Alpha, Numeric and space in Description 10."
                                    ControlToValidate="txtDescription10" SetFocusOnError="true" Display="None" ValidationGroup="p"
                                    ValidationExpression="^[a-zA-Z\d\s\.]+$"></asp:RegularExpressionValidator>--%>
    <asp:RegularExpressionValidator ID="revTitle1" runat="server" ControlToValidate="txttitle1"
        Display="None" ErrorMessage="Title 1 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle2" runat="server" ControlToValidate="txttitle2"
        Display="None" ErrorMessage="Title 2 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle3" runat="server" ControlToValidate="txtTitle3"
        Display="None" ErrorMessage="Title 3 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle4" runat="server" ControlToValidate="txtTitle4"
        Display="None" ErrorMessage="Title 4 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle5" runat="server" ControlToValidate="txtTitle5"
        Display="None" ErrorMessage="Title 5 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle6" runat="server" ControlToValidate="txtTitle6"
        Display="None" ErrorMessage="Title 6 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle7" runat="server" ControlToValidate="txtTitle7"
        Display="None" ErrorMessage="Title 7 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle8" runat="server" ControlToValidate="txtTitle8"
        Display="None" ErrorMessage="Title 8 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle9" runat="server" ControlToValidate="txtTitle9"
        Display="None" ErrorMessage="Title 9 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="revTitle10" runat="server" ControlToValidate="txtTitle10"
        Display="None" ErrorMessage="Title 10 Contains Alphabetic value!" Font-Bold="False"
        ForeColor="#C00000" ToolTip="ra" ValidationExpression="^[A-Za-z. ]{1,50}$" ValidationGroup="ra"
        SetFocusOnError="true"></asp:RegularExpressionValidator>
    <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="ra" HeaderText="Please Check the following..." />
    <%--    </asp:Panel>
                </Content>

                 </cc3:AccordionPane>
        </Panes>
    </cc3:Accordion>--%>
    <div class="col-sm-4">
        <%-- <asp:RequiredFieldValidator ID="rfvBatchNo" runat="server" ErrorMessage="Please Enter Batch No."
            ControlToValidate="txtBatchNo" SetFocusOnError="true" Display="None" ValidationGroup="ac"></asp:RequiredFieldValidator>--%>
        <%--<asp:RegularExpressionValidator ID="refBatch" runat="server" ErrorMessage="Only letters or numbers are allowed in Batch No."
            ControlToValidate="txtBatchNo" SetFocusOnError="true" Display="None" ValidationGroup="ac"
            ValidationExpression="^[a-zA-Z0-9]*$"></asp:RegularExpressionValidator>--%>
        <asp:RequiredFieldValidator ID="vdl2" runat="server" ControlToValidate="txtTitle"
            Display="None" ErrorMessage="Please Enter Title !" ForeColor="#C00000" SetFocusOnError="True"
            ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="vdl" runat="server" ControlToValidate="txtProductName"
            Display="None" ErrorMessage="Please Enter Product Name !" ForeColor="#C00000"
            SetFocusOnError="True" ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMRP"
            Display="None" ErrorMessage="Please Enter
    MRP !" ForeColor="#C00000" SetFocusOnError="True" ValidationGroup="ac">Please Enter
    MRP !</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtMRP"
            Display="None" ErrorMessage="Only Numeric
    Value Without Space Is Allowed !" Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*"
            ValidationGroup="ac">Only Numeric Value Without Space Is Allowed !</asp:RegularExpressionValidator>
        <%--    <asp:RequiredFieldValidator ID="rfvMFD" runat="server" ErrorMessage="Please Enter Manufacturing Date."
            ControlToValidate="txtMfdDate" SetFocusOnError="true" Display="None" ValidationGroup="ac"></asp:RequiredFieldValidator>--%>
        <%-- <asp:RegularExpressionValidator ID="revMFD" runat="server" ErrorMessage="Please Enter Valid Manufacturing Date."
            ControlToValidate="txtMfdDate" SetFocusOnError="true" Display="None" ValidationGroup="ac"
            ValidationExpression="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$">
        </asp:RegularExpressionValidator>--%>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDP"
            Display="None" ErrorMessage="Please Enter DP!" ForeColor="#C00000" Style="left: 41px;
            position: static; top: -29px" ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDP"
            Display="None" ErrorMessage="Only Numeric Value Without
    Space Is Allowed In DP!" Font-Bold="False" ForeColor="#C00000" Style="position: static"
            ValidationExpression="^[0-9.]*" ValidationGroup="ac"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtBV"
            Display="None" ErrorMessage="Please Enter BV!" ForeColor="#C00000" ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtBV"
            Display="None" ErrorMessage="Only Numeric Value Without
    Space Is Allowed In BV!" Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*"
            ValidationGroup="ac"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtpvamt"
            Display="None" ErrorMessage="Please Enter PV!" ForeColor="#C00000" ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtpvamt"
            Display="None" ErrorMessage="Only Numeric Value Without
    Space Is Allowed In PV!" Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*"
            ValidationGroup="ac"></asp:RegularExpressionValidator>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDPWithTax"
            Display="None" ErrorMessage="Please enter value in DP with GST!" ForeColor="#C00000"
            ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtDPWithTax"
            Display="None" ErrorMessage="Only numeric value
    without space is allowed in DP with GST!" Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*"
            ValidationGroup="ac"></asp:RegularExpressionValidator>
        <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtDPTax"
            Display="None" ErrorMessage="Please enter value in GST !" ForeColor="#C00000"
            ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
            ControlToValidate="txtDPTax" Display="None" ErrorMessage="Only numeric value without
    space is allowed in GST !" Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*"
            ValidationGroup="ac"></asp:RegularExpressionValidator>--%>
        <asp:RequiredFieldValidator ID="rfvPacksize" runat="server" ControlToValidate="txtPack"
            Display="None" ErrorMessage="Please Enter Pack Size!" ForeColor="#C00000" SetFocusOnError="true"
            ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator20" runat="server"
            SetFocusOnError="true" ControlToValidate="txtPack" Display="None" ErrorMessage="Only numeric value without space is allowed in pack size !"
            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9]*" ValidationGroup="ac"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="rfvCostAmt" runat="server" ControlToValidate="txtCostAmt"
            Display="None" ErrorMessage="Please Enter Cost Amount!" ForeColor="#C00000" SetFocusOnError="true"
            ValidationGroup="ac"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revCostAmt" runat="server" SetFocusOnError="true"
            ControlToValidate="txtCostAmt" Display="None" ErrorMessage="Only numeric value without space is allowed in Cost Amount !"
            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9.]*$" ValidationGroup="ac"></asp:RegularExpressionValidator>
        <asp:HiddenField ID="hdnCalculatedDP" runat="server" />
         <asp:HiddenField ID="hdnCalculatedDPStk" runat="server" />
        <asp:HiddenField ID="hdnCalculatedBV" runat="server" />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
            HeaderText="Please check the following..." ShowSummary="false" ValidationGroup="ac" />
    </div>
</asp:Content>
