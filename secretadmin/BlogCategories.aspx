<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="BlogCategories.aspx.cs" Inherits="secretadmin_blog_AllBlogs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <script src="../js/jquery.blockUI.js" type="text/javascript"></script>
    <link href="../../css/modalPopup.css" rel="stylesheet" />
       
    
    <script type = "text/javascript">
       <%-- function BlockUI(elementID) {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_beginRequest(function () {
                $("#" + elementID).block({
                    message: '<table align = "center"><tr><td>' +
                        '<img src="../images/loadingAnim.gif"/></td></tr></table>',
                    css: {},
                    overlayCSS: {
                        backgroundColor: '#000000', opacity: 0.6
                    }
                });
            });
            prm.add_endRequest(function () {
                $("#" + elementID).unblock();
            });
        }
        $(document).ready(function () {

            BlockUI("<%=pnlAddEdit.ClientID %>");
        $.blockUI.defaults.css = {};
    });--%>
        function Hidepopup() {
            $find("popup").hide();
            return false;
        }
        function ValidateFields() {
            if ($("#txtCatName").val().length == 0{
                alert('Category is required');
                return false
            }
            
        }
    </script> 
    <style>
        .ui-widget-content {
            z-index: 100000 !important;
        }

        #Approve {
            background-color: #315787;
            color: white;
        }

        #Cancel {
            background-color: red;
            color: white;
        }
    </style>


    <script type="text/javascript">

        /*function closePopup_Model() { $('#Model_Popup').hide(); }*/


        
    </script>
    <h1 class="fs-20 font-w600  me-auto float-left mb-0">Blog Categories</h1>
    <p></p>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
   
    
            <div class="table-responsive">
                <asp:Button runat="server" Text="New" OnClick="AddEdit_Click" class="btn btn-success btn-sm btn-hasicon pull-left" ToolTip="Add" />
                <div class="btn-group befdv pull-left" style="margin-left:50px;">
            </div>
                 <asp:UpdatePanel runat="server">
        <ContentTemplate>       
        <asp:GridView ID="GridAllBlogs" runat="server" AutoGenerateColumns="False" AllowPaging="true" PageSize="50"
            EmptyDataText="No Data Found." DataKeyNames="catid" CssClass="table table-striped table-hover"
            OnPageIndexChanging="GridAllBlogs_PageIndexChanging">
            <Columns>
                     
              <asp:TemplateField ItemStyle-Width = "30px" HeaderText = "Edit">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkEdit" runat="server" Text = "Edit" OnClick = "AddEdit_Click" ></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="catid" HeaderText="Category ID" />
              <asp:BoundField DataField="catname" HeaderText="Category" />
              <asp:TemplateField HeaderText="Is Active">                   
                  <ItemTemplate>
                     <asp:CheckBox ID="chkActice" runat="server" Checked='<%# Eval("isActive") %>'  Enabled="false"  />
                  </ItemTemplate>
              </asp:TemplateField> 
            </Columns>
        </asp:GridView>
        
    

              
<asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" style = "display:none">
    <h2>Category Details</h2>
    <hr />
<table align = "center">
 <tr>
     <td><asp:HiddenField ID="hiddenID" runat="server" /></td>
 </tr>
<tr>
<td>
<asp:Label ID = "Label2" runat = "server" Text = "Category" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtCatName" runat="server" ClientIDMode="Static"></asp:TextBox>   
</td>
</tr>

<tr>
<td>
<asp:Label ID = "Label3" runat = "server" Text = "isActive" ></asp:Label>
</td>
<td>
<asp:Checkbox ID="chkActive" runat="server"></asp:Checkbox><br />
</td>
</tr>
 <tr><td><br /></td></tr>
<tr>
<td>
<asp:Button ID="btnSave" runat="server" Text="Save" OnClick = "Save_Click" CssClass="btn btn-sm btn-block btn-secondary" OnClientClick="return ValidateFields()" />
</td>
<td>
<asp:Button ID="btnCancel" runat="server"  Text="Cancel" OnClientClick = "return Hidepopup()" CssClass="btn btn-sm btn-danger"/>
</td><br />
</tr>
</table>
    </asp:Panel>
                <asp:LinkButton ID="lnkFake" runat="server"></asp:LinkButton>
<cc1:ModalPopupExtender ID="popup" runat="server" DropShadow="false"
PopupControlID="pnlAddEdit" TargetControlID = "lnkFake"
BackgroundCssClass="modalBackground">
</cc1:ModalPopupExtender>
</ContentTemplate>
<Triggers>
<asp:AsyncPostBackTrigger ControlID = "GridAllBlogs" />
<asp:AsyncPostBackTrigger ControlID = "btnSave" />
</Triggers>
                      
        </asp:UpdatePanel>
    </div>
           

        

</asp:Content>
