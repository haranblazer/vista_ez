<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="Listunpaid.aspx.cs" Inherits="admin_Listunpaid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
    <h2>Unpaid List</h2>
        <br />      
        
     <table align="center" style="width: 100%"  >
        <tr>
            <td align="center" style="text-align: left">
                <span style="font-size: 10pt; font-family: Arial">
                User ID</span>
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
                </td>
            <td align="center" style="text-align: right">
                                        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/admin/images/excel.gif" 
                        OnClick="imgbtnExcel_Click" Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/admin/images/word.jpg" 
                        OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
                    <asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="~/admin/images/pdf.gif" 
                        OnClick="imgbtnpdf_Click" />
                </td>
        </tr>
       
        <tr>
            <td style="text-align: left; height: 21px;" colspan="2">
                &nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="10pt">
                    </asp:Label></td>
        </tr>
        <tr><td colspan="2">
    
    <asp:GridView ID="GridView1"  EmptyDataText="No record found" Width="100%" AutoGenerateColumns="false"  runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Font-Names="Arial" Font-Size="Small" AllowPaging="True" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging" >
    <Columns>
                   <asp:TemplateField HeaderText="Sr.No">
<ItemStyle Height="20px" Font-Bold="True" HorizontalAlign="Center"></ItemStyle>
<ItemTemplate>
<%#Container.DataItemIndex+1 %>
</ItemTemplate>
</asp:TemplateField>
                  <asp:BoundField DataField="AppMstRegNo" HeaderText="UserId" >
                      <ItemStyle HorizontalAlign="Center" />
                  </asp:BoundField>
                <asp:BoundField DataField="name" HeaderText="Name" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                 
                  <asp:BoundField DataField="SponsorID" HeaderText="Sponsor Id" >
                      <ItemStyle HorizontalAlign="Center" />
                  </asp:BoundField>
                  <asp:BoundField DataField="ParentId" HeaderText="Parent Id" >
                      <ItemStyle HorizontalAlign="Center" />
                  </asp:BoundField>
                  <asp:BoundField DataField="JoinFor" HeaderText="Join For" >
                      <ItemStyle HorizontalAlign="Center" />
                  </asp:BoundField>
                  	<asp:BoundField DataField="appmstpaid" HeaderText="Status" >
                          <ItemStyle HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:HyperLinkField  DataNavigateUrlFields="Appmstregno,Appmstfname,JoinFor"   Text="Upgrade" DataNavigateUrlFormatString="selectproduct.aspx?n={0}&amp;n1={1}&amp;n2={2}"/>  
                  </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <PagerStyle BackColor="Gray" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    
    </asp:GridView>

</td></tr></table>

    </div>
   </asp:Content>