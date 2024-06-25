<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="sponserlist.aspx.cs" Inherits="admin_sponserlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
    
    body,td,th{
    font-family: Arial;
    font-size: 12px;
    }
    
    
    </style>
    

   <div align="center">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
      <td><div align="center">
        <table width="1000" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
            </td>
            <td style="width: 50px; height: 25px; text-align: right;">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/admin_images/printer.gif"
                    OnClick="ImageButton1_Click" ToolTip="Print" /></td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 700px; border-bottom: #000000 1px solid;
                height: 25px; background-color: #2881A2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Sponsor List</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 350px; height: 35px; background-color: #EDF0FD">
                &nbsp;</td>
            <td style="border-right: #000000 1px solid; width: 350px; height: 35px; background-color: #EDF0FD;
                text-align: right">
                No Of Records&nbsp; :
                <asp:TextBox ID="TextBox2" runat="server" Enabled="False" Width="38px"></asp:TextBox>
                &nbsp; &nbsp;
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-left: #000000 1px solid;
                border-bottom: #000000 1px solid; height: 35px; background-color: #EDF0FD; text-align: center">
                No Of Sponsor :<asp:TextBox ID="TextBox1" runat="server" onkeypress="number()" Width="33px">2</asp:TextBox>&nbsp;<asp:RadioButton ID="RadioButton1"
                                runat="server" Checked="True" GroupName="p" Text="<" Width="31px" />&nbsp;<asp:RadioButton ID="RadioButton2" runat="server" GroupName="p" Text="=" />&nbsp;<asp:RadioButton ID="RadioButton3" runat="server" GroupName="p" Text=">" />&nbsp;<asp:RadioButton ID="RadioButton4" runat="server" ForeColor="White" GroupName="p"
                            Text="." />&gt;=&nbsp;
                <asp:RadioButton ID="RadioButton5" runat="server" ForeColor="White" GroupName="p"
                            Text="." />&lt;=</td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 3px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 3px;
                text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:RangeValidator ID="RangeValidator1"
                            runat="server" ControlToValidate="TextBox1" ErrorMessage="Wrong Choice" MaximumValue="999999"
                            MinimumValue="1" Type="Integer"></asp:RangeValidator></td>
            <td style="width: 50px; height: 3px">
            </td>
        </tr>
                <tr>
                    <td style="width: 50px; height: 3px">
                    </td>
                    <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 3px;
                        text-align: center; border-right-width: 1px; border-right-color: #000000">
                        <asp:Label ID="lbl" runat="server" Font-Bold="True" ForeColor="Red" Width="319px"></asp:Label></td>
                    <td style="width: 50px; height: 3px">
                    </td>
                </tr>
        <tr>
            <td style="width: 50px; height: 30px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 30px;
                text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:Button ID="Button1"
                            runat="server" OnClick="Button1_Click" Text="Show" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 50px; height: 30px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 700px; border-bottom: #000000 1px solid;
                height: 25px; text-align: center" valign="top">
                 <asp:Panel ID="Panel1" runat="server">
                  <asp:GridView ID="datargd1" runat="server" AllowPaging="True" CellPadding="4" Font-Names="Arial"
                    Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50" AutoGenerateColumns="False" OnPageIndexChanging="datargd1_PageIndexChanging" Width="695px">
                    <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <Columns>
 <asp:TemplateField HeaderText="SrNo." ><ItemTemplate ><%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>
                        <asp:BoundField DataField="AppMstregno" HeaderText="User Id" />                                          
                       
                        <asp:BoundField DataField="Name" HeaderText="Name" /> 
                        <asp:BoundField DataField="sponsorid" HeaderText="Sponsor Id"/>
                       <asp:BoundField DataField="sponsorname" HeaderText="Sponsor Name"/>
                        <asp:BoundField DataField="AppMstSponsorTotal" HeaderText="Total Sponsor" /> 
                        <asp:BoundField DataField="AppMstDOJ" HeaderText="Date Of Joinning" /> 
                        
                        <asp:BoundField DataField="AppMstCity" HeaderText="City" /> 
                        <asp:BoundField DataField="AppMstState" HeaderText="State" /> 
                      <asp:BoundField DataField="appmstpaid" HeaderText="Status" /> 
                    </Columns>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <EditRowStyle BackColor="#999999" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2881A2" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
        
         </asp:Panel>
         </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
    </table></td>
          </tr>
        </table>
      </div></td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
   </asp:Content>