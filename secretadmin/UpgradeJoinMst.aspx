<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="UpgradeJoinMst.aspx.cs" Inherits="admin_UpgradeJoinMst" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <center>
    <div>
       <br />
       <br />
       <br />
       <table style="width: 458px; border-right: #2881a2 1px solid; border-top: #2881a2 1px solid; border-left: #2881a2 1px solid; border-bottom: #2881a2 1px solid;" cellspacing="0">
           <tr>
               <td colspan="2" style="background-color: #2881a2">
                   <strong><span style="color: #ffffff; font-family: Arial">Upgrade Zero Pins</span></strong></td>
           </tr>
           <tr style="background-color:#edf0fd">
               <td align="right" style="width: 138px; text-align: right">
                   <span style="font-size: 10pt; font-family: Arial">
                   User ID:</span></td>
               <td style="width: 100px; text-align: left">
                   <asp:TextBox id="txtregno" runat="server" Width="193px"></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtregno"
                       Display="None" ErrorMessage="USer ID !" SetFocusOnError="True" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" ValidationGroup="uv"></asp:RequiredFieldValidator>
                   <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtregno"
                       Display="none" ErrorMessage="Invalid User ID!" Font-Names="Arial" Font-Size="10pt"
                       ForeColor="#C00000" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9]*"
                       ValidationGroup="uv"></asp:RegularExpressionValidator></td>
           </tr>
           <tr>
               <td align="right" style="width: 138px; text-align: right">
                   <span style="font-size: 10pt; font-family: Arial">
                   Join For:</span></td>
               <td style="width: 100px; text-align: left">
                   <asp:DropDownList ID="ddlJoinFor" runat="server" Width="299px">
                   </asp:DropDownList>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlJoinFor"
                       Display="None" ErrorMessage="JoinFor" SetFocusOnError="True" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" ValidationGroup="uv"></asp:RequiredFieldValidator>
               </td>
           </tr>
           <tr>
               <td colspan="2">
                   <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#C00000"></asp:Label></td>
           </tr>
           <tr style="background-color:#edf0fd">
               <td colspan="2">
                   <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" ShowMessageBox="True" ShowSummary="False" ValidationGroup="uv" />
                   <asp:Button id="Button1" onclick="Button1_Click" runat="server" Text="Submit" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" ValidationGroup="uv" BackColor="#2881A2"></asp:Button></td>
           </tr>
       </table>
       <br />
       <br />
       <br />
       <br />
    
    </div>
    </center>
    </asp:Content>