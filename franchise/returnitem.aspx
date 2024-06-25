<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="returnitem.aspx.cs" Inherits="secretadmin_returnitem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">
            <label>Associate Product Return</label>
        </h4>
    </div>


    <div class="row">
        <div class="col-sm-12">
            <span class="text-right" style="color: red;">Note: When you return any item then this scheme will be lapse.</span>
        </div>

        <div class="col-sm-3">
            <asp:TextBox ID="txt_invoiceNO" runat="server" CssClass="form-control" placeholder="Invoice no"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_invoiceNO"
                ErrorMessage="Enter invoice no."></asp:RequiredFieldValidator>
        </div>
        <div class="col-sm-1">
            <asp:Button ID="btnSerch" runat="server" Text="Search" CssClass="btn btn-success" OnClick="btnSerch_Click" />
        </div>
        <div class="clearfix"></div>


        <div class="col-sm-12">
            <table id="tblUserDetails" runat="server" visible="false" style="width: 100%; text-align: left;">
                <tr>
                    <td style="text-align: left;">
                        <table style="width: 100%; text-align: left;" class="withclass">
                            <tr>
                                <td style="text-align: left;">
                                    <span class="companyName useriddisply">Invoice No:
                                    <asp:Label ID="lblInvoiceNo" runat="server" CssClass="head>"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">
                                    <span class="companyName useriddisply">User Id:
                                    <asp:Label ID="txtUserId" runat="server"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">
                                    <span class="companyName useriddisply">User Name:
                                    <asp:Label ID="txtUserName" runat="server"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">
                                    <span class="companyName useriddisply">Invoce Date:
                                    <asp:Label ID="lblinvoiceDate" runat="server"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">
                                    <span class="companyName useriddisply">Phone No:
                                    <asp:Label ID="lbl_phoneno" runat="server"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="text-align: right;">
                        <table style="width: 100%; text-align: left;" class="withclass">
                            <tr>
                                <td style="text-align: left; vertical-align: top; width: 50%;">
                                    <span class="companyName useriddisply">Address:
                                    <asp:Label ID="lblToAdd" runat="server"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>

    </div>
    <div class="clearfix"></div>
    <hr />
    <center>
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
    </center>
    <div style="width: 100%; float: right;">
        <asp:GridView ID="GridView1" DataKeyNames="cd" runat="server" AutoGenerateColumns="False"
            CssClass="table table-striped table-hover display dataTable nowrap cell-border cell-border" 
            OnRowDataBound="GridView1_RowDataBound" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="#">
                    <ItemTemplate>
                        <asp:HiddenField ID="hnd_DP" runat="server" Value='<%# Eval("DP") %>' />
                        <asp:HiddenField ID="hnd_batchid" runat="server" Value='<%# Eval("batchid") %>' />
                        <asp:HiddenField ID="hdf_OFFERID" runat="server" Value='<%# Eval("OFFERID") %>' />
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Code">
                    <ItemTemplate>
                        <asp:Label ID="lblcd" runat="server" Text='<%# Eval("cd") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <asp:Label ID="lblpname" runat="server" Text='<%# Eval("pname") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Unit Price">
                    <ItemTemplate>
                        <asp:Label ID="lblDPWT" runat="server" Text='<%# Eval("DPWT") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="labelTotal" runat="server">Total</asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sold Qty" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblQty" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblF_Qty" runat="server"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Good Qty">
                    <ItemTemplate>
                        <asp:TextBox ID="txtResale" runat="server" MaxLength="5" CssClass="form-control"
                            Text='<%# Eval("Resale") %>' Style="max-width: 50px; max-height: 25px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Damage/<br>Exp. Qty">
                    <ItemTemplate>
                        <asp:TextBox ID="txtDamage" runat="server" MaxLength="5" CssClass="form-control"
                            Text='<%# Eval("Damage") %>' Style="max-width: 50px; max-height: 25px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("Dis") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblF_Discount" runat="server"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Value" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblValue" runat="server" Text='<%# Eval("val") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblF_Value" runat="server"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tax(%)" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblTax" runat="server" Text='<%# Eval("Tax") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tax" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblTaxRs" runat="server" Text='<%# Eval("TaxRs") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblF_TaxRs" runat="server"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="BV" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblBV" runat="server" Text='<%# Eval("BV") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblF_BV" runat="server"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("total") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblF_Total" runat="server"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div id="tblbank" runat="server" visible="false" style="width: 100%; float: right; text-align: left;">
            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <div class="col-sm-6">
                                Payments Mode
                            </div>
                            <div class="col-sm-6">
                                <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="form-control" onchange="PayModeDisplay();">
                                    <asp:ListItem Value="5">Credit Note</asp:ListItem>
                                    <asp:ListItem Value="1">Cash</asp:ListItem>
                                    <asp:ListItem Value="2">Cheque</asp:ListItem>
                                    <asp:ListItem Value="3">Net Banking</asp:ListItem>
                                    <asp:ListItem Value="4">DD</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div id="bankelement" runat="server" style="display: none;">
                            <div class="clearfix"></div>
                            <div class="col-sm-12">
                                <div class="col-sm-6">
                                    Bank Name
                                </div>
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtbname" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-sm-12">
                                <div class="col-sm-6">
                                    DD/Cheque/Transaction No
                                </div>
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtDD" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-sm-12">
                                <div class="col-sm-6">
                                    Date
                                </div>
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-sm-2">
                    <asp:Button ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Update"
                        OnClientClick="return confirm('Are you sure you want to process this opration?');"
                        CssClass="btn btn-success" />
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <br />

        <div id="Div1" runat="server" style="width: 100%; float: right; text-align: right;">
            <asp:GridView AllowPaging="true" ID="GridView2" runat="server" AutoGenerateColumns="false"
                CssClass="table table-striped table-hover display dataTable nowrap cell-border cell-border" 
                PageSize="50" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField HeaderText="Credit Note No." DataField="invoiceno" />
                    <asp:BoundField HeaderText="Invoice No." DataField="Ret_InvoiceNo" />
                    <asp:BoundField HeaderText="Bill By" DataField="salesrep">
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="User Id" DataField="appmstregno">
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Name" DataField="appmstfname">
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>

                    <asp:BoundField HeaderText="Amount Returned" DataField="returnamt" />
                    <asp:BoundField HeaderText="BV Minus" DataField="bvamt" />

                    <asp:TemplateField HeaderText="Detail">
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        <ItemTemplate>
                            <%--to bind the product detail--%>
                            <span id="tblPrd" style="display: none;">
                                <%#Eval("tbl") %>
                            </span><a href="javascript:void(0)" style="color: Blue;">View Detail</a>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField HeaderText="Date " DataField="doe">
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Pay Mode" DataField="PayMode">
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <div class="clearfix"></div>
    <br />


    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" /> 
    <script src="../Grid_js_css/jquery-3.5.1.js" type="text/javascript"></script>
  

    <script> var $JDT = $.noConflict(true); </script>
    <script>

        $JDT(function () {
            $JDT('#<%=GridView2.ClientID %> tr:gt(0)').find("td:eq(8)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView2.ClientID %> tr:gt(0)').find("td:eq(8)").each(function () {
                        $(this).find('a').css("display", "block");
                        $(this).find('span').css("display", "none");
                    });
                    //show specific span tag
                    $(this).parent().find('span').css("display", "block");
                    $(this).css("display", "none");
                });
            });
        });

        function PayModeDisplay() {
            if ($('#<%=ddlpaytype.ClientID%>').val() == "1" || $('#<%=ddlpaytype.ClientID%>').val() == "5") {
                $('#<%=bankelement.ClientID%>').hide();
            }
            else {
                $('#<%=bankelement.ClientID%>').show();
            }
        }

    </script>
</asp:Content>
