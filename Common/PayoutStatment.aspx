<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PayoutStatment.aspx.cs" Inherits="Common_PayoutStatment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/Payout.css" rel="stylesheet" /><link href="https://toptime.in/secretadmin/css/bootstrap.min.css" rel="stylesheet" />
<style type="text/css">
        img.cancel {
            position: absolute;
            top: 90px;
            left: 30%;
        }

        .table {
            margin-bottom: 0px;
        }
    </style>
<style>
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

        div#b {
            zoom: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
       <%-- <div class="right-sign">
<img src="../secretadmin/images/right-sign.png">
</div>--%>
        <div class="tax-invoice">
            <img src="../secretadmin/images/franchises_payout.jpg" width="90px">
        </div>

        <header class="clearfix">
            <img id="Image1" src="../images/logo.png" style="  width: 140px; border-width: 0px;">
            <div class="clearfix"></div>
            <br>
            <span id="lblComapnyName" class="payment"><%=method.COMP_NAME %></span>
            <br>
            <div style="clear: both">
            </div>
            <span id="lblCompanyAddress"><%=method.COMP_ADDRESS %></span>
            <br>
            <span id="lblcompanywebsite">website : <%=method.WEB_URL %> / email :<%=method.COMP_EMAIL %></span>
            <div class="clearfix"></div>
            <br>
          
           
        </header>

          <div class="heading">
                <h2>Statement Payout</h2>
            </div>
        <br />
        <div class="table-responsive" >
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                EmptyDataText="Record not found." EmptyDataRowStyle-ForeColor="Red" ShowFooter="True">
                <FooterStyle Font-Bold="true" />
                <Columns>

                    <asp:TemplateField HeaderText="Invoive Number" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="#ddd">
                        <ItemTemplate><%# Eval("[Invoive Number]")%> </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Date" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="#ddd">
                        <ItemTemplate><%# Eval("Date")%> </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="FPV" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="#ddd" Visible="false">
                        <ItemTemplate><%# Eval("FPV")%> </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="APV" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="#ddd" Visible="false">
                        <ItemTemplate><%# Eval("APV")%> </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="COMM. on Purchases" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="#ddd">
                        <ItemTemplate><%# Eval("[Commission on FPV]")%> </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="COMM. on Sales" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="#ddd">
                        <ItemTemplate><%# Eval("[Commission on APV]")%> </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <b>
                <table class="table table-bordered text-center" >
                    <tr>
                        <td style="width: 58%"></td>
                        <td style="width: 40%; text-align: left;">Add Offer Income</td>
                        <td style="width: 10%; text-align: right;">
                            <asp:Label ID="lbl_OfferInc" runat="server">0</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style=" text-align: left;">Add Maintenance Expenses</td>
                        <td style=" text-align: right;">
                            <asp:Label ID="lbl_Maintenance_Expe" runat="server">0</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align: left;">Total Commission Payable</td>
                        <td style="text-align: right;">
                            <asp:Label ID="lbl_Total_commi_payable" runat="server">0</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align: left;">Less TDS</td>
                        <td style="text-align: right;">
                            <asp:Label ID="lbl_TDS" runat="server">0</asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 50%"></td>
                        <td style="width: 40%; text-align: left;">Net Commission Payable</td>
                        <td style="width: 10%; text-align: right;">
                            <asp:Label ID="lbl_Net_Commi_Payable" runat="server">0</asp:Label>
                        </td>
                    </tr>

                </table>
            </b>
        </div>


    </form>
   <style>
       th {
    text-align: right;
}

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
                background-color: #f47d35;
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
</body>
</html>
