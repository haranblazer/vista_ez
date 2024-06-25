<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="BankBalance.aspx.cs" Inherits="admin_BankBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
    <center>
    <table width="100%">
    <tr>
        <td style="background-color:#2881A2">
            <strong><span style="font-size: 14pt; color: #ffffff">
            Bank Balance List</span></strong></td>
    </tr>
    <tr>
    <td>
        <asp:GridView ID="GrdWithdraw" runat="server" AllowPaging="True" CellPadding="4" Font-Names="Arial"
                    Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50" AutoGenerateColumns="False" OnPageIndexChanging="dgrd_PageIndexChanging" Width="100%">
         <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
         <Columns>
            <asp:TemplateField  HeaderText="Sr.No" >
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="userId" HeaderText="User ID" />
            <asp:BoundField DataField="fname" HeaderText=" UserName"/>
            <asp:BoundField DataField="banktrandate" HeaderText="Last Transaction Date"/>
            <asp:BoundField DataField="banktranbalance" HeaderText="BankBalance"/>
            
           
         </Columns>
         <RowStyle BackColor="#F3F3F3" ForeColor="#333333" />
         <EditRowStyle BackColor="#999999" />
         <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
         <PagerStyle BackColor="#414141" ForeColor="White" HorizontalAlign="Center" />
         <HeaderStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
         <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
     </asp:GridView>
        
    </td>
    </tr>
    
    </table>
    </center>
    </div>
    </asp:Content>