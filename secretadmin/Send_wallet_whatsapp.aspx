<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Send_wallet_whatsapp.aspx.cs" Inherits="secretadmin_Send_wallet_whatsapp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Send Wallet & Whatsapp</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <hr />

    <div class="row">
        <div class="col-sm-3" style="font-weight: 700; font-size: 14px;">
            Generation Payout Send To Wallet
        </div>
        <div class="col-sm-2">
            <button type="button" id="btn_SendToGenerationWallet" runat="server" title="Search"
                class="btn btn-primary" onclick="Send('SendToGenerationWallet')">
                Send Generation Wallet</button>
        </div>
        <div class="col-sm-3">
            <div id="div_SendToGenerationWallet" runat="server"></div>
        </div>
        <div class="col-sm-3"></div>
    </div>

    <div class="row">
        <div class="col-sm-3" style="font-weight: 700; font-size: 14px;">
            WithDraw Generation Wallet
        </div>
        <div class="col-sm-2">
            <button type="button" id="btn_Sys_WithDraw_Generation" runat="server" title="Search"
                class="btn btn-primary" onclick="Send('Sys_WithDraw_Generation')">
                WithDraw Generation Wallet</button>
        </div>
        <div class="col-sm-3">
            <div id="lbl_Sys_WithDraw_Generation" runat="server"></div>
        </div>
        <div class="col-sm-3"></div>
    </div>

    <div class="row">
        <div class="col-sm-3" style="font-weight: 700; font-size: 14px;">
            Send Generation Rank Whatsapp
        </div>
        <div class="col-sm-2">
            <button type="button" id="btn_Generation_Rank_Achievement" runat="server" title="Search"
                class="btn btn-primary" onclick="Send('Generation_Rank_Achievement')">
                Send Generation Rank Whatsapp</button>
        </div>
        <div class="col-sm-3">
            <div id="div_Generation_Rank_Achievement" runat="server"></div>
        </div>
        <div class="col-sm-3"></div>
    </div>

    <div class="row">
        <div class="col-sm-3" style="font-weight: 700; font-size: 14px;">
            Send Generation Payout Whatsapp
        </div>
        <div class="col-sm-2">
            <button type="button" id="btn_Payout_Generation" runat="server" title="Search"
                class="btn btn-primary" onclick="Send('Payout_Generation')">
                Send Generation Payout Whatsapp</button>
        </div>
        <div class="col-sm-3">
            <div id="div_Payout_Generation" runat="server"></div>
        </div>
        <div class="col-sm-3"></div>
    </div>

    <div class="row">
        <div class="col-sm-3" style="font-weight: 700; font-size: 14px;">
            Send Loyalty Achievement Whatsapp
        </div>
        <div class="col-sm-2">
            <button type="button" id="btn_Loyalty_Points_Achievement" runat="server" title="Search"
                class="btn btn-primary" onclick="Send('Loyalty_Points_Achievement')">
                Send Loyalty Points Whatsapp</button>
        </div>
        <div class="col-sm-3">
            <div id="div_Loyalty_Points_Achievement" runat="server"></div>
        </div>
        <div class="col-sm-3"></div>
    </div>

    <div class="row">
        <div class="col-sm-3" style="font-weight: 700; font-size: 14px;">
            Send AWC Loyalty Achievement Whatsapp
        </div>
        <div class="col-sm-2">
            <button type="button" id="btn_AWC_Loyalty_Achievement" runat="server" title="Search"
                class="btn btn-primary" onclick="Send('AWC_Loyalty_Achievement')">
                Send AWC Loyalty Whatsapp</button>
        </div>
        <div class="col-sm-3">
            <div id="div_AWC_Loyalty_Achievement" runat="server"></div>
        </div>
        <div class="col-sm-3"></div>
    </div>

    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Send(MstKey) {
            if (!confirm('Are you sure you want to send？')) {
                return false;
            }
            $('#LoaderImg').show();

            if (MstKey == 'SendToGenerationWallet')
                $('#btn_SendToGenerationWallet').attr('disabled', true);

            if (MstKey == 'Sys_WithDraw_Generation')
                $('#btn_Sys_WithDraw_Generation').attr('disabled', true);

            if (MstKey == 'Generation_Rank_Achievement')
                $('#div_Generation_Rank_Achievement').attr('disabled', true);

            if (MstKey == 'Payout_Generation')
                $('#btn_Payout_Generation').attr('disabled', true);

            if (MstKey == 'Loyalty_Points_Achievement')
                $('#btn_Loyalty_Points_Achievement').attr('disabled', true);

            if (MstKey == 'AWC_Loyalty_Achievement')
                $('#btn_AWC_Loyalty_Achievement').attr('disabled', true);

            $.ajax({
                type: "POST",
                url: 'Send_wallet_whatsapp.aspx/Send_wallet_whatsapp',
                data: "{'MstKey':'" + MstKey + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#LoaderImg').hide();
                    if (response.d == "1") {
                        window.location = window.location.href;
                    }
                    else {
                        alert(response.d);
                    }
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
    </script>



</asp:Content>

