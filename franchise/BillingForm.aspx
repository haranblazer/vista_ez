<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="BillingForm.aspx.cs" Inherits="d2000admin_BillingFrom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-1.4.2.js"></script>
    <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />
    <link rel="stylesheet" href="../css/jquery.autocomplete.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
    <style>
        .rrr
        {
            display: none;
        }
        td, th
        {
            padding: 5px 5px;
            border-color: #ddd;
            font-size: 13px;</style>
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
                var ProductId = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("input:text").val();


                if (parseInt(qnt) <= parseInt(SQTY)) {
                    if (parseInt(qnt) <= parseInt(MaxAllowed)) {

                        if (ProductId != '0' && ProductId != '')
                            GetFreeProduct();
                        
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
                        $('#<%=lblAmt.ClientID %>').val(parseFloat(NetTot).toFixed(2));
                        $('#<%=lblTotalPy.ClientID %>').val(parseFloat(NetTot).toFixed(2));
                        $('#<%=lblTotalBV.ClientID%>').text(parseFloat(TBV).toFixed(2));
                        $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(gross).toFixed(2));
                        $('#<%=txtDiscount.ClientID %>').val(0);
                        $('#<%=hfNetTotal.ClientID %>').val(parseFloat(NetTot).toFixed(2));

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
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(11)").find("input:text").val(parseFloat($(this).find("td:eq(5)").text()));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("input:text").val(parseFloat($(this).find("td:eq(6)").text()));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(12)").find("input:text").val(parseFloat($(this).find("td:eq(7)").text()));
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(13)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));
                            isExists = 1;
                            //alert(isExists);
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
                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(13)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));
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
                $('#lblAmt').val(netAmt.toFixed(2));
                $('#lblTotalPy').val(netAmt.toFixed(2));
            }


            /*Offer Product Details*/
            function GetFreeProduct() {
                var ProductList = "";
                $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").each(function () {
                    var ProductId = $(this).find('td:eq(1)').find("input:text").val();
                    var Qty = $(this).find('td:eq(4)').find("input:text").val();
                    if (ProductId != "0") {
                        if ((Qty != '' && Qty != '0')) {
                            ProductList = ProductList + ProductId + '^' + Qty + ",";
                            ProductId = "0";
                        }
                    }
                });

                if (ProductList != "") {
                    $.ajax({
                        type: "POST",
                        url: 'BillingForm.aspx/GetOfferProduct',
                        data: '{ProductList: "' + ProductList + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.length > 0) {
                                $('#FreeList').empty().append("");

                                var tblContent = "<h5 class='head' style='text-align:center; margin-bottom: -2px;'><i aria-hidden='true'></i>&nbsp; Offer products </H5>";
                                tblContent += "<table style='width: 100%; border-collapse: collapse;'>";
                                tblContent += "<thead ><tr><th style='text-align:left;'>SNo.</th>  <th style='text-align:left;'>Scheme</th> <th style='text-align:left;'>Product Id</th><th style='text-align:left;'>Product Name</th> <th>Quantity</th> </tr></thead>";
                                tblContent += '<tbody>';
                                for (var i = 0; i < data.d.length; i++) {
                                    tblContent += '<tr style="border-bottom:hidden; text-align:left; font-size: 15px; Height:15px;">';
                                    tblContent += '<td>' + (i + 1) + '</td>';
                                    tblContent += '<td>' + data.d[i].Scheme + '</td>';
                                    tblContent += '<td>' + data.d[i].Pid + '</td>';
                                    tblContent += '<td>' + data.d[i].ProductName + '</td>';
                                    tblContent += '<td style="text-align:center;">' + data.d[i].OfferQty + '</td>';
                                    tblContent += '</tr>';
                                    /*public int ID { get; set; }
                                    public int OfferID { get; set; }
                                    public int Pid { get; set; }
                                    
                                    public string ProductName { get; set; }
                                    public double Rs { get; set; }
                                    public int OfferQty { get; set; }
                                    public int batchid { get; set; }
                                    */
                                }
                                tblContent += '</tbody> </table> ';
                                $('#FreeList').empty().append(tblContent);
                            }
                            else
                            { $('#FreeList').empty().append(""); }
                        },
                        error: function (response) {
                            $('#FreeList').empty().append("");
                        }
                    });
                }
                else
                { $('#FreeList').empty().append(""); }


            }
        </script>
        <asp:HiddenField ID="hfCouponapplied" runat="server" Value="0" />
        <asp:HiddenField ID="hfNetTotal" runat="server" Value="0" />
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
                <div class="col-sm-11 pull-left" style="display: none;">
                    <button onclick="myFunction()" class="hide_class" style="float: right">
                        Print this Bill</button>
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
                    <h2 class="head">
                        <i class="fa fa-check-square-o" aria-hidden="true"></i>Billing Form
                    </h2>
                    <div class="form-group">
                        <div id="tblBillHeader">
                            <div class="col-sm-2" style="display: none;">
                                <label class="control-label">
                                    Distributor Type
                                </label>
                                <asp:DropDownList ID="ddldistributor" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <label class="control-label">
                                    Distributor Mode
                                </label>
                                <asp:DropDownList ID="ddlsubdistributor" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="1">Package</asp:ListItem>
                                    <%--  <asp:ListItem Value="2">Upgrade</asp:ListItem>
                                        <asp:ListItem Value="3">Repurchase</asp:ListItem>
                                    <asp:ListItem Value="4">Free Sample</asp:ListItem>--%>
                                </asp:DropDownList>
                            </div>
                            <div id="divWalletType" class="col-sm-2" style="display: none;">
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
                                <label>
                                    Personal Point</label>
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
                                <label class="control-label">
                                    User Id
                                </label>
                                <asp:TextBox ID="txtUserId" ValidationGroup="g" runat="server" CssClass="form-control"
                                    AutoPostBack="true" CausesValidation="true" onblur="return CallVal(this);" TabIndex="1"
                                    OnTextChanged="txtUserId_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId"
                                    Display="Dynamic" ErrorMessage="Enter user id." SetFocusOnError="true" ValidationGroup="g"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtUserDisp" Enabled="false" Style="border-style: none; background-color: Transparent;
                                    color: Black;" runat="server"></asp:TextBox>
                                <asp:TextBox ID="txtUserName" Enabled="false" Style="border-style: none; background-color: Transparent;
                                    color: Black;" Width="300" runat="server" MaxLength="30"></asp:TextBox>
                                <asp:Label ID="lblToAdd" runat="server" Visible="false"></asp:Label>
                            </div>
                            <div class="col-sm-2">
                                <label class="control-label">
                                    Franchise Type
                                </label>
                                <asp:DropDownList ID="ddl_BillBy" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0" Selected="True">Self</asp:ListItem>
                                    <asp:ListItem Value="1">Off line Franchise</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <label class="control-label">
                                    Franchise Id
                                </label>
                                <asp:TextBox ID="txt_distributor" runat="server" MaxLength="30" Style="background-color: Transparent;"
                                    onblur="return GetDistributorName();" CssClass="form-control"></asp:TextBox>
                                <span id="lbl_distName"></span>
                            </div>
                            <div class="col-sm-2">
                                <label>
                                    Place of Supply:</label>
                                <asp:DropDownList ID="ddlplaceofsupply" runat="server" CssClass="form-control">
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
                                                <br />
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
                                                <br />
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="col-xs-4">
                                                <label class="control-label">
                                                    State</label></div>
                                            <div class="col-xs-8">
                                                <asp:DropDownList ID="ddl_state" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                                <div class="clearfix">
                                                </div>
                                                <br />
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
                                                <br />
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="col-xs-4">
                                                <label class="control-label">
                                                    Billing Date
                                                </label>
                                                <asp:TextBox ID="txtbilldate" runat="server" placeholder="DD/MM/YYYY" AutoPostBack="true"
                                                    CssClass="form-control" OnTextChanged="txtbilldate_TextChanged"></asp:TextBox></div>
                                            <div class="col-xs-8">
                                                Party GST No.</label>
                                                <asp:TextBox ID="txtpartgstno" runat="server" CssClass="form-control"></asp:TextBox>
                                                <div class="clearfix">
                                                </div>
                                                <br />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                <div id="divBulkBuying" runat="server" style="display: none;">
                </div>
                <div class="clearfix">
                </div>
                <div id="divbind" runat="server">
                    <div style="overflow: scroll">
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
                                        <asp:TextBox ID="txtcode" Text='<%#Eval("cd") %>' runat="server" Width="80" Style="text-align: right"
                                            ValidationGroup="a" CssClass="form-control"></asp:TextBox>
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
                                <asp:TemplateField HeaderText="BV " ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
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
                        <div id="FreeList" style="width: 100%">
                        </div>
                    </div>
                    <hr />
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
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;<asp:TextBox ID="lblAmt" runat="server" ReadOnly="true" Style="text-align: right;
                                    width: 80px; border-style: none; background-color: transparent"></asp:TextBox>
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
                                <asp:TextBox ID="lblTotalPy" runat="server" ReadOnly="true" Style="text-align: right;
                                    width: 80px; border-style: none; background-color: transparent"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <div class="clearfix">
                    </div>
                    <div class="totalnet">
                        <div class="col-sm-6">
                            <table style="width: 100%; border-top: dashed 1px #000;">
                                <tr>
                                    <td style="width: 60%;">
                                        <table>
                                            <tr id='trWallet'>
                                                <td>
                                                    <asp:Label ID="lblwallettext" runat="server" Text="User wallet Balance :"></asp:Label>
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
                                                    <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtDiscount"
                                                                            Display="Dynamic" ErrorMessage="Invalid Entry of Discount." SetFocusOnError="true"
                                                                            ValidationExpression="^[0-9.]{1,5}$" ValidationGroup="g"></asp:RegularExpressionValidator>
                                                                        <asp:RangeValidator ID="RangeValidator3" runat="server" Type="Double" MinimumValue="0"
                                                                            MaximumValue="100" ControlToValidate="txtDiscount" Display="Dynamic" ErrorMessage="0"
                                                                            SetFocusOnError="true" ValidationGroup="g"></asp:RangeValidator>--%>
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
                                        </table>
                                        <b>
                                            <asp:Label ID="lblAmtWord" runat="server"></asp:Label></b>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm-4">
                            <table style="width: 100%; float: left; border-top: dashed 1px #000;">
                                <tr>
                                    <td style="width: 40%;">
                                        <b>Tax Summary:</b>
                                        <table style="width: 80%;">
                                            <tr>
                                                <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                                    GST %
                                                </td>
                                                <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                                    GST Amount
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style1">
                                                </td>
                                                <td class="style1">
                                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="clearfix">
                        </div>
                        <asp:Button ID="btnGenerateBill" runat="server" CssClass="btn btn-success" OnClick="btnGenerateBill_Click"
                            OnClientClick="javascript:return Validation()" Text="Generate Bill" ValidationGroup="g"
                            Style="float: right" />
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
                                    Prepared By<asp:Label ID="lblp" runat="server"></asp:Label>
                                </span>
                                    <br />
                                    <asp:Button ID="nextbill" runat="server" Text="Next Bill" CssClass="hide_class btn btn-success"
                                        PostBackUrl="BillingForm.aspx" OnClick="nextbill_Click" />
                                </b>
                            </td>
                        </tr>
                    </table>
                    <%--<button onclick="myFunction()" class="hide_class btn btn-success" style="float: right">
                        Print this Bill</button>--%>
                    <script type="text/javascript">
                        function myFunction() {
                            window.print();
                        }
                    </script>
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
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
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
            if ($('#<%=ddl_BillBy.ClientID%>').val() == "1") {
                if ($('#<%=txt_distributor.ClientID%>').val() == "") {
                    MSG += "\n Please Enter Distributor-Id.!";
                    $('#<%=txt_distributor.ClientID%>').focus();
                }
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

        function GetDistributorName() {
            $('#lbl_distName').css('color', 'red');
            if ($('#<%=txt_distributor.ClientID%>').val() != "") {
                var Name = $('#<%=txt_distributor.ClientID%>').val();
                $.ajax({
                    type: "POST",
                    url: 'BillingForm.aspx/GetDistName',
                    data: '{UserId: "' + Name + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d != '') {
                            $('#lbl_distName').text(response.d);
                            $('#lbl_distName').css('color', 'green');
                            return true;
                        }
                        else {
                            $('#lbl_distName').text("Invalid Distributor ID.!");
                            return false;
                        }
                    },
                    error: function (response) {
                        $('#lbl_distName').text("Invalid Distributor ID.!");
                        return false;
                    }
                });
            }
            else {
                $('#lbl_distName').text("");
                return false;
            }
        }
    </script>
</asp:Content>
