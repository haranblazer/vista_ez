<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AgreementList.aspx.cs" Inherits="admin_AgreementList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>

   <form  id="form1" runat="server"> 
   <div>
     <center>   &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            <table style="border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid" cellspacing="0" id="TABLE1" onclick="return TABLE1_onclick()">
                <tr>
                    <td style="width: 100%; background-color: #2881a2">
                        <span style="font-size: 11pt; color: #ffffff; font-family: Arial"><strong style="width: 100%">
                            Agreement Entries</strong></span></td>
                </tr>
                <tr style="color: #000000">
                    <td style="width: 100%; text-align: left">
                        <table style="width: 879px" cellspacing="0">
                            <tr style="background-color: #edf0fd;">
                                <td style="width: 44%; text-align: left">
                                    <strong><span style="font-size: 10pt; font-family: Arial">From &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                                        <asp:TextBox ID="txtFDD" runat="server" Width="46px"></asp:TextBox>
                                        /
                                        <asp:TextBox ID="txtFMM" runat="server" Width="46px"></asp:TextBox>
                                        /
                                        <asp:TextBox ID="txtFYYYY" runat="server" Width="46px"></asp:TextBox></span></strong></td>
                                <td style="width: 50%; text-align: left; ">
                                    <span style="font-size: 10pt; font-family: Arial"><strong>To
                                        <asp:TextBox ID="txtTDD" runat="server" Width="46px"></asp:TextBox>
                                        /
                                        <asp:TextBox ID="txtTMM" runat="server" Width="46px"></asp:TextBox>
                                        /
                                        <asp:TextBox ID="txtTYYYY" runat="server" Width="46px"></asp:TextBox></strong></span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="background-color: #edf0fd;">
                    <td style="width: 100%; text-align: left">
                        <strong><span style="font-size: 10pt; font-family: Arial">User Id : &nbsp; &nbsp;&nbsp;&nbsp;
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:TextBox ID="txtUserId" runat="server"></asp:TextBox>&nbsp;
                            </span></strong></td>
                </tr>
                <tr style="background-color: #edf0fd;">
                    <td style="width: 100%; text-align: left">
                        <span style="font-size: 10pt; font-family: Arial"><strong>Agreement Number:
                            <asp:TextBox ID="txtAgreementno" runat="server"></asp:TextBox>&nbsp;
                            </strong></span></td>
                </tr>
                <tr style="background-color: #edf0fd">
                    <td style="width: 100%; text-align: left">
                    </td>
                </tr>
                <tr style="background-color: #edf0fd;">
                    <td style="width: 100%; text-align: left">
                        <span style="font-size: 10pt; font-family: Arial"><strong><span style="color: #990000">
                            Note: </span>Search by one option at time!</strong></span></td>
                </tr>
                <tr style="background-color: #edf0fd;">
                    <td style="width: 100%; text-align: center">
                        <asp:Button ID="Button1" runat="server" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid"
                            BorderWidth="1px" Font-Bold="True" ForeColor="White" OnClick="Button1_Click"
                            Text="Search" /></td>
                </tr>
                <tr style="background-color: #edf0fd;">
                    <td style="width: 100%">
                        <asp:Label ID="lbl" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#C00000"
                            Width="473px"></asp:Label></td>
                </tr>
                <tr style="background-color: #edf0fd;">
                    <td style="width: 100%; text-align: left">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#C00000"
                            Width="204px" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#C00000"
                            Width="204px" Font-Size="Small"></asp:Label></td>
                </tr>
            <tr style="color: #000000">
                <td style="width: 100px"> <asp:GridView ID="GridView1" runat="server" Width="880px"  CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging1" PageSize="2"  >
                    <Columns>
                    <asp:TemplateField HeaderText="Sr.No"><ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>

                        <asp:BoundField  DataField="userid"   HeaderText="User Id" />
                        <asp:BoundField  DataField="agreementno" HeaderText="Agreement Number" />
                        <asp:BoundField  DataField="doa" HeaderText="Date Of Agreement" />
                         
                        
                        
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EDF0FD" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <PagerStyle BackColor="#69B5D1" ForeColor="#333333" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    
                </asp:GridView>
                </td>
            </tr>
        </table>
        </center>
    
    </div>
    </form>
</body>
</html>
