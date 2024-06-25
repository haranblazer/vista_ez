<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RoyaltyClubDisplay.aspx.cs" Inherits="Keyadmin_GoldenSalaryIncome" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Welcome Salary Income</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table align="center" style="width: 730px" cellspacing="0"  >
        <tr>
            <td style="text-align: center; height: 26px; background-color: #2881a2;">
                <strong><span style="font-family: Arial; color: #ffffff;">Royalty Club Income Qualifier's
                    List</span></strong></td>
        </tr>
         <tr>
             <td style="height: 23px; text-align: center"><table align="center" border="0" bordercolor="black" cellpadding="0" cellspacing="0"
                                                        width="100%">
                                                        <tr class="printable" id="pr">
                                                            <td align="center" valign="middle" style="border-left: #000000 1px solid; width: 50%;
                                                                height: 30px; border-top-width: 1px; border-bottom-width: 1px; border-bottom-color: #000000;
                                                                border-top-color: #000000; background-color: lavender; border-right-width: 1px;
                                                                border-right-color: #000000;">
                                                                <span style="font-size: 10pt; font-family: Arial"><strong>
                                                                From</strong></span> &nbsp; &nbsp;
                                                                <asp:TextBox ID="TextBox1" runat="server" MaxLength="2" Width="47px">10</asp:TextBox>
                                                                &nbsp; /&nbsp;
                                                                <asp:TextBox ID="TextBox2" runat="server" MaxLength="2" Width="47px">9</asp:TextBox>&nbsp;
                                                                /&nbsp;
                                                                <asp:TextBox ID="TextBox3" runat="server" MaxLength="4" Width="47px">2008</asp:TextBox>&nbsp;
                                                                <strong><span style="font-size: 8pt; font-family: Arial">DD/MM/YYYY</span></strong></td>
                                                            <td align="center" valign="middle" style="border-right: #000000 1px solid; width: 50%;
                                                                height: 30px; border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                                                                border-bottom-width: 1px; border-bottom-color: #000000; border-top-color: #000000;
                                                                background-color: lavender;">
                                                                <span style="font-size: 10pt; font-family: Verdana"><strong>TO</strong></span> &nbsp;
                                                                &nbsp;
                                                                <asp:TextBox ID="TextBox4" runat="server" MaxLength="2" Width="47px">8</asp:TextBox>&nbsp;
                                                                /&nbsp;
                                                                <asp:TextBox ID="TextBox5" runat="server" MaxLength="2" Width="47px">12</asp:TextBox>&nbsp;
                                                                /&nbsp;
                                                                <asp:TextBox ID="TextBox6" runat="server" MaxLength="4" Width="47px">2008</asp:TextBox>&nbsp;
                                                                <strong><span style="font-size: 8pt; font-family: Arial">DD/MM/YYYY</span></strong></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" style="width: 50%; height: 11px; border-top-width: 1px; border-top-color: #000000;
                                                                border-right-width: 1px; border-right-color: #000000; border-left: #000000 1px solid;
                                                                border-bottom: #000000 1px solid; background-color: #ffffff;" valign="middle">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1"
                                                                    ErrorMessage="RequiredFieldValidator" ForeColor="#C00000" ValidationGroup="s">*</asp:RequiredFieldValidator>
                                                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox1"
                                                                    ErrorMessage="RangeValidator" MaximumValue="31" MinimumValue="1" Type="Integer" ForeColor="#C00000" ValidationGroup="s">*</asp:RangeValidator>
                                                                &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;<asp:RangeValidator ID="RangeValidator2" runat="server"
                                                                    ControlToValidate="TextBox2" ErrorMessage="RangeValidator" MaximumValue="12"
                                                                    MinimumValue="1" Type="Integer" ForeColor="#C00000" ValidationGroup="s">*</asp:RangeValidator>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox2"
                                                                    ErrorMessage="RequiredFieldValidator" ForeColor="#C00000" ValidationGroup="s">*</asp:RequiredFieldValidator>
                                                                &nbsp; &nbsp; &nbsp;&nbsp;
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox3"
                                                                    ErrorMessage="RequiredFieldValidator" ForeColor="#C00000" ValidationGroup="s">*</asp:RequiredFieldValidator>&nbsp;
                                                                <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="TextBox3"
                                                                    ErrorMessage="RangeValidator" MaximumValue="2015" MinimumValue="2005" Type="Integer" ForeColor="#C00000" ValidationGroup="s">*</asp:RangeValidator>&nbsp;</td>
                                                            <td align="center" style="width: 50%; height: 11px; border-top-width: 1px; border-left-width: 1px;
                                                                border-left-color: #000000; border-top-color: #000000; border-right: #000000 1px solid;
                                                                border-bottom: #000000 1px solid; background-color: #ffffff;" valign="middle">
                                                                &nbsp;<asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="TextBox4"
                                                                    ErrorMessage="RangeValidator" MaximumValue="31" MinimumValue="1" Type="Integer" ForeColor="#C00000" ValidationGroup="s">*</asp:RangeValidator>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox4"
                                                                    ErrorMessage="RequiredFieldValidator" ForeColor="#C00000" ValidationGroup="s">*</asp:RequiredFieldValidator>
                                                                &nbsp; &nbsp; &nbsp;<asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="TextBox5"
                                                                    ErrorMessage="RangeValidator" MaximumValue="12" MinimumValue="1" Type="Integer" ForeColor="#C00000" ValidationGroup="s">*</asp:RangeValidator>
                                                                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox5"
                                                                    ErrorMessage="RequiredFieldValidator" ForeColor="#C00000" ValidationGroup="s">*</asp:RequiredFieldValidator>
                                                                &nbsp; &nbsp; &nbsp; &nbsp;
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox6"
                                                                    ErrorMessage="RequiredFieldValidator" ForeColor="#C00000" ValidationGroup="s">*</asp:RequiredFieldValidator>&nbsp;
                                                                <asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="TextBox6"
                                                                    ErrorMessage="RangeValidator" MaximumValue="2015" MinimumValue="2008" Type="Integer" ForeColor="#C00000" ValidationGroup="s">*</asp:RangeValidator></td>
                                                        </tr>
                                                    </table>
             </td>
         </tr>
        <tr>
            <td style="height: 23px; text-align: center">
            </td>
        </tr>
         <tr>
             <td style="height: 23px; text-align: center">
                                                                <asp:Button ID="btnShow" runat="server" OnClick="btnShow_Click" Text="Show List"
                                                                    BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                                                                    Font-Bold="True" ForeColor="White" ValidationGroup="s" /></td>
         </tr>
        <tr>
            <td style="height: 23px; text-align: center">
            </td>
        </tr>
         <tr>
             <td style="height: 21px; text-align: center">
                 <table cellspacing="0" style="width: 723px">
                     <tr>
                         <td style="width: 102px; text-align: left;">
                             <span style="font-size: 10pt; font-family: Arial">Enter User Id:</span></td>
                         <td style="text-align: left" colspan="2">
                             <asp:TextBox ID="txtUserId" runat="server" Width="138px"></asp:TextBox>
                             <asp:Button ID="btnSubmit" runat="server" BackColor="#2881A2" BorderColor="Black"
                                 BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" OnClick="btnSubmit_Click"
                                 Text="Search" ValidationGroup="w" Width="90px" /></td>
                     </tr>
                     <tr>
                         <td style="width: 102px">
                         </td>
                         <td colspan="2" style="text-align: left">
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId"
                                 ErrorMessage="Please Enter User Id !" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000"
                                 ValidationGroup="w"></asp:RequiredFieldValidator>
                             <br />
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserId"
                                 ErrorMessage="Only Alpha Numeric Value  Is Allowed!" Font-Names="Arial" Font-Size="10pt"
                                 ForeColor="#C00000" ValidationExpression="^[0-9a-zA-Z ]*" ValidationGroup="w"></asp:RegularExpressionValidator></td>
                     </tr>
                     <tr>
                         <td style="width: 102px">
                         </td>
                         <td colspan="2" style="text-align: left">
                             <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="10pt"
                    ForeColor="#C00000"></asp:Label></td>
                     </tr>
                 </table>
             </td>
         </tr>
         <tr>
             <td style="height: 21px; background-color: lavender; text-align: right">
             </td>
         </tr>
        <tr>
            <td style="text-align: right; height: 21px;">
                <asp:Label ID="Label3" runat="server" Font-Names="Arial" Font-Size="10pt" ForeColor="White"></asp:Label>
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="10pt"
                    ForeColor="#C00000"></asp:Label>&nbsp;</td>
        </tr>
        <tr><td>
    
    <asp:GridView ID="GridView1" Width="100%" AutoGenerateColumns=False   runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Font-Names="Arial" Font-Size="Small" AllowPaging="True" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging" >
    <Columns>
                   <asp:TemplateField HeaderText="Sr.No">
