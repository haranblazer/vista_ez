<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="DTB.aspx.cs" Inherits="admin_DTB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:GridView ID="GrdView" runat="server" EmptyDataText="No records found" CssClass="mygrd"
        Font-Size="Small" ForeColor="#333333" AutoGenerateColumns="False">
        <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="Sr.No">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %></ItemTemplate>
                <ItemStyle Font-Bold="True" Height="20px" />
            </asp:TemplateField>
            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                DataField="userId" HeaderText="User ID" />
            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                DataField="Name" HeaderText="User Name" />
            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                DataField="Causeid" HeaderText="Cause ID" />
            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                DataField="Amount" HeaderText="Amount" />
            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                DataField="Effectdate" HeaderText="Date" />
            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                DataField="DTB" HeaderText="Remarks" />
        </Columns>
    </asp:GridView>
</asp:Content>
