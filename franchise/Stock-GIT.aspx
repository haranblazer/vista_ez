<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Stock-GIT.aspx.cs" 
    EnableEventValidation="false" Inherits="franchise_Stock_GIT" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .printmygrd th {
            color: #000;
            text-align: left !important;
            font-size: 14px !important;
            border-bottom: dotted 1px #000 !important;
            border-top: dotted 1px #000 !important;
        }

        .printmygrd td {
            color: Black;
            font-size: 12px !important;
            text-align: left;
        }

        .footerstylebodder {
            border-bottom: dotted 1px #000 !important;
            border-top: dotted 1px #000 !important;
        }

        .printmygrd table a:link, .printmygrd table a:visited {
        }

        .printmygrd table a:hover, .printmygrd table a:active {
        }

        .container hr, footer {
            display: none;
        }
    </style>

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txt_VendorINVDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function onlyNumber(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                }
                else if (e) {
                    var charCode = e.which;
                }
                else { return true; }
                if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) {
                    return false;
                }
                return true;
            }
            catch (err) {
                alert(err.Description);
            }
        }

    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">GRN Stock</h4>



     <asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="updatepnl" runat="server">
        <ContentTemplate>
           
               <div class="row">

                    <div class="col-sm-3">
                        <asp:DropDownList ID="ddl_Vendor" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_Vendor_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_orderno" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_orderno_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txt_VendorINV" runat="server" CssClass="form-control" placeholder="Vendor Invoice no." MaxLength="30"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txt_VendorINVDate" runat="server" CssClass="form-control" placeholder="Vendor Invoice Date" MaxLength="30" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-sm-3 text-right">
                        <asp:CheckBox ID="chk_Status" runat="server" Text="&nbsp;Close PO" />
                     
                    <span>
                       <a href="AddEditQuantity.aspx" class="btn btn-primary">Add Batch</a>
                        </span>
                        </div>
                </div>
                <div class="clearfix"></div>
              

                <table id="tblUserDetails" runat="server" visible="false" style="width: 100%; text-align: left; margin-left: 10px; margin-top: 10px;" class="withclass">
                    <tr>
                        <td style="text-align: left;">
                            <span class="companyName useriddisply">Order No:
                      <asp:Label ID="lblInvoiceNo" runat="server" CssClass="head>"></asp:Label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left;">
                            <span class="companyName useriddisply">Vendor Name:
                                    <asp:Label ID="lbl_VendorName" runat="server"></asp:Label>
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
                                    <asp:Label ID="lblBillDate" runat="server"></asp:Label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left;">
                            <span class="companyName useriddisply">Delivery Date:
                                    <asp:Label ID="lbl_DeliveryDate" runat="server"></asp:Label>
                            </span>
                        </td>
                    </tr>
                </table>

             
                <center>
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </center>
                
                <div class="clearfix">
                </div>
                           
        </ContentTemplate>
    </asp:UpdatePanel>



    <div style="width: 100%;">
                    <asp:GridView ID="GridView1" DataKeyNames="cd" runat="server" AutoGenerateColumns="False"
                        Width="100%" CssClass="table table-striped table-hover" OnRowDataBound="GridView1_RowDataBound"
                        ShowFooter="true" FooterStyle-Font-Bold="true" FooterStyle-ForeColor="#555555">
                        <Columns>
                            <asp:TemplateField HeaderText="SNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Code">
                                <ItemTemplate>
                                    <asp:Label ID="lblcd" runat="server" Text='<%# Eval("pcode") %>'></asp:Label>
                                    <asp:HiddenField ID="hd_pcode" runat="server" Value='<%# Eval("pcode") %>' />
                                    <asp:HiddenField ID="hd_pid" runat="server" Value='<%# Eval("cd") %>' />
                                    <asp:HiddenField ID="hd_pname" runat="server" Value='<%# Eval("pname") %>' />
                                    <asp:HiddenField ID="hd_hsncode" runat="server" Value='<%# Eval("hsncode") %>' />
                                    <asp:HiddenField ID="hd_quantity" runat="server" Value='<%# Eval("quantity") %>' />
                                    <asp:HiddenField ID="hd_Tax" runat="server" Value='<%# Eval("Tax") %>' />
                                    <asp:HiddenField ID="hd_TaxRs" runat="server" Value='<%# Eval("TaxRs") %>' />
                                    <asp:HiddenField ID="hd_Price" runat="server" Value='<%# Eval("Price") %>' />
                                    <asp:HiddenField ID="hd_gross" runat="server" Value='<%# Eval("gross") %>' />
                                    <asp:HiddenField ID="hd_total" runat="server" Value='<%# Eval("total") %>' />

                                    <asp:HiddenField ID="hd_IGST" runat="server" Value='<%# Eval("IGST") %>' />
                                    <asp:HiddenField ID="hd_IGSTRS" runat="server" Value='<%# Eval("IGSTRS") %>' />
                                    <asp:HiddenField ID="hd_CGST" runat="server" Value='<%# Eval("CGST") %>' />
                                    <asp:HiddenField ID="hd_CGSTRS" runat="server" Value='<%# Eval("CGSTRS") %>' />
                                    <asp:HiddenField ID="hd_SGST" runat="server" Value='<%# Eval("SGST") %>' />
                                    <asp:HiddenField ID="hd_SGSTRS" runat="server" Value='<%# Eval("SGSTRS") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblpname" runat="server" Text='<%# Eval("pname") %>'></asp:Label>
                                </ItemTemplate>
                                <%-- <FooterTemplate>
                                    <asp:Label ID="labelTotal" runat="server">Total</asp:Label>
                                </FooterTemplate>--%>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Batch">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddl_Batch" runat="server" CssClass="form-control" Width="200px"></asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Rate">
                                <ItemTemplate>
                                    <asp:Label ID="lblDPWT" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Order Qty" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblQty" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Already Rcv'd">
                                <ItemTemplate>
                                    <asp:Label ID="lblReceived" runat="server" Text='<%# Eval("Received") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Receive">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtReceived" runat="server" MaxLength="6" CssClass="form-control text-center"
                                        Text='<%# Eval("RMNG") %>' OnTextChanged="txtRate_Changed" AutoPostBack="true"
                                        onkeypress="return onlyNumber(event,this);" Style="max-width: 70px; max-height: 30px; padding: 2px; margin: 2px;"></asp:TextBox>
                                </ItemTemplate>
                                <%--  <FooterTemplate>
                                    <asp:Label ID="lblF_Qty" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>--%>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Rate">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRate" runat="server" MaxLength="6" CssClass="form-control text-center"
                                        Text='<%# Eval("Price") %>' OnTextChanged="txtRate_Changed" AutoPostBack="true"
                                        onkeypress="return onlyNumber(event,this);" Style="max-width: 70px; max-height: 30px; padding: 2px; margin: 2px;"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Gross" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblValue" runat="server" Text='<%# Eval("gross") %>'></asp:Label>
                                </ItemTemplate>
                                <%-- <FooterTemplate>
                                    <asp:Label ID="lblF_Value" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>--%>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="GST(%)" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblTax" runat="server" Text='<%# Eval("Tax") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="GST" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblTaxRs" runat="server" Text='<%# Eval("TaxRs") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<FooterTemplate>
                                    <asp:Label ID="lblF_TaxRs" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>--%>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("total") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<FooterTemplate>
                                    <asp:Label ID="lblF_Total" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>--%>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                     <div class="col-sm-12 text-right">
                    <asp:Label ID="lbl_FooterData" runat="server" Style="color: darkblue;">00</asp:Label>
                </div>

                    <div style="width: 100%; float: right; text-align: right;">
                        <div class="form-group">
                            <div class="col-sm-8">
                            </div>
                            <div class="col-sm-4">
                                <asp:Button ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="GRN Stock"
                                    OnClientClick="return confirm('Are you sure you want to process this opration?');"
                                    CssClass="btn btn-primary" Visible="false" />

                            </div>
                        </div>
                       
                    </div>
                    <div class="clearfix">
                    </div>
                 

                </div>



</asp:Content>

