<%@ Page Language="C#" AutoEventWireup="true" CodeFile="printchq.aspx.cs" Inherits="admin_printchq" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
 <%--
    <style type="text/css" media="print">
        html, body {
        margin:0;
        padding:0;
        }
        div {
        border: 0;
        margin: 0px 0px 0px 0px;
        padding:0;
        }
        .noprint {
        display:none;
        }
    </style>--%>
   <%--<style type="text/css" media="print"> 
  .Mystyle1   
  {   
  width:8.5in;   
  height:11in;   
  background:#FFFF99;   
  border-left:0.1   solid   black;   
  border-top:0.1   solid   black;   
  border-right:4   solid   black;   
  border-bottom:4   solid   black;   
  margin:8.2px;   
  }   
   </style>--%>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Panel ID="Panel1" runat="server" Height="50px" Width="125px" Visible="False">
        <table border="0" cellpadding="0" cellspacing="0" style="background-image: url(../images/print_base.jpg);
            width: 8in">
            <tr>
                <td style="width: 23px; height: 38px;">
                </td>
                <td style="width: 100px; height: 38px; text-align: right;">
                    <asp:Label ID="lbldate" runat="server" Text="lbldate" Width="119px" style="text-align: left; z-index: 100; left: 642px; position: absolute; top: 4px;" Font-Names="Arial" Font-Size="14px" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 23px; height: 34px;">
                </td>
                <td style="width: 100px; height: 34px;" valign="bottom">
                    <asp:Label ID="lblname" runat="server" Text="Label" Width="443px" style="z-index: 100; left: 151px; position: absolute; top: 27px" Font-Names="Arial" Font-Size="14px" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 23px; height: 31px;">
                </td>
                <td style="width: 100px; height: 31px;">
                </td>
            </tr>
            <tr>
                <td style="width: 23px; height: 33px;">
                </td>
                <td style="width: 100px; vertical-align: bottom; height: 33px;">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
                    <asp:Label ID="lblmoneyinwords" runat="server" Text="lblmoneyinwords" Width="530px" style="z-index: 100; left: 215px; position: absolute; top: 82px" Font-Names="Arial" Font-Size="14px" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 23px; height: 31px;">
                </td>
                <td style="width: 100px">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    <asp:Label ID="lblmoneyinnumber" runat="server" Text="lblmoneyinnumber" Width="108px" style="z-index: 100; left: 620px; position: absolute; top: 122px" Font-Names="Arial" Font-Size="14px" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 23px; height: 31px">
                </td>
                <td style="width: 100px; height: 31px;">
                    &nbsp;</td>
            </tr>
        </table>
        </asp:Panel>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 774px">
            <tr>
                <td style="width: 100px; height: 24px; text-align: right">
                </td>
                <td style="width: 300px; height: 24px; text-align: center">
                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Label" Visible="False"
                        Width="245px"></asp:Label></td>
                <td style="width: 100px; height: 24px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; text-align: right; height: 24px;">
                    </td>
                <td style="width: 300px; height: 24px; text-align: center;">
                    <asp:Button ID="btnnext" runat="server" Text="Next" Width="75px" OnClick="btnnext_Click" />
                    &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="btnPrint" runat="server" Text="Print" Width="75px" OnClick="btnPrint_Click" /></td>
                <td style="width: 100px; height: 24px;">
                </td>
            </tr>
        </table>
        <br />
        
    
    </div>
    </form>
</body>
</html>
