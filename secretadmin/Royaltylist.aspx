<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"  CodeFile="Royaltylist.aspx.cs" Inherits="admin_list" %>

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
        <table width="900" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
    
   
    <table align="center" border="0" bordercolor="black" cellpadding="0" cellspacing="0"
        width="100%">
        <tr align="center">
            <td align="center" colspan="2"
                style="text-align: center;background-color: #2881A2; border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;">
                <span><span style="font-size: 16px"><strong><span style="font-family: Verdana; color: #ffffff;">
                    List of Royalty Achievers</span></strong></span></span></td>
        </tr>
        <tr>
            <td colspan="2" align="center" style="height: 30px; text-align: center" valign="middle">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
        </tr>
       
        <tr>
            <td align="center" style="height: 30px; text-align: left" valign="middle">
                    No Of Records:<asp:Label ID="Label2" runat="server" Font-Bold="True">0</asp:Label></td>
                    <td style="text-align:right"><asp:Image
                    ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/admin_images/excel.gif" /><asp:Button
                        ID="Button3" runat="server" BackColor="#093872" BorderStyle="None" Font-Bold="True"
                        Font-Italic="True" ForeColor="White" OnClick="Button3_Click" Text="EXPORT" /></td>
        </tr>
        <tr>
            <td align="center" colspan="2" 
                style="text-align: center; border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid;" 
                valign="top">
                  <asp:Panel ID=Panel1 runat=server>
                      <asp:GridView ID="dglst" EmptyDataText="No data found" RowStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"  runat="server" AllowPaging="True" CellPadding="4"
                       Font-Names="Arial"
                    Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50" 
                    AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging" Width="907px"
                     >
                    <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <Columns>
                               <asp:TemplateField HeaderText="Sr.No"><ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>                             
                        <asp:BoundField  DataField="AppMstregno" HeaderText="User ID"/>
                         
                          <asp:BoundField  DataField="name" HeaderText="Name"/>
                      
                           
                               <asp:BoundField  DataField="DOA" HeaderText="Achieved Date"/>
                              	
                    </Columns>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <EditRowStyle BackColor="#999999" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2881A2" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView></asp:Panel>
                
                
                </td>
        </tr>  
       
    </table>
            </td>
          </tr>
        </table>
      </div></td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
   </asp:Content>