<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="phonepe_resp.aspx.cs" Inherits="phonepe_resp" %>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick"></asp:Timer>  
        </ContentTemplate>
    </asp:UpdatePanel>



    <div class="container">
        <br />
        <div id="div_containtSuccess" runat="server" visible="false" style="margin-bottom: 20px">
            <div class="bg">
                <div class="card">
                    <span class="card__success"><i class="fa fa-thumbs-up"></i></span>
                    <h1 class="card__msg">Payment Complete</h1>
                    <div id="div_paymentSuccess" runat="server" class="text-start"></div>

                    <a href="default" class="btn btn-primary btn-block">Go to home</a>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div id="div_containtError" runat="server" visible="false" style="margin-bottom: 20px">
            <div class="bg">
                <div class="card">
                    <span class="card__success1"><i class="fa fa-thumbs-down"></i></span>
                    <h1 class="card__msg">Payment Failed</h1>
                    <div id="div_paymentError" runat="server" class="text-start"></div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>


        <div id="div_paymentRequest" runat="server" style="display: none; margin-bottom: 20px">
            <center>
                <div class="timer animatable">
                    <svg>
                        <circle cx="50%" cy="50%" r="50" />
                        <circle cx="50%" cy="50%" r="50" pathlength="1" />
                        <text x="100" y="100" text-anchor="middle">
                            <tspan id="timeLeft"></tspan>
                        </text>
                        <text x="100" y="120" text-anchor="middle">seconds</text>
                    </svg>
                </div>
                <h5><span style="color: dodgerblue;">Your Payment Under Process. Do not refresh or hit back button. </span></h5>
            </center>
            <br />
        </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <asp:HiddenField ID="hdn_status" runat="server" Value="0" />
    <script type="text/javascript">
        var Sec = 0;
        var timeLeft = 0;
        var TotalSec = 0;
        $(function () {
            Getdatetime();
        });



        function Getdatetime() {
            setInterval(function () { 
                TotalSec = TotalSec + 1;
                if (TotalSec < 1200) {
                    runTimer(document.querySelector('.timer'));
                } else {
                    alert('Payment Fail.');
                    window.location = "default";
                }
            }, 1000);
            $('#<%=div_paymentRequest.ClientID%>').show();
        }



        let timer = document.getElementById('timeLeft');

        function runTimer(timerElement) { 
            $.ajax({
                type: "POST",
                url: 'phonepe_resp.aspx/GetTimer',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    timeLeft = data.d.timeLeft;
                    Sec = data.d.Sec;
                     //debugger;
                    const timerCircle = timerElement.querySelector('svg > circle + circle');
                    timerElement.classList.add('animatable');
                    timerCircle.style.strokeDashoffset = 1;
                    if (timeLeft > -1) {
                        const timeRemaining = timeLeft;
                        const normalizedTime = (parseInt(Sec) - timeRemaining) / parseInt(Sec);
                        timerCircle.style.strokeDashoffset = normalizedTime;
                        timer.innerHTML = timeRemaining;
                    } else {
                        timerElement.classList.remove('animatable');
                    }
                },
                error: function (response) { }
            });
        }
    </script>



    <style>
        .bg {
            width: 480px;
            /* overflow: hidden;*/
            margin: 0 auto;
            box-sizing: border-box;
            /*font-family: 'Roboto';*/
            margin-top: 40px;
        }

        .card {
            background-color: #fff;
            width: 480px;
            float: left;
            margin-top: 40px;
            border-radius: 5px;
            box-sizing: border-box;
            padding: 80px 30px 25px 30px;
            text-align: center;
            position: relative;
            /* box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);*/
            box-shadow: rgba(0, 0, 0, 0.3) 0px 19px 38px, rgba(0, 0, 0, 0.22) 0px 15px 12px;
        }

        .card__success {
            position: absolute;
            top: -50px;
            left: 40%;
            width: 100px;
            height: 100px;
            border-radius: 100%;
            background-color: green;
            border: 5px solid #fff;
        }

            .card__success i {
                color: #fff;
                line-height: 85px;
                font-size: 45px;
            }

        .card__success1 {
            position: absolute;
            top: -50px;
            left: 40%;
            width: 100px;
            height: 100px;
            border-radius: 100%;
            background-color: red;
            border: 5px solid #fff;
        }

            .card__success1 i {
                color: #fff;
                line-height: 85px;
                font-size: 45px;
            }

        .card__msg {
            text-transform: uppercase;
            color: #55585b;
            font-size: 26px;
            font-weight: 500;
            margin-bottom: 0px;
        }

        .card__submsg {
            color: #818181;
            font-size: 16px;
            font-weight: 400;
            margin: 0px 0px 10px;
            line-height: 20px;
        }

        .card__submsg1 {
            color: #818181;
            font-size: 14px;
            font-weight: 400;
            margin-top: 0px;
            line-height: 20px;
        }

        .timer > svg {
            width: 200px;
            height: 200px;
        }

            .timer > svg > circle {
                fill: none;
                stroke-opacity: 0.3;
                stroke: #0d6efd;
                stroke-width: 10;
                transform-origin: center center;
                transform: rotate(-90deg);
            }

                .timer > svg > circle + circle {
                    stroke-dasharray: 1;
                    stroke-dashoffset: 1;
                    stroke-linecap: round;
                    stroke-opacity: 1;
                }

        .timer.animatable > svg > circle + circle {
            transition: stroke-dashoffset 0.3s ease;
        }

        .timer > svg > text {
            font-size: 2rem;
        }

            .timer > svg > text + text {
                font-size: 1rem;
            }
    </style>

</asp:Content>

