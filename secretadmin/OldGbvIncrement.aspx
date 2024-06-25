<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="OldGbvIncrement.aspx.cs" Inherits="User_OldGbvIncrement" %>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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

      function onlyNos(e, t) {
          try {
              if (window.event) {
                  var charCode = window.event.keyCode;
              }
              else if (e) {
                  var charCode = e.which;
              }
              else { return true; }
              if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                  return false;
              }
              return true;
          }
          catch (err) {
              alert(err.Description);
          }
      }
    </script>

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Team Business Updation</h4>					
				</div>
  
                <div class="row">
                 
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="User Id" onchange="return CallVal(this);" CausesValidation="True" AutoPostBack="true"></asp:TextBox>
                        <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId"
  Display="None" ErrorMessage="User ID require." SetFocusOnError="True" ValidationGroup="t">
                                        </asp:RequiredFieldValidator>
                       
                    </div>
               
                  
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtGbvAdd" runat="server" CssClass="form-control" placeholder="Add Value" AutoPostBack="true" onkeypress="return onlyNos(event,this);"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtGbvAdd"
                                        Display="None" ErrorMessage="Value Required" SetFocusOnError="True" ValidationGroup="t">
                                        </asp:RequiredFieldValidator>

                                   <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtGbvAdd"
                                        ErrorMessage="Invalid Value" SetFocusOnError="True" ValidationExpression="^[0-9]*$"
                                        ValidationGroup="t" Display="None"></asp:RegularExpressionValidator>--%>
                                 <%--   <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtGbvAdd"
                                        ErrorMessage="Points limit is 1-900000." MaximumValue="900000"
                                        MinimumValue="1" Type="Double" ValidationGroup="t"></asp:RangeValidator>--%>
                       
                    </div>
              
                    <div class="col-sm-1 control-label">
                        </div>
                    <div class="col-sm-2">
                        <asp:Button ID="btSubmit" runat="server" CssClass="btn btn-primary" 
                            onclick="btSubmit_Click" Text="Submit"></asp:Button>
                       
                    </div>
             
        </div>
         
</asp:Content>
