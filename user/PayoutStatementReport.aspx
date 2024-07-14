<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PayoutStatementReport.aspx.cs"
    Inherits="admin_PayoutStatementReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../user/css/bootstrap.min.css" rel="stylesheet" />
    <style>
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
                    <img id="Image1" src="../images/logo.png" style="width: 150px; border-width: 0px;">
                </div>
                <div class="col-md-6">

                    <br>
                    <div style="clear: both"></div>
                       <asp:Label ID="lblcompanyname" CssClass="payment" runat="server"></asp:Label>
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
                            <p style="background: #fff0f0; padding: 10px; font-size: 20px;">
                                Payout Statement
                            <asp:Label ID="lblmonthyear" runat="server"></asp:Label>
                                From Date : 
                           <asp:Label ID="lblfrmdate" runat="server" Text=""></asp:Label>
                                To Date :  
                           <asp:Label ID="lbltodate" runat="server" Text=""></asp:Label>
                            </p>
                            <div class="clearfix"></div>
                           <%-- <p style="background: #f7f7f7; padding: 10px; font-size: 20px;">
                                Payout No 
                                <span id="lblpayoutno"></span>
                            </p>--%>
                        </strong>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <br>
                    <div style="background: #fff0f0; padding: 15px;">
                        <table class="table table-bordered text-center" rules="all">
                            <tbody>
                                <tr style="font-weight: 700;">
                                    <td>Self Repurchase Bonus
                                    </td>
                                    <td style="text-align: right;">
                                         <asp:Label ID="lblPI" runat="server" Style="display: none;"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Sales Matching Bonus
                                    </td>
                                    <td style="text-align: right;">
                                      <asp:Label ID="lbl_LB" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>StartUp Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                       
                                    </td>
                                </tr>

                                <tr style="font-weight: 700;">
                                    <td>Lifestyle Bonus</td>
                                    <td style="text-align: right;">
                                       <asp:Label ID="lbl_TF" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr style="font-weight: 700;">
                                    <td>Prime Club Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_LCF" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Leadership Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_HF" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr style="font-weight: 700;">
                                    <td>Royalty Club Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_BlueDF" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr style="font-weight: 700;">
                                    <td>Double Diamond Directors Club Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_DDF" runat="server"></asp:Label>
                                    </td>
                                </tr>


                                <tr style="font-weight: 700;">
                                    <td>Ambassadors Club Bonus
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lbl_CAF" runat="server">0</asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Total Incentive
                                    </td>
                                    <td style="text-align: right;">
                                       <asp:Label ID="lbltoalincentive" runat="server" Text="0.00"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>TDS
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:Label ID="lblTDS" runat="server" Text="0.00"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>PC Charges
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

                            </tbody>
                        </table>
                        <br>
                        <br>
                    </div>
                </div>
                <div class="col-md-6">

                    <br>
                    <div style="background: #ecdaff; padding: 15px; margin-left: 10px;">
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
                                    <td>Current PPV
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCurrentppv" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="font-weight: 700;">
                                    <td>Current GPV
                                    </td>
                                    <td>
                                       <asp:Label ID="lblcurrentgpv" runat="server"></asp:Label>
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

     <%--   <div class="right-sign">
            <img src="../secretadmin/images/right-sign.png">
        </div>
        <div id="Idtaxinvoice" class="tax-invoice">
            <img src="images/payout.png">
        </div>--%>

        <header class="clearfix" style="display:none;">
            <asp:Image ID="Image2" runat="server" ImageUrl="~/images/logo.png" Width="140px" />
            <div class="clearfix"></div>
            <br>
            <span class="COM_Font_Size">
             </span><br />
            <span class="Cad_Font_Size">
               </span>
            <div class="clearfix"></div>
            <div class="heading">
                <h2>Payout And Earnings Statement</h2>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <table class="table table-bordered" rules="all">
                        <tbody>
                            <tr>
                                <td>ID No.
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>Name
                                </td>
                                <td>
                                   
                                </td>
                            </tr>
                            <tr>
                                <td>Address
                                </td>
                                <td>
                                   
                                </td>
                            </tr>
                            <tr>
                                <td>Mobile
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>Pan
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-6">
                    <table class="table table-bordered" rules="all">
                        <tbody>
                            <tr style="background: #e4e5e6; font-weight: 900;">
                                <td colspan="2">Repurchase Income Statement
                                        
                                </td>
                            </tr>
                            <tr>
                                <td>From date :
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>To date :
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr style="background: #e4e5e6; font-weight: 900;">
                                <td colspan="2">Repurchase Rank
                                    </td>
                            </tr>
                            <tr>
                                <td>Current PPV
                                </td>
                                <td>
                                    </td>
                            </tr>
                            <tr>
                                <td>Current GPV
                                </td>
                                <td>
                                    </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>


        </header>
        <table class="table table-bordered text-center" rules="all" style="display:none">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">

                    <td width="25%">Leadership Bonus
                    </td>
                    <td width="25%">Starter Fund</td>
                    <td width="25%">Two Wheeler Fund</td>
                    <td width="25%"><%--Self Purchase--%></td>
                </tr>
                <tr>

                    <td>
                        
                    </td>
                    <td>
                        <asp:Label ID="lbl_SF" runat="server"></asp:Label></td>
                    <td>
                        <asp:Label ID="lbl_BP" runat="server"></asp:Label></td>
                    <td>
                       
                    </td>
                </tr>
            </tbody>
        </table>
        <table class="table table-bordered text-center" rules="all" style="display:none">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">
                    <td width="25%">Travel Fund</td>
                    <td width="25%">Car Fund
                    </td>
                    <td width="25%">House Fund</td>
                    <td width="25%">Diamond Fund</td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td>
                        
                    </td>
                    <td>
                        </td>
                    <td>
                        <asp:Label ID="lbl_DF" runat="server"></asp:Label></td>
                </tr>
            </tbody>
        </table>
        <table class="table table-bordered text-center" rules="all" style="display:none">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">
                    <td width="25%">Double Diamond Fund</td>
                    <td width="25%">Blue Diamond Fund
                    </td>
                    <td width="25%">Black Diamond Fund</td>
                    <td width="25%">Crown Ambassador Fund</td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td>
                        
                    </td>
                    <td>
                        <asp:Label ID="lbl_BlkDF" runat="server"></asp:Label></td>
                    <td>
                        </td>
                </tr>
            </tbody>
        </table>
        <table class="table table-bordered text-center" rules="all" style="display:none">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">
                    <td width="20%">Diamond Booster Fund</td>
                    <td width="20%">Super 20 Booster Fund</td>
                    <td width="20%">Super 4 Booster Fund</td>
                    <td width="20%">GRP Booster Fund</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_OfferInc1" runat="server">0</asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbl_OfferInc2" runat="server">0</asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbl_OfferInc3" runat="server">0</asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbl_OfferInc4" runat="server">0</asp:Label>
                    </td>
                </tr>
            </tbody>
        </table>
        <table class="table table-bordered text-center" rules="all" style="display:none">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">
                    <td width="20%">Total Incentive</td>
                    <td width="20%">TDS </td>
                    <td width="20%">PC Charges</td>
                    <td width="20%">Net Amount</td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td>
                        
                    </td>
                    <td>
                        
                    </td>
                    <td>
                        
                    </td>
                </tr>
            </tbody>
        </table>

        <table class="table table-bordered text-center" rules="all" style="display:none">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">
                    <td>Annual Royalty</td>
                    <td>Self Purchase (P-Wallet) </td>
                    <td>Total Benefits</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_ARF" runat="server">0</asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbl_Prod_Wallet" runat="server" Text="0.00"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbl_TotalBenefits" runat="server" Text="0.00"></asp:Label>
                    </td>

                </tr>
            </tbody>
        </table>
        <%--<div class="heading">
            <h2>Leadership Bonus</h2>
        </div>--%>
        <br />
        <table width="100%" class="table table-bordered" style="display:none">
            <tr style="background: #e4e5e6; font-weight: 900; text-align: left; width: 10%">
                <th>#</th>
                <%--<th>User ID       </th>
                <th>User Name       </th>
                <th>RPV       </th>--%>
                <th>Level       </th>
                <%-- <th>LB%      </th>--%>
                <th>Amount       </th>
            </tr>
            <asp:Repeater ID="Repeater_LB" runat="server">
                <ItemTemplate>
                    <tr>
                        <td class="td align" style="text-align: left; width: 10%">
                            <itemtemplate>
                                <%#Container.ItemIndex+1 %>
                            </itemtemplate>
                        </td>

                        <%--  <td class="td align" style="text-align: left; width: 10%">
                            <%#Eval("userid").ToString()%>
                        </td>
                        <td class="td align" style="text-align: left; width: 30%">
                            <%#Eval("name").ToString()%>
                        </td>
                        <td class="td align" style="text-align: left; width: 10%;">
                            <%#Eval("RPV").ToString()%>
                        </td>--%>
                        <td class="td align" style="text-align: left; width: 12%">
                            <%#Eval("paymentcause").ToString()%>    <%#Eval("Level").ToString()%>
                        </td>
                        <%-- <td class="td align" style="text-align: left; width: 8%">
                            <%#Eval("LB").ToString()%>  %
                        </td>--%>
                        <td class="td align" style="text-align: left; width: 10%">
                            <%#Eval("Amount").ToString()%> 
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>



        <div width="100%" style="height: auto;" style="display:none">

            <table width="100%" class="table table-bordered hidden">
                <tr>
                    <td valign="top">
                        <table class="table table-bordered">
                            <tr style="display: none;">
                                <td>
                                    <span class="Font_Size">B/F GPV</span>
                                </td>
                                <td class="align">
                                    
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td style="border: 1px solid black;">
                                    <span class="Font_Size">Total GPV</span>
                                </td>
                                <td class="align" style="border: 1px solid black;">
                                   
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
                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <div class="clearfix"></div>








            <div class="clearfix"></div>


            <div style="width: 100%; display: inline-block; border: 1px solid black; margin-top: 4px; display: none;">
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
                               
                                </td>
                                <td class="td align" style="text-align: left; width: 10%;">
                                    <%#Eval("liincome").ToString()%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
            <div style="text-align: center; width: 100%; display: inline-block; border: 1px solid black; margin-top: 4px; display:none;">
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
                width: 22cm;
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
