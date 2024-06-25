<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="TotalIn.aspx.cs" Inherits="admin_TotalIn" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        td,
        th {
            padding: 5px 5px;
            border-color: #ddd;
        }
    </style>
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">  <asp:Label ID="lblpname" runat="server"></asp:Label></h4>
   
    <div class="form-group">
        <div class="col-md-7">
            <asp:Label ID="lblCode" runat="server" Font-Bold="True" ForeColor="green"></asp:Label>
            <asp:Label ID="lblNRecord" runat="server" Font-Bold="True" ForeColor="green"></asp:Label>
            <asp:Label ID="lblNoP" runat="server" Font-Bold="True" ForeColor="green"></asp:Label>
        </div>
        <div class="clearfix hidden-lg"></div>
        <div class="col-md-2 col-xs-3">
            
        </div>
        <div class="col-md-1 col-xs-4">
            <%-- <asp:DropDownList 
            ID="ddlPageSize" runat="server" CssClass="form-control" AutoPostBack="True"
            OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
            <asp:ListItem Value="25">25</asp:ListItem>
            <asp:ListItem Value="50">50</asp:ListItem>
            <asp:ListItem Value="100">100</asp:ListItem>
            <asp:ListItem Value="All">All</asp:ListItem>
        </asp:DropDownList>--%>
        </div>
        <div class="col-md-2" style="text-align: right;">

            <asp:ImageButton ID="ImageButton" runat="server" ImageUrl="images/excel.gif"
                Width="25px" OnClick="ImageButton_Click" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg"
                Style="margin-left: 0px" Width="26px" OnClick="imgbtnWord_Click" />
        </div>
    </div>
    <br />
    <div>
        <cc1:PagingGridView ID="GridView1" runat="server" CssClass="table table-striped table-hover" AutoGenerateColumns="true"
            HeaderStyle-BackColor="#546e7a" HeaderStyle-ForeColor="#ffffff">
            <Columns>
                <%--<asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <b>
                            <%#Container.DataItemIndex+1%>
                        </b>
                    </ItemTemplate>
                </asp:TemplateField>
                 
                <asp:BoundField DataField="PId" HeaderText="Prod Code" ItemStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="ProductName" HeaderText="Prod Name" ItemStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="Qty" HeaderText="Quantity" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="BalQty" HeaderText="Balance" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="BatchNo" HeaderText="Batch No" ItemStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="BatchDate" HeaderText="Batch Date" ItemStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="Doe" HeaderText="Date Of Transaction" ItemStyle-HorizontalAlign="Left" />
                <asp:BoundField DataField="Item_Desc" HeaderText="Transaction Type" ItemStyle-HorizontalAlign="Left" />--%>
                
            </Columns>
        </cc1:PagingGridView>
    </div>
</asp:Content>
