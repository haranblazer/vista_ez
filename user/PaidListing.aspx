<%@ Page Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="PaidListing.aspx.cs" Inherits="user_PaidListing" Title="Paid Listing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="site-content">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-list" aria-hidden="true"></i>&nbsp;Paid Listing
            </div>
            <div class="panel-body">
                <p style="margin-left: 15px;">
                    Network Overview</p>
                <div class="table-responsive">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover" cellspacing="0" rules="all" border="1"
                            id="MainContent_GridView1" style="border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <td align="left" valign="top">
                                        <b>Title</b>
                                    </td>
                                    <td align="left" valign="top">
                                        <b>Paid Members</b>
                                    </td>
                                    <td align="left" valign="top">
                                        <b>Sponsor</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        Total
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:HyperLink ID="HyperLink5" runat="server">HyperLink</asp:HyperLink>
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:HyperLink ID="HyperLink6" runat="server">HyperLink</asp:HyperLink>
                                    </td>
                                </tr>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
