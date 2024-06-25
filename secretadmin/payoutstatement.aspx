<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="true"  CodeFile="payoutstatement.aspx.cs" Inherits="payoutstatement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Payout Statement</title>
    <style type="text/css">
        .style1
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: small;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        </div>
            <br />
            <br />
            <p align="center">
            </p>
            <p align="center">
            </p>
            <hr color="#000000" size="1" style="width: 1025px" />
            <p>
            </p>
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="80%">
                <tr>
                    <td align="left" style="text-align: center">
                    </td>
                    <td valign="top">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="text-align: left; height: 23px;">
                        <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="12px"></asp:Label></td>
                    <td valign="top" style="height: 23px">
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3" style="height: 2px">
                        <hr color="#000000" size="1" />
                        <asp:Label ID="Label10" runat="server" Font-Bold="True" Width="169px" Font-Names="Arial" Font-Size="14px" ForeColor="Black"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" style="height: 48px">
                        <br />
                        <span style="font-size: 10pt; font-family: Arial">
                        We are thankful to all our Associate Members for their overwhelming response to
                        our <b>Business Plan</b>. We assure you that the confidence, which you all have
                        invested in us will go a long way.</span></td>
                </tr>
                <tr>
                    <td align="left">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3" style="height: 2px">
                        <hr color="#000000" size="1" />
                    </td>
                </tr>
            </table>
            <table align="center" border="0" cellpadding="0" cellspacing="1" width="80%">
                <tr>
                    <!--
          <td align=center>
            
              <B>Payout No. : 1 </B>  </div></td>
        -->
                    <td align="center" style="text-align: center">
                        <b><span style="font-size: 10pt; font-family: Arial">Payout Period :</span>
                            <asp:Label ID="Label20" runat="server" Font-Names="Arial" Font-Size="12px"></asp:Label></b>
                    </td>
                </tr>
                
                <tr>
                    <td align="center" colspan="3" style="height: 2px">
                        <hr color="#000000" size="1" />
                    </td>
                </tr>
                
                <tr>
                    <td align="center" colspan="3" style="height: 302px">
                        <table runat="server"  align="left" border="1" bordercolor="#000000" cellpadding="1" cellspacing="1"
                            width="50%" id="Table1">
                            <tr>
                                <td style="height: 20px;" colspan="2">
                                    <span style="font-size: 10pt; font-family: Arial"><strong>Team Size</strong></span></td>
                                
                            </tr>
                            <tr>
                                <td style="height: 20px; width: 203px;">
                                    <span style="font-size: 10pt; font-family: Arial">Total Paid </span>
                                </td>
                                <td align="center" style="height: 20px">
                                    <asp:Label ID="lblTotalPaid" runat="server" Text="0" Font-Size="12px" 
                                        Font-Names="Arial"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 203px">
                                    <span style="font-size: 10pt; font-family: Arial">
                                    Newly Paid </span>
                                </td>
                              <td align="center">
                                    <asp:Label ID="lblTotalNewpaid" runat="server" Text="0" Font-Size="12px" 
                                        Font-Names="Arial"></asp:Label></td>
                            </tr>
                            <tr id="hj" runat="server" visible="false">
                                <td align="center" style="width: 203px">
                                    <span style="font-size: 10pt; font-family: Arial" >
                                    Brought Forward</span></td>
                                <td align="center">
                                    <asp:Label ID="lblbrtfrwd" runat="server" Text="0" Font-Size="12px" 
                                        Font-Names="Arial"></asp:Label></td>
                            </tr>
                            <tr >
                                <td align="center" style="height: 19px; width: 203px;">
                                    <span style="font-size: 10pt; font-family: Arial">Total Pair </span>
                                </td>
                                <td align="center" style="height: 19px;">
                                <asp:Label ID="lbltotpair" runat="server"
                                        Text="0" Font-Size="12px" Font-Names="Arial"></asp:Label></td>
                            </tr>
                            <tr id="ff" runat="server">
                               <td align="center" style="width: 203px">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">
                                    Calculated Paid
                                    </span></span>
                                </td>
                               <td align="center">
                                    
                                        <asp:Label ID="lblCalculatepaid" runat="server" Text="0" Font-Size="12px" 
                                        Font-Names="Arial"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" style="text-align: center">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">
                                    Carried Forward
                                    </span></span></td>
                                <td align="center" style="text-align: center">
                                    
                                        <asp:Label ID="lblCarriefrwd" runat="server" Text="0" Font-Size="12px" 
                                        Font-Names="Arial"></asp:Label></td>
                            </tr>
                            <tr  runat="server" >
                                <td style="height: 28px; width: 203px;">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">GPV
                                    </span></span></td>
                               
                                <td style="height: 28px">
                                    <asp:Label ID="lblGBV" runat="server" Text="0"></asp:Label></td>
                            </tr>
                            <tr >
                                <td style="width: 203px">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">PPV
                                    </span></span></td>
                                <td>
                                    <asp:Label ID="lblPBV" runat="server" Text="0"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 203px">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">Level
                                    </span></span></td>
                                <td style="height: 28px; text-align: center">
                                    <asp:Label ID="lblLevel" runat="server" Text="0"></asp:Label></td>
                            </tr>
                        </table><table align="center" border="1" bordercolor="#000000" cellpadding="1" cellspacing="1"
                            width="50%">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt"><span style="font-family: Arial">&nbsp; <strong>Type Of
                                        &nbsp;Incomes</strong></span></span></td>
                                <td align="right" style="width: 114px">
                                    <b><span style="font-size: 10pt; font-family: Arial">Amount</span></b>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 10px">
                             
                                        <span style="font-size: 10pt; font-family: Arial">
                                        Binary Income</span>
                                </td>
                                <td align="right" style="width: 114px; height: 10px;">
                                    <asp:Label ID="lblBinaryIncome" runat="server" Font-Names="Arial" Font-Size="12px"
                                        Text="0"></asp:Label></td>
                            </tr>
                    <%--<tr>
                        <td>
                            <span style="font-size: 10pt">Direct Income</span></td>
                        <td align="right" style="width: 114px">
                            <asp:Label ID="lblDirect" runat="server" Font-Names="Arial" Font-Size="12px" Text="0"></asp:Label></td>
                    </tr>--%>
                    <%--<tr>
                        <td>
                            <span style="font-size: 10pt">ROI Of Plan A</span></td>
                        <td align="right" style="width: 114px">
                            <asp:Label ID="lblROIA" runat="server" Font-Names="Arial" Font-Size="12px" Text="0"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-size: 10pt">ROI Of Plan B</span></td>
                        <td align="right" style="width: 114px">
                            <asp:Label ID="lblROIB" runat="server" Font-Names="Arial" Font-Size="12px" Text="0"></asp:Label></td>
                    </tr>--%>
                    <tr>
                        <td>
                            <span style="font-size: 10pt; font-family: Arial">
                            Leader Ship Bonus Income</span></td>
                        <td align="right" style="width: 114px">
                            <asp:Label ID="lblLB" runat="server" Font-Names="Arial" Font-Size="12px" Text="0"></asp:Label></td>
                    </tr><tr>
                        <td class="style1">
                            Royalty Income</td>
                        <td align="right" style="width: 114px">
                            <asp:Label ID="lblRoyalty" runat="server" Font-Names="Arial" Font-Size="12px" 
                                Text="0"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Performance Bonus</td>
                        <td align="right" style="width: 114px">
                            <asp:Label ID="lblPerformanceBonus" runat="server" Font-Names="Arial" Font-Size="12px" 
                                Text="0"></asp:Label></td>
                    </tr>
                            <tr>
                                <td>
                                    <span style="font-size: 10pt"><span style="font-family: Arial">
                                    <b>Total Earning</b>
                                    </span></span>
                                </td>
                                <td align="right" style="width: 114px">
                                    <b><asp:Label ID="totalearning" runat="server" Text="0" Font-Size="12px" Font-Names="Arial"></asp:Label></b></td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial">
                                    TDS </span>
                                </td>
                                <td align="right" style="width: 114px">
                                    <asp:Label ID="Label13" runat="server" Text="0" Font-Size="12px" Font-Names="Arial"></asp:Label>
                                    </td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial">Handling Charges </span>
                                </td>
                                <td align="right" style="width: 114px">
                                    <asp:Label ID="Label14" runat="server" Text="0" Font-Size="12px" Font-Names="Arial"></asp:Label></td>
                            </tr>
                    <tr visible="false" runat="server" >
                        <td>
                            <span style="font-size: 10pt; font-family: Arial">
                            E-Wallet Fund</span></td>
                        <td align="right" style="width: 114px">
                            <asp:Label ID="lblEfund" runat="server" Font-Names="Arial" Font-Size="12px" Text="0"></asp:Label></td>
                    </tr>
                            <tr>
                                <td>
                                    <b><span style="font-size: 10pt; font-family: Arial">Net Earning</span></b></td>
                                <td align="right" style="width: 114px">
                                    <b><asp:Label ID="Label15" runat="server" Text="0" Font-Size="12px" Font-Names="Arial"></asp:Label></b> </td>
                            </tr>
                            <tr id="dd" visible="false" runat="server" >
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial">
                                    Draft/Cheque no</span></td>
                                <td align="right" style="text-align: right; width: 114px;">
                                    <asp:Label ID="Label26" runat="server" Text="0" Font-Size="12px" Font-Names="Arial"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 23px">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3" style="height: 2px">
                        <hr color="#000000" size="1" />
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="3" valign="justify" width="80%">
                        &nbsp; <span style="font-size: 10pt; font-family: Arial">We assure that, we can create a mutually beneficial long term working relationship
                        with you and assure you of our full cooperation in making this tie up a success
                        for both of us. </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: left; height: 21px;"><hr color="#000000" size="1" />
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: center">
                        &nbsp;&nbsp; <span style="font-size: 10pt; font-family: Arial">This is computer generated document. No signature required.</span></td>
                </tr>
                <tr>
                    <td align="center" colspan="3" height="2">
                        <hr color="#000000" size="1" /><a href="javascript:history.back()">
        <img alt="Back" border="0" src="../admin_images/btn_prev.gif" /></a>
                    </td>
                </tr>
            </table>
        </form>
    
    </div>
    </form>
</body>
</html>
