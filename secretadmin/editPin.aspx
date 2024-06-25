<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="editPin.aspx.cs" Inherits="admin_editPin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        $(function() {
            $('#<%=txtDOJ.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

        });   
    </script>
 
    <h1>Edit Pin</h1> <table>
        
        <tr>
            <td>
            </td>
            <td class="alignr">
                Pin Serial No:</td>
            <td>
                <asp:TextBox ID="txtpin" runat="server" Enabled="False"></asp:TextBox></td>
            <td>
            </td>
        </tr>
        <tr runat="server" visible="false">
            <td>
            </td>
            <td class="alignr">
                Registration Number:
            </td>
            <td>
                <asp:TextBox ID="txtregno" runat="server" Enabled="False"></asp:TextBox></td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td class="alignr">
                Used Status:</td>
            <td>
                <asp:TextBox ID="txtpaid" runat="server" Enabled="False"></asp:TextBox></td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td class="alignr">
                Pin Type:</td>
            <td>
                <asp:TextBox ID="txtpintype" runat="server" Enabled="False"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpintype"
                    ErrorMessage="Please enter pin type!" ValidationGroup="epv"></asp:RequiredFieldValidator></td>
            <td>
            </td>
        </tr>
        <tr runat="server" visible="false">
            <td>
            </td>
            <td class="alignr">
                Plan Type:</td>
            <td>
                <asp:TextBox ID="txtplantype" runat="server" Enabled="False"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtplantype"
                    ErrorMessage="Please enter plan type!" ValidationGroup="epv" Font-Size="10pt"
                    ForeColor="#C00000"></asp:RequiredFieldValidator></td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td class="alignr">
                Amount:</td>
            <td>
                <asp:TextBox ID="txtamount" runat="server" Enabled="False"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtamount"
                    ErrorMessage="Please enter amount!" ValidationGroup="epv" ForeColor="#C00000"></asp:RequiredFieldValidator></td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td class="alignr">
                Alloted To:</td>
            <td>
                <asp:TextBox ID="txtallotedto" runat="server" Enabled="False"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtallotedto"
                    ErrorMessage="Please enter registration number!" ValidationGroup="epv" ForeColor="#C00000"></asp:RequiredFieldValidator></td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td class="alignr">
                Allotment Date:</td>
            <td> <asp:TextBox ID="txtDOJ" ToolTip="dd/mm/yyyy" runat="server" CausesValidation="True" Width="174px"
                        ValidationGroup="n">
                    </asp:TextBox>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td class="alignr">
                Remarks:</td>
            <td>
                <asp:TextBox ID="txtRemark" runat="server" Height="50px" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label></td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="SUBMIT" ValidationGroup="epv" CssClass="btn" /></td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
