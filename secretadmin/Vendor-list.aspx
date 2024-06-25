<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="Vendor-list.aspx.cs" Inherits="secretadmin_Vendor_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dotGreen
        {
            height: 25px;
            width: 25px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }
        .dotGrey
        {
            height: 25px;
            width: 25px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>
    <h2 class="head">
        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;All Vendor</h2>
    <div class="clearfix">
    </div>
    <div class="panel panel-default" style="padding-top:10px;">
        <div class="table-responsive">
            <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="VID"
                CssClass="table table-striped table-hover mygrd" runat="server" AutoGenerateColumns="False"
                AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowEditing="GridView1_RowEditing">
                <Columns>
                    <asp:TemplateField HeaderText="SNo">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Vendor Name" DataField="ComName" ReadOnly="True" />
                    <asp:BoundField HeaderText="Company Name" DataField="DisplayName" ReadOnly="True" />
                    <asp:BoundField HeaderText="Email" DataField="V_Email" ReadOnly="True" />
                    <asp:BoundField HeaderText="Work Phone" DataField="Phone" ReadOnly="True" />
                    <asp:BoundField HeaderText="GST Treatment" DataField="GSTNAME" ReadOnly="True" />
                    <asp:BoundField HeaderText="Payables" DataField="PAYABLES" ReadOnly="True" />
                </Columns>
            </asp:GridView>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>
