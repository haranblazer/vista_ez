<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="PayoutAllReport.aspx.cs" Inherits="User_PayourAllReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        td, th {
            padding: 5px 5px;
            border-color: #ddd;
        }
    </style>

    <div class="container-fluid page__heading-container">
        <div class="page__heading d-flex align-items-center">
            <div class="flex">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="#">Financial Report</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Payout Report</li>
                    </ol>
                </nav>
            </div>
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
    </div>


    <div class="container-fluid page__container">
        <div class="panel card card-body">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="table-responsive">
                        <h5>Total Payout</h5>
                        <table cellpadding="0" width="100%" cellspacing="0" class="table"
                            style="margin-top: 10px;">
                            <tr>
                                <th class="tatoal_ba">Topper Amount</th>
                                <th class="tatoal_ba">Topper Reward Amount</th>
                                <th class="tatoal_ba">Repurchase Amount</th>
                                <th class="tatoal_ba">Annual Royalty </th>
                                <th class="tatoal_ba">Total Amount</th>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_TotalTopperAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_TotalTopperRewardAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Total_RepurchaseAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_TotalAnnualRoyalty" runat="server" Text="0" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_TotalAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
                                </td>
                            </tr>
                        </table>
                         <div class="clearfix">
                        </div>
                        <hr />

                         <h5>Topper Payout</h5>
                         <div class="col-md-12">
                            <div class="row">
                                <label class="col-sm-1">Months</label>
                                <div class="col-sm-2">
                                    <asp:DropDownList ID="ddl_TopperMonth" runat="server" CssClass="form-control"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddl_TopperMonth_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <table cellpadding="0" width="100%" cellspacing="0" class="table" style="margin-top: 10px;">
                            <tr>
                                <th class="tatoal_ba">Topper Amount</th>
                                <th class="tatoal_ba">Topper Reward Amount</th>
                                <th class="tatoal_ba">Total Amount</th>
                                <th class="tatoal_ba">TDS Amount</th>
                                <th class="tatoal_ba">GC Charges</th>
                                <th class="tatoal_ba">Dispatched Amount</th>
                                <th class="tatoal_ba">Hold Amount</th>
                            </tr>
                            <tr>
                                 <td>
                                    <asp:Label ID="lbl_TopperPayout_Topper" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                 <td>
                                    <asp:Label ID="lbl_TopperRewardPayout_Topper" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_TotalAmountMonth_Topper" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td id="Td2" runat="server">
                                    <asp:Label ID="lbl_TDSAmountMonth_Topper" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_ChargesAmountMonth_Topper" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_DispatchedAmountMonth_Topper" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_HoldAmountMonth_Topper" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                            </tr>
                        </table>

                         <div class="clearfix">
                        </div>
                        <hr />

                         <h5>Genaration Payout</h5>
                        <div class="col-md-12">
                            <div class="row">
                                <label class="col-sm-1">Months</label>
                                <div class="col-sm-2">
                                    <asp:DropDownList ID="ddl_GenerationMonth" runat="server" CssClass="form-control"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddl_GenerationMonth_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <table cellpadding="0" width="100%" cellspacing="0" class="table" style="margin-top: 10px;">
                            <tr>
                                <th class="tatoal_ba">Repurchase Amount</th>
                                <th class="tatoal_ba">Annual Royalty </th>
                                <th class="tatoal_ba">Total Amount</th>
                                <th class="tatoal_ba">TDS Amount</th>
                                <th class="tatoal_ba">GC Charges</th>
                                <th class="tatoal_ba">Dispatched Amount</th>
                                <th class="tatoal_ba">Hold Amount</th>
                            </tr>
                            <tr>
                                 <td>
                                    <asp:Label ID="lbl_RepurchasePayout_Gen" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_AnnualRoyalty_Gen" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_TotalAmountMonth_Gen" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_TDSAmountMonth_Gen" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_ChargesAmountMonth_Gen" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_DispatchedAmountMonth_Gen" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_HoldAmountMonth_Gen" runat="server" Font-Bold="True">0</asp:Label>
                                </td>
                            </tr>
                        </table>
                        <div class="clearfix">
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    </div>


</asp:Content>

