<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="GenerateFund.aspx.cs" MasterPageFile="MasterPage.master" Inherits="secretadmin_GenerateFund" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        #tooltip {
            position: absolute;
            border: 2px solid red;
            background-color: #FFFFE1;
            padding: 2px 5px;
            text-align: left;
            font-family: arial;
            font-size: 12px;
            color: #000000;
            display: none;
            width: auto;
            height: auto;
        }
    </style>
    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">F-Wallet/ C-Wallet/ R-Wallet Generation</h4>					
				</div>


   
    
            <div class="row">
                <div class="col-md-2 control-label">
                    Current Balance
                </div>
                <div class="col-md-2">
                    <asp:Label ID="lblfund" CssClass="form-control" runat="server" Font-Bold="True" Font-Size="Larger"></asp:Label>
                </div>
          
                <div class="col-md-2 control-label">
                    Choose Wallet Name:
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" CausesValidation="True"
                        CssClass="form-control" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                        <asp:ListItem Value="1">F-Wallet</asp:ListItem>
                        <asp:ListItem Value="2">C-Wallet</asp:ListItem>
                        <asp:ListItem Value="3">Redemption Wallet</asp:ListItem>
			<asp:ListItem Value="4">OD Wallet</asp:ListItem>
                    </asp:DropDownList>
                </div>
        
              
                <div class="col-md-2">
                    <asp:TextBox ID="txtfund" runat="server" CssClass="form-control" CausesValidation="True" placeholder="Amount"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtfund"
                        Display="None" ErrorMessage="Amount Required" SetFocusOnError="True" ValidationGroup="t">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtfund"
                        ErrorMessage="Invalid Amount" SetFocusOnError="True" ValidationExpression="^[0-9]*$"
                        ValidationGroup="t" Display="None"></asp:RegularExpressionValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtfund"
                        Display="None" ErrorMessage="Amount limit is 1-9000000." MaximumValue="9000000"
                        MinimumValue="1" SetFocusOnError="True" Type="Double" ValidationGroup="t"></asp:RangeValidator>
                </div>
       
               
                <div class="col-md-1">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-primary" OnClick="btnSubmit_Click"
                        ValidationGroup="t" />
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="t" />
                </div>
            </div>
           
        
</asp:Content>
