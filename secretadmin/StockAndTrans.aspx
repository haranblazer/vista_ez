<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="StockAndTrans.aspx.cs" Inherits="admin_StockAndTrans" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function enterNumeric(txt) {
            var sText = txt.value
            validText = sText.substring(0, sText.length - 1)
            var ValidChars = "0123456789";
            var Char;
            for (i = 0; i < sText.length; i++) {
                Char = sText.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    txt.value = validText
                }
            }

        } </script>
    <div>
        <h2>
            Stock Transfer<hr />
        </h2>
    </div>
    <asp:LinkButton ID="linkST" runat="server" Text="Stock Transfer" OnClick="linkST_Click"></asp:LinkButton>
    <br />
    <table width="100%" id="tblST" runat="server" visible="false">
        <tr>
            <td style="padding-left: 20px">
                <table width="50%">
                    <tr>
                        <td>
                            Products Name
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProduct" runat="server" Width="150px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Franchise Name
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlFranchise" runat="server" Width="150px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Quantity
                        </td>
                        <td>
                            <asp:TextBox ID="txtQty" runat="server" Width="150px" onkeyup="javascript:return enterNumeric(this);"
                                MaxLength="5"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="if (!confirm('Are you sure for Transfer?')) return false;"
                                Width="80px" OnClick="btnSubmit_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="80px" OnClick="btnCancel_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
   
    <asp:GridView ID="GrdProduct" runat="server" AutoGenerateColumns="False" EmptyDataText=" Data Not found."
        CssClass="mygrd">
        <Columns>
            <asp:TemplateField HeaderText="SrNo.">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ProductName" HeaderText="Product Name"></asp:BoundField>
            <asp:BoundField DataField="MRP" HeaderText="MRP"></asp:BoundField>
            <asp:BoundField DataField="DPAmt" HeaderText="DP Amount"></asp:BoundField>
            <asp:BoundField DataField="BVAmt" HeaderText="BV Amount"></asp:BoundField>
            <asp:BoundField DataField="QTY" HeaderText="Quantity"></asp:BoundField>
            <asp:BoundField DataField="MaxAllowed" HeaderText="Max Allowed"></asp:BoundField>
        </Columns>
    </asp:GridView>
</asp:Content>
