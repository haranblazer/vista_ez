<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PO_BILL.aspx.cs" Inherits="franchise_PO_BILL" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <%--<img src="../images/banner_invoice.jpg" class="banner" />
        <div class="right-sign">
            <img src="../secretadmin/images/right-sign.png">
        </div>--%>
        <div class="tax-invoice">
            <img src="../secretadmin/images/purchase-order.png">
        </div>

        <header class="clearfix">

            <img src="../images/logo.png" class="logo">

            <div class="clearfix"></div>
            <br />
            <br />
          <div class="total-bold" style="margin-top: 2px;"><span>CIN:</span><%=method.COMP_CINNO%>
            </div>
            <div class="clearfix"></div>
            <div id="project">
                <div class="card-group-row row">
                    <div class="col-md-2 " style="font-weight: bold;"><span>FranchiseID : </span>
                        <asp:Label ID="lbl_Regno" runat="server"></asp:Label></div>
                </div>
                <div class="col-sm-6 total-bold" style="font-size: larger;">
                    <asp:Label ID="lbl_DisplayName" runat="server" Style="width: 100%"></asp:Label></div>
                <div>
                    <asp:Label ID="lbl_B_Address" runat="server" Style="width: 100%; height: 40px; font-size: 12px;"></asp:Label></div>
                <div><span style="font-weight: bold;">State:</span>
                    <asp:Label ID="lbl_B_state" runat="server"></asp:Label></div>
                <div><span style="font-weight: bold;">Tel : </span>
                    <asp:Label ID="lbl_Phone" runat="server"></asp:Label></div>
                <div><span style="font-weight: bold;">Email:</span>
                    <asp:Label ID="lbl_F_Email" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">GSTIN :</span>
                    <asp:Label ID="lbl_GSTIN" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">PlaceofSupply :</span><asp:Label ID="lbl_place_supply" runat="server"></asp:Label>
                </div>

            </div>


            <div id="company" class="clearfix">


                <div><span>Franchise Id: </span>
                    <asp:Label ID="lbl_Userid" runat="server"></asp:Label></div>
                <div class="total-bold" style="font-size: larger;">
                    <asp:Label ID="lbl_UserName" runat="server" Style="width: 100%"></asp:Label></div>
                <div>
                    <asp:Label ID="lbl_UserAdd" runat="server" Style="width: 100%; height: 40px; font-size: 12px;"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">State:</span>
                    <asp:Label ID="lbl_UserSate" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">Tel : </span>
                    <asp:Label ID="lbl_UserMobileNo" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">Email:</span>
                    <asp:Label ID="lbl_UserEmail" runat="server"></asp:Label>
                </div>

                <div><span style="font-weight: bold;">GSTIN :</span>
                    <asp:Label ID="lbl_UserGSTIN" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">PAN :</span>
                    <asp:Label ID="lbl_UserPAN" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">CIN :</span>
                    <asp:Label ID="lbl_UserCIN" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">Order No. :</span>
                    <asp:Label ID="lbl_UserINVNo" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">Order Date :</span>
                    <asp:Label ID="lbl_UserINVDate" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">Date PO No. :</span>
                    <asp:Label ID="lbl_User_Date_PO_NO" runat="server"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">E-Way Bill No. : </span>NA    </div>

                <div><span style="font-weight: bold;">Deliver To:</span>
                    <asp:Label ID="lbl_DeliverTo" runat="server" Style="width: 100%; font-size: 12px;"></asp:Label>
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
                            <th class="total-bold">HSN CODE</th>
                            <th class="total-bold">Unit Price</th>
                            <th class="total-bold">Billed Qty</th>
                            <th class="total-bold">Actual Qty.</th>
                            <th class="total-bold">Value</th>
                            <th class="total-bold">GST</th>
                            <th class="total-bold">Tax</th>
                            <th class="total-bold">Total</th>
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
                        <tr style="background: #ddd;">
                            <th class="total-bold">HSN CODE</th>
                            <th class="total-bold">GST Rate</th>
                            <th class="total-bold">Taxable Value</th>
                            <th class="total-bold">CGST</th>
                            <th class="total-bold">SGST</th>
                            <th class="total-bold">IGST</th>
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



        <table style="width: 30%; margin-left: 2%; float: left">

            <tr>
                <td style="border-bottom: none;" class="total-bold">Gross Total Value :</td>
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
                <td class="total-bold" style="border-bottom: none;">Total tax</td>
                <td class="grand total" style="border-bottom: none;">
                    <asp:Label ID="lbl_tottax" runat="server">0</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="total-bold">Net Total Value(Rs) :</td>
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
                6. Goods bought by the puchaser for self consumption purposes, ITC will not be available.<br />
            </div>
        </div>
        <div style="width: 40%; float: left; margin-left: 5%">
            <div>For</div>
            <div class="notice">
                <img src="../images/qr_code_invoice.png" width="70px" style="float: right">
                Seller Name: <b>
                    <asp:Label ID="lbl_ComNameFooter" runat="server"></asp:Label>
                </b>
                This is computer generated Order, thus any physical signature not required.<br />
            </div>
        </div>
        <br />
        <br />
        <br />
    </form>
    <style>
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
                width: 96px;
                margin-right: 10px;
                display: inline-block;
                font-size: 1.0em;
                line-height: 1.5;
                /* font-weight: bold;*/
            }

        #company span {
            /* font-weight: bold;*/
            color: #001028;
            text-align: left;
            width: 96px;
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
