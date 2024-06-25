<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="compliance_documents.aspx.cs" Inherits="compliance_documents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list">
                <li class="breadcrumb-item"><a href="default">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Downloads</a></li>
            </ol>
        </div>
    </div>
    <div class="section section-padding pt-4 mb-4">
        <div class="container-fluid">
            <div class="table table-responsive">
                <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped table-hover" runat="server"
                    AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No.">
                            <ItemTemplate>
                                <asp:Label ID="lblserial" Text='<%# Container.DataItemIndex + 1%>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:TemplateField HeaderText="Download">
                            <ItemTemplate>
                                <a href="images/downloads/<%# Eval("FileName")%>" target="_blank">Download</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="FileName" HeaderText="File Name" />
                        <asp:ButtonField ButtonType="Link" Text="Download" CommandName="Dwn" HeaderText="Files" />--%>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <style>
        table th {
            background-color: #fe6a00;
            color: #fff;
        }
    </style>
</asp:Content>
