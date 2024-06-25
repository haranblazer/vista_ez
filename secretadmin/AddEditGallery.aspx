<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="AddEditGallery.aspx.cs" Inherits="admin_AddEditGallery" EnableEventValidation="false" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function DeleteImage() {
            if (confirm("Are you sure want to delete this Gallery?") == true) {
                return true;
            }
            else {
                return false;
            }

        }
    </script>
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Add/Edit Gallery</h4>
   <div class="row">
                   <div class="col-sm-1  control-label">
            Title :<span style="color: Red">*</span>
        </div>
        <div class="col-sm-3 ">
            <asp:TextBox ID="txtTitle" runat="server" ValidationGroup="cs" CssClass="form-control"
                placeholder="Please Enter Gallery Title" MaxLength="50"></asp:TextBox>
          
        </div>
        <div class="col-sm-1">
            <button id="btnSubmit" runat="server" class="btn btn-primary" validationgroup="cs"
                title="Add" onserverclick="btnSubmit_Click">
                Save
            </button>
            </div>
             <div class="col-sm-1">
            <button id="btnSearch" runat="server" class="btn btn-primary" validationgroup="cs"
                title="Search" onserverclick="btnSearch_Click">
                Search
            </button>
           
          
        </div>
        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server" AutoPostBack="True"
                OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                <asp:ListItem Value="0">Active</asp:ListItem>
                <asp:ListItem Value="1">In Active</asp:ListItem>
            </asp:DropDownList>
            
            
        </div>
        <div class="col-sm-2">
            <button id="btnShowAll" runat="server" class="btn btn-primary" title="Show All" onserverclick="btnShowAll_Click">
                Show All
            </button>
        </div>
        <div class="pull-right col-sm-2">
        <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
            OnClick="ibtnExcelExport_Click" />
        <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
    </div>
                </div>
   <hr />
    <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="false" Font-Names="Arial"></asp:Label>
    <div class="table-responsive">
        <cc1:PagingGridView ID="GridView1" DataKeyNames="TitleId" OnRowDataBound="GridView1_RowDataBound"
            EmptyDataText="Record not found !" runat="server" CssClass="table table-striped table-hover"
            AutoGenerateColumns="False" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging"
            OnRowCommand="GridView1_RowCommand" OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit"
            OnRowUpdating="GridView1_RowUpdating">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Title" DataField="Title"></asp:BoundField>
                <asp:BoundField DataField="doe" HeaderText="Date" ReadOnly="True"></asp:BoundField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Image ID="imgStatus" runat="server" />
                    </ItemTemplate>
                    <ItemStyle />
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" HeaderText="Action" CancelText="Cancel" EditText="Edit"
                    UpdateText="Update" ControlStyle-CssClass="btn btn-success"/>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnStatus" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <i class="fa fa-picture-o" aria-hidden="true"></i>&nbsp;<asp:LinkButton ID="lnkbtnViewAddEdit"
                            CommandName="ViewAddEdit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            Text="View/Add/Edit Photo" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <i class="fa fa-trash"></i>&nbsp;<asp:LinkButton ID="lnkDelete" CommandName="Del"
                            CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Delete" runat="server"
                            OnClientClick="return DeleteImage();" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </cc1:PagingGridView>
        <asp:RequiredFieldValidator ID="rfvGalleryTitle" runat="server" ControlToValidate="txtTitle"
            SetFocusOnError="true" ErrorMessage="Please Enter Gallery Title !" Font-Names="Arial"
            Font-Size="10pt" ForeColor="#C00000" ValidationGroup="cs" Display="None" />
        <br />
        <asp:ValidationSummary ID="Validation" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="cs" HeaderText="Correct the following errors..." />
    </div>
    
  
</asp:Content>
