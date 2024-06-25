<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="LoyaltyDetails.aspx.cs" Inherits="secretadmin_RoyaltyDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div>
        <h2 class="head">
            <i class="fa fa-list" aria-hidden="true"></i>&nbsp;Legwise Loyalty Report
            <div class="pull-right text-right">
                <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="20px" />
            </div>
        </h2>
        <div class="panel panel-default">
            <br />

            <div class="clearfix"></div>
            <hr />

            <div class="table-responsive">

                <asp:GridView ID="GridView1" runat="server" CellPadding="4" CssClass="table table-striped table-hover"
                    Font-Names="Arial" Font-Size="Small" AutoGenerateColumns="False"
                    EmptyDataText="No Record Found." ShowFooter="true" FooterStyle-Font-Bold="true">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate>
                                <asp:Label ID="lblUser" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="UserId" DataField="UserId" />
                        <asp:BoundField HeaderText="User Name" DataField="UserName" />
                        <asp:BoundField HeaderText="District" DataField="District" />
                        <asp:BoundField HeaderText="State" DataField="State" />
                        <asp:BoundField HeaderText="Mobile No" DataField="MobileNo" />
                        <asp:BoundField HeaderText="Invoice No" DataField="InvoiceNo" />
                        <asp:BoundField HeaderText="Invoice Value" DataField="RPV" />
                        <asp:BoundField HeaderText="Date" DataField="MonthName" />
                    </Columns>
                </asp:GridView>
            </div>

            <div class="clearfix"></div>
        </div>
</asp:Content>

