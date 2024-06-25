<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintReport.aspx.cs" Inherits="admin_PrintReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <style type="text/css">
.break (page-break-after: always)
</style>
</head>
<body>
    <form id="form1" runat="server">
   <center> <div> <asp:Repeater   ID="Repeater1" runat="server">
      <HeaderTemplate> </HeaderTemplate>
      <ItemTemplate>
        <br />
            <br />
     <table align="center" border="0" cellpadding="0" cellspacing="0" width="80%">
                <tr>
                    <td align="left" style="text-align: center">
                    </td>
                    <td valign="top">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="text-align: left"><table style="width: 362px">
                         <tr>
                             <td colspan="2" style="height: 20px">
                <asp:Label ID="Label11" Width="150px" style="text-align:left" runat="server" Font-Names="Verdana" Font-Bold="True" Text='<%# DataBinder.Eval (Container.DataItem, "appmstregno") %>' Font-Size="10pt"></asp:Label>
                             </td>
                         </tr>
                     
            <tr>
                <td style="height: 20px;" colspan="2"> <asp:Label ID="Label21" Width="400px" runat="server" Font-Names="Verdana" Font-Bold="True" Text='<%# DataBinder.Eval (Container.DataItem, "name") %>' Font-Size="10pt"></asp:Label>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <span style="font-size: 10pt; font-family: Verdana">
                    Address : 
                    <asp:Label ID="Label12" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt"
                        Text='<%# DataBinder.Eval (Container.DataItem, "appmstaddress1") %>' Width="200px"></asp:Label></span></td>
            </tr>
            <tr>
                <td colspan="2">
                    <span style="font-size: 10pt; font-family: Verdana">
                    District :&nbsp;
                        <asp:Label ID="Label22" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt"
                        Text='<%# DataBinder.Eval (Container.DataItem, "distt") %>' Width="200px"></asp:Label></span></td>
            </tr>
            <tr>
                <td colspan="2">
                    <span style="font-size: 10pt; font-family: Verdana">
                    City : &nbsp; &nbsp;&nbsp;
                        <asp:Label ID="Label23" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt"
                        Text='<%# DataBinder.Eval (Container.DataItem, "AppMstCity") %>' Width="200px"></asp:Label></span></td>
            </tr>
            <tr>
                <td colspan="2">
                    <span style="font-size: 10pt; font-family: Verdana">
                    State : &nbsp;&nbsp;
                    <asp:Label ID="Label24" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt"
                        Text='<%# DataBinder.Eval (Container.DataItem, "AppMstState") %>' Width="200px"></asp:Label></span></td>
            </tr>
            <tr>
                <td colspan="2">
                    <span style="font-size: 10pt; font-family: Verdana">Pin Code :<asp:Label ID="Label25" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt"
                        Text='<%# DataBinder.Eval (Container.DataItem, "AppMstPinCode") %>' Width="200px"></asp:Label></span></td>
            </tr>
            <tr>
                <td style="height: 18px;" colspan="2">
                    <span style="font-size: 10pt; font-family: Verdana">Mob No :
                        <asp:Label ID="Label27" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt"
                        Text='<%# DataBinder.Eval (Container.DataItem, "AppMstMobile") %>' Width="200px"></asp:Label></span></td>
            </tr>
        </table>
                        </td>
                    <td valign="top">
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3" height="2">
                        <hr color="#000000" size="1" />
                        <asp:Label ID="Label10" runat="server" Font-Bold="True"  Text='<%# DataBinder.Eval (Container.DataItem, "appmstregno") %>' Width="169px" Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left">
                        <br />
                        <span style="font-size: 10pt; font-family: Verdana">
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
                        <b><span style="font-size: 10pt; font-family: Verdana">Payout Period :</span>
                            <asp:Label ID="Label20" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "payoutperiod") %>' Font-Names="Verdana" Font-Size="10pt"></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3" style="height: 2px">
                        <hr color="#000000" size="1" />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3" style="height: 22px"> <table runat="server"  align="left" border="1" bordercolor="#000000" cellpadding="1" cellspacing="1"
                            width="50%" id="Table1">
                            <tr>
                                <td style="width: 203px; text-align: center;">
                                    <span style="font-size: 10pt; font-family: Verdana;"><strong>Team Size&nbsp; </strong></span>
                                </td>
                                <td style="width: 63px; text-align: center;">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">
                                    <b>Left</b> </span></span>
                                </td>
                                <td style="text-align: center">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">
                                    <b>Right</b> </span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 20px; width: 203px; text-align: center;">
                                    <span style="font-size: 10pt; font-family: Verdana">Total Paid </span>
                                </td>
                                <td align="center" style="width: 63px; height: 20px;">
                                    <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "TPL") %>' Font-Names="Verdana" Font-Size="10pt"></asp:Label></td>
                                <td align="center" style="height: 20px">
                                    <asp:Label ID="Label5" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "TPR") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 203px; text-align: center;">
                                    <span style="font-size: 10pt; font-family: Verdana">
                                    Newly Paid </span>
                                </td>
                               <td align="center" style="width: 63px">
                                    <asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "NPL") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label>
                                    </td>
                              <td align="center">
                                    <asp:Label ID="Label6" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "NPR") %>' Font-Names="Verdana" Font-Size="10pt"></asp:Label></td>
                            </tr>
                            <tr id="hj" runat="server">
                                <td align="center" style="width: 203px">
                                    <span style="font-size: 10pt; font-family: Verdana" >
                                    Brought Forward</span></td>
                               <td align="center" style="width: 63px">
                                    <asp:Label ID="Label3" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "BFL") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                                <td align="center">
                                    <asp:Label ID="Label7" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "BFR") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                            </tr>
                            <tr >
                                <td align="center" style="height: 19px; width: 203px;">
                                    <span style="font-size: 10pt; font-family: Verdana">Total Pair </span>
                                </td>
                                <td align="center" style="height: 19px; width: 63px;">
                                <asp:Label ID="lbltotpair" runat="server"
                                        Text="0" Font-Bold="True" Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                                <td align="center" style="height: 19px">
                                </td>
                            </tr>
                            <tr id="ff" runat="server">
                               <td align="center" style="width: 203px">
                                    <b><span style="font-size: 10pt; font-family: Verdana">Total </span></b>
                                </td>
                                <td align="center" style="width: 63px">
                                    <b>
                                        <asp:Label ID="Label4" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "CPL") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></b></td>
                               <td align="center">
                                    <b>
                                        <asp:Label ID="Label8" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "CPR") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></b></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="3" style="text-align: right">
                                    &nbsp; &nbsp;</td>
                            </tr>
                            <tr runat="server" >
                                <td style="height: 28px; width: 203px;">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">
                                    Calculated Paid
                                    </span></span>
                                </td>
                                <td style="width: 63px; height: 28px; text-align: center;">
                                    <strong>
                                        <asp:Label ID="Label16" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "CPL") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></strong></td>
                                <td style="height: 28px; text-align: center;">
                                    <strong>
                                        <asp:Label ID="Label18" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "CPR") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></strong></td>
                            </tr>
                            <tr runat="server">
                                <td style="width: 203px">
                                    <span style="font-family: Arial"><span style="font-size: 10pt">
                                    Carried Forward
                                    </span></span>
                                </td>
                                <td style="width: 63px; text-align: center;">
                                    <strong>
                                        <asp:Label ID="Label17" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "CFL") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></strong>&nbsp;</td>
                                <td style="text-align: center">
                                    <strong>
                                        <asp:Label ID="Label19" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "CFR") %>' Width="13px" Font-Size="10pt" Font-Names="Verdana"></asp:Label></strong>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3" style="height: 28px; text-align: right">
                                    <span style="color: #ffffff">.</span></td>
                            </tr>
                        </table>
                
                       <table align="center" border="1" bordercolor="#000000" cellpadding="1" cellspacing="1"
                            width="50%">
                            <tr>
                                <td>
                                    <strong><span style="font-size: 10pt; font-family: Verdana">Type Of &nbsp;Income</span></strong></td>
                                <td align="right">
                                    <b><span style="font-size: 10pt; font-family: Verdana">Amount</span></b>
                                </td>
                            </tr>
                            
                          
                            <tr id="in8d" runat="server" >
                                <td style="height: 19px">
                                    <span style="font-size: 10pt; font-family: Verdana">
                                        Binary Income</span></td>
                                <td align="right" style="height: 19px">
                                    <asp:Label ID="txtjumbo2" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "binaryamt") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                            </tr>
                    <tr id="Tr1" runat="server" >
                                <td style="height: 19px">
                                    <span style="font-size: 10pt; font-family: Verdana">
                                        Leader Ship Bonus Income</span></td>
                                <td align="right" style="height: 19px">
                                    <asp:Label ID="Label9" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "leadershipamt") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                            </tr>
                            <tr id="Tr2" runat="server" >
                                <td style="height: 19px">
                                    <span style="font-size: 10pt; font-family: Verdana">
                                        Royalty Income</span></td>
                                <td align="right" style="height: 19px">
                                    <asp:Label ID="Label28" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "royaltyamt") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                            </tr>
                              <%--<tr id="Tr2" runat="server" >
                                <td style="height: 19px">
                                    <span style="font-size: 10pt; font-family: Verdana">
                                        ROI Of Plan A</span></td>
                                <td align="right" style="height: 19px">
                                    <asp:Label ID="Label28" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "rol1") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                            </tr>
                              <tr id="Tr3" runat="server" >
                                <td style="height: 19px">
                                    <span style="font-size: 10pt; font-family: Verdana">
                                       ROI Of Plan B</span></td>
                                <td align="right" style="height: 19px">
                                    <asp:Label ID="Label29" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "rol2") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                            </tr>--%>
                            
                            
                             
                            <tr>
                                <td>
                                    <span style="font-size: 10pt"><span style="font-family: Arial">
                                    <b>Total Earning</b>
                                    </span></span>
                                </td>
                                <td align="right">
                                    <b><asp:Label ID="totalearning" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "totalearning") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></b></td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Verdana">
                                    TDS </span>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label13" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "TDS") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label>
                                    </td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Verdana">Handling Charges </span>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label14" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "handlingCharges") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
                            </tr>
                              <tr visible="false" runat="server" >
                              <td>
                                  <span style="font-size: 10pt; font-family: Arial">Other Charges </span>
                              </td>
                              <td align="right">
                                  <asp:Label ID="txtOC" runat="server" Font-Names="Arial" Font-Size="12px" Text='<%# DataBinder.Eval (Container.DataItem, "otherCharges") %>'></asp:Label></td>
                          </tr>
                            <tr>
                                <td>
                                    <b><span style="font-size: 10pt; font-family: Verdana">Net Earning</span></b></td>
                                <td align="right">
                                    <b><asp:Label ID="Label15" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "dispachedamt") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></b> </td>
                            </tr>
                            <tr id="dd" runat="server" visible="false">
                                <td>
                                    <span style="font-size: 10pt; font-family: Verdana">
                                    Draft/Cheque no</span></td>
                                <td align="right" style="text-align: right">
                                    <asp:Label ID="Label26" runat="server" Text='<%# DataBinder.Eval (Container.DataItem, "paymenttrandraftno") %>' Font-Size="10pt" Font-Names="Verdana"></asp:Label></td>
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
                        <br />
                        <span style="font-size: 10pt; font-family: Verdana">
                        &nbsp; We assure that, we can create a mutually beneficial long term working relationship
                        with you and assure you of our full co-operation in making this tie up a success
                        for both of us.</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 15px; text-align: left">
                        <hr color="#000000" size="1" />
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: center">
                        <span style="font-size: 10pt; font-family: Verdana">
                        &nbsp;&nbsp; This is computer generated statement. No signature required.</span></td>
                </tr>
                <tr>
                    <td align="center" colspan="3" height="2">
                        <hr color="#000000" size="1" /><a href="javascript:history.back()">
        </a>
                    </td>
                </tr>
            </table><div style="page-break-after: always "></div>
            
        
        
        
                  </ItemTemplate>
      
      <FooterTemplate></table></FooterTemplate>
      </asp:Repeater>
      <br class="break"/> 
      
      <br />
      <br />
      <br />
       <br />
      <br />
      <br />
          <br />
      <br />
      <br />
       <br />
      <br />
      <br />
          
          
          
               <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Next" />
        <br />

    
    </div></center>
    </form>
</body>
</html>
