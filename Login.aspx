<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="~/Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/login2.css?v=0.1" rel="stylesheet" type="text/css" />

    <style>
        .support-area {
            display: none !important;
        }

        header {
            display: none !important;
        }

        footer {
            display: none !important;
        }

        .section {
            display: none;
        }

        .rd-mobilepanel {
            display: none;
        }

        ::placeholder {
            color: black !important;
            opacity: 1; /* Firefox */
        }

        :-ms-input-placeholder { /* Internet Explorer 10-11 */
            color: black !important;
        }

        ::-ms-input-placeholder { /* Microsoft Edge */
            color: black !important;
        }

        .rest {
            width: 100%;
        }

        .box {
            position: relative;
        }
        @media (max-width: 480px) {
            .box .square {
                display: none;
            }

            .login-container {
                margin: 20px auto;
            }

                .login-container .login-wrapper {
                    padding: 20px 0px;
                }
        }

            .box .square {
                position: absolute;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(5px);
                box-shadow: 0 25px 45px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.15);
                border-radius: 15px;
                animation: square 10s linear infinite;
                animation-delay: calc(-1s * var(--i));
               
            }

        @keyframes square {
            0%, 100% {
                transform: translateY(-20px);
            }

            50% {
                transform: translateY(20px);
            }
        }

        .box .square:nth-child(1) {
            width: 100px;
            height: 100px;
            top: -15px;
            right: -45px;
        }

        .box .square:nth-child(2) {
            width: 150px;
            height: 150px;
            top: 105px;
            left: -125px;
            z-index: 2;
        }

        .box .square:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 85px;
            right: -45px;
            z-index: 2;
        }

        .box .square:nth-child(4) {
            width: 50px;
            height: 50px;
            bottom: 35px;
            left: -95px;
        }

        .box .square:nth-child(5) {
            width: 50px;
            height: 50px;
            top: -15px;
            left: -25px;
        }

        .box .square:nth-child(6) {
            width: 85px;
            height: 85px;
            top: 165px;
            right: -155px;
            z-index: 2;
        }

        section {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradient 10s ease infinite;
        }

        @keyframes gradient {
            0% {
                background-position: 0% 50%;
            }

            50% {
                background-position: 100% 50%;
            }

            100% {
                background-position: 0% 50%;
            }
        }
    </style>
    <section>
        <div class="container-fluid">
            <div class="row">
                <div class="offset-md-4 col-md-4 col-sm-6 col-sx-12">
                    <div class="login-container">
                        <div class="box">
                            <div class="square" style="--i: 0;"></div>
                            <div class="square" style="--i: 1;"></div>
                            <div class="square" style="--i: 2;"></div>
                            <div class="square" style="--i: 3;"></div>
                            <div class="square" style="--i: 4;"></div>
                            <div class="square" style="--i: 5;"></div>
                            <div class="login-wrapper animated flipInY">
                                <div id="login" class="show">
                                    <img src="images/logo1.png" style="height: 65px;">
                                    <div style="padding: 20px 25px;">
                                        <div class="form-group has-feedback">
                                            <asp:DropDownList ID="ddltype" CssClass="form-control"  runat="server">
                                                <asp:ListItem Value="100" Selected="True">Associates</asp:ListItem>
                                                <%--<asp:ListItem Value="99" >Customer</asp:ListItem>--%>
                                                <asp:ListItem Value="0">Billing Panel</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group has-feedback">
                                            <label class="control-label" for="passWord">User ID</label>
                                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Enter Your User Id" Style="background-color: #fff;"></asp:TextBox>
                                        </div>
                                        <div class="form-group has-feedback">
                                            <label class="control-label" for="passWord">Password</label>
                                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter Your Password" autocomplete="off" TextMode="Password" Style="background-color: #fff;"></asp:TextBox>
                                        </div>
                                        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-login btn-lg btn-block" Style="color: White !important;" />
                                        <div class="col-md-12">
                                            <p class="text-center">
                                                <span><a href="ForgotsPassword.aspx" style="color: #000">Forgot Username/ Password? </a></span>
                                                <a class="txt2" href="newjoin.aspx" style="color: #000">Create your Account </a>
                                            </p>
                                        </div>
                                        <asp:Button ID="btn_preferredcust" runat="server" Text="Preferred Customer" OnClick="btn_preferredcust_Click" CssClass="btn btn-login btn-lg btn-block" Style="color: White !important;" />

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="login d-none">
            <div class=" container-fluid" style="padding-top: 0px; height: 100vh;">
                <div class="col-md-12" style="border-right: 1px solid #e6e6e6; display: none">
                    <span class="login100-form-title">&nbsp;
                     Latest News
                    </span>
                    <marquee direction="up" onmouseout="this.start();" onmouseover="this.stop();" scrollamount="1"
                        scrolldelay="3" style="width: 100%; height: 247px; text-align: left;">
                        <div id="divnews" class="panel-body" runat="server"></div>
                    </marquee>
                </div>
                <!-- Trigger/Open The Modal -->
                <!-- The Modal -->
                <div id="myModal" class="modal">
                    <!-- Modal content -->
                    <div class="modal-content" id="div_Subscribe">
                        <div>
                            <span class="close">&times;</span>
                            <img src="images/whatsapp.png" style="width: 35px; margin-bottom: 25px;"><br />
                            <h6 style="font-size: 15px; color: #000; font-weight: 700; font-family: 'Roboto';">Updates yours Whatsapp</h6>
                            <p style="font-size: 15px; margin-top: 5px; color: #000; font-family: sans-serif; font-weight: 700">
                                Do you want to receive important information
                                    <br />
                                and updates over <strong style="font-size: 17px;">Whatsapp?</strong>
                            </p>
                            <br />
                            <p style="font-size: 15px; margin-top: 5px; font-weight: 700; color: #000; font-family: sans-serif;">Please enter your phone number</p>
                            <div class="row">
                                <div class="col-md-8 col-xs-12">
                                    <input type="text" id="txt_Mobileno" class="input100"
                                        maxlength="12" placeholder="Please enter your phone number" style="background-color: #fff; font-size: 18px; margin-bottom: 5px;" />
                                </div>
                                <div class="col-md-4">
                                    <input type="button" id="btn_subscribe" value="SUBSCRIBE" onclick="return SUBSCRIBE()"
                                        style="width: 90px; height: 35px; font-size: 11px; background: #45c455; color: #fff; border-radius: 100px;" />
                                </div>
                                <div class="col-md-12" style="padding-left: 0px;">
                                    <br />
                                    <div id="lblmsg" class="col-sm-12 text-center" style="color: Red;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-content" id="div_Thanks" style="display: none; background: #45c455;">
                        <span class="close">&times;</span>
                        <center>
                            <img src="images/whatsapp.png" style="width: 35px; margin-bottom: 25px;"><br />
                            <h6 style="font-size: 25px; color: #fff; font-weight: 700; font-family: 'Roboto';">THANK YOU!</h6>
                            <p style="font-size: 18px; margin-top: 5px; color: #fff; font-family: sans-serif;">
                                You have successfully<br />
                                subscribed to notifications<br />
                                and updates over<br />
                                <strong>Whatsapp.</strong>
                            </p>
                            <br />
                        </center>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        // Get the modal
        var modal = document.getElementById("myModal");

        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks the button, open the modal 
        btn.onclick = function () {
            modal.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>


    <script type="text/javascript">
        $(function () {
            $('#txt_Mobileno').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    return false;
                }
                if ($('#txt_Mobileno').val().length == 10) {
                    return false;
                }
                if (e.keyCode == 13) {
                    SUBSCRIBE();
                }
            });

            $("#myBtn").click(function () {
                $('#lblmsg').html('');
                $('#div_Subscribe').show();
                $('#div_Thanks').hide();
                $('#txt_Mobileno').val('');
            });
        });


        function SUBSCRIBE() {
            var MSG = "";
            $('#lblmsg').html('');
            var UserType = $('#<%=ddltype.ClientID%>').val();
            var Mobileno = $('#txt_Mobileno').val();
            if (Mobileno == "") {
                MSG = "Please Enter Mobile No.!!";
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to subscribe.？')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: 'WhatsAppServices.aspx/WhatsApp_OPTIN',
                data: '{Mobileno: "' + Mobileno + '", UserType: "' + UserType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1") {
                        $('#txt_Mobileno').val('');
                        $('#div_Subscribe').hide();
                        $('#div_Thanks').show();
                    }
                    else {
                        $('#lblmsg').text(data.d);
                        $('#txt_Mobileno').val('');
                    }
                },
                error: function (response) {
                    $('#lblmsg').text("Server error. Time out.!!");
                    $('#txt_Mobileno').val('');
                    return false;
                }
            });
        }
    </script>



    <style>
        .wrap-login100 {
            width: 100%;
            padding: 0;
        }

        .btn-primary {
            color: #fff;
            background-color: #0242b8;
            border-color: #0242b8;
        }

            .btn-primary:hover {
                color: #fff;
                background-color: #ff6a00;
                border-color: #ff6a00;
            }

        .login100-form-btn {
            width: 100%;
            font-size: 20px;
            color: #555555;
            line-height: 1.2;
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0 6px;
            min-width: 120px;
            height: 35px;
            border-radius: 0px;
            background: #ffffff;
            /* background: -webkit-linear-gradient(bottom, #49ab31, #1c6119); */
            background: -o-linear-gradient(bottom, #7579ff, #b224ef);
            background: -moz-linear-gradient(bottom, #7579ff, #b224ef);
            background: linear-gradient(bottom, #7579ff, #b224ef);
            position: relative;
            z-index: 1;
            -webkit-transition: all 0.4s;
            -o-transition: all 0.4s;
            -moz-transition: all 0.4s;
            transition: all 0.4s;
        }

        ::placeholder {
            color: black;
        }

        ::-webkit-input-placeholder { /* Edge */
            color: black;
        }

        :-ms-input-placeholder { /* Internet Explorer 10-11 */
            color: black;
        }

        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgb(14 14 14 / 90%);
        }

        /* Modal Content */
        .modal-content {
            background-color: #e7e7e7;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 40%;
            border-radius: 10px;
        }

        /* The Close Button */
        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }

        blink {
            font-size: 18px;
            color: #000;
        }

        @media only screen and (max-width: 600px) {
            .modal-content {
                width: 100%;
            }
        }
    </style>
    <script type="text/javascript">
        function blink() {
            var blinks = document.getElementsByTagName('blink');
            for (var i = blinks.length - 1; i >= 0; i--) {
                var s = blinks[i];
                s.style.visibility = (s.style.visibility === 'visible') ? 'hidden' : 'visible';
            }
            window.setTimeout(blink, 1000);
        }
        if (document.addEventListener) document.addEventListener("DOMContentLoaded", blink, false);
        else if (window.addEventListener) window.addEventListener("load", blink, false);
        else if (window.attachEvent) window.attachEvent("onload", blink);
        else window.onload = blink;
    </script>
</asp:Content>
