<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
 CodeFile="TotalCancel.aspx.cs" Inherits="franchise_TotalCancel" %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <style>
    td,
    th {
      padding:5px 5px; border-color:#ddd; }
 </style>    
    <div>
      <h2 class="head"><i class="fa fa-eercast" aria-hidden="true"></i>
            <asp:Label ID="lblpname" runat="server"></asp:Label>
      </h2>
    </div><br /><br />
   <div class="form-group">
        <div class="col-md-7">
        <asp:Label ID="lblCode" runat="server" Font-Bold="True" ForeColor="green"></asp:Label>
        <asp:Label ID="lblNRecord" runat="server" Font-Bold="True" ForeColor="green"></asp:Label>
        <asp:Label ID="lblNoP" runat="server" Font-Bold="True" ForeColor="green"></asp:Label>
        </div>
        <div class="clearfix hidden-lg"></div>
        <div class="col-md-2 col-xs-3"><strong>Page Size:</strong>
    </div>
    <div class="col-md-1 col-xs-4">
    <asp:DropDownList ID="ddlPageSize" CssClass="form-control" runat="server" AutoPostBack="True"
            OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
            <asp:ListItem Value="25">25</asp:ListItem>
            <asp:ListItem Value="50">50</asp:ListItem>
            <asp:ListItem Value="100">100</asp:ListItem>
            <asp:ListItem Value="All">All</asp:ListItem>
        </asp:DropDownList>
    </div>
        <div class="col-md-2" style="text-align: right;">
            <asp:ImageButton ID="ImageButton" runat="server" ImageUrl="images/excel.gif" 
                Width="25px" onclick="ImageButton_Click"/>
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" 
                Style="margin-left: 0px" Width="26px" onclick="imgbtnWord_Click" />
    </div></div>
    <br />
   
        <cc1:PagingGridView ID="GridView1" CssClass="table table-striped table-hover" AutoGenerateColumns="false" 
            runat="server" AllowPaging="True" HeaderStyle-BackColor="#546e7a" HeaderStyle-ForeColor="#ffffff"
            onpageindexchanging="GridView1_PageIndexChanging" PageSize="25">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <b>
                            <%#Container.DataItemIndex+1%>
                        </b>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="To">
                    <ItemTemplate>
                        <%#Eval("sellby")%>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="by">
                    <ItemTemplate>
                        <%#Eval("soldto")%>
                    </ItemTemplate>
                </asp:TemplateField>
            
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <%#Eval("canqty")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date Of Transaction">
                    <ItemTemplate>
                        <%#Eval("doe")%>
                    </ItemTemplate>
                </asp:TemplateField>
                
            </Columns>
        </cc1:PagingGridView>
    </div>
</asp:Content>

