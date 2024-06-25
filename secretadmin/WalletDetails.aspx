<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="WalletDetails.aspx.cs" Inherits="secretadmin_WalletDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="head">
        <i class="fa fa-hand-o-right" aria-hidden="true"></i>&nbsp;
        <asp:Label ID="lbl_Header" runat="server"></asp:Label>
    </h1>
    <div class="panel panel-default">
        <div class="clearfix"></div>
        <br />
        <div class="col-md-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Enter Id."></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-success" />
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-2 text-right">
            <a href="TotalBalance.aspx">Company Balance List</a>
        </div>
        <div class="col-sm-2 col-xs-6 text-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif" OnClick="imgbtnExcel_Click" />
        </div>
        <div class="clearfix"></div>
        <br />

        <div class="table-responsive">
            <asp:GridView ID="GridView1" EmptyDataText="No record found" runat="server" CellPadding="4" CellSpacing="1"
                AutoGenerateColumns="false" CssClass="table table-striped table-hover" Width="100%" ShowFooter="true" FooterStyle-Font-Bold="true">
                <Columns>
                    <asp:TemplateField HeaderText="SNo">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Date" HeaderText="Date" />
                    <asp:BoundField DataField="UserId" HeaderText="User Id" />
                    <asp:BoundField DataField="UserName" HeaderText="User Name" />
                    <asp:BoundField DataField="Balance" HeaderText="Amount" />
                    <asp:BoundField DataField="Reason" HeaderText="Remarks" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="clearfix">
        </div>
        <br />
    </div>

</asp:Content>

