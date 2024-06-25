<%@ Page Language="C#" AutoEventWireup="true" CodeFile="invoice1.aspx.cs" Inherits="yesadmin_invoice1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>invoice</title>
     <style>
     
     .textshowdw{color: white; text-shadow: #ececec 0.1em 0.7em 0.2em; font-size:20px;text-align:center;letter-spacing:2px; font-weight:bold }
     
     </style>
</head>
<body>
    <form id="form1" runat="server">
    <center>
            <div>
                <asp:Repeater ID="Repeater1" runat="server" 
                    onitemdatabound="Repeater1_ItemDataBound">
                    <HeaderTemplate></HeaderTemplate>
                    <ItemTemplate>

                        <table cellpadding="0" cellspacing="0" id="AutoNumber1" class="datatable" style="width: 665px">
                            <tr>
                                <td style="text-align: left; line-height: 18px; border-bottom-style: none;">
                                    <center>
                                       RETAIL INVOICE</center>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td colspan="2">
                                                <table style="border: 2px solid #ddd; width: 97%; margin-left: 16px">
                                                    <tr>
                                                        <td style="border-right: 2px solid #ddd">
                                                            <img src="http://swarnabhoomi.biz/images/logo.png" Height="60px"  Width="270px"  />
                                                            <%-- <asp:Image ID="imgLogo" runat="server" ImageUrl='<%# "GalleryImages/"+ Eval("logoURL")%>' Width="233px" Height="120px" />--%>
                                                        </td>
                                                        <td style="padding-top: 5px; width: 250px;">
                                                            <asp:Label ID="lblCNameNew" runat="server" Font-Names="Arial" Font-Size="13pt" Font-Bold="true" Text='<%#Eval("companyname")%>' style="text-transform: uppercase"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="lblCAddress" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("address")%>'></asp:Label><br />

                                                            <span style="font-size: 9pt; font-family: Arial">PHONE :   </span>
                                                            <asp:Label ID="lblphoneno" runat="server" Text='<%#Eval("phone")%>' Style="font-size: 9pt; font-family: Arial"></asp:Label>
                                                            <br />
                                                            <span style="font-size: 9pt; font-family: Arial">WEBSITE   :   </span>
                                                            <asp:Label ID="lblwebsite" runat="server" Text='<%#Eval("website")%>' Style="font-size: 9pt; font-family: Arial"></asp:Label>

                                                        </td>


                                                    </tr>


                                                </table>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 15px; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none; height: 22px; text-align: left;"
                                                colspan="2">
                                                <table cellspacing="0" style="border: 2px solid #dddddd; width: 99.5%">
                                                    <tr>
                                                        <td>
                                                            <span style="font-size: 9pt; font-family: Arial"><strong>BUYER</strong></span>
                                                        </td>
                                                        <td style="width: 10px; vertical-align: top;"></td>
                                                        <td style="width: 300px;">
                                                            <asp:Label ID="lblID" Text='<%#Eval("appmstregno")%>' runat="server" Font-Names="Arial" Font-Size="9pt"></asp:Label>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span style="font-size: 9pt; font-family: Arial"><strong>NAME</strong></span>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="lblClientName" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("appmsttitle")%>'></asp:Label>
                                                           

                                                              <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("appmstFName")%>'></asp:Label>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span style="font-size: 9pt; font-family: Arial"><strong>MOBILE</strong></span>
                                                        </td>
                                                        <td>
                                                            <strong>:</strong>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblMobile" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("appmstmobile")%>'></asp:Label>
                                                        </td>
                                                        <td><strong><span style="font-size: 10pt; font-family: Arial">INVOICE NO</span></strong> <strong>:</strong>
                                                            #<asp:Label ID="lblInvoiceNo" runat="server" Font-Bold="False" Font-Size="10pt" Font-Names="Arial" Text='<%#Eval("appmstid")%>'></asp:Label>
                                                        </td>
                                                        <td></td>
                                                        <td><strong><span style="font-size: 10pt; font-family: Arial">DATE</span></strong> <strong>:</strong>
                                                            <asp:Label ID="lblInvoicedate" runat="server" Font-Size="10pt" Font-Names="Arial" Text='<%#Eval("invoicedate")%>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="vertical-align: top;">
                                                            <span style="font-size: 9pt; font-family: Arial"><strong>ADDRESS</strong></span>
                                                        </td>
                                                        <td style="vertical-align: top;">
                                                            <strong>:</strong>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblAdress" runat="server" Width="240px" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("AppMstAddress1")%>'>Address</asp:Label><br />
                                                            <asp:Label ID="lblCity" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("AppMstCity")%>'>City</asp:Label>
                                                            <asp:Label ID="lblState" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("AppMstState")%>'>State</asp:Label>
                                                            <asp:Label ID="lblpincode" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("AppMstPinCode")%>'>Pin Code</asp:Label>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                  
                                        <tr>
                                            <td colspan="2" style="padding-left: 15px; border-top-style: none; border-right-style: none; border-left-style: none; height: 18px; text-align: left; border-bottom-style: none">
                                             
                                          
                                                <table cellspacing="0" style="width: 646px;">
                                                    <tr>
                                                        <td style="border: 1px solid #dddddd; background-color: lightgrey; text-align: left;"
                                                            class="style4">
                                                            <span style="font-size: 10pt; font-family: Arial;"><strong>S. NO.</strong></span>
                                                        </td>
                                                        <td style="border: 1px solid #dddddd; background-color: lightgrey; text-align: left;"
                                                            class="style5">
                                                            <span style="font-size: 10pt; font-family: Arial;"><strong>Description</strong></span>
                                                        </td>
                                                        <td style="border: 1px solid #dddddd; background-color: lightgrey; text-align: left;">
                                                            <span style="font-size: 10pt; font-family: Arial;"><strong>Qty</strong></span>
                                                        </td>
                                                        <td style="border: 1px solid #dddddd; background-color: lightgrey; text-align: left; width:50px;"
                                                            >
                                                            <span style="font-size: 10pt; font-family: Arial;"><strong>Rate</strong></span>
                                                        </td>


                                                         <td style="border: 1px solid #dddddd; background-color: lightgrey; text-align: left; width:50px;"
                                                            >
                                                            <span style="font-size: 10pt; font-family: Arial;"><strong>Vat/CST</strong></span>
                                                        </td>

                                                         <td style="border: 1px solid #dddddd; background-color: lightgrey; text-align: left; width:50px;"
                                                            >
                                                            <span style="font-size: 10pt; font-family: Arial;"><strong>Amount</strong></span>
                                                        </td>

                                                        
                                                        
                                                        <td style="border: 1px solid #dddddd; background-color: lightgrey; text-align: left;"
                                                            class="style6">
                                                            <span style="font-size: 10pt; font-family: Arial"><strong>Tax Amt</strong></span>
                                                        </td>

                                                        <td style="border: 1px solid #dddddd; background-color: lightgrey; text-align: left; "
                                                            class="style6">
                                                            <span style="font-size: 10pt; font-family: Arial"><strong>Net Amt</strong></span>
                                                        </td>
                                                    </tr>

                                                      <asp:Repeater ID="Repeater2" runat="server" >
                    <HeaderTemplate></HeaderTemplate>
                    <ItemTemplate>
                                                    
                                                    <tr>
                                                        <td style="border: 1px solid #dddddd;" class="style7">
                                                        
           <ItemTemplate>
     <%#Container.ItemIndex+1 %>
</ItemTemplate>
                                             
                                                               </td>


                                                        <td style="border: 1px solid #dddddd; text-align: left; font-size: 12px;">  <strong> 
                                                        <asp:Label ID="lblPackgName" runat="server" Text='<%#Eval("productname")%>'> </asp:Label></strong></td>

                                                            
                                                        <td style="border: 1px solid #dddddd; text-align: center" >
                                                            <asp:Label ID="lblQNT" runat="server"  Font-Bold="True" Font-Names="Arial" 
                                                                Font-Size="10pt" Text='<%#Eval("quantity")%>'>0</asp:Label>

                                                        </td>

                                                        
                                                              


                                                         <td style="border: 1px solid #dddddd; text-align: right; padding-right:15px; width:50px;" > 
                                                         <asp:Label ID="lblRate" runat="server"  Font-Bold="True" Font-Names="Arial" Text='<%#Eval("peritemcost")%>'
                                                                Font-Size="10pt">0</asp:Label></td>


                                                                  <td style="border: 1px solid #dddddd; text-align: right; padding-right:15px; width:50px;" >
                                                                <asp:Label ID="lbltax" runat="server"  Font-Bold="True" Font-Names="Arial" Text='<%#Eval("tax")%>'
                                                                Font-Size="10pt">0</asp:Label></td>


                                                                 <td style="border: 1px solid #dddddd; text-align: right; padding-right:15px; width:50px;" > 
                                                         <asp:Label ID="lblrqamount" runat="server"  Font-Bold="True" Font-Names="Arial" Text='<%#Eval("price")%>'
                                                                Font-Size="10pt">0</asp:Label></td>


                                                              
                                                        <td style="border: 1px solid #dddddd; padding-right: 20px; text-align: right;" class="style9">
                                                          <asp:Label ID="lblTSaleP" runat="server"  Font-Bold="True" Font-Names="Arial" Text='<%#Eval("taxamount")%>'
                                                                Font-Size="10pt">0</asp:Label>
                                                        </td>

                                                         <td style="border: 1px solid #dddddd; padding-right: 20px; text-align: right;" class="style9">
                                                          <asp:Label ID="lblnetamount" runat="server"  Font-Bold="True" Font-Names="Arial" Text='<%#Eval("netamount")%>'
                                                                Font-Size="10pt">0</asp:Label>
                                                        </td>
                                                    </tr>
                                                    
                                                                                                    
                    </ItemTemplate>
</asp:Repeater>
                                    
                                                  
                                                   
                     
                                                   
                                                   
                                                    
                                                    <tr>
                                                        <td style="text-align: right; width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid;"
                                                            colspan="5">
                                                            <strong><span style="font-size: 10pt; font-family: Arial">Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></strong>
                                                        </td>
                                                        <td style="width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; padding-right: 20px; text-align: right;">
                                                            <asp:Label ID="Label2" runat="server" Text="Label" Font-Bold="True" Font-Names="Arial" 
                                                                Font-Size="10pt"></asp:Label>

                                                        </td>

                                           <td style="width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; padding-right: 20px; text-align: right;">
                                               <asp:Label ID="Label3" runat="server" Text="Label" Font-Bold="True" Font-Names="Arial" 
                                                                Font-Size="10pt"></asp:Label>
                                           </td>

                                                                                                                                                                  <td style="width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; padding-right: 20px; text-align: right;">
                                                                                                                                                                  
                                                                                                                                                                      <asp:Label ID="Label4" runat="server" Text="Label" Font-Bold="True" Font-Names="Arial" 
                                                                Font-Size="10pt"></asp:Label>
                                                                                                                                                                  </td>

                                                    </tr>
                                                    <tr style="display:none;">
                                                        <td style="text-align: right; width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid;"
                                                            colspan="7">
                                                            <strong><span style="font-size: 10pt; font-family: Arial">Total Sale Value Before V.A.T/C.S.T</span></strong>
                                                        </td>
                                                        <td style="width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; padding-right: 20px; text-align: right;">
                                                            <asp:Label ID="lblVatBefore" runat="server"  Font-Bold="True" Font-Names="Arial"
                                                                Font-Size="10pt">0</asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="display:none;">
                                                        <td style="text-align: right; width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid;"
                                                            colspan="7">
                                                            <strong><span style="font-size: 10pt; font-family: Arial">Add V.A.T/C.S.T..</span></strong>
                                                        </td>
                                                        <td  style="width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; padding-right: 20px; text-align: right;">
                                                            <asp:Label ID="lblTSaleV" runat="server"  Font-Bold="True" Font-Names="Arial"
                                                                Font-Size="10pt">0</asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right; width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid;"
                                                            colspan="7">
                                                            <strong><span style="font-size: 10pt; font-family: Arial">Total Price</span></strong>
                                                        </td>
                                                        <td style="width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; padding-right: 20px; text-align: right;">
                                                              <asp:Label ID="lblAmount" runat="server"  Font-Bold="True" Font-Names="Arial"
                                                                Font-Size="10pt">0</asp:Label>
                                                            
                                                            
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left; width: 100px; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid;"
                                                            colspan="8">
                                                            <strong><span style="font-size: 10pt; font-family: Arial">
                                                                <asp:Label ID="lblAmtWord" runat="server">0</asp:Label></span>
                                                            </strong>
                                                        </td>
                                                    </tr>
                                                </table>


                                                 

                                            </td>
                                        </tr>

                                    </table>
                                </td>
                            </tr>
                      
                              <tr>
                                <td align="left">
                                    <table cellspacing="0" style="width: 97.5%; border: 1px solid #ddd; margin-left: 14px">
                                        <tr>
                                            <td>
                                                <span style="font-size: 10pt; font-family: Arial">TIN NO.</span>
                                                <asp:Label ID="lblcnm" runat="server" Font-Bold="true" Font-Names="Arial" Font-Size="10pt" Text='<%#Eval("tinno")%>'></asp:Label>
                                            </td>
                                            <td></td>
                                            <td rowspan="5" style="border: 1px solid #dddddd;" valign="top">
                                                <%-- <strong>Nayee Disha Solutions </strong>--%>
                                                <br />
                                                <br />
                                                <br />
                                                <br />
                                                Authorised Signatory
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span style="font-size: 10pt; font-family: Arial">PAN No.</span>
                                                <asp:Label ID="lblCPanNo" runat="server" Font-Bold="true" Font-Names="Arial" Font-Size="10pt" Text='<%#Eval("panno")%>' ></asp:Label>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 18px; text-align: right; border-bottom-style: none; font-size: 12px;">
                                                <p style="text-align: justify; width: 400px">
                                                    <strong>Declaration:</strong> Goods once sold are not returnable under any circumstance. 
                                                    <br />
                                                    <strong>Subject to Delhi Jurisdiction Only</strong>
                                                    <br />
                                                    
                                                </p>
                                            </td>
                                            <td></td>
                                        </tr>
                                       
                                    </table>
                                </td>
                            </tr>
                          
                            <tr>
                                <td style="border-top-style: none; height: 12px; border-bottom-style: none"></td>
                            </tr>
                            <tr id="print_click">
                                <td style="border-top-style: none;  text-align:center; font-size:12px;">&nbsp;This is a Computer generated invoice.
                                </td>
                            </tr>

                            <tr>
                            
                            <td style="height:20px"></td>
                            </tr>

                            <tr>
                                <td style="border-top-style: none; height: 12px; border-bottom-style: none"></td>
                            </tr>
                             <tr>
                                <td style="line-height: 18px; text-align: right; border-bottom-style: none">
                                    <asp:Label ID="lblcNameWaterMark" runat="server" Font-Names="Swis721 BlkOul BT" ForeColor="Silver"
                                        CssClass="textshowdw" Width="202px" Text='<%#Eval("companyname")%>'></asp:Label></td>
                            </tr>

                            <tr>

                                <td style="height: 180px"></td>
                            </tr>
                        </table>


                    </ItemTemplate>



               

                    <FooterTemplate>
                        
                        </table>


                        

                    </FooterTemplate>

                      <SeparatorTemplate>
                            <p style="page-break-before: always">
                            </p>
                        </SeparatorTemplate>

                </asp:Repeater>


                     
              
            </div>
        </center>

        
    </form>
</body>
</html>
