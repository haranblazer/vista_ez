<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="download.aspx.cs" Inherits="download" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Downloads</h4>
    </div>
    <div class="table table-responsive">
        <asp:GridView ID="GridView1" CssClass="table table-striped table-hover" runat="server"
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
                        <a href="../images/downloads/<%# Eval("FileName")%>" target="_blank">Download</a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ButtonField ButtonType="Link" Text="Download" CommandName="Dwn" HeaderText="Files" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
