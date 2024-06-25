<%@ Page Language="C#" AutoEventWireup="true" CodeFile="notActiveList.aspx.cs" Inherits="admin_notActiveList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center><table border="0" cellpadding="0" cellspacing="0" style="width: 800px; border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid;">
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="width: 600px; height: 25px">
            </td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff; font-family: Arial;">Not Active Pins List</span></strong></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 32px">
            </td>
            <td style="width: 600px; height: 35px; text-align: center">
                <asp:Button ID="btnShow" runat="server" Style="position: relative" Text="Show" Width="71px" OnClick="btnShow_Click" /></td>
            <td style="width: 100px; height: 32px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="width: 600px; height: 35px; text-align: right">
                <span style="font-family: Arial">
                No Of Records&nbsp; :</span>
                <asp:TextBox ID="txtNoofRecords" runat="server" Width="43px"></asp:TextBox>&nbsp;
            </td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-bottom: #000000 1px solid; height: 25px">
           <asp:GridView ID="dgList" runat="server" AllowPaging="True" CellPadding="4" Font-Names="Arial"
                    Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50" AutoGenerateColumns="False" OnPageIndexChanging="dgList_PageIndexChanging" Width="617px">
                    <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <Columns>
                      <asp:TemplateField HeaderText="SrNo." ><ItemTemplate ><%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>
                        <asp:BoundField DataField="PinSerial_No" HeaderText="PinSerial_No" />                                          
                      
                        <asp:BoundField />
                    </Columns>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <EditRowStyle BackColor="#999999" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2881A2" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="width: 600px; height: 25px; text-align: center">
                <asp:Label ID="Label2" runat="server" Width="151px" Font-Names="Arial"></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <asp:Label ID="lblmsg1" runat="server" Width="140px" Font-Names="Arial" ForeColor="#C00000"></asp:Label></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
    </table></center>
    </div>
    </form>
</body>
</html>
