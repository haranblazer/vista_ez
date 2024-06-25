<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeleteCategory.aspx.cs" Inherits="admin_DeleteCategory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center> <table style="width: 800px; height: 0%">
            <tr>
                <td colspan="3" style="height: 15px" bgcolor="#ffff99">
                    <span style="font-size: 16pt; color: #ff3300"><strong>Delete Category</strong></span></td>
            </tr>
            <tr>
                <td style="height: 16px" colspan="3">
                    <asp:Label ID="lblerror" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Maroon"
                        Visible="False"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3" style="height: 16px">
                </td>
            </tr>
            <tr>
                <td style="width: 129px; height: 16px">
                    Category Id</td>
                <td style="width: 100px; height: 16px">
                    <asp:DropDownList ID="ddlcatid" runat="server" Width="155px" AutoPostBack="True" OnSelectedIndexChanged="ddlcatid_SelectedIndexChanged">
                        <asp:ListItem>----Select Category----</asp:ListItem>
                        
                    </asp:DropDownList>
                   
                    <asp:RequiredFieldValidator ID="rddl1" InitialValue ="----Select Category----" SetFocusOnError ="true" Display ="None" runat ="server" ControlToValidate ="ddlcatid" ErrorMessage ="Please Select Category Id "  ForeColor ="Red"></asp:RequiredFieldValidator> 


                       
                <td style="width: 100px; height: 16px">
                </td>
            </tr>
            <tr>
                <td style="width: 129px">
                    Category Name</td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtcatname" runat="server" Enabled="False"></asp:TextBox></td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 129px">
                    Category Description</td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtDescription" runat="server" Enabled="False"></asp:TextBox></td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 129px; height: 16px">
                </td>
                <td style="width: 300px; height: 16px; text-align: left">
                </td>
                <td style="width: 100px; height: 16px">
                </td>
            </tr>
            <tr>
                <td style="width: 129px">
                </td>
                <td style="width: 300px; text-align: left">
                    <asp:Button ID="btnDeleteCategory" runat="server" Text="Delete Category" Width="113px" Font-Bold="True" ForeColor="Red" OnClick="btnDeleteCategory_Click" />&nbsp;
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="91px" Font-Bold="True" ForeColor="#004000" OnClick="btnCancel_Click" CausesValidation="False" /></td>
                <td style="width: 100px">
                </td>
            </tr>
        </table></center>
    </div>
    </form>
</body>
</html>
