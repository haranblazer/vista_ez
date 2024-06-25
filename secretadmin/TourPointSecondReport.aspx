<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="TourPointSecondReport.aspx.cs" Inherits="admin_TourPointSecondReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<table>
 <tr>
                <td align="center" style="text-align: center; border-right: #000000 1px solid;   font-size: 9.8px; border-top: #000000 1px solid;
                    border-left: #000000 1px solid; border-bottom: #000000 1px solid;" valign="top">
                    <asp:Panel ID="Panel1" runat="server">
                        <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="mygrd" Width="800px"
                            Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
                            AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging" >
                           
                            <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %></ItemTemplate>
                                    <ItemStyle Font-Bold="True" Height="20px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="regno" HeaderText="User ID" />
                               
                                <asp:BoundField DataField="tp2608l" HeaderText="Tour Point Left" />
                                <asp:BoundField DataField="tp2608r" HeaderText="Tour Point Right" />
                               
                              

                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </td>
            </tr>
        </table>

</asp:Content>



