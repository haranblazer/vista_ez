<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="VideoUpload.aspx.cs" Inherits="admin_VideoUpload" ValidateRequest="false"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .dotGreen {
            height: 25px;
            width: 25px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 25px;
            width: 25px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }

        .scrolling {
            position: absolute;
        }

        .gvWidthHight {
            overflow: scroll;
            height: 400px;
        }
    </style>

    <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add Video/ Event Link</h4>					
				</div>

  
  
    
            <div class="row">
                <%--<div class="col-md-2 control-label">
                    Video Type:
                </div>--%>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddl_DataType" runat="server" style="display: none;" CssClass="form-control"
                        AutoPostBack="true" OnSelectedIndexChanged="ddl_DataType_SelectedIndexChanged">
                        <asp:ListItem Value="Videos">Video</asp:ListItem>
                        <asp:ListItem Value="Events">Event</asp:ListItem>
                        <asp:ListItem Value="DiamondCelebration">Diamond Celebration</asp:ListItem> 
                    </asp:DropDownList>
                </div>
            
                <%--<div class="col-md-2 control-label">
                    Title:
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddl_title" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>--%>
            </div>
           
                <div class="alert alert-primary alert-dismissible fade show mt-2">									
									<strong>Note</strong>  Video size must be width 100% and height 200px
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
								</div>

           
      

            <div class="form-group" >
                 <div class="col-md-2 ">Title: <span style="color: Red">*</span></div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddl_title" runat="server" CssClass="form-control"></asp:DropDownList>

                </div>
                <div class="col-md-2 ">
                   Video Link:<span style="color: Red">*</span>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ID="txtVideoUpload" runat="server" CssClass="form-control"
                        placeholder="Please Enter Embed Video Link"></asp:TextBox>
                    <asp:Label ID="lblMsg" runat="server" Text="" Visible="false" ForeColor="Red" Font-Bold="true"></asp:Label>
                </div>
                <div class="col-md-2 ">
   Description:<span style="color: Red">*</span>
</div>
                 <div class="col-md-3">
     <asp:TextBox ID="txt_Desc" runat="server" CssClass="form-control"
         placeholder="Please Enter Video Description"></asp:TextBox></div>
            </div>
            <div class="clearfix"></div>

            <div class="form-group" >
               <%-- <div class="col-md-2">
                    Upload Image
                </div>--%>
                <div  style="display: none;" class="col-md-3">
                    <div class="input-group">
                                            <div class="form-file">
                                               
                                                <asp:FileUpload ID="fuUpload" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.gif" />
                                            </div>
                                        </div>
                    
                </div>

          
                <div class="col-md-4">
                    <asp:Button ID="btnSubmit" runat="server" Text="Add Link" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
                </div>
               
            </div>
         
        
           
                <div class="col-md-12">
                    <div id="dvPreview" runat="server"></div>
                </div>
            
        

       
            <div style="display: none;" class="row">
                <div class="col-md-2 control-label">
                    Enter Title 
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txt_Title" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSave" runat="server" Text="Add Title" OnClientClick="javascript:return Validation()"
                        OnClick="btnSave_Click" CssClass="btn btn-primary" />
                </div>
            </div>
          <hr />
          
                    <div class="table-responsive">
                        <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="Tid" Width="100%"
                            CssClass="table table-striped table-hover mygrd" runat="server" AutoGenerateColumns="False"
                            OnRowEditing="GridView1_RowEditing" OnRowDeleting="OnRowDeleting"
                            AllowPaging="false" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:HiddenField ID="hnd_Tid" runat="server" Value='<%# Eval("Tid") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Title" DataField="Title" ReadOnly="True" />
                                <asp:BoundField HeaderText="Title Type" DataField="TitleType" ReadOnly="True" />
                                <%--<asp:TemplateField HeaderText="Show/Hide">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='ACTIVE_DEACTIVE'>&nbsp;<%# Eval("IsActive").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                               <%-- <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnk_delete" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='DELETE'> <%#"<center><span style='color:Red; font-size:x-large;'>&times;</span></center>"%> </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                            </Columns>
                        </asp:GridView>
                    </div>
              
       

                    <div class="table-responsive">
                        <asp:GridView ID="DataVideo" runat="server" DataKeyNames="id,Img" Width="100%" EmptyDataText="Record not found."
                            CssClass="table table-striped table-hover mygrd" AutoGenerateColumns="False" AllowPaging="false"
                            OnRowEditing="GridView1_RowEditing" OnRowDeleting="OnRowDeleting"
                            OnPageIndexChanging="DataVideo_PageIndexChanging" OnRowCommand="DataVideo_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                      <%--  <asp:HiddenField ID="hnd_id" runat="server" Value='<%# Eval("id") %>' />
                                        <asp:HiddenField ID="hnd_VImg" runat="server" Value='<%# Eval("Img") %>' />--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Title" DataField="Title" ReadOnly="True" />
                               
                              <%--  <asp:TemplateField HeaderText="Image">
                                    <ItemTemplate>
                                        <img src="<%# Eval("Img","../images/Slip/{0}")%>" width="70px;" height="80px;" />
                                        <br />
                                        <asp:FileUpload ID="imgVUpload" runat="server" CssClass="btn btn-default"
                                            width="150px" accept=".png,.jpg,.jpeg,.gif" />
                                        <br />
                                        <asp:LinkButton ID="lnkVupdate" runat="server" Text="Update Image" CssClass="btn btn-primary" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='IMG_UPDATE'></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                <asp:TemplateField HeaderText="On/ Off">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkOnOff" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='Status'>&nbsp;<%# Eval("Status").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDel" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='VDELETE'
                                            OnClientClick="return confirm('Are you sure want to delete this record?');"> <%#"<center><span style='color:Red; font-size:x-large;'>&times;</span></center>"%> </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Video Link">
                                    <ItemTemplate> <%--shortname--%>
                                        <asp:Label ID="lbl_vlink" runat="server" ForeColor="Blue"
                                            Text='<%# Eval("VName") %>' ToolTip='<%# Eval("VName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

               
    <script type="text/javascript">
        function HideLabel() {
            var seconds = 15;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };

        function ConfirmDelete() {
            if (confirm("Are you sure want to delete this record?")) {
                return true;
            }
            return false;
        }

        $(function () {
            $("[id*=fuUpload]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=dvPreview.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:112px;width: 105px");
                                img.attr("src", e.target.result);
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#<%=fuUpload.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });
        });
    </script>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
