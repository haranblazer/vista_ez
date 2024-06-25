<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true"
    CodeFile="franballist.aspx.cs" Inherits="secretadmin_franballist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<h2 class="head"><i class="fa fa-plus-circle" aria-hidden="true"></i>  Unit Wallet  Balance List </h2>    
    
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <div class="col-sm-1">
            <strong>User id:</strong>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-sm-2 downlist">
            <strong>User Name:</strong>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_UserName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-sm-1 downlist">
            <strong>Status:</strong> 
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1" Selected="True">All</asp:ListItem>
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="0">Deactive</asp:ListItem>  
            </asp:DropDownList>
        </div>
        <br class="hidden-lg" />
         <div class="col-sm-1 downlist">
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnSearch_Click" />
        </div>
    </div>
    
    <div class="clearfix">
    </div>
 <hr />
    <div class="table table-responsive">
        <table width="100%">
            <tr>
                <td align="center" style="text-align: left; font-size: 9.8px;" valign="top">
                    <asp:Panel ID="Panel1" runat="server">
                        <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover mygrd"
                            Width="100%" Font-Names="Arial" Font-Size="Small" ForeColor="#333333" PageSize="50"
                            AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                            <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %></ItemTemplate>
                                    <ItemStyle Font-Bold="True" Height="20px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="FranchiseId" HeaderText="Franchise ID" />
                                <asp:BoundField DataField="Fname" HeaderText="Franchise Name" />
                                <asp:BoundField DataField="Dwallet" HeaderText="Unit Wallet Bal" />
                                
                                 <asp:BoundField DataField="mobile" HeaderText="Mobile No" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
