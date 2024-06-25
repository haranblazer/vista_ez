<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="TranStock.aspx.cs" Inherits="TranStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <style type="text/css">
        .rrr
        {
            display: none;
        }
    </style>
    <script type="text/javascript">
        function CallVal(txt) {
            if (txt.value.length > 2)
                ServerSendValue(txt.value, "ctx");
        }
        function run() {
            $('#trWallet').hide();

            var ddlReport = document.getElementById("<%=ddlpaytype.ClientID%>");
            var Text = ddlReport.options[ddlReport.selectedIndex].text;

            var Table = document.getElementById('tblbank').rows[3].id
            if (Text.localeCompare("Cash") == 0) {
                document.getElementById(Table).style.display = 'none'
            }
            else if (Text.localeCompare("Wallet") == 0) {
                document.getElementById(Table).style.display = 'none'
                $('#trWallet').show();
            }
            else {
                document.getElementById(Table).style.display = 'block'
            }

        }
        function ServerResult(arg) {
            if (arg == "Required field cannot be blank !" || arg == "User Does Not Exists!") {
                document.getElementById("<%=txtUserName.ClientID%>").style.color = "Red";
                document.getElementById("<%=txtUserName.ClientID%>").value = arg;
                document.getElementById("<%=txtUserId.ClientID%>").focus();
            }
            else {
                document.getElementById("<%=txtUserName.ClientID%>").style.color = "Blue";
                document.getElementById("<%=txtUserName.ClientID%>").value = arg;
                document.getElementById("<%=txtUserDisp.ClientID%>").value = document.getElementById("<%=txtUserId.ClientID%>").value;
                document.getElementById("<%=txtUserName.ClientID%>").value = arg;

            }
        }

        function ClientErrorCallback() {
        }

    </script>
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
                //user id auto complete
                var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
                $('#<%=txtUserId.ClientID %>').autocomplete(dataUserID);

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
                var Tgross = 0;
                //tr:gt(0) skips the header and footer row while sum the value
                $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").each(function () {

                    var taxperce = $(this).find('td:eq(7)').find("input:text").val();

                    var d = $(this).find('td:eq(5)').find("input:text").val();
                    var d1 = parseFloat((d == '' || d == null || isNaN(parseFloat(d))) ? 0 : d);
                    var temp = $(this).find('td:eq(4)').find("input:text").val();
                    var qntt = parseInt((temp == '' || temp == null || isNaN(parseInt(temp))) ? 0 : temp);
                    var temp1 = $(this).find('td:eq(9)').find("input:text").val();
                    var bv = parseFloat((temp1 == '' || temp1 == null || isNaN(parseFloat(temp1))) ? 0 : temp1);
                    TBV += qntt * bv;

                    var Dpp = $(this).find('td:eq(3)').find("input:text").val();
                    var DppAmt = parseFloat((Dpp == '' || Dpp == null || isNaN(parseFloat(Dpp))) ? 0 : Dpp);
                    gross += qntt * DppAmt - d1;
                    Tgross += (DppAmt * qntt) * taxperce / 100;
                });

                //                    alert(mrp);
                //                   
                //alert(qnt);


                $('#<%=Label1.ClientID%>').text(parseFloat(Tgross).toFixed(2));
                $('#<%=txtNetAmt.ClientID %>').val(parseFloat(Tgross + gross).toFixed(2));
                $('#<%=txtTax.ClientID %>').val(parseFloat(Tgross).toFixed(2));
                $('#<%=lblAmt.ClientID%>').text(parseFloat(Tgross + gross).toFixed(2));
                $('#<%=lblTotalPy.ClientID%>').text(parseFloat(Tgross + gross).toFixed(2));
                //                    $('#<%=lblTotalBV.ClientID%>').text(parseFloat(TBV).toFixed(2));
                $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(gross).toFixed(2));

                CalNetAmt('txtDelChrg', 'lblDelChrg');
                CalNetAmt('txtDiscount', 'lblDiscount');

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
            $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("input:text").val('');
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
            var txtVal = $('#' + txt).val();
            if (txtVal == '' || txtVal == '0')
                $('#' + txt).val('0');

            var TotalAmt = 0;
            $('#<%=GridView1.ClientID %> tr:gt(0)').not('tr:last').each(function () {

                TotalAmt += parseFloat($(this).find('td:eq(9)').text());
            });
            TotalAmt = parseFloat(isNaN(TotalAmt) ? 0 : TotalAmt);
            taxAmt = parseFloat(parseFloat($('#' + txt).val()) * TotalAmt / 100).toFixed(2);
            $('#' + lbl).text(taxAmt);
            var taxRs = parseFloat($('#txtTax').val());
            var DelRs = parseFloat($('#lblDelChrg').text());
            var DisRs = parseFloat($('#lblDiscount').text());
            var gross = parseFloat($('#<%=lblGrossTotal.ClientID %>').text());
            taxRs = isNaN(taxRs) ? 0 : taxRs;
            DelRs = isNaN(DelRs) ? 0 : DelRs;
            DisRs = isNaN(DisRs) ? 0 : DisRs;

            var netAmt = parseFloat(TotalAmt) + parseFloat(DelRs) - parseFloat(DisRs);
            $('#txtNetAmt').val(netAmt.toFixed(2));
        }

    </script>
    <%-- <div class="CenterArea">--%>
    <%--  <asp:HiddenField ID="hfCouponapplied" runat="server" Value="0" />
        <asp:HiddenField ID="hfNetTotal" runat="server" Value="0" />--%>
    <h2 class="head">
        <i class="fa fa-stack-overflow" aria-hidden="true"></i>Stock Transfer
    </h2>
    <div class="panel panel-default">
        <div class="col-md-12">
            <div class="clearfix">
            </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="upnl" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnl" runat="server">
                        <ProgressTemplate>
                            <img alt="Wait...." style="position: absolute; padding-left: 150px; padding-top: 50;
                                margin-top: 50px;" src="../images/loading.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <div class="printdiv">
                        <div style="overflow: auto;">
                            <table style="width: 100%;" class="withclass">
                                <tr>
                                    <td style="text-align: left; width: 10%; vertical-align: top;">
                                        <asp:Image ID="imgLogo" CssClass="logodiplay" runat="server" Width="80%" />
                                    </td>
                                    <td style="width: 50%; vertical-align: top;">
                                        <h2>
                                            <asp:Label ID="lblComName" runat="server" CssClass="websiteName"></asp:Label></h2>
                                        <asp:Label ID="lblLeftHead" runat="server" CssClass="companyName"></asp:Label>
                                    </td>
                                    <td style="vertical-align: top; width: 40%">
                                        <table style="width: 100%;">
                                            <caption>
                                                <br />
                                                <tr style="display: none">
                                                    <td style="text-align: right; font-weight: bold;">
                                                        Invoice Number :
                                                    </td>
                                                    <td style="text-align: left;">
                                                        <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                                                        <asp:Label ID="lblOrderNO" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; font-weight: bold;">
                                                        Invoice Date :
                                                    </td>
                                                    <td style="text-align: left;">
                                                        <asp:Label ID="lblRightHead" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; font-weight: bold;">
                                                        GST No. :
                                                    </td>
                                                    <td style="text-align: left;">
                                                        <asp:Label ID="lblGST" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; font-weight: bold;">
                                                        PAN No. :
                                                    </td>
                                                    <td style="text-align: left;">
                                                        <asp:Label ID="lblpan" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; font-weight: bold;">
                                                        CIN No. :
                                                    </td>
                                                    <td style="text-align: left;">
                                                        <asp:Label ID="lblcinno" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </caption>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <hr />
                        <div class="clearfix">
                        </div>
                        <div class="col-md-3">
                            <label>
                                <span class="companyName useriddisply">Franchise Id:&nbsp;<asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId" Display="Dynamic"
                                    ErrorMessage="Enter Franchise Id." SetFocusOnError="true" ValidationGroup="g"></asp:RequiredFieldValidator></span></label>
                            <asp:TextBox ID="txtUserId" ValidationGroup="g" runat="server" CausesValidation="true"
                                CssClass="form-control" AutoPostBack="true" onblur="return CallVal(this);" TabIndex="1"
                                OnTextChanged="txtUserId_TextChanged"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label>
                                Distributor Mode
                            </label>
                            <asp:DropDownList ID="ddldistrimode" runat="server" CssClass="form-control" AutoPostBack="true"
                                OnSelectedIndexChanged="ddldistrimode_SelectedIndexChanged">
                                <asp:ListItem Value="1">Stock Transfer</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label>
                            </label>
                            <asp:Label ID="lblToAdd" runat="server"></asp:Label></div>
                        <div class="clearfix">
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtUserName" CssClass="form-control" Enabled="false" BorderStyle="None"
                                Style="background-color: Transparent; color: Black;" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtUserDisp" CssClass="form-control" Visible="false" Enabled="false"
                                Style="border-style: none; background-color: Transparent; color: Black;" runat="server"></asp:TextBox>
                        </div>
                        <div class="clearfix">
                        </div>
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
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                        <div class="clearfix">
                        </div>
                        <div id="divbind" runat="server">
                            <div style="overflow: scroll">
                                <asp:GridView ID="GridView1" CssClass="table table-striped table-hover" Style="width: 100%;"
                                    DataKeyNames="id" BorderStyle="Dashed" BorderColor="Black" BorderWidth="1" ShowFooter="true"
                                    AutoGenerateColumns="False" runat="server" OnRowDeleting="GridView1_RowDeleting"
                                    OnRowDataBound="GridView1_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField ControlStyle-Width="40px" ControlStyle-CssClass="border_leert"
                                            HeaderText="SrNo.">
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
                                                <asp:TextBox ID="txtcode" Text='<%#Eval("cd") %>' Width="80" runat="server" CssClass="form-control"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Product Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                            HeaderStyle-Width="190px">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" Text='<%#Eval("pname") %>' ID="txtProductNAme" CausesValidation="True"
                                                    CssClass="form-control" ValidationGroup="ad"></asp:TextBox>
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
                                                    runat="server"></asp:TextBox>
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
                                                    runat="server" CssClass="form-control"></asp:TextBox>
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
                                        <asp:TemplateField HeaderText="GST" ControlStyle-Width="80" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTaxRs" Text='<%#string.Format("{0:#0.00}",Eval("TaxRs")) %>'
                                                    Style="text-align: right" BackColor="Transparent" Enabled="false" BorderStyle="None"
                                                    runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle />
                                            <FooterTemplate>
                                                <asp:Label ID="lblTaxRsTtotal" runat="server"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:TemplateField HeaderText="DP " ControlStyle-CssClass="hide_class" HeaderStyle-CssClass="hide_class"
                                            FooterStyle-CssClass="hide_class" ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtDP" Text='<%#string.Format("{0:#0.00}", Eval("DP")) %>' Style="text-align: right"
                                                    BackColor="Transparent" Enabled="false" BorderStyle="None" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="border_leert hide_class" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblDPTtotal" runat="server"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="BV " ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtBV" Text='<%#String.Format("{0:#0.00}", Eval("BV")) %>' Style="text-align: right"
                                                    BackColor="Transparent" Enabled="false" BorderStyle="None" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="border_leert" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblBVtotal" runat="server"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total" ControlStyle-Width="75" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
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
                                        <asp:TemplateField HeaderText="m allow " ControlStyle-Width="50" HeaderStyle-CssClass="rrr"
                                            ItemStyle-CssClass="rrr" FooterStyle-CssClass="rrr">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtMax" Text='<%# Eval("MaxAllowed") %>' Style="text-align: right;"
                                                    BackColor="Transparent" Enabled="false" BorderStyle="None" ForeColor="Black"
                                                    runat="server"></asp:TextBox>
                                                <span style="color: Red;"></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="s qty " ControlStyle-Width="50" HeaderStyle-CssClass="rrr"
                                            ItemStyle-CssClass="rrr" FooterStyle-CssClass="rrr">
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
                                                    ImageUrl="images/Delete.jpg" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="border_leert hide_class" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                            <table style="width: 100%; background-color: White;">
                                <tr>
                                    <td>
                                        <div id="divOffer" runat="server">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table id="tblbank" style="float: right; margin-right: 5%;">
                                            <tr>
                                                <td colspan="2">
                                                    Payments:
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border-top: dashed 1px #000; border-bottom: dashed 1px #000;">
                                                    S.No.
                                                </td>
                                                <td style="border-top: dashed 1px #000; border-bottom: dashed 1px #000;">
                                                    Mode
                                                </td>
                                                <td style="border-top: dashed 1px #000; border-bottom: dashed 1px #000;">
                                                    Amount
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    1.
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="selectbox" onchange="run();">
                                                        <asp:ListItem>Cash</asp:ListItem>
                                                        <asp:ListItem>Cheque</asp:ListItem>
                                                        <asp:ListItem>Net Banking</asp:ListItem>
                                                        <asp:ListItem>DD</asp:ListItem>
                                                        <asp:ListItem>Wallet</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    &nbsp;<asp:Label ID="lblAmt" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="trbank" runat="server" style="display: none;">
                                                <td>
                                                    Bank Name<br />
                                                    <asp:TextBox ID="txtbname" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    DD/Cheque/Transaction No<br />
                                                    <asp:TextBox ID="txtDD" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Date<br />
                                                    <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right" style="border-top: dashed 1px #000;">
                                                    Total: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="lblTotalPy" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="totalnet">
                                            <table style="width: 100%; border-top: dashed 1px #000;">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <table>
                                                            <tr id='trWallet'>
                                                                <td>
                                                                    <asp:Label ID="lblwallettxt" runat="server" Text="User wallet Balance :"></asp:Label>
                                                                </td>
                                                                <td style="text-align: right">
                                                                    <asp:Label ID="lbl_UserWalletBalance" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
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
                                                                    <asp:TextBox ID="txtTax" runat="server" Style="background-color: Transparent; text-align: right;
                                                                        border-style: none;"></asp:TextBox>
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
                                                                    <asp:TextBox ID="txtNetAmt" runat="server" ReadOnly="true" BorderStyle="None" Style="text-align: right;
                                                                        width: 80px;" ValidationGroup="g"></asp:TextBox>
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
                                                    <td style="width: 40%;">
                                                        <b>GST Summary:</b>
                                                        <table style="width: 80%;">
                                                            <tr>
                                                                <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                                                    <asp:Label ID="lbltaxamt" runat="server"></asp:Label>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td colspan="2">
                                                                    <div id="divcoupon" class="form-group" runat="server">
                                                                        <div class="col-md-12 input-group">
                                                                            <div class="input-group">
                                                                                <asp:TextBox ID="txt_Coupon" runat="server" class="form-control" placeholder="Enter Voucher Code"
                                                                                    onclick="CouponApply();"></asp:TextBox>
                                                                                <div class="input-group-btn">
                                                                                    <button type="button" id="btnReset" class="btn btn-default" onclick="Reset()" style="background-color: #ececec;
                                                                                        display: none;">
                                                                                        <i class=" fa fa-times" style="color: #f00; font-size: 20px;"></i>
                                                                                    </button>
                                                                                    &nbsp;&nbsp;
                                                                                    <button type="button" id="btncoupon" class="btn btn-success" onclick="CouponApply();">
                                                                                        <span class="fa fa-edit"></span>Apply</button>
                                                                                </div>
                                                                            </div>
                                                                            <div class=" input-group-btn">
                                                                                <span class="fa-fa-edit"></span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <span id="lblmsgcoupon"></span>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    <br />
                                                                    <asp:Button ID="btnGenerateBill" runat="server" CssClass="btn btn-success" OnClick="btnGenerateBill_Click"
                                                                        Text="Generate Bill" ValidationGroup="g" OnClientClick="javascript:return Validation()" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table style="width: 100%; border-top: dashed 1px #000; border-bottom: dashed 1px #000;">
                                            <tr>
                                                <td style="text-align: left; width: 70%;" class="boder_righ">
                                                    <span class="term_condition"><b>Terms & Conditions</b>
                                                        <ol type="1">
                                                            <%--<li>All Disputes are subject to jurisdiction of delhi only.</li>--%>
                                                            <li>Goods once sold will not be taken back.</li>
                                                            <li>Warranty will be under taken by the manufacturer only.</li>
                                                            <li>All disputes are subject to
                                                                <asp:Label ID="lblCityDisplay" runat="server"></asp:Label>
                                                                jurisdiction.</li>
                                                            <li>Company is not responsible after the goods leave the premises.</li>
                                                            <li>Any inaccuracy in this bill must be notified immediately on its receipt.</li>
                                                            <li>This is a computer generated invoice. No signature required.</li>
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
                                                        Prepared By<asp:Label ID="lblp" runat="server"></asp:Label>
                                                    </span>
                                                        <asp:Button ID="nextbill" Visible="false" runat="server" Text="Next Bill" CssClass="btn btn-success hide_class"
                                                            PostBackUrl="TranStock.aspx" OnClick="nextbill_Click" />
                                                    </b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <center>
                                <div style="width: 100%; float: left; margin-top: 20px;">
                                    <asp:Label Text="" ID="lblBillFooter" runat="server"></asp:Label>
                                </div>
                            </center>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="clearfix">
        </div>
    </div>
    <%--</div>--%>
    <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function Reset() {
            $('#<%=txtUserId.ClientID %>').val('');
            $('#<%=txtUserName.ClientID %>').val('');
        }

        function Validation() {
            var MSG = "";
            if ($('#<%=txtUserId.ClientID%>').val() == "") {
                MSG += "\n Please Enter UserId.!";
                $('#<%=txtUserId.ClientID%>').focus();
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (confirm('Are you sure you want to proceed？')) {
                return true;
            } else {
                return false;
            }

        }
    </script>
</asp:Content>
