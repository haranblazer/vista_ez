<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="admin_ProductDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center><table width="800">
        <tr>
            <td style="width: 159px; height: 16px">
                <strong>
                Search By Category</strong></td>
            <td colspan="2" style="height: 16px">
                <asp:DropDownList ID="ddlcid" runat="server" Width="162px" OnSelectedIndexChanged="ddlcid_SelectedIndexChanged" AutoPostBack="True">
                    <asp:ListItem>----Select Category Id----</asp:ListItem>
                </asp:DropDownList>&nbsp;&nbsp;<asp:Button ID="btngetdata" runat="server" Text="Get Data" OnClick="btngetdata_Click" Visible="False" />&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 159px; height: 21px;">
                </td>
            <td style="width: 243px; text-align: left; height: 21px;">
                </td>
            <td style="width: 100px; height: 21px;">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Maroon"></asp:Label></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;&nbsp;&nbsp;
                 <asp:Panel ID="Panel1" runat="server" Height="400px" Width="800px" ScrollBars="AUTO">
                     &nbsp;<asp:GridView ID="GridView1" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84"
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" Height="1%" Width="750px" OnRowEditing="GridView1_RowEditing" ShowFooter="True" PageSize="1" AutoGenerateColumns="False">                    
                        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                        <Columns>                       
                         <asp:TemplateField  HeaderText ="Select For Delete">                         
                           <ItemTemplate>   
                                             
                           <asp:CheckBox ID="chkSelect" runat="server"/>                              
                                           
                                </ItemTemplate>
                                                           
                               </asp:TemplateField>
                               <asp:TemplateField HeaderText="Image">
                               <HeaderTemplate>
                               Product Image
                               </HeaderTemplate>
                               <ItemTemplate>
                               
                               
                               <img alt="i" src='../pics/<%#DataBinder.Eval(Container.DataItem,"ProductImage")%>' height ="50"  width ="50"/>
                                
                               </ItemTemplate>
                               </asp:TemplateField>
                            <asp:BoundField DataField="ProductCode" HeaderText="Product Code" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" >
                                <ControlStyle Height="20px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="StockInHand" HeaderText="Stock In Hand" />
                            <asp:BoundField DataField="Description" HeaderText="Description" />
                            <asp:BoundField DataField="BV" HeaderText="BV" />
                            <asp:BoundField DataField="PV" HeaderText="PV" />
                            <asp:BoundField DataField="DistibutorPrice" HeaderText="Distibutor Price" />
                            <asp:BoundField DataField="vat" HeaderText="vat" />
                            <asp:BoundField DataField="MRP" HeaderText="MRP" />
                             
                       
                           </Columns>
                        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                     <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Delete Selected Items" Visible="False" />
                     &nbsp;&nbsp;&nbsp;
                 </asp:Panel>


            </td>
            <td style="width: 100px">
            </td>
        </tr>
    </table></center>
    </div>
    </form>
</body>
</html>
