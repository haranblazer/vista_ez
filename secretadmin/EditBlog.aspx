<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" ValidateRequest="false"
    AutoEventWireup="true" CodeFile="EditBlog.aspx.cs" Inherits="secretadmin_blog_AllBlogs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
    
   
 

    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" rel="stylesheet"/>
<%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">--%>


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


    
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Add/Edit Blogs</h4>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>

    <script type="text/javascript">
        function CheckUploadFile() {
            var file = document.querySelector('#<%=imgUpload.ClientID %>').files[0];
            if (file.size > 512000) {
                alert("File size must be less than equal to 500 KB. Please reduce your file size then upload.");
                var uploadControl = document.getElementById('<%=imgUpload.ClientID%>');
                uploadControl.value = "";
                return false;
                file.focus();
            }
            else {
                return true;
            }
        }
       
        function ValidateFields() {
           
            console.log($('#<%=imgUpload.ClientID %>').val().length);
            //return false;
            if($('#<%=title.ClientID %>').val().length == 0) {
                alert('Title is required');
                return false;
            }
            if ($('#<%=description.ClientID %>').val().length == 0) {
                alert('Description is required');
                return false;
            }
    
        }
    </script>
   
    
            <div class="table-responsive">
                <div class="row">
                <div class="col-md-10">
                <asp:TextBox id="title" runat="server" autocomplete="off" placeholder="Blog Title..." CssClass="form-control" ClientIDMode="Static" />
                <asp:TextBox id="description" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="2" placeholder="Blog Description"/>
                <div id="div_Product1" runat="server" visible="true" class="col-sm-8">
                    Upload Blog Image :<br />
                    <asp:FileUpload ID="imgUpload" runat="server" ForeColor="Black" onchange="CheckUploadFile();" accept=".png,.jpg,.jpeg,.gif"  />
                    <asp:Label ID="imgFileName" runat="server" /><br />
                    <span style="color: Red">Note: &nbsp; Image size must be width 400px and height 525px and File Size must be less than 500 KB.<br />
                    Only .jpg/.jpeg/.png/.gif file types are allowed.
                    Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>
                </span>
                </div>
                
                <asp:TextBox id="content" runat="server" placeholder="content" TextMode="MultiLine" CssClass="form-control" Rows="3" ClientIDMode="Static" />
                    </div>
                <div class="col-md-2">
                    <a runat="server" id="aGoTO" class="btn btn-sm btn-block btn-warning">GO TO POST</a>
                    <asp:Button runat="server" text="SAVE" id="Save" OnClick="Save_Click" CssClass="btn btn-sm btn-block btn-secondary" OnClientClick="javascript:return ValidateFields();"/>
                    <a href="AllBlogs.aspx" class="btn btn-sm btn-block btn-danger">CANCEL</a> 
                    <br />
                    <label for="ddl_categories">Categories</label>
                   <asp:ListBox runat="server" id="ddl_categories" placeholder="Categories" DataTextField="catname" SelectionMode="Multiple"  DataValueField="catid" width="100%" ClientIDMode="static"/> <br />
                   <br /><label for="ddl_tags">Tags</label>
                   <asp:ListBox runat="server" ID="ddl_tags" placeholder="Tags" DataTextField="tagname" SelectionMode="Multiple" DataValueField="tagid" Width="100%" ClientIDMode="Static"/><br />
                   <br /><label for="showComments">Show Comments</label>
                    <asp:CheckBox runat="server" ID="showComments" /><br />
                    <label for="isPublished"> Is Published</label>
                    <asp:CheckBox runat="server" ID="isPublished" /><br />
                </div>
                    </div>
                <asp:UpdatePanel runat="server">
        <ContentTemplate>       
     
        
       
              
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

<asp:AsyncPostBackTrigger ControlID = "btnSave" />
</Triggers>
                      
        </asp:UpdatePanel>
    </div>
           
 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"  type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/js/bootstrap-multiselect.js"  type="text/javascript"></script>
    <style type="text/css">
        .cke_contents {
            height: 500px !important;
        }
    </style>
    
   <%-- <script src="../scripts/tinymce/tinymce.min.js" type="text/javascript"></script>--%>
    <%--<script src="//cdn.ckeditor.com/4.15.0/standard/ckeditor.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        $(function () {
            $('[id*=ddl_categories]').multiselect({
                includeSelectAllOption: true
            });
            $('[id*=ddl_tags]').multiselect({
                includeSelectAllOption: true
            });
        });

        <%--tinymce.init({
            selector: '#<%=content.ClientID%>',
            license_key: 'gpl',
            statusbar: false,
            promotion: false,
            plugins: 'table link image',
            table_toolbar: 'tableprops tabledelete | tableinsertrowbefore tableinsertrowafter tabledeleterow | tableinsertcolbefore tableinsertcolafter tabledeletecol'

        });--%>

        <%--CKEDITOR.replace('<%=content.ClientID%>');--%>
        ClassicEditor.create(document.querySelector('#content'));

        setTimeout(function () {
            $(".tox-promotion").hide();
        }, 500);

    </script>>
   
</asp:Content>
