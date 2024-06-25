<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="PurchaseOrderForm.aspx.cs" Inherits="franchise_PurchaseOrderForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-1.4.2.js"></script>
    <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />
    <link rel="stylesheet" href="../css/jquery.autocomplete.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
    <style>
        td, th
        {
            padding: 5px 5px;
            border-color: #ddd;
        }
        .rrr
        {
            display: none;
        }
        .style1
        {
            height: 19px;
        }
        li.ac_even.ac_over
        {
            list-style: none;
            color: #fff;
            padding: 2px;
        }
        li.ac_even.ac_over:hover
        {
            background: #b52821;
            color: #fff;
        }
        li.ac_odd.ac_over:hover
        {
            background: #52821;
            color: #fff;
        }
        .ac_results li
        {
            margin: 0px;
            background: #C1C1C1b;
            padding: 2px 5px;
            cursor: default;
            display: block; /* width: 100%; */
            font: menu;
            font-size: 12px;
            line-height: 16px;
            overflow: hidden;
            color: #000;
        }
    </style>
    <script type="text/javascript">
        function CallVal(txt) {
            if (txt.value.length > 2)
                ServerSendValue(txt.value, "ctx");
        }
        function run() {
            var paytype = $('#<%=ddlpaytype.ClientID%>').val();
            if ($('#<%=ddlpaytype.ClientID%>').val() == 1) {
                $('#trbank').hide();
            }
            else {
                $('#trbank').show();
            }
        }
    </script>
    <div class="CenterArea">
        <script type="text/javascript">

            Sys.Application.add_load(function () {
                $(document).ready(function () {

                    var PCode = document.getElementById("<%=divProductCode.ClientID%>").innerHTML.split(",");
                    $('#<%=GridView1.ClientID %> tr:gt(0)').not("tr:last").find("td:eq(1)").find("input:text").each(function () {
                        $(this).autocomplete(PCode);
                    });

                    var data = document.getElementById("<%=divProduct.ClientID%>").innerHTML.split(",");
                    $('#<%=GridView1.ClientID %> tr:gt(0)').not("tr:last").find("td:eq(2)").find("input:text").each(function () {
                        $(this).autocomplete(data);
                    });
                });
            });

            function calculate(rowindex, txt) {

                //to get textbox value use val()
                //--------------------*************************************************************************************
                var qnt = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(4)").find("input:text").val();
                var items = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("input:text").val();
                var MaxAllowed = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(11)").find("input:text").val();
                var SQTY = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(12)").find("input:text").val();

                if (parseInt(qnt) <= parseInt(SQTY)) {
                    if (parseInt(qnt) <= parseInt(MaxAllowed)) {


                        var TaxPer = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(7)").find("input:text").val();
                        TaxPer = isNaN(TaxPer) ? 0 : TaxPer;
                        qnt = isNaN(qnt) ? 0 : qnt;

                        var mrp = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val();
                        mrp = isNaN(mrp) ? 0 : mrp;
                        var total = (mrp * qnt);
                        var dis = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(5)").find("input:text").val();
                        total = total - dis;
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(6)").text(total.toFixed(2));

                        var TaxInRs = (mrp * TaxPer / 100) * qnt;
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(8)").find("input:text").val(TaxInRs.toFixed(2));
                        total = Math.round(total + TaxInRs);

                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(10)").find("input:text").val(total.toFixed(2));

                        var TBV = 0;
                        var gross = 0;
                        var NetTot = 0;
                        var tottax = 0;
                        //tr:gt(0) skips the header and footer row while sum the value
                        $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").each(function () {


                            var d = $(this).find('td:eq(5)').find("input:text").val().trim();
                            var d1 = parseFloat((d == '' || d == null || isNaN(parseFloat(d))) ? 0 : d);
                            var temp = $(this).find('td:eq(4)').find("input:text").val().trim();
                            var qntt = parseInt((temp == '' || temp == null || isNaN(parseInt(temp))) ? 0 : temp);
                            var temp1 = $(this).find('td:eq(9)').find("input:text").val().trim();
                            var bv = parseFloat((temp1 == '' || temp1 == null || isNaN(parseFloat(temp1))) ? 0 : temp1);
                            var temp2 = $(this).find('td:eq(8)').find("input:text").val().trim();
                            // alert(temp2);
                            var tax = parseFloat((temp2 == '' || temp2 == null || isNaN(parseFloat(temp2))) ? 0 : temp2);
                            TBV += qntt * bv;
                            tottax += tax;
                            var Dpp = $(this).find('td:eq(3)').find("input:text").val().trim();
                            var DppAmt = parseFloat((Dpp == '' || Dpp == null || isNaN(parseFloat(Dpp))) ? 0 : Dpp);
                            gross += qntt * DppAmt - d1;

                        });
                        NetTot = gross + tottax;
                        NetTot = Math.round(NetTot);
                        $('#<%=txtTax.ClientID %>').val(parseFloat(tottax).toFixed(2));
                        $('#<%=txtNetAmt.ClientID %>').val(parseFloat(NetTot).toFixed(2));
                        $('#<%=lblTotalBV.ClientID%>').text(parseFloat(TBV).toFixed(2));
                        $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(gross).toFixed(2));

                        CalNetAmt('txtDelChrg', 'lblDelChrg');
                        CalNetAmt('txtDiscount', 'lblDiscount');
                    }

                    else {
                        alert("Max Allowed " + MaxAllowed);
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(4)").find("input:text").val(0);
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(6)").text(0);
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(10)").find("input:text").val(0);
                        return;
                    }
                }

                else {
                    alert("Stock in Hand " + SQTY);
                    $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(4)").find("input:text").val(0);
                    $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(6)").text(0);
                    $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(10)").find("input:text").val(0);
                    return;
                }
            }

            function productNotExists(rowindex) {
                $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("input:text").val('0');
                $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val('0');
                $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(4)").find("input:text").val('0');
                $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(5)").find("input:text").val('0');
                $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(6)").find("input:text").val('0');
                $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(7)").find("input:text").val('0');
                $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(8)").find("input:text").val('0');
                $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(10)").find("input:text").val('0');
                calculate(rowindex, $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(4)").find("input:text"));
            }


            function ShowMRP(rowindex, txt) {
                var isExists = 0;
                if (txt.value == '') {
                    productNotExists(rowindex);
                }
                else {
                    $('#tblMRP tr').each(function () {
                        if ($(this).find("td:first").text() == txt.value) {
                            //set MRP
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val(parseFloat($(this).find("td:eq(3)").text()).toFixed(2));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(7)").find("input:text").val(parseFloat($(this).find("td:eq(2)").text()).toFixed(2));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(9)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(11)").find("input:text").val(parseFloat($(this).find("td:eq(5)").text()));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("input:text").val(parseFloat($(this).find("td:eq(6)").text()));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(12)").find("input:text").val(parseFloat($(this).find("td:eq(7)").text()));
                            isExists = 1;
                        }
                    });
                    if (isExists == 0) {
                        //user has entered some value for the product but not matched
                        productNotExists(rowindex);
                        $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("span").text('Product not exists');
                    }
                    else {
                        $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("span").text('');
                    }
                }
                //sum MRP total
                var MrpTotal = 0;
                var BVTotal = 0;

                $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").each(function () {
                    var strVal = $(this).find("td:eq(3)").find("input:text").val();
                    var strBV = $(this).find("td:eq(5)").find("input:text").val();
                    MrpTotal += parseFloat(strVal == '' || strVal == null ? "0" : strVal);
                    BVTotal += parseFloat(strBV == '' || strBV == null ? "0" : strBV);
                    if ($(this).index() != (rowindex - 1) && txt.value != '' && isExists == 1 && $(this).find("td:eq(1)").find("input:text").val() == txt.value) {
                        $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("span").text('Already added');
                    }
                    else
                        $('#<%=GridView1.ClientID %> tr:nth-child(' + (rowindex + 1) + ')').find("td:eq(1)").find("span").text('');

                });
                calculate(rowindex, $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("input:text"));
                CalNetAmt('txtDelChrg', 'lblDelChrg');
                CalNetAmt('txtDiscount', 'lblDiscount');
            }




            function ShowMRPonPCode(rowindex, txt) {
                var isExists = 0;
                if (txt.value == '') {
                    productNotExists(rowindex);
                }
                else {
                    $('#tblMRP tr').each(function () {
                        if ($(this).find("td:eq(6)").text() == txt.value) {
                            //set MRP
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val(parseFloat($(this).find("td:eq(3)").text()).toFixed(2));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(7)").find("input:text").val(parseFloat($(this).find("td:eq(2)").text()).toFixed(2));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(9)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(13)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(11)").find("input:text").val(parseFloat($(this).find("td:eq(5)").text()));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("input:text").val($(this).find("td:eq(0)").text());
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(12)").find("input:text").val(parseFloat($(this).find("td:eq(7)").text()));
                            isExists = 1;
                        }
                    });
                    if (isExists == 0) {
                        //user has entered some value for the product but not matched
                        productNotExists(rowindex);
                        $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("span").text('Product code not exists');
                    }
                    else {
                        $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("span").text('');
                    }
                }
                var MrpTotal = 0;
                var BVTotal = 0;
                $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").each(function () {
                    var strVal = $(this).find("td:eq(3)").find("input:text").val();
                    var strBV = $(this).find("td:eq(5)").find("input:text").val();
                    MrpTotal += parseFloat(strVal == '' || strVal == null ? "0" : strVal);
                    BVTotal += parseFloat(strBV == '' || strBV == null ? "0" : strBV);
                    if ($(this).index() != (rowindex - 1) && txt.value != '' && isExists == 1 && $(this).find("td:eq(1)").find("input:text").val() == txt.value) {
                        $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("span").text('Already added');
                    }
                    else
                        $('#<%=GridView1.ClientID %> tr:nth-child(' + (rowindex + 1) + ')').find("td:eq(1)").find("span").text('');

                });
                calculate(rowindex, $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("input:text"));
                CalNetAmt('txtDelChrg', 'lblDelChrg');
                CalNetAmt('txtDiscount', 'lblDiscount');
            }


            function CalNetAmt(txt, lbl) {
                var taxAmt = 0;
                var txtVal = $('#' + txt).val().trim();
                if (txtVal == '' || txtVal == '0')
                    $('#' + txt).val('0');

                var TotalAmt = 0;
                $('#<%=GridView1.ClientID %> tr:gt(0)').not('tr:last').each(function () {
                    TotalAmt += parseFloat($(this).find('td:eq(9)').text());
                });
                TotalAmt = parseFloat(isNaN(TotalAmt) ? 0 : TotalAmt);
                taxAmt = parseFloat(parseFloat($('#' + txt).val()) * TotalAmt / 100).toFixed(2);
                $('#' + lbl).text(taxAmt);
                var taxRs = parseFloat($('#txtTax').val().trim());
                var DelRs = parseFloat($('#lblDelChrg').text().trim());
                var DisRs = parseFloat($('#lblDiscount').text().trim());
                var gross = parseFloat($('#<%=lblGrossTotal.ClientID %>').text().trim());
                taxRs = isNaN(taxRs) ? 0 : taxRs;
                DelRs = isNaN(DelRs) ? 0 : DelRs;
                DisRs = isNaN(DisRs) ? 0 : DisRs;
                var netAmt = parseFloat(TotalAmt) + parseFloat(DelRs) - parseFloat(DisRs);
                $('#txtNetAmt').val(netAmt.toFixed(2));
            }

        </script>
        <h2 class="head">
            <i class="fa fa-check-square-o"></i>Make New PO
        </h2>
        <div class="clearfix">
        </div>
        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="upnl" runat="server">
            <ContentTemplate>
                <div class="col-sm-11 pull-left" style="display: none;">
                    <%--  <button onclick="myFunction()" class="hide_class" style="float: right">
                        Print this Bill</button>--%>
                    <asp:Image ID="imgLogo" CssClass="logodiplay" runat="server" />
                    <h2>
                        <asp:Label ID="lblComName" runat="server" CssClass="websiteName"></asp:Label></h2>
                </div>
                <div class="clearfix">
                </div>
                <div class="printdiv">
                    <div class="col-sm-6 pull-left" style="display: none;">
                        <asp:Label ID="lblLeftHead" runat="server" CssClass="companyName"></asp:Label>
                    </div>
                    <div class="col-sm-6 pull-left" style="display: none;">
                        Invoice Number :
                        <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                        <asp:Label ID="lblOrderNO" runat="server"></asp:Label>
                        <br />
                        Invoice Date :
                        <asp:Label ID="lblRightHead" runat="server"></asp:Label>
                        <br />
                        TIN No. :
                        <asp:Label ID="lbltinno" runat="server"></asp:Label>
                        <br />
                        PAN No. :
                        <asp:Label ID="lblpan" runat="server"></asp:Label>
                        <br />
                        CIN No. :
                        <asp:Label ID="lblcinno" runat="server"></asp:Label>
                    </div>
                    <div class="col-sm-11">
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtCcode" class="col-sm-1 col-xs-3 control-label">
                            User Id:
                        </label>
                        <div class="col-sm-2 col-xs-9">
                            <asp:DropDownList ID="ddlbindfrantype" runat="server" CssClass="form-control" ValidationGroup="g">
                            </asp:DropDownList>
                            <%-- <asp:TextBox ID="txtUserId" ValidationGroup="g" runat="server" CssClass="form-control" CausesValidation="true"
                                onblur="return CallVal(this);" TabIndex="1"></asp:TextBox>--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlbindfrantype"
                                InitialValue="0" Display="Dynamic" ErrorMessage="Enter user id." SetFocusOnError="true"
                                ValidationGroup="g"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUserDisp" Enabled="false" Style="border-style: none; background-color: Transparent;
                                color: Black;" runat="server"></asp:TextBox>
                            <asp:TextBox ID="txtUserName" Enabled="false" Style="border-style: none; background-color: Transparent;
                                color: Black;" Width="300" runat="server"></asp:TextBox>
                            <asp:Label ID="lblToAdd" runat="server" Visible="false"></asp:Label>
                        </div>
                        <%--
                          <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
                        Distributor Type :
                        </label>--%>
                        <div class="col-sm-2">
                            <%--   <asp:DropDownList ID="ddldistributor" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddldistributor_SelectedIndexChanged">
                        </asp:DropDownList>--%>
                        </div>
                        <%--    Distributor  Mode:
                          <div class="col-sm-2">
                              <asp:DropDownList ID="ddlsubdistributor" runat="server" CssClass="form-control">
                              <asp:ListItem Value="1">Normal</asp:ListItem>
                              <asp:ListItem Value="2">Topper</asp:ListItem>
                              <asp:ListItem Value="3">Eagle</asp:ListItem>

                              </asp:DropDownList>
                                 
                          </div>--%>
                        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
                            Delivery Address:
                        </label>
                        <div class="col-sm-3 col-xs-9">
                            <asp:TextBox ID="txtDAddress" TextMode="MultiLine" runat="server" Height="50px" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <br />
                    <br />
                    <%--this div is used to store the product names to bind through javascript while searching in textbox--%>
                    <div id="divProduct" style="display: none;" runat="server">
                    </div>
                     <div id="divProductCode" style="display: none;" runat="server">
                        </div>
                    <%--this div is used to store the userid names to bind through javascript while searching in textbox--%>
                    <div id="divUserID" style="display: none;" runat="server">
                    </div>
                    <%--this div is used to store the product names and MRP to bind in grid--%>
                    <div id="divMRP" runat="server" style="display: none;">
                    </div>
                    <div class="clearfix">
                    </div>
                    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnl" runat="server">
                        <ProgressTemplate>
                            <img alt="Wait...." style="position: absolute; padding-left: 150px; z-index: 11111;
                                padding-top: 50;" src="../images/loading.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <td style="text-align: center;">
                                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                    <asp:GridView ID="GridView1" CssClass="printmygrd" Style="width: 100%;" DataKeyNames="id"
                                        BorderStyle="Dashed" BorderColor="Black" BorderWidth="1" ShowFooter="true" AutoGenerateColumns="False"
                                        runat="server" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound="GridView1_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField ControlStyle-Width="40px" ControlStyle-CssClass="border_leert"
                                                HeaderText="SNo.">
                                                <ItemTemplate>
                                                    <b>
                                                        <%#Container.DataItemIndex+1%>
                                                    </b>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert centertext" />
                                                <FooterTemplate>
                                                    <asp:ImageButton ID="btnNewRow" runat="server" ValidationGroup="a" OnClick="btnAddMore_Click"
                                                        ImageUrl="images/add_48.png" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                                HeaderStyle-Width="50px">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtcode" Text='<%#Eval("cd") %>' Width="80" Style="text-align: right"
                                                        CssClass="form-control" ValidationGroup="a" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Product Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                                HeaderStyle-Width="294px">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%#Eval("pname") %>' ID="txtProductNAme" CausesValidation="True"
                                                        ValidationGroup="ad" CssClass="form-control"></asp:TextBox>
                                                    <span style="color: Red;"></span>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert lefttext" />
                                                <FooterTemplate>
                                                    <b>Total:</b>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Unit Price" ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                                FooterStyle-CssClass="footerstylebodder" HeaderStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDPWT" Text='<%# String.Format("{0:#0.00}", DataBinder.Eval(Container.DataItem, "DPWT")) %>'
                                                        Style="text-align: right" BackColor="Transparent" Enabled="false" BorderStyle="None"
                                                        runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert" />
                                                <FooterTemplate>
                                                    <asp:Label ID="lblDPWTtotal" runat="server"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quantity" ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                                FooterStyle-CssClass="footerstylebodder" HeaderStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:RegularExpressionValidator ValidationExpression="^[0-9]{1,5}$" ID="RegularExpressionValidator1"
                                                        SetFocusOnError="true" Display="Dynamic" ValidationGroup="a" ControlToValidate="txtQuantity"
                                                        runat="server" ErrorMessage="Invalid Quantity."></asp:RegularExpressionValidator>
                                                    <asp:TextBox ID="txtQuantity" Text='<%#Eval("quantity") %>' Width="50" MaxLength="5"
                                                        Style="text-align: right" ValidationGroup="a" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblQtotal" runat="server"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Discount" ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                                FooterStyle-CssClass="footerstylebodder" HeaderStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDis" Text='<%# String.Format("{0:#0.00}", DataBinder.Eval(Container.DataItem, "Dis")) %>'
                                                        Style="text-align: right" BackColor="Transparent" ValidationGroup="a" ForeColor="Black"
                                                        Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert" />
                                                <FooterTemplate>
                                                    <asp:Label ID="lblDistotal" runat="server"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Value" ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                                FooterStyle-CssClass="footerstylebodder" HeaderStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtval" Text='<%# String.Format("{0:#0.00}", DataBinder.Eval(Container.DataItem, "val")) %>'
                                                        Style="text-align: right" BackColor="Transparent" Enabled="false" BorderStyle="None"
                                                        ForeColor="Black" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert" />
                                                <FooterTemplate>
                                                    <asp:Label ID="lblValtotal" runat="server"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="GST(%)" ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                                FooterStyle-CssClass="footerstylebodder" HeaderStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTax" Text='<%# String.Format("{0:#0.00}",Eval("Tax")) %>' Style="text-align: right"
                                                        BackColor="Transparent" Enabled="false" BorderStyle="None" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert" />
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTaxtotal" runat="server"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="GST" ControlStyle-CssClass="hide_class " FooterStyle-CssClass="hide_class"
                                                HeaderStyle-CssClass="hide_class" ControlStyle-Width="80" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTaxRs" Text='<%#string.Format("{0:#0.00}",Eval("TaxRs")) %>'
                                                        Style="text-align: right" BackColor="Transparent" Enabled="false" BorderStyle="None"
                                                        runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert hide_class" />
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTaxRsTtotal" Font-Bold="true" runat="server"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="BV" ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                                FooterStyle-CssClass="footerstylebodder" HeaderStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBV" Text='<%#String.Format("{0:#0.00}", Eval("BV")) %>' Style="text-align: right"
                                                        BackColor="Transparent" Enabled="false" BorderStyle="None" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert" />
                                                <FooterTemplate>
                                                    <asp:Label ID="lblBVtotal" runat="server"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTotal" Text='<%# String.Format("{0:#0.00}",Eval("total")) %>'
                                                        Style="text-align: right" BackColor="Transparent" Enabled="false" BorderStyle="None"
                                                        runat="server"></asp:TextBox>
                                                    <%--<%#string.Format("{0:#0.00}", Eval("total") )%>--%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="rrr" ItemStyle-CssClass="rrr" FooterStyle-CssClass="rrr">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtMax" Text='<%# Eval("MaxAllowed") %>' Style="text-align: right;"
                                                        BackColor="Transparent" Enabled="false" BorderStyle="None" ForeColor="Black"
                                                        runat="server"></asp:TextBox>
                                                    <span style="color: Red;"></span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="rrr" ItemStyle-CssClass="rrr" FooterStyle-CssClass="rrr">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtSQTY" Text='<%# Eval("QTY") %>' Style="text-align: right;" BackColor="Transparent"
                                                        Enabled="false" BorderStyle="None" ForeColor="Black" runat="server"></asp:TextBox>
                                                    <span style="color: Red;"></span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-CssClass="hide_class" HeaderStyle-CssClass="hide_class"
                                                FooterStyle-CssClass="hide_class">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnDelete" ValidationGroup="a" OnClientClick="return confirm('Are you sure to delete the item.');"
                                                        CommandName="Delete" CommandArgument='<%#Container.DisplayIndex%>' runat="server"
                                                        ImageUrl="~/franchise/images/delete.jpg" />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="border_leert hide_class" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="totalnet">
                        <div class="col-sm-6">
                            <table style="width: 100%; border-top: dashed 1px #000;">
                                <tr>
                                    <td style="width: 60%;">
                                        <table>
                                            <tr>
                                                <td>
                                                    Net Product&#39;s Value Total :
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:Label ID="lblGrossTotal" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Total GST Amount :
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:TextBox ID="txtTax" runat="server" Enabled="false" Style="background-color: Transparent;
                                                        text-align: right; border-style: none;" ReadOnly="True"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Total BV :
                                                    <td style="text-align: right">
                                                        <asp:Label ID="lblTotalBV" runat="server"></asp:Label>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Total weight:<td style="text-align: right">
                                                        <asp:Label ID="lblWeight" runat="server"></asp:Label>
                                                    </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Delivery Charge:
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:TextBox ID="txtDelChrg" runat="server" ToolTip="% of Total" MaxLength="5" onblur="CalNetAmt('txtDelChrg','lblDelChrg');"
                                                        Style="text-align: right" ValidationGroup="g" Width="50"></asp:TextBox>
                                                    <asp:Label ID="lblDelChrg" runat="server"></asp:Label>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDelChrg"
                                                        Display="Dynamic" ErrorMessage="Invalid Entry of Delivery Charge." SetFocusOnError="true"
                                                        ValidationExpression="^[0-9.]{1,5}$" ValidationGroup="g"></asp:RegularExpressionValidator>
                                                    <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtDelChrg"
                                                        Display="Dynamic" ErrorMessage="0" MaximumValue="100" MinimumValue="0" SetFocusOnError="true"
                                                        Type="Double" ValidationGroup="g"></asp:RangeValidator>
                                                </td>
                                            </tr>
                                            <tr style="display: none">
                                                <td>
                                                    Discount:
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:TextBox ID="txtDiscount" ToolTip="% of Total" onblur="CalNetAmt('txtDiscount','lblDiscount');"
                                                        Width="50" Style="text-align: right" runat="server" MaxLength="5" ValidationGroup="g"></asp:TextBox>
                                                    <span class="companyName">
                                                        <asp:Label ID="lblDiscount" runat="server"></asp:Label></span><br />
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtDiscount"
                                                        Display="Dynamic" ErrorMessage="Invalid Entry of Discount." SetFocusOnError="true"
                                                        ValidationExpression="^[0-9.]{1,5}$" ValidationGroup="g"></asp:RegularExpressionValidator>
                                                    <asp:RangeValidator ID="RangeValidator3" runat="server" Type="Double" MinimumValue="0"
                                                        MaximumValue="100" ControlToValidate="txtDiscount" Display="Dynamic" ErrorMessage="0"
                                                        SetFocusOnError="true" ValidationGroup="g"></asp:RangeValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Total&nbsp; Amount(Rs):
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:TextBox ID="txtNetAmt" runat="server" Style="text-align: right; width: 80px;
                                                        border-style: none; background-color: transparent" ValidationGroup="g" ReadOnly="True"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtNetAmt"
                                                        Display="Dynamic" ErrorMessage="Invalid Entry of Net Amount." SetFocusOnError="true"
                                                        ValidationExpression="^[0-9.]{1,20}$" ValidationGroup="g"></asp:RegularExpressionValidator>
                                                    <asp:RequiredFieldValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtNetAmt"
                                                        Display="Dynamic" ErrorMessage="Enter Net Amount" SetFocusOnError="true" ValidationGroup="g"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                        <b>
                                            <asp:Label ID="lblAmtWord" runat="server"></asp:Label></b>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm-6">
                            <table id="tblbank" style="float: right; margin-right: 5%; width: 100%; border-top: dashed 1px #000;">
                                <tr>
                                    <td>
                                        Payments Mode:<br />
                                        <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="form-control" onchange="run();">
                                            <asp:ListItem Value="1">Cash</asp:ListItem>
                                            <asp:ListItem Value="2">Cheque</asp:ListItem>
                                            <asp:ListItem Value="3">Net Banking</asp:ListItem>
                                            <asp:ListItem Value="4">DD</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="trbank" style="display: none;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        Bank Name
                                                    </td>
                                                    <td>
                                                        DD/Cheque/Transaction No
                                                    </td>
                                                    <td>
                                                        Date
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtbname" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDD" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="clearfix">
                        </div>
                        <asp:Button ID="btnGenerateBill" runat="server" CssClass="btn btn-success" OnClick="btnGenerateBill_Click"
                            Text="Make New PO" ValidationGroup="g" Style="float: right" OnClientClick="return confirm('Are you sure you want to proceed？')"/>
                        <br />
                        <asp:Label ID="lblscheme" runat="server"></asp:Label>
                    </div>
                    <table style="width: 100%; border-top: dashed 1px #000; border-bottom: dashed 1px #000;">
                        <tr>
                            <td style="text-align: left; width: 70%;" class="boder_righ">
                                <span class="term_condition"><b>Terms & Conditions</b>
                                    <ol>
                                        <li>All Disputes are subject to jurisdiction of Delhi only.</li>
                                        <li>Company is not responsible after the goods leave the premises.</li>
                                        <li>Any inaccuracy in this bill must be notifided immediately on its receipt.</li>
                                        <li style="display: none">
                                            <asp:Label ID="lblCity" runat="server"></asp:Label>� jurisdiation only.</li>
                                        <li style="display: none">Warranty vaild in
                                            <asp:Label ID="lblCity2" runat="server"></asp:Label>
                                            Only</li>
                                    </ol>
                                </span>
                            </td>
                            <td style="text-align: left; width: 30%">
                                <b><span class="companyName">for
                                    <asp:Label ID="lblCompName" runat="server"></asp:Label>
                                    <br />
                                    <br />
                                    <br />
                                    Prepared By<asp:Label ID="lblp" runat="server"></asp:Label>
                                </span></b>
                            </td>
                        </tr>
                    </table>
                    <%-- <button onclick="myFunction()" class="hide_class" style="float: right">
                            Print this Bill</button>
                        <script>
                            function myFunction() {
                                window.print();
                            }
                        </script>--%>
                    <center>
                        <div style="width: 100%; float: left; margin-top: 20px;">
                            <asp:Label Text="" ID="lblCompanyAdd" runat="server"></asp:Label>
                            <asp:Label Text="" ID="lblBillFooter" Visible="false" runat="server"></asp:Label>
                        </div>
                    </center>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

         
    </script>
</asp:Content>
