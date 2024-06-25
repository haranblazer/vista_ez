<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="TotalOut.aspx.cs" Inherits="admin_TotalOut" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <script type="text/javascript">

      function SetTarget() {
          document.forms[0].target = "_blank";
      }
    </script>
<h4 class="head" style="color: #fff;">
             <i class="fa fa-image-o"></i>&nbsp;Total Out
        </h4>

   <div class="panel panel-default">
            <div class="col-sm-12">
          
        <h2>
            <asp:Label ID="lblpname" runat="server" Font-Bold="True"></asp:Label>
        </h2>
        <br />
    
    <div>
        <div class="col-sm-2">
            <asp:Label ID="lblCode" runat="server" Font-Bold="True"></asp:Label>
        </div>
    </div>
    <div>
        <div class="col-sm-2">
            <asp:Label ID="lblNRecord" runat="server" Font-Bold="True"></asp:Label>
        </div>
    </div>
    <div>
        <div class="col-sm-3">
             <asp:Label ID="lblNoP" runat="server" Font-Bold="True"></asp:Label>
        </div>
    </div>
   
    <div>
        <label for="MainContent_txtPassword" class="col-sm-2 control-label">
            Page Size:</label>
        <div class="col-sm-1">
            <asp:DropDownList 
            ID="ddlPageSize" runat="server" AutoPostBack="True" 
            OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" CssClass="form-control" Width="70px">
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


    <%--<div>
        <asp:Label ID="lblCode" runat="server" Font-Bold="True"></asp:Label>
        <asp:Label ID="lblNRecord" runat="server" Font-Bold="True"></asp:Label>
        <asp:Label ID="lblNoP" runat="server" Font-Bold="True"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Page Size:</strong><asp:DropDownList 
            ID="ddlPageSize" runat="server" AutoPostBack="True" 
            OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
            <asp:ListItem Value="25">25</asp:ListItem>
            <asp:ListItem Value="50">50</asp:ListItem>
            <asp:ListItem Value="100">100</asp:ListItem>
            <asp:ListItem Value="All">All</asp:ListItem>
        </asp:DropDownList>
    </div>--%>




    <div class="table-responsive">
        <cc1:PagingGridView ID="GridView1" 
            CssClass="table table-striped table-hover mygrd" AutoGenerateColumns="false" 
            runat="server" AllowPaging="True" DataKeyNames="pid,soldto,soldToFlag,soldbyFlag"
            onpageindexchanging="GridView1_PageIndexChanging" PageSize="25" 
            onrowcommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <b>
                            <%#Container.DataItemIndex+1%>
                        </b>
                    </ItemTemplate>
                </asp:TemplateField>

               <%-- <asp:TemplateField HeaderText="Invoice No">
                    <ItemTemplate>
                        <b>
                              <%#Eval("invoiceno")%> 
                        </b>
                    </ItemTemplate>
                </asp:TemplateField>--%>

                <asp:TemplateField HeaderText="Sold To">
                    <ItemTemplate>
                        <%#Eval("soldto")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sellby">
                    <ItemTemplate>
                        <%#Eval("sellby")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                     <asp:LinkButton ID="lblOUTBill" CommandName="OUTBill" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                                Text='<%# Eval("totalout")%>' runat="server"></asp:LinkButton>
                       
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
    </div>
    <div class="clearfix"></div>
    </div>
</asp:Content>
