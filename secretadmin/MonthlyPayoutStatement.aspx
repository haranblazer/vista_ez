<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MonthlyPayoutStatement.aspx.cs" Inherits="secretadmin_WeeklyPayoutStatement" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%" class="table table-bordered">
                <tbody>
                    <tr>
                        <th colspan="2" style="text-align: center;">
                            <h4 style="margin: 0px; font-weight: 700; color: Red;"><asp:Literal ID="lbl_Company" runat="server"></asp:Literal></h4>
                        </th>
                    </tr>
                    <tr>
                        <th colspan="2" style="text-align: center;">
                            <h4 style="margin: 0px; font-weight: 700; color: blue;">Monthly Topper Fund Income Statement</h4>
                        </th>
                    </tr>
                </tbody>
                <tr>
                    <td width="50%">Period
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_date" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">User ID & Name
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_user" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">Sponsor ID & Name
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_sponsor" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">PAN
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_PAN" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td width="50%"></td>
                    <td width="50%"></td>
                </tr>
                <tr>
                    <td width="50%"><b style="font-size: medium;">Business Details</b>
                    </td>
                    <td width="50%"></td>
                </tr>

              

                 <tr>
                    <td width="50%">Pairs Matched
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Pairs" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr style="display: none;">
                    <td width="50%">Total Matching
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Matching" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td width="50%">Topper Rank
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_TopperRank" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td width="50%"></td>
                    <td width="50%"></td>
                </tr>
                   
                <tr>
                    <td width="50%"><b style="font-size: medium;">Income Statement</b>
                    </td>
                    <td width="50%"></td>
                </tr>

                <tr>
                    <td width="50%">Bronze& Silver Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Bronze_Silver" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td width="50%">Gold Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Gold" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">Ruby Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Ruby" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">Pearl Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Pearl" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">Diamond Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Diamond" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">Double Diamond Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_DoubleDiamond" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">Blue Diamond Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_BlueDiamond" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">BlackDiamond Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_BlackDiamond" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">CrownAmbassador Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_CrownAmbassador" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">Offer Income</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_OfferIncome" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="50%">Reward Fund</td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_RewardFund" runat="server"></asp:Label>
                    </td>
                </tr>

                 <tr>
                    <td width="50%"><b>Total Incentive</b>
                    </td>
                    <td width="50%" class="text-right">
                        <b>
                            <asp:Label ID="lbl_Incentive" runat="server"></asp:Label>
                        </b>
                    </td>
                </tr>
                 <tr>
                    <td width="50%"><b>TDS</b>
                    </td>
                    <td width="50%" class="text-right">
                        <b>
                            <asp:Label ID="lbl_TDS" runat="server"></asp:Label>
                        </b>
                    </td>
                </tr>

                 <tr>
                    <td width="50%"><b>PC Charges</b>
                    </td>
                    <td width="50%" class="text-right">
                        <b>
                            <asp:Label ID="lbl_PCCharges" runat="server"></asp:Label>
                        </b>
                    </td>
                </tr>

                <tr>
                    <td width="50%"><b>Net Amount</b>
                    </td>
                    <td width="50%" class="text-right">
                        <b>
                            <asp:Label ID="lbl_TotalIncome" runat="server"></asp:Label>
                        </b>
                    </td>
                </tr>

            </table>
        </div>
        <style>
            body {
                position: relative;
                width: 18cm; /* height: 29.7cm; */
                margin: 0 auto;
                color: #001028;
                background: #FFFFFF;
                font-family: Arial, sans-serif;
                font-size: 12px;
                font-family: Arial; 
            } 
        </style>
    </form>
</body>
</html>

