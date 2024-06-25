<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="AddEditPackSize.aspx.cs" Inherits="d2000admin_AddEditPackSize"  EnableEventValidation="false"%>
<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls" 
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  

     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add / Edit Pack Size </h4>					
				</div>


<div id="tblBrandList" runat="server">
<div runat="server" id="search">

             <div class="form-group row">
             <div  class="col-sm-1 control-label">
             Size :
             </div>        
            <div class="col-sm-2">
            <asp:TextBox ID="txtPackSize" runat="server" ValidationGroup="cs"  MaxLength="50"
                               CssClass="form-control"></asp:TextBox>
            </div>
         
            <div class="col-sm-2">
            <asp:Button ID="btnSubmit" runat="server" Text="Add"   OnClick="btnSubmit_Click"
                                ValidationGroup="cs" CssClass="btn btn-primary" />
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                                ValidationGroup="cs" CssClass="btn btn-primary" />
            </div>
            

                 
            <div class="col-sm-2 ">
            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Value="0">Active</asp:ListItem>
                                <asp:ListItem Value="1">In Active</asp:ListItem>
                            </asp:DropDownList>
            </div>
                
            <div class="col-sm-1">
           <asp:Button ID="btnShowAll" runat="server" Text="Show All" 
                                OnClick="btnShowAll_Click" CssClass="btn btn-primary" />
            </div>

                   
            <div class="col-sm-2 ">
           <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                            <asp:ListItem Value="25">25</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>
                            <asp:ListItem>All</asp:ListItem>
                        </asp:DropDownList>


           
            </div>
            <div class="clearfix"></div> 
          
            <div class="col-md-12">
            <div class="pull-right">
            <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="~/secretadmin/images/excel.gif"
                                OnClick="ibtnExcelExport_Click" />
                            <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="~/secretadmin/images/word.jpg"
                                OnClick="ibtnWordExport_Click" />
                                <%--<asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="images/pdf.gif" 
                        OnClick="imgbtnpdf_Click" />--%>
            </div>
            </div>  

 <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="False" 
                                Font-Names="Arial"></asp:Label>
<div class="clearfix"></div>
 <div style="overflow:auto;">
<cc1:PagingGridView ID="GridView1" OnRowDataBound="GridView1_RowDataBound" EmptyDataText="No Data Found !" CssClass="table table-striped table-hover"
                    runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowCommand="GridView1_RowCommand" OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowUpdating="GridView1_RowUpdating">
                    <Columns>
                    <asp:CommandField ShowEditButton="True" CancelText="Cancel" EditText="Edit" UpdateText="Update" />
                      <%--  <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Pack Size Unit Id">
                            <ItemTemplate>
                                <asp:Label ID="lblId" runat="server" Text='<%# Eval("srno") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="PackSize" DataField="PackSize"></asp:BoundField>
                        <asp:BoundField DataField="doe" HeaderText="Date" ReadOnly="True"></asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" />
                            </ItemTemplate>
                            <ItemStyle />
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnStatus" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" onclientclick="return confirm('Are you sure?')" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                   
                 </cc1:PagingGridView>
                 </div>

                  <div class="col-sm-12">
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPackSize"
                    ErrorMessage="Please Enter 50 Character Pack Size !" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000"
                    ValidationGroup="cs" Display="None"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server"
                    ControlToValidate="txtPackSize" Display="None" ErrorMessage="Only Alpha Numeric Value With . Is Allowed!"
                    ForeColor="#C00000" ValidationExpression="^[0-9a-zA-Z.]*" Width="336px" Font-Names="Arial"
                    Font-Size="10pt" ValidationGroup="cs">Only Alpha Numeric Value With . Is Allowed!</asp:RegularExpressionValidator>
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="cs" Width="438px" />

                    </div>
</div>

  
    
    
   </div>
     </div>
  </asp:Content>