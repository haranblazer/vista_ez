<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pooldisplayadmin.aspx.cs" Inherits="solaradmin_pooldisplayadmin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Pool Report</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>
        <table style="width: 755px">
            <tr>
                <td align="center" colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                    border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                    background-color: #2881a2; text-align: center">
                    <span><span><span style="font-size: 16px"><strong><span style="color: #ffffff; font-family: Verdana">
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="#C00000" Width="292px"></asp:Label></span></strong></span></span></span></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <table style="width: 742px">
                        <tr>
                            <td style="width: 106px; height: 18px">
                                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#C00000" Width="292px"></asp:Label></td>
                            <td style="width: 100px; height: 18px; text-align: right" align="right">
                                <asp:LinkButton ID="lnkBtnBack" runat="server" Font-Bold="True" ForeColor="#C00000"
                                    OnClick="lnkBtnBack_Click" Text="Back"></asp:LinkButton><%-- <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" NavigateUrl="~/user/PinList.aspx?i=<%=strsessionid %>" ForeColor="#C00000">Back</asp:HyperLink>--%></td>
                        </tr>
                    </table>
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                        Font-Names="Arial" Font-Size="10pt" OnPageIndexChanging="GridView1_PageIndexChanging"
                        PageSize="50" Width="751px">
                        <PagerSettings PageButtonCount="25" />
                        <FooterStyle CssClass="grdfooter" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="poolid" HeaderText="PoolId" />
                            <asp:BoundField DataField="appmstregno" HeaderText="Registration No." />
                            <asp:BoundField DataField="PoolEntryDOJ" HeaderText="Pool Entry Date" />
                        </Columns>
                        <PagerStyle BackColor="#FF9C65" BorderStyle="None" BorderWidth="0px" />
                        <HeaderStyle CssClass="grdfooter" />
                        <AlternatingRowStyle CssClass="grdAlt" />
                    </asp:GridView>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="padding-left: 10px; width: 100px">
                    &nbsp;</td>
            </tr>
        </table>
    </center>
    </div>
    </form>
</body>
</html>
