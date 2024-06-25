<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Zero_ID_Paid.aspx.cs" Inherits="secretadmin_Zero_ID_Paid" %>

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
    </script>

     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
    <h4 class="fs-20 font-w600  me-auto">Zero Id Paid</h4>
    </div>

   
            <div class="row form-group">
               
                <div class="col-md-2">
                    <asp:TextBox ID="txtsearch" runat="server" MaxLength="10" ValidationGroup="g" CssClass="form-control" required placeholder="Enter User ID"
                        onchange="return CallVal(this);" CausesValidation="True"></asp:TextBox>
                    <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="None" ControlToValidate="txtsearch"
                        ErrorMessage="Enter User Id.!" ForeColor="#C00000"
                        ToolTip="g" ValidationGroup="g">Please Enter User ID!</asp:RequiredFieldValidator>
                </div>
                 <div class="col-md-2">
                    <asp:DropDownList ID="ddl_Joinfor" runat="server" CssClass="form-control" >
                        <asp:ListItem Value="0">Select Join Type</asp:ListItem>
                        <asp:ListItem Value="0.5">T2500 (0.5)</asp:ListItem>
                        <asp:ListItem Value="1">T5000 (1)</asp:ListItem>
                        <asp:ListItem Value="2">T10000 (2)</asp:ListItem>
                    </asp:DropDownList>
                </div>
                 <div class="col-md-2 control-label">
                    <asp:CheckBox ID="chk_IsPaid" runat="server" Text="&nbsp;User Paid" />
                </div>

                <div class="col-md-4">
                    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click1" CssClass="btn btn-primary" />
                </div>

            </div>
            
</asp:Content>

