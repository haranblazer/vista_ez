<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="true" CodeFile="adminpaymentreport.aspx.cs"
    Inherits="payoutstatement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Payout Statement</title>
    <link href="css/Payout.css" rel="stylesheet" />
      <style type="text/css">
        body
        {
            color: #000;
        }
        table
        {
            border-collapse: collapse;
            text-indent: 10px;
        }
        
        table, td, th
        {
            border: 1px solid black;
        }
        img.cancel
        {
            position: absolute;
            top: 90px;
            left: 30%;
        }
    </style>
    <style>
        .payment
        {
            line-height: 20px;
            font-size: 30px;
            text-align: center;
            color: #F26329;
            font-weight: bold;
            padding: 8px 0px;
        }
    </style>
</head>
<body style="font-size: 14px; font-family: Arial, Helvetica, sans-serif;">
    <form id="form1" runat="server">
    <div style="padding: 10px 50px 10px 50px">
        <center>
            <table style="width: 100%">
                <tr>
                    <td style="width: 40%">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" Style="height: 90px;
                            width: 260px; border-width: 0px;" />
                    </td>
                    <td style="width: 60%">
                        <asp:Label CssClass="payment" ID="lblComapnyName" runat="server"></asp:Label>
                        <br />
                        <div style="clear: both">
                        </div>
                        <asp:Label ID="lblCompanyAddress" runat="server"></asp:Label>
                        <div style="clear: both">
                        </div>
                        <asp:Label ID="lblcompanywebsite" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="line-height: 20px; font-size: 20px; text-align: center; background-color: #e6e6e6;
                        border: solid 1px #000000; padding: 8px 0px;" colspan="2">
                        <strong>Payout And Earnings Statement</strong>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td style="border: #000000 solid 1px;">
                        <table style="width: 100%;" rules="all">
                            <tr>
                                <td class="Left_table">
                                    Name
                                </td>
                                <td class="right_table" style="text-align: left;" colspan="2">
                                    &nbsp;<asp:Label ID="lblName" runat="server"></asp:Label>
                                </td>
                                <td class="Left_table">
                                    User Id
                                </td>
                                <td class="right_table" style="text-align: left" colspan="2">
                                    &nbsp;<asp:Label ID="lblUserId" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table">
                                    Address
                                </td>
                                <td class="right_table" colspan="5" style="text-align: left">
                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table">
                                    Mobile Number
                                </td>
                                <td class="right_table" style="text-align: left" colspan="2">
                                    <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                </td>
                                <td class="Left_table">
                                    E Mail Id
                                </td>
                                <td class="right_table" style="text-align: left" colspan="2">
                                    <asp:Label ID="lblEMailId" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table">
                                    PAN No
                                </td>
                                <td class="right_table" style="text-align: left">
                                    <asp:Label ID="lblPAN" runat="server"></asp:Label>
                                </td>
                                <td class="Left_table" colspan="4">
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table" colspan="6">
                                    Commission For The Period:
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table">
                                    Beginning
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;<asp:Label ID="lblPayoutFromDate" runat="server">0</asp:Label>
                                </td>
                                <td class="Left_table">
                                    Ending
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;<asp:Label ID="lblPayoutToDate" runat="server">0</asp:Label>
                                </td>
                                <td class="Left_table">
                                    Payout No
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;<asp:Label ID="lblPayoutNo" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <%--<tr>
                                <td colspan="6">
                                </td>
                            </tr>--%>

                             <tr>
                                <td class="Left_table" colspan="6" style="padding-left: 5px">
                                    Pair Points
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <table style="width: 100%;" rules="all">
                                        <tr>
                                            <td class="right_table" colspan="1">
                                                Direct CV<%--BFL--%>
                                            </td>
                                           <td class="right_table" colspan="3">
                                                <asp:Label ID="lbldirectcv" runat="server">0</asp:Label>
                                                <%--<asp:Label ID="lblBFL" runat="server">0</asp:Label>--%>
                                            </td>
                                           <%--  <td class="right_table">
                                                BFR
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblBFR" runat="server">0</asp:Label>
                                            </td>--%>
                                        </tr>

                                         <tr style="display:none">
                                            <td class="right_table">
                                                Total Left <%=gbv %>
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblTLB" runat="server">0</asp:Label>
                                            </td>
                                            <td class="right_table">
                                                Total Right <%=gbv %>
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblTRB" runat="server">0</asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="right_table">
                                                New Left <%=pbv %>
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblNewLeft" runat="server">0</asp:Label>
                                            </td>
                                            <td class="right_table">
                                                New Right <%=pbv %>
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblNewRight" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                          <tr>
                                            <td class="right_table">
                                                Carry Left <%=gbv %>
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblCarryLeft" runat="server">0</asp:Label>
                                            </td>
                                            <td class="right_table">
                                                Carry Right <%=gbv %>
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblCarryRight" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Calculated Left <%=gbv %>
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblCPL" runat="server">0</asp:Label>
                                            </td>
                                            <td class="right_table">
                                                Calculated Right <%=gbv %>
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblCPR" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                      
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%" rules="all">
                            <tr>
                                <td class="Left_table" colspan="2" style="padding-left: 5px">
                                    Earnings:
                                </td>
                            </tr>
                         <%--   <tr>
                                <td class="right_table">
                                    Direct Income
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lbldirectincome" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>--%>
                            <tr>
                                <td class="right_table">
                                     <asp:Label ID="lbl_B1" runat="server"></asp:Label>
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblBinary" runat="server">0</asp:Label>
                                </td>
                            </tr>
                          
                             <tr>
                                <td class="right_table">
                                    <asp:Label ID="lbl_B2" runat="server"></asp:Label>
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblSClub" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>
                             <tr>
                                <td class="right_table">
                                   <asp:Label ID="lbl_B3" runat="server"></asp:Label>
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblRoyalStar" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>
                             <tr>
                                <td class="right_table">
                                   <asp:Label ID="lbl_B4" runat="server"></asp:Label>
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblPClub" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>

                             <tr>
                                <td class="right_table">
                                  <asp:Label ID="lbl_B5" runat="server"></asp:Label>
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblDiamondStar" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>
                       
                             <tr>
                                <td class="right_table">
                                  TF
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblTF" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>

                               <tr>
                                <td class="right_table">
                                  CF
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblCF" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>

                            <tr>
                                <td class="Left_table">
                                    Total
                                </td>
                                <td class="Left_table">
                                    <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table" colspan="2">
                                    Deductions
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table">
                                    TDS
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblTDS" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table">
                                    Admin Charges
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblOC" runat="server">0</asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td class="right_table" width="1051px" style="padding-left: 5px">
                                    Release Amount
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lbl_ReleaseAmt" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table" colspan="2">
                                    Net Earning
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table">
                                    Net earnings after deductions
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblNet" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" colspan="2">
                                    Paid in Cash
                                    <asp:CheckBox ID="CheckBox1" runat="server" TextAlign="Left" />
                                    or Cheque
                                    <asp:CheckBox ID="CheckBox2" runat="server" />
                                    or Account Transfer
                                    <asp:CheckBox ID="CheckBox3" runat="server" />&nbsp; or other
                                    <asp:CheckBox ID="CheckBox4" runat="server" />&nbsp; Specify _____<asp:Label ID="Label29"
                                        runat="server"></asp:Label>______ Net Amount Due :
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>


                <tr>
                    <td style="font-size: 12px; font-weight: 500; line-height: 20px; border: #000000 solid 1px;">
                        We are thankful to all our Associate Members for their overwhelming response to
                        our <strong>Business Plan</strong>. We assure you that the confidence, which you
                        all have invested in us, will go a long way.
                    </td>
                </tr>
            </table>
        </center>
            <img src="images/onhold.png" class="cancel" style="width: 50%; opacity:0.20;" id="imgbill"
            runat="server"/>
    </div>
    </form>
</body>
</html>
