<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="PowerLegs.aspx.cs" Inherits="admin_PowerLegs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" charset="UTF-8">
        function validateAndConfirm(message) {
            var validated = Page_ClientValidate('pp');
            if (validated) {
                return confirm(message);
            }
        }
    </script>
   
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
    <h4 class="fs-20 font-w600  me-auto">Power Leg</h4>
    </div>

    <div class="row form-group">
        <label for="uid" class="col-sm-1 control-label">
            User Id:<span style="color: Red">*</span>
        </label>
        <div class="col-sm-2">
            <asp:TextBox ID="txtUserId" runat="server" placeholder="Enter User Id" CssClass="form-control"></asp:TextBox>
            <asp:Label ID="lblUsername" runat="server"></asp:Label>
            <asp:RequiredFieldValidator ID="rfvUserID" runat="server" ErrorMessage="Please Enter User Id."
                SetFocusOnError="true" ControlToValidate="txtUserId" Display="None" ValidationGroup="pp"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revUserId" runat="server" ValidationExpression="^[A-Za-z0-9]*$"
                ErrorMessage="User Id Contains AlphaNumeric Value Without Space." SetFocusOnError="true"
                ControlToValidate="txtUserId" Display="None" ValidationGroup="pp"></asp:RegularExpressionValidator>
        </div>
    
        <label for="postion" class="col-sm-1 control-label">
            Position:<span style="color: Red">*</span>
        </label>
        <div class="col-sm-2 control-label">
            <asp:RadioButtonList ID="rdobtnLeftTight" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True" Value="0">Left</asp:ListItem>
                <asp:ListItem Value="1">Right</asp:ListItem>
            </asp:RadioButtonList>
        </div>
    
        <label for="postion" class="col-sm-2 control-label">
            Left/Right Point:<span style="color: Red">*</span>
        </label>
        <div class="col-sm-2">
            <asp:TextBox ID="txtPoint" runat="server" CssClass="form-control" placeholder="Enter Left/Right Point"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLeftRightPoint" runat="server" ErrorMessage="Please Enter Left/Right Point."
                SetFocusOnError="true" ControlToValidate="txtPoint" Display="None" ValidationGroup="pp"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revLeftRightPoint" runat="server" ValidationExpression="^[0-9]*$"
                ErrorMessage="Left/Right Point Contains Numeric Value Without Space." SetFocusOnError="true"
                ControlToValidate="txtPoint" Display="None" ValidationGroup="pp"></asp:RegularExpressionValidator>
            <div class="clearfix">
            </div>
           
        </div>
        <div class="col-sm-2">

            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary " OnClick="btnsubmit_Click" OnClientClick="return validateAndConfirm('Do you really want to submit?');" />
            <asp:ValidationSummary ID="VadidationPowerLeg" runat="server" HeaderText="Correct the following errors..."
                ShowMessageBox="true" ShowSummary="false" ValidationGroup="pp" />
        </div>
    </div>
      
  
   
   
    <div class="table-responsive">
        <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-hover"
            AutoGenerateColumns="false" Width="100%">
            <Columns>
                <asp:BoundField DataField="userid" HeaderText="User Id">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="username" HeaderText="User Name">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Point" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label ID="lblPoint" Text="0" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reward Point" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label ID="lblRewardPoint" Text="0" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tour Point" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label ID="lblTourPoint" Text="0" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="doj" HeaderText="Date Of Joinning">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>
   
</asp:Content>
