<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="ExpressSignUp.aspx.cs" Inherits="secretadmin_ExpressSignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <%--    <script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="secretadmin/datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="secretadmin/datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="secretadmin/datepick/jquery.datepick.js" type="text/javascript"></script>--%>
    <%--    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />

    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>--%>
    <style type="text/css">
        legend.legendStyle
        {
            padding-left: 5px;
            padding-right: 5px;
        }
        
        fieldset.fsStyle
        {
            font-family: Verdana, Arial, sans-serif;
            font-size: small;
            font-weight: normal;
            border: 1px solid #999999;
            padding: 4px;
            margin: 5px;
            border-radius: 6px;
        }
        legend.legendStyle
        {
            font-size: 15px;
            color: #333;
            background-color: transparent;
            font-weight: bold;
        }
        legend
        {
            width: auto;
            border-bottom: 0px;
        }
    </style>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        
        
        
        @media only screen and (max-width: 480px)
        {
            legend.legendStyle
            {
                font-size: 12px;
            }
            .txt2
            {
                font-size: 9px;
            }
            btn2
            {
                font-size: 8px;
                padding: 0px;
            }
        }
    </style>
    <script language="javascript" type="text/javascript">
        function CallVal(txt) {
            ServerSendValue(txt.value, "ctx");
        }
        function ServerResult(arg) {

            if (arg == "You cannot leave blank field here !") {
                document.getElementById("lblUser.ClientID").style.color = "Red";
                document.getElementById("lblUser.ClientID").innerHTML = arg;
            }
            else {
                document.getElementById("<%=lblUser.ClientID%>").style.color = "darkblue";
                document.getElementById("<%=lblUser.ClientID%>").innerHTML = arg;
            }
        }
        function ClientErrorCallback() {
        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <style type="text/css">
        legend.legendStyle
        {
            padding-left: 5px;
            padding-right: 5px;
        }
        fieldset.fsStyle
        {
            font-family: Verdana, Arial, sans-serif;
            font-size: small;
            font-weight: normal;
            border: 1px solid #999999;
            padding: 4px;
            margin: 5px;
            border-radius: 6px;
        }
        legend.legendStyle
        {
            font-size: 90%;
            color: #888888;
            background-color: transparent;
            font-weight: bold;
        }
        legend
        {
            width: auto;
            border-bottom: 0px;
        }
    </style>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        .modalPopup
        {
            min-height: 75px;
            position: absolute;
            z-index: 2000;
            -moz-opacity: .15;
            padding: 0;
            background-color: #fff;
            border-radius: 6px;
            background-clip: padding-box;
            border: 1px solid rgba(0, 0, 0, 0.2);
            min-width: 290px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0);
            width: 100%;
        }
        .modalBackground
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: #000;
            opacity: 0.5;
            z-index: 1800;
            min-height: 100%;
            width: 100%;
            overflow: hidden;
            filter: alpha(opacity=50);
            display: inline-block;
            z-index: 1000;
        }
        
        .b2 h1
        {
            font-size: 30px;
            padding: 0px 0px 10px 0px;
        }
        .panel-default > .panel-heading
        {
            background: linear-gradient(#F4DF82 , #D1A457);
            border: none;
            color: #000;
            font-weight: bold;
        }
    </style>
    <br />
    <div class="container">
        <h2 class="head" style="margin-top: 0px;">
            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>Express Signup Form
        </h2>
    </div>
    <div class="container-fluid" style="background: #333;" id="Popup" visible="false"
        runat="server">
        <div class="col-md-3">
        </div>
        <div class="col-md-6" style="padding-top: 40px; padding-bottom: 30px;">
            <asp:Panel ID="PanelPopup" runat="server" Width="100%" Style="background: linear-gradient(#F4DF82 , #D1A457);
                color: black; border-radius: 6px; padding: 20px 15px;" CssClass="moda lPopup">
                <fieldset class="fsStyle">
                    <legend class="legendStyle"><i class="fa fa-address-book" aria-hidden="true"></i>Sponsor
                        Details </legend>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtCcode" class=" txt2 col-sm-3 col-xs-6 control-label">
                            Sponsor Id:</label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblSponsorID" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtCcode" class=" txt2 col-sm-3 col-xs-6 control-label">
                            Sponsor Name:</label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblSponsorName" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </fieldset>
                <div class="clearfix">
                </div>
                <fieldset class="fsStyle">
                    <legend class="legendStyle">Personal Details </legend>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtPname" class=" txt2 col-sm-3 col-xs-6 control-label">
                            Position:
                        </label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblPosition" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtPcode" class=" txt2 col-sm-3 col-xs-6 control-label">
                            Name:
                        </label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblName" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <%--<div class="form-group">
                        <label for="MainContent_myForm_txtPname" class=" txt2 col-sm-3 col-xs-6 control-label">
                            DOB:
                        </label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblDateofBirth" runat="server" Text=""></asp:Label>
                        </div>
                    </div>--%>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtPname" class=" txt2 col-sm-3 col-xs-6 control-label">
                            Mobile Number:</label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblMobile" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <%--<div class="form-group">
                        <label for="MainContent_myForm_txtPname" class=" txt2 col-sm-3 col-xs-6 control-label">
                            E-Mail Id:</label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblEmail" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtPname" id="Label1" runat="server" class=" txt2 col-sm-3 col-xs-6 control-label">
                            Pan No:</label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblPAN" runat="server" Text=""></asp:Label>
                            <div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <div class="clearfix">
                </div>
                <fieldset class="fsStyle">
                    <legend class="legendStyle">Security Details </legend>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtCcode" class=" txt2 col-sm-3 control-label">
                            <span style="color: Red"></span>Password:</label>
                        <div class="col-sm-4 col-xs-6">
                            <asp:Label class="txt2" ID="lblPassword" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </fieldset>
                <div class="clearfix">
                </div>
                <fieldset class="fsStyle">
                    <legend class="legendStyle" style="display: none">OTP Details</legend>
                    <div class="form-group" style="display: none">
                        <div class="col-sm-3">
                            <span class="txt2">Enter OTP </span>
                        </div>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtotp" runat="server" CssClass="form-control" Style="clear: both;"></asp:TextBox>
                           <asp:RequiredFieldValidator class="txt2" ID="reqotp" runat="server" ControlToValidate="txtotp"
                                ErrorMessage="Please Enter OTP" ValidationGroup="NJ" Style="position: relative"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-sm-4">
                            <asp:LinkButton class="txt2" ID="lnkotp" runat="server" Text="Resend OTP"></asp:LinkButton>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>--%>
                    <div class="form-group">
                        <div class="col-sm-3">
                        </div>
                        <div class="col-sm-6 ">
                            <asp:Button ID="btnConfirm" runat="server" CausesValidation="true" CssClass=" btn2 btn btn-success"
                                OnClick="btnConfirm_Click" Text="Confirm" ValidationGroup="NJ" />
                            &nbsp;
                            <asp:Button ID="btnEdit" runat="server" CausesValidation="true" CssClass=" btn2 btn btn-success"
                                OnClick="btnEdit_Click" Text="Cancel" />
                        </div>
                    </div>
                </fieldset>
            </asp:Panel>
        </div>
    </div>
    <div class="bodytext" id="regForm" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <%--<div id="title" class="b2">
                        <h1 class="head" style="color: #fff; font-size:30px; padding-top:5px;">
                          &nbsp; <i class="fa fa-pencil-square-o" aria-hidden="true"></i>  Registration Form
                        </h1>
                    </div>
                    <div class="clearfix">
                    </div>--%>
                    <div class="joing_inter">
                        <asp:Panel ID="DivNewjoin" DefaultButton="btnSubmit" runat="server">
                            <div id="MainContent_myForm_UpdatePanel1">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <section id="loginForm_1">

          <div class="form-horizontal">
                        <div class="panel panel-default">
                                <%--<div class="panel-heading"> <i class="fa fa-address-book" aria-hidden="true"></i> Sponsor Details (Step -1)</div>--%> 

                               
                                <div class="panel-body">
                                

                                <div class="col-md-6" style="padding:15px 0px 0px 0px; margin:0px;"> 

<div class="form-group">
    <div class="col-md-3 col-xs-3">
        <label for="MainContent_myForm_txtPname" class="txt col-sm-3 col-xs-3 control-label" style="text-align:left" >Sponsor Id<span style="color:Red">*</span></label>

   </div>
   <div class="col-md-7 col-xs-9">
    <asp:TextBox ID="TxtSponsorId" runat="server" placeholder="Sponsor Id" MaxLength="30" CssClass="form-control" required
                                onchange="return CallVal(this);" CausesValidation="True" ValidationGroup="NJ"></asp:TextBox>
                            <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtSponsorId"
                                Display="None" ErrorMessage="Please Enter Sponsor ID!" Font-Bold="False" ForeColor="#C00000" SetFocusOnError="true"
                                ToolTip="NJ" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator19" runat="server" SetFocusOnError="true"
                                ControlToValidate="TxtSponsorId" Display="None" ErrorMessage="Sponsor Id Contains Alphanumeric Value Without Space."
                                Font-Bold="False" ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[a-zA-Z0-9]{1,50}$"
                                ValidationGroup="NJ" Width="398px"></asp:RegularExpressionValidator>
 




   </div>
   </div>
   
 
</div>




  

    <div class="col-md-6" style="padding:10px 0px 0px 0px; margin:0px;"> 

<div class="form-group">
    <div class="col-md-3 col-xs-3">

        <label for="MainContent_myForm_txtPname" class="txt col-sm-3 col-xs-3 control-label" style="text-align:left">Position<span style="color:Red">*</span></label>

  
   </div>
   <div class="col-md-7 col-xs-9">
     <asp:DropDownList ID="ddlposition"  runat="server"  CssClass="form-control">
         <asp:ListItem Value="0">Left</asp:ListItem>
        <asp:ListItem Value="1">Right</asp:ListItem>                              
     </asp:DropDownList>
   </div>
   </div>

   </div>


   </div>

</div>
</div>





                                                                
                                    

                        <div class="form-horizontal">
                        <div class="panel panel-default">
                               <%-- <div class="panel-heading txt">
                                <i class="fa fa-user-circle" aria-hidden="true"></i> Personal Details (Step -2)</div>--%>
                                <div class="panel-body">

                                <div class="row">
<div class="col-md-6" style="padding: 15px 0px 0px 0px; margin:0px;"> 



<div class="form-group">
                                <div class="col-md-3 col-xs-3">
<label for="MainContent_myForm_txtPname" class="txt col-sm-3 col-xs-3 control-label" style="text-align:left">Name:<span style="color:Red">*</span></label>
                                  
                                </div>
                               
                           
                                
                                <div class="col-md-2 col-xs-4 " style="padding-right:0px;">
                        
                                   <asp:DropDownList ID="ddlTitle" runat="server"    CausesValidation="True"
                                CssClass="form-control" MaxLength="30" ValidationGroup="NJ" >
                                <asp:ListItem>Mr.</asp:ListItem>
                                <asp:ListItem>Ms.</asp:ListItem>
                                <asp:ListItem>Mrs.</asp:ListItem>
                                <asp:ListItem>M/S.</asp:ListItem>
                                <asp:ListItem>Dr.</asp:ListItem>
                                <asp:ListItem>Md.</asp:ListItem>
                            </asp:DropDownList>
                                </div>
                                <div class="col-md-5 col-xs-5" style="padding-left: 0px;">
                                        <asp:TextBox ID="TxtName" runat="server" CausesValidation="True"  CssClass="form-control" MaxLength="50" ValidationGroup="NJ"></asp:TextBox> 
                                          <asp:RequiredFieldValidator ID="fnamExp" runat="server" ControlToValidate="TxtName"
                                Display="None" ErrorMessage="Please Enter Applicant Name!" Font-Bold="False"
                                ForeColor="#C00000" ToolTip="NJ" ValidationGroup="NJ" SetFocusOnError="true">
                                    </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtName"
                                Display="None" ErrorMessage="Applicant Name Contains Alphabetic Value!"
                                Font-Bold="False" ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[A-Za-z. ]{1,50}$"
                                ValidationGroup="NJ" SetFocusOnError="true"></asp:RegularExpressionValidator>       
                                </div>
                                
                             
                                
                            </div>








   </div>

   <div class="col-md-6" style="padding:15px 0px 0px 0px; margin:0px;"> 

<div class="form-group">
    <div class="col-md-3 col-xs-3">
                                        <label for="MainContent_myForm_txtPname" class="txt col-sm-3 col-xs-3 control-label" style="text-align:left">
                                        Mobile:<span style="color:Red">*</span></label>

   </div>
   <div class="col-md-7 col-xs-9">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                          <asp:TextBox ID="TxtMobile" runat="server" CausesValidation="True" CssClass="form-control"
                                MaxLength="10"  
                                               ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvMobileNo" runat="server" ControlToValidate="TxtMobile"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Mobile No!"
                                    ToolTip="NJ" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revMobileNo" runat="server" ControlToValidate="TxtMobile"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter 10 Digits Valid Mobile No."
                                    ToolTip="NJ" ValidationExpression="^[789][0-9]{9}$" ValidationGroup="NJ"></asp:RegularExpressionValidator>
                                <asp:Label ID="lblMob" runat="server" Text=""></asp:Label>
                                </ContentTemplate>
                        </asp:UpdatePanel>
                                
   </div>
   </div>
   </div>

   </div>
   </div>

 
   <div class="clearfix"></div>

 
</div>


                                   
                                                           
   
                            
                            <div class="panel panel-default">
                               <%-- <div class="panel-heading txt"> <i class="fa fa-lock" aria-hidden="true"></i> Security Details (Step -5)</div>--%>
                                <div class="panel-body">
                                   
                                  




<div class="col-md-6" style="padding:15px 0px 0px 0px; margin:0px;"> 

<div class="form-group" runat="server" id="div5">
    <div class="col-md-3 col-xs-3">
    <label for="MainContent_myForm_txtPname" class="txt col-sm-3 col-xs-3 control-label" style="text-align:left">Set UserName:<span style="color:Red">*</span></label>


   </div>
   <div class="col-md-7 col-xs-9">
    <asp:TextBox ID="txtUserName"  runat="server" CssClass="form-control"
                                          ></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="requn" runat="server" ControlToValidate="txtUserName" SetFocusOnError="true"
                                      ErrorMessage="Please Enter Username!" ValidationGroup="NJ" Style="position: relative"></asp:RequiredFieldValidator>  
                                       <asp:RegularExpressionValidator ID="revUserName" runat="server" SetFocusOnError="true"
                                ControlToValidate="txtUserName" Display="None" ErrorMessage="User Name Required minimum 5 Alphanumeric characters without space."
                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[0-9a-zA-Z]{5,}$" ValidationGroup="NJ"></asp:RegularExpressionValidator>
                               
        
   </div>
   </div>
  

 
</div>


                                    <div class="col-md-6" style="padding:15px 0px 0px 0px; margin:0px;"> 

<div class="form-group" runat="server" id="div3">
    <div class="col-md-3 col-xs-3">
     <label for="MainContent_myForm_txtPname" class="txt col-sm-3 col-xs-3 control-label" style="text-align:left">Set Password:<span style="color:Red">*</span></label>


   </div>
   <div class="col-md-7 col-xs-9">
       <asp:TextBox ID="TxtPassword" runat="server" CausesValidation="True" CssClass="form-control"
                                MaxLength="15" TextMode="Password" ValidationGroup="NJ"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TxtPassword" SetFocusOnError="true"
                                Display="None" ErrorMessage="Please Enter Password." ForeColor="#C00000" Style="left: 0px"
                                ToolTip="NJ" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator21" runat="server" SetFocusOnError="true"
                                ControlToValidate="TxtPassword" Display="None" ErrorMessage="Password must be mix of 6 alphnumeric character."
                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[0-9a-zA-Z]{6,15}$" ValidationGroup="NJ"></asp:RegularExpressionValidator>
   </div>
   </div>
  

 
</div>

                                      <div class="clearfix"> </div>

                                      <div class="form-group">
                                      <div class="col-sm-1 col-xs-3"> </div>
                                      <div class="col-sm-4 col-xs-4 text-right">  
                                     <asp:Button ID="btnSubmit" runat="server" CausesValidation="true" CssClass="btn btn-default" 
                                OnClick="btnSubmit_Click" Text="Submit" ValidationGroup="NJ" />
                                 <asp:Label ID="LblMsg" runat="server" ForeColor="Red"></asp:Label>
                                      </div>
                                       </div>
                                    
                                   
                                </div>
                            </div>                                                                 

</div>
</section>
                                    </div>
                                </div>
                            </div>
                            <table style="width: 100%" class="tableehegth">
                                <tr>
                                    <td>
                                    </td>
                                    <td style="width: 37%">
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                            ShowSummary="False" ValidationGroup="NJ" HeaderText="Please check the following..." />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <div class="clear">
                        </div>
                        <br />
                    </div>
                    <div class="baner_joing" style="display: none;">
                        <img src="images/joiningbg.gif" style="border: solid 3px #dddddd; margin-left: 20px;" />
                        <div class="ip_addres">
                            <h5 style="text-align: center">
                                <p>
                                    <span style="color: #000000">Your current IP address our current IP address
                                        <br />
                                        {<asp:Label ID="lblIP" runat="server" ForeColor="#C00000"></asp:Label>}<br />
                                        <span style="color: #000000">is being registered<br />
                                            <span style="color: #990000">*</span>This information is provided in a secure environment
                                            and to help&nbsp; protect against fraud. </span>
                                </p>
                            </h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </span>
</asp:Content>
