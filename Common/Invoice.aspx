<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Invoice.aspx.cs" Inherits="Common_Invoice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- <meta name="viewport" content="width=device-width,initial-scale=1" />--%>
</head>
<body>
    <form id="form1" runat="server">
        <%-- <div class="tax-invoice" id="Idtaxinvoice" runat="server">
            <img src="../secretadmin/images/tax-invoice.png">
        </div>
        <div class="tax-invoice" id="Idsalesinvoice" runat="server">
            <img src="../secretadmin/images/sales-invoice.png">
        </div>--%>
        <div class="heading" id="div_InvType" runat="server">Tax Invoice</div>
        <header class="clearfix">
            <img src="../images/logo.png" class="logo">
            <img src="../images/billcancel.png" class="cancel" style="position: absolute; right: 0px; top: 162px; width: 95%; z-index: 0000000000;" id="imgbill" runat="server" />
           <div class="total-bold" style="margin-top: 2px;"><span>CIN:</span><%=method.COMP_CINNO%>
            </div>
            <div class="clearfix"></div>
            <br />
            <div id="project">
                <div>
                    <span class="total-bold">Seller User Id: </span>
                    <asp:Label ID="lbl_Sellerid" runat="server"></asp:Label>
                </div>
                <div class="total-bold" style="font-size: larger;">
                    <asp:Label ID="lbl_SellerName" runat="server" Width="100%"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lbl_ComAdd" runat="server" Width="100%" Height="40px"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Tel : </span>
                    <asp:Label ID="lbl_ComMobileno" runat="server"></asp:Label>
                    <span class="total-bold">Email:</span>
                    <asp:Label ID="lbl_ComEmail" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">GSTIN :</span>
                    <asp:Label ID="lbl_ComGSTIN" runat="server"></asp:Label>
                    <span class="total-bold">PAN :</span>
                    <asp:Label ID="lbl_ComPanNo" runat="server"></asp:Label>
                </div>
                <div style="display: none;">
                    <span class="total-bold">CIN :</span>
                    <asp:Label ID="lbl_ComCIN" runat="server"></asp:Label>
                </div>
                <hr />
                <div>
                    <span class="total-bold">PO No. :</span>
                    <asp:Label ID="lbl_User_PO_NO" runat="server"></asp:Label>

                    <span class="total-bold">Invoice No. :</span>
                    <asp:Label ID="lbl_UserINVNo" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Invoice Type :</span>
                    <asp:Label ID="lbl_UserInvType" runat="server"></asp:Label>

                    <span class="total-bold">Invoice Date :</span>
                    <asp:Label ID="lbl_UserINVDate" runat="server"></asp:Label>
                </div>

                <div>
                    <span class="total-bold">E-Way Bill No. : </span>
                    <asp:Label ID="lbl_EwayNo" runat="server"></asp:Label>

                    <span class="total-bold">Pay Mode :</span>
                    <asp:Label ID="lbl_PayMode" runat="server"></asp:Label>
                </div>

                <%-- <div>
                    <span class="total-bold">Use Wallet : </span>
                    <asp:Label ID="lbl_UseWallet" runat="server"></asp:Label>

                    <span class="total-bold">Secondary Amount :</span>
                    <asp:Label ID="lbl_secondaryAmount" runat="server"></asp:Label>
                </div>--%>


                <div style="display: none;"><span>E-Way Bill No. : </span>NA </div>
                <div style="display: none;">
                    <span>Invoice No. :</span>
                    <asp:Label ID="lbl_InvoiceNo" runat="server"></asp:Label>
                </div>
                <div style="display: none;">
                    <span>Invoice Type :</span>
                    <asp:Label ID="lbl_InvType" runat="server"></asp:Label>
                </div>
                <div style="display: none;">
                    <span>Invoice Date :</span>
                    <asp:Label ID="lbl_InvoiceDate" runat="server"></asp:Label>
                </div>
                <div style="display: none;">
                    <span>Date PO No. :</span>
                    <asp:Label ID="lbl_Date_PO_NO" runat="server"></asp:Label>
                </div>
            </div>

            <div id="company" class="clearfix">
                <div>
                    <span class="total-bold">Buyer User Id: </span>
                    <asp:Label ID="lbl_Userid" runat="server"></asp:Label>
                </div>
                <div class="total-bold">
                    <asp:Label ID="lbl_UserName" runat="server"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lbl_UserAdd" runat="server" Width="100%" Height="40px"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Tel : </span>
                    <asp:Label ID="lbl_UserMobileNo" runat="server"></asp:Label>

                    <span class="total-bold">Email:</span>
                    <asp:Label ID="lbl_UserEmail" runat="server"></asp:Label>
                </div>

                <div>
                    <span class="total-bold">GSTIN :</span>
                    <asp:Label ID="lbl_UserGSTIN" runat="server"></asp:Label>

                    <span class="total-bold">PAN :</span>
                    <asp:Label ID="lbl_UserPAN" runat="server"></asp:Label>
                </div>
                <div style="display: none;">
                    <span class="total-bold">CIN :</span>
                    <asp:Label ID="lbl_UserCIN" runat="server"></asp:Label>
                </div>
                <hr />
                <div>
                    <span class="total-bold" style="width: 100%">Shipping Address : </span>
                    <asp:Label ID="lbl_ShipingAdd" runat="server" Style="width: 100%"></asp:Label>
                </div>

                <div>
                    <span class="total-bold">Transport Name: </span>
                    <asp:Label ID="lbl_TransportName" runat="server"></asp:Label>
                    <div class="clearfix"></div>
                    <span class="total-bold">Bility No.: </span>
                    <asp:Label ID="lbl_BilityNo" runat="server"></asp:Label>
                </div>

            </div>
        </header>


        <asp:Repeater ID="Repeater" runat="server">
            <HeaderTemplate>
                <table>
                    <tbody>
                        <tr style="background: #ddd;">
                            <th class="service total-bold">#</th>
                            <th class="desc total-bold">Product Name</th>
                            <th class="total-bold hide-xs">HSN CODE</th>
                            <th class="total-bold">MRP</th>
                            <th class="total-bold"><%=method.DP%>(excl. Tax) </th>
                            <th class="total-bold hide-xs">Qty.</th>
                            <th class="total-bold hide-xs">Gross Value</th>

                            <th class="total-bold">Disc%</th>
                            <th class="total-bold">Disc Value</th>

                            <%--<th class="total-bold hide-xs">Billing Value</th>--%>
                            <th class="total-bold hide-xs">GST%</th>
                            <%-- <th class="total-bold hide-xs">Tax</th>--%>
                            <th class="total-bold hide-xs"><%=method.DP%>(incl.Tax)</th>
                            <th class="total-bold hide-xs"><%=method.PV%></th>
                        </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>

                    <td class="service"><%# Container.ItemIndex + 1 %></td>
                    <td class="desc"><%#Eval("productname") %> </td>
                    <td class="unit hide-xs"><%#Eval("hsn") %> </td>
                    <td class="total" style="text-align: right;"><%#Eval("MRP") %> </td>
                    <td class="total" style="text-align: right;"><%#Eval("DP") %> </td>
                    <td class="total hide-xs" style="text-align: right;"><%#Eval("quantity") %> </td>
                    <td class="total hide-xs" style="text-align: right;"><%#Eval("Gross") %> </td>
                    <td class="total hide-xs" style="text-align: right;"><%#Eval("Disc_Perc_Val") %>  <%#Eval("dis_type") %>  </td>
                    <td class="total hide-xs" style="text-align: right;"><%#Eval("disc") %> </td>
                    <%--   <td class="total hide-xs" style="text-align: right;"><%#Eval("DP") %> </td>--%>
                    <td class="total hide-xs" style="text-align: right;"><%#Eval("tax") %> </td>
                    <%--<td class="total hide-xs" style="text-align: right;"><%#Eval("taxrs") %> </td>--%>
                    <td class="total hide-xs" style="text-align: right;"><%#Eval("TotalAmt") %>  </td>
                    <td class="total hide-xs" style="text-align: right;"><%#Eval("BV") %>  </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                <tr>
                    <td class="total-bold hide-xs"></td>
                    <td class="total-bold"><span style="font-weight: bold">Total</span>  </td>
                    <td class="total-bold hide-xs"></td>
                    <td class="total-bold hide-xs"></td>
                    <td class="total-bold hide-xs"></td>

                    <td class="total-bold hide-xs" style="text-align: right;">
                        <asp:Label ID="lbltotalqty" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold hide-xs" style="text-align: right;">
                        <asp:Label ID="lblGross" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold hide-xs" style="text-align: right;">0 </td>
                    <td class="total-bold hide-xs" style="text-align: right;">
                        <asp:Label ID="lbl_Disc" runat="server"></asp:Label>
                    </td>

                    <%--  <td class="total-bold hide-xs" style="text-align: right;">
                        <asp:Label ID="lbl_BillingValue" runat="server"></asp:Label>
                    </td>--%>


                    <td class="total-bold hide-xs" style="text-align: right;">0 </td>
                    <%--  <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lblTAX" runat="server"></asp:Label>
                    </td>--%>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lbltotal" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lbl_TotalPV" runat="server"></asp:Label>
                    </td>
                </tr>
                </tbody> </table> 
            </FooterTemplate>
        </asp:Repeater>




        <%-- <asp:Repeater ID="RPT_Seller" runat="server">
            <HeaderTemplate>
                <table>
                    <tbody>
                        <tr style="background: #ddd;">
                            <th class="service total-bold">#</th>
                            <th class="desc total-bold">Product Name</th>
                            <th class="total-bold ">Unit Price</th>
                            <th class="total-bold">Billed Qty</th>
                            <th class="total-bold">Actual Qty.</th>
                            <th class="total-bold">Billing Value</th>
                            <th class="total-bold"><%=BilltypeValue%>  </th>
                        </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="service"><%# Container.ItemIndex + 1 %></td>
                    <td class="desc">
                        <%#Eval("productname") %> 
                    </td>
                    <td class="total">
                        <%#Eval("DPWithTax") %>
                    </td>
                    <td class="total">
                        <%#Eval("quantity") %>
                    </td>
                    <td class="total">
                        <%#Eval("quantity") %>
                    </td>
                    <td class="total">
                        <%#Eval("TotalAmt") %>
                    </td>
                    <td class="total">
                        <%#Eval("BV") %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                <tr>
                    <td class="total-bold"></td>
                    <td class="total-bold"></td>

                    <td class="total-bold">
                        <span style="font-weight: bold">Total</span>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lbltotalqty1" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lbltotalqty" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lblValue" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lblPV" runat="server"></asp:Label>
                    </td>
                </tr>
                </tbody> </table> 
            </FooterTemplate>
        </asp:Repeater>--%>

        <asp:Repeater ID="RepeaterGST" runat="server">
            <HeaderTemplate>
                <table style="width: 68%; border-collapse: collapse; float: left;">
                    <tbody>
                        <tr style="background: #ddd;">
                            <th class="total-bold" style="text-align: right;">HSN CODE</th>
                            <th class="total-bold" style="text-align: right;">GST Rate</th>
                            <th class="total-bold" style="text-align: right;">Taxable Value</th>
                            <th class="total-bold" style="text-align: right;">CGST</th>
                            <th class="total-bold" style="text-align: right;">SGST</th>
                            <th class="total-bold" style="text-align: right;">IGST</th>
                        </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td style="text-align: right;">
                        <%#Eval("HSN") %>
                    </td>
                    <td style="text-align: right;">
                        <%#Eval("tax") %>
                    </td>
                    <td style="text-align: right;">
                        <%#Eval("taxable") %>
                    </td>
                    <td style="text-align: right;">
                        <%#Eval("CGSTRS") %>
                    </td>
                    <td style="text-align: right;">
                        <%#Eval("SGSTRS") %>
                    </td>
                    <td style="text-align: right;">
                        <%#Eval("IGSTRS") %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                <tr>
                    <td class="total-bold">
                        <span style="font-weight: bold">Total</span>
                    </td>
                    <td class="total-bold"></td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lblTaxablevalue" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lblCGST" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lblSGST" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lblIGST" runat="server"></asp:Label>
                    </td>
                </tr>
                </tbody> </table> 
            </FooterTemplate>
        </asp:Repeater>
        <table class="total_table">
            <tr style="display: none;">
                <td style="border-bottom: none;" class="total-bold">Gross Value :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lvl_Gross" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr style="display: none;">
                <td style="border-bottom: none;" class="total-bold">Discount Value :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_Discount" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: none;" class="total-bold">Billing Value :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_GrossTotal" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: none;" class="total-bold" id="tdGst" runat="server">GST :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_gst" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold" style="border-bottom: none;">Courier Charges:</td>
                <td class="grand total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_CourierCharges" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold" style="border-bottom: none;">Adjustment Amount:</td>
                <td class="grand total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_Estimated" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: none;" class="total-bold">Invoice Value(Rs) :</td>
                <td class="grand total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_NetTotal" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: none;" class="total-bold"><%=method.PV%>  :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_TotalPV" runat="server">0</asp:Label>
                </td>
            </tr>

            <tr style="display: none;">
                <td class="total-bold">Gross Weight :</td>
                <td class="total-bold" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_GrossWeight" runat="server">0</asp:Label>
                </td>
            </tr>
        </table>
        <div class="clearfix"></div>

        <div id="lbl_UserRemark" runat="server"></div>

        <div class="clearfix"></div>
        <hr />
        <div id="notices">
            <div><b>Terms & Conditions:</b></div>
            <div class="notice">
                1. All Disputes are subject to jurisdiction of <asp:Label ID="lbl_state" runat="server"></asp:Label> only.<br />
                2. Company is not responsible after the goods leave the premises.<br />
                3. Any inaccuracy in this bill must be notified within 7 days of receipt of Bill.<br />
                4. Goods provided Free of Cost / Offer, subject to reversal of input tax credit of GST as prevailing.<br />
                5. Goods bought by the puchaser for self consumption purposes, ITC will not be available.
                
            </div>
        </div>
        <div class="barcode">
            <div class="notice">
                <%-- <img src="../images/qr_code_invoice.png" width="70px" style="float: right" />--%>
                For <b>
                    <asp:Label ID="lbl_ComNameFooter" runat="server"></asp:Label>
                </b>
                <br />
                <br />
                <div id="sign">
                    <asp:Image ID="img_sign" runat="server" width="120px"/>
                </div>
                <%--<img src="../images/ezcare_sign.png" width="120px" />--%>
                <br />
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="footer">
            This is computer generated invoice, thus any physical signature not required.
        </div>
        <br />
        <br />
        <br />
    </form>
    <style>
        .footer {
            text-align: center;
            font-size: 14px;
            border-bottom: 1px solid #000;
            border-top: 1px solid #000;
            padding: 3px;
        }

        .heading {
            text-align: center;
            font-size: 20px;
            border-bottom: 1px solid #000;
            border-top: 1px solid #000;
            padding: 3px;
            margin-top: 5px;
        }

        .total_table {
            width: 30%;
            margin-left: 2%;
            float: right
        }

        #notices {
            width: 55%;
            float: left;
        }

        .barcode {
            width: 40%;
            float: left;
            margin-left: 5%;
            text-align: end;
        }

        .logo {
            width: 140px;
        }

        .banner {
            width: 25cm;
            /*height: 3.88cm;*/
        }

        .clearfix:after {
            content: "";
            display: table;
            clear: both;
        }

        a {
            color: #5D6975;
            text-decoration: underline;
        }

        body {
            position: relative;
            width: 25cm;
            /* height: 29.7cm; */
            margin: 0 auto;
            color: #001028;
            background: #FFFFFF;
            font-family: Arial, sans-serif;
            font-size: 12px;
            font-family: Arial;
        }

        header {
            position: relative;
            padding: 10px 0;
            margin-bottom: 30px;
            width: 25cm;
            margin: auto;
        }

        .right-sign {
            position: absolute;
        }

        .tax-invoice {
            position: absolute;
            right: 220px;
            margin-top: 1px;
        }

        #logo {
            text-align: center;
            margin-bottom: 10px;
        }

            #logo img {
                width: 90px;
            }

        h1 {
            border-top: 1px solid #5D6975;
            border-bottom: 1px solid #5D6975;
            color: #5D6975;
            font-size: 2.4em;
            line-height: 1.4em;
            font-weight: normal;
            text-align: center;
            margin: 0 0 20px 0;
            background: url(dimension.png);
        }

        .total-bold {
            font-weight: bold;
        }

        #project {
            float: left;
            width: 50%;
        }

            #project span {
                color: #001028;
                text-align: left;
                /* width: 100px;*/
                margin-right: 10px;
                display: inline-block;
                font-size: 12px;
                line-height: 1.5;
                /* font-weight: bold;*/
            }

        #company span {
            /* font-weight: bold;*/
            color: #001028;
            text-align: left;
            /* width: 90px;*/
            margin-right: 10px;
            display: inline-block;
            font-size: 1.0em;
            line-height: 1.5;
        }

        #company {
            float: left;
            /* text-align: right; */
            width: 47%;
            margin-left: 1%;
            border-left: 1px dotted;
            padding-left: 10px;
        }

            #project div,
            #company div {
                /*white-space: nowrap;   */
            }

        table {
            width: 100%;
            /* border-collapse: collapse;*/
            border-spacing: 0;
            margin-bottom: 20px;
        }

            table tr td {
                /*background: #F5F5F5;*/
                border-bottom: 2px dotted #000;
            }

            table th,
            table td {
                text-align: left;
            }

            table th {
                padding: 5px;
                color: #000;
                border-bottom: 2px dotted #000000;
                white-space: nowrap;
                font-weight: normal;
            }

            table .service,
            table .desc {
                text-align: left;
            }

            table td {
                padding: 5px;
                /*text-align: right;*/
            }

                table td.service,
                table td.desc {
                    vertical-align: top;
                }

                table td.unit,
                table td.qty,
                table td.total {
                    font-size: 1.2em;
                }

                table td.grand {
                    /*border-top: 1px solid #5D6975;*/
                    border-bottom: 2px dotted #000;
                }

        #notices .notice {
            color: #5D6975;
            font-size: 1.2em;
        }

        footer {
            color: #5D6975;
            width: 100%;
            height: 30px;
            position: absolute;
            bottom: 0;
            border-top: 1px solid #C1CED9;
            padding: 8px 0;
            text-align: center;
        }

        /*   @media only screen and (min-width:320px) and (max-width:479px) {
            body {
                width: 98%;
                margin-left: 1%;
            }

            #project {
                width: 100%;
            }

            #company {
                width: 100%;
                margin-left: 0px
            }


            .banner {
                width: 100%;
                height: 100%
            }

            header {
                width: 100%;
            }

            .tax-invoice {
                right: 0px;
            }

            .logo {
                width: 200px;
            }

            #project span {
                width: 115px;
            }
            #company span {
                width: 115px;
            }
            #notices {
                width: 100%;
                float: left;
            }

            .barcode {
                width:100%;
                float: left;
                margin-left: 0%
            }
            .total_table {
            width:100%
            }
            .hide-xs {
            display:none;
            }
        }

        @media only screen and (min-width:480px) and (max-width:767px) {

        }

        @media(min-width:768px) and (max-width:991px) {
        }

        @media(min-width:992px) and (max-width:1169px) {
        }

        @media(min-width:992px) and (max-width:1239px) {
        }

        @media(min-width:1240px) and (max-width:1500px) {
        }

        @media(min-width:1200px) {
        }*/
    </style>
</body>
</html>

