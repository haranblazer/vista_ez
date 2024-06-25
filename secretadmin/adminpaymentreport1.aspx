<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminpaymentreport1.aspx.cs"
    Inherits="admin_adminpaymentreport1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payout Statement</title>
    <link href="css/Payout.css" rel="stylesheet" />
     <style>
    .payment
    {
        line-height: 20px; font-size: 30px; text-align: center; color:#F26329; font-weight:bold;
                        padding: 8px 0px;
        }
    
    </style>
</head>
<body style="font-size: 14px; font-family: Arial, Helvetica, sans-serif;">
    <form id="form1" runat="server">
    <div style="padding: 10px 50px 10px 50px">
        <center>
            <table style="width: 90%">
                <tr>
                    <td width="20px" height="20px">
                        <asp:Image ID="Image1" runat="server" Width="75px" Height="75px" ImageUrl="~/images/logo (1).png" />
                    </td>
                    <td style=" text-align: center;" colspan="3">
                       
                       <asp:Label cssClass="payment" ID="lblComapnyName" runat="server"></asp:Label><br /><br />
                        <asp:Label ID="lblCompanyAddress" runat="server"></asp:Label><br />
                        <asp:Label ID="lblcompanywebsite" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td>
                    </td>
                </tr>
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
                                <td class="Left_table">
                                    Name
                                </td>
                                <td class="right_table" style="text-align: left; width:30%; ">
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
                                    GBV
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;
                                    <asp:Label ID="lblgbv" runat="server">0</asp:Label>
                                </td>
                                <td class="Left_table" style="width: 153px">
                                    PBV
                                </td>
                                <td class="right_table" style="text-align: left">
                                    &nbsp;
                                    <asp:Label ID="lblpbv" runat="server">0</asp:Label>
                                </td>
                            </tr>
                           
                            <tr>
                                <td colspan="4">
                                </td>
                            </tr>
                            <tr>
                                <td class="Left_table" colspan="4">
                                    Earnings
                                </td>
                            </tr>
                        </table>
                        <table rules="all" width="100%">
                            <tr>
                                <td class="right_table" style="width: 50%">
                                    <table width="100%" rules="all">
                                        <tr>
                                            <td class="right_table">
                                                Co-sponsor
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblCoSponsor" runat="server">0</asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Franchise Income
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblFi" runat="server">0</asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Performance Income
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="PI" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Performance Bonus
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblperofrmancebonus" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Performance Royalty
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblperfonanceroyalty" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Bike Fund
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblbikefund" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Travel Fund
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="bltravelfund" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Car Fund
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblcarfund" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                House Fund
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblhousefund" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Royalty Bonus
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblroyaltyfund" runat="server">0</asp:Label>
                                            </td>
                                        </tr>

                                          <tr runat="server" id="tr1">
                                            <td class="right_table">
                                               Franchise Sales Income
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblfsi" runat="server">0</asp:Label>&nbsp;
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
                                                Other Charges
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblOC" runat="server">0</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="right_table">
                                                Payment Amount
                                            </td>
                                            <td class="right_table">
                                                <asp:Label ID="lblTotal" runat="server">0</asp:Label>
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
                                                    runat="server"></asp:Label>______ Net Amount Due : &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="right_table" valign="top">
                                    <table cellpadding="0" cellspacing="0" id="AutoNumber2" width="100%">
                                        <tr>
                                            <td class="right_table" style="width: 5%">
                                                SNO
                                            </td>
                                            <td class="right_table" style="width: 20%">
                                                Name
                                            </td>
                                            <td class="right_table" style="width: 12%">
                                                Cause ID
                                            </td>
                                            <td class="right_table" style="width: 20%">
                                                User ID
                                            </td>
                                            <td class="right_table" style="width: 14%">
                                                Amount
                                            </td>
                                            <td class="right_table" style="width: 9%">
                                                PBV
                                            </td>
                                            <td class="right_table" style="width: 10%">
                                                GBV
                                            </td>
                                            <td class="right_table" style="width: 10%">
                                                Rank
                                            </td>
                                        </tr>
                                        <asp:Repeater ID="Repeater1" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="right_table" style="width: 5%">
                                                        <itemtemplate>
                                                     <%#Container.ItemIndex+1 %>
                                                     </itemtemplate>
                                                    </td>
                                                    <td class="right_table" style="width: 20%">
                                                        <asp:Label ID="lblname" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("Name")%>'></asp:Label>
                                                    </td>
                                                    <td class="right_table" style="width: 12%">
                                                        <asp:Label ID="lblcauseid" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("causeid")%>'></asp:Label>
                                                    </td>
                                                    <td class="right_table" style="width: 20%">
                                                        <asp:Label ID="lblregno" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("regno")%>'></asp:Label>
                                                    </td>
                                                    <td class="right_table" style="width: 14%">
                                                        <asp:Label ID="lblamount" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("amount")%>'></asp:Label>
                                                    </td>
                                                    <td class="right_table" style="width: 9%">
                                                        <asp:Label ID="lblbv" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("pbvamt")%>'></asp:Label>
                                                    </td>
                                                    <td class="right_table" style="width: 10%">
                                                        <asp:Label ID="Label1" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("gbvamt")%>'></asp:Label>
                                                    </td>
                                                    <td class="right_table" style="width: 10%">
                                                        <asp:Label ID="lblrank" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("rank")%>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </table>
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
    </div>
    </form>
</body>
</html>
