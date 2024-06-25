<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="BDMDashboardDetails.aspx.cs" Inherits="secretadmin_BDMDashboardDetails" %>


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
                <%--<div class="col-sm-1">
                    <a href="welcome.aspx" class="btn btn-success">Dashboard</a>
                </div>--%>

              <div class="clearfix"></div>  
                <div class="row">
                    <div class="table-responsive">
                        <asp:GridView ID="Grid_RPV" runat="server" AllowPaging="false" CellPadding="1" CssClass="table table-striped table-hover mygrd"
                            AutoGenerateColumns="false" ShowFooter="true" FooterStyle-ForeColor="Red" EmptyDataText="No Record Found." EmptyDataRowStyle-ForeColor="Red">
                            <Columns>

                                <asp:TemplateField HeaderText="Invoice No">
                                    <ItemTemplate><%#Eval("[Invoice No]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Invoice Date">
                                    <ItemTemplate><%#Eval("[Date]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Seller UserId">
                                    <ItemTemplate><%#Eval("[Seller UserId]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Seller Name">
                                    <ItemTemplate><%#Eval("[Seller Name]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Seller State">
                                    <ItemTemplate><%#Eval("[Seller State]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Seller District">
                                    <ItemTemplate><%#Eval("[Seller District]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Buyer UserId">
                                    <ItemTemplate><%#Eval("[Buyer UserId]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Buyer Name">
                                    <ItemTemplate><%#Eval("[Buyer Name]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Buyer Mobile No">
                                    <ItemTemplate><%#Eval("[Buyer Mobile No]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Amount">
                                    <ItemTemplate><%#Eval("[Total Amount]") %> </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="DP Amount">
                                    <ItemTemplate><%#Eval("[DP Amount]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Normal PV">
                                    <ItemTemplate><%#Eval("[Normal PV]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Topper PV">
                                    <ItemTemplate><%#Eval("[Topper PV]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sponsor ID">
                                    <ItemTemplate><%#Eval("[Sponsor ID]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sponsor Name">
                                    <ItemTemplate><%#Eval("[Sponsor Name]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Reference Id">
                                    <ItemTemplate><%#Eval("[Reference Id]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Reference Name">
                                    <ItemTemplate><%#Eval("[Reference Name]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tax / Sales Invoive">
                                    <ItemTemplate><%#Eval("[Tax / Sales Invoive]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Billing Type">
                                    <ItemTemplate><%#Eval("[Billing Type]") %> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Invoice Status">
                                    <ItemTemplate><%#Eval("[Invoice Status]") %> </ItemTemplate>
                                </asp:TemplateField>
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
