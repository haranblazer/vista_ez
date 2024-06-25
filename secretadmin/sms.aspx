<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="sms.aspx.cs" Inherits="tohadmin_sms" Title="Send SMS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function func() {
            var statusList = document.getElementById("<%=ddlList.ClientID %>");
            if ((statusList.options[statusList.selectedIndex].value == 1)) {
                document.getElementById("<%=trState.ClientID %>").style.display = "none";
                document.getElementById("<%=txtInput.ClientID %>").value = '';
                document.getElementById("<%=trTextInput.ClientID %>").style.display = "none";
                document.getElementById("<%=txtMultiple.ClientID %>").value = '';
                document.getElementById("<%=trTextMultiple.ClientID %>").style.display = "block";

            }
            else if ((statusList.options[statusList.selectedIndex].value == 2) || (statusList.options[statusList.selectedIndex].value == 4) || (statusList.options[statusList.selectedIndex].value == 5)) {
                document.getElementById("<%=trState.ClientID %>").style.display = "none";
                document.getElementById("<%=txtInput.ClientID %>").value = '';
                document.getElementById("<%=trTextInput.ClientID %>").style.display = "block";
                document.getElementById("<%=txtMultiple.ClientID %>").value = '';
                document.getElementById("<%=trTextMultiple.ClientID %>").style.display = "none";

            }
            else if ((statusList.options[statusList.selectedIndex].value == 3) || (statusList.options[statusList.selectedIndex].value == 7)) {
                document.getElementById("<%=trState.ClientID %>").style.display = "none";
                document.getElementById("<%=txtInput.ClientID %>").value = '';
                document.getElementById("<%=trTextInput.ClientID %>").style.display = "none";
                document.getElementById("<%=txtMultiple.ClientID %>").value = '';
                document.getElementById("<%=trTextMultiple.ClientID %>").style.display = "none";

            }
            else {   // for state
                document.getElementById("<%=trState.ClientID %>").style.display = "block";
                document.getElementById("<%=txtInput.ClientID %>").value = '';
                document.getElementById("<%=trTextInput.ClientID %>").style.display = "none";
                document.getElementById("<%=txtMultiple.ClientID %>").value = '';
                document.getElementById("<%=trTextMultiple.ClientID %>").style.display = "none";

            }


        }
    </script>
    <div style="padding:15px 0px 0px 15px;">
        <h2 class="head">
           <i class="fa fa-paper-plane" aria-hidden="true"></i>&nbsp;Send SMS</h2>
    </div>
    <div class="clearfix"> </div> <br />

    <div class="col-md-12">
    <asp:Label ID="lblSMS" runat="server" Font-Bold="true"></asp:Label> 
    </div>
    <div class="clearfix"> </div> <br />

    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-3 control-label">
            Select News Type
        </label>
        <div class="col-sm-3">
            <asp:DropDownList ID="ddlList" runat="server" Font-Names="Arial" onchange="func();" CssClass="form-control"
                Font-Size="10pt">
                <asp:ListItem Value="1" Selected="True">On Single / Multiple Mobile Number</asp:ListItem>
                <asp:ListItem Value="2">Single Member</asp:ListItem>
                <asp:ListItem Value="3">All Members</asp:ListItem>
                <asp:ListItem Value="4">Downline Members</asp:ListItem>
                <asp:ListItem Value="5">Payout Members</asp:ListItem>
                <asp:ListItem Value="6">State</asp:ListItem>
                <asp:ListItem Value="7">Paid Members</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    
    <div runat="server" id="trState">
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-3 control-label">
                State:
            </label>
            <div class="col-sm-3">
                <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control">
                    <asp:ListItem>--Select--</asp:ListItem>
                    <asp:ListItem>Andaman &amp; Nicobar</asp:ListItem>
                    <asp:ListItem>Andhra Pradesh</asp:ListItem>
                    <asp:ListItem>Arunachal Pradesh</asp:ListItem>
                    <asp:ListItem>Assam</asp:ListItem>
                    <asp:ListItem>Bihar</asp:ListItem>
                    <asp:ListItem>Chandigarh</asp:ListItem>
                    <asp:ListItem>Chattisgarh</asp:ListItem>
                    <asp:ListItem>Dadar Nagar Haweli</asp:ListItem>
                    <asp:ListItem>Daman &amp; Diu</asp:ListItem>
                    <asp:ListItem>Delhi</asp:ListItem>
                    <asp:ListItem>Goa</asp:ListItem>
                    <asp:ListItem>Gujarat</asp:ListItem>
                    <asp:ListItem>Haryana</asp:ListItem>
                    <asp:ListItem>Himanchal Pradesh</asp:ListItem>
                    <asp:ListItem>Jammu &amp; Kashmir</asp:ListItem>
                    <asp:ListItem>Jharkhand</asp:ListItem>
                    <asp:ListItem>Karnataka</asp:ListItem>
                    <asp:ListItem>Kerala</asp:ListItem>
                    <asp:ListItem>Lakshadweep</asp:ListItem>
                    <asp:ListItem>Madhya Pradesh</asp:ListItem>
                    <asp:ListItem>Maharastra</asp:ListItem>
                    <asp:ListItem>Manipur</asp:ListItem>
                    <asp:ListItem>Meghalaya</asp:ListItem>
                    <asp:ListItem>Mizoram</asp:ListItem>
                    <asp:ListItem>Nagaland</asp:ListItem>
                    <asp:ListItem>Orissa</asp:ListItem>
                    <asp:ListItem>Pondicherry</asp:ListItem>
                    <asp:ListItem>Punjab</asp:ListItem>
                    <asp:ListItem>Rajasthan</asp:ListItem>
                    <asp:ListItem>Sikkim</asp:ListItem>
                    <asp:ListItem>Tamilnadu</asp:ListItem>
                    <asp:ListItem>Tripura</asp:ListItem>
                    <asp:ListItem>Uttar Pradesh</asp:ListItem>
                    <asp:ListItem>Uttaranchal</asp:ListItem>
                    <asp:ListItem>West Bengal</asp:ListItem>
                    <asp:ListItem>Bangladesh</asp:ListItem>
                    <asp:ListItem>Nepal</asp:ListItem>
                    <asp:ListItem>Bhutan</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <div runat="server" id="trTextInput">
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-3 control-label">
                User Name/Payout Number :
            </label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtInput" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:Label ID="lblInput" CssClass="form-control" runat="server"></asp:Label>
            </div>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
     <div runat="server" id="trTextMultiple">
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-3 control-label">
            On Single/Multiple Mobile Numbers:<br />
                    (Note:Write multiple numbers separated by comma)
        </label>
        <div class="col-sm-3">
        <asp:TextBox ID="txtMultiple" runat="server" TextMode="MultiLine" Height="76px" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
   
        
    </div>
      <div class="clearfix">
    </div>
    <br />
     <div runat="server" id="Div1">
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-3 control-label">
          Type Your Message Here:
        </label>
        <div class="col-sm-3">
        <%--<asp:TextBox ID="txtMessage" runat="server" BackColor="White" Height="205px" TextMode="MultiLine"
                                CssClass="form-control"></asp:TextBox>--%>

 <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Columns="50" Rows="5"  CssClass="form-control" ClientIDMode="Static"/>

                      <label id="lblCharLeft">
    </label>
             

    <script language="javascript" type="text/javascript">
        var maxLength = 120; // change here to change the max limit
        // write the character left message
        $(document).ready(function () {
            $("#lblCharLeft").text(maxLength + " characters left");
        });

        // limit the characters
        $('#<%=txtMessage.ClientID %>').keyup(function () {
            var text = $(this).val();
            var textLength = text.length;
            if (textLength > maxLength) {
                $(this).val(text.substring(0, (maxLength)));
                alert("Sorry, you only " + maxLength + " characters are allowed");
            }
            else {
                $("#lblCharLeft").text((maxLength - textLength) + " characters left.");
            }
        });
    </script>


        </div>
        <div class="col-sm-12">
         <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="True" Font-Names="Arial"
                                Font-Size="10pt"></asp:Label>
                                </div>
        </div>

        </div>
          <div class="clearfix">
    </div>
    <br />
        <div class="form-group">
       <div class="col-sm-3"></div>
        <div class="col-sm-2">
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Send SMS"
                                CssClass="btn btn-success" ValidationGroup="s" />
        </div>
        </div>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtInput"
        Display="None" ErrorMessage="Only Alpha Numeric Value Is Allowed!" ValidationExpression="^[a-zA-Z0-9]*"
        ValidationGroup="s"></asp:RegularExpressionValidator>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="s" />
</asp:Content>
