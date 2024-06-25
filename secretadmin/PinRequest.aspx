<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PinRequest.aspx.cs" Inherits="admin_PinRequest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
   <div align="center">
    
   
    <table align="center" border="0" bordercolor="black" cellpadding="0" cellspacing="0" style="width: 84%">
        <tr align="center"colspan="2">
            <td align="center"colspan="2" style="text-align: center;background-color: #2881A2; border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;">
                <span><span><span style="font-size: 16px"><strong><span style="font-family: Verdana; color: #ffffff;">
                    Pin Requested</span></strong></span></span></span></td>
        </tr>
        <tr>
            <td align="center" colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; text-align: center"
                valign="top">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                    ForeColor="#C04000"></asp:Label></td>
        </tr>
        <tr>
            <td align="center" colspan="2" style="text-align: center; border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid;" valign="top">
                  <asp:Panel ID="Panel1" runat="server">
               <asp:GridView ID="dgr"  runat="server" AllowPaging="True" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" OnPageIndexChanging="dgr_PageIndexChanging" Width="941px" CellPadding="0" ForeColor="#333333" GridLines="None" PageSize="100" Font-Bold="False">
<FooterStyle BackColor="#108ACB" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="Sr.No">
<ItemStyle Height="20px" Font-Bold="True"></ItemStyle>
<ItemTemplate>
<%#Container.DataItemIndex+1 %>
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="srno" HeaderText="Request No"></asp:BoundField>
<asp:BoundField DataField="userid" HeaderText="User ID"></asp:BoundField>
<asp:BoundField DataField="JoiningAmount" HeaderText="Joining Amount"></asp:BoundField>
<asp:BoundField DataField="PinAlloted" HeaderText="Pin Alloted"></asp:BoundField>
<asp:BoundField DataField="Description" HeaderText="Description"></asp:BoundField>
<asp:BoundField DataField="DOE" HeaderText="Request Date"></asp:BoundField>
<asp:BoundField DataField="Remark" HeaderText="Remark"></asp:BoundField>
<asp:BoundField DataField="Status" HeaderText="Status"></asp:BoundField>

                



</Columns>

<RowStyle BackColor="#EDF0FD" ForeColor="#333333"></RowStyle>

<EditRowStyle BackColor="#999999"></EditRowStyle>

<SelectedRowStyle BackColor="#E2DED6" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#69B5D1" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#69B5D1" ForeColor="White" Font-Bold="True"></HeaderStyle>

<AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>
</asp:GridView>
              

              
</asp:Panel>
                
                
                </td>
        </tr>  
       
    </table>
          <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
              ForeColor="#C00000"></asp:Label>
</div>
    </form>
</body>
</html>
