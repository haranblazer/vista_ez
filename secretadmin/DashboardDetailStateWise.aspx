<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="DashboardDetailStateWise.aspx.cs" Inherits="secretadmin_DashboardDetailStateWise" %>

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
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"/>
                </div>
               <%-- <div class="col-sm-1">
                    <a href="welcome.aspx">Dashboard</a>
                </div>--%>

                <div class="clearfix"></div><hr />
                <div class="row">
                    <div class="table-responsive">

                        <asp:GridView ID="Grid_State" runat="server" AllowPaging="false" CellPadding="1" CssClass="table table-striped table-hover mygrd"
                            AutoGenerateColumns="false" ShowFooter="true" FooterStyle-ForeColor="Green" EmptyDataText="No Record Found." EmptyDataRowStyle-ForeColor="Red"
                            OnRowCommand="Grid_State_RowCommand" DataKeyNames="Seller_State">
                            <Columns>
                                <asp:TemplateField HeaderText="Seller State">
                                    <ItemTemplate><%#Eval("[Seller_State]") %> </ItemTemplate>
                                </asp:TemplateField> 
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkAmount" Text='<%#Eval("[Secondary_Sales]") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                            CommandName="State" runat="server" Style="text-align: center; color: Blue;" />
                                    </ItemTemplate>
                                </asp:TemplateField>


                            </Columns>
                        </asp:GridView>
                        <div class="clearfix"></div>
                        <hr />
                     
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>

