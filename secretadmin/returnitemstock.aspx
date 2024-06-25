<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="returnitemstock.aspx.cs" Inherits="secretadmin_returnitem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .printmygrd th
        {
            color: #000;
            text-align: left !important;
            font-size: 14px !important;
            border-bottom: dotted 1px #000 !important;
            border-top: dotted 1px #000 !important;
        }
        .printmygrd td
        {
            color: Black;
            font-size: 12px !important;
            text-align: left;
        }
        
        .footerstylebodder
        {
            border-bottom: dotted 1px #000 !important;
            border-top: dotted 1px #000 !important;
        }
        .printmygrd table a:link, .printmygrd table a:visited
        {
        }
        .printmygrd table a:hover, .printmygrd table a:active
        {
        }
        .container hr, footer
        {
            display: none;
        }
    </style>
       <%--<script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
  
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
    
    <h3 class="head">
        <i class="fa fa-file-text" aria-hidden="true"></i>&nbsp;Return Item
    </h3>
   
    <div class="panel panel-default">
    <br />
        <div class="form-group">
            <div class="col-sm-3">
                <asp:TextBox ID="txt_invoiceNO" runat="server" CssClass="form-control" placeholder="Invoice no"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_invoiceNO"
                    ErrorMessage="Enter invoice no."></asp:RequiredFieldValidator>
            </div>
            <div class="col-sm-2">
                <asp:Button ID="btnSerch" runat="server" Text="Search" CssClass="btn btn-info" OnClick="btnSerch_Click" />
            </div>
            <div class="col-sm-7">
            </div>
        </div>
  
    <br />
    <div class="clearfix">
    </div>
    <hr />
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
                            <span class="companyName useriddisply">Invoice Date:
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
    <br />
    <center>
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
    </center>
    <div style="width: 100%; float: right;">
        <asp:GridView ID="GridView1" DataKeyNames="cd" runat="server" AutoGenerateColumns="False"
            Width="100%" CssClass="table table-hover mygrd" OnRowDataBound="GridView1_RowDataBound" ShowFooter="true"
            FooterStyle-Font-Bold="true" FooterStyle-ForeColor="#555555">
            <Columns>
                <asp:TemplateField HeaderText="SNo.">
                    <ItemTemplate>
                        <asp:HiddenField ID="hnd_DP" runat="server" Value='<%# Eval("DP") %>' />
                        <asp:HiddenField ID="hnd_batchid" runat="server" Value='<%# Eval("batchid") %>' />
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
                <%--<asp:BoundField ItemStyle-HorizontalAlign="Left" DataField="cd" HeaderText="Code" />
                <asp:BoundField ItemStyle-HorizontalAlign="Left" DataField="pname" HeaderText="Product Name" />
                <asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="DPWT" HeaderText="Unit Price"
                    FooterText="Total" />--%>
                <asp:TemplateField HeaderText="Qty" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblQty" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblF_Qty" runat="server"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Resale">
                    <ItemTemplate>
                        <asp:TextBox ID="txtResale" runat="server" MaxLength="5" CssClass="form-control" Text='<%# Eval("Resale") %>'
                            Style="max-width: 50px; max-height: 25px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Damage">
                    <ItemTemplate>
                        <asp:TextBox ID="txtDamage" runat="server" MaxLength="5" CssClass="form-control" Text='<%# Eval("Damage") %>'
                            Style="max-width: 50px; max-height: 25px"></asp:TextBox>
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
        <br />
        <div id="tblbank" runat="server" visible="false" style="width: 100%; float: right;
            text-align: right;">
            <div class="form-group">
                <div class="col-sm-7">
                </div>
                <div class="col-sm-3">
                    <table style="float: right; margin-right: 5%;">
                        <tr>
                            <td colspan="2">
                                Payments Mode:
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="ddlpaytype" runat="server" CssClass="selectbox" onchange="run();">
                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                    <asp:ListItem Value="1">Wallet</asp:ListItem>
                                    <asp:ListItem Value="2">Cash</asp:ListItem>
                                    <asp:ListItem Value="3">Cheque</asp:ListItem>
                                    <asp:ListItem Value="4">Net Banking</asp:ListItem>
                                    <asp:ListItem Value="5">DD</asp:ListItem>
                                    <asp:ListItem Value="6">Credit Note</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="bankelement" runat="server" style="display: none;">
                            <td>
                                Bank Name<br />
                                <asp:TextBox ID="txtbname" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                DD/Cheque/Transaction No<br />
                                <asp:TextBox ID="txtDD" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                Date<br />
                                <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-sm-2">
                    <asp:Button ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Update"
                        OnClientClick="return confirm('Are you sure you want to process this operation?');"
                        CssClass="btn btn-success" />
                </div>
            </div>
        </div>
             <br />
        <div id="Div1" runat="server" style="width: 100%; float: right;
            text-align: right;">
         
           <asp:GridView AllowPaging="true" ID="GridView2" runat="server" AutoGenerateColumns="false"
            CssClass="table table-striped table-hover mygrd" PageSize="50"
            Width="100%" >
            <Columns>
                <asp:TemplateField HeaderText="SrNo.">
                <ItemStyle HorizontalAlign="center"></ItemStyle>
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
               
 <asp:HyperLinkField DataTextField="invoiceno" HeaderText="Invoice No." DataNavigateUrlFields="srno,status"
                            Text="Print" DataNavigateUrlFormatString="GSTBill.aspx?id={0}&st={1}" ControlStyle-ForeColor="Blue" ><ItemStyle HorizontalAlign="Left"></ItemStyle></asp:HyperLinkField>

                   <%-- <asp:BoundField HeaderText="Invoice No" DataField="invoiceno" ><ItemStyle HorizontalAlign="Left"></ItemStyle></asp:BoundField>--%>
                    <asp:BoundField HeaderText="Bill By" DataField="salesrep" ><ItemStyle HorizontalAlign="Left"></ItemStyle></asp:BoundField>
                <asp:BoundField HeaderText="Franchise Id" DataField="franchiseid" ><ItemStyle HorizontalAlign="Left"></ItemStyle></asp:BoundField>
                <asp:BoundField HeaderText="Name" DataField="fname" ><ItemStyle HorizontalAlign="Left"></ItemStyle></asp:BoundField>
              <%--  <asp:BoundField HeaderText="PO-TO(ID)" DataField="orderto" />
                <asp:BoundField HeaderText="PO-TO(Name)" DataField="ordertoname" />--%>
                <asp:BoundField HeaderText="Amount Returned" DataField="returnamt" />
                <asp:BoundField HeaderText="BV Minus" DataField="bvamt" />
               <%-- <asp:TemplateField HeaderText="Address">
                    <ItemTemplate>
                        <asp:Label ID="lbladdress" runat="server" Text='<%#Eval("adrs") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                --%>
                <asp:TemplateField HeaderText="Detail">
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    <ItemTemplate>
                        <%--to bind the product detail--%>
                        <span id="tblPrd" style="display: none;">
                            <%#Eval("tbl") %>
                        </span><a href="javascript:void" style="color: Blue;">View Detail</a>
                    </ItemTemplate>
                </asp:TemplateField>

             <%--   <asp:TemplateField HeaderText="PaymentSlip_Image">
                    <ItemTemplate>
                        <a href="<%# Eval("PaymentSlip","../User/PaymentSlip/{0}") %>" data-fancybox="gallery">
                            <asp:Image ID="bankimage" runat="server" Height="50px" ImageUrl='<%# Eval("PaymentSlip","../User/PaymentSlip/{0}") %>'
                                Width="50px" />
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>--%>
             <%--   <asp:BoundField HeaderText="Bank" DataField="BankName" />
                <asp:BoundField HeaderText="Tran_No." DataField="TranNo" />
                <asp:BoundField HeaderText="Tran_Date" DataField="TranDate" />--%>
                 <asp:BoundField HeaderText="Date " DataField="doe" ><ItemStyle HorizontalAlign="Left"></ItemStyle></asp:BoundField>
                <asp:BoundField HeaderText="Pay Mode" DataField="PayMode" ><ItemStyle HorizontalAlign="Left"></ItemStyle></asp:BoundField>

             <%--   <asp:TemplateField HeaderText="Remarks">
                    <ItemTemplate>
                        <asp:TextBox ID="txtcomment" runat="server" CssClass="form-control" Text='<%# Eval("remarks") %>'
                            Style="max-width: 220px; min-width: 180px" placeholder="Enter Remarks"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" Text="Submit" CommandName="A" CssClass="btn btn-success btn-xs"
                            CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Button ID="Button2" runat="server" Text="Cancel" CommandName="B" CssClass="btn btn-success btn-xs"
                            CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>
        </div>
    </div>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
 <%--   <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function run() {
            var ddlReport = document.getElementById("<%=ddlpaytype.ClientID%>");
            var Text = ddlReport.options[ddlReport.selectedIndex].text;

            var Table = document.getElementById("<%=bankelement.ClientID%>");
            if (Text.localeCompare("Cash") == 0) {
                Table.style.display = "none";
            }
            else {
                Table.style.display = "block";
            }
        }
    </script> --%>

     <script>
         $(document).ready(function () {
             $('#<%=GridView2.ClientID %> tr:gt(0)').find("td:eq(7)").each(function () {
                 $(this).find('a').click(function () {
                     
                     //hide all spanded tag
                     $('#<%=GridView2.ClientID %> tr:gt(0)').find("td:eq(7)").each(function () {
                        
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
     <div class="clearfix">
        </div>
     </div>
     <br />
</asp:Content>
