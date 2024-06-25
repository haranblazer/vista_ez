<%@ Page Title="" Language="C#" MasterPageFile="member.master" AutoEventWireup="true" CodeFile="welcome.aspx.cs" Inherits="member_welcome" %>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <style type="text/css">
        .fa-2x {
            font-size: 2em;
        }

        .classic-tabs .nav li a {
            display: block;
            padding: 20px 20px;
            font-size: 13px;
            text-align: center;
            text-transform: uppercase;
            border-radius: 0;
        }

        .tab-content {
            padding-top: 2rem;
        }

        .classic-tabs .nav.tabs-orange li a.active {
            border-color: #e16123;
        }

        .classic-tabs .nav li a.active {
            color: #ea680f;
            border-bottom: 3px solid;
            background: #f7f7f7;
        }

        .fade {
            opacity: 3;
            -webkit-transition: opacity .15s linear;
            -o-transition: opacity .15s linear;
            transition: opacity .15s linear;
        }

        .card {
            min-height: 200px;
        }
        /*---- end---*/
        @media only screen and (max-width: 500px) {
            .bdynx {
                height: auto !important;
                width: 320px !important;
            }
        }


        .acolor {
            color: #fff;
        }

        .dashboard-stat {
            display: block;
            padding: 30px 15px;
            text-align: right;
            font-size: 20px;
            position: relative;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
        }

        .dashboard-stat1 {
            display: block;
            padding: 10px 10px;
            font-size: 20px;
            position: relative;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
        }

        .dashboard-stat .bg-icon {
            position: absolute;
            font-size: 80px;
            opacity: 0.4;
            left: 0;
            bottom: 0;
        }
    </style>
    <script src="js/jquery.counterup.js" type="text/javascript"></script>

    <script src="js/jquery.counterup.min.js" type="text/javascript"></script>
    <style type="text/css">
        @media (min-width: 1140px) {
            html, body {
                font-size: 14px;
            }
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            padding: 8px;
            line-height: 2.2;
            vertical-align: top;
            border-top: 1px solid #ddd;
        }

        body {
            font-family: 'Varela Round', sans-serif;
        }

        .countDown {
            display: inline-block;
            margin: auto;
        }

        .nbvc_1 {
            padding: 15px !important;
        }

        .countDown span {
            display: block; /* background: #fffefe; */
            color: #ffffff;
            height: 45px;
            float: left;
            margin-right: 5px;
            padding: 4px;
            border-radius: 5px;
            font-size: 25px;
            line-height: normal;
            text-align: center;
            border: 1px solid #89c7e4;
            box-shadow: 2px 2px 8px #89c7e4; /* background-color: black; */
            background-size: contain;
            background-repeat: repeat-x;
        }

        #days:after, #hours:after, #minutes:after, #seconds:after {
            font-size: 14px;
            line-height: normal;
            display: block;
            width: inherit;
            margin-top: 10px;
            color: #5C5757;
            text-align: center;
        }

        #days:after {
            content: "Days";
        }

        #minutes:after {
            content: "Minutes";
        }

        #hours:after {
            content: "Hours";
        }

        #seconds:after {
            content: "Seconds";
        }

        .span_cng {
            padding-top: 10px;
        }

        @media only screen and (max-width: 480px) {
            p, h2, h3, h4, h5 {
                font-size: 10px;
            }

            .bk_mg_fg {
                height: 260px !important;
                overflow: scroll;
            }
        }

        @media only screen and (min-width: 1200px) {
            .countDown span {
                float: left;
                margin-left: 15px; /* padding-top: 14px; */
                margin-top: 6px;
            }

            .countDown span1 {
                float: left;
                margin-left: 16px;
            }
        }

        .panel1 {
            box-shadow: 0 2px 2px 0 rgba(0,0,0,0.14), 0 3px 1px -2px rgba(0,0,0,0.2), 0 1px 5px 0 rgba(0,0,0,0.1);
        }
    </style>

    <asp:HiddenField ID="hnf_DailyPayoutDate" runat="server" Value="" />
    <asp:HiddenField ID="hnf_WeeklyPayoutDate" runat="server" Value="" />
    <asp:HiddenField ID="hnf_MonthlyPayoutDate" runat="server" Value="" />

    <div class="text-center">
        <!-- Button HTML (to Trigger Modal) -->
        <button type="button" class="btn btn-primary mb-2 launch-modal" data-bs-toggle="modal" data-bs-target="#basicModal">Basic modal</button>
    </div>

    

    <!-- Modal HTML -->
    <div id="basicModal2" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="fa fa-check"></i>
                    </div>
                    <h4 class="modal-title w-100">Success!</h4>
                </div>
                <div class="modal-body pb-0">
                    <p class="text-center">
                        Your booking has been confirmed. Check your email for detials. 
                    <span>
                        <button type="button" class="btn btn-primary btn-xxs" style="min-height: 0px;">Copy</button></span>
                    </p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-primary btn-block" data-bs-dismiss="modal">Close</button>
                    <%--<button class="btn btn-success btn-block" data-dismiss="modal">OK</button>--%>
                </div>
            </div>
        </div>
    </div>

    <style>
.modal-confirm .modal-header {
              border-bottom: none;
              position: relative;
          }

          .modal-confirm h4 {
              text-align: center;
              font-size: 26px;
              margin: 30px 0 -15px;
          }

          .modal-confirm .icon-box {
              color: #fff;
              position: absolute;
              margin: 0 auto;
              left: 0;
              right: 0;
              top: -55px;
              width: 95px;
              height: 95px;
              border-radius: 50%;
              z-index: 9;
              background: #82ce34;
              padding: 15px;
              text-align: center;
              box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
          }

              .modal-confirm .icon-box i {
                  font-size: 58px;
                  position: relative;
                  top: 3px;
              }

          .modal-confirm.modal-dialog {
              margin-top: 80px;
          }

          </style>
</asp:Content>

