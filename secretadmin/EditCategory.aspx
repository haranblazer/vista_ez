<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditCategory.aspx.cs" Inherits="admin_EditCategory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center><table style="width: 961px; height: 148px">
        <tr>
            <td colspan="4">
                <strong>Edit&nbsp; Category</strong></td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Label ID="lblerror" runat="server" Font-Bold="True" Font-Size="Small" ForeColor="#C00000"
                    Visible="False"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 100px">
                <span class="heading"> </span>
            </td>
            <td style="width: 100px">
                <strong>Category Id</strong></td>
            <td style="width: 150px">
                <asp:DropDownList ID="ddlcid" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlcid_SelectedIndexChanged1" Width="154px" >
                    <asp:ListItem>----Select Category id----</asp:ListItem>
                </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlcid" ErrorMessage="Please Select Categoty Id" InitialValue ="----Select Category id----">*</asp:RequiredFieldValidator></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
                <strong>Category Name</strong></td>
            <td style="width: 200px">
                <asp:Label ID="lblcatname" runat="server" Font-Bold="True" ForeColor="Purple"></asp:Label></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 26px">
            </td>
            <td style="width: 100px; height: 26px; text-align: left">
                <strong>Category name:</strong></td>
            <td style="width: 150px; height: 26px">
                <asp:TextBox ID="txtCategoryname" runat="server" Height="20px" MaxLength="49"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCategoryname"
                    ErrorMessage="Please Enter Categoy Name">*</asp:RequiredFieldValidator></td>
            <td style="width: 100px; height: 26px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 21px">
            </td>
            <td style="width: 100px; height: 21px; text-align: left">
                <strong>Description:</strong></td>
            <td style="width: 150px; height: 21px">
                <asp:TextBox ID="txtDescription" runat="server" Height="45px" TextMode="MultiLine"
                    Width="152px" MaxLength="480"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDescription"
                    ErrorMessage='Please Enter Category Descripton"'>*</asp:RequiredFieldValidator></td>
            <td style="width: 100px; height: 21px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 4px">
            </td>
            <td style="width: 100px; height: 4px; text-align: right">
            </td>
            <td style="width: 100px; height: 4px; text-align: left">
            </td>
            <td style="width: 100px; height: 4px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px; text-align: right">
                <asp:Button ID="btnEdit" runat="server"  Text="Update" Width="64px" OnClick="btnEdit_Click" /></td>
            <td style="width: 100px; text-align: left">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="55px" CausesValidation="False" OnClick="btnCancel_Click" /></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" />
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
    </table></center>
    </div>
    </form>
</body>
</html>
