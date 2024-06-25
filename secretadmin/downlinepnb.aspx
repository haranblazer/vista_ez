<%@ Page Language="C#" AutoEventWireup="true" CodeFile="downlinepnb.aspx.cs" Inherits="admin_downlinepnb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body style="margin-left: 10px; margin-right: 20px" >
    <form id="form1" runat="server" >
 <center>  <div style="padding-left:55px">  <asp:Repeater ID="Repeater1" runat="server">
      <HeaderTemplate> </HeaderTemplate>
      <ItemTemplate><asp:Panel ID="Panel1" runat="server" Height="100px" Width="567px">
   
         &nbsp;&nbsp;&nbsp;  <table border="0" width="300px" cellpadding="0" cellspacing="0" style="border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-bottom-width: 1px; border-bottom-color: black; border-top-color: black; border-right-width: 1px; border-right-color: black;">
            <tr>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width: 94px; border-top-color: #000000;
                    height: 223px; border-right-width: 1px; border-right-color: #000000">
                </td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width: 84px; border-top-color: #000000;
                    height: 223px; border-right-width: 1px; border-right-color: #000000">
                </td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width:35px; border-top-color: #000000; border-right-width: 1px; border-right-color: #000000; vertical-align:text-bottom;padding-top:20px ;text-align:left;padding-right:10px" rowspan="2">
                    <asp:Label ID="Label1" style="writing-mode:tb-rl;text-align: left;padding-top:10px;" Font-Bold="True" runat="server" Font-Names="Arial" Font-Size="14px"  Text='<%# DataBinder.Eval (Container.DataItem, "dispachedAmtwords") %>' Height="435px"></asp:Label></td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width:60px; border-top-color: #000000;
                    height: 223px; border-right-width: 1px; border-right-color: #000000;padding-right:50px;text-align: center;">
                    <asp:Label ID="Label2" style="writing-mode:tb-rl;text-align: left;padding-top:30px;" Font-Bold="True" runat="server" Font-Names="Arial" Font-Size="14px"  Text='<%# DataBinder.Eval (Container.DataItem, "name") %>'  Height="170px" Width="33px"></asp:Label></td>
            </tr>
            <tr>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width: 94px; border-top-color: #000000;
                    height: 279px; border-right-width: 1px; border-right-color: #000000;vertical-align: text-top; padding-top:40px; text-align: right;">
                    <asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="14px"
                        style="writing-mode:tb-rl;" Text='<%# DataBinder.Eval (Container.DataItem, "regno") %>'></asp:Label>
                </td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width: 84px; border-top-color: #000000;
                    height: 279px; border-right-width: 1px; border-right-color: #000000;vertical-align: text-top;padding-top:38px;text-align:left">
                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="14px"
                        Height="80px" Style="writing-mode: tb-rl" Text="--------------"></asp:Label><asp:Label
                            ID="Label12" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="14px"
                            Height="80px" Style="writing-mode: tb-rl" Text="A/C Payee"></asp:Label><asp:Label
                                ID="Label13" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="14px"
                                Height="80px" Style="writing-mode: tb-rl" Text="---------------"></asp:Label>
                </td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width: 84px; border-top-color: #000000;
                    height: 279px; border-right-width: 1px; border-right-color: #000000">
                </td>
            </tr>
            <tr>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width: 94px; border-top-color: #000000;
                    height: 253px; border-right-width: 1px; border-right-color: #000000">
                </td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width:100px; border-top-color: #000000;
                    height: 253px; border-right-width: 1px; border-right-color: #000000; vertical-align: top; text-align: right; padding-left:2px">
                    <asp:Label ID="Label4" style="writing-mode:tb-rl" runat="server" Font-Names="Arial" Font-Size="14px" Font-Bold="True"  Text='<%# DataBinder.Eval (Container.DataItem, "dispachedamt") %>'></asp:Label></td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width: 37px; border-top-color: #000000;
                    height: 253px; border-right-width: 1px; border-right-color: #000000">
                </td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #000000;
                    border-bottom-width: 1px; border-bottom-color: #000000; width: 84px; border-top-color: #000000;
                    height: 253px; border-right-width: 1px; border-right-color: #000000; vertical-align: text-top; padding-top: 20px; text-align: right;">
                    <asp:Label ID="Label5" style="writing-mode:tb-rl" runat="server" Font-Names="Arial" Font-Size="14px" Font-Bold="True"  Text='<%# DataBinder.Eval (Container.DataItem, "paymenttodate") %>'></asp:Label></td>
            </tr>            
            
            
        </table>
    
    
                    </asp:Panel>  </ItemTemplate>
      
      <FooterTemplate></table></FooterTemplate>
      </asp:Repeater></div></center>
      <br class="break"/> 
    
     
        
    <asp:Button ID="Button2" OnClick="Button2_Click" runat="server" Text="Back" />
      
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Next" Visible="false" />
        <br />
        
   
    </form>
</body>
</html>
