<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="RazorpayRequest.aspx.cs" Inherits="User_RazorpayRequest" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title></title>
    </head>
    <%--<script src="../franchise/js/jquery-1.10.2.js"></script>--%>
    <script src="../Grid_js_css/jquery-3.5.1.js" type="text/javascript"></script>
    <body style="display: flex; align-items: center; justify-content: center; margin-top: 100px">
        <button id="rzp-button1"></button>
        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
         <%--<script> var $J = $.noConflict(true); </script>--%>
        <script>
           
            $(function () { 
                $('#rzp-button1').click();
            });
            var options = {
                "key": "<%=KeyId%>", // Enter the Key ID generated from the Dashboard
                "amount": "<%=amount%>", // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
                "currency": "INR",
                "name": "Toptime Consumer Private Limited",
                "description": "<%=product%>",
                "image": "https://example.com/your_logo",
                "order_id": "<%=orderId%>", //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
                "handler": function (response) {
                    var payment_id = response.razorpay_payment_id;
                    var order_id = response.razorpay_order_id;
                    var signature = response.razorpay_signature;
                    $.ajax({
                        type: "POST",
                        url: 'RazorpayRequest.aspx/GenerateInv',
                        data: '{order_id: "' + order_id + '", payment_id: "' + payment_id + '", signature: "' + signature + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.Error == "") {
                                alert("Invoice Generated Successfully. Invoice Number is : " + data.d.InvoiceNo);
                                window.location = "BarcodeBilling.aspx";
                                return;
                            }
                            else {
                                alert(data.d.Error);
                            }
                        },
                        error: function (response) {
                        }
                    });

                },
                "prefill": {
                    "name": "<%=name%>",
                    "email": "<%=email%>",
                    "contact": "<%=contact%>"
                },
                "notes": {
                    "address": "Razorpay Corporate Office"
                },
                "theme": {
                    "color": "#3399cc"
                }
            };
            var rzp1 = new Razorpay(options);
            rzp1.on('payment.failed', function (response) {
                var code = response.error.code;
                var desc = response.error.description;
                var source = response.error.source;
                var step = response.error.step;
                var reason = response.error.reason;
                var oid = response.error.metadata.order_id;
                // alert(response.error.metadata.payment_id);
                window.location = "RazorpayResponse.aspx?code=" + code + ",&desc=" + desc + ",&source=" + source + ",&step=" + step + ",&reason=" + reason + ",&oid=" + oid;
            });
            document.getElementById('rzp-button1').onclick = function (e) {
                rzp1.open();
                e.preventDefault();
            }
        </script>
    </body>
    </html>

</asp:Content>

