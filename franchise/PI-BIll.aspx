<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PI-BIll.aspx.cs" Inherits="franchise_PI_BIll" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <%-- <div class="right-sign">
            <img src="../secretadmin/images/right-sign.png">
        </div>--%>
        <div class="tax-invoice">
            <img src="../secretadmin/images/purchase-invoice.png">
        </div>

        <header class="clearfix">
              <img src="../secretadmin/images/logo.png" width="250px">
            
              <div class="clearfix"></div><br /><br />  

            <div id="project">
            <div class="card-group-row row">
             <div class="col-md-2 " style="font-weight: bold;"><span>Vendor Regno : </span> <asp:Label id="lbl_Regno" runat="server"></asp:Label></div>
              <div ><span style="font-weight: bold;" >B_Attention : </span> <asp:Label id="lbl_B_attention" runat="server"></asp:Label> </div>
            </div>
                    <div class="col-sm-6 total-bold" style="font-size:larger;"><asp:Label id="lbl_DisplayName" runat="server" style="width:100%"></asp:Label></div>
                    <div><asp:Label id="lbl_B_Address" runat="server" style="width:100%;font-size:12px;"></asp:Label></div>
                    <div><span style="font-weight: bold;">Zip Code :</span> <asp:Label id="lbl_B_ZipCode" runat="server"></asp:Label>
                     <div><span style="font-weight: bold;">State:</span> <asp:Label id="lbl_B_state" runat="server"></asp:Label></div>  </div>
                    <div><span style="font-weight: bold;">Tel : </span> <asp:Label id="lbl_Phone" runat="server"></asp:Label></div>
                    <div><span style="font-weight: bold;">Email:</span> <asp:Label id="lbl_V_Email" runat="server"></asp:Label> </div>
                    <div><span style="font-weight: bold;">Website :</span> <asp:Label id="lbl_Website" runat="server"></asp:Label></div>
                    <div><span style="font-weight: bold;">GSTIN :</span> <asp:Label id="lbl_GSTIN" runat="server"></asp:Label>  </div>
                    <div><span style="font-weight: bold;">SourceSupply :</span> <asp:Label id="lbl_Source_supply" runat="server"></asp:Label>  </div>
              </div>

              <div id="company" class="clearfix">

                
                <div><span>Franchise Id: </span> <asp:Label id="lbl_Userid" runat="server" ></asp:Label></div>
                <div class="total-bold" style="font-size:larger;"><asp:Label id="lbl_UserName" runat="server" style="width:100%"></asp:Label></div>
                <div><asp:Label id="lbl_UserAdd" runat="server" style="width:100%;font-size:12px;"></asp:Label>
                </div>
                <div><span style="font-weight: bold;">Tel : </span> <asp:Label id="lbl_UserMobileNo" runat="server"></asp:Label> </div>
                <div><span style="font-weight: bold;">Email:</span>  <asp:Label id="lbl_UserEmail" runat="server"></asp:Label> </div>
       
                <div><span style="font-weight: bold;">GSTIN :</span> <asp:Label id="lbl_UserGSTIN" runat="server"></asp:Label> </div>
                <div><span style="font-weight: bold;">PAN :</span> <asp:Label id="lbl_UserPAN" runat="server"></asp:Label> </div>
                <div><span style="font-weight: bold;">CIN :</span> <asp:Label id="lbl_UserCIN" runat="server"></asp:Label> </div>
                <div><span style="font-weight: bold;">Invoice No. :</span> <asp:Label id="lbl_UserINVNo" runat="server"></asp:Label> </div>
                <div><span style="font-weight: bold;">Invoice Date :</span> <asp:Label id="lbl_UserINVDate" runat="server"></asp:Label> </div>
                <div><span style="font-weight: bold;">Date PO No. :</span>  <asp:Label id="lbl_User_Date_PO_NO" runat="server"></asp:Label>     </div>
                <div><span style="font-weight: bold;">E-Way Bill No. : </span>    NA    </div>
              </div>
    </header>


        <asp:Repeater ID="Repeater" runat="server">
            <HeaderTemplate>
                <table>
                    <tbody>
                        <tr style="background: #d0d6ff;">
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

                    <td class="total-bold">
                        0
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
                        <tr style="background: #d0d6ff;">
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
                        <%#Eval("IGSTRS") %>
                    </td>
                    <td>
                        <%#Eval("CGSTRS") %>
                    </td>
                    <td>
                        <%#Eval("SGSTRS") %>
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

        <hr />
        <div id="notices" style="width: 55%; float: left;">
            <div><b>Terms & Conditions:</b></div>
            <div class="notice">
                1. All Disputes are subject to jurisdiction of <asp:Label ID="lbl_F_city" runat="server"></asp:Label> only.<br />
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
                Seller Name: <b>
                    <asp:Label ID="lbl_ComNameFooter" runat="server"></asp:Label>
                </b>
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
                line-height: 1.5;
            }

        #company span {
            font-weight: bold;
            color: #5D6975;
            text-align: left;
            width: 90px;
            margin-right: 10px;
            display: inline-block;
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
