<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="DashboardInvDetails.aspx.cs" Inherits="secretadmin_DashboardInvDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="head">
        <i class="fa fa-list" aria-hidden="true"></i>&nbsp;
        <asp:Label ID="lbl_ReportName" runat="server"></asp:Label>
        Report
    </h2>
    <div class="panel panel-default">
        <div class="col-md-12">
            <div class="form-group">

                <div class="col-sm-11"></div>
                <div class="col-sm-1 text-right">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />
                </div>
                <%-- <div class="col-sm-2">
                    <a href="javascript:history.back()">Babk</a> ||
                    <a href="welcome.aspx" >Dashboard</a>
                </div>--%>

                <div class="clearfix"></div>
                <div class="row">
                    <div class="table-responsive">
                        <div class="clearfix"></div>
                        <hr />
                        <center>
                            <h3>
                                <asp:Label ID="lbl_State" runat="server"></asp:Label>
                            </h3>
                        </center>
                         

                        <asp:GridView ID="Grid_InvDetails" runat="server" AllowPaging="false" CellPadding="1" 
                            CssClass="table table-striped table-hover" PageSize="50" Width="100%" 
                            OnPageIndexChanging="GridView1_PageIndexChanging"
                            AutoGenerateColumns="false" ShowFooter="true" FooterStyle-Font-Bold="true"
                            EmptyDataText="No Record Found." EmptyDataRowStyle-ForeColor="Red">
                            <Columns>

                                <asp:TemplateField HeaderText="Invoice No">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("[Invoice No]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Invoice Date">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%#Eval("[Invoice Date]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Seller UserId">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("[Seller UserId]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Seller Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%#Eval("[Seller Name]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Buyer UserId">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%#Eval("[Buyer UserId]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Buyer Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%#Eval("[Buyer Name]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Buyer District">
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%#Eval("[Buyer District]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Buyer State">
                                    <ItemTemplate>
                                        <asp:Label ID="Label8" runat="server" Text='<%#Eval("[Buyer State]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                                <asp:BoundField HeaderText="Billed Qty." DataField="Billed_Qty" />

                                <asp:TemplateField HeaderText="Total Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="Label9" runat="server" Text='<%#Eval("[Total Amount]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="RPV">
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" runat="server" Text='<%#Eval("[RPV]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TPV">
                                    <ItemTemplate>
                                        <asp:Label ID="Label11" runat="server" Text='<%#Eval("[TPV]") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Payment Mode" DataField="PayMode" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>

