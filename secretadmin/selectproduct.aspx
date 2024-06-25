<%@ Page Language="C#" AutoEventWireup="true" CodeFile="selectproduct.aspx.cs" Inherits="admin_selectproduct" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Upgrade User</title>
  <script language="javascript" type="text/javascript">
   
     
      
       function conf() 
      {
      var a =document.form1.TextBox3.value
      var b =document.form1.TextBox2.value
      var y=document.form1.TextBox1.value
      var z=document.form1.jamount.value
      return confirm("Name : "+b+"\n\nRegno: "+a +"\n\nAmount:" +z+"\n\nDate :" + y+)
      }
   
   
 </script>
   
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <br />
        <br />
        <br />
        <br />
        &nbsp;</div>
        <div style="text-align: center">
            <table border="1" style="height: 199px">
                <tr>
                    <td style="border-right: black 1px solid; border-top: black 1px solid; border-left: black 1px solid;
                        width: 100px; border-bottom: black 1px solid">
    <table align="center" width="500">
        <tr>
            <td colspan="2" style="height: 12px; background-color: #2881a2; text-align: center">
                <span style="color: #ffffff; font-family: Arial;"><strong>Upgrade User</strong></span></td>
        </tr>
        <tr>
            <td style="width: 152px; text-align: center; height: 25px;">
                <span style="font-size: 12pt; font-family: Arial"><strong>&nbsp;User ID</strong></span></td>
            <td style="width: 3px; text-align: left; height: 25px;">
                <asp:TextBox ID="TextBox3" runat="server" BorderWidth="0px" ReadOnly="True"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 152px; height: 24px; text-align: center">
                <strong><span style="font-family: Arial">Name</span></strong></td>
            <td style="width: 3px; height: 24px; text-align: left">
                <asp:TextBox ID="TextBox2" runat="server" BorderWidth="0px" ForeColor="Black" ReadOnly="True"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center">
            </td>
        </tr>
        <tr>
            <td style="text-align: center" colspan="2">
                <asp:Button ID="Button1"   runat="server" OnClick="Button1_Click" Text="Submit" />
                &nbsp;<asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Back" /></td>
        </tr>
        <tr>
            <td style="width: 152px">
            </td>
            <td style="width: 3px" align="left">
                <asp:Label ID="Label2" runat="server" ForeColor="Red" Font-Bold="True" Font-Names="Arial" Font-Size="Small" Width="207px"></asp:Label></td>
        </tr>
    </table>
                    </td>
                </tr>
            </table>
        </div>
        &nbsp;
    </form>
</body>
</html>
