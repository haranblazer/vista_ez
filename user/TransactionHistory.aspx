<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="TransactionHistory.aspx.cs" Inherits="User_TransactionHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" charset="utf-8">
        function ConfirmSubmit() {
            if (confirm("Are you sure want to proceed for payment?")) {
                return true;
            }
            return false;
        }
    </script>
    
    <section class="page--header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6">
                            <!-- Page Title Start -->
                            <h2 class="page--title h5"> My Shopping</h2>
                            <!-- Page Title End -->
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item active"><span>Transaction History</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>
               <section class="main--content">
             <br />
           
            <div class=" gutter-20">
            <div class="col-md-12">
        <div class="panel panel-default">
          
            
                    <div class="col-sm-2">
                        <strong><span style="font-size: 10pt; font-family: Verdana">Transaction Type</span></strong>
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddlTranType" runat="server" AutoPostBack="True" CssClass="form-control"
                            OnSelectedIndexChanged="ddlTranType_SelectedIndexChanged">
                            <asp:ListItem Value="-1">All</asp:ListItem>
                            <asp:ListItem Value="1">Success</asp:ListItem>
                            <asp:ListItem Value="2">Failed</asp:ListItem>
                            <asp:ListItem Value="0">Pending</asp:ListItem>
                        </asp:DropDownList>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
              <div class="clearfix"></div>
                <div class="form-group">
                <div class="col-md-12">
                    <p>
                        <span class="badge badge-primary" style="background-color: #f4fef4; border: 1px solid #333;
                            color: #333; font-size: small">Success &nbsp;</span> <span style="background-color: #FCFFF0;
                                border: 1px solid #333; color: #333; font-size: small" class="badge badge-primary">
                                Pending&nbsp;</span> <span style="background-color: #ffcccc; border: 1px solid #333;
                                    color: #333; font-size: small" class="badge badge-primary">Failed&nbsp;</span>
                    </p>
                </div>
                </div>
                <br />
                <div class="table-responsive">
                    <asp:GridView ID="POTranHistoryOnline" EmptyDataText="No Record Found." CssClass="table "
                        runat="server" AllowPaging="true" AutoGenerateColumns="false" PageSize="25" OnPageIndexChanging="POTranHistoryOnline_PageIndexChanging"
                        OnRowDataBound="POTranHistoryOnline_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="User ID" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblId" runat="server" Text='<%#Eval("srno") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="lblUID" runat="server" Text='<%#Eval("appmstid") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Details">
                                <ItemTemplate>
                                    <%-- Bind The Product Detail(s)--%>
                                    <span id="tblPrd">
                                        <%#Eval("tbl") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="amount" HeaderText="Amount" />
                            <asp:BoundField DataField="paymentstatus" HeaderText="Status" />
                            <asp:BoundField DataField="doe" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="btn btn-success btn-sm" OnClick="lnkSubmit_Click"
                                        OnClientClick="return ConfirmSubmit();"><i class="fa fa-paper-plane-o"></i>&nbsp;Make Payment</asp:LinkButton>
                                    <asp:LinkButton ID="lnlGetInvoice" runat="server" Visible="false" CssClass="btn btn-default btn-sm"
                                        OnClick="lnlGetInvoice_Click"><i class="fa fa-print"></i>&nbsp;Invoice</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CollectType" HeaderText="Receive Type" />
                            <asp:BoundField DataField="DeliverStatus" HeaderText="Deliver Status" />
                        </Columns>
                    </asp:GridView>
                </div>
            
        </div>
    </div>
    </div>
   
    </section>
</asp:Content>
