<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ForgotsPassword.aspx.cs" Inherits="ForgotsPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/login2.css" rel="stylesheet" type="text/css" />

    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script type="text/javascript">
        function Validate() {
            var uid = document.getElementById('<%=txtuserid.ClientID %>').value;
            var expuid = /^[a-zA-Z0-9]*$/;
            if (uid == "") {
                alert("The user id is required.");
                document.getElementById('<%=txtuserid.ClientID %>').focus();
                return false;
            }
            if (uid != "") {
                if (!expuid.test(uid)) {
                    alert("The user id contains alphanumeric value without space.");
                    document.getElementById('<%=txtuserid.ClientID %>').focus();
                    return false;
                }
            }
            return true;
        }
    </script>
    <style>
        /*header {
            display: none !important;
        }*/

      /*  footer {
            display: none !important;
        }*/



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

        textarea:focus, input:focus {
            border-color: #151515c2 !important;
        }
    </style>
   
    <div class="testmonial header_cat ptb-90">
        <div class="container">
            <div class="text-center">
                <h2>Forgot Password</h2>
                <div class="bread-crumb">
                    <span>
                        <a href="default.aspx">Home</a></span><i class="fa fa-angle-right"></i><span><a href="javascript:void(0)">Forgot Password</a>
                        </span>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 col-sm-6 col-sx-12">
                <div class="login-container">
                    <div class="login-wrapper animated flipInY">
                        <div id="login" class="show">
                            <div class="login-header">
                                <h3>Forgot Your Password?</h3>
                            </div>
                            <div style=" padding: 15px 25px  0px;">
                                <span class="login100-form-title" style="text-align: left; font-size: 16px;">
                                    <strong>Note : </strong>we will send your password on your registered mobile number.
                                </span>
                            </div>
                            <div style="padding: 25px 25px; ">
                                <div class="form-group has-feedback d-none">
                                    <asp:DropDownList ID="ddltype" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="1" Selected="True">Associates</asp:ListItem>
                                        <asp:ListItem Value="2">Franchise</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group has-feedback">
                                    <asp:TextBox ID="txtuserid" runat="server" class="form-control" placeholder="Enter Your User Id"></asp:TextBox>

                                </div>
                                <asp:Button ID="btnSubmit" runat="server" Text="Get Password"
                                    OnClick="btnSubmit_Click" OnClientClick="return  Validate();" CssClass="btn btn-login btn-lg btn-block" />

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>

    <style>
        .btn-login {
    background-color: #ff0041;
    border-color: #ff0041;
    color: #fff;
}
        .btn-login:hover {
      background-color: #ff0041;
    border-color: #ff0041;
    color: #fff;
}
        .login-container .login-header {
            background: #ff0041;
                margin-bottom: 0px;
        }
        .login-container .login-header h3{
            color:#fff;
                text-transform: capitalize;
        }
        body {
            background: #fff;
        }
        .login-container .login-wrapper {
    background: #f9e0e0;
    -webkit-border-radius: 2px;
    -moz-border-radius: 2px;
    border-radius: 2px;
    padding: 0px;
}
        header.header-style-five {
    background: #fff;
    box-shadow: 0 8px 6px -6px rgba(0,0,0,.4);
}
    </style>
</asp:Content>
