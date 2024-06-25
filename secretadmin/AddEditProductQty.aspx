<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="AddEditProductQty.aspx.cs" Inherits="secretadmin_AddEditProductQty" %>
  <%--  <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        $(function () {
            $("[id*=txtquantity]").val("0");
        });
        $("[id*=txtquantity]").live("change", function () {
            if (isNaN(parseInt($(this).val()))) {
                $(this).val('0');
            } else {
                $(this).val(parseInt($(this).val()).toString());
            }
        });
        $("[id*=txtquantity]").live("keyup", function () {



            if (!jQuery.trim($(this).val()) == '') {
                if (!isNaN(parseFloat($(this).val()))) {
                    var row = $(this).closest("tr");


                    $("[id*=lbltotalqty]", row).html(parseFloat($(".price", row).html()) + parseFloat($(this).val()));
                }
            } else {
                $(this).val('');
            }

        });
    </script>
    <div style="padding: 15px 0px 0px  0px;">
        <h2 class="head">
            Add/Edit Quantity
        </h2>
    </div>
    <div class="clearfix">
    </div>
    <br />
  <%--  <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataKeyNames="productid"
        CssClass="mygrd" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="SrNo">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product ID">
                <ItemTemplate>
                    <asp:Label ID="lblproductid" runat="server" Text='<%#Eval("Productid") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product Name">
                <ItemTemplate>
                    <asp:Label ID="lblproductname" runat="server" Text='<%#Eval("productname") %>'></asp:Label>
                    <asp:Label ID="lblquantity" runat="server" Text='<%#Eval("qty") %>' Visible="false"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="qty" HeaderText="Qty" ItemStyle-CssClass="price" ItemStyle-Font-Size="Medium"
                ItemStyle-Font-Names="Helvetica Neue" />
            <asp:TemplateField HeaderText="Stock Quantity">
                <ItemTemplate>
                    <asp:TextBox ID="txtquantity" runat="server" Text="0"></asp:TextBox>
                    <br />
                    <asp:RangeValidator ID="rg1" runat="server" ControlToValidate="txtquantity" SetFocusOnError="true"
                        Display="Dynamic"></asp:RangeValidator>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total Quantity">
                <ItemTemplate>
                    <asp:Label ID="lbltotalqty" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Batch No">
                <ItemTemplate>
                    <asp:TextBox ID="txtbatchno" runat="server" Text='<%#Eval("batchno") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="rqbatchno" runat="server" ControlToValidate="txtbatchno"
                        SetFocusOnError="true" Display="Dynamic" ErrorMessage="Batch no" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Manfacturing Date">
                <ItemTemplate>
                    <asp:TextBox ID="txtdate" runat="server" Text='<%#Eval("doe") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="rqdate" runat="server" ControlToValidate="txtdate"
                        SetFocusOnError="true" Display="Dynamic" ErrorMessage="Batch Date" ForeColor="Red"></asp:RequiredFieldValidator>
                    <%--<cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtdate"
                        PopupButtonID="txtdate" Format="dd/MM/yyyy">
                    </cc1:CalendarExtender>--%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-success" />
</asp:Content>
