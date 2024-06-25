<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="BillingForm.aspx.cs" Inherits="BillingFrom" %>

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

        function Setcouriercharge() {
            if ($("#<%=drpDeliCharge.ClientID%>").val() == '0')
                $("#<%=txtDelChrg.ClientID%>").val('0');
            else
                $("#<%=txtDelChrg.ClientID%>").val('100');
        }

        function run() {
            var ddlReport = document.getElementById("<%=ddlpaytype.ClientID%>");
            var Text = ddlReport.options[ddlReport.selectedIndex].text;
            var Table = document.getElementById('tblbank').rows[3].id
            if (Text.localeCompare("Cash") == 0) {
                document.getElementById(Table).style.display = 'none'
                $('#divWalletType').hide();
            }
            else if (Text.localeCompare("Wallet") == 0) {
                document.getElementById(Table).style.display = 'none'
            }
            else {
                document.getElementById(Table).style.display = 'block'
                $('#divWalletType').hide();
            }
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
                //                var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
                //                $('#<%=txtUserId.ClientID %>').autocomplete(dataUserID);
            });
        });
        function IsNumeric(input) {
            return (input - 0) == input && ('' + input).replace(/^\s+|\s+$/g, "").length > 0;
        }

        function calculate(rowindex, txt) {

            //to get textbox value use val()
            //--------------------*************************************************************************************
            var qnt = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(4)").find("input:text").val();
            var items = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("input:text").val();
            var MaxAllowed = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(11)").find("input:text").val();
            var SQTY = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(12)").find("input:text").val();

            if (parseInt(qnt) <= parseInt(SQTY)) {
                if (parseInt(qnt) <= parseInt(MaxAllowed)) {



                    var gbvamt = $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(13)").find("input:text").val();
                    gbvamt = isNaN(gbvamt) ? 0 : gbvamt;

                    var totalgbv = (gbvamt * qnt);

                    $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(9)").find("input:text").val(totalgbv.toFixed(2));

                    var TaxPer = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(7)").find("input:text").val();
                    TaxPer = isNaN(TaxPer) ? 0 : TaxPer;
                    qnt = isNaN(qnt) ? 0 : qnt;

                    var mrp = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val();
                    mrp = isNaN(mrp) ? 0 : mrp;
                    var total = (mrp * qnt);
                    var dis = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(5)").find("input:text").val();

                    if (dis > (mrp * qnt)) {
                        alert("Discouted value not valid.");
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(5)").find("input:text").val(0);
                        return;
                    }

                    total = total - dis;
                    $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(6)").text(total.toFixed(2));

                    var TaxInRs = (total * TaxPer / 100);
                    $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(8)").find("input:text").val(TaxInRs.toFixed(2));
                    total = Math.round(total + TaxInRs);

                    $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(10)").find("input:text").val(total.toFixed(2));

                    var TBV = 0;
                    var gross = 0;
                    var NetTot = 0;
                    var tottax = 0;
                    //tr:gt(0) skips the header and footer row while sum the value
                    $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").each(function () {


                        var d = $(this).find('td:eq(5)').find("input:text").val();
                        var d1 = parseFloat((d == '' || d == null || isNaN(parseFloat(d))) ? 0 : d);
                        var temp = $(this).find('td:eq(4)').find("input:text").val();
                        var qntt = parseInt((temp == '' || temp == null || isNaN(parseInt(temp))) ? 0 : temp);
                        var temp1 = $(this).find('td:eq(9)').find("input:text").val();
                        var bv = parseFloat((temp1 == '' || temp1 == null || isNaN(parseFloat(temp1))) ? 0 : temp1);
                        var temp2 = $(this).find('td:eq(8)').find("input:text").val();
                        // alert(temp2);
                        var tax = parseFloat((temp2 == '' || temp2 == null || isNaN(parseFloat(temp2))) ? 0 : temp2);
                        //TBV += qntt * bv;
                        TBV += bv;
                        tottax += tax;
                        var Dpp = $(this).find('td:eq(3)').find("input:text").val();
                        var DppAmt = parseFloat((Dpp == '' || Dpp == null || isNaN(parseFloat(Dpp))) ? 0 : Dpp);
                        gross += qntt * DppAmt - d1;

                    });
                    NetTot = gross + tottax;
                    NetTot = Math.round(NetTot);
                    $('#<%=txtTax.ClientID %>').val(parseFloat(tottax).toFixed(2));
                    $('#<%=txtNetAmt.ClientID %>').val(parseFloat(NetTot).toFixed(2));

                    $('#<%=hfNetTotal.ClientID %>').val(parseFloat(NetTot).toFixed(2));


                    $('#<%=lblTotalBV.ClientID%>').text(parseFloat(TBV).toFixed(2));
                    $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(gross).toFixed(2));
                    $('#<%=txtDiscount.ClientID %>').val(0);
                    //BulkBuying(NetTot);

                    // myf(qnt, items);
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
                        //set MRP
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val(parseFloat($(this).find("td:eq(3)").text()).toFixed(2));
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(7)").find("input:text").val(parseFloat($(this).find("td:eq(2)").text()).toFixed(2));
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(9)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));
                        $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(13)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));
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
    <asp:HiddenField ID="hfCouponapplied" runat="server" Value="0" />
    <asp:HiddenField ID="hfNetTotal" runat="server" Value="0" />
    <h3 class="head">
        <i class="fa fa-file-text" aria-hidden="true"></i>Billing Form
    </h3>
    <div class="panel panel-default">
        <div class="col-md-12">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="upnl" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnl" runat="server">
                        <ProgressTemplate>
                            <img alt="Please Wait....." style="position: absolute; padding-left: 150px; padding-top: 0;
                                z-index: 99999; margin-top: 50px;" src="../images/loading.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <div class="printdiv">
                        <div class="clearfix">
                        </div>
                        <div class="form-group" style="padding-top: 5px;">
                            <div>
                                <div class="col-sm-2">
                                    <label>
                                        Distributor</label>
                                    <asp:DropDownList ID="ddltype" runat="server" AutoPostBack="true" CssClass="form-control"
                                        TabIndex="1" OnSelectedIndexChanged="ddltype_SelectedIndexChanged">
                                        <asp:ListItem Value="1">Package</asp:ListItem>
                                       <%-- <asp:ListItem Value="2">Upgrade</asp:ListItem>
                                         <asp:ListItem Value="3">Repurchase</asp:ListItem>
                                        <asp:ListItem Value="4">Free Sample</asp:ListItem>--%>
                                    </asp:DropDownList>
                                    <%--   <asp:TextBox ID="txtUserDisp" Enabled="false"  Style="border-style: none; background-color: Transparent;
                                   color: Black;" runat="server"></asp:TextBox>--%>
                                </div>
                                <div id="divWalletType" class="col-sm-2">
                                    <label class="control-label">
                                        Wallet Type
                                    </label>
                                    <asp:DropDownList ID="ddlWalletType" runat="server" CssClass="form-control" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlWalletType_SelectedIndexChanged">
                                        <asp:ListItem Value="BankTran">User Wallet</asp:ListItem>
                                        <asp:ListItem Value="PTran80">Payout Wallet</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtBal" Style="border-style: none; background-color: Transparent;
                                        color: Black;" Width="300" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <label>Personal Point</label>
                                    <asp:DropDownList ID="ddl_PointType" runat="server" CssClass="form-control">
                                      <asp:ListItem Value="0">Select</asp:ListItem>
                                        <asp:ListItem Value="1">Left side</asp:ListItem>
                                        <asp:ListItem Value="2">Right side</asp:ListItem>
                                        <asp:ListItem Value="3">50:50</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="TextBox1" Style="border-style: none; background-color: Transparent;
                                        color: Black;" Width="300" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <label>
                                        User Id &nbsp;
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId"
                                            Display="Dynamic" ErrorMessage="Enter userid." SetFocusOnError="true" ValidationGroup="g"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox ID="txtUserId" ValidationGroup="g" runat="server" AutoPostBack="true"
                                        CausesValidation="true" CssClass="form-control" onblur="return CallVal(this);"
                                        TabIndex="3" OnTextChanged="txtUserId_TextChanged"></asp:TextBox>
                                    <asp:TextBox ID="txtUserName" Enabled="false" Style="border-style: none; background-color: Transparent;
                                        color: Black;" Width="300" runat="server"></asp:TextBox>
                                    <asp:Label ID="lblToAdd" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-2">
                                    <label>
                                        Party GST No.</label>
                                    <asp:TextBox ID="txtpartgstno" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <label>
                                        Place of Supply</label>
                                    <asp:DropDownList ID="ddlplaceofsupply" runat="server" AppendDataBoundItems="true"
                                        CssClass="form-control">
                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse1"><font style="font-weight: bold;">Shipping
                                            Details</font> <span class="fa fa-plus pull-right"></span></a>
                                    </h5>
                                </div>
                                <div id="collapse1" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="col-xs-4">
                                                    <label class="control-label">
                                                        Name
                                                    </label>
                                                </div>
                                                <div class="col-xs-8">
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Your Name"></asp:TextBox>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="col-xs-4">
                                                    <label class="control-label">
                                                        Address</label></div>
                                                <div class="col-xs-8">
                                                    <asp:TextBox ID="txtaddress" TextMode="MultiLine" runat="server" Rows="2" placeholder="Enter Your Address "
                                                        CssClass="form-control"></asp:TextBox>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="col-xs-4">
                                                    <label class="control-label">
                                                        State</label></div>
                                                <div class="col-xs-8">
                                                    <asp:DropDownList ID="ddl_state" runat="server" AppendDataBoundItems="true" CssClass="form-control">
                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="col-xs-4">
                                                    <label class="control-label">
                                                        City</label></div>
                                                <div class="col-xs-8">
                                                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Enter Your City"></asp:TextBox></div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="col-xs-4">
                                                    <label class="control-label">
                                                        Pincode</label></div>
                                                <div class="col-xs-8">
                                                    <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control" placeholder="Enter Your Pincode"></asp:TextBox>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="col-xs-4">
                                                    <label class="control-label">
                                                        Billing Date</label></div>
                                                <div class="col-xs-8">
                                                    <asp:TextBox ID="txtbilldate" runat="server" placeholder="DD/MM/YYYY" AutoPostBack="true"
                                                        CssClass="form-control" OnTextChanged="txtbilldate_TextChanged"></asp:TextBox>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix">
                                </div>
                            </div>
                        </div>
                        <div id="divProduct" style="display: none;" runat="server">
                        </div>
                        <div id="divProductCode" style="display: none;" runat="server">
                        </div>
                        <div id="divUserID" style="display: none;" runat="server">
                        </div>
                        <div id="divMRP" runat="server" style="display: none;">
                        </div>
                        <div id="divBulkBuying" runat="server" style="display: none;">
                        </div>
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                        <div class="clearfix">
                        </div>
                       
                        <div id="divbind" runat="server">
                            <div style="overflow: scroll">
                                <asp:GridView ID="GridView1" Style="width: 100%;" DataKeyNames="id" CssClass="table table-striped table-hover"
                                    BorderStyle="Dashed" BorderColor="Black" BorderWidth="1" ShowFooter="true" AutoGenerateColumns="False"
                                    runat="server" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound="GridView1_RowDataBound">
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
                                                    runat="server" CssClass="form-control" Enabled="false" ></asp:TextBox>
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
                                        <asp:TemplateField HeaderText="BV " ControlStyle-Width="70" ItemStyle-HorizontalAlign="Right"
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
                                        <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Right" ControlStyle-Width="75"
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
                                        <asp:TemplateField HeaderStyle-CssClass="rrr" ItemStyle-CssClass="rrr" FooterStyle-CssClass="rrr">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txttotalbv" Text='<%# Eval("BV") %>' Style="text-align: right;"
                                                    BackColor="Transparent" BorderStyle="None" ForeColor="Black" runat="server"></asp:TextBox>
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
                            <hr />
                            <div class="col-md-5">
                                <table>
                                    <tr id='trWallet'>
                                        <td>
                                            <asp:Label ID="lblwallettext" runat="server" Text=""></asp:Label>
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
                                            <div class="col-md-5">
                                                <asp:DropDownList ID="drpDeliCharge" runat="server" Class="form-control" onchange="Setcouriercharge()">
                                                    <asp:ListItem runat="server" Value="0">Self PickUp</asp:ListItem>
                                                    <asp:ListItem runat="server" Value="1">Courier</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-5">
                                                <asp:TextBox ID="txtDelChrg" runat="server" Class="form-control" ToolTip="% of Total"
                                                    MaxLength="5" onblur="CalNetAmt('txtDelChrg','lblDelChrg');" Style="text-align: right"
                                                    ValidationGroup="g" Width="70px">0</asp:TextBox>
                                            </div>
                                            <asp:Label ID="lblDelChrg" runat="server"></asp:Label>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDelChrg"
                                                Display="Dynamic" ErrorMessage="Invalid Entry of Delivery Charge." SetFocusOnError="true"
                                                ValidationExpression="^[0-9.]{1,5}$" ValidationGroup="g"></asp:RegularExpressionValidator>
                                            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtDelChrg"
                                                Display="Dynamic" ErrorMessage="0" MaximumValue="100" MinimumValue="0" SetFocusOnError="true"
                                                Type="Double" ValidationGroup="g"></asp:RangeValidator>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td>
                                            Bulk Buying:
                                        </td>
                                        <td style="text-align: right">
                                            <asp:TextBox ID="txtDiscount" ToolTip="% of Total" onblur="CalNetAmt('txtDiscount','lblDiscount');"
                                                Width="50" Style="text-align: right" runat="server" MaxLength="5" ValidationGroup="g"
                                                ReadOnly="true"></asp:TextBox>
                                            <span class="companyName">
                                                <asp:Label ID="lblDiscount" runat="server" Style="display: none;"></asp:Label></span><br />
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <b>
                                                <asp:Label ID="lblAmtWord" runat="server"></asp:Label></b>
                                            <br />
                                            <br />
                                            <span>The scheme products at Rs.1 in the Invoice cannot be returned or exchanged</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-2">
                            </div>
                            <div class="col-md-5">
                                <table id="tblbank" style="width: 100%; float: right; margin-right: 5%;">
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Payment Mode
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="selectbox" onchange="run();">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr id="trbank" runat="server" style="display: none;">
                                        <td align="right">
                                            <table style="width: 100%; float: right;" align="right">
                                                <tr>
                                                    <td>
                                                        Bank Name
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtbname" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        DD/Cheque/Transaction No
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDD" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Date
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <br />
                                            <br />
                                            <asp:Button ID="btnGenerateBill" runat="server" CssClass="btn btn-success" OnClick="btnGenerateBill_Click"
                                               OnClientClick="javascript:return Validation()" Text="Generate Bill"
                                                ValidationGroup="g" /><br />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table style="width: 100%; border-top: dashed 1px #000; border-bottom: dashed 1px #000;">
                                <tr>
                                    <td style="text-align: left; width: 70%;" class="boder_righ">
                                        <span class="term_condition"><b>Terms & Conditions</b>
                                            <ol>
                                                <li>Goods Once Sold Will Not Be Taken Back.</li>
                                                <li>Warranty Will Be Under Taken By The Manufacturer Only.</li>
                                                <li>All Disputes Are Subject To
                                                    <asp:Label ID="lbladminadress" runat="server"></asp:Label>
                                                    Jurisdiction.</li>
                                                <li>Company Is Not Responsible After The Goods Leave The Premises.</li>
                                                <li>Any Inaccuracy In This Bill Must Be Notifided Immediately On Its Receipt.</li>
                                                <li>This is a computer generated invoice. No signature required.</li>
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
                                        </span>
                                            <br />
                                            <br />
                                            <br />
                                            <asp:Button ID="nextbill" runat="server" Text="Next Bill" CssClass="hide_class" PostBackUrl="BillingForm.aspx"
                                                OnClick="nextbill_Click" OnClientClick="javascript:return Validation()" />
                                        </b>
                                    </td>
                                </tr>
                            </table>
                            <center>
                                <div style="width: 100%; float: left; margin-top: 20px;">
                                    <asp:Label Text="" ID="lblCompanyAdd" runat="server"></asp:Label>
                                    <asp:Label Text="" ID="lblBillFooter" Visible="false" runat="server"></asp:Label>
                                </div>
                        </div>
                    </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="clearfix">
            </div>
        </div>
    </div>
    <%--  <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
    <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        

        function Validation() {
            var MSG = "";
            if ($('#<%=txtUserId.ClientID%>').val() == "") {
                MSG += "\n Please Enter UserId.!";
                $('#<%=txtUserId.ClientID%>').focus();
            }

            if ($('#<%=ddl_PointType.ClientID%>').val() == "0") {
                MSG += "\n Please Select Self Point.!";
                $('#<%=ddl_PointType.ClientID%>').focus();
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
