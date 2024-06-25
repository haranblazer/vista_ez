<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="SendMessageAdmin.aspx.cs" Inherits="admin_SendMessageAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
      <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Compose Message</h4>					
				</div>
       

  
    <div class="clearfix"> </div> 
    <div class="col-md-12" runat="server" id="search"> 
    <asp:LinkButton class="subhead" ID="LinkButton1" runat="server" PostBackUrl="~/secretadmin/Messages.aspx" style="color:#0a7311"> <i class="fa fa-envelope-open-o" aria-hidden="true"></i> Inbox</asp:LinkButton>
    </div>

    <div class="clearfix"> </div> <br />

<div class="form-group row"> 

<div class="col-md-3 "> <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" onchange="return CallVal(this);" placeholder="User Id"></asp:TextBox>
    <asp:Label class="txt" ID="lblUser" runat="server" ForeColor="Black"></asp:Label> 
</div>

<div class="col-md-3">  <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Subject"></asp:TextBox>
</div>


<div class="col-md-3">  <asp:TextBox ID="txtMessage" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Message"></asp:TextBox>
</div>
  <div class="col-md-3">  <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="Button1_Click" ValidationGroup="sm" />
</div>
    </div>
<div class="clearfix"> </div> 

  <asp:HiddenField ID="Hidid" runat="server" />

 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSubject"
                    Display="None" ErrorMessage="Please enter subject !" ForeColor="#C00000" ValidationGroup="sm"
                    Font-Size="10pt" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMessage"
                    Display="None" Font-Size="10pt" ErrorMessage="Please enter message !" ForeColor="#C00000"
                    ValidationGroup="sm" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtUserId"
                    Display="None" Font-Size="10pt" ErrorMessage="Please enter DID / User Id !" ForeColor="#C00000"
                    ValidationGroup="sm" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="sm" />


</asp:Content>
