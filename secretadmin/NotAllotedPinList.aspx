<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="NotAllotedPinList.aspx.cs" Inherits="tohadmin_NotAllotedPinList" %>
<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
     <script type="text/javascript">
         $(function() {
             $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
             $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
         });   
    </script>


    <div id="title" class="b2">
        <h2>
           Not Alloted Pin List</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <table style="width:98%">
        
        
        <tr>
                        <td  ><table><tr><td style="width: 446px"> 
                            <asp:Panel ID="pnlDateRange" runat="server">
                           
                            From Date:<asp:TextBox ID="txtFromDate" runat="server" Width="125px"></asp:TextBox>&nbsp;To Date:<asp:TextBox ID="txtToDate" runat="server" Width="108px"></asp:TextBox>&nbsp;<asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show List"
                            ValidationGroup="Show" CssClass="btn"></asp:Button> </asp:Panel></td><td> 
                                <asp:Panel ID="pnlUtility" runat="server">
                                
                                &nbsp;Search Pin :
                               <asp:TextBox ID="txtSearch" runat="server" Width="117px"></asp:TextBox>
                            &nbsp;<asp:Button ID="btSearch" runat="server"  Text="Search" ValidationGroup="sp"
                                OnClick="btSearch_Click" />
                             &nbsp;&nbsp;&nbsp;&nbsp;Page Size <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                            <asp:ListItem Value="25">25</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>
                            <asp:ListItem>All</asp:ListItem>
                        </asp:DropDownList>
                                        &nbsp;<asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                            OnClick="ibtnExcelExport_Click" />
                             &nbsp;<asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg"
                                OnClick="ibtnWordExport_Click" style="width: 24px" />
                        &nbsp;<asp:ImageButton ID="ibtnPDFExport" runat="server" 
                                 ImageUrl="images/pdf.gif" onclick="ibtnPDFExport_Click" /></asp:Panel></td></tr></table>
                            
                       
                        </td>
                    </tr>
        <tr>
            <td colspan="2"><asp:Label ID="lblcount" runat="server" Font-Bold="True" Font-Italic="False" ForeColor="#000000"
                    Font-Names="Arial" Font-Size="Small"></asp:Label>
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Italic="False" ForeColor="#C00000"
                    Font-Names="Arial" Font-Size="Small"></asp:Label>
            </td>
        </tr>
        
        <tr>
            <td colspan="2">
              
                    <cc1:PagingGridView ID="dglst" runat="server" AllowPaging="True" CssClass="mygrd" PageSize="50" EmptyDataText="record not found."
                        AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                                <ItemStyle Font-Bold="True" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="PinSrNo"  HeaderText="Pin Serial Number" />
                           <asp:BoundField DataField="PinNo" HeaderText="Pin Number" />
                            <asp:BoundField DataField="activedate" HeaderText="Pin Generation Date" />
                            
                        </Columns>
                   </cc1:PagingGridView>
               
            </td>
        </tr><tr><td><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please enter date in dd/mm/yy format!"
        ControlToValidate="txtFromDate" Font-Bold="False" ForeColor="#C00000" ValidationGroup="Show"
        Display="None"></asp:RequiredFieldValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtToDate"
        ErrorMessage="Please enter date in dd/mm/yy format!" Font-Bold="False"
        ForeColor="#C00000" ValidationGroup="Show" Display="None"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Please enter date in dd/mm/yy format!"
        Font-Bold="False" ForeColor="#C00000" ControlToValidate="txtToDate" ValidationExpression="^[0-9/]*"
        ValidationGroup="Show" Display="None"></asp:RegularExpressionValidator><asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="Show" Width="220px" /> <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Please enter date in dd/mm/yy format!"
        Font-Bold="False" ForeColor="#C00000" ControlToValidate="txtFromDate" ValidationExpression="^[0-9/]*"
        ValidationGroup="Show" Display="None"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
                runat="server" ControlToValidate="txtSearch" Display="None"
                                ErrorMessage="Please enter pin serial no!" 
                ForeColor="#C00000" ValidationGroup="sp"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="txtSearch" Display="None"
                                ErrorMessage="Only numeric value is allowed!" 
                ForeColor="#C00000" ValidationGroup="sp"
                                ValidationExpression="^[0-9]*"></asp:RegularExpressionValidator>
                                
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="sp" ShowMessageBox="true" ShowSummary="false" /></td></tr>
    </table>


</asp:Content>

