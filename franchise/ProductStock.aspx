<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="ProductStock.aspx.cs" Inherits="admin_ProductStock" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            var dataUserID = document.getElementById("<%=divProduct.ClientID%>").innerHTML.split(",");
            $('#<%=txtPname.ClientID %>').autocomplete(dataUserID);
        });
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
    </script>
    <h2 class="head">
        <i class="fa fa-hand-o-right" aria-hidden="true"></i>&nbsp;Stock Summary Report
        <div class="pull-right">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="25px" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                Style="margin-left: 0px" Width="26px" />
        </div>
    </h2>
    <div class="clearfix">
    </div>
    <br />
    <div style="display: none">
        <span style="text-align: right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/admin/images/excel.gif"
                OnClick="imgbtnExcel_Click" Width="25px" /></span>
    </div>
    <div style="display: none">
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
                Product Name
            </label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtPname" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-sm-2">
            </div>
            <div class="col-sm-2">
                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Search"
                    OnClick="btnSearch_Click" />
            </div>
            <div class="col-sm-2">
                <asp:Button ID="BtnClear" runat="server" CssClass="btn btn-success" Text="Clear"
                    OnClick="BtnClear_Click" />
            </div>
        </div>
    </div>
    
    <div>
        <div class="col-sm-12" style="overflow: auto;">
            <asp:GridView ID="Grdreport" CssClass="table table-striped table-hover" AutoGenerateColumns="false"
                runat="server" OnRowCommand="Grdreport_RowCommand" ShowFooter="true" DataKeyNames="Pid">
                <Columns>
                    <%--<asp:TemplateField HeaderText="SNo">
                        <ItemTemplate>
                            <b>
                                <%#Container.DataItemIndex+1%>
                            </b>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:BoundField DataField="ProductCode" HeaderText="Prod Code" />
                    <asp:TemplateField HeaderText="Product Name" ItemStyle-Width="300">
                        <ItemTemplate>
                            <asp:Label ID="lblPName" runat="server" Text='<%#Eval("ProductName")%>' Width="180px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Opening" HeaderText="Op Bal" ItemStyle-HorizontalAlign="Right" />
                    
                    <asp:TemplateField HeaderText="TI">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_TI" runat="server" Text='<%# Eval("ItemIn")%>' CommandName="TI" style="color:blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="GRN">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_GRN" runat="server" Text='<%# Eval("GRN")%>' CommandName="GRN" style="color:blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Sales">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_Sales" runat="server" Text='<%# Eval("Sold")%>' CommandName="Sales" style="color:red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Packed">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_Packed" runat="server" Text='<%# Eval("Packed")%>' CommandName="Packed" style="color:blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Packed Using">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_PackedUsing" runat="server" Text='<%# Eval("PackedUsing")%>' CommandName="PackedUsing" style="color:red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Un Packed">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_UnPacked" runat="server" Text='<%# Eval("UnPacked")%>' CommandName="UnPacked" style="color:red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Un Packed Items">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_UnPackedItems" runat="server" Text='<%# Eval("UnPackedItems")%>' CommandName="UnPackedItems" style="color:blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <%--<asp:BoundField DataField="ItemIn" HeaderText="TI" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="GRN" HeaderText="GRN" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="Sold" HeaderText="Sales" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="Packed" HeaderText="Packed" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="PackedUsing" HeaderText="Packed Using" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="UnPacked" HeaderText="Un Packed" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="UnPackedItems" HeaderText="Un Packed Items" ItemStyle-HorizontalAlign="Right" />--%>

                     <asp:TemplateField HeaderText="TO">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_ItemOut" runat="server" Text='<%# Eval("ItemOut")%>' CommandName="ItemOut" style="color:red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Issued">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_Issued" runat="server" Text='<%# Eval("Issued")%>' CommandName="Issued" style="color:red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="From Item Adj">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_FromItemAdj" runat="server" Text='<%# Eval("FromItemAdj")%>' CommandName="FromItemAdj" style="color:red;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>




                    <%--<asp:BoundField DataField="ItemOut" HeaderText="TO" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="Issued" HeaderText="Issued" />
                    <asp:BoundField DataField="FromItemAdj" HeaderText="From Item Adj" ItemStyle-HorizontalAlign="Right" />--%>

                     <asp:TemplateField HeaderText="To Item Adj">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_ToItemAdj" runat="server" Text='<%# Eval("ToItemAdj")%>' CommandName="ToItemAdj" style="color:blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Sales Return">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_SalesReturn" runat="server" Text='<%# Eval("SalesReturn")%>' CommandName="SalesReturn" style="color:blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="RTV">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_RTV" runat="server" Text='<%# Eval("RTV")%>' CommandName="RTV" style="color:black;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Bal Qty">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbl_Balance" runat="server" Text='<%# Eval("BalQty")%>'  CommandName="Balance" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%--<asp:BoundField DataField="ToItemAdj" HeaderText="To Item Adj" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="SalesReturn" HeaderText="Sales Return" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="RTV" HeaderText="RTV" ItemStyle-HorizontalAlign="Right" />--%>

                   <%-- <asp:BoundField DataField="BalQty" HeaderText="Balance" ItemStyle-HorizontalAlign="Left" />--%>
                    <%-- <asp:TemplateField HeaderText="Product Code">
                        <ItemTemplate>
                            <%#Eval("pid")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Product Name">
                        <ItemTemplate>
                            <%#Eval("pname")%>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Batch No">
                        <ItemTemplate>
                            <%#Eval("Batchno")%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Batch Date">
                        <ItemTemplate>
                            <%#Eval("Batchdate")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total In">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbltotin" CommandName="In" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                                Text='<%# Eval("inqty")%>' runat="server"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Out">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbltotout" CommandName="out" ForeColor="Red" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                                Text='<%# Eval("outqty")%>' runat="server"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Cancel Qty">
                        <ItemTemplate>
                            <asp:LinkButton ID="lblcancelqty" CommandName="Cancel" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                                Text='<%# Eval("canqty")%>' runat="server"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:BoundField DataField="stock" HeaderText="Stock In Hand" FooterText="Total"/>
                    <asp:TemplateField HeaderText="Amount">
                        <ItemTemplate>
                            <%#Eval("amount")%>
                        </ItemTemplate>
                      
                    </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <div id="divProduct" style="display: none;" runat="server">
    </div>
    <div class="clearfix">
    </div>
    <br />
</asp:Content>
