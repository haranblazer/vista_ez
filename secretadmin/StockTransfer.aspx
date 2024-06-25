﻿<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="StockTransfer.aspx.cs" Inherits="secretadmin_StockTransfer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <script src="../js/jquery-1.4.2.js"></script>
    <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />
  
    <link rel="stylesheet" href="../css/jquery.autocomplete.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
    <style>
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
            var ddlReport = document.getElementById("<%=ddlpaytype.ClientID%>");
            var Text = ddlReport.options[ddlReport.selectedIndex].text;

            var Table = document.getElementById('tblbank').rows[3].id
            if (Text.localeCompare("Cash") == 0) {
                document.getElementById(Table).style.display = 'none'
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
            debugger;
            Sys.Application.add_load(function () {
                $(document).ready(function () {
                    var data = document.getElementById("<%=divProduct.ClientID%>").innerHTML.split(",");
                    $('#<%=GridView1.ClientID %> tr:gt(0)').not("tr:last").find("td:eq(2)").find("input:text").each(function () {
                        $(this).autocomplete(data);
                    });
                    //user id auto complete
                    var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
                    $('#<%=txtUserId.ClientID %>').autocomplete(dataUserID);

                });
            });
            function IsNumeric(input) {
                return (input - 0) == input && ('' + input).replace(/^\s+|\s+$/g, "").length > 0;
            }
            function disable(a, quantity, items, t, a1) {
                var targetTable = document.getElementById('tblOffer');
                var targetTableColCount;
                var c = 0;
                var r = 1, s1 = 0, s2 = 0;
                var mr = "", p = "";
                var gross = document.getElementById("<%=lblGrossTotal.ClientID %>").innerHTML
                var bv = document.getElementById("<%=lblTotalBV.ClientID %>").innerHTML
                for (var rowIndex = 0; rowIndex < targetTable.rows.length; rowIndex++) {
                    //alert("my name is khan");
                    var rowData = '';
                    var quantity = 0;
                    var offertype = 0;
                    var pamt = 0.0;
                    p = "t" + (rowIndex + 1);
                    var targetTable1 = document.getElementById(p);

                    mr = "p" + (rowIndex + 1);

                    for (var rowI = 0; rowI < targetTable1.rows.length; rowI++) {

                        var row1 = targetTable1.rows[rowI];

                        if (mr == row1.id) {
                            rowData = targetTable1.rows.item(rowI).cells.item(c).textContent;
                            quantity = targetTable1.rows.item(rowI).cells.item(r).textContent;
                            offertype = targetTable1.rows.item(rowI).cells.item(2).textContent;
                            var q1 = parseInt(a);
                            var q2 = parseInt(quantity);
                            if (rowData.localeCompare(items) == 0 && q2 < q1 && t == 0 && offertype == 1) {
                                var row = targetTable.rows[rowIndex];
                                if ((document.getElementById(row.id).style.display == 'block')) {
                                    document.getElementById(row.id).style.display = 'none'
                                    a = 0;
                                }
                            }
                            if (IsNumeric(rowData)) {
                                var d = parseFloat(rowData);
                                if (d < a1 && t == 2 && offet == 2) {

                                    var row = targetTable.rows[rowIndex];
                                    if ((document.getElementById(row.id).style.display == 'block')) {
                                        document.getElementById(row.id).style.display = 'none'
                                    }
                                }
                                if (t == 3 && offertype == 3) {
                                    //                                    alert(a1);
                                    //alert(d);
                                    var row = targetTable.rows[rowIndex];

                                    if ((document.getElementById(row.id).style.display == 'block')) {
                                        if (d < a1) {

                                            document.getElementById(row.id).style.display = 'none'
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            function dis(a, items) {

            }

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

                        var d = $(this).find('td:eq(5)').find("input:text").val().trim();
                        var d1 = parseFloat((d == '' || d == null || isNaN(parseFloat(d))) ? 0 : d);
                        var temp = $(this).find('td:eq(4)').find("input:text").val().trim();
                        var qntt = parseInt((temp == '' || temp == null || isNaN(parseInt(temp))) ? 0 : temp);
                        var temp1 = $(this).find('td:eq(9)').find("input:text").val().trim();
                        var bv = parseFloat((temp1 == '' || temp1 == null || isNaN(parseFloat(temp1))) ? 0 : temp1);
                        TBV += qntt * bv;

                        var Dpp = $(this).find('td:eq(3)').find("input:text").val().trim();
                        var DppAmt = parseFloat((Dpp == '' || Dpp == null || isNaN(parseFloat(Dpp))) ? 0 : Dpp);
                        gross += qntt * DppAmt - d1;
                        Tgross += (DppAmt * qntt) * TaxPer / 100;
                        //alert(Tgross);
                    });

                    //                    alert(mrp);
                    //                   
                    //alert(qnt);


                    $('#<%=Label1.ClientID%>').text(parseFloat(Tgross).toFixed(2));
                    $('#<%=txtNetAmt.ClientID %>').val(parseFloat(Tgross + gross).toFixed(2));
                    $('#<%=txtTax.ClientID %>').val(parseFloat(Tgross).toFixed(2));
                    $('#<%=lblAmt.ClientID%>').text(parseFloat(Tgross + gross).toFixed(2));
                    //                    $('#<%=lblTotalBV.ClientID%>').text(parseFloat(TBV).toFixed(2));
                    $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(gross).toFixed(2));
                    myf(qnt, items);
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
            function myf(a, items) {

                if (a >= 0) {
                    var targetTable = document.getElementById('tblOffer');
                    var targetTableColCount;
                    var c = 0;
                    var r = 1, s1 = 0, s2 = 0;
                    var mr = "", p = "";
                    var gross = document.getElementById("<%=lblGrossTotal.ClientID %>").innerHTML
                    var bv = document.getElementById("<%=lblTotalBV.ClientID %>").innerHTML
                    for (var rowIndex = 0; rowIndex < targetTable.rows.length; rowIndex++) {
                        var rowData = '';
                        var quantity = 0;
                        var offertype = 0;
                        var pamt = 0.0;
                        p = "t" + (rowIndex + 1);

                        var targetTable1 = document.getElementById(p);

                        mr = "p" + (rowIndex + 1);

                        for (var rowI = 0; rowI < targetTable1.rows.length; rowI++) {

                            var row1 = targetTable1.rows[rowI];

                            if (mr == row1.id) {
                                rowData = targetTable1.rows.item(rowI).cells.item(c).textContent;
                                quantity = targetTable1.rows.item(rowI).cells.item(r).textContent;
                                offertype = targetTable1.rows.item(rowI).cells.item(2).textContent;
                                var q1 = parseInt(a);
                                var q2 = parseInt(quantity);
                                if (rowData.localeCompare(items) == 0 && q1 < q2) {
                                    var row = targetTable.rows[rowIndex];
                                    if ((document.getElementById(row.id).style.display == 'block')) {
                                        document.getElementById(row.id).style.display = 'none'
                                        a = 0;
                                    }
                                }
                                if (a > 0) {
                                    if (rowData.localeCompare(items) == 0 && q1 >= q2) {
                                        disable(q1, q2, items, 0, 0.0);
                                        var row = targetTable.rows[rowIndex];
                                        document.getElementById(row.id).style.display = 'block'
                                        var g = parseFloat(gross);
                                        g = g + parseFloat(pamt);
                                        $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(g).toFixed(2));
                                    }
                                }
                                if (IsNumeric(rowData)) {
                                    var d = parseFloat(rowData);
                                    if (gross < d && offertype == 2) {
                                        var row = targetTable.rows[rowIndex];
                                        if ((document.getElementById(row.id).style.display == 'block')) {
                                            document.getElementById(row.id).style.display = 'none'
                                        }
                                    }
                                    if (bv < d && offertype == 3) {
                                        var row = targetTable.rows[rowIndex];
                                        if ((document.getElementById(row.id).style.display == 'block')) {
                                            document.getElementById(row.id).style.display = 'none'
                                        }
                                    }
                                }
                                if (IsNumeric(rowData)) {
                                    var d = parseFloat(rowData);
                                    if (gross >= d && offertype == 2) {
                                        //                                        disable(q1, q2, items, 2, d);
                                        var row = targetTable.rows[rowIndex];
                                        document.getElementById(row.id).style.display = 'block'
                                        var g = parseFloat(gross);
                                        g = g + parseFloat(pamt);
                                        $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(g).toFixed(2));
                                    }
                                    if (bv >= d && offertype == 3) {

                                        //disable(q1, q2, items, 3, d);
                                        var row = targetTable.rows[rowIndex];
                                        document.getElementById(row.id).style.display = 'block'
                                        //alert(row.id);
                                        //                                        disable(q1, q2, items, 3, d);
                                        var g = parseFloat(gross);
                                        g = g + parseFloat(pamt);
                                        //disable(q1, q2, items, 3, d);
                                        $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(g).toFixed(2));

                                    }
                                }

                            } //if condtion

                        } //inner loop

                    } //outerloop

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
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="upnl" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnl" runat="server">
                    <ProgressTemplate>
                        <img alt="Wait...." style="position: absolute; padding-left: 150px; padding-top: 50; top: 98px; left: 311px;"
                            src="images/progress.gif" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <button onclick="myFunction()" class="btn btn-success hide_class" style="float: right" >
                    Print this Bill</button>
                <div class="printdiv">
                <br />
                <div class="style="overflow:auto;">
                    <table style="width: 100%;" class="withclass">
                        <tr>
                            <td style="text-align: left; width: 10%; vertical-align: top;">
                                <asp:Image ID="imgLogo" CssClass="logodiplay" runat="server" />
                            </td>
                            <td style="width: 50%; vertical-align: top;">
                                <h2>
                                    <asp:Label ID="lblComName" runat="server" CssClass="websiteName"></asp:Label></h2>
                                <asp:Label ID="lblLeftHead" runat="server" CssClass="companyName"></asp:Label>
                            </td>
                            <td style="vertical-align: top; width: 40%">
                                <table style="width: 100%;">
                                    <tr>
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
                                            TIN No. :
                                        </td>
                                        <td style="text-align: left;">
                                            <asp:Label ID="lbltinno" runat="server"></asp:Label>
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
                                </table>
                            </td>
                        </tr>
                    </table>
                    </div>
                    <div class="col-sm-12">
                    <hr />
                    </div>
                    <table style="width: 100%; text-align: left;" class="withclass">
                        <tr>
                            <td style="text-align: left;">
                                <span class="companyName useriddisply">Franchise Id:
                                    <asp:TextBox ID="txtUserId" ValidationGroup="g" runat="server" CausesValidation="true" CssClass="form-control"
                                        onblur="return CallVal(this);" TabIndex="1"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId"
                                        Display="Dynamic" ErrorMessage="Enter user id." SetFocusOnError="true" ValidationGroup="g"></asp:RequiredFieldValidator></span>

                                        
                                <asp:Label ID="lbltype" runat="server" >Select Type</asp:Label>
                    <asp:DropDownList ID="ddldistributor" runat="server" AutoPostBack="true" CssClass="form-control"
                                    onselectedindexchanged="ddldistributor_SelectedIndexChanged">
                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                    <asp:ListItem Value="1">VAT</asp:ListItem>
                                     <asp:ListItem Value="2">CST</asp:ListItem>
                                    </asp:DropDownList>


                                      <asp:Label ID="lblcst" runat="server" >Select CST</asp:Label>
                 <asp:DropDownList ID="ddlcst" runat="server" AutoPostBack="true" CssClass="form-control"
                                    onselectedindexchanged="ddlcst_SelectedIndexChanged" >
                                     <asp:ListItem Value="0">Select</asp:ListItem>                       
                                     <asp:ListItem Value="2">2</asp:ListItem>
                                      <asp:ListItem Value="5">5</asp:ListItem>
                                    </asp:DropDownList>


                            </td>
                            
                        </tr>
                        <tr id="tblBillHeader">
                            <td style="text-align: left; vertical-align: top; width: 50%;">
                                                                <asp:TextBox ID="txtUserDisp" Enabled="false" Style="border-style: none; background-color: Transparent;
                                    color: Black;" runat="server"></asp:TextBox><br />
                                <asp:TextBox ID="txtUserName" Enabled="false" Style="border-style: none; background-color: Transparent;
                                    color: Black;" Width="300" runat="server"></asp:TextBox>

                                     <br />
                                <asp:Label ID="lblPanNoF" runat="server" ></asp:Label>
                                 <br />
                                <asp:Label ID="lblTinNoF" runat="server" ></asp:Label>
                                <br />
                                <asp:Label ID="lblToAdd" runat="server"></asp:Label>
                                <br />
                                </span>
                            </td>
                            <td style="text-align: left; vertical-align: top; width: 50%;">
                                <span style="display: none">Delivery Address :</span>
                            </td>
                        </tr>
                    </table>
                    <%--this div is used to store the product names to bind through javascript while searching in textbox--%>
                    <div id="divProduct" style="display: none;" runat="server">
                    </div>
                    <%--this div is used to store the userid names to bind through javascript while searching in textbox--%>
                    <div id="divUserID" style="display: none;" runat="server">
                    </div>
                    <%--this div is used to store the product names and MRP to bind in grid--%>
                    <div id="divMRP" runat="server" style="display: none;">
                    </div>
                    <div class="style="overflow:auto;">
                    <table style="width: 100%; background-color: White;">
                        <tr>
                            <td style="text-align: center;">
                                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                <asp:GridView ID="GridView1" CssClass="printmygrd" Style="width: 100%;" DataKeyNames="id"
                                    BorderStyle="Dashed" BorderColor="Black" BorderWidth="1" ShowFooter="true" AutoGenerateColumns="False"
                                    runat="server" OnRowDeleting="GridView1_RowDeleting" 
                                    OnRowDataBound="GridView1_RowDataBound" 
                                    onselectedindexchanged="GridView1_SelectedIndexChanged">
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
                                                <asp:TextBox ID="txtcode" Text='<%#Eval("cd") %>' Width="50" Style="text-align: right"
                                                    ValidationGroup="a" Enabled="false" BorderStyle="None" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Product Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                            HeaderStyle-Width="294px">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" Text='<%#Eval("pname") %>' ID="txtProductNAme" CausesValidation="True"
                                                    ValidationGroup="ad"></asp:TextBox>
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
                                                    Style="text-align: right" ValidationGroup="a" runat="server"></asp:TextBox>
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
                                                    runat="server"></asp:TextBox>
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
                                        <asp:TemplateField HeaderText="Tax(%)" ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
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
                                        <asp:TemplateField HeaderText="Tax" 
                                             ControlStyle-Width="80" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTaxRs" Text='<%#string.Format("{0:#0.00}",Eval("TaxRs")) %>'
                                                    Style="text-align: right" BackColor="Transparent" Enabled="false" BorderStyle="None"
                                                    runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle />
                                            <FooterTemplate>
                                                <asp:Label ID="lblTaxRsTtotal" Font-Bold="true" runat="server" Visible="false"></asp:Label>
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
                                        <asp:TemplateField HeaderText="PV " ControlStyle-Width="50" ItemStyle-HorizontalAlign="Right"
                                           HeaderStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtBV" Text='<%#String.Format("{0:#0.00}", Eval("BV")) %>' Style="text-align: right"
                                                    BackColor="Transparent" Enabled="false" BorderStyle="None" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="border_leert" />
                                            <FooterTemplate >
                                                <asp:Label ID="lblBVtotal" runat="server" Visible="false"></asp:Label>
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
                                                    ImageUrl="images/Delete.jpg" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="border_leert hide_class" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
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
                                            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="selectbox" onchange="run();">
                                                        <asp:ListItem>Cash</asp:ListItem>
                                                        <asp:ListItem>Cheque</asp:ListItem>
                                                        <asp:ListItem>Net Banking</asp:ListItem>
                                                        <asp:ListItem>DD</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
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
                                                            Total Tax Amount :
                                                        </td>
                                                        <td style="text-align: right">
                                                            <asp:TextBox ID="txtTax" runat="server" Style="background-color: Transparent;
                                                                text-align: right; border-style: none;"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Total PV :
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
                                                            <asp:TextBox ID="txtNetAmt" runat="server" Style="text-align: right; width: 80px;"
                                                                ValidationGroup="g"></asp:TextBox>
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
                                                <b>Tax Summary:</b>
                                                <table style="width: 80%;">
                                                    <tr>
                                                        <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                                            <asp:Label ID="lbltaxamt" runat="server" ></asp:Label>    &nbsp;&nbsp;&nbsp;&nbsp;  <asp:Label ID="Label1" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                                           
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                          
                                                        </td>
                                                        <td>
                                                            
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Button ID="btnGenerateBill" runat="server" CssClass="btn btn-success" OnClick="btnGenerateBill_Click" Text="Generate Bill"
                                        ValidationGroup="g" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table style="width: 100%; border-top: dashed 1px #000; border-bottom: dashed 1px #000;">
                                    <tr>
                                        <td style="text-align: left; width: 70%;" class="boder_righ">
                                            <span class="term_condition"><b>Terms & Conditions</b>
                                                <ol>
                                                    <%--<li>All Disputes are subject to jurisdiction of delhi only.</li>--%>
                                                      <li>Goods Once Sold Will Not Be Taken Back.</li>
                                                      <li>Warranty Will Be Under Taken By The Manufacturer Only.</li>
                                                      <li>All Disputes Are Subject To Delhi Jurisdiction.</li>
                                                    <li>Company Is Not Responsible After The Goods Leave The Premises.</li>
                                                    <li>Any Inaccuracy In This Bill Must Be Notifided Immediately On Its Receipt.</li>
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
                                                <br />
                                                <br />
                                                <br />
                                                Prepared By<asp:Label ID="lblp" runat="server"></asp:Label>
                                            </span>
                                                
                                                <asp:Button ID="nextbill" runat="server" Text="Next Bill" CssClass="btn btn-success hide_class" PostBackUrl="TranStock.aspx"
                                                    OnClick="nextbill_Click" />
                                            </b>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    </div>
                    <button onclick="myFunction()" class="btn btn-success hide_class" style="float: right">
                        Print this Bill</button>
                    <script>
                        function myFunction() {
                            window.print();
                        }
                    </script>
                    <center>
                        <div style="width: 100%; float: left; margin-top: 20px;">
                            <asp:Label Text="" ID="lblBillFooter" runat="server"></asp:Label>
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
    </script>

</asp:Content>
