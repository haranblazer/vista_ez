<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeeklyPayoutStatement.aspx.cs" Inherits="secretadmin_WeeklyPayoutStatement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../secretadmin/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .payment {
            line-height: 28px;
            font-size: 15px;
            text-align: center;
            color: #000000;
            font-weight: bold;
            padding: 8px 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="right-sign">
            <img src="../secretadmin/images/right-sign.png">
        </div>
        <div id="Idtaxinvoice" class="tax-invoice">
            <img src="images/payout.png">
        </div>
        <header class="clearfix">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" Style="height: 60px; border-width: 0px;" />
            <div class="clearfix"></div>
            <br />
            <span class="payment"><asp:Literal ID="lbl_Company" runat="server"></asp:Literal></span>
            <br />
            <asp:Literal ID="lbl_CompAddress" runat="server"></asp:Literal>
            <br />
            <asp:Literal ID="lbl_Website" runat="server"></asp:Literal>
            <div class="clearfix"></div>
            <br>
        </header>
        <div class="heading">
            <h2>Weekly Fund Income Statement</h2>
        </div>
        <br />
        <table class="table table-bordered text-center" rules="all">
            <tbody>
                <tr style="background: #ecdaff; font-weight: 900;">
                    <td width="25%">Period </td>
                    <td width="25%">User ID & Name </td>
                    <td width="25%">Sponsor ID & Name </td>
                    <td width="25%">PAN </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_date" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbl_user" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbl_sponsor" runat="server"></asp:Label></td>
                    <td>
                        <asp:Label ID="lbl_PAN" runat="server"></asp:Label>
                    </td>
                </tr>


            </tbody>
        </table>

        <div class="heading">
            <h2>Business Details</h2>
        </div>
        <br />
        <table class="table table-bordered text-center" rules="all">
            <tbody>
                <tr style="background: #ecdaff; font-weight: 900;">
                    <td width="50%">Pairs Matched
                    </td>
                    <td width="50%">Rank
                    </td>


                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_Pairs" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbl_TopperRank" runat="server"></asp:Label>
                    </td>

                </tr>


            </tbody>
        </table>

        <div class="heading">
            <h2>Income Statement</h2>
        </div>
        <br />
        <table class="table table-bordered text-center" rules="all">
            <tbody>
                <tr style="background: #ecdaff; font-weight: 900;">
                    <td width="20%">
                        Matching Income
                    </td>
                     <td width="20%">
                         Total Incentive
                    </td>
                     <td width="20%">TDS
                    </td>
                     <td width="20%">
                         PC Charges
                     </td>
                          <td width="20%">  
                              Net Amount
                    </td>                    
                </tr>
                <tr>
                    <td> <asp:Label ID="lbl_MatchingInc" runat="server"></asp:Label></td>
                    <td><asp:Label ID="lbl_Incentive" runat="server"></asp:Label></td>
                    <td> <asp:Label ID="lbl_TDS" runat="server"></asp:Label></td>
                    <td> <asp:Label ID="lbl_PCCharges" runat="server"></asp:Label></td>
                    <td><asp:Label ID="lbl_TotalIncome" runat="server"></asp:Label></td>
                </tr>


            </tbody>
        </table>
        <div>
            <table width="100%" class="table table-bordered hidden">

                <tr style="display: none;">
                    <td width="50%">C/F Self Cumulative TPV
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_CF_self_TPV" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr style="display: none;">
                    <td width="50%">Type
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_TopperType" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr style="display: none;">
                    <td width="50%">Total Matching
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Matche" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr style="display: none;">
                    <td width="50%">B/F Cumulative Group TPV
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_BF_G_TPV" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr style="display: none;">
                    <td width="50%">Current Group TPV
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_Curr_G_TPV" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr style="display: none;">
                    <td width="50%">C/F Cumulative Group TPV
                    </td>
                    <td width="50%" class="text-right">
                        <asp:Label ID="lbl_CF_G_TPV" runat="server"></asp:Label>
                    </td>
                </tr>


            </table>
        </div>
        <style>
            .clearfix:after {
                content: "";
                display: table;
                clear: both;
            }

            a {
                color: #5D6975;
                text-decoration: underline;
            }

            body {
                position: relative;
                width: 23cm;
                /* height: 29.7cm; */
                margin: 0 auto;
                color: #001028;
                background: #FFFFFF;
                font-family: Arial, sans-serif;
                font-size: 15px;
                font-family: Arial;
            }

            header {
                position: relative;
                padding: 10px 0 0 22%;
                margin-bottom: 30px;
                /* width: 17cm; */
                margin: auto;
            }

            .right-sign {
                position: absolute;
                z-index: -1;
            }

            .tax-invoice {
                position: absolute;
                right: 0px;
            }

            #logo {
                text-align: center;
                margin-bottom: 10px;
            }

                #logo img {
                    width: 90px;
                }

            h1 {
                border-top: 1px solid #5D6975;
                border-bottom: 1px solid #5D6975;
                color: #5D6975;
                font-size: 2.4em;
                line-height: 1.4em;
                font-weight: normal;
                text-align: center;
                margin: 0 0 20px 0;
                background: url(dimension.png);
            }

            .total-bold {
                font-weight: bold;
            }

            #project {
                float: left;
                width: 40%;
            }

                #project span {
                    color: #001028;
                    text-align: left;
                    width: 100px;
                    margin-right: 10px;
                    display: inline-block;
                    line-height: 1.5;
                }

            #company span {
                /*font-weight: bold;*/
                color: #001028;
                text-align: left;
                width: 100px;
                margin-right: 10px;
                display: inline-block;
                line-height: 1.5;
            }

            #company {
                float: left;
                /* text-align: right; */
                width: 40%;
                margin-left: 20%;
            }

                #project div,
                #company div {
                    /*white-space: nowrap;   */
                }

            table {
                width: 100%;
                /* border-collapse: collapse;*/
                border-spacing: 0;
                margin-bottom: 20px;
            }

                table tr td {
                    /*background: #F5F5F5;*/
                    border-bottom: 2px dotted #000;
                }



                table th {
                    padding: 5px;
                    color: #000;
                    border-bottom: 2px dotted #000000;
                    white-space: nowrap;
                    font-weight: normal;
                }

                table .service,
                table .desc {
                    text-align: left;
                }

                table td {
                    padding: 5px;
                    /*text-align: right;*/
                }

                    table td.service,
                    table td.desc {
                        vertical-align: top;
                    }

                    table td.unit,
                    table td.qty,
                    table td.total {
                        font-size: 1.2em;
                    }

                    table td.grand {
                        /*border-top: 1px solid #5D6975;*/
                        border-bottom: 2px dotted #000;
                    }

            #notices .notice {
                color: #5D6975;
                font-size: 1.2em;
            }



            footer {
                color: #5D6975;
                width: 100%;
                height: 30px;
                position: absolute;
                bottom: 0;
                border-top: 1px solid #C1CED9;
                padding: 8px 0;
                text-align: center;
            }

            .heading {
                background: #fff0f0;
                padding: 5px;
                text-align: center;
            }

                .heading h2 {
                    margin: 0;
                    font-size: 18px;
                    color: #000000;
                }
            /* #project span {
            font-weight: bold;
        }*/
        </style>
    </form>
</body>
</html>
