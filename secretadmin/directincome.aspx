<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="directincome.aspx.cs" Inherits="admin_directincome" Title="Details Cause for Direct Income : Admin Control Panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 700px; height: 25px">
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Details Cause for Direct Income</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 25px">
                <asp:GridView ID="GridView1" DataSourceID=sql runat="server" AutoGenerateColumns="False" CellPadding="4"
                    ForeColor="#333333" GridLines="None" AllowPaging="True" PageSize="25" Width="700px">
                    <Columns>
                        <asp:BoundField DataField="userid" HeaderText="User Id" />
                        <asp:BoundField DataField="couseid" HeaderText="Cause Id" />
                        <asp:BoundField DataField="dincome" HeaderText="Direct Income" />
                     <asp:BoundField DataField="LeftTotal" HeaderText="Left Total" />
                            <asp:BoundField DataField="RightTotal" HeaderText="Right Total" />
                         <asp:BoundField DataField="Totalsponser" HeaderText=" Total Sponsor" />
                        <asp:BoundField DataField="effectdate" HeaderText="Effect date" />
                       
                        
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#D2FABA" />
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#69B5D1" ForeColor="Black" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; width: 700px; border-top-color: #000000;
                height: 25px; text-align: center; border-right-width: 1px; border-right-color: #000000">
                <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" ForeColor="Black"
                    NavigateUrl="~/admin/beforpayout.aspx" Width="46px">Back</asp:HyperLink></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                border-bottom-width: 1px; border-bottom-color: #000000; width: 700px; border-top-color: #000000;
                height: 25px; border-right-width: 1px; border-right-color: #000000">
                <asp:SqlDataSource ID=sql runat=server SelectCommand= "select * from  CouseId where userid=@userid" ConnectionString="<%$ConnectionStrings:dsn %>">

<SelectParameters>

<asp:QueryStringParameter  Name=userid QueryStringField=n Type=string/>

</SelectParameters>

</asp:SqlDataSource>
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
    </table>
    <br />




</asp:Content>

