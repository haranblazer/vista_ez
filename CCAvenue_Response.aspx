<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CCAvenue_Response.aspx.cs" Inherits="CCAvenue_Response" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <div id="div_Success" runat="server" class="col-md-4 m-auto" visible="false">
        <div class="card">
            <div style="border-radius: 200px; height: 80px; width: 80px; background: #F8FAF5; margin: 0 auto;">
                <i class="checkmark">✓</i>
            </div>
            <h4>Success</h4>

            <table class="table">
                <tr>
                    <td>Status Message</td>
                    <td>
                        <asp:Label ID="lbls_status_message" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Order Status</td>
                    <td>
                        <asp:Label ID="lbls_order_status" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Order Id</td>
                    <td>
                        <asp:Label ID="lbls_order_id" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Amount</td>
                    <td>
                        <asp:Label ID="lbls_amount" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Payment Mode</td>
                    <td>
                        <asp:Label ID="lbls_payment_mode" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>





    <div id="div_Error" runat="server" class="col-md-4 m-auto" visible="false">
        <div class="card">
            <div style="border-radius: 200px; height: 80px; width: 80px; background: #F8FAF5; margin: 0 auto;">
                <i class="checkmark" style="color: red">X</i>
            </div>
            <h4>Error</h4>
            <table class="table">
                <tr>
                    <td>Order Status</td>
                    <td>
                        <asp:Label ID="lble_order_status" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Order Id</td>
                    <td>
                        <asp:Label ID="lble_order_id" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Amount</td>
                    <td>
                        <asp:Label ID="lble_amount" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>



    <br />
    <br />

    <style>
        i {
            color: #86d112;
            font-size: 42px;
            line-height: 75px;
            /* margin-left: -15px; */
            font-weight: bold;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 4px;
            box-shadow: 0 2px 3px #C8D0D8;
            display: inline-block;
            margin: 0 auto;
            text-align: center;
            width: 100%;
        }
    </style>


</asp:Content>

