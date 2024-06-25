﻿<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="StockTranReports1.aspx.cs" Inherits="franchise_StockTranReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">

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
    <h3 class="head">
        <i class="fa fa-file-text" aria-hidden="true"></i>&nbsp;GIT Report
    </h3>
    <asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="updatepnl" runat="server">
        <ContentTemplate>
            <div class="panel-default">

                <div class="form-group">
                    <div class="col-sm-3">
                        <asp:TextBox ID="txt_invoiceNO" runat="server" CssClass="form-control" placeholder="Invoice no"></asp:TextBox>
                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_invoiceNO"
                    ErrorMessage="Enter invoice no."></asp:RequiredFieldValidator>--%>
                    </div>
                   
                    <div class="col-sm-3">
                        <asp:Button ID="btn_Search" runat="server" Text="Search" CssClass="btn btn-success"
                            OnClick="btn_Search_Click" />
                        <%-- <asp:Button ID="btnSerch" runat="server" Text="Search" CssClass="btn btn-info" OnClick="btnSerch_Click" />--%>
                    </div>
                    <div class="col-sm-6">
                        <asp:CheckBox ID="chk_Status" runat="server" Text="&nbsp;Close PO" Visible="false" />
                    </div>
                </div>

                <div class="clearfix">
                </div>

                <table id="tblUserDetails" runat="server" visible="false" style="width: 100%; text-align: left;"
                    class="table mygrd">
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

                <center>
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </center>
                <div style="width: 100%; float: right;">
                    <asp:GridView ID="GridView1" DataKeyNames="cd" runat="server" AutoGenerateColumns="False"
                        Width="100%" CssClass="table table-hover mygrd" OnRowDataBound="GridView1_RowDataBound"
                        ShowFooter="false" FooterStyle-Font-Bold="true" FooterStyle-ForeColor="#555555">
                        <Columns>
                            <asp:TemplateField HeaderText="SNo.">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hnd_OFFERID" runat="server" Value='<%# Eval("OFFERID") %>' />
                                    <asp:HiddenField ID="hnd_DP" runat="server" Value='<%# Eval("DP") %>' />
                                      <asp:HiddenField ID="hnd_FPV" runat="server" Value='<%# Eval("FPV") %>' />
                                    <asp:HiddenField ID="hnd_batchid" runat="server" Value='<%# Eval("batchid") %>' />
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Code">
                                <ItemTemplate>
                                    <asp:Label ID="lblcd" runat="server" Text='<%# Eval("cd") %>' Style="display: none;"></asp:Label>
                                    <%# Eval("pcode") %>
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
                            <asp:TemplateField HeaderText="Order Qty" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblQty" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblF_Qty" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Already Rcv'd">
                                <ItemTemplate>
                                    <asp:Label ID="lblReceived" runat="server" Text='<%# Eval("Received") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Receive">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtReceived" runat="server" MaxLength="6" CssClass="form-control text-center" Enabled="false"
                                        Text='<%# Eval("RMNG") %>' OnTextChanged="txtRate_Changed" AutoPostBack="true" onkeypress="return onlyNumber(event,this);"
                                        Style="max-width: 50px; max-height: 30px; padding: 2px; margin: 2px;"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--  <asp:TemplateField HeaderText="Damage">
                        <ItemTemplate>
                            <asp:TextBox ID="txtDamage" runat="server" MaxLength="5" CssClass="form-control"
                                Text='<%# Eval("Damage") %>' Style="max-width: 50px; max-height: 30px; padding: 2px;
                                margin: 2px;"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Center" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("Dis") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblF_Discount" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gross" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblValue" runat="server" Text='<%# Eval("val") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblF_Value" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>
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
                                <FooterTemplate>
                                    <asp:Label ID="lblF_TaxRs" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FPV" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_TotalFPV" runat="server" Text='<%# Eval("TotalFPV") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblF_TaxRs" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("total") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblF_Total" runat="server" Style="text-align: center;"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <div class="col-sm-12 text-right">
                        <asp:Label ID="lbl_FooterData" runat="server" Style="color: darkblue;"></asp:Label>
                    </div>

                    <div style="width: 100%; float: right; text-align: right;">
                        <div class="form-group">
                            <div class="col-sm-8">
                            </div>
                            <div class="col-sm-4">
                                <asp:Button ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Receive Stock"
                                    OnClientClick="return confirm('Are you sure you want to process this opration?');"
                                    CssClass="btn btn-success" Visible="false" />
                            </div>
                        </div>
                    </div>
                    
                    <div class="clearfix"></div>
                    <hr />
                    <br />

                    <div class="form-group">
                        <div class="col-sm-3">
                        <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                            <asp:ListItem Value="-1">All</asp:ListItem>
                            <asp:ListItem Value="0">GIT</asp:ListItem>
                            <asp:ListItem Value="1">fulfill</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                        <div class="col-sm-3">
                            <asp:Button ID="btn_Search1" runat="server" Text="Search" CssClass="btn btn-success"
                                OnClick="btn_Search1_Click" />
                        </div>

                    </div>
                    <div class="clearfix"></div>
                    <br />

                    <asp:GridView AllowPaging="true" ID="GridView2" runat="server" AutoGenerateColumns="false"
                        CssClass="table table-striped table-hover mygrd" PageSize="50" Width="100%" OnRowCommand="GridView2_RowCommand"
                        OnRowDataBound="GridView2_RowDataBound" DataKeyNames="invoiceno">
                        <Columns>
                            <asp:TemplateField HeaderText="SNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:HyperLinkField HeaderText="Invoice No." DataTextField="InvoiceNo" DataNavigateUrlFields="srno_Encript"
                                DataNavigateUrlFormatString="~/franchise/StockTranBill.aspx?id={0}" />
                            <%--<asp:HyperLinkField DataTextField="invoiceno" HeaderText="Invoice No." DataNavigateUrlFields="srno, status"
                                Text="Print" DataNavigateUrlFormatString="StockTranBill.aspx?inv={0}&st={1}" ControlStyle-ForeColor="Blue" />--%>


                            <asp:TemplateField HeaderText="GIT/ REC">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnk_GIT" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                        CommandName="GIT" runat="server" Style="text-align: center; color: Blue;" />
                                    <asp:Label ID="lbl_GIT" runat="server" Style="color: green"></asp:Label>
                                    <asp:HiddenField ID="hd_Status" runat="server" Value='<%#Eval("Status") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="IsOffer" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("IsOffer").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Is PO Close" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" Visible="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkIsPOClose" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='Status'>&nbsp;<%# Eval("Status").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                            <asp:BoundField HeaderText="Seller Id" DataField="SellerID" />
                            <asp:BoundField HeaderText="Seller Name" DataField="SellerName" />
                            <asp:BoundField HeaderText="Buyer Id" DataField="BuyerId" />
                            <asp:BoundField HeaderText="Buyer Name" DataField="BuyerName" />
                            <asp:BoundField HeaderText="Amount" DataField="NetAmt" />
                            <asp:TemplateField HeaderText="Detail">
                                <ItemTemplate>
                                    <span id="tblPrd" style="display: none;">
                                        <%#Eval("tbl") %>
                                    </span><a href="javascript:void" style="color: Blue;">View Detail</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Qty" DataField="Quantity" />
                          <%--  <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("Status").ToString() == "1" ? "<span style='color:green;'>" + Eval("StatusText") + "</span>" : "<span style='color:red;'>"+ Eval("StatusText") +"</span>"%>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField HeaderText="Date " DataField="doe" />
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="clearfix">
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <style type="text/css">
        .dotGreen {
            height: 18px;
            width: 18px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 18px;
            width: 18px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=GridView2.ClientID %> tr:gt(0)').find("td:eq(9)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(9)").each(function () {
                        $(this).find('a').css("display", "block");
                        $(this).find('span').css("display", "none");
                    });
                    //show specific span tag
                    $(this).parent().find('span').css("display", "block");
                    $(this).css("display", "none");
                });
            });
});
        </script>
    </asp:Content>