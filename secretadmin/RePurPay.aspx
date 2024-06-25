<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="RePurPay.aspx.cs" Inherits="Admin_RePurPay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <div id="title" class="b2">
        <h2>
            Repurchase Details</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <table border="0" cellpadding="0" cellspacing="0" style="width: 80%">
        <tr>
            <td colspan="3" style="border-left-width: 1px; border-left-color: #000000; height: 25px">
                <table style="width: 100%">
                    <tr id="Tr1" runat="server" visible="false">
                        <td class="top_table" style="width: 22px">
                            &nbsp;
                        </td>
                        <td class="top_table" style="width: 431px">
                            &nbsp;
                        </td>
                        <td class="top_table">
                            &nbsp;
                        </td>
                    </tr>
                    <tr id="Tr2" runat="server">
                        <td class="top_table" style="width: 22px">
                            &nbsp;
                        </td>
                        <td class="top_table" style="width: 431px">
                            From
                            <asp:TextBox ID="txtFromDate" runat="server" BackColor="White" Width="80px"></asp:TextBox>
                            &nbsp;TO
                            <asp:TextBox ID="txtToDate" runat="server" Width="80px" BackColor="White"></asp:TextBox>
                            <%--  &nbsp;<asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click"
                                CssClass="btn" ValidationGroup="show" />--%>
                        </td>
                        <td class="top_table">
                            &nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr id="Tr3" runat="server">
                        <td class="top_table" style="width: 22px">
                            &nbsp;
                        </td>
                        <td class="top_table" colspan="2">
                            <asp:Label ID="lblLastPayoutDate" runat="server" Font-Bold="True" Font-Names="Arial"
                                Font-Size="10pt"></asp:Label>
                        </td>
                    </tr>
                    <tr id="Tr4" runat="server">
                        <td class="top_table" style="text-align: center; height: 34px">
                           
                        </td>
                        <td class="top_table" style="text-align: left; padding-left:80px; height: 34px">
                         &nbsp;
                            <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="Button3_Click" CssClass="btn" />
                        </td>
                        <td class="top_table" style="text-align: center; height: 34px">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="border-left-width: 1px; border-left-color: #000000; width: 26px; height: 25px">
                &nbsp;
            </td>
            <td style="border-left-width: 1px; border-left-color: #000000; width: 350px; height: 25px">
                &nbsp;
            </td>
            <td style="width: 350px; height: 25px; border-right-width: 1px; border-right-color: #000000">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="border-left-width: 1px; border-left-color: #000000; width: 26px; height: 25px">
            </td>
            <td style="border-left-width: 1px; border-left-color: #000000; width: 350px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px; border-right-width: 1px; border-right-color: #000000">
            </td>
        </tr>
        <tr>
            <td style="border-left-width: 1px; border-left-color: #000000; height: 25px" colspan="3">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="show"
                    ControlToValidate="txtFromDate" Display="None" ErrorMessage="Please enter from date!"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                    ControlToValidate="txtFromDate" ErrorMessage="Please enter date in dd/mm/yyyy format!"
                    Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*" ValidationGroup="show"
                    Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="show"
                    ControlToValidate="txtToDate" Display="None" ErrorMessage="Please enter to date!"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtToDate"
                    ErrorMessage="Please enter date in dd/mm/yyyy format!" Font-Bold="False" ForeColor="#C00000"
                    ValidationExpression="^[0-9/]*" ValidationGroup="show" Display="none" SetFocusOnError="True"></asp:RegularExpressionValidator>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
                    ShowSummary="false" ValidationGroup="show" />
            </td>
        </tr>
    </table>
</asp:Content>
