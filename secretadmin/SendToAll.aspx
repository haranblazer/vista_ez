<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="SendToAll.aspx.cs" Inherits="secretadmin_SendToAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function func() {
            var statusList = document.getElementById("<%=ddltype.ClientID %>");
            if ((statusList.options[statusList.selectedIndex].value == 1)) {
                document.getElementById("<%=txtsearch.ClientID %>").style.display = "block"
                document.getElementById("<%=lblid.ClientID %>").style.display = "block";
                $('#<%=lblid.ClientID %>').html('User ID');

            }
            if ((statusList.options[statusList.selectedIndex].value == 2)) {
                document.getElementById("<%=txtsearch.ClientID %>").style.display = "none";
                document.getElementById("<%=lblid.ClientID %>").style.display = "none";

            }

            if ((statusList.options[statusList.selectedIndex].value == 3)) {
                document.getElementById("<%=txtsearch.ClientID %>").style.display = "block"
                document.getElementById("<%=lblid.ClientID %>").style.display = "block";
                $('#<%=lblid.ClientID %>').html('User ID');

            }

            if ((statusList.options[statusList.selectedIndex].value == 4)) {
                document.getElementById("<%=txtsearch.ClientID %>").style.display = "block"
                document.getElementById("<%=lblid.ClientID %>").style.display = "block";
                $('#<%=lblid.ClientID %>').html('Payout No');

            }

            if ((statusList.options[statusList.selectedIndex].value == 5)) {
                document.getElementById("<%=txtsearch.ClientID %>").style.display = "block"
                document.getElementById("<%=lblid.ClientID %>").style.display = "block";
                $('#<%=lblid.ClientID %>').html('State');

            }

            if ((statusList.options[statusList.selectedIndex].value == 6)) {
                document.getElementById("<%=txtsearch.ClientID %>").style.display = "none"
                document.getElementById("<%=lblid.ClientID %>").style.display = "none";


            }

        }
    </script>
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Send SMS</h4>					
				</div>

  
     
    <div class="row">
      
            <div class="col-md-2 control-label">
                Select Type
            </div>
            <div class="col-md-2">
                <asp:DropDownList ID="ddltype" runat="server" onchange="func();" CssClass="form-control"
                    Font-Size="10pt">
                    <asp:ListItem Value="1" Selected="True">Single Member</asp:ListItem>
                    <asp:ListItem Value="2">All Members</asp:ListItem>
                    <asp:ListItem Value="3">Downline Members</asp:ListItem>
                    <asp:ListItem Value="4">Payout Members</asp:ListItem>
                    <asp:ListItem Value="5">State</asp:ListItem>
                    <asp:ListItem Value="6">Paid Members</asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <div class="col-md-1 control-label">
                <asp:Label ID="lblid" runat="server" Text="User ID"></asp:Label>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtsearch" runat="server" CssClass="form-control" placeholder="Enter User ID"></asp:TextBox>
            </div>           
         
           
            <div class="col-md-3">
                <asp:TextBox ID="txtmessage" runat="server" CssClass="form-control" TextMode="MultiLine"
                    required placeholder="Type Your Message"></asp:TextBox>

                      <label id="lblCharLeft1">
    </label>
             

    <script language="javascript" type="text/javascript">
        var maxLength = 130; // change here to change the max limit
        // write the character left message
        $(document).ready(function () {
            $("#lblCharLeft1").text(maxLength + " characters left");
        });

        // limit the characters
        $('#<%=txtmessage.ClientID %>').keyup(function () {
            var text = $(this).val();
            var textLength = text.length;
            if (textLength > maxLength) {
                $(this).val(text.substring(0, (maxLength)));
                alert("Sorry, you only " + maxLength + " characters are allowed");
            }
            else {
                $("#lblCharLeft1").text((maxLength - textLength) + " characters left.");
            }
        });
    </script>
           </div>
           
            <div class="col-md-2">
                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn-primary btn" />
            </div>
                
       
    </div>
   
  
</asp:Content>
