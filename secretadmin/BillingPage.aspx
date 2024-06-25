<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="BillingPage.aspx.cs" Inherits="secretadmin_BillingPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<%--    <script type="text/javascript">

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
                    $("[id*=lbltotalamt]", row).html(parseFloat($(".price", row).html()) * parseFloat($(this).val()));
                }
            } else {
                $(this).val('');
            }
            var grandTotal = 0;
            $("[id*=lbltotalamt]").each(function () {
                grandTotal = grandTotal + parseFloat($(this).html());
            });
            $("[id*=lblGrandTotal]").html(grandTotal.toString());
        });
    </script>--%>
    <style type="text/css">
        tr, td, th
        {
            padding: 7px;
        }
    </style>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="line">
                <h2 class="Approch">
                    Generate Sales
                </h2>
            </div>
            <div class="form-group">
                <div class="col-sm-2">
                    Enter User ID</div>
                <div class="col-sm-3">
                    <asp:TextBox ID="txtuserid" runat="server" CssClass="form-control" onchange="return CallVal(this);"
                        CausesValidation="True"></asp:TextBox>
                    <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtuserid"
                        ErrorMessage="Please Enter userid"></asp:RequiredFieldValidator></div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div id="divUserID" style="display: none;" runat="server">
            </div>
            <div class="form-group">
                <div class="col-sm-2">
                    <asp:Label ID="lbladdress" runat="server" Text="If You want Change Delivery Address Then Fill Up Otherwise No Need  To Fill Up"></asp:Label></div>
                <div class="col-sm-3">
                    <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox><br />
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtaddress"
                ErrorMessage="Please Enter Delivery Addres"></asp:RequiredFieldValidator>--%>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-2">
                    <asp:Label ID="lbldoe" runat="server" Text="Date Of Bill"></asp:Label></div>
                <div class="col-sm-3">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFromDate"
                        ErrorMessage="Please Enter"></asp:RequiredFieldValidator></div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="table-responsive">
                <table >
                    <tr>
                        <td>
                            <asp:GridView ID="dglst" runat="server" AutoGenerateColumns="False" EmptyDataText="Record not found."
                               CssClass="mygrd" OnRowDataBound="dglst_RowDataBound"  >
                                <Columns>
                                    <asp:TemplateField HeaderText="SrNo">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                            <asp:Label ID="lblpid" runat="server" Text='<%#Eval("productid") %>' Visible="false"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Package Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblpname" runat="server" Text='<%#Eval("productname") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Batch No">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlbatchno" runat="server" OnSelectedIndexChanged="ddlbatchno_SelectedIndexChanged"
                                                AutoPostBack="true">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Stock Qty" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblstockqty" runat="server" Text="0"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Qty">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtquantity" runat="server" ontextchanged="txtquantity_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Price">
                                        <ItemTemplate>
                                          <%--  <asp:Label ID="lblprice" runat="server"  CssClass="price"  Style="font-size:12px"></asp:Label>--%>

                                             <asp:Label ID="lblprice" runat="server"  CssClass="price"  Style="font-size:12px"></asp:Label>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalamt" runat="server" Text="0"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Grand Total:
                            <asp:Label ID="lblGrandTotal" runat="server" Text="0"></asp:Label>
                        </td>
                    </tr>
                </table>
                <div class="clearfix">
                </div>
                <br />
            </div>
            

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
