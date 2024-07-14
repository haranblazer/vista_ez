<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="BlogComments.aspx.cs" Inherits="secretadmin_blog_AllBlogs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
    <%--<link href="../../css/modalPopup.css" rel="stylesheet" />--%>
       
   
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
    <h1 class="fs-20 font-w600  me-auto float-left mb-0">Blog Comments</h1><br />

    <asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
   
    
            <div class="table-responsive">

               
                 <asp:UpdatePanel runat="server">
        <ContentTemplate>       
        <asp:GridView ID="GridAllBlogs" runat="server" AutoGenerateColumns="False" AllowPaging="true" PageSize="50"
            EmptyDataText="No Data Found." DataKeyNames="blogid" CssClass="table table-striped table-hover"
            OnPageIndexChanging="GridAllBlogs_PageIndexChanging">
            <Columns>
                
               
              

                <asp:HyperLinkField DataNavigateUrlFields="blogid" HeaderText="Title" DataTextField="title"
                    ControlStyle-ForeColor="Blue" DataNavigateUrlFormatString="~/Blog?n={0}" />
                
                
                <asp:BoundField DataField="author" HeaderText="Author" />
                <asp:BoundField DataField="comments" HeaderText="Comments" />
                
                <asp:BoundField DataField="created_dt" HeaderText="Date" />
              
                 <asp:TemplateField HeaderText="Published">                   
                    <ItemTemplate>
                          <asp:CheckBox ID="chkPublished" runat="server" Checked='<%# Eval("published") %>'  Enabled="false"/>
                     </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Is Active">                   
                    <ItemTemplate>
                          <asp:CheckBox ID="chkActice" runat="server" Checked='<%# Eval("isActive") %>'  Enabled="false"/>
                     </ItemTemplate>
                </asp:TemplateField>
               
            </Columns>
        </asp:GridView>
        
        <%-- <div id="popupdiv" title="Basic modal dialog" style="display: none">
            
        </div>--%>

        <div id="Model_Popup" class="modal fade show" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-md modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;PAN Documents</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup_Model()">
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-3 pb-2">User Id </div>
                            <div class="col-sm-9 pb-2">
                                <div id="lblId"></div>
                            </div>

                            <div class="col-sm-3 pb-2">D.O.B</div>
                            <div class="col-sm-9 pb-2">
                                <div id="lblDob"></div>
                            </div>

                            <div class="col-sm-3 pb-2">Pan No</div>
                            <div class="col-sm-9">
                                <div id="lblPan"></div>
                            </div>

                            <div class="col-sm-3 pb-2">Status</div>
                            <div class="col-sm-9">
                                <div id="lblPanStatus" style="width: 100%;"></div>
                            </div>

                            <br />

                            <div class="col-sm-12 pb-2">
                                <div id="lblPanImg" ></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

              
<asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" style = "display:none">
    <asp:Label Font-Bold = "true" ID = "Label4" runat = "server" Text = "Customer Details" ></asp:Label>
<br />
<table align = "center">
<tr>
<td>
<asp:Label ID = "Label1" runat = "server" Text = "CustomerId" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtCustomerID" Width = "40px" MaxLength = "5" runat="server"></asp:TextBox>
</td>
</tr>
<tr>
<td>
<asp:Label ID = "Label2" runat = "server" Text = "Contact Name" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtContactName" runat="server"></asp:TextBox>   
</td>
</tr>
<tr>
<td>
<asp:Label ID = "Label3" runat = "server" Text = "Company" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
</td>
</tr>
<tr>
<td>
<asp:Button ID="btnSave" runat="server" Text="Save" OnClick = "Save_Click" />
</td>
<td>
<asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick = "return Hidepopup()"/>
</td>
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
