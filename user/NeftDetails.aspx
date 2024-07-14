<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="NeftDetails.aspx.cs" Inherits="user_NeftDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#">My Information</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Bank Details</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Bank Details</h1>
                            </div>
                              <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div>
                   
                    <div class="container-fluid page__container">
            
        <div class="panel card card-body">
           
            <div class="panel-body card-group-row row">
                <asp:Label ID="lblMessage" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>
               
                <div class="col-md-6 " style="padding: 15px 0px 0px 0px; margin: 0px;">
                    <div class="form-group card-group-row">
                        <div class="col-md-3 col-xs-3">
                            <label for="MainContent_myForm_txtPname" class="txt control-label"
                                style="text-align: left">
                                Name:<span style="color: Red"></span></label>
                        </div>
                        <div class="col-md-7 col-xs-9">
                            <asp:TextBox ID="txtname" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                  
                </div>
                           
                <div class="col-md-6 " style="padding: 15px 0px 0px 0px; margin: 0px;">
                    <div class="form-group card-group-row">
                        <div class="col-md-3 col-xs-3">
                            <label for="MainContent_myForm_txtPname" class="txt control-label"
                                style="text-align: left">
                                Bank Name:<span style="color: Red"></span></label>
                        </div>
                        <div class="col-md-7 col-xs-9">
                            <asp:DropDownList ID="ddlBankName" runat="server" CausesValidation="True" CssClass="form-control"
                                ValidationGroup="NJ">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                   
                </div>
                <div class="col-md-6" style="padding: 15px 0px 0px 0px; margin: 0px;">
                    <div class="form-group card-group-row">
                        <div class="col-md-3 col-xs-3">
                            <label for="MainContent_myForm_txtPname" class="txt control-label"
                                style="text-align: left">
                                Branch:<span style="color: Red"></span></label>
                        </div>
                        <div class="col-md-7 col-xs-9">
                            <asp:TextBox ID="txtbranch" runat="server" CausesValidation="True" CssClass="form-control"
                                MaxLength="50" ValidationGroup="NJ"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    
                </div>
                <div class="col-md-6" style="padding: 15px 0px 0px 0px; margin: 0px;">
                    <div class="form-group card-group-row">
                        <div class="col-md-3 col-xs-3">
                            <label for="MainContent_myForm_txtPname" class="txt control-label"
                                style="text-align: left">
                                A/C No:<span style="color: Red"></span></label>
                        </div>
                        <div class="col-md-7 col-xs-9">
                            <asp:TextBox ID="txtaccountno" runat="server" ValidationGroup="NJ" CssClass="form-control"
                                MaxLength="20" CausesValidation="True"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revAcNo" runat="server" SetFocusOnError="true"
                                ErrorMessage="Account Number Contains Numeric Value!" Display="None" ValidationExpression="^#?[0-9]{1,20}$"
                                ControlToValidate="txtaccountno" ForeColor="#CC0000" ValidationGroup="NJ"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                   
                </div>
                <div class="col-md-6" style="padding: 15px 0px 0px 0px; margin: 0px;">
                    <div class="form-group card-group-row">
                        <div class="col-md-3 col-xs-3">
                            <label for="MainContent_myForm_txtPname" class="txt control-label"
                                style="text-align: left">
                                A/C Type:<span style="color: Red"></span></label>
                        </div>
                        <div class="col-md-7 col-xs-9">
                            <asp:DropDownList ID="ddlAccType" runat="server" CssClass="form-control">
                                <%--    <asp:ListItem>--Select  Account Type--</asp:ListItem>--%>
                                <asp:ListItem>SAVING A/C</asp:ListItem>
                                <asp:ListItem>CURRENT A/C</asp:ListItem>
                                <asp:ListItem>OD A/C</asp:ListItem>
                                <asp:ListItem>CC A/C</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    
                </div>
                <div class="col-md-6" style="padding: 15px 0px 0px 0px; margin: 0px;">
                    <div class="form-group card-group-row">
                        <div class="col-md-3 col-xs-3">
                            <label for="MainContent_myForm_txtPname" class="txt control-label"
                                style="text-align: left">
                                IFS Code:<span style="color: Red"></span></label>
                        </div>
                        <div class="col-md-7 col-xs-9">
                            <asp:TextBox ID="TxtIFS" runat="server" CssClass="form-control" CausesValidation="True"
                                MaxLength="20"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revIFSC" runat="server" SetFocusOnError="true"
                                ControlToValidate="TxtIFS" Display="None" ValidationGroup="NJ" ErrorMessage="IFS Code Contains AlphaNumeric Value Without Space"
                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[A-Za-z0-9]{1,20}$"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                  
                </div>
                <div class="clearfix">
                </div>
              
                <div class="col-md-12 right" style="display: block; float: right;">
                    <asp:Button ID="btnupdate" runat="server" CssClass="btn btn-success" Text="Update"
                        ValidationGroup="NJ" OnClick="btnupdate_Click" />
                    <asp:ValidationSummary ID="ValidationNEFT" runat="server" ShowMessageBox="true" ShowSummary="false"
                        HeaderText="Please check the following errors..." ValidationGroup="NJ" />
                </div>
                <asp:TextBox ID="txtpassword" runat="server" Visible="false"></asp:TextBox>
                <br />
            </div>

            <div class="clearfix"></div>
        </div>
        
        </div>
        </div>
  
</asp:Content>
