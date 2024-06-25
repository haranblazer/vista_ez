<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="franshisePinlist.aspx.cs" Inherits="admin_franshisePinlist" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link href="css/PagingGridView.css" rel="stylesheet" type="text/css" />
    <div id="title" class="b2">
        <h2>Pin Details</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>

    <table style="width: 90%">
        <tr>
            <td style="width: 80%">
                <asp:Label ID="lblUser" runat="server" Font-Bold="true"></asp:Label></td>
            <td style="width: 20%; text-align: right;">
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
                <asp:ImageButton ID="ibtnExcelExport" runat="server"
                    ImageUrl="images/excel.gif" OnClick="ibtnExcelExport_Click" />
                <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg"
                    OnClick="ibtnWordExport_Click" Style="width: 24px" />
                <asp:ImageButton ID="ibtnPDFExport" runat="server"
                    ImageUrl="images/pdf.gif" OnClick="ibtnPDFExport_Click" />
            </td>
        </tr>
    </table>
  
    <cc1:PagingGridView AllowPaging="true" EmptyDataText="No Pins Alloted !" CssClass="mygrd"
        AutoGenerateColumns="false" PageSize="50" ID="gv" runat="server"
        CellPadding="4" Width="100%"
        BorderStyle="Solid" BorderWidth="1px" Font-Size="8pt"
        BorderColor="#336699" GridLines="Horizontal"
        OnPageIndexChanging="gv_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="SrNo.">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="PIN Sr No." DataField="Pinsrno" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="70"/>
            <asp:BoundField HeaderText="Pin No." DataField="PinNo" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="250" />

            <%--<asp:BoundField HeaderText="Pin Type" DataField="Pintype" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />--%>
            <asp:BoundField HeaderText="Allotment Date" DataField="allotmentdate" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
            <%--<asp:BoundField HeaderText="USED BY" DataField="usedby" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="250"/>
--%>            <asp:BoundField HeaderText="Amount" DataField="amount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="mode" HeaderText="MODE" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="transactionNo" HeaderText="Transaction No." ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="bank" HeaderText="BANK" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="depositedamount" HeaderText="Deposited Amount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100"/>
           <%-- <asp:BoundField DataField="remark" HeaderText="REMARK" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />--%>
        </Columns>


    </cc1:PagingGridView>
</asp:Content>

