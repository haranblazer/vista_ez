<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintBill.aspx.cs" Inherits="admin_PrintBill" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .printmygrd th
        {
            color: #000;
            text-align: left !important;
            font-size: 14px !important;
            border-bottom: dotted 1px #000 !important;
            border-top: dotted 1px #000 !important;
        }
        .printmygrd td
        {
            color: Black;
            font-size: 12px !important;
            text-align: left;
        }
        .textalingn
        {
            text-align: left !important;
        }
        .footerstylebodder
        {
            border-bottom: dotted 1px #000 !important;
            border-top: dotted 1px #000 !important;
        }
        .printmygrd table a:link, .printmygrd table a:visited
        {
        }
        .printmygrd table a:hover, .printmygrd table a:active
        {
        }
        .container hr, footer
        {
            display: none;
        }
    </style>
    <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />
</head>
<body>
    <form id="form1" runat="server">
    <center>
        <div style="width: 80%">
            <button onclick="myFunction()" class="hide_class" style="float: right">
                Print this Bill</button>
            <div class="printdiv">
                <table style="width: 100%;" class="withclass">
                    <tr>
                        <td style="text-align: left; width: 30%; vertical-align: top;">
                            <asp:Image ID="imgLogo" runat="server" Style="width: 80%" />
                        </td>
                        <td style="width: 30%; vertical-align: top;">
                            <asp:Label ID="lblComName" runat="server" CssClass="websiteName" Style="font-weight: bold;
                                font-size: 20px;"></asp:Label><br />
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
                 <h3>======================================INVOICE&nbsp;<asp:Label ID="lblbilltype" runat="server"></asp:Label>===================================</h3>
                <table style="width: 100%; text-align: left;" class="withclass">
                    <tr>
                        <td style="text-align: left;">
                            <span class="companyName useriddisply">User Id:
                                <asp:Label ID="txtUserId" runat="server"></asp:Label>
                            </span>
                        </td>
                        <td style="text-align: left">
                            <asp:Label ID="Label2" runat="server" Style="font-size: large"></asp:Label>
                        </td>
                    </tr>
                    <tr id="tblBillHeader">
                        <td style="text-align: left; vertical-align: top; width: 50%;">
                            <asp:Label ID="txtUserName" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="lblToAdd" runat="server"></asp:Label>
                            <br />
                            Phone No:<asp:Label ID="Label3" runat="server"></asp:Label>
                        </td>
                        <td style="text-align: left; vertical-align: top; width: 50%;">
                            <span style="display: block">Delivery Address :</span><br />
                            <asp:Label ID="txtDAddress" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Repeater ID="GridView1" runat="server">
                    <HeaderTemplate>
                        <div style="width: 100%; float: left;">
                            <table class="printmygrd" style="width: 100%; border-collapse: collapse;">
                                <tbody>
                                    <tr>
                                        <th>
                                            SrNo.
                                        </th>
                                        <th>
                                            Batch No
                                        </th>
                                        <th>
                                            Code
                                        </th>
                                        <th>
                                            Product Name
                                        </th>
                                        <th>
                                            Unit Price
                                        </th>
                                        <th>
                                            Quantity
                                        </th>
                                        <th>
                                            Discount
                                        </th>
                                        <th>
                                            VAT/CST
                                        </th>
                                        <th>
                                            Tax(%)
                                        </th>
                                        <th>
                                            Tax
                                        </th>
                                        <th>
                                            RP
                                        </th>
                                        <th>
                                            Total
                                        </th>
                                    </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="textalingn">
                                <%#Container.ItemIndex+1%>
                            </td>
                            <td class="textalingn">
                                <%#Eval("batchno") %>
                            </td>
                            <td class="textalingn">
                                <%#Eval("cd") %>
                            </td>
                            <td class="textalingn">
                                <%#Eval("pname") %>
                            </td>
                            <td>
                                <%# String.Format("{0:#0.00}", DataBinder.Eval(Container.DataItem, "DPWT")) %>
                            </td>
                            <td>
                                <%#Eval("quantity") %>
                            </td>
                            <td>
                                <%# String.Format("{0:#0.00}", DataBinder.Eval(Container.DataItem, "Dis")) %>
                            </td>
                            <td>
                                <%# String.Format("{0:#0.00}", DataBinder.Eval(Container.DataItem, "val")) %>
                            </td>
                            <td>
                                <%# String.Format("{0:#0.00}",Eval("Tax")) %>
                            </td>
                            <td>
                                <%#string.Format("{0:#0.00}",Eval("TaxRs")) %>
                            </td>
                            <td>
                                <%#String.Format("{0:#0.00}", Eval("BV")) %>
                            </td>
                            <td>
                                <%# String.Format("{0:#0.00}",Eval("total")) %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td class="footerstylebodder" align="right">
                                Total:
                            </td>
                            <td class="footerstylebodder" align="right">
                                <asp:Label ID="lblQtotal" runat="server"></asp:Label>
                            </td>
                            <td class="footerstylebodder" align="right">
                                <asp:Label ID="lblDistotal" runat="server"></asp:Label>
                            </td>
                            <td class="footerstylebodder" align="right">
                                <asp:Label ID="lblValtotal" runat="server"></asp:Label>
                            </td>
                            <td class="footerstylebodder" align="right">
                            </td>
                            <td class="footerstylebodder" align="right">
                                <asp:Label ID="lblTaxRsTtotal" runat="server"></asp:Label>
                            </td>
                            <td class="footerstylebodder" align="right">
                            </td>
                            <td class="footerstylebodder" align="right">
                                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                            </td>
                        </tr>
                        </tbody> </table> </div>
                    </FooterTemplate>
                </asp:Repeater>
                <table style="width: 100%; background-color: White; float: left;">
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
                                        <asp:Label ID="ddltype" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;<asp:Label ID="lblAmt" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trbank" runat="server">
                                    <td>
                                        Bank Name<br />
                                        <asp:Label ID="lblbank" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        DD/Cheque/Transaction No<br />
                                        <asp:Label ID="lbldd" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        Date<br />
                                        <asp:Label ID="lbldate" runat="server"></asp:Label>
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
                            <table style="width: 100%; border-top: dashed 1px #000; border-bottom: dashed 1px #000;">
                                <tr>
                                    <td style="width: 60%; vertical-align: top">
                                        <table>
                                            <tr>
                                                <td>
                                                    Total RP :
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:Label ID="lblTotalBV" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Total weight:
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:Label ID="lblWeight" runat="server"></asp:Label>
                                                </td>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                            <b>
                                <asp:Label ID="lblAmtWord" runat="server"></asp:Label></b>
                        </td>
                        <td style="width: 40%; vertical-align: top">
                            <table style="float: right;">
                                <tr>
                                    <td>
                                        Value Total :
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
                                        <asp:Label ID="txtTax" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Delivery Charge:
                                    </td>
                                    <td style="text-align: right">
                                        <asp:Label ID="txtDelChrg" runat="server"></asp:Label>
                                        <asp:Label ID="lblDelChrg" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td>
                                        Discount:
                                    </td>
                                    <td style="text-align: right">
                                        <asp:Label ID="txtDiscount" runat="server"></asp:Label>
                                        <span class="companyName">
                                            <asp:Label ID="lblDiscount" runat="server"></asp:Label></span><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Total&nbsp; Amount(Rs):
                                    </td>
                                    <td style="text-align: right">
                                        <asp:Label ID="txtNetAmt" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br />
                <table id="Table1" style="float: right; margin-right: 5%;">
                    <tr>
                        <td colspan="3" style="text-align: center">
                            <b>Tax Summary:</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                Tax %
                            </td>
                            <td style="border-top: dotted 1px #000; border-bottom: dotted 1px #000; width: 40%">
                                Tax Amount
                            </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Repeater ID="dglst" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                        </td>
                                        <td style="text-align: left; font-size: 12px;">
                                            <asp:Label ID="lblPackgName" runat="server" Text='<%#Eval("tax")%>'> </asp:Label>
                                        </td>
                                        <td style="text-align: left; font-size: 12px;">
                                            <asp:Label ID="lblQNT" runat="server" Text='<%#Eval("taxamount")%>'>0</asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td>
                            Total Tax
                        </td>
                        <td>
                            12.50%
                        </td>
                        <td>
                            <asp:Label ID="Label1" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
                </td> </tr>
                <tr>
                    <td>
                        <br />
                        <asp:Label ID="lblscheme" runat="server"></asp:Label>
                    </td>
                </tr>
                </table>
                <table style="width: 100%; border-top: dashed 1px #000; border-bottom: dashed 1px #000;
                    float: left;">
                    <tr>
                        <td style="text-align: left; width: 70%;" class="boder_righ">
                            <span class="term_condition"><b>Terms & Conditions</b>
                                <ol>
                                    <li>Goods Once Sold Will Not Be Taken Back.</li>
                                    <li>Warranty Will Be Under Taken By The Manufacturer Only.</li>
                                    <li>All Disputes Are Subject To
                                        <asp:Label ID="lblCityDisplay" runat="server"></asp:Label>
                                        Jurisdiction.</li>
                                    <li>Company Is Not Responsible After The Goods Leave The Premises.</li>
                                    <li>Any Inaccuracy In This Bill Must Be Notifided Immediately On Its Receipt.</li>
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
                                <br />
                                <%--    Prepared By&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblp" runat="server"></asp:Label>--%>
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
                <button onclick="myFunction()" class="hide_class" style="float: right">
                    Print this Bill</button>
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
            </div>
    </center>
    </ContentTemplate> </asp:UpdatePanel> </div> </center>
    </form>
</body>
</html>
