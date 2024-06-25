<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="ShowInvoiceAndWelcomeletter.aspx.cs" Inherits="admin_ShowInvoiceAndWelcomeletter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">   
     <script >

         $(document).ready(function() {
         $('#<%=txtRegno.ClientID %>').autocomplete(document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(","));
         });
       
    </script>
    <div id="title" class="b2" style="padding-top:15px;">
        <h2 class="head">
            Welcome Letter / Invoice</h2> 
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <div class="clearfix"> </div> 
    <br />

    <asp:Panel ID="pnlWli" runat="server" DefaultButton="btnOk">

    <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
               Enter User Id:</label>
            <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtRegno" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            </div>
             <div class="form-group">            
            <div class="col-sm-3 col-xs-9 txt1">
            <asp:DropDownList ID="ddlDocument" runat="server" CssClass="form-control">
                    <asp:ListItem Value="1">Welcome Letter</asp:ListItem>
                     <asp:ListItem Value="2">Invoice</asp:ListItem>
                </asp:DropDownList>
            </div>
            </div>
             <div class="form-group">            
            <div class="col-sm-3 col-xs-6 btn4">
             <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" OnClientClick="aspnetForm.target='_blank';" Text="Show" 
                    CssClass="btn btn-success" ValidationGroup="s" />
                <asp:Label ID="lblMsg" runat="server" Visible="False" ForeColor="#CC3300" 
                    style="margin-bottom: 0px"></asp:Label>
            </div>
            </div>


    <table style="width: 100%">
       
        <tr>
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server"
                    ControlToValidate="txtRegno" Display="None" 
                    ErrorMessage="Only alpha numeric value is allowed!" ForeColor="#C00000"
                    ValidationExpression="^[A-Za-z0-9]*" Font-Size="10pt" ValidationGroup="s"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRegno"
                    ForeColor="#C00000" Display="None" ErrorMessage="Please enter user id!" 
                    ValidationGroup="s"></asp:RequiredFieldValidator>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                    ShowMessageBox="True" ShowSummary="False" ValidationGroup="s" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
    </table> </asp:Panel> 
<div id="divUserID" style="display: none;" runat="server">
                        </div>
   

</asp:Content>
