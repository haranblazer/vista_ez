<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bineryincome.aspx.cs" Inherits="admin_bineryincome" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    
    <style type="text/css">
    
    body,td,th{
    font-family: Arial;
    font-size: 12px;
    }
    
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
   <div align="center">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
      <td><div align="center">
        <table width="900" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
    
   <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 700px; height: 25px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Details Cause for Binary Income</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 25px">
                <asp:GridView ID="GridView1"  runat="server" AutoGenerateColumns="False" CellPadding="4"
                    ForeColor="#333333" GridLines="None"  Width="700px">
                    <Columns>
                        <asp:BoundField DataField="userid" HeaderText="User Id" />
                        <asp:BoundField DataField="causeid" HeaderText="Cause Id" />
                        <asp:BoundField DataField="Amount" HeaderText="Binary Income" />                     
                        <asp:BoundField DataField="effectdate" HeaderText="Effect date" />
                       
                        
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EFF3FB" />
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#69B5D1" ForeColor="White" HorizontalAlign="Center" />
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
                <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" ForeColor="Blue"
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
                &nbsp;
            </td>
            <td style="width: 50px; height: 25px">
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
    </form>
</body>
</html>
