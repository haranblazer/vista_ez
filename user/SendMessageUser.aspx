<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="SendMessageUser.aspx.cs" Inherits="user_SendMessageUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Compose Message</h4>					
				</div>

  
          
          
                    <div class="row">
                        <div class="col-md-2">
                            <span style="color: red">*</span> Subject :
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtSubject" runat="server" class="form-control col-sm-4"></asp:TextBox>
                        </div>
                   
                    <br />
                    <div class="clearfix"></div>
                        <div class="col-md-2">
                            <span style="color: red">*</span> Message :
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtMessage" TextMode="MultiLine" runat="server" class="form-control col-sm-4"
                                Columns="30" Height="150px" Rows="5"></asp:TextBox>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-2">
                        </div>
                        <div class="col-md-3">
                            <asp:HiddenField ID="Hidid" runat="server" />
                            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary"
                                OnClick="Button1_Click" ValidationGroup="sm" /><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSubject"
                                Display="None" ErrorMessage="Please enter subject !" ForeColor="#C00000" ValidationGroup="sm"
                                Font-Size="10pt" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMessage"
                                Display="None" Font-Size="10pt" ErrorMessage="Please enter Message !" ForeColor="#C00000"
                                ValidationGroup="sm" SetFocusOnError="True">Please Enter Message !</asp:RequiredFieldValidator>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                HeaderText="Please check the following..." ShowSummary="False" ValidationGroup="sm" />
                        </div>
                         <div class="col-md-3 control-label" runat="server" id="search" style="font-size: 10pt">
                    
                        <ul>
                            <li style="list-style: none">
                                <asp:LinkButton ID="LinkButton1" Font-Bold="true" runat="server"                                     PostBackUrl="~/user/Messages.aspx" CssClass=""> <i class="fa fa-envelope-o" aria-hidden="true"></i> Inbox</asp:LinkButton></li>
                        </ul>
                   
                </div>
                    </div>
               
          
      
    <div class="clearfix">
    </div>
    <br />
</asp:Content>
