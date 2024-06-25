<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="franchisebalancelist.aspx.cs" Inherits="secretadmin_franchisebalancelist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Balance List </h4>
    <div class="row">
                   <div class="col-sm-2">
                    <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" palceholder="User id"></asp:TextBox>
                </div>
              
                <div class="col-sm-2">
                    <asp:TextBox ID="txt_UserName" runat="server" CssClass="form-control" placeholder="User Name"></asp:TextBox>
                </div>
                <div class="col-sm-1 control-label">
                    Status:
                </div>
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                        <asp:ListItem Value="-1" Selected="True">All</asp:ListItem>
                        <asp:ListItem Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">Deactive</asp:ListItem>
                    </asp:DropDownList>
                </div>
               
                <div class="col-sm-1">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                        OnClick="btnSearch_Click" />
                </div>
                </div>
   
   <hr />
                     <div class="table table-responsive">
                   <asp:Panel ID="Panel1" runat="server">
                                    <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover mygrd"
                                        Width="100%" Font-Names="Arial" Font-Size="Small" ForeColor="#333333" PageSize="50"
                                        AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                                        <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr.No">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="True" Height="20px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="FranchiseId" HeaderText="Franchise ID" />
                                            <asp:BoundField DataField="Fname" HeaderText="Franchise Name" />
                                            <asp:BoundField DataField="Dwallet" HeaderText="F-Wallet Bal" />

                                            <asp:BoundField DataField="mobile" HeaderText="Mobile No" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
            </div>
        
    
</asp:Content>
