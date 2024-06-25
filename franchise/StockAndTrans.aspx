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
            Stock In Hand<hr />
        </h2>
    </div>
    <br />
    <asp:GridView ID="GrdProduct" runat="server" AutoGenerateColumns="False" EmptyDataText="Not Data found."
        CssClass="table table-striped table-hover">
        <Columns>
            <asp:TemplateField HeaderText="SrNo.">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ProductName" HeaderText="Product Name"></asp:BoundField>
            <asp:BoundField DataField="MRP" HeaderText="MRP"></asp:BoundField>
          <%--  <asp:BoundField DataField="DPAmt" HeaderText="DP With Tax"></asp:BoundField>
            <asp:BoundField DataField="BVAmt" HeaderText="BV Amount"></asp:BoundField>--%>
            <asp:BoundField DataField="QTY" HeaderText="Quantity"></asp:BoundField>
           <%-- <asp:BoundField DataField="MaxAllowed" HeaderText="Max Allowed"></asp:BoundField>--%>
        </Columns>
    </asp:GridView>
</asp:Content>
