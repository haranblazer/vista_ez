<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AllDownlinePrintedCheques.aspx.cs" Inherits="admin_AllDownlinePrintedCheques" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <center> <table style="width: 739px">
           <tr>
               <td style="width: 98px; height: 24px; text-align: left"> <table style="width: 795px">
                     <tr>
                         <td colspan="2" style="background-color: #f5f5f5; text-align: center">
                             <span style="color: #b22222;"><span style="font-family: Arial"><strong><span style="font-size: 14pt">
                                 &nbsp; &nbsp; &nbsp; <span style="color: #000000">Downline Printed Cheques</span><span></span></span></strong></span></span></td>
                     </tr>
                 </table><hr  style="color:#b22222;width: 800px" />
               </td>
           </tr>
           <tr>
               <td style="width: 98px; text-align: center">
                   <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                       ForeColor="#C00000" Width="334px"></asp:Label>&nbsp;</td>
           </tr>
            <tr>
                <td style="width: 98px">
                    &nbsp;
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:GridView ID="dgr" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                CellPadding="0" Font-Bold="False" Font-Names="Arial" Font-Size="Small" ForeColor="#333333"
                                GridLines="None" OnPageIndexChanging="dgr_PageIndexChanging" PageSize="100" Width="800px">
                                <FooterStyle BackColor="#108ACB" Font-Bold="True" ForeColor="White" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No">
                                        <ItemStyle Font-Bold="True" Height="20px" />
                                        <ItemTemplate>
<%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="srno" HeaderText="Cheque Number" />
                                     <asp:BoundField DataField="regno" HeaderText="User Id" />
                                <asp:BoundField DataField="name" HeaderText="Name" />
                                <asp:BoundField DataField="paymenttodate" HeaderText="Date" />
                                <asp:BoundField DataField="amount" HeaderText="Amount" />
                                <asp:BoundField DataField="parentid" HeaderText="ParentId" />
                                <asp:BoundField DataField="payoutno" HeaderText="PayoutNo" />
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="Status" runat="server" Text="Issued"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chk1" runat="server" AutoPostBack="true" OnCheckedChanged="checkme" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk2" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#EDF0FD" ForeColor="#333333" />
                                <EditRowStyle BackColor="#999999" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#69B5D1" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            </asp:GridView>
                        </asp:Panel>
                </td>
            </tr>
           <tr>
               <td style="width: 98px; text-align: center;">
                   &nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Send To Printed List" /></td>
           </tr>
        </table></center>
    
    </div>
    </form>
</body>
</html>
