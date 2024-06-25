<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GSTBILL.aspx.cs" Inherits="secretadmin_GSTBILL" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        table, th, td
        {
            border-collapse: collapse;
            text-indent: 10px;
            border: 0.1pt solid black;
            padding: 0px;
            margin: 0px;
        }
    </style>
</head>
<body style="padding: 0px; margin: 0px">
  <form id="form1" runat="server">
    <div>
        <table style="width: 100%" cellpadding="0px" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 40%; text-align: center">
                                <img src="../images/logo.png" class="img-responsive" title="Ocean India" alt="#"
                                    style="margin-top: 5px; margin-bottom: 2px; height: 60px; width: 260px">
                                <%--  <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" Width="150px" Height="50px" />--%>
                            </td>
                            <td style="width: 60%">
                                <div style="padding-left: 10px; padding-right: 10px; float: left">
                                    <b>
                                        <asp:Label ID="lblcompanyname" runat="server"></asp:Label></b>
                                </div>
                                <div style="clear: both">
                                </div>
                                <div style="padding-left: 10px; padding-right: 10px; float: left">
                                    <asp:Label ID="lblcaddress" runat="server"></asp:Label>
                                </div>
                                <div style="clear: both">
                                </div>
                                <div style="padding-left: 10px; padding-right: 10px; float: left">
                                    <span>Phone No :</span><asp:Label ID="lblcphone" runat="server"></asp:Label>
                                    &nbsp;&nbsp; <span>Email : </span>
                                    <asp:Label ID="lblemailid" runat="server"></asp:Label>
                                </div>
                                <div style="clear: both">
                                </div>
                                <%-- <div style="padding-left: 10px; padding-right: 10px; float: left">
                                    <span>Email ID:</span><asp:Label ID="lblemailid" runat="server"></asp:Label>
                                </div>--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <span>
                        <asp:Label ID="lblinvoice" runat="server" Text="Label"></asp:Label></span>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" style="font-size: 12px" cellpadding="0px" cellspacing="0" border="0">
                        <tr>
                            <td style="width: 60%">
                                <table style="width: 100%" cellpadding="0px" cellspacing="0" border="0">
                                    <tr>
                                        <td colspan="4" style="width: 100%">
                                            GSTIN:
                                            <asp:Label ID="lblgstno" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%">
                                            Inv No:
                                        </td>
                                        <td style="width: 25%">
                                            <asp:Label ID="lblinvoiceno" runat="server" Text="Label"></asp:Label>
                                        </td>
                                        <td style="width: 25%">
                                            CIN:
                                        </td>
                                        <td style="width: 25%">
                                            <asp:Label ID="lblcin" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%">
                                            Date:
                                        </td>
                                        <td style="width: 25%">
                                            <asp:Label ID="lbldoe" runat="server" Text="Label"></asp:Label>
                                        </td>
                                        <td style="width: 25%">
                                            PAN:
                                        </td>
                                        <td style="width: 25%">
                                            <asp:Label ID="lblpanno" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 40%; vertical-align: top">
                                <table style="width: 100%" cellpadding="0px" cellspacing="0" border="0">
                                    <tr>
                                        <td style="width: 50%;">
                                            Mode of Transport
                                        </td>
                                        <td style="width: 50%">
                                            <asp:Label ID="lbltransport" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%">
                                            Place Of Supply
                                        </td>
                                        <td style="width: 50%">
                                            <asp:Label ID="lblsupply" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%">
                                            State Code
                                        </td>
                                        <td style="width: 50%">
                                            <asp:Label ID="lblcstatecode" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 100%; font-size: 12px" cellpadding="0px" cellspacing="0" border="0">
                        <tr>
                            <td style="width: 50%">
                                <table width="100%">
                                    <tr>
                                        <td style="width: 100%" colspan="2">
                                            <span>Details Of receiver(Billed to)</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            Name:
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="lblname" runat="server" Text="Label"></asp:Label><span> ( User Id:
                                                <asp:Label ID="lblUserId" runat="server" Text="Label"></asp:Label>
                                                )</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            Address:
                                        </td>
                                        <td style="width: 80%;">
                                            <div style="padding-left: 10px;">
                                                <asp:Label ID="lbladdress" runat="server" Text="Label"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            State:
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="lblstate" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <div style="width: 100%; text-align: left">
                                                State Code
                                            </div>
                                            <div style="clear: both">
                                            </div>
                                            <div style="width: 100%; text-align: left">
                                            </div>
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="lblstatecode" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <div style="width: 100%; text-align: left">
                                                GSTIN/Unq.ID
                                            </div>
                                            <%--<div style="clear: both">
                                            </div>
                                            <div style="width: 100%; text-align: left">
                                                
                                            </div>--%>
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="lblgst" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 50%">
                                <table width="100%">
                                    <tr>
                                        <td style="width: 100%" colspan="2">
                                            <span>Details Of Consignee(Shipped to)</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            Name:
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="lblname1" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            Address:
                                        </td>
                                        <td style="width: 80%">
                                            <div style="padding-left: 10px">
                                                <asp:Label ID="lbladdress1" runat="server" Text="Label"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            State:
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="lblstate1" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <div style="width: 100%; text-align: left">
                                                State Code
                                            </div>
                                            <div style="clear: both">
                                            </div>
                                            <div style="width: 100%; text-align: left">
                                            </div>
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="lblstatecode1" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <div style="width: 100%; text-align: left">
                                                GSTIN/Unq.ID
                                            </div>
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="lblgst1" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                     <asp:Repeater ID="rp1" runat="server">
                        <HeaderTemplate>
                            <table style="width: 100%; border-collapse: collapse;">
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
                                        <td style="width: 20%; font-size: 12px">
                                            Description
                                        </td>
                                        <td style="width: 5%; font-size: 12px">
                                            HSN<br />
                                        </td>
                                        <td style="width: 5%; font-size: 12px">
                                            MRP
                                        </td>
                                        <td style="width: 7%; font-size: 12px">
                                            <div style="width: 100%; text-align: left">
                                                Unit
                                            </div>
                                            <div style="clear: both">
                                            </div>
                                            <div style="width: 100%; text-align: left">
                                                Price
                                            </div>
                                        </td>
                                        <td style="width: 5%; font-size: 12px">
                                            Qty
                                        </td>
                                        <td style="width: 5%; font-size: 12px">
                                            Gross
                                        </td>
                                        <td style="width: 5%; font-size: 12px">
                                            Disc
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
                                                <tr>
                                                    <td style="width: 100%; text-align: center; font-size: 12px" colspan="2">
                                                        SGST
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="50%">
                                                        Rate
                                                    </td>
                                                    <td width="50%">
                                                        Amt
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 10%" colspan="2">
                                            <table width="100%" style="border: none">
                                                <tr>
                                                    <td style="width: 100%; text-align: center; font-size: 12px" colspan="2">
                                                        CGST
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="50%">
                                                        Rate
                                                    </td>
                                                    <td width="50%">
                                                        Amt
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 10%" colspan="2">
                                            <table width="100%" style="border: none">
                                                <tr>
                                                    <td style="width: 100%; text-align: center; font-size: 12px" colspan="2">
                                                        IGST
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="50%">
                                                        Rate
                                                    </td>
                                                    <td width="50%">
                                                        Amt
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                         <td style="width: 8%; font-size: 12px;">
                                            Amount
                                        </td>
                                    </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td style="width: 5%; font-size: 12px">
                                    <%#Eval("productid") %>
                                </td>
                                <td style="width: 10%; font-size: 12px">
                                    <asp:Label ID="lblpname" runat="server" Text='<%#Eval("productname") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="hsncode" runat="server" Text='<%#Eval("hsn") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("mrp") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblrate" runat="server" Text='<%#Eval("unitprice") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblqty" runat="server" Text='<%#Eval("quantity") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblGross" runat="server" Text='<%#Eval("Gross") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblDiscount" runat="server" Text='<%#Eval("disc") %>'></asp:Label> (<%#Eval("dis_type") %>)
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblvalue" runat="server" Text='<%#Eval("taxable") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblsgrate" runat="server" Text='<%#Eval("srate") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblsgamount" runat="server" Text='<%#Eval("samount") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblcgrate" runat="server" Text='<%#Eval("crate") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblcgamount" runat="server" Text='<%#Eval("camount") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbligrate" runat="server" Text='<%#Eval("irate") %>'></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbligamount" runat="server" Text='<%#Eval("iamount") %>'></asp:Label>
                                </td>
                                 <td style="width: 5%; font-size: 12px;">
                                    <asp:Label ID="lblamount" runat="server" Text='<%#Eval("amt") %>'></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <tr>
                                <td style="width: 5%; font-size: 12px">
                                </td>
                                <td style="width: 10%; font-size: 12px">
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <span style="font-weight: bold"></span>Total
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbltotalqty" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lblTotalgross" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                   
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbltotalvalue" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbltotalsgrate" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbltotalsgamount" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbltotalcgrate" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbltotalcgamount" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbltotaligrate" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px">
                                    <asp:Label ID="lbltotaligamount" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                                <td style="width: 5%; font-size: 12px;">
                                    <asp:Label ID="lbltotalamt" runat="server" Style="font-weight: bold"></asp:Label>
                                </td>
                            </tr>
                            </tbody> </table> </div>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 100%; font-size: 12px">
                        <tr>
                            <td style="width: 50%">
                                 Invocie Total (In Words):
                                &nbsp;&nbsp;<asp:Label ID="lblwords" runat="server" Text="Label"></asp:Label>
                            </td>
                             <%-- <td style="width:15%">
                            
                                 Bulk buying :
                                &nbsp;&nbsp;<asp:Label ID="lblDiscount" runat="server" Text="Label">0</asp:Label>
                            </td>--%>
                            <td style="width: 50%">
                                <span style="font-weight: bold">Invoice Total:
                                    <asp:Label ID="lblallamount" runat="server" Text="Label"></asp:Label></span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <%--<div>
                        Payment Mode</div>
                    <div style="clear: both">
                    </div>--%>
                    <table style="width: 100%; font-size: 12px">
                        <tr>
                            <td style="width: 20%">
                                Total BV:
                            </td>
                            <td style="width: 20%">
                                <asp:Label ID="lblpv" runat="server"></asp:Label>
                            </td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                      
                        <tr>
                            <td style="width: 20%">
                                SNO
                            </td>
                            <td style="width: 20%">
                                Payment Mode
                            </td> 
                            <td style="width: 20%">
                                Adjustment Amt
                            </td>
                            <td style="width: 20%">
                                Amount
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                1
                            </td>
                            <td style="width: 20%">
                                <asp:Label ID="lblpaymode" runat="server" Text="0"></asp:Label>
                            </td>
                             <td style="width: 20%">
                                <asp:Label ID="lbl_Adjustemnt" runat="server" Text="0"></asp:Label>
                            </td>
                            <td style="width: 20%">
                                <asp:Label ID="lblamount" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <%--  <tr>
                <td>--%>
            <%--<pre>Use our missed call service from your mobile number registered
      with us and know your bonus-<asp:Label ID="lblcmobileno" runat="server" Text="Label"></asp:Label></pre>--%>
            <%-- <br />
                    <table width="100%">
                        <tr>
                            <td style="width: 25%">
                                
                            </td>
                            <td style="width: 25%">
                               
                            </td>--%>
            <%-- <td style="width:25%">Total BV:</td>
         <td style="width:25%"> <asp:Label ID="lblbv" runat="server"></asp:Label> </td>
            </tr>--%>
            <%-- <tr>
      <td style="width:25%">Group PV:</td>
        <td style="width:25%">
            <asp:Label ID="lblgpv" runat="server" ></asp:Label></td>
          <td style="width:25%">Group BV:</td>
            <td style="width:25%"> <asp:Label ID="lblgbv" runat="server"></asp:Label> </td>
      
      </tr>--%>
            <%--</table>
                </td>
            </tr>--%>
            <tr>
                <td>
                    <table style="width: 100%; height: 20%">
                        <tr>
                            <td style="width: 60%; font-size: 12px">
                                <ol type="1">
                                    <b><u>Terms & Conditions : </u></b>
                                    <li>Seller is not responsible for any loss or damage of goods in transit. </li>
                                    <li>Please store above mentioned products at cool place and away from sunlight.</li>
                                    <li>Any inaccuracy in this bill must be notified immediately on its receipt.</li>
                                    <li>Disputes if any will be subject to
                                        <asp:Label ID="lblcstate" runat="server" Text="Label"></asp:Label>
                                        court jurisdiction.</li>
                                </ol>
                            </td>
                            <td style="width: 40%;">
                                <div style="text-align: left; font-size: 12px; margin-top: 5px; padding-left: 20px">
                                    FOR <b>
                                        <asp:Label ID="lblcompanyname2" runat="server" Text="Label"></asp:Label></b>
                                </div>
                                <div style="text-align: left; height: 50px">
                                </div>
                                <%-- <div style="clear: both">
                                </div>--%>
                                <div style="text-align: left; font-size: 13px; padding-left: 20px">
                                    <span><b>Authorized Signatory:</b></span>
                                    <%--   <asp:Label ID="lblauthorisedsignatory" runat="server" ></asp:Label>--%>
                                </div>
                                <div style="text-align: left; font-size: 12px; padding-left: 20px">
                                    <span>Prepared By:</span><asp:Label ID="lblpreparedby" runat="server"></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="text-align: left; font-size: 10px">
                        <u>Registered Office : </u>
                        <asp:Label ID="lblcompanyname33" runat="server"></asp:Label><span></span>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height: 50px; text-align: center">
                    <p>
                        Cut From Here &#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;&#x2702;
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td colspan="2" style="text-align: center">
                                Detail of Invoice To
                            </td>
                            <td colspan="2" style="text-align: center">
                                Detail of Invoice By
                            </td>
                        </tr>
                        <tr>
                            <td width="10%">
                                Name
                            </td>
                            <td width="40%">
                                <asp:Label ID="lbltoname" runat="server"></asp:Label><span> ( User Id:
                                                <asp:Label ID="lblUId" runat="server" Text="Label"></asp:Label>
                                                )</span>
                            </td>
                            <td width="10%">
                                Name
                            </td>
                            <td width="40%">
                                <asp:Label ID="lblfromname" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="10%">
                                Phone No
                            </td>
                            <td width="40%">
                                <asp:Label ID="lbltophone" runat="server"></asp:Label>
                            </td>
                            <td width="10%">
                                Phone No
                            </td>
                            <td width="40%">
                                <asp:Label ID="lblfromphone" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="10%">
                                Address
                            </td>
                            <td width="40%">
                                <asp:Label ID="lbltoaddress" runat="server"></asp:Label>
                            </td>
                            <td width="10%">
                                Address
                            </td>
                            <td width="40%">
                                <asp:Label ID="lblfromaddress" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <%--<tr>
                <td>
                    <div style="text-align: left; font-size: 15px">
                        Corporate Office :<asp:Label ID="lblcompanyname4" runat="server"></asp:Label>
                    </div>
                </td>
            </tr>--%>
        </table>
    </div>
    </form>
</body>
</html>
