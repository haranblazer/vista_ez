<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RePurchaseList.aspx.cs" Inherits="user_RePurchaseList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Payout Statement</title>
    <link href="css/Payout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding: 10px 100px 10px 100px">
        <center>
            <table style="width: 100%">
                <tr>
                    <td style="line-height: 20px; font-size: 20px; text-align: center; background-color: #e6e6e6;
                        border: solid 1px #000000; padding: 8px 0px;" colspan="3">
                        <strong>Payout And Earnings Statement</strong>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td style="border: #000000 solid 1px;">
                        <table style="width: 100%;" rules="all">
                            <tr>
                                <td class="Left_table" style="width: 200px;">
                                    Company Name
                                </td>
                                <td style="text-align: left;" class="right_table" colspan="3">
                                    <asp:Label ID="lblComapnyName" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table">
                                    Name
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;<asp:Label ID="lblName" runat="server"></asp:Label>
                                </td>
                                <td class="Left_table" style="width: 153px">
                                    User Id
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;<asp:Label ID="lblUserId" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table">
                                    Address
                                </td>
                                <td class="right_table" colspan="3" style="text-align: left">
                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table">
                                    Mobile Number
                                </td>
                                <td class="right_table" style="text-align: left">
                                    <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                </td>
                                <td class="Left_table" style="width: 153px">
                                    E Mail Id
                                </td>
                                <td class="right_table" style="text-align: left">
                                    <asp:Label ID="lblEMailId" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table">
                                    Pan No
                                </td>
                                <td class="right_table" style="text-align: left" colspan="3">
                                    <asp:Label ID="lblPanNO" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table" colspan="4">
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
                                <td class="Left_table" style="width: 153px">
                                    Ending
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;<asp:Label ID="lblPayoutToDate" runat="server">0</asp:Label>
                                </td>
                            </tr>


                             <tr>
                                <td class="Left_table">
                                   PBV
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;<asp:Label ID="lblpbv" runat="server">0</asp:Label>
                                </td>
                                <td class="Left_table" style="width: 153px">
                                    gbv
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;<asp:Label ID="lblgbv" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table" colspan="4">
                                    Team Size
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <%--   <table style="width: 100%" rules="all"  >
                                                <tr>
                                                    <td class="Left_table">
                                                    </td>
                                                    <td class="Left_table">
                                                        Total Paid
                                                    </td>
                                                    <td class="Left_table">
                                                        Newly Paid
                                                    </td>
                                                    <td class="Left_table">
                                                        Brought Forward
                                                    </td>
                                                    <td class="Left_table">
                                                        Calculated Paid
                                                    </td>
                                                    <td class="Left_table">
                                                        Carried Forward
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="Left_table">
                                                        Left</td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblTPL"  runat="server"></asp:Label></td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblNPL"  runat="server"></asp:Label></td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblBFL"  runat="server"></asp:Label></td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblCPL"  runat="server"></asp:Label></td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblCFL"  runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td class="Left_table">
                                                        Right</td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblTPR"  runat="server"></asp:Label></td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblNPR"  runat="server"></asp:Label></td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblBFR"  runat="server"></asp:Label></td>
                                                    <td class="right_table">
                                                        <asp:Label ID="lblCPR"  runat="server"></asp:Label></td>
                                                    <td class="right_table" style="width: 100px">
                                                        <asp:Label ID="lblCFR"  runat="server"></asp:Label></td>
                                                </tr>
                                            </table>--%>
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table" colspan="4">
                                    Earnings
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%" rules="all">
                           <%-- <tr>
                                <td style="width: 701px;" class="right_table">
                                    Matching Income
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblBinary" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Matching Bonus
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="Label1" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>
                           --%>

                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Co-sponsor
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblCoSponsor" runat="server">0</asp:Label>&nbsp;
                                </td>
                            </tr>

                            <tr>
                                <td class="right_table" style="width: 701px">
                                   FI
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblFi" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Performance Income
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="PI" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Performance Bonus
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblperofrmancebonus" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Performance Royalty
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblperfonanceroyalty" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Bike Fund
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblbikefund" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Travel Fund
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="bltravelfund" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Car Fund
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblcarfund" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    House Fund
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblhousefund" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Royalty Bonus
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblroyaltyfund" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Total Earnings
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblTotal" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Net earnings after deductions
                                </td>
                                <td class="right_table">
                                    <asp:Label ID="lblNet" runat="server">0</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="right_table" style="width: 701px">
                                    Paid in Cash
                                    <asp:CheckBox ID="CheckBox1" runat="server" TextAlign="Left" />
                                    or Cheque
                                    <asp:CheckBox ID="CheckBox2" runat="server" />
                                    or Account Transfer
                                    <asp:CheckBox ID="CheckBox3" runat="server" />&nbsp; or other
                                    <asp:CheckBox ID="CheckBox4" runat="server" />&nbsp; Specify _____<asp:Label ID="Label29"
                                        runat="server"></asp:Label>______ Net Amount Due :
                                </td>
                                <td class="right_table">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 12px; font-weight: 500; line-height: 20px; border: #000000 solid 1px;">
                        This is to certify the correctness of the above calculations and acknowledge the
                        receipt of the net amount due to me.<br />
                        We are thankful to all our Associate Members for their overwhelming response to
                        our <strong>Business Plan</strong>. We assure you that the confidence, which you
                        all have invested in us, will go a long way.<br />
                        We assure that, we can create a mutually beneficial long term working relationship
                        with you and assure you of our full co-operation in making this tie up a success
                        for both of us.<br />
                        This is computer generated document. No signature required.
                    </td>
                </tr>
            </table>
            <table style="width: 100%">
                <tr>
                    <td style="line-height: 20px; font-size: 12px; text-align: center; background-color: #e6e6e6;
                        border: solid 1px #000000; padding: 8px 0px;" colspan="3">
                        <asp:Label ID="lblCompanyAddress" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </center>
    </div>
    </form>
</body>
</html>

