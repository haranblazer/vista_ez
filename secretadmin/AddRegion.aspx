<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AddRegion.aspx.cs" 
    EnableEventValidation="false" Inherits="secretadmin_AddRegion" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add Region </h4>					
				</div>


    
   
        <div class="row">
           
            <div class="col-sm-3">
                <asp:TextBox ID="txtAddRegion" runat="server" CssClass="form-control" Placeholder="Enter Region Name"></asp:TextBox>
                
               
                
            </div>

             

            <div class="col-sm-1">
                <asp:Button ID="btnAddRegion" runat="server" Text="ADD" CssClass="btn btn-primary"
                    Style="float: right" OnClick="btnAddRegion_Click" />
            </div>
        </div>



      
        <div class=" table-responsive">
            <asp:GridView ID="GridRegion" runat="server" CssClass="table table-striped table-hover mygrd"
                PageSize="50" AutoGenerateColumns="false" Width="100%" DataKeyNames="Rid, Region" EmptyDataText="No Record Found."
                OnRowCommand="GridRegion_RowCommand" OnRowUpdated="GridRegion_RowUpdated">
                <Columns>
                    <asp:TemplateField HeaderText="Sr No.">
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField> 
                    <asp:BoundField DataField="Region" HeaderText="Region" /> 
                    <asp:TemplateField HeaderText="IsActive" ItemStyle-HorizontalAlign="Center">
                       <ItemTemplate>
                           <asp:LinkButton ID="lnkIsRedeem" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                               CommandName="Isactive">  <%# Eval("Isactive").ToString() == "1"? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%> </asp:LinkButton>
                       </ItemTemplate>
                   </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:HiddenField ID="hnd_Region" runat="server" Value='<%# Bind ("Region") %>' />
                            <asp:LinkButton ID="lnkEdit" runat="server"  
                               CssClass="fa fa-edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" 
                                CommandName="Edits"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>


       
</asp:Content>

