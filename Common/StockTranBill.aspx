<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockTranBill.aspx.cs" Inherits="secretadmin_StockGstBill" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style>
        .bold-text {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
       <%--  <img src="../images/banner_invoice.jpg" class="banner" />
        <div class="right-sign">
            <img src="../secretadmin/images/right-sign.png">
        </div>--%>
        <div class="tax-invoice" id="Idtaxinvoice" runat="server">
            <img src="../secretadmin/images/tax-invoice.png">
        </div>
        <div class="tax-invoice" id="Idsalesinvoice" runat="server">
            <img src="../secretadmin/images/sales-invoice.png">
        </div>
        <header class="clearfix">
              <img src="../images/logo.png" class="logo">

            <img src="../images/billcancel.png" class="cancel" style="position: absolute; right: 0px; top: 162px; width: 95%; z-index: 0000000000;" id="imgbill" runat="server" />
            <div class="clearfix"></div>
            <br />
            <br />
           <div class="total-bold" style="margin-top: 2px;"><span>CIN:</span><%=method.COMP_CINNO%>
            </div>
            <div class="clearfix"></div>
            <div id="project">
                <div class="card-group-row row">
                    
                    <div class="col-md-2">
                        <span class="bold-text">Franchise id : </span>
                        <asp:Label ID="lbl_Regno" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-sm-6 total-bold" style="font-size: larger;">
                    <asp:Label ID="lbl_DisplayName" runat="server" Style="width: 100%"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lbl_B_Address" runat="server" Style="width: 100%;     height: 40px; font-size: 12px;"></asp:Label>
                </div>
                <div>
                    <span style="font-weight: bold;">State:</span>
                    <asp:Label ID="lbl_B_state" runat="server"></asp:Label>
                </div>
                 <div>
                    <span style="font-weight: bold;">Tel : </span>
                    <asp:Label ID="lbl_Phone" runat="server"></asp:Label>
               
               
                    <span style="font-weight: bold;">Email:</span>
                    <asp:Label ID="lbl_F_Email" runat="server"></asp:Label>
                     </div>
 <div>
     <span style="font-weight: bold;">GSTIN :</span>
                    <asp:Label ID="lbl_GSTIN" runat="server"></asp:Label>
                
                
                    <span style="font-weight: bold;">PAN :</span>
                    <asp:Label ID="lbl_UserPAN" runat="server"></asp:Label>
                </div>
                <hr />
                <div>
                    <span style="font-weight: bold;">CIN :</span>
                    <asp:Label ID="lbl_UserCIN" runat="server"></asp:Label>
                </div>
                <div>
                    <span style="font-weight: bold;">PlaceofSupply :</span><asp:Label ID="lbl_place_supply" runat="server"></asp:Label>
                </div>
                <div>
                    <span style="font-weight: bold;">Invoice No. :</span>
                    <asp:Label ID="lbl_UserINVNo" runat="server"></asp:Label>
               
                    <span style="font-weight: bold;">Invoice Date :</span>
                    <asp:Label ID="lbl_UserINVDate" runat="server"></asp:Label>
                </div>
                <div>
                    <span style="font-weight: bold;">PO No. :</span>
                    <asp:Label ID="lbl_User_PO_NO" runat="server"></asp:Label>
                
                    <span style="font-weight: bold;">E-Way Bill No. : </span>NA    </div>
                <div>
                    <span style="font-weight: bold;">Pay Mode :</span>
                    <asp:Label ID="lbl_PayMode" runat="server"></asp:Label>
                </div>
            </div>

            <div id="company" class="clearfix">
                <div>
                    <span class="bold-text">Franchise Id: </span>
                    <asp:Label ID="lbl_Userid" runat="server"></asp:Label>
                </div>
                <div class="total-bold" style="font-size: larger;">
                    <asp:Label ID="lbl_UserName" runat="server" Style="width: 100%"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lbl_UserAdd" runat="server" Style="width: 100%;     height: 40px; font-size: 12px;"></asp:Label>
                </div>
                <div>
                    <span style="font-weight: bold;">State:</span>
                    <asp:Label ID="lbl_UserSate" runat="server"></asp:Label>
                </div>
                 <div>
                    <span style="font-weight: bold;">Tel : </span>
                    <asp:Label ID="lbl_UserMobileNo" runat="server"></asp:Label>
               
               
                    <span style="font-weight: bold;">Email:</span>
                    <asp:Label ID="lbl_UserEmail" runat="server"></asp:Label>
               
                   
                </div>

                <div>
                     <span style="font-weight: bold;">GSTIN :</span>
                    <asp:Label ID="lbl_UserGSTIN" runat="server"></asp:Label>
                    <span class="bold-text">PAN :</span>
                    <asp:Label ID="lbl_ComPanNo" runat="server"></asp:Label>
                </div>
                <hr />
                <div>
                    <span class="bold-text">CIN :</span>
                    <asp:Label ID="lbl_ComCIN" runat="server"></asp:Label>
                </div>
                <div>
                    <b>Shipping Address : </b>
                    <asp:Label ID="lbl_ShipingAdd" Width="100%" runat="server"></asp:Label>
                </div>
                <div>
                    <span class="bold-text">Transport Name: </span>
                    <asp:Label ID="lbl_TransportName" runat="server"></asp:Label>
                
                    <span class="bold-text">Bility No.: </span>
                    <asp:Label ID="lbl_BilityNo" runat="server"></asp:Label>
                </div>

            </div>
        </header>


        <asp:Repeater ID="Repeater" runat="server">
            <HeaderTemplate>
                <table align="right">
                    <tbody>
                        <tr style="background: #ddd;">
                            <th class="service total-bold">#</th>
                            <th class="desc total-bold">Product Name</th>
                            <th class="total-bold">HSN CODE</th>
                            <th class="total-bold">Unit Price</th>
                            <th class="total-bold">Billed Qty</th>
                            <th class="total-bold">Actual Qty.</th>
                            <th class="total-bold">Billing Value</th>
                            <th class="total-bold">GST Rate</th>
                            <th class="total-bold">GST Value</th>
                            <th class="total-bold">Invoice Value</th>
                            <th class="total-bold">RPV</th>
                        </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="service"><%# Container.ItemIndex + 1 %></td>
                    <td class="desc">
                        <%#Eval("productname") %> 
                    </td>
                    <td class="unit">
                        <%#Eval("HSN")%>
                    </td>

                    <td class="total">
                        <%#Eval("Rate")%>
                    </td>
                    <td class="total">
                        <%#Eval("quantity") %>
                    </td>
                    <td class="total">
                        <%#Eval("quantity") %>
                    </td>
                    <td class="total">
                        <%#Eval("taxable")%>
                    </td>
                    <td class="total">
                        <%#Eval("tax") %>
                    </td>
                    <td class="total">
                        <%#Eval("taxrs") %>
                    </td>
                    <td class="total">
                        <%#Eval("TotalAmt") %>
                    </td>
                    <td class="total">
                        <%#Eval("TotalBV") %>
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
                    <td class="total-bold">
                        <asp:Label ID="lbltotalqty1" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lbltotalqty" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lblValue" runat="server"></asp:Label>
                    </td>

                    <td class="total-bold">0
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lblTAX" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lbltotal" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold"> 
                         <asp:Label ID="lbl_TotalRPV" runat="server"></asp:Label>
                    </td>
                     
                </tr>
                </tbody> </table> 
            </FooterTemplate>
        </asp:Repeater>

        <asp:Repeater ID="RPT_Seller" runat="server">
            <HeaderTemplate>
                <table>
                    <tbody>
                        <tr style="background: #ddd;">
                            <th class="service total-bold">#</th>
                            <th class="desc total-bold">Product Name</th>
                            <th class="total-bold">HSN CODE</th>
                            <th class="total-bold">Unit Price</th>
                            <th class="total-bold">Billed Qty</th>
                            <th class="total-bold">Actual Qty.</th>
                            <th class="total-bold">Billing Value</th>
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
                        <%#Eval("HSN")%>
                    </td>

                    <td class="total">
                        <%#Eval("DPWithTax")%>
                    </td>
                    <td class="total">
                        <%#Eval("quantity") %>
                    </td>
                    <td class="total">
                        <%#Eval("quantity") %>
                    </td>
                    <td class="total">
                        <%#Eval("TotalAmt")%>
                    </td>
                    <td class="total">
                        <%#Eval("TotalAmt")%>
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
                    <td class="total-bold">
                        <asp:Label ID="lbltotalqty1" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lbltotalqty" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lbltotal" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lblValue" runat="server"></asp:Label>
                    </td>
                </tr>
                </tbody> </table> 
            </FooterTemplate>
        </asp:Repeater>

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
                    <td>
                        <%#Eval("HSN") %>
                    </td>

                    <td>
                        <%#Eval("tax") %>
                    </td>
                    <td>
                        <%#Eval("taxable") %>
                    </td>
                    <td>
                        <%#Eval("CGSTRS") %>
                    </td>
                    <td>
                        <%#Eval("SGSTRS") %>
                    </td>
                    <td>
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
                    <td class="total-bold">
                        <asp:Label ID="lblTaxablevalue" runat="server"></asp:Label>
                    </td>

                    <td class="total-bold">
                        <asp:Label ID="lblCGST" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lblSGST" runat="server"></asp:Label>
                    </td>
                    <td class="total-bold">
                        <asp:Label ID="lblIGST" runat="server"></asp:Label>
                    </td>
                </tr>
                </tbody> </table> 
            </FooterTemplate>
        </asp:Repeater>



        <table style="width: 30%; margin-left: 2%; float: right">

            <tr>
                <td style="border-bottom: none;" class="total-bold">Net Billing Value :</td>
                <td class="total" style="border-bottom: none;">
                    <asp:Label ID="lbl_GrossTotal" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: none;" class="total-bold">Discount :</td>
                <td class="total" style="border-bottom: none;">
                    <asp:Label ID="lbl_Discount" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold" style="border-bottom: none;" id="gstr" runat="server">GST :</td>
                <td class="grand total" style="border-bottom: none;">
                    <asp:Label ID="lbl_tottax" runat="server">0</asp:Label>
                </td>
            </tr>
             <tr>
                <td class="total-bold">RPV:</td>
                <td class="grand total">
                    <asp:Label ID="lbl_RPV" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold">FPV:</td>
                <td class="grand total">
                    <asp:Label ID="lbl_FPV" runat="server">0</asp:Label>
                </td>
            </tr>

             <tr>
                <td class="total-bold">Delivery Charge:</td>
                <td class="grand total">
                    <asp:Label ID="lbl_DeliveryCharge" runat="server">0</asp:Label>
                </td>
            </tr>
             <tr>
                <td class="total-bold">GST Delivery :</td>
                <td class="grand total">
                    <asp:Label ID="lbl_GSTDelivery" runat="server">0</asp:Label>
                </td>
            </tr>
              
            <tr>
                <td class="total-bold">Gross Invoice Value(Rs) :</td>
                <td class="grand total">
                    <asp:Label ID="lbl_NetTotal" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold">Gross Weight :</td>
                <td class="total-bold">
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
                3. Any inaccuracy in this bill must be notified within 7 days of receipt of Bill.<br />
                4. Goods provided Free of Cost / Offer, subject to reversal of input tax credit of GST as prevailing.<br />
                5. Goods bought by the puchaser for self consumption purposes, ITC will not be available.<br />

            </div>
        </div>
        <div style="width: 40%; float: right; text-align:end; /*margin-left: 150%*/">
            
            <div class="notice">
                For<b>
                <asp:Label ID="lbl_sellerName" runat="server">0</asp:Label></b>
                <b>
                    <asp:Label ID="lbl_ComNameFooter" runat="server"></asp:Label>
                </b>
                <br />
                <br />
                <img src="../images/ezcare_sign.png" width="120px" />
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
