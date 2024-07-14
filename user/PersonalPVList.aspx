﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="PersonalPVList.aspx.cs" Inherits="User_PersonalPVList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="site-content">

        <div class="panel-heading">
                 <i class="fa fa-user" aria-hidden="true"></i>&nbsp; Personal CV
            </div>

 <div id="main-container" style="background-color: #fff">  
    <br />

        <div class="table-responsive"> 
    <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
        Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
        EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="False"
        OnPageIndexChanging="dglst_PageIndexChanging">
        <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="Sr.No">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %></ItemTemplate>
                <ItemStyle Font-Bold="True" Height="20px" />
            </asp:TemplateField>
            <asp:BoundField DataField="InvoiceNo" HeaderText="InvoiceNo" />
            <asp:BoundField DataField="Amount" HeaderText="Invoice Amount" />
            <asp:BoundField DataField="TotalBV" HeaderText="Total CV"/>
            <asp:BoundField DataField="doe" HeaderText="Date" />
         <%--   <asp:BoundField DataField="appmstlefttotal" HeaderText="Paid Left" />
            <asp:BoundField DataField="appmstrighttotal" HeaderText="Paid Right" />


             <asp:BoundField DataField="templefttotal" HeaderText="Associates in Group A" />
            <asp:BoundField DataField="temprighttotal" HeaderText="Associates in Group B" />--%>
           <%-- <asp:BoundField DataField="pbvamt" HeaderText="PRP" />
            <asp:BoundField DataField="gbvamt" HeaderText="GRP" />--%>
          
        </Columns>
    </asp:GridView>
    </div>
    </div>
</div>
</asp:Content>
