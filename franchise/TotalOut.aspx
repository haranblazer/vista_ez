<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="TotalOut.aspx.cs" Inherits="admin_TotalOut" %>

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

    <h2 class="head">
        <i class="fa fa-list" aria-hidden="true"></i>&nbsp;Transaction Summary Report of  <%=ProductName%>
        <div class="pull-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="ImageButton_Click" Width="25px" />
        </div>
    </h2>

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
        </div>

    </div>
    <br />
    <div>

        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CellPadding="1" CssClass="table table-striped table-hover" AutoGenerateColumns="false"
            Font-Names="Arial" Font-Size="Small" PageSize="500" EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="SNo">
                    <ItemTemplate>
                        <b>
                            <%#Container.DataItemIndex+1%>
                        </b>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Invoice No">
                    <ItemTemplate>
                        <%#Eval("[Invoice No]")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Seller ID">
                    <ItemTemplate>
                        <%#Eval("[Seller ID]")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Seller Name">
                    <ItemTemplate>
                        <%#Eval("[Seller Name]")%>
                    </ItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Buyer ID">
                    <ItemTemplate>
                        <%#Eval("[Buyer ID]")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Buyer Name">
                    <ItemTemplate>
                        <%#Eval("[Buyer Name]")%>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Batch No">
                    <ItemTemplate>
                        <%#Eval("[Batch No]")%>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Mfg">
                    <ItemTemplate>
                        <%#Eval("[Mfg]")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Expiry">
                    <ItemTemplate>
                        <%#Eval("[Expiry]")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Date Of Transaction">
                    <ItemTemplate>
                        <%#Eval("[Date Of Transaction]")%>
                    </ItemTemplate>
                </asp:TemplateField>



                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <%#Eval("[Quantity]")%>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="DP Rate">
                    <ItemTemplate>
                        <%#Eval("[DP Rate]")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="DP With Tax">
                    <ItemTemplate>
                        <%#Eval("[DP With Tax]")%>
                    </ItemTemplate>

                </asp:TemplateField>

                <asp:TemplateField HeaderText="RPV">
                    <ItemTemplate>
                        <%#Eval("[RPV]")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="TPV">
                    <ItemTemplate>
                        <%#Eval("[TPV]")%>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Transaction Type">
                    <ItemTemplate>
                        <%#Eval("[Transaction Type]")%>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>

    </div>
</asp:Content>
