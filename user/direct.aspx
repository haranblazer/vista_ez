<%@ Page Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="direct.aspx.cs" Inherits="direct" Title="Network Direct : User Control Panel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        @media (min-width: 1200px) {
            tr:nth-child(even) {
                background-color: #fff;
            }
        }

        tr:nth-child(even) {
            background-color: #fff;
            border-shadow: none;
            box-shadow: none;
            border: none;
        }

        tr:nth-child(odd) {
            background-color: #ffffff;
            box-shadow: none;
            border: none;
        }

        .gen {
            max-width: 67%;
        }

        @media only screen and (max-width: 520px) and (min-width: 180px) {
            .gen {
                width: 50%;
            }

            th, td {
                font-size: 11px;
            }
        }
    </style>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
    <script src="js/main1.js" type="text/javascript"></script>
    <script src="js/jquery.js" type="text/javascript"></script>


    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Genealogy</h4>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Enter User id"></asp:TextBox>
            <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
        </div>

        <div class="col-sm-1">
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                OnClick="btnSearch_Click" />
        </div>
        <div class="col-md-3"></div>
        <div class="col-md-1 col-2 text-center">
            <img src="images/paid_l.gif" />
            <div class="clearfix"></div>
            Paid A
        </div>
        <div class="col-md-1 col-2 text-center">
            <img src="images/paid_r.gif" />
            <div class="clearfix"></div>
            Paid B
        </div>
        <div class="col-md-1 col-2 text-center">
            <img src="images/unpaid_l.gif" />
            <div class="clearfix"></div>
            Unpaid A
        </div>
        <div class="col-md-1 col-2 text-center">
            <img src="images/unpaid_r.gif" />
            <div class="clearfix"></div>
            Unpaid B
        </div>
        <div class="col-md-1 col-2 text-center">
            <img src="images/part_paid_l.gif" />
            <div class="clearfix"></div>
            Partial A
        </div>
        <div class="col-md-1 col-2 text-center">
            <img src="images/part_paid_r.gif" />
            <div class="clearfix"></div>
            Partial B
        </div>
    </div>
    <div class="container-fluid page__container">
        <div class="panel card card-body">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="table-responsive">
                        <center>
                            <div id="tbl_UserDetail" runat="server" class="col-md-5 align-content-center">
                                <%--<table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <td colspan="4" style="background-color: #000; color: white">Member Current Status </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #d3d3d3;">
                                            <td style="text-align: center">Rahul </td>
                                            <td style="text-align: center">12345 </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #d3d3d3;">
                                            <td style="text-align: center">DOJ: 01/06/2024 </td>
                                            <td style="text-align: center">BV: 0  </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #d3d3d3;">
                                            <td style="text-align: center">GBV : 0 </td>
                                            <td style="text-align: center">Rank: 0 </td>
                                        </tr>
                                    </tbody>
                                </table>--%>
                            </div>
                        </center>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td colspan="9">
                                        <div style="float: right">
                                            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">More</asp:LinkButton>
                                        </div>
                                    </td>
                                    <td colspan="9">
                                        <div style="float: right"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9" witdh="100%">
                                        <center>
                                            <asp:ImageButton ID="ImageButton1" ImageUrl="images/paid12.gif" runat="server"
                                                Enabled="False" /><br />
                                            <asp:Label ID="Label1" runat="server" ForeColor="Black">Open</asp:Label><br />
                                            <asp:LinkButton ID="LinkButton5" runat="server" Font-Bold="False" Font-Size="14px"
                                                Enabled="False" OnClick="LinkButton5_Click"></asp:LinkButton><br />
                                            <img src="images/tree3_1.gif" class="img-responsive gen" style="min-width: 52%;" />
                                        </center>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" width="33.33%">
                                        <center>
                                            <asp:ImageButton ID="ImageButton2" ImageUrl="images/unpaid12.gif" runat="server"
                                                Enabled="False" /><br />
                                            <asp:Label ID="Label2" runat="server" ForeColor="Black">Open</asp:Label><br />
                                            <asp:LinkButton ID="LinkButton6" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton><br />
                                            <asp:Image ID="Image2" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen" Style="min-width: 52%;" />
                                            <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" Visible="False"
                                                SkinID="0">More</asp:LinkButton>
                                        </center>
                                    </td>
                                    <td colspan="3" width=" 33.33%">
                                        <center>
                                            <asp:ImageButton ID="ImageButton3" ImageUrl="images/unpaid12.gif" runat="server"
                                                Enabled="False" /><br />
                                            <asp:Label ID="Label3" runat="server" ForeColor="Black">Open</asp:Label>
                                            <br />
                                            <asp:LinkButton ID="LinkButton7" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton><br />
                                            <asp:Image ID="Image3" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen" Style="min-width: 52%;" />
                                            <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" Visible="False"
                                                Width="21px">More</asp:LinkButton>&nbsp;
                                    <%--<div style="float: right">
                                    </div>--%>
                                        </center>
                                    </td>
                                    <td colspan="3" width="33.33%">
                                        <center>
                                            <asp:ImageButton ID="ImageButton4" ImageUrl="images/unpaid12.gif" runat="server"
                                                Enabled="False" /><br />
                                            <asp:Label ID="Label4" runat="server" ForeColor="Black">Open</asp:Label><br />
                                            <asp:LinkButton ID="LinkButton8" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton><br />
                                            <asp:Image ID="Image4" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen" Style="min-width: 52%;" />
                                            <asp:LinkButton ID="LinkButton4" runat="server" OnClick="LinkButton4_Click" Visible="False">More</asp:LinkButton>
                                            <%--<div style="float: right; width: 26px;">
                                        </div>--%>
                                        </center>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton5" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        &nbsp;<asp:Label ID="Label5" runat="server" ForeColor="Black">Open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton9" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton6" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        <asp:Label ID="Label6" runat="server" ForeColor="Black">Open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton10" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton7" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        <asp:Label ID="Label7" runat="server" ForeColor="Black">Open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton11" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton8" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        <asp:Label ID="Label8" runat="server" ForeColor="Black">Open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton12" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton9" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        &nbsp;<asp:Label ID="Label9" runat="server" ForeColor="Black">open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton13" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton10" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        <asp:Label ID="Label10" runat="server" ForeColor="Black">Open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton14" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton11" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        &nbsp;<asp:Label ID="Label11" runat="server" ForeColor="Black">Open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton15" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton12" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        <asp:Label ID="Label12" runat="server" ForeColor="Black">Open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton16" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 11.11%;">
                                        <asp:ImageButton ID="ImageButton13" ImageUrl="images/unpaid12.gif" runat="server"
                                            Enabled="False" /><br />
                                        &nbsp;<asp:Label ID="Label13" runat="server" ForeColor="Black">Open</asp:Label><br />
                                        <asp:LinkButton ID="LinkButton17" runat="server" Font-Bold="False" OnClick="BindAgain"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
   
</asp:Content>
