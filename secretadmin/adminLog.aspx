<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminLog.aspx.cs" Inherits="admin_adminLog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Panel</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/png" href="../images/favicon.png" />
    <link href="css/bootstrap.css" rel="stylesheet" media="screen">
    <!-- Animate CSS -->
    <link href="css/animate.css" rel="stylesheet" media="screen">
    <!-- Main CSS -->
    <link href="css/main.css" rel="stylesheet" media="screen">
    <!-- Main CSS -->
    <link href="css/login.css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-push-4 col-md-4 col-sm-push-3 col-sm-6 col-sx-12">
                    <!-- Header end -->
                    <div class="login-container">
                        <div class="login-wrapper animated flipInY">
                            <div id="login" class="show">
                                <div class="login-header">
                                    <h3>ADMINISTRATOR LOGIN</h3>
                                </div>
                                <br>
                                <img src="../images/logo.png">
                                <div style="padding: 20px 25px;">
                                    <div class="form-group has-feedback">
                                        <label class="control-label" for="userName">Username</label>

                                        <asp:TextBox ID="txtId" runat="server" MaxLength="20" placeholder="User Name" CssClass="form-control" pattern="^[a-zA-Z0-9]+$" title="User Name must contain including letters and numbers without space. "
                                            required="required"></asp:TextBox>

                                        <i class="fa fa-user text-logn form-control-feedback"></i>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <label class="control-label" for="passWord">Password</label>
                                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"
                                            pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$"
                                            title="Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"
                                            required="required" CssClass="form-control"></asp:TextBox>


                                        <i class="fa fa-key text-logn form-control-feedback"></i>

                                        <asp:Label ID="lblMsg" runat="server" ForeColor="Maroon" Font-Bold="True"></asp:Label>
                                    </div>
                                    <asp:Button ID="loginbtn" runat="server" Text="Submit" OnClick="loginbtn_Click" ValidationGroup="l" CssClass="btn btn-login btn-lg btn-block" Style="color: #fff;"></asp:Button>



                                    <div class="col-md-12">
                                        <div>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword"
                                                ErrorMessage="PLEASE ENTER PASSWORD!" ValidationGroup="l" ForeColor="#C00000"
                                                Width="177px" Display="None">PLEASE ENTER PASSWORD!</asp:RequiredFieldValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtId"
                                                ErrorMessage="PLEASE ENTER USER NAME!" ValidationGroup="l" ForeColor="#C00000"
                                                Width="178px" Display="None">PLEASE ENTER USER NAME!</asp:RequiredFieldValidator>
                                        </div>
                                        <div>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtId"
                                                ErrorMessage="ONLY ALPHA NUMERIC VALUE WITHOUT SPACE IS ALLOWED IN  USER NAME!"
                                                ValidationExpression="^[A-Za-z0-9]*" Display="None" ValidationGroup="l"></asp:RegularExpressionValidator><asp:RegularExpressionValidator
                                                    ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPassword"
                                                    ErrorMessage="Password must contain: Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"
                                                    ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$" Display="None" ValidationGroup="l"></asp:RegularExpressionValidator>
                                        </div>
                                        <div>
                                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                                ShowSummary="False" ValidationGroup="l" />
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-push-4 col-md-4 col-sm-push-3 col-sm-6 col-sx-12">
                    <h5 style="text-align: center; font-size: small; line-height: 23px; color: #fff;">
                        <span class="size">Your current IP address (</span>
                        <asp:Label ID="Label1" class="size" runat="server" ForeColor="#ffffff"></asp:Label>
                        <span class="size">) is being registered
                            <br />
                            <span>*</span>This information is provided in a secure environment and to help protect
                        against fraud. </span>
                    </h5>
                </div>
            </div>
        </div>
        <!-- Container Fluid ends -->
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <%--<script type="text/javascript">
    (function ($) {
        // constants
        var SHOW_CLASS = 'show',
		HIDE_CLASS = 'hide',
		ACTIVE_CLASS = 'active';

        $('a').on('click', function (e) {
            e.preventDefault();
            var a = $(this),
		href = a.attr('href');

            $('.active').removeClass(ACTIVE_CLASS);
            a.addClass(ACTIVE_CLASS);

            $('.show')
		.removeClass(SHOW_CLASS)
		.addClass(HIDE_CLASS)
		.hide();

            $(href)
		.removeClass(HIDE_CLASS)
		.addClass(SHOW_CLASS)
		.hide()
		.fadeIn(550);
        });
    })(jQuery);
</script>--%>
    </form>
</body>
</html>
