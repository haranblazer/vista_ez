<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Invoice1.aspx.cs" Inherits="Invoice1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- <meta name="viewport" content="width=device-width,initial-scale=1" />--%>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%; border: none;">
            <tbody>
                <tr>
                    <td style="width: 30%; border: none;">
                        <img src="../images/logo.png" class="img-responsive" title="Ocean India" alt="#" style="margin-top: 5px; margin-bottom: 2px; height: 70px;">
                    </td>
                    <td style="width: 70%; border: none; text-align: center">

                        <b><span>Zingool Technologies Pvt. Ltd.</span></b>

                        <div style="clear: both">
                        </div>

                        <span id="lblcaddress">Plot 9, Sector 16A,
Film City,
Noida, UP-201301</span>

                        <div style="clear: both">
                        </div>

                        <span>Phone No :</span><span id="lblcphone">91 72890 88882</span>
                        &nbsp;&nbsp; <span>Email : </span>
                        <span id="lblemailid">care@ezcare.com</span>

                        <div style="clear: both">
                        </div>

                    </td>
                </tr>
            </tbody>
        </table>
        <div style="border-top: 2px solid black; border-bottom: 2px solid black; text-align: center;">
            <b>TAX INVOICE</b>
        </div>
        <table style="width: 100%" cellpadding="0px" cellspacing="0" border="0">
            <tr>
                <td style="width:33.33%">
                    <table>
                        <tr>
                            <td>Order No </td>
                            <td>OR118328 </td>
                        </tr>
                        <tr>
                            <td>Order Date:  </td>
                            <td>30 Mar 2023 </td>
                        </tr>
                        <tr>
                            <td>Payment Status:  </td>
                            <td>Success</td>
                        </tr>
                    </table>
                </td>
                <td style="width:33.33%">
                    <table>
                        <tr>
                            <td>Invoice No </td>
                            <td>UPS055/23/000006  </td>
                        </tr>
                        <tr>
                            <td>Invoice Date </td>
                            <td>30 Mar 2023 </td>
                        </tr>
                        <tr>
                            <td>Place Of Supply  </td>
                            <td>UTTAR PRADESH</td>
                        </tr>
                    </table>
                </td>
                <td style="width:33.33%">
                    <table>
                        <tr>
                            <td>CIN</td>
                            <td>  </td>
                        </tr>
                        <tr>
                            <td>GST </td>
                            <td>  </td>
                        </tr>
                        <tr>
                            <td>Code  </td>
                            <td>0</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div style="border-top: 2px solid black; border-bottom: 2px solid black; text-align: left;">
            Mode of Transport: Self
        </div>
        <table style="width: 100%; font-size: 12px; margin-top: 2px;" cellpadding="0px" cellspacing="0">
            <tr>
                <td style="width: 50%">
                    <table width="100%">
                        <tbody>
                            <tr>
                                <td style="width: 100%; border-bottom: 2px solid black;" colspan="4">
                                    <b>Details of Receiver (Billed to)</b>
                                </td>
                            </tr>
                            <tr>
                                 
                                <td><b>BP ID </b></td>
                                <td>:</td>
                                <td>91554587 </td>
                                <td></td>
                            </tr>
                            <tr>  
                                <td>Name </td>
                                <td>:</td>
                                <td>NIKITA YADAV  </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 20%">Address: </td>
                                <td style="width: 5%">:</td>
                                <td style="width: 60%;">MS. NIKITA YADAV<br>
                                    SHARDA NAGAR KARMETA,  
                                </td>
                                <td style="width: 15%;">Code : 9</td>
                            </tr>
                             <tr>
                                <td>City:</td>
                                <td>:</td>
                                <td>ALLAHABAD </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>State:</td>
                                <td>:</td>
                                <td>UTTAR PRADESH </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Pin Code </td>
                                <td>:</td>
                                <td>211003 </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Mobile</td>
                                <td>:</td>
                                <td>0  </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>PAN</td>
                                <td>:</td>
                                <td>0  </td>
                                <td></td>
                            </tr>
                              <tr>
                                <td>GSTIN</td>
                                <td>:</td>
                                <td>0  </td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td style="width: 50%">
                    <table width="100%">
                        <tbody>
                            <tr>
                                <td style="width: 100%; border-bottom: 2px solid black;" colspan="4">
                                    <b>Details of Receiver (Billed to)</b>
                                </td>
                            </tr>
                            <tr>
                                 
                                <td>BP ID </td>
                                <td>:</td>
                                <td>91554587 </td>
                                <td></td>
                            </tr>
                            <tr>  
                                <td>Name </td>
                                <td>:</td>
                                <td>NIKITA YADAV  </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 20%">Address: </td>
                                <td style="width: 5%">:</td>
                                <td style="width: 60%;">MS. NIKITA YADAV<br>
                                    SHARDA NAGAR KARMETA,  
                                </td>
                                <td style="width: 15%;">Code : 9</td>
                            </tr>
                             <tr>
                                <td>City:</td>
                                <td>:</td>
                                <td>ALLAHABAD </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>State:</td>
                                <td>:</td>
                                <td>UTTAR PRADESH </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Pin Code </td>
                                <td>:</td>
                                <td>211003 </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Mobile</td>
                                <td>:</td>
                                <td>0  </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>PAN</td>
                                <td>:</td>
                                <td>0  </td>
                                <td></td>
                            </tr>
                              <tr>
                                <td>GSTIN</td>
                                <td>:</td>
                                <td>0  </td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>

        </table>

        <table style="width: 100%; border-collapse: separate;" cellpadding="1" cellspacing="1" border="1">
            <tbody>
                <tr>
                    <td style="width: 5%; font-size: 12px">
                        <div style="width: 100%; text-align: left">
                            Item
                        </div>
                        <div style="clear: both">
                        </div>
                        <div style="width: 100%; text-align: left">
                            Code
                        </div>
                    </td>
                    <td style="width: 10%; font-size: 12px">Description
                    </td>
                    <td style="width: 5%; font-size: 12px">HSN<br>
                    </td>
                    <td style="width: 5%; font-size: 12px">MRP
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <div style="width: 100%; text-align: left">
                            Unit
                        </div>
                        <div style="clear: both">
                        </div>
                        <div style="width: 100%; text-align: left">
                            Price
                        </div>
                    </td>
                    <td style="width: 5%; font-size: 12px">Qty
                    </td>

                    <td style="width: 5%; font-size: 12px">Disc
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <div style="width: 100%; text-align: left">
                            Taxable
                        </div>
                        <div style="clear: both">
                        </div>
                        <div style="width: 100%; text-align: left">
                            Value
                        </div>
                    </td>
                    <td style="width: 10%" colspan="2">
                        <table width="100%" style="border: none">
                            <tbody>
                                <tr>
                                    <td style="width: 100%; text-align: center; font-size: 12px" colspan="2">SGST
                                    </td>
                                </tr>
                                <tr>
                                    <td width="50%">Rate
                                    </td>
                                    <td width="50%">Amt
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td style="width: 10%" colspan="2">
                        <table width="100%" style="border: none">
                            <tbody>
                                <tr>
                                    <td style="width: 100%; text-align: center; font-size: 12px" colspan="2">CGST
                                    </td>
                                </tr>
                                <tr>
                                    <td width="50%">Rate
                                    </td>
                                    <td width="50%">Amt
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td style="width: 10%" colspan="2">
                        <table width="100%" style="border: none">
                            <tbody>
                                <tr>
                                    <td style="width: 100%; text-align: center; font-size: 12px" colspan="2">IGST
                                    </td>
                                </tr>
                                <tr>
                                    <td width="50%">Rate
                                    </td>
                                    <td width="50%">Amt
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>

                    <td style="width: 5%; font-size: 12px">Net_Amt
                    </td>
                </tr>

                <tr>
                    <td style="width: 5%; font-size: 12px">11002
                    </td>
                    <td style="width: 10%; font-size: 12px">
                        <span id="rp1_lblpname_0">PCL MALUS CALLUS</span>
                        <span style="color: red;">&nbsp;  </span>

                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_hsncode_0">20089999</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_Label1_0">4000</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblrate_0">2678.57</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblqty_0">2</span>
                    </td>

                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_Label2_0">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblvalue_0">5357</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblsgrate_0">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblsgamount_0">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblcgrate_0">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblcgamount_0">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbligrate_0">12</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbligamount_0">642.86</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblamount_0">6000</span>
                    </td>
                </tr>

                <tr>
                    <td style="width: 5%; font-size: 12px">11021
                    </td>
                    <td style="width: 10%; font-size: 12px">
                        <span id="rp1_lblpname_1">PHYGRO HAIR NOURISHMENT CAPSULE</span>
                        <span style="color: red;">&nbsp; Scheme </span>

                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_hsncode_1">21069099</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_Label1_1">650</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblrate_1">0.84746</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblqty_1">1</span>
                    </td>

                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_Label2_1">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblvalue_1">1</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblsgrate_1">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblsgamount_1">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblcgrate_1">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblcgamount_1">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbligrate_1">18</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbligamount_1">0.15254</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lblamount_1">1</span>
                    </td>
                </tr>

                <tr>
                    <td style="width: 5%; font-size: 12px"></td>
                    <td style="width: 10%; font-size: 12px"></td>
                    <td style="width: 5%; font-size: 12px"></td>
                    <td style="width: 5%; font-size: 12px"></td>
                    <td style="width: 5%; font-size: 12px">
                        <span style="font-weight: bold"></span>Total
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotalqty" style="font-weight: bold">3</span>
                    </td>

                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotaldisc" style="font-weight: bold">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotalvalue" style="font-weight: bold">5358</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotalsgrate" style="font-weight: bold"></span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotalsgamount" style="font-weight: bold">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotalcgrate" style="font-weight: bold"></span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotalcgamount" style="font-weight: bold">0</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotaligrate" style="font-weight: bold"></span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotaligamount" style="font-weight: bold">643.01254</span>
                    </td>
                    <td style="width: 5%; font-size: 12px">
                        <span id="rp1_lbltotalamt" style="font-weight: bold">6001</span>
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="width: 100%" cellpadding="0px" cellspacing="0">
            <tbody>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <table style="width: 100%; font-size: 12px">
                            <tbody>
                                <tr>
                                    <td style="width: 30%">Invocie Total (In Words):<br>
                                        &nbsp;&nbsp;<span id="lblwords">(Rupees Six Thousand And One Only)</span>
                                    </td>
                                    <td style="width: 20%">
                                        <span style="font-weight: bold">Courier Charge:
                                    <span id="lbl_CourierCharge">0</span></span>
                                    </td>

                                    <td style="width: 50%">
                                        <span style="font-weight: bold">Invoice Total:
                                    <span id="lblallamount">6001.00</span></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>

                        <table style="width: 100%; font-size: 12px">
                            <tbody>
                                <tr>
                                    <td style="width: 20%">Total BV:
                                    </td>
                                    <td style="width: 20%">
                                        <span id="lblpv">3780</span>
                                    </td>
                                    <td style="width: 20%"></td>
                                </tr>

                                <tr>
                                    <td style="width: 20%">SNO
                                    </td>
                                    <td style="width: 20%">Payment Mode
                                    </td>
                                    <td style="width: 20%">Amount
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%">1
                                    </td>
                                    <td style="width: 20%">
                                        <span id="lblpaymode">Cash</span>
                                    </td>
                                    <td style="width: 20%">
                                        <span id="lblamount">6001.00</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>






                <tr>
                    <td>
                        <table style="width: 100%; height: 20%">
                            <tbody>
                                <tr>
                                    <td style="width: 60%; font-size: 12px">
                                        <ol type="1">
                                            <b><u>Terms &amp; Conditions : </u></b>
                                            <li>Seller is not responsible for any loss or damage of goods in transit. </li>
                                            <li>Please store above mentioned products at cool place and away from sunlight.</li>
                                            <li>Any inaccuracy in this bill must be notified immediately on its receipt.</li>
                                            <li>Disputes if any will be subject to
                                        <span id="lblcstate" style="display: none;">Varanasi</span>
                                                Varanasi
                                        court jurisdiction.</li>
                                        </ol>
                                    </td>
                                    <td style="width: 40%;">
                                        <div style="text-align: left; font-size: 12px; margin-top: 5px; padding-left: 20px">
                                            FOR
                                    <b><span id="lblcompanyname2">Phytocell Life Marketing Pvt Ltd</span></b>
                                        </div>
                                        <div style="text-align: left; height: 50px">
                                        </div>

                                        <div style="text-align: left; font-size: 13px; padding-left: 20px">
                                            <span><b>Authorized Signatory:</b></span>

                                        </div>
                                        <div style="text-align: left; font-size: 12px; padding-left: 20px">
                                            <span>Prepared By:</span><span id="lblpreparedby">Mr. Amit Sarin</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="text-align: left; font-size: 10px">
                            <u>Registered Office : </u>
                            <span id="lblcompanyname33">C 33/2, 3rd Floor, Prem Complex, Chandua, 
Chhittupur, Varanasi, Varanasi, Uttar Pradesh, India, 221001</span><span></span>
                        </div>
                    </td>
                </tr>

            </tbody>
        </table>
    </form>
    <style type="text/css">
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
        /*   table, th, td {
            border-collapse: collapse;
            text-indent: 10px;
            border: 0.1pt solid black;
            padding: 0px;
            margin: 0px;
        }*/
    </style>
</body>
</html>

