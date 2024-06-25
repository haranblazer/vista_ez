<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PayoutStatementReport.aspx.cs"
    Inherits="admin_PayoutStatementReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Repurchase Payout Statement</title>
    <style type="text/css">
        img.cancel {
            position: absolute;
            top: 90px;
            left: 30%;
        }

        .table {
            margin-bottom: 0px;
        }

        .payment {
            line-height: 28px;
            font-size: 15px;
            text-align: center;
            color: #000000;
            font-weight: bold;
            padding: 8px 0px;
        }

        body {
            position: relative;
            width: 22cm; /* height: 29.7cm; */
            margin: 0 auto;
            color: #001028;
            background: #FFFFFF;
            font-family: Arial, sans-serif;
            font-size: 12px;
            font-family: Arial;
        }

        .col-md-6 {
            flex: 0 0 auto;
            width: 50%;
        }

        .row {
            /* --bs-gutter-x: 30px;
    --bs-gutter-y: 0;*/
            display: flex;
            flex-wrap: wrap;
            /* margin-top: calc(var(--bs-gutter-y) * -1);
    margin-right: calc(var(--bs-gutter-x)/-2);
    margin-left: calc(var(--bs-gutter-x)/-2);*/
        }

        div#b {
            zoom: 100%;
        }

        p {
            margin: 2px 0;
        }

        .col-md-12 {
            flex: 0 0 auto;
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="heading">
            <h2>Payout Statement</h2>
        </div>
        <br />
        <br />
        <header class="clearfix">
            <div class="row">
                <div class="col-md-6">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" Width="150px"  />

                </div>
                <div class="col-md-6">

                    <br>
                    <div style="clear: both"></div>
                    <asp:Label ID="lblcompanyname" runat="server"><%=method.COMP_NAME%></asp:Label>
                    <br>
                    <asp:Label ID="lblcaddress" runat="server"></asp:Label>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12">
                    <p>
                        <asp:Label ID="lblid" runat="server" Text=""></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                        <asp:Label ID="lblname" runat="server" Text=""></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                        <asp:Label ID="lbladdress" runat="server" Text=""></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                        <asp:Label ID="lblmobile" runat="server" Text=""></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                        <asp:Label ID="lblpanno" runat="server" Text=""></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p></p>
                    <div style="clear: both"></div>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-12">
                    <br>
                    <div style="text-align: center;">
                        <strong>
                            <p style="background: #f7f7f7; padding: 10px; font-size: 20px;">
                                Payout Statement
                            <asp:Label ID="lblmonthyear" runat="server"></asp:Label>
                                From Date : 
                            <asp:Label ID="lblfrmdate" runat="server" Text=""></asp:Label>
                                To Date :  
                            <asp:Label ID="lbltodate" runat="server" Text=""></asp:Label>
                            </p>
                            <div class="clearfix"></div>
                            <p style="background: #f7f7f7; padding: 10px; font-size: 20px;">
                                Payout No 
                                <asp:Label ID="lblpayoutno" runat="server" Text=""></asp:Label>
                            </p>
                        </strong>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <br>
                    <div style="background: #f7f7f7; padding: 15px;">
                        <table class="table table-bordered text-center" rules="all">
                            <tbody>
                             <%--   Inc1 = @ST_B 	-- Startup Bonus 
		Inc2 = @P_B 	-- Performance Bonus
		Inc3 =@LST_B 	-- Lifestyle Bonus
		Inc4 =@PC_B		-- Prime Club Bonus
		Inc5 =@LB		-- Leadership Bonus
		Inc6 =@RC_B 	-- Royalty Club Bonus
		
		Inc7 =@SP 		-- Self Purchase Bonus--%>
                                <tr style="font-weight: 700;">
                                    <td>Startup Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_Inc1" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Performance Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_Inc2" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Lifestyle Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_Inc3" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <%-- <tr>
                                    <td style="border: 1px solid black;">
                                        <span class="Font_Size">Performace Bonus</span>
                                    </td>
                                    <td class="align" style="border: 1px solid black;">
                                        <asp:Label ID="lbl_BP" runat="server"></asp:Label>
                                    </td>
                                </tr>--%>
                                <tr style="font-weight: 700;">
                                    <td>Prime Club Bonus</td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_Inc4" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr style="font-weight: 700;">
                                    <td>Leadership Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_Inc5" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Royalty Club Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_Inc6" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr style="font-weight: 700;">
                                    <td>Self Purchase Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_Inc7" runat="server"></asp:Label>
                                    </td>
                                </tr>
                               <%-- <tr style="font-weight: 700;">
                                    <td>Diamond Directors Club Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_DF" runat="server"></asp:Label>
                                    </td>
                                </tr> --%>
                               <%-- <tr style="font-weight: 700;">
                                    <td>Double Diamond Directors Club Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_DDF" runat="server"></asp:Label>
                                    </td>
                                </tr>--%>

                                <%--<tr>
                                    <td style="border: 1px solid black;">
                                        <span class="Font_Size">Black Diamond Fund</span>
                                    </td>
                                    <td class="align" style="border: 1px solid black;">
                                        <asp:Label ID="lbl_BlkDF" runat="server"></asp:Label>
                                    </td>
                                </tr>--%>
                              <%--  <tr style="font-weight: 700;">
                                    <td>Ambassadors Club Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_CAF" runat="server">0</asp:Label>
                                    </td>
                                </tr>--%>
                                <tr style="font-weight: 700;">
                                    <td>Total Payout
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbltoalincentive" runat="server" Text="0.00"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td >TDS
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lblTDS" runat="server" Text="0.00"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td >Admin Charges
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lblHandlingChrgs" runat="server" Text="0.00"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Net Amount
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lblNetAmt" runat="server" Text="0.00"></asp:Label>
                                    </td>
                                </tr>
                               <%-- <tr style="font-weight: 700; display: none;">
                                    <td>Annual Royalty
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_ARF" runat="server">0</asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700; display: none;">
                                    <td>Offer Income 1
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_OfferInc1" runat="server">0</asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700; display: none;">
                                    <td>Offer Income 2
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_OfferInc2" runat="server">0</asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700; display: none;">
                                    <td>Offer Income 3
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_OfferInc3" runat="server">0</asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700; display: none;">
                                    <td>Offer Income 4
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_OfferInc4" runat="server">0</asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700; display: none;">
                                    <td>MG Income 
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_MG" runat="server">0</asp:Label>
                                    </td>
                                </tr>--%>
                            </tbody>
                        </table>
                        <br>
                        <br>
                    </div>
                </div>
                <div class="col-md-6">

                    <br>
                    <div style="background: #f7f7f7; padding: 15px; margin-left: 10px;">
                        <table class="table table-bordered text-center" rules="all">
                            <tbody>

                                <tr style="font-weight: 700;">
                                    <td>Repurchase Rank
                                    </td>
                                    <td>
                                        <asp:Label ID="lblprofitlevel" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td style="border: 1px solid black;">
                                        <span class="Font_Size">B/F GPV</span>
                                    </td>
                                    <td class="align" style="border: 1px solid black;">
                                        <asp:Label ID="lblbv" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Current <%=method.PV%>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCurrentppv" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Current <%=method.GBV%>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblcurrentgpv" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
    <td>Matched
    </td>
    <td>
        <asp:Label ID="lbl_Matched" runat="server"></asp:Label>
    </td>
</tr>
                                <tr style="display: none;">
                                    <td style="border: 1px solid black;">
                                        <span class="Font_Size">Total GPV</span>
                                    </td>
                                    <td class="align" style="border: 1px solid black;">
                                        <asp:Label ID="lbltbv" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td colspan="2" align="center" style="height: 70px;">
                                        <span class="Font_Size  Second_Head_Font_Size">Topper</span>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td style="border: 1px solid black;">
                                        <span class="Font_Size">No. of Topper</span>
                                    </td>
                                    <td class="align" style="border: 1px solid black;">
                                        <asp:Label ID="lbltopperunderyou" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br>
                        <br>
                    </div>
                </div>
            </div>
        </header>
        <br />
        <div width="100%" style="height: auto;  display: none;">
            <div class="heading">
                <h2>Leadership Bonus </h2>
            </div>
            <br />
            <header class="clearfix">
                <table width="100%" style="border-collapse: collapse;  display: none;">

                    <tr>
                        <th>S.NO.       </th>
                        <th>User ID       </th>
                        <th>User Name       </th>
                        <th>RPV       </th>
                        <th>Level       </th>
                        <th>LB%      </th>
                        <th>Amount       </th>
                    </tr>
                    <asp:Repeater ID="Repeater_LB" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td class="td align" style="text-align: left; width: 6.5%">
                                    <itemtemplate>
                                        <%#Container.ItemIndex+1 %>
                                    </itemtemplate>
                                </td>

                                <td class="td align" style="text-align: left; width: 10%">
                                    <%#Eval("userid").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 30%">
                                    <%#Eval("name").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 10%;">
                                    <%#Eval("RPV").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 12%">
                                    <%#Eval("Level").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 8%">
                                    <%#Eval("LB").ToString()%>  %
                                </td>
                                <td class="td align" style="text-align: left; width: 10%">
                                    <%#Eval("Amount").ToString()%> 
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </header>

            <div style="width: 100%; display: inline-block; border: 1px solid black; margin-top: 4px; ">
                <table id="tb1" width="100%" style="border-collapse: collapse;">
                    <tr>
                        <td colspan="8" align="center" style="height: 40px">
                            <span class="Head_Font_Size">Leadership Bonus </span>
                        </td>
                    </tr>
                    <tr>
                        <th>S.NO.
                        </th>
                        <th>ID No
                        </th>
                        <th>Associate Name
                        </th>
                        <th>Total GPV
                        </th>
                        <th>Status
                        </th>
                        <th>(%) Level
                        </th>
                        <th>Difference
                        </th>
                        <th>Incentive
                        </th>
                    </tr>
                    <asp:Repeater ID="Rpincome" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td class="td align" style="text-align: left; width: 6.5%">

                                    <itemtemplate>
                                        <%#Container.ItemIndex+1 %>
                                    </itemtemplate>

                                </td>

                                <td class="td align" style="text-align: left; width: 10%">
                                    <%#Eval("userid").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 30%">
                                    <%#Eval("name").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 10%;">
                                    <%#Eval("gbvamt").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 12%">
                                    <%#Eval("Incomerank").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 8%">
                                    <%#Eval("diffperc").ToString()%>
                                %
                                </td>
                                <td class="td align" style="text-align: left; width: 10%">
                                    <%#Eval("perc").ToString()%>
                                %
                                </td>
                                <td class="td align" style="text-align: left; width: 10%">
                                    <%#Eval("pincome").ToString()%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>



            <div style="width: 100%; display: inline-block; border: 1px solid black; margin-top: 4px; display: none">
                <table id="Table1" width="100%" style="border-collapse: collapse;">
                    <tr>
                        <td colspan="8" align="center" style="height: 40px">
                            <span class="Head_Font_Size">LEADERSHIP BONUS </span>
                        </td>
                    </tr>
                    <tr>
                        <th>S.NO.
                        </th>
                        <th>ID No
                        </th>
                        <th>Associate Name
                        </th>
                        <th>PGRP
                        </th>
                        <th>Status
                        </th>
                        <th>(%) age
                        </th>
                        <th>(%) Level
                        </th>
                        <th>Amount
                        </th>
                    </tr>
                    <asp:Repeater ID="liincome" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td class="td align" style="text-align: left; width: 6.5%">
                                    <itemtemplate>
                                        <%#Container.ItemIndex+1 %>
                                    </itemtemplate>
                                </td>
                                <td class="td align" style="text-align: left; width: 10%">
                                    <%#Eval("userid").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 30%">
                                    <%#Eval("name").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 10%;">
                                    <%#Eval("gbvamt").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 12%">
                                    <%#Eval("Incomerank").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 10%;">
                                    <%#Eval("perc").ToString()%>
                                </td>
                                <td class="td align" style="text-align: left; width: 8%;">
                                    <%#Eval("diffperc").ToString()%>
                                %
                                </td>
                                <td class="td align" style="text-align: left; width: 10%;">
                                    <%#Eval("liincome").ToString()%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
            <br />
            <div style="text-align: center; width: 100%; display: inline-block; margin-top: 4px">
                <span class="Head_Font_Size">END OF STATEMENT </span>
            </div>
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
                border: 1px solid #d9d9d9;
                padding: 10px;
            }

            header {
                /*position: relative;
                padding: 10px 0 0 22%;*/
                margin-bottom: 30px;
                width: 20cm;
                margin: auto;
            }

            .right-sign {
                position: absolute;
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
                    border-bottom: 2px dotted #0000;
                }



                table th {
                    padding: 5px;
                    color: #000;
                    border: 1px solid #d7d7d7;
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
                    border: 0;
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
                background-color: #ed1c3d;
                padding: 5px;
                text-align: center;
            }

                .heading h2 {
                    margin: 0;
                    font-size: 18px;
                    color: #fff;
                }
            /* #project span {
            font-weight: bold;
        }*/
        </style>
    </form>
</body>
</html>
