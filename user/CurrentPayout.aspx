<%@ Page Title="" Language="C#" MasterPageFile="user.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="CurrentPayout.aspx.cs" Inherits="secretadmin_Title" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <div class="site-content">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-cart-arrow-down" aria-hidden="true"></i>&nbsp;Current Payout
            </div>
            <div class="panel-body">
                <asp:Panel ID="Panel1" runat="server">
                    <div class="clearfix">
                    </div>
                    <br />
                    <div class="col-sm-12">
                        <asp:Label ID="lblMessage" runat="server" CssClass="control-label" Font-Bold="true"></asp:Label>
                        <div class="table table-responsive">
                            <table width="100%;" border="1" cellpadding="2" cellspacing="2" class="table table-striped table-hover">
                                <tr>
                                    <td>
                                        Direct Income
                                    </td>
                                    <td>
                                        Total CV :
                                        <asp:Label ID="lbldirect" runat="server" Text="0"></asp:Label>
                                        X
                                        <asp:Label ID="lblper1" runat="server" Text="0"></asp:Label>% =
                                    </td>
                                    <td>
                                        Income :
                                        <asp:Label ID="lbldirectInc" runat="server" Text="0"></asp:Label>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        Self Income
                                    </td>
                                    <td>
                                        Self CV :
                                        <asp:Label ID="lbl_SelfCV" runat="server" Text="0"></asp:Label>
                                        X
                                        <asp:Label ID="lbl_Self_Per" runat="server" Text="0"></asp:Label>% =
                                    </td>
                                    <td>
                                        Income :
                                        <asp:Label ID="lbl_Self_directInc" runat="server" Text="0"></asp:Label>
                                    </td>
                                </tr>

                            </table>
                            <table width="100%;" border="1" cellpadding="2" cellspacing="2" class="table table-striped table-hover">
                                <tr>
                                    <td colspan="3">
                                        Maximizer Bonus
                                    </td>
                                </tr>
                                <%-- <tr>
                                    <td>
                                        Total CV Left :
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="lblcvleft" runat="server" Text="0"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Total CV Right :
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="lblcvright" runat="server" Text="0"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Total Matching
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="lblTotalMatching" runat="server" Text="0"></asp:Label>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        Current Matching :
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="lblMaxBonus" runat="server" Text="0"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Income :
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="lblMaxBonus1" runat="server" Text="0"></asp:Label>
                                        X
                                        <asp:Label ID="lblper" runat="server" Text="0"></asp:Label>% =
                                        <asp:Label ID="lblMaxBonusInc" runat="server" Text="0"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </asp:Panel>
            </div>
            <div class="clearfx">
            </div>
        </div>
    </div>
</asp:Content>
