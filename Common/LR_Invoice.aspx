<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LR_Invoice.aspx.cs" Inherits="Common_LR_Invoice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <%-- <div class="right-sign">
            <img src="../secretadmin/images/right-sign.png">
        </div>--%>
        <div class="tax-invoice">
            <img src="../secretadmin/images/redemption_voucher.jpg">
        </div>

        <header class="clearfix">

            <img src="../secretadmin/images/logo.png" width="140px">
            <img id="ImgbillCancel" runat="server" src="../images/billcancel.png" class="cancel" style="position: absolute; right: 0px; top: 162px; width: 95%; z-index: 0000000000;"  />
            <div class="total-bold" style="margin-top: 2px;">
                <span>CIN:</span><asp:Label ID="lbl_MainCompanyCIN" runat="server"></asp:Label>
            </div>
            <div class="clearfix"></div>
            <br />


            <div id="project">


                <div><span class="total-bold">Seller: </span></div>
                <div>
                    <span class="total-bold">User Id: </span>
                    <asp:Label ID="lbl_Sellerid" runat="server"></asp:Label>
                </div>
                <div class="total-bold" style="font-size: larger;">
                    <asp:Label ID="lbl_SellerName" runat="server" Width="100%"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lbl_ComAdd" runat="server" Width="100%"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Tel : </span>
                    <asp:Label ID="lbl_ComMobileno" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Email:</span>
                    <asp:Label ID="lbl_ComEmail" runat="server"></asp:Label>
                </div>

                <div>
                    <span class="total-bold">GSTIN :</span>
                    <asp:Label ID="lbl_ComGSTIN" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">PAN :</span>
                    <asp:Label ID="lbl_ComPanNo" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">CIN :</span>
                    <asp:Label ID="lbl_ComCIN" runat="server"></asp:Label>
                </div>
                <hr />
                <div>
                    <span class="total-bold">Invoice No. :</span>
                    <asp:Label ID="lbl_UserINVNo" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Invoice Type :</span>
                    <asp:Label ID="lbl_UserInvType" runat="server" Style="width: 55%;"></asp:Label>
                </div>

                <div>
                    <span class="total-bold">Invoice Date :</span>
                    <asp:Label ID="lbl_UserINVDate" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">PO No. :</span>
                    <asp:Label ID="lbl_User_PO_NO" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">E-Way Bill No. : </span>
                    <asp:Label ID="lbl_EwayNo" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Pay Mode :</span>
                    <asp:Label ID="lbl_PayMode" runat="server"></asp:Label>
                </div>

                <div style="display: none;"><span>E-Way Bill No. : </span>NA    </div>

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

                <div><span class="total-bold">Buyer: </span></div>
                <div>
                    <span class="total-bold">User Id: </span>
                    <asp:Label ID="lbl_Userid" runat="server"></asp:Label>
                </div>
                <div class="total-bold">
                    <asp:Label ID="lbl_UserName" runat="server"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lbl_UserAdd" runat="server" Width="100%"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Tel : </span>
                    <asp:Label ID="lbl_UserMobileNo" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">Email:</span>
                    <asp:Label ID="lbl_UserEmail" runat="server"></asp:Label>
                </div>

                <div>
                    <span class="total-bold">GSTIN :</span>
                    <asp:Label ID="lbl_UserGSTIN" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">PAN :</span>
                    <asp:Label ID="lbl_UserPAN" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="total-bold">CIN :</span>
                    <asp:Label ID="lbl_UserCIN" runat="server"></asp:Label>
                </div>
                <hr />
                <div>
                    <span class="total-bold">Shipping Address : </span>
                    <asp:Label ID="lbl_ShipingAdd" runat="server"></asp:Label>
                </div>

                <div>
                    <span class="total-bold">Transport Name: </span>
                    <asp:Label ID="lbl_TransportName" runat="server"></asp:Label>
                </div>

                <div>
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
                          <%--  <th class="total-bold">HSN CODE</th>--%>
                            <th class="total-bold" style="text-align: right;">Point Value</th>
                            <th class="total-bold" style="text-align: right;">Qty</th>
                           <%-- <th class="total-bold">Actual Qty.</th>--%>
                            <th class="total-bold" style="text-align: right;">Point</th>
                           <%-- <th class="total-bold">GST</th>
                            <th class="total-bold">Tax</th>
                            <th class="total-bold">Invoice Value</th>--%>
                        </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="service"><%# Container.ItemIndex + 1 %></td>
                    <td class="desc">
                        <%#Eval("productname") %> 
                    </td>
                   <%-- <td class="unit">
                        <%#Eval("hsn") %>
                    </td>--%>

                    <td class="total" style="text-align: right;">
                        <%#Eval("DP") %>
                    </td>
                  <%--  <td class="total" style="text-align: right;">
                        <%#Eval("quantity") %>
                    </td>--%>

                    <td class="total" style="text-align: right;">
                        <%#Eval("quantity") %>
                    </td>
                   <%-- <td class="total" style="text-align: right;">
                        <%#Eval("taxable") %>
                    </td>
                    <td class="total" style="text-align: right;">
                        <%#Eval("tax") %>
                    </td>
                    <td class="total" style="text-align: right;">
                        <%#Eval("taxrs") %>
                    </td>--%>
                    <td class="total" style="text-align: right;">
                        <%#Eval("TotalAmt") %>
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
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lbltotalqty" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lbltotal" runat="server"></asp:Label>
                    </td>
                </tr>
                </tbody> </table> 
            </FooterTemplate>
        </asp:Repeater>



        <table style="width: 30%; margin-left: 2%; float: right">

            <tr>
                <td style="border-bottom: none;" class="total-bold">Total Points :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_GrossTotal" runat="server">0</asp:Label>
                </td>
            </tr>
          <%--  <tr>
                <td style="border-bottom: none;" class="total-bold" id="tdGst" runat="server">GST :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_gst" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: none;" class="total-bold">Extra PV :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_ExtraPV" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: none;" class="total-bold">Total PV :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_TotalPV" runat="server">0</asp:Label>
                </td>
            </tr>

            <tr>
                <td style="border-bottom: none;" class="total-bold">Discount :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_Discount" runat="server">0</asp:Label>
                </td>
            </tr>--%>
            <tr>
                <td class="total-bold" style="border-bottom: none;">Courier Charges</td>
                <td class="grand total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_CourierCharges" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold">Total Point Value:</td>
                <td class="grand total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_NetTotal" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
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
        <div id="notices" style="width: 55%; float: left;">
            <div><b>Terms & Conditions:</b></div>
            <div class="notice">
                1. All Disputes are subject to jurisdiction of <%=method.COMP_STATE %> only.<br />
                2. Company is not responsible after the goods leave the premises.<br />
               <%-- 3. Any inaccuracy in this bill must be notified within 7 days of receipt of Bill.<br />
                4. Goods provided Free of Cost / Offer, subject to reversal of input tax credit of GST as prevailing.<br />--%>
                3. Point once redeemed can’t be reversed.<br />
                4. Point are not exchangeable in cash.<br />
                <%--5. If loyalty redemption, then point value will be associate rate.<br />
                6. If product wallet redemption, then point value will be MRP rate.<br />
                7. If product wallet redemption, then invoice series shall start with PW.<br />--%>
                5. Goods bought by the puchaser for self consumption purposes, ITC will not be available.<br />
            </div>
        </div>
        <div style="width: 40%; float: left; margin-left: 5%">
            <div>For</div>
            <div class="notice">
                <b>
                    <asp:Label ID="lbl_ComNameFooter" runat="server"></asp:Label>
                </b>
                <br />
                <br />
                <br />
                This is computer generated invoice, thus any physical signature not required.<br />
            </div>
        </div>
        <br />
        <br />
        <br />
    </form>
    <style>
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
            width: 23cm;
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
            width: 17cm;
            margin: auto;
        }

        .right-sign {
            position: absolute;
        }

        .tax-invoice {
            position: absolute;
            right: 220px;
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
            width: 40%;
        }

            #project span {
                color: #001028;
                text-align: left;
                width: 90px;
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
            width: 40%;
            margin-left: 20%;
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
    </style>
</body>
</html>
