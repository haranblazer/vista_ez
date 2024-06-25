<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="ReportMultiPrint.aspx.cs" Inherits="admin_ReportMultiPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="title" class="b2">
        <h2>
            Print All Payout Statements</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <table id="TABLE1"  style="width: 100%;">
      
        <tr>
            
            <td colspan="3">
             <asp:Panel ID="pnlUtility" runat="server" DefaultButton="btnSubmit">    <table>
                    <tr>
                        <td class="alignr">
                            Select Closing:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDate" runat="server" AutoPostBack="True" 
                                onselectedindexchanged="ddlDate_SelectedIndexChanged">
            
                            </asp:DropDownList></td>
                        <td>
                            Report Number:<asp:TextBox ID="TxtPaymentTrandraftid" runat="server" 
                                Width="110px"></asp:TextBox></td>
                        <td>
                            Number Of Reports:<asp:TextBox ID="TxtNoChq" runat="server" Width="110px"></asp:TextBox></td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn"  
                                ValidationGroup="s" onclick="btnSubmit_Click"/></td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    </table></asp:Panel>
            </td>
            
        </tr>
        <tr>
            
            <td colspan="3">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="true"
                     PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging"
                    CssClass="mygrd">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="User Id" DataField="appmstregno">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Name" DataField="name">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Report Number" DataField="PaymenttranDraftId" />
                    </Columns>
                </asp:GridView>
            </td>
            <td>
            </td>
        </tr>
       
    </table>
 <asp:RequiredFieldValidator
                         ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlDate"
                         Display="None" ErrorMessage="Plaese select closing!" Font-Names="Arial"
                         Font-Size="10pt" ForeColor="#C00000" 
                    Style="position: relative; left: 0px;" ValidationGroup="s" 
        InitialValue="Select Closing"></asp:RequiredFieldValidator>
 <asp:RequiredFieldValidator
                         ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtPaymentTrandraftid"
                         Display="None" ErrorMessage="Plaese enter report number" Font-Names="Arial"
                         Font-Size="10pt" ForeColor="#C00000" 
                    Style="position: relative; left: 0px;" ValidationGroup="s"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator
                             ID="RegularExpressionValidator7" runat="server" ControlToValidate="TxtPaymentTrandraftid"
                             Display="None" ErrorMessage="Only numeric value is allowed !" 
                    Font-Names="Arial" Font-Size="10pt"
                             ForeColor="#C00000" ValidationExpression="^[0-9]*" Width="277px" 
                                 ValidationGroup="s"></asp:RegularExpressionValidator>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                 ControlToValidate="TxtNoChq" Display="none" ErrorMessage="Plaese enter number of report!"
                                 Font-Names="Arial" Font-Size="10pt" 
        ForeColor="#C00000" Style="position: static;" ValidationGroup="s"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator
                                     ID="RegularExpressionValidator1" 
        runat="server" ControlToValidate="TxtNoChq"
                                     Display="None" ErrorMessage="Only numeric value is allowed !" 
                                 Font-Names="Arial" Font-Size="10pt"
                                     ForeColor="#C00000" 
        ValidationExpression="^[0-9]*" Width="237px" ValidationGroup="s"></asp:RegularExpressionValidator>
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" 
                                 ShowSummary="False" ValidationGroup="s" />


</asp:Content>
