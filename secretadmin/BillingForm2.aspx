<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="BillingForm2.aspx.cs" Inherits="BillingFrom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <%-- <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />--%>
    <%--ragh<script src="../calendar/jquery.datetimepicker.full.min.js" type="text/javascript"></script> 
    <link href="../calendar/jquery.datetimepicker.min.css" rel="stylesheet" />
     <script type="text/javascript">
             $('#ctl00$ContentPlaceHolder1$txtbilldate').datetimepicker({

                 lang: 'ch',
                 timepicker: false,
                 format: 'd/m/Y',
                 formatDate: 'Y/m/d',
                 //  minDate: '-1970/01/02', // yesterday is minimum date
                 // maxDate: '+1970/01/02' // and tommorow is maximum date calendar
                 //ctl00_ContentPlaceHolder2_txtDate
             });

          </script>--%>
         <%-- <script type="text/javascript">
              $(function () {
                  jQuery.noConflict(true);
                  $('#<%= txtbilldate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
              });
    </script>--%>
   
    <style type="text/css">
        .rrr
        {
            display: none;
        }
    </style>  
    <script type="text/javascript">
        //        function CallVal(txt) {
        //            if (txt.value.length > 2)
        //                ServerSendValue(txt.value, "ctx");
        //        }
        function run() {
            $('#trWallet').hide();
            $('#trOTPGen').hide();
            document.getElementById("<%=btnGenerateBill.ClientID%>").disabled = false;
            var ddlReport = document.getElementById("<%=ddlpaytype.ClientID%>");
            var Text = ddlReport.options[ddlReport.selectedIndex].text;
            $('#trOTPGen').hide();

            var Table = document.getElementById('tblbank').rows[3].id
            if (Text.localeCompare("Cash") == 0) {
                document.getElementById(Table).style.display = 'none'
            }
            else if (Text.localeCompare("Wallet") == 0) {
                document.getElementById(Table).style.display = 'none'
                $('#trWallet').show();
                $('#trOTPGen').show();
                document.getElementById("<%=btnGenerateBill.ClientID%>").disabled = true;
            }
            else {
                document.getElementById(Table).style.display = 'block'
            }
        }

        //        function ServerResult(arg) {
        //            if (arg == "Required field cannot be blank !" || arg == "User Does Not Exists!") {
        //                document.getElementById("<%=txtUserName.ClientID%>").style.color = "Red";
        //                document.getElementById("<%=txtUserName.ClientID%>").value = arg;
        //                document.getElementById("<%=txtUserId.ClientID%>").focus();
        //            }
        //            else {
        //                document.getElementById("<%=txtUserName.ClientID%>").style.color = "Blue";
        //                document.getElementById("<%=txtUserName.ClientID%>").value = arg;

        //                document.getElementById("<%=txtUserName.ClientID%>").value = arg;

        //            }
        //        }
        //        function ClientErrorCallback() {
        //        }
    </script>
         
       
   
   <script type="text/javascript">
       //  debugger;
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
       function disable(a, quantity1, items1, t, a1) {
           var targetTable = document.getElementById('tblOffer');
           var targetTableColCount;
           var c = 0, ch = 0;
           var r = 1, s1 = 0, s2 = 0;
           var mr = "", p = "";
           var gross = document.getElementById("<%=txtNetAmt.ClientID %>").value;
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

                       if (rowData.localeCompare(items1) == 0 && offertype == 1) {
                           var row = targetTable.rows[rowIndex];
                           if ((document.getElementById(row.id).style.display == 'block')) {
                               //alert("enter");
                               if (quantity1 > q2) {
                                   ch = 1;
                                   document.getElementById(row.id).style.display = 'none'
                               }
                               else if (quantity1 < q2) {

                                   ch = 1;
                                   document.getElementById(row.id).style.display = 'block'
                               }
                           }
                           else if (q2 >= quantity1 && ch == 0 && q1 >= q2) {
                               //alert(q2);
                               document.getElementById(row.id).style.display = 'block'
                           }
                       }
                       if (IsNumeric(rowData)) {
                           var d = parseFloat(rowData);
                           if (t == 2 && offertype == 2) {

                               var row = targetTable.rows[rowIndex];
                               if ((document.getElementById(row.id).style.display == 'block')) {
                                   if (d < a1) {
                                       document.getElementById(row.id).style.display = 'none'
                                   }
                               }
                           }
                           if (t == 3 && offertype == 3) {
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


                       var d = $(this).find('td:eq(5)').find("input:text").val().trim();
                       var d1 = parseFloat((d == '' || d == null || isNaN(parseFloat(d))) ? 0 : d);
                       var temp = $(this).find('td:eq(4)').find("input:text").val().trim();
                       var qntt = parseInt((temp == '' || temp == null || isNaN(parseInt(temp))) ? 0 : temp);
                       var temp1 = $(this).find('td:eq(9)').find("input:text").val().trim();
                       var bv = parseFloat((temp1 == '' || temp1 == null || isNaN(parseFloat(temp1))) ? 0 : temp1);
                       var temp2 = $(this).find('td:eq(8)').find("input:text").val().trim();
                       // alert(temp2);
                       var tax = parseFloat((temp2 == '' || temp2 == null || isNaN(parseFloat(temp2))) ? 0 : temp2);
                       //TBV += qntt * bv;
                       TBV += bv;
                       tottax += tax;
                       var Dpp = $(this).find('td:eq(3)').find("input:text").val().trim();
                       var DppAmt = parseFloat((Dpp == '' || Dpp == null || isNaN(parseFloat(Dpp))) ? 0 : Dpp);
                       gross += qntt * DppAmt - d1;

                   });
                   NetTot = gross + tottax;
                   NetTot = Math.round(NetTot);
                   $('#<%=txtTax.ClientID %>').val(parseFloat(tottax).toFixed(2));
                   $('#<%=txtNetAmt.ClientID %>').val(parseFloat(NetTot).toFixed(2));
                   $('#<%=hfNetTotal.ClientID %>').val(parseFloat(NetTot).toFixed(2));
                   if ($('#<%=txt_Coupon.ClientID %>').val().trim() != "") {
                       CouponApply();
                   }

                   $('#<%=lblTotalBV.ClientID%>').text(parseFloat(TBV).toFixed(2));
                   $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(gross).toFixed(2));
                   $('#<%=txtDiscount.ClientID %>').val(0);
                   BulkBuying(NetTot);

                   myf(qnt, items);
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
       function myf(a, items) {

           if (a >= 0) {
               var targetTable = document.getElementById('tblOffer');
               var targetTableColCount;
               var c = 0;
               var r = 1, s1 = 0, s2 = 0;
               var mr = "", p = "";
               var gross = document.getElementById("<%=txtNetAmt.ClientID %>").value;

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
                           if (rowData.localeCompare(items) == 0 && q1 < q2 && offertype == 1) {
                               var row = targetTable.rows[rowIndex];
                               if ((document.getElementById(row.id).style.display == 'block')) {
                                   document.getElementById(row.id).style.display = 'none'
                                   //a = 0;
                               }
                           }
                           //                                alert(q1);
                           if (a > 0) {
                               if (rowData.localeCompare(items) == 0 && offertype == 1 && q1 >= q2) {

                                   var row = targetTable.rows[rowIndex];
                                   //document.getElementById(row.id).style.display = 'block'
                                   //alert(q2);
                                   disable(q1, q2, items, 1, 0.0);
                                   var g = parseFloat(gross);
                                   g = g + parseFloat(pamt);
                                   // $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(g).toFixed(2));
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
                                   disable(q1, q2, items, 2, d);
                                   var row = targetTable.rows[rowIndex];
                                   document.getElementById(row.id).style.display = 'block'
                                   var g = parseFloat(gross);
                                   g = g + parseFloat(pamt);
                                   //$('#<%=lblGrossTotal.ClientID%>').text(parseFloat(g).toFixed(2));
                               }
                               if (bv >= d && offertype == 3) {

                                   disable(q1, q2, items, 3, d);
                                   var row = targetTable.rows[rowIndex];
                                   document.getElementById(row.id).style.display = 'block'
                                   //alert(row.id);
                                   //                                        disable(q1, q2, items, 3, d);
                                   var g = parseFloat(gross);
                                   g = g + parseFloat(pamt);
                                   //disable(q1, q2, items, 3, d);
                                   //  $('#<%=lblGrossTotal.ClientID%>').text(parseFloat(g).toFixed(2));

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

                       //                            $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(7)").find("input:text").val(parseFloat($(this).find("td:eq(3)").text()).toFixed(2));

                       $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(9)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));


                       $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(13)").find("input:text").val(parseFloat($(this).find("td:eq(4)").text()).toFixed(2));

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
       function CouponApply() {
           var CouponCode = $('#<%=txt_Coupon.ClientID %>').val().trim();
           var userid = $('#<%=txtUserId.ClientID %>').val();
           var NetTotal_New = $('#<%=hfNetTotal.ClientID %>').val();
           if (CouponCode == "") {
               $('#lblmsgcoupon').text("Please enter coupon.");
               $('#lblmsgcoupon').css('color', 'red');
               $('#lblDiscount').text(0);
               $('#<%=txtNetAmt.ClientID %>').val($('#<%=hfNetTotal.ClientID %>').val());
               $('#btnReset').css('display', 'none');
               $('#<%=hfCouponapplied.ClientID %>').val(0);
               $('#<%=txt_Coupon.ClientID %>').removeAttr("disabled", "disabled");
               return;
           }
           else {
               $.ajax({
                   type: "POST",
                   url: 'BillingForm.aspx/couponapply',
                   data: '{CouponCode: "' + CouponCode + '", userid: "' + userid + '", ConditionAmount: "' + $('#<%=hfNetTotal.ClientID %>').val() + '"}',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       if (response.d == '0') {
                           $('#lblmsgcoupon').text("Please enter valid coupon.");
                           $('#lblmsgcoupon').css('color', 'red');
                           $('#btnReset').css('display', 'none');
                           $('#<%=hfCouponapplied.ClientID %>').val(0);
                           $('#<%=txt_Coupon.ClientID %>').removeAttr("disabled", "disabled");
                       }
                       else {
                           if (NetTotal_New > response.d) {
                               $('#lblmsgcoupon').text("");
                               $('#lblmsgcoupon').text("Coupon applied successfully.");
                               $('#lblmsgcoupon').css('color', 'green');
                               $('#btnReset').css('display', 'inline');
                               $('#<%=lblDiscount.ClientID %>').text(response.d);
                               var NetAmt = $('#<%=hfNetTotal.ClientID %>').val();
                               $('#<%=txtNetAmt.ClientID %>').val(parseInt(NetAmt) - parseInt(response.d));
                               $('#<%=hfCouponapplied.ClientID %>').val(1);
                               $('#<%=txt_Coupon.ClientID %>').attr("disabled", true);
                           }
                           else {
                               $('#lblmsgcoupon').text("Coupon amount greater then invoice amount.");
                               $('#lblmsgcoupon').css('color', 'red');
                               $('#btnReset').css('display', 'none');
                               $('#<%=hfCouponapplied.ClientID %>').val(0);
                               $('#<%=txt_Coupon.ClientID %>').removeAttr("disabled", "disabled");
                           }

                       }
                   },
                   error: function (response) {
                       $('#lblmsgcoupon').text("Server error. Time out..!!");
                       $('#btnReset').css('display', 'none');
                       $('#<%=hfCouponapplied.ClientID %>').val(0);
                       $('#<%=txt_Coupon.ClientID %>').removeAttr("disabled", "disabled");
                   }
               });
           }
       }

       function Reset() {
           $('#<%=txt_Coupon.ClientID %>').val('');
           $('#<%=txt_Coupon.ClientID %>').removeAttr("disabled", "disabled");
           $('#lblmsgcoupon').text("");
           $('#<%=lblDiscount.ClientID %>').text(0);
           $('#<%=txtNetAmt.ClientID %>').val($('#<%=hfNetTotal.ClientID %>').val());
           $('#btnReset').css('display', 'none');
       }

       function BulkBuying(NetTot) {
           if ($('#<%=ddltype.ClientID %>').val() == "3") {
               var flag = 0;
               $('#tblBulkBuying tr').each(function () {
                   var PointVal = $(this).find("td:eq(0)").text();
                   var Discount = $(this).find("td:eq(1)").text();
                   if (flag == 0) {
                       if (parseInt(NetTot) >= parseInt(PointVal)) {
                           $('#<%=txtNetAmt.ClientID %>').val((parseFloat(NetTot) - parseFloat(Discount)).toFixed(2));
                           $('#<%=txtDiscount.ClientID %>').val(parseFloat(Discount).toFixed(2));
                           flag = 1;
                       }
                   }
               });
           }
       }



       function btncoupon_onclick() {

       }

   </script>
        <asp:HiddenField ID="hfCouponapplied" runat="server" Value="0" />
        <asp:HiddenField ID="hfNetTotal" runat="server" Value="0" />
        <h3 class="head">
            <i class="fa fa-file-text" aria-hidden="true"></i>Billing Form
        </h3>
           <div class="panel panel-default">
  <div class="col-md-12">
    <div class="clearfix">
    </div>
    <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="upnl" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnl" runat="server">
                    <ProgressTemplate>
                        <img alt="Please Wait....." style="position: absolute; padding-left: 150px; padding-top: 0; z-index:99999; 
                            margin-top: 50px;" src="../images/loading.gif" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div class="printdiv">
                    <div class="clearfix">
                    </div>
                   
                    <div class="form-group">
                        <div id="tblBillHeader">
                            <div class="col-sm-2" style="display:none"> <label>  Distributor Type :</label>
                                <asp:DropDownList ID="ddltype" runat="server" Onchange="Reset()" CssClass="form-control" TabIndex="1">
                                   <%-- <asp:ListItem Value="0">Select</asp:ListItem>--%>
                                    <asp:ListItem Value="1">Package</asp:ListItem>
                                    <asp:ListItem Value="2">Upgrade</asp:ListItem>
                                    <asp:ListItem Value="3">Repurchase</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddltype"
                                    ErrorMessage="please Select Type" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>
                                <%--   <asp:TextBox ID="txtUserDisp" Enabled="false"  Style="border-style: none; background-color: Transparent;
                                   color: Black;" runat="server"></asp:TextBox>--%>
                               
                            </div>
                             <div class="col-sm-3"> <label>
                                    User Id:&nbsp;  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId"
                                        Display="Dynamic" ErrorMessage="Enter userid." SetFocusOnError="true" ValidationGroup="g"></asp:RequiredFieldValidator>
                                   
                                </label>
                                    <asp:TextBox ID="txtUserId" ValidationGroup="g" runat="server" AutoPostBack="true"
                                        CausesValidation="true" CssClass="form-control" onblur="return CallVal(this);"
                                        TabIndex="3" ontextchanged="txtUserId_TextChanged" ></asp:TextBox>
                                         <asp:TextBox ID="txtUserName" Enabled="false" Style="border-style: none; background-color: Transparent;
                                    color: Black;" Width="300" runat="server"></asp:TextBox>
                                      <asp:Label ID="lblToAdd" runat="server"></asp:Label>
                                </div>
                                  <div class="col-sm-2">
                                <label>Billing Date:
                             </label>
                                  <asp:TextBox ID="txtbilldate" runat="server" placeholder="DD/MM/YYYY" AutoPostBack="true" 
                                          CssClass="form-control" ontextchanged="txtbilldate_TextChanged"></asp:TextBox>
                             </div>
                             <div class="col-sm-2">
                             <label>Party GST No.:</label>
                                  <asp:TextBox ID="txtpartgstno" runat="server"  CssClass="form-control"></asp:TextBox>
                             </div>
                              
                             <div class="col-sm-3"><label> Place of Supply:</label>
                             <asp:DropDownList ID="ddlplaceofsupply" runat="server" CssClass="form-control">
                                                            </asp:DropDownList>
                                                         </div>
                                                          </div> </div>
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
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                             
                            </div>
                           
                            <div style="clear: both">
                            </div>
                          
                                <div class="col-sm-2">
                                </div>
                                <div class="col-sm-2">
                                    <asp:Button ID="btncheck" runat="server" Text="Check User" OnClick="btncheck_Click"
                                        Visible="false" />
                                </div>
                          
                            <%--this div is used to store the product names to bind through javascript while searching in textbox--%>
                            <div id="divProduct" style="display: none;" runat="server">
                            </div>
                            <%--this div is used to store the userid names to bind through javascript while searching in textbox--%>
                            <div id="divUserID" style="display: none;" runat="server">
                            </div>
                            <%--this div is used to store the product names and MRP to bind in grid--%>
                            <div id="divMRP" runat="server" style="display: none;">
                            </div>
                            <div id="divBulkBuying" runat="server" style="display: none;">
                            </div>
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                            <div class="clearfix">
                            </div>
                            <br />
                            <div id="divbind" runat="server">
                                <div style="overflow: scroll">

                                    <asp:GridView ID="GridView1" Style="width: 100%;"  DataKeyNames="id" CssClass="table table-striped table-hover" 
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
                                <table style="width: 100%; background-color: White;">
                                    <tr>
                                        <td style="text-align: center;">
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
                                                        <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="selectbox" onchange="run();">
                                                            <asp:ListItem>Wallet</asp:ListItem>
                                                            <asp:ListItem>Cash</asp:ListItem>
                                                            <asp:ListItem>Cheque</asp:ListItem>
                                                            <asp:ListItem>Net Banking</asp:ListItem>
                                                            <asp:ListItem>DD</asp:ListItem>
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
                                                                        User wallet Balance :
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
                                                                        GST %
                                                                    </td>
                                                                    <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                                                        GST Amount
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" >
                                                                        <div id="divcoupon" class="form-group" >
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
                                                                                        <button type="button" id="btncoupon" class="btn btn-success" onclick="CouponApply();" >
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
                                                                    <td colspan="2" style="width: 100%">
                                                                        <div id="trOTPGen">
                                                                            <a href="#\" onclick="OPTGenerate(1)" class="btn btn-default">Generate OTP</a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" style="width: 100%">
                                                                        <div id="trOTPVerify" style="display: none">
                                                                            ENTER OTP :
                                                                            <asp:TextBox ID="txtOTP" runat="server" MaxLength="10" Style="background-color: transparent;
                                                                                width: 150px;"></asp:TextBox>
                                                                            <a href="#\" onclick="OPTVerift()"  class="btn btn-info">Verify</a>
                                                                            <br />
                                                                            <span id="lblOTPMSG"></span>
                                                                            <br />
                                                                            <div id="divRegenerate">
                                                                                <a href="#\" onclick="OPTGenerate(2)">Re-Generate OTP</a>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>  <td>&nbsp;</td>
                                                                <td>
                                                <asp:Button ID="btnGenerateBill" runat="server" CssClass="btn btn-success" OnClick="btnGenerateBill_Click"
                                                    Text="Generate Bill" ValidationGroup="g" /><br />
                                                    
                                                    </td></tr>
                                                            </table>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <br />
                                                <div id="CouponDiv" runat="server">
                                                </div>
                                                <asp:Label ID="lblscheme" runat="server"></asp:Label>
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
                                                                OnClick="nextbill_Click" />
                                                        </b>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <center>
                                    <div style="width: 100%; float: left; margin-top: 20px;">
                                        <asp:Label Text="" ID="lblCompanyAdd" runat="server"></asp:Label>
                                        <asp:Label Text="" ID="lblBillFooter" Visible="false" runat="server"></asp:Label>
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
<%--  <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
    <link href="../datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="../datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
        function OPTGenerate(flag) {
            var UserName = $('#<%=txtUserId.ClientID %>').val().trim();
            var Amount = $('#<%=txtNetAmt.ClientID %>').val().trim();

            $('#<%=txtOTP.ClientID %>').val('');
            $.ajax({
                type: "POST",
                url: 'BillingForm.aspx/GenerateOTP',
                data: '{UserName: "' + UserName + '", Amount: "' + Amount + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == '0') {
                        $('#trOTPGen').hide();
                        $('#trOTPVerify').show();
                        if (flag == "2") {
                            $('#lblOTPMSG').text("OTP RE-GENERATED.");
                            $('#lblOTPMSG').css('color', 'green');
                        }
                    }
                    return false;
                },
                error: function (response) {
                    $('#lblmsgcoupon').text("Server error. Time out..!!");
                }
            });
        }

        function OPTVerift() {
            var UserName = $('#<%=txtUserId.ClientID %>').val().trim();
            var OTP = $('#<%=txtOTP.ClientID %>').val().trim();
            $.ajax({
                type: "POST",
                url: 'BillingForm.aspx/VerifyOTP',
                data: '{UserName: "' + UserName + '", OTP: "' + OTP + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == '0') {
                        $('#lblOTPMSG').text("OTP Verified succeessfully.");
                        $('#lblOTPMSG').css('color', 'green');
                        $('#divRegenerate').hide();
                        $('#trOTPGen').hide();
                        $('#trOTPVerify').show();
                        document.getElementById("<%=btnGenerateBill.ClientID%>").disabled = false;
                        document.getElementById("<%=ddltype.ClientID%>").disabled = true;
                        document.getElementById("<%=txtUserId.ClientID%>").disabled = true;
                        document.getElementById("<%=txtbilldate.ClientID%>").disabled = true;
                        document.getElementById("<%=txtpartgstno.ClientID%>").disabled = true;
                        document.getElementById("<%=ddlplaceofsupply.ClientID%>").disabled = true;
                        document.getElementById("<%=txtName.ClientID%>").disabled = true;
                        document.getElementById("<%=txtaddress.ClientID%>").disabled = true;
                        document.getElementById("<%=ddl_state.ClientID%>").disabled = true;
                        document.getElementById("<%=txtCity.ClientID%>").disabled = true;
                        document.getElementById("<%=txtPincode.ClientID%>").disabled = true;
                        document.getElementById("<%=ddlpaytype.ClientID%>").disabled = true;
                        //debugger;
                        document.getElementById("<%=GridView1.ClientID%>").disabled = true;

                        //  $('#btnNewRow').hide();
                        $('#<%=GridView1.ClientID %>').attr('disabled', true);
                        $('#<%=txtOTP.ClientID %>').attr('disabled', 'disabled');
                    }
                    else {
                        $('#lblOTPMSG').text(response.d);
                        $('#lblOTPMSG').css('color', 'red');
                    }
                },
                error: function (response) {
                    $('#lblmsgcoupon').text("Server error. Time out..!!");
                }
            });
        }


        function Reset() {
            $('#<%=txtUserId.ClientID %>').val('');
            $('#<%=txtUserName.ClientID %>').val('');
        }
    </script>
</asp:Content>
