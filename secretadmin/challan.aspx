<%@ Page Language="C#" AutoEventWireup="true" CodeFile="challan.aspx.cs" Inherits="admin_challan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Challan</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" style="border-right: #000000 1px solid;
            border-top: #000000 1px solid; border-left: #000000 1px solid; width: 433px;
            border-bottom: #000000 1px solid">
            <tr>
                <td style="width: 70%; border-bottom: #000000 1px solid; height: 36px; text-align: center">
                    <span style="font-family: Arial; font-size: 14pt;"><strong>CHALLAN</strong></span></td>
            </tr>     <tr>
                    <td align="left" style="height:44px; text-align: center">
                        <b style="font-size: 30px; font-style: italic">Integrator Technologies Private Limited</b></td>
                    <td style="height: 44px" valign="top">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="text-align: center; font-weight: bold; font-size: 15px; font-style: italic; height: 15px;">
                        B-6/65, Sector-5 Near Mount Abu School Rohini,Delhi-110085</td>
                    <td valign="top" style="height: 15px">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="text-align: center; font-weight: bold; font-size: 15px; font-style: italic; font-family: Arial; height: 15px;">
                        Phone no:- 011-47243373</td>
                    <td valign="top" style="height: 15px">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="text-align: center; font-weight: bold; font-size: 15px; font-style: italic; font-family: Arial; height: 15px;">
                        Email: info@Integratortech.biz</td>
                    <td valign="top" style="height: 15px">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="text-align: center; font-weight: bold; font-size: 15px; font-style: italic; font-family: Arial; height: 15px;">
                        &nbsp;website http://www.Integratortech.com</td>
                    <td valign="top" style="height: 15px">
                    </td>
                </tr><tr>
                <td style="width: 100px; height: 12px">
                </td>
            </tr>
            <tr>
                <td style="width: 70%; height: 362px; vertical-align: top;">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 696px">
                        <tr>
                            <td style="width: 50%; height: 20px;">
                                <span style="font-size: 10pt; font-family: Arial">I<asp:Label
                                    ID="lblCompany" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></span></td>
                            <td style="width: 30%; height: 20px;">
                                <span style="font-size: 9pt; font-family: Arial">CHALLAN NO</span>.
                                <asp:Label ID="lblInvoiceNo" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                            <td style="width: 30%; height: 20px;">
                                <asp:Label ID="lblinvoiceDate" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 50%; height: 34px;">
                                <span style="font-size: 10pt; font-family: Arial">
                                    <asp:Label ID="lblCAddress" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></span></td>
                            <td style="width: 30%; height: 34px;">
                            </td>
                            <td style="width: 30%; height: 34px;">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 50%; height: 35px;">
                                <span style="font-size: 10pt; font-family: Arial"></span></td>
                            <td style="width: 30%; height: 35px;">
                                <span style="font-size: 10pt; font-family: Arial">
                                ORDER NO </span>
                                <asp:Label ID="lblOrderNo"
                                    runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                            <td style="width: 30%; height: 35px;">
                                <asp:Label ID="lblOrderDate" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 50%; height: 22px;">
                            </td>
                            <td style="width: 30%; height: 22px;">
                            </td>
                            <td style="width: 30%; height: 22px;">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 50%; height: 23px;">
                                <span><span style="font-size: 10pt; font-family: Arial">TIN NO.:07310374867</span></span></td>
                            <td style="width: 30%; height: 23px; font-size: 12pt; font-family: Times New Roman;">
                                <span style="font-size: 10pt; font-family: Arial">DESPATCH THROUGH</span></td>
                            <td style="width: 30%; height: 23px;">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 50%; height: 22px;">
                            </td>
                            <td style="width: 30%; height: 22px;">
                            </td>
                            <td style="width: 30%; height: 22px;">
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="5" style="width: 40%">
                                <span style="font-size: 10pt; font-family: Arial">
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 413px; height: 130px">
                                        <tr>
                                            <td style="width: 20%; height: 19px">
                                                ID NO:</td>
                                            <td style="width: 80%; height: 19px">
                                                <asp:Label ID="lblId" runat="server" Width="323px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 29pt; height: 16px">
                                                NAME:</td>
                                            <td style="width: 50pt; height: 16px">
                                                <asp:Label ID="lblName" runat="server" Width="321px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 29pt; height: 16px">
                                                ADDRESS:</td>
                                            <td style="width: 50pt; height: 16px">
                                                <asp:Label ID="lblAddress" runat="server" Width="318px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 29pt">
                                                CITY:</td>
                                            <td style="width: 50pt">
                                                <asp:Label ID="lblCity" runat="server" Width="316px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 29pt">
                                                STATE:</td>
                                            <td style="width: 50pt">
                                                <asp:Label ID="lblState" runat="server" Width="315px"></asp:Label></td>
                                        </tr>
                                    </table>
                                </span>
                            </td>
                            <td style="width: 30%; height: 8px">
                                <span style="font-size: 10pt; font-family: Arial">PAYMENT DETAILS</span></td>
                            <td style="width: 30%; height: 8px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                            </td>
                            <td style="width: 30%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <span style="font-size: 10pt; font-family: Arial">TERMS OF DELIVERY</span></td>
                            <td style="width: 30%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%; height: 8px">
                            </td>
                            <td style="width: 30%; height: 8px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%; height: 2px">
                            </td>
                            <td style="width: 30%; height: 2px">
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="0" style="border-right: #000000 1px solid;
                        border-top: #000000 1px solid; border-left: #000000 1px solid; width: 697px;
                        border-bottom: #000000 1px solid; height: 28px;">
                        <tr>
                            <td style="border-right: #000000 1px solid; width: 49px; height: 26px; text-align: center; border-bottom: #000000 1px solid;">
                                <span style="font-size: 10pt; font-family: Arial"><strong>SR.NO</strong></span></td>
                            <td style="border-right: #000000 1px solid; width: 250px; height: 26px; text-align: center; border-bottom: #000000 1px solid;">
                                <span style="font-size: 10pt; font-family: Arial"><strong>PARTICUULARS</strong></span></td>
                            <td style="border-right: #000000 1px solid; width: 51px; height: 26px; text-align: center; border-bottom: #000000 1px solid;">
                                <span style="font-size: 10pt; font-family: Arial"><strong>QTY</strong></span></td>
                            <td style="border-right: #000000 1px solid; width: 130px; height: 26px; text-align: center; border-top-width: 1px; border-left-width: 1px; border-bottom: #000000 1px solid;">
                                <span style="font-size: 10pt; font-family: Arial"><strong>RATE</strong></span></td>
                            <td style="width: 100px; height: 26px; text-align: center; border-bottom: #000000 1px solid;">
                                <span style="font-size: 10pt; font-family: Arial"><strong>AMOUNT</strong></span></td>
                        </tr>
                        <tr>
                            <td style="border-right: #000000 1px solid; width: 49px; height: 28px; text-align: center">
                                <asp:Label ID="lblSrNo" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label>&nbsp;</td>
                            <td style="border-right: #000000 1px solid; width: 250px; height: 28px; text-align: center">
                                <asp:Label ID="lblPerticulars" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                            <td style="border-right: #000000 1px solid; width: 51px; height: 28px; text-align: center">
                                <asp:Label ID="lblQty" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                            <td style="border-right: #000000 1px solid; width: 130px; height: 28px; text-align: center">
                                <asp:Label ID="lblRate" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                            <td style="width: 100px; height: 28px; text-align: center">
                                <asp:Label ID="lblAmount" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 70%; vertical-align: top; height: 94px;">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 696px; height: 82px;">
                        <tr>
                            <td style="width: 50%; height: 48px; text-align: right">
                                <span style="font-size: 10pt; font-family: Arial"><strong>TAX EXEMPTED SALES</strong></span><span
                                    style="mso-spacerun: yes">&nbsp;</span></td>
                            <td style="font-size: 12pt; width: 50%; font-family: Times New Roman; height: 48px">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="vertical-align: text-bottom; width: 70%; height: 36px">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 696px">
                        <tr>
                            <td style="border-top: #000000 1px solid; width: 76%; border-bottom: #000000 1px solid;
                                height: 34px; text-align: right">
                                <span style="font-size: 10pt; font-family: Arial"><strong>TOTAL AMOUNT</strong></span><span style="mso-spacerun: yes">&nbsp;</span></td>
                            <td style="border-top: #000000 1px solid; font-size: 12pt; width: 50%; border-bottom: #000000 1px solid;
                                font-family: Times New Roman; height: 34px">
                                &nbsp;*<asp:Label ID="lblTotalAmount" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label>/-</td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 694px; height: 34px;">
                        <tr>
                            <td style="width: 22%; height: 19px; text-align: left; border-bottom: #000000 1px solid;">
                                <span style="font-family: Arial"><span style="font-size: 10pt">&nbsp;( AMOUNT IN WORDS<span
                                    style="mso-spacerun: yes"> )</span></span></span><span style="mso-spacerun: yes">&nbsp;</span></td>
                            <td style="width: 51%; height: 19px; border-bottom: #000000 1px solid;">
                                <span style="font-size: 10pt; font-family: Arial">Rs.</span><asp:Label ID="lblAmountInWords" runat="server" Font-Names="Arial" Font-Size="10pt"></asp:Label>
                                <span style="font-size: 10pt; font-family: Arial">Only</span></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 70%; vertical-align: top; height: 68px;">
                </td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 70%">
                    <span style="font-size: 11pt; font-family: Arial"><strong>TERMS &amp; CONDITIONS:</strong></span></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 70%">
                    <span style="font-size: 10pt; font-family: Arial">GOODS ONCE SOLD WILL NOT BE TAKEN
                        BACK</span></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 70%">
                    <span style="font-size: 10pt; font-family: Arial">ALL DISPUTES SUBJECT TO DELHI JURISDICTION</span></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 70%; height: 44px;">
                </td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 70%; text-align: right">
                    <span style="font-size: 10pt; font-family: Arial"><strong>For INTEGRATOR TECHNOLOGIES PVT LTD</strong></span></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 70%; text-align: right; height: 36px;">
                </td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 70%; text-align: center; height: 18px;">
                    <span style="font-size: 9pt; font-family: Arial"><strong>(THIS IS COMPUTER GENERATED
                        CHALLAN &nbsp;HENCE SIGNATURES NOT REQUIRED)</strong></span></td>
            </tr>
        </table>
    
    </div>
        
    </form>
</body>
</html>
