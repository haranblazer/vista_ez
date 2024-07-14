<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="PurchaseOrderBill.aspx.cs" Inherits="franchise_PurchaseOrderBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  < <style type="text/css">
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

      <div class="site-content">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Purchase Order Bill
            </div>

    <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />
    <button onclick="myFunction()" class="hide_class" style="float: right">
        Print this Bill</button>
    <div class="printdiv">
        <table style="width: 100%;" class="withclass">
            <tr>
                <td style="text-align: left; width: 30%; vertical-align: top;">
                    <asp:Image ID="imgLogo" runat="server" Style="width: 260px;height:80px" />
                </td>
                <td style="width: 30%; vertical-align: top;">
                    <h2>
                        <asp:Label ID="lblComName" runat="server" CssClass="websiteName"></asp:Label></h2>
                    <asp:Label ID="lblLeftHead" runat="server" CssClass="companyName"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 40%">
                    <table style="width: 100%;">
                        <tr>
                            <td style="text-align: right; font-weight: bold;">
                                PO Number :
                            </td>
                            <td style="text-align: left;">
                                <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                                <asp:Label ID="lblOrderNO" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; font-weight: bold;">
                                PO Date :
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
        <center>
            <h3>
                ===============================Purchase Order(PO)===========================</h3>
        </center>
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
                                    Value
                                </th>
                                <th>
                                    GST(%)
                                </th>
                                <th>
                                    GST
                                </th>
                                <th>
                                    BV
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
                        <%#Eval("cd") %>
                    </td>
                    <td class="textalingn">
                        <%#Eval("pname") %>
                    </td>
                    <td>
                        <%# String.Format("{0:#0.00}", DataBinder.Eval(Container.DataItem, "DP")) %>
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
        <table>
            <tr>
                <td style="height: 20px">
                </td>
            </tr>
        </table>
        <table style="width: 100%;">
            <tr>
                <td colspan="4" style="height: 10px">
                </td>
            </tr>
            <tr>
                <th class="printmygrd th">
                    Detail
                </th>
                <th class="printmygrd th">
                    Tax Summary
                </th>
                <th class="printmygrd th">
                    Payment
                </th>
                <th class="printmygrd th">
                    Value
                </th>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                Total BV :
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
                            </tr>
                </table>
                </td>
          
               <td>
          
               <asp:Repeater ID="dglst" runat="server">
                <HeaderTemplate>
          <table cellspacing="0" rules="all" border="1">
            <tr>
               <tr>
                    <td>
                        GST %
                    </td>
                    <td>
                        GST Amount
                    </td>
                </tr>
               
    </HeaderTemplate>
             
                 
                        <ItemTemplate>

                        <tr>
                            <td>
                                <asp:Label ID="lblPackgName" runat="server" Text='<%#Eval("tax")%>'> 
                                </asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblQNT" runat="server" Text='<%#Eval("taxamount")%>'>0</asp:Label>
                            </td>
                            </tr>
                        </ItemTemplate>
                      <FooterTemplate>
        </table>
    </FooterTemplate>
                    </asp:Repeater>
          
        </td>

          <td>
            <table width="100%">
                <tr>
                    <td>
                        S.No.
                    </td>
                    <td>
                        Mode
                    </td>
                    <td>
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
                        <asp:Label ID="lblAmt" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr id="trbank" runat="server" style="display: none;">
                    <td>
                        Bank Name<br />
                        <asp:Label ID="txtbname" runat="server"></asp:Label>
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
                    <td>
                    </td>
                    <td>
                        Total:
                    </td>
                    <td>
                        <asp:Label ID="lblTotalPy" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table>
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
                <tr>
                    <td>
                        Bulk Buying:
                    </td>
                    <td style="text-align: right">
                        <asp:Label ID="txtDiscount" runat="server"></asp:Label>
                        <span class="companyName">
                            <asp:Label ID="lblDiscount" runat="server">0</asp:Label></span><br />
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
        <table>
            <tr>
                <td style="height: 10px">
                </td>
            </tr>
        </table>
        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:Label ID="lblAmtWord" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <table style="width: 100%; border-top: dashed 1px #000; float: left;">
            <tr>
                <td style="text-align: left; width: 0%;" class="boder_righ">
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
                    </span>
                        <asp:Button ID="nextbill" runat="server" Text="Next Bill" CssClass="hide_class btn btn-success"
                            PostBackUrl="" OnClick="nextbill_Click" />
                        <button onclick="myFunction()" class="btn btn-success" style="float: right">
                            Print this Bill</button>
                    </b>
                </td>
            </tr>
        </table>
        <script>
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
    </div>

    </div>
   
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    </asp:Content>

