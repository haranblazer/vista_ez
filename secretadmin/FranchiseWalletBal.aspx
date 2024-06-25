<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="FranchiseWalletBal.aspx.cs" Inherits="secretadmin_FranchiseWalletBal" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Franchise Wallet Balances</h4>					
				</div>
  
        <div class="col-sm-2 col-xs-6 text-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif" OnClick="imgbtnExcel_Click" />
        </div>
       

        <div class="table-responsive">

            <asp:GridView ID="GridView1" EmptyDataText="No record found" runat="server" AutoGenerateColumns="false" CellPadding="4"
                CellSpacing="1" CssClass="table table-striped table-hover" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="SNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UserId" HeaderText="UserId" />
                    <asp:BoundField DataField="UserName" HeaderText="UserName" />
                    <asp:BoundField DataField="F_Wallet" HeaderText="F_Wallet" />
                    <asp:BoundField DataField="OD_Wallet" HeaderText="OD_Wallet" />
                    <asp:BoundField DataField="F_OD_Bal" HeaderText="Net Balance(F-OD)" />
                    
                </Columns>
            </asp:GridView>

        </div>
      
     
</asp:Content>