<ItemStyle Height="20px" Font-Bold="True" HorizontalAlign="Center"></ItemStyle>
<ItemTemplate>
<%#Container.DataItemIndex+1 %>
</ItemTemplate>
</asp:TemplateField>
  <asp:BoundField 
                              DataField="appmstregno" 
                              HeaderText="User ID" >
                                  <ItemStyle HorizontalAlign="Left" />
                                  <HeaderStyle HorizontalAlign="Left" />
                              </asp:BoundField>
                           <asp:BoundField 
                            DataField="uname" HeaderText="Name">
                               <ItemStyle HorizontalAlign="Left" />
                               <HeaderStyle HorizontalAlign="Left" />
                           </asp:BoundField>
                           <asp:BoundField 
                           DataField="aleft" HeaderText="AchiverLeft">
                               <ItemStyle HorizontalAlign="Left" />
                               <HeaderStyle HorizontalAlign="Left" />
                           </asp:BoundField>
                          
                                
                                     
                                                      
                                            <asp:BoundField DataField="aright" 
                                                      HeaderText="AchiverRight">
                                                <ItemStyle HorizontalAlign="Left" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                                     <asp:BoundField 
                                                DataField="status" HeaderText="Status">
                                                         <ItemStyle HorizontalAlign="Left" />
                                                         <HeaderStyle HorizontalAlign="Left" />
                                                     </asp:BoundField>
                                                    
                  </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="Lavender" />
        <PagerStyle BackColor="Gray" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    
    </asp:GridView>

</td></tr></table>
    </div>
    </form>
</body>
</html>
