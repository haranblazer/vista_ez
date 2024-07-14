<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="downstatusInv2.aspx.cs" Inherits="User_downstatusInv" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="site-content">
        <div class="panel panel-default">
          <div>
        
            <h2>
             &nbsp;   <asp:Label ID="lblpname" runat="server"></asp:Label>
            </h2>
            <br />
            
           </div>
            <div>
                <div class="col-sm-2">
                    <asp:Label ID="lblNRecord" runat="server" Font-Bold="True"></asp:Label>
                </div>
            </div>
             <div>
                <div class="col-sm-2">
                    <asp:Label ID="lblnoofinv" runat="server" Font-Bold="True"></asp:Label>
                </div>
            </div>
            <div>
                <div class="col-sm-4">
                    <asp:Label ID="lblNoP" runat="server" Font-Bold="True"></asp:Label>
                </div>
            </div>
            <div>
                <label for="MainContent_txtPassword" class="col-sm-2 control-label">
                    Page Size:</label>
                <div class="col-sm-1">
                    <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged"
                        CssClass="form-control" Width="70px">
                        <asp:ListItem Value="25">25</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                        <asp:ListItem Value="All">All</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="table-responsive">
                <cc1:PagingGridView ID="GridView1" AutoGenerateColumns="false" runat="server" runat="server"
                    AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="25"
                    Width="100%" CssClass="table table-striped table-hover mygrd">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <b>
                                    <%#Container.DataItemIndex+1%>
                                </b>
                            </ItemTemplate>
                        </asp:TemplateField>
                          <asp:HyperLinkField DataTextField="InvoiceNo" HeaderText="Invoice No." DataNavigateUrlFields="srno,status"
                        Text="Print" DataNavigateUrlFormatString="GSTBill.aspx?id={0}&st={1}" ControlStyle-ForeColor="Blue"/>
                       <%-- <asp:TemplateField HeaderText="InvoiceNo">
                            <ItemTemplate>
                                <%#Eval("InvoiceNo")%>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <%#Eval("doe")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <%#Eval("Quantity")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <%#Eval("Amount")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <%#Eval("CV")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </cc1:PagingGridView>
            </div>
        </div>
    </div>
</asp:Content>
