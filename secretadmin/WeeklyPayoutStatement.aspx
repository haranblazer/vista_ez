<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeeklyPayoutStatement.aspx.cs" Inherits="secretadmin_WeeklyPayoutStatement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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
        <div>
            <div class="heading" style="display: none;">
                <h2>
                    <asp:Literal ID="lbl_Company" runat="server"></asp:Literal>
                </h2>
            </div>

            <div class="heading">
                <h2>Weekly Income Statement</h2>
            </div>

            <br />
            <header class="clearfix">
                <div class="row">
                    <div class="col-md-6">
                        <img id="Image1" src="../images/logo.png" style="width: 150px; border-width: 0px;">
                    </div>
                    <div class="col-md-6">
                        <br>
                        <div style="clear: both"></div>
                        <asp:Label ID="lblcompanyname" runat="server"><%=method.COMP_NAME%></asp:Label>
                        <br>
                        <asp:Label ID="lblcaddress" runat="server"><%=method.COMP_ADDRESS%></asp:Label>

                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <p>
                            <%--    lblid, lblname,lbladdress, lblmobile, lblpanno--%>
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
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12">

                        <div style="clear: both"></div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-12">
                        <br>
                        <div style="text-align: center; display: none;">
                            <strong>

                                <p style="background: #f7f7f7; padding: 10px; font-size: 15px;">
                                    <span>Period :
                                    <asp:Label ID="lbl_date" runat="server"></asp:Label></span>
                                </p>

                                <p style="background: #f7f7f7; padding: 10px; font-size: 15px;">
                                    User ID & Name : 
                    
                        <asp:Label ID="lbl_user" runat="server"></asp:Label>
                                </p>
                                <p style="background: #f7f7f7; padding: 10px; font-size: 15px;">
                                    Sponsor ID & Name
                    
                        <asp:Label ID="lbl_sponsor" runat="server"></asp:Label>
                                </p>
                                <p style="background: #f7f7f7; padding: 10px; font-size: 15px;">
                                    PAN : 
                     
                        <asp:Label ID="lbl_PAN" runat="server"></asp:Label>
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
                                    <tr>
                                        <td colspan="2" style="text-align: center"><b style="font-size: medium;">Business Details</b>
                                        </td>

                                    </tr>

                                    <tr style="display: none;">
                                        <td width="50%">B/F Self Cumulative TPV
                                        </td>
                                        <td width="50%" class="text-right">
                                            <asp:Label ID="lbl_BF_self_TPV" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td width="50%">Current Self TPV
                                        </td>
                                        <td width="50%" class="text-right">
                                            <asp:Label ID="lbl_self_TPV" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td width="50%">C/F Self Cumulative TPV
                                        </td>
                                        <td width="50%" class="text-right">
                                            <asp:Label ID="lbl_CF_self_TPV" runat="server"></asp:Label>
                                        </td>
                                    </tr>


                                    <tr style="display: none;">
                                        <td width="50%">Topper Type
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_TopperType" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="font-weight: 700;"><%=method.PV%> Matched
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_Pairs" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td width="50%">Total Matching
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_Matche" runat="server"></asp:Label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td width="50%" style="font-weight: 700;">Rank
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_TopperRank" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="font-weight: 700;">Status
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_Status" runat="server"></asp:Label>
                                        </td>
                                    </tr>

                                      <tr>
                                        <td width="50%" style="font-weight: 700;"><%=method.PV %>
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_PV" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td width="50%">B/F Cumulative Group TPV
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_BF_G_TPV" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="font-weight: 700;">Carry Forward Left
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_CFL" runat="server">0</asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="font-weight: 700;">Carry Forward Right
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_CFR" runat="server">0</asp:Label>
                                        </td>
                                    </tr>
                                      

                                      <tr>
      <td width="50%" style="font-weight: 700;">Total Matched Left
      </td>
      <td width="50%" style="text-align: right">
          <asp:Label ID="lbl_TML" runat="server">0</asp:Label>
      </td>
  </tr>
                                                                        <tr>
    <td width="50%" style="font-weight: 700;">Total Matched Right
    </td>
    <td width="50%" style="text-align: right">
        <asp:Label ID="lbl_TMR" runat="server">0</asp:Label>
    </td>
