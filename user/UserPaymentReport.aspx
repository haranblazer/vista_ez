<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="true" CodeFile="userpaymentreport.aspx.cs"
    Inherits="payoutstatement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Payout Statement</title>
    <link href="css/Payout.css" rel="stylesheet" />
    <link href="../secretadmin/css/bootstrap.min.css" rel="stylesheet" />
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
<body style="font-family: Arial, Helvetica, sans-serif;">
    <form id="form1" runat="server">
        <%--<div class="right-sign">
            <img src="../secretadmin/images/right-sign.png">
        </div>
        <div id="Idtaxinvoice" class="tax-invoice">
            <img src="images/payout.png">
        </div>--%>
        <div class="heading">
            <h2>Payout Statement</h2>
        </div>
        <br /><br />
        <header class="clearfix">
            <div class="row">
                <div class="col-md-6">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" Style="width: 250px; border-width: 0px;" />
                </div>
                <div class="col-md-6">
                    <asp:Label CssClass="payment" ID="lblComapnyName" runat="server"></asp:Label>
                    <br />
                    <div style="clear: both"></div>
                    <asp:Label ID="lblCompanyAddress" runat="server"></asp:Label>
                    <br />
                    <asp:Label ID="lblcompanywebsite" runat="server" Text="Label"></asp:Label>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12">
                    <p>
                <asp:Label ID="lblUserId" runat="server"></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                     
                <asp:Label ID="lblName" runat="server"></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                       
                <asp:Label ID="lblAddress" runat="server"></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                      
                <asp:Label ID="lblMobile" runat="server"></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                      
                <asp:Label ID="lblPAN" runat="server"></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                    <p>
                       
            <asp:Label ID="lblEMailId" runat="server"></asp:Label>
                    </p>
                    <div style="clear: both"></div>
                </div> 
                <div class="clearfix"></div>
              
                <div class="col-md-12">
                     <br />
                    <p style="text-align: center;">
                        <strong>Commission For The Period Beginning
                            <asp:Label ID="lblPayoutFromDate" runat="server">0</asp:Label>
                            Ending 
                            <asp:Label ID="lblPayoutToDate" runat="server">0</asp:Label>
                            Payout No  
                            <asp:Label ID="lblPayoutNo" runat="server">0</asp:Label></strong>
                    </p>
                </div>
            </div>
            <div class="row">
            <div class="col-md-6">
                 <%--<div class="heading">
            <h2>Earnings</h2>
        </div>--%>
                <br />
     
        <br />
                <div  style="background: #d9e8f7;     padding: 15px;">
                  <table class="table table-bordered text-center" rules="all">
            <tbody>
                 <tr style="background: #d9e8f7; font-weight: 700;">
                    <td>Active Bonus
                    </td>
                     <td style="text-align: right;">
                        <asp:Label ID="lblBinary" runat="server">0</asp:Label>
                    </td>
                     </tr>
                
                <tr style="background: #d9e8f7; font-weight: 700;">
                    <td>Self Help Club Bonus
                    </td>
                     <td style="text-align: right;">
                        <asp:Label ID="lbl_SelfHelpClubBonus" runat="server">0</asp:Label>
                    </td>
                    </tr>
                 <tr style="background: #d9e8f7; font-weight: 700;">
                    <td>Total
                    </td>
                      <td style="text-align: right;">
                        <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                    </td>
                     </tr>
                 <tr style="background: #d9e8f7; font-weight: 700;">
                   
                    <td>TDS
                    </td>
                     <td style="text-align: right;">
                        <asp:Label ID="lblTDS" runat="server">0</asp:Label>
                    </td>
                     </tr>

                <tr style="background: #d9e8f7; font-weight: 700;">
                   
                    <td>PC Charges</td>
                     <td style="text-align: right;">
                        <asp:Label ID="lblOC" runat="server">0</asp:Label>
                    </td>
                    </tr>
                     <tr style="background: #d9e8f7; font-weight: 700;">
                          <td>Release Amount</td>
                          <td style="text-align: right;">
                        <asp:Label ID="lbl_ReleaseAmt" runat="server">0</asp:Label></td>
                </tr>
                <tr style="background: #d9e8f7; font-weight: 700;">
                     <td>Net earnings after deductions</td>
                     <td style="text-align: right;">
                        <asp:Label ID="lblNet" runat="server">0</asp:Label></td>
                </tr>
               
            </tbody>
        </table>
                     <br /><br />
                    </div>
       

            </div>

        </div>
        </header>

        



        <%-- <div class="heading">
            <h2>Commission For The Period</h2>
        </div>
        <table class="table table-bordered text-center" rules="all">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">
                    <td width="25%">Beginning</td>
                    <td width="25%"></td>
                    <td width="25%"></td>
                    <td width="25%"></td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td>
                        
                    </td>
                    <td>
                       
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>--%>
        <br />
       <%-- <div class="heading">
            <h2>Pair Points</h2>
        </div>--%>
        <table class="table table-bordered text-center" rules="all" style="display: none;">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">
                    <td width="25%">TCC Left</td>
                    <td width="25%">TCC Right</td>
                    <td width="25%">New TCC Left</td>
                    <td width="25%">New TCC Right</td>
                </tr>
                <tr>
                    <td width="25%">
                        <asp:Label ID="lblTCCLeft" runat="server">0</asp:Label>
                    </td>
                    <td width="25%">
                        <asp:Label ID="lblTCCRight" runat="server">0</asp:Label>
                    </td>
                    <td width="25%">
                        <asp:Label ID="lblNewTCCLeft" runat="server">0</asp:Label>
                    </td>
                    <td width="25%">
                        <asp:Label ID="lblNewTCCRight" runat="server">0</asp:Label>
                    </td>
                </tr>
            </tbody>
        </table>
        <br />
        <table class="table table-bordered text-center" rules="all" style="display: none;">
            <tbody>
                <tr style="background: #e4e5e6; font-weight: 900;">
                    <td width="25%">TMI Left </td>
                    <td width="25%">TMI Right </td>
                    <td width="25%">Matched<%--BFL--%></td>
                    <td width="25%"></td>
                </tr>
                <tr>
                    <td width="25%">
                        <asp:Label ID="lblTMILeft" runat="server">0</asp:Label></td>
                    <td width="25%">
                        <asp:Label ID="lblTMIRight" runat="server">0</asp:Label></td>
                    <td width="25%">
                        <asp:Label ID="lblmatched" runat="server">0</asp:Label></td>
                    <td width="25%"></td>
                </tr>
            </tbody>
        </table>
        <br />
       
      
        <div id="b">
            <%-- <center>
                        <table class="table table-bordered" rules="all">
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
            <table class="table table-bordered">             


                <tr>
                    <td style="font-size: 12px; font-weight: 500; line-height: 20px;">
                        We are thankful to all our Associate Members for their overwhelming response to
                        our <strong>Business Plan</strong>. We assure you that the confidence, which you
                        all have invested in us, will go a long way.
                    </td>
                </tr>
            </table>
        </center>--%>
            <%--<img src="images/onhold.png" class="cancel" style="width: 50%; opacity:0.20;" id="imgbill"
            runat="server"/>--%>
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
                background-color: #002e9e;
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
