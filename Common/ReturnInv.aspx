<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReturnInv.aspx.cs" Inherits="Common_ReturnInv" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <%--<div class="right-sign">
            <img src="../secretadmin/images/right-sign.png">
        </div>--%>
        
        <div class="tax-invoice" id="Idsalesinvoice" runat="server">
            <img src="../secretadmin/images/sales-return.png">
        </div>

        <header class="clearfix">
            <div class="total-bold" ><span>CIN:</span><%=method.COMP_CINNO%>
            </div>
           
              <img src="../secretadmin/images/logo.png" width="140px">
               
              <div class="clearfix"></div><br />
          
             
              <div id="project">
              

               <div ><span>Seller: </span></div>
                <div><span>User Id: </span> <asp:Label id="lbl_Sellerid" runat="server"></asp:Label> </div>
                <div class="total-bold" style="font-size:larger;"> <asp:Label id="lbl_SellerName" runat="server" Width="100%"></asp:Label> </div>
                <div> <asp:Label id="lbl_ComAdd" runat="server"  Width="100%"></asp:Label></div>
                    <div><span>Tel : </span> <asp:Label id="lbl_ComMobileno" runat="server"></asp:Label></div>
                    <div><span>Email:</span> <asp:Label id="lbl_ComEmail" runat="server"></asp:Label> </div>
                    <br />
                <div><span>GSTIN :</span> <asp:Label id="lbl_ComGSTIN" runat="server"></asp:Label>  </div>
                <div><span>PAN :</span> <asp:Label id="lbl_ComPanNo" runat="server"></asp:Label>  </div>
                <div><span>CIN :</span> <asp:Label id="lbl_ComCIN" runat="server"></asp:Label>  </div>
                  <div><span>Invoice No. :</span> <asp:Label id="lbl_UserINVNo" runat="server"></asp:Label> </div>
                <div><span>Invoice Type :</span> <asp:Label id="lbl_UserInvType" runat="server" style="width: 55%;"></asp:Label> </div>

                <div><span>Invoice Date :</span> <asp:Label id="lbl_UserINVDate" runat="server"></asp:Label> </div>
                <div><span>Date PO No. :</span>  <asp:Label id="lbl_User_Date_PO_NO" runat="server"></asp:Label>     </div>
                  <div ><span>E-Way Bill No. : </span>     <asp:Label id="lbl_EwayNo" runat="server"></asp:Label>     </div>
                <div style="display:none;"><span>E-Way Bill No. : </span>    NA    </div>

                <div style="display:none;"><span>Invoice No. :</span> <asp:Label id="lbl_InvoiceNo" runat="server"></asp:Label> </div>
                <div style="display:none;"><span>Invoice Type :</span> <asp:Label id="lbl_InvType" runat="server"></asp:Label> </div>
                <div style="display:none;"><span>Invoice Date :</span> <asp:Label id="lbl_InvoiceDate" runat="server"></asp:Label> </div>
                <div style="display:none;"><span>Date PO No. :</span>  <asp:Label id="lbl_Date_PO_NO" runat="server"></asp:Label>  </div>
                
              </div>

              <div id="company" class="clearfix">

                <div ><span>Buyer: </span></div>
                <div><span>User Id: </span> <asp:Label id="lbl_Userid" runat="server"></asp:Label></div>
                <div class="total-bold"><asp:Label id="lbl_UserName" runat="server"></asp:Label></div>
                <div><asp:Label id="lbl_UserAdd" runat="server" Width="100%"></asp:Label>
                </div>
                <div><span>Tel : </span> <asp:Label id="lbl_UserMobileNo" runat="server"></asp:Label> </div>
                <div><span>Email:</span>  <asp:Label id="lbl_UserEmail" runat="server"></asp:Label> </div>
                <br />
                <div><span>GSTIN :</span> <asp:Label id="lbl_UserGSTIN" runat="server"></asp:Label> </div>
                <div><span>PAN :</span> <asp:Label id="lbl_UserPAN" runat="server"></asp:Label> </div>
                <div><span>CIN :</span> <asp:Label id="lbl_UserCIN" runat="server"></asp:Label> </div>
                 <div><span>Shipping Address : </span>   <asp:Label id="lbl_ShipingAdd" runat="server"></asp:Label>      </div>
              </div>
    </header>


        <asp:Repeater ID="Repeater" runat="server">
            <HeaderTemplate>
                <table>
                    <tbody>
                        <tr style="background: #f47d35;">
                            <th class="service total-bold">#</th>
                            <th class="desc total-bold">Product Name</th>
                            <th class="total-bold">HSN CODE</th>
                            <th class="total-bold">Unit Price</th>
                            <th class="total-bold">Billed Qty</th>
                            <th class="total-bold">Actual Qty.</th>
                            <th class="total-bold">Billing Value</th>
                            <th class="total-bold">GST</th>
                            <th class="total-bold">Tax</th>
                            <th class="total-bold">Invoice Value</th>
                            
                        </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="service"><%# Container.ItemIndex + 1 %></td>
                    <td class="desc">
                        <%#Eval("productname") %> 
                    </td>
                    <td class="unit">
                        <%#Eval("hsn") %>
                    </td>

                    <td class="total" style="text-align: right;">
                        <%#Eval("DP") %>
                    </td>
                    <td class="total" style="text-align: right;">
                        <%#Eval("quantity") %>
                    </td>

                    <td class="total" style="text-align: right;">
                        <%#Eval("quantity") %>
                    </td>
                    <td class="total" style="text-align: right;">
                        <%#Eval("taxable") %>
                    </td>
                    <td class="total" style="text-align: right;">
                        <%#Eval("tax") %>
                    </td>
                    <td class="total" style="text-align: right;">
                        <%#Eval("taxrs") %>
                    </td>
                    <td class="total" style="text-align: right;">
                        <%#Eval("TotalAmt") %>
                    </td>
                    
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                <tr>
                    <td class="total-bold"></td>
                    <td class="total-bold"></td>
                    <td class="total-bold"></td>

                    <td class="total-bold">
                        <span style="font-weight: bold">Total</span>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lbltotalqty1" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lbltotalqty" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lblValue" runat="server"></asp:Label>
                    </td>

                    <td class="total-bold" style="text-align: right;">0
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lblTAX" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold" style="text-align: right;">
                        <asp:Label ID="lbltotal" runat="server"></asp:Label>
                    </td>
                    
                </tr>
                </tbody> </table> 
            </FooterTemplate>
        </asp:Repeater>




        <asp:Repeater ID="RPT_Seller" runat="server">
            <HeaderTemplate>
                <table>
                    <tbody>
                        <tr style="background: #d0d6ff;">
                            <th class="service total-bold">#</th>
                            <th class="desc total-bold">Product Name</th>
                            <th class="total-bold">Unit Price</th>
                            <th class="total-bold">Billed Qty</th>
                            <th class="total-bold">Actual Qty.</th>
                            <th class="total-bold">Billing Value</th>
                            <th class="total-bold">
                                <%=Session["BilltypeValue"].ToString() %>
                            </th>
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
        </asp:Repeater>

        <asp:Repeater ID="RepeaterGST" runat="server">
            <HeaderTemplate>
                <table style="width: 68%; border-collapse: collapse; float: left;">
                    <tbody>
                        <tr style="background: #d0d6ff;">
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



        <table style="width: 30%; margin-left: 2%; float: right">

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
                <td style="border-bottom: none;" class="total-bold">Discount :</td>
                <td class="total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_Discount" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold" style="border-bottom: none;">Courier Charges</td>
                <td class="grand total" style="border-bottom: none; text-align: right;">
                    <asp:Label ID="lbl_CourierCharges" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold">Invoice Value(Rs) :</td>
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
        <hr />
        <div id="notices" style="width: 55%; float: left;">
            <div><b>Terms & Conditions:</b></div>
            <div class="notice">
                1. All Disputes are subject to jurisdiction of <%=method.COMP_STATE %> only.<br />
                2. Company is not responsible after the goods leave the premises.<br />
                3. Any inaccuracy in this bill must be notified within 7 days of receipt of Bill.<br />
                4. Goods provided Free of Cost / Offer, subject to reversal of input tax credit of GST as prevailing.<br />
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
                color: #5D6975;
                text-align: left;
                width: 90px;
                margin-right: 10px;
                display: inline-block;
                font-size: 1.0em;
                line-height: 1.5;
            }

        #company span {
            font-weight: bold;
            color: #5D6975;
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

        #project span {
            font-weight: bold;
        }
    </style>
</body>
</html>
