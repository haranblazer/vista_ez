<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="AddPacked.aspx.cs" Inherits="AddPacked" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-lg-12 col-md-12">

        <div class="form-group card-group-row row">
            <div class="clearfix"></div>
            <br />
            <div class="row">
                <div class="col-md-4">
                    <asp:DropDownList ID="ddl_prod" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_prod_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddl_Typ" runat="server" CssClass="form-control">
                        <asp:ListItem Value="PACKED">Packed</asp:ListItem>
                        <asp:ListItem Value="UNPACKED">Unpacked</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ID="txt_Qty" runat="server" CssClass="form-control" Placeholder="Enter Packed/Unpacked Qty." MaxLength="5" onkeypress="return onlyNumbers(event,this);">
                    </asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btn_Packed" runat="server" Text="Packed/Unpacked" CssClass="btn btn-primary"
                        OnClick="btn_Packed_Click" OnClientClick="return confirm('Are you sure you want to packed/unpacked?')" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div id="div_msg" runat="server"></div>
                </div>
            </div>

            <div class="clearfix"></div>
            <br />
            <div class="row">

                <div class="col-md-1"></div>
                <div class="col-md-10">
                    <div class="table-responsive">
                        <asp:GridView ID="GridView2" EmptyDataText="Record not found." CssClass="table table-striped table-hover display dataTable nowrap cell-border"
                            runat="server" AutoGenerateColumns="False" AllowPaging="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Product Code" ItemStyle-Width="15%">
                                    <ItemTemplate>
                                        <%#Eval("ProductCode") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product Name" ItemStyle-Width="45%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("ProductName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Qty" ItemStyle-Width="10%">
                                    <ItemTemplate>
                                        <%#Eval("Qty")%>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="AVBL. Qty" ItemStyle-Width="10%">
                                    <ItemTemplate>
                                        <%#Eval("AvaiQty")%>
                                    </ItemTemplate>
                                </asp:TemplateField>


                            </Columns>
                        </asp:GridView>

                    </div>
                </div>
                <div class="col-md-1"></div>

            </div>
        </div>
    </div>
    <div class="clearfix"></div>

    <script language="Javascript" type="text/javascript">
        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }
    </script>
</asp:Content>