</tr>
                                                                        <tr>
    <td width="50%" style="font-weight: 700;">Brought Forward Left
    </td>
    <td width="50%" style="text-align: right">
        <asp:Label ID="lbl_BFL" runat="server">0</asp:Label>
    </td>
</tr>
                                                                        <tr>
    <td width="50%" style="font-weight: 700;">Brought Forward Right
    </td>
    <td width="50%" style="text-align: right">
        <asp:Label ID="lbl_BFR" runat="server">0</asp:Label>
    </td>
                                                                                                                <tr>
    <td width="50%" style="font-weight: 700;">Self Repurchase BV
    </td>
    <td width="50%" style="text-align: right">
        <asp:Label ID="lbl_SRBV" runat="server">0</asp:Label>
    </td>
                                                                                                                                   <tr>
    <td width="50%" style="font-weight: 700;">First Purchase BV
    </td>
    <td width="50%" style="text-align: right">
        <asp:Label ID="lbl_FPBV" runat="server">0</asp:Label>
    </td>
                                                                                                                                                                                                <tr>
    <td width="50%" style="font-weight: 700;">Highest Downline BV
    </td>
    <td width="50%" style="text-align: right">
        <asp:Label ID="lbl_HDBV" runat="server">0</asp:Label>
    </td>
</tr>
                                                                                                                                                                                                <tr>
    <td width="50%" style="font-weight: 700;">Second Highest BV
    </td>
    <td width="50%" style="text-align: right">
        <asp:Label ID="lbl_SHBV" runat="server">0</asp:Label>
    </td>
</tr>
                                                                                                                                                                                                <tr>
    <td width="50%" style="font-weight: 700;">Rest of Legs BV
    </td>
    <td width="50%" style="text-align: right">
        <asp:Label ID="lbl_ROLBV" runat="server">0</asp:Label>
    </td>
</tr>
</tr>
</tr>
</tr>


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
                                    <tr>
                                        <td colspan="2" style="font-weight: 700; text-align: center"><b style="font-size: medium;">Income Statement</b>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td width="50%" style="font-weight: 700;">Matching Bonus</td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_MatchingInc" runat="server"></asp:Label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td width="50%" style="font-weight: 700;">Total Payout
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_Incentive" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="font-weight: 700;">TDS
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_TDS" runat="server"></asp:Label></td>
                                    </tr>

                                    <tr>
                                        <td width="50%" style="font-weight: 700;">PC Charges
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <asp:Label ID="lbl_PCCharges" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="font-weight: 700;"><b>Net Amount</b>
                                        </td>
                                        <td width="50%" style="text-align: right">
                                            <b>
                                                <asp:Label ID="lbl_TotalIncome" runat="server"></asp:Label>
                                            </b>
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


            <table width="100%" class="table table-bordered">

                <asp:Repeater ID="Repeater" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tbody>
                                <tr style="background: #ddd;">
                                    <th class="service total-bold">#</th>
                                    <th class="desc total-bold">User ID</th>
                                    <th class="desc total-bold">User Name</th>
                                    <th class="desc total-bold">Carry Forward</th>
                                    <th class="desc total-bold"><%=method.GBV%></th>
                                </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="service"><%# Container.ItemIndex + 1 %></td>
                            <td class="desc"><%#Eval("AppMstRegNo") %> </td>
                            <td class="desc"><%#Eval("AppMstFName") %> </td>
                            <td class="desc"><%#Eval("CarryForward") %> </td>
                            <td class="desc"><%#Eval("GRP_TPV") %> </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody> </table> 
                    </FooterTemplate>
                </asp:Repeater>

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
