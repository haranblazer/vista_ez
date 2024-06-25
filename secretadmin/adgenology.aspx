<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="adgenology.aspx.cs" Inherits="admin_adgenology" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Genology</h4>					
				</div>
   
    
  

    <asp:Panel ID="Panel1" runat="server" DefaultButton="Button1">

    
              <div class="form-group">
              <label for="MainContent_myForm_txtCcode" class="col-sm-3 control-label">
   Please enter user name/id no. 
             </label>
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
     <asp:RadioButton ID="RadioButton1" runat="server" Checked="True" GroupName="p" ValidationGroup="p"
                    TabIndex="1" CssClass="radios" />
                <span><span>Id No<span>.</span></span></span>
                <asp:RadioButton ID="RadioButton2" runat="server" GroupName="p" ValidationGroup="p"
                    TabIndex="2" CssClass="radios" />
                <span>User Name </span>
                <asp:TextBox ID="txtRegNo" runat="server" CssClass="form-control" TabIndex="3"></asp:TextBox>
             </label>        
           
            <div class="clearfix"></div>
                     
            
             <div class="col-sm-2">
            <asp:Button ID="Button1"  ValidationGroup="s" runat="server" OnClick="Button1_Click" Text="Submit" CssClass="btn btn-primary" TabIndex="4"
                    Font-Bold="True"/>
            </div>
            </div>


  <table style="width: 100%;">       
       
        <tr>
            <td style="text-align: right">
                &nbsp;</td>
            <td>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRegNo"
                    Display="None" ErrorMessage="Please enter user id !" Font-Names="Arial" Font-Size="10pt"
                    ForeColor="#C00000" ValidationGroup="s"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                        ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtRegNo"
                        ErrorMessage="Only aplha numeric value is allowed !" ValidationExpression="^[A-Za-z0-9]*"
                        Display="None" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" 
                    ValidationGroup="s"></asp:RegularExpressionValidator><asp:ValidationSummary 
                    ID="ValidationSummary1" runat="server" ValidationGroup="s" ShowMessageBox="true" ShowSummary="false" />&nbsp;</td>
        </tr>
    </table>
    </asp:Panel> 

  
</asp:Content>
