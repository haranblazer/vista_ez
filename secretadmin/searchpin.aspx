<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="searchpin.aspx.cs" Inherits="admin_search" %>
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
            Search Pin</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <table style="width: 100%">
        <tr>
            <td  class="top_table" style="width: 228px">
                Pin Serial No / Alloted To / Amount
            </td>
            <td class="top_table" style="width: 136px">
                <asp:TextBox ID="txtSearch" ToolTip="PLEASE ENTER SEARCH WORDS" runat="server" ValidationGroup="p"></asp:TextBox>
                <br />
                
            </td>
            <td>
                Date&nbsp;From:
                <asp:TextBox ID="txtFromDate" runat="server" ToolTip="dd/mm/yyyy" Width="80px"></asp:TextBox>
                To:
                <asp:TextBox ID="txtToDate" runat="server" ToolTip="dd/mm/yyyy" Width="80px"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" ValidationGroup="p"
                    CssClass="btn" />
                &nbsp;Page Size <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
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
                                 ImageUrl="images/pdf.gif" onclick="ibtnPDFExport_Click" />
            </td>
        </tr>
        
        <tr>
            <td  class="top_table" colspan="3" style="text-align: left">
                <asp:Label ID="lblCount" runat="server" Font-Bold="True" ></asp:Label>
            </td>
        </tr>
        
        <tr>
            <td colspan="3">
                <cc1:PagingGridView ID="dgr" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    EmptyDataText="" CssClass="mygrd" OnPageIndexChanging="dgr_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField DataTextField="pinsrno" DataNavigateUrlFields="Pinsrno" DataNavigateUrlFormatString="editPin.aspx?n={0}" HeaderText="Pin Serial Number" />
                        <asp:BoundField DataField="allotedto" HeaderText="Alloted To"></asp:BoundField>
                        <asp:BoundField DataField="allotedtoname" HeaderText="Name"></asp:BoundField>
                        <asp:BoundField DataField="Amount" HeaderText="Amount"></asp:BoundField>
                        <asp:BoundField DataField="Allotmentdate" HeaderText="Alloted Date"></asp:BoundField>
                        <asp:BoundField DataField="paidappmstid" HeaderText="Status"></asp:BoundField>
                        <asp:BoundField DataField="usedby" HeaderText="Used By "></asp:BoundField>
                        <asp:BoundField DataField="usedbyname" HeaderText="Name"></asp:BoundField>
                        <asp:BoundField DataField="remark" HeaderText="Remark"></asp:BoundField>
                    </Columns>
             </cc1:PagingGridView>
            </td>
        </tr>
    </table>
<asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server"
                    ControlToValidate="txtSearch" Display="Dynamic" ErrorMessage="Invalid Input"
                    ForeColor="#084383" ValidationExpression="^[A-Za-z0-9]*" >Only alpha numeric value is allowed!</asp:RegularExpressionValidator>
  

</asp:Content>
