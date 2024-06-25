
<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="UploadBannerImage.aspx.cs" Inherits="secretadmin_UploadBannerImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <script src="https://cdn.ckeditor.com/4.5.6/standard/ckeditor.js"></script>
   <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>--%>

    <script src="https://cdn.ckeditor.com/4.5.6/standard/ckeditor.js"></script>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script src="//cdn.ckeditor.com/4.15.0/standard/ckeditor.js"></script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script type="text/javascript">
        function validateAndConfirm(message) {
            var validated = Page_ClientValidate('pp');
            if (validated) {
                return confirm(message);
            }
        }
    </script>
    <script type="text/javascript">
        function previewImage() {
            var preview = document.querySelector('#<%=ImgFileSliderImage.ClientID %>');
            var Image = document.querySelector('#<%=FileSliderImage.ClientID %>').files[0];
            var width = preview.clientWidth;
            var height = preview.clientHeight;
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;

            }
            if (Image) {
                reader.readAsDataURL(Image);
            }
            else {

                var img = document.getElementById('<%=ImgFileSliderImage.ClientID%>');
                if (img.value = "") {
                    img.value = "";

                }
            }
        }
    </script>
    <script type="text/javascript">
        function ConfirmDelete() {
            if (confirm("Are you sure want to delete this record?")) {
                return true;
            }
            return false;
        }

    </script>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Upload Slider Image</h4>
    </div>


    <div class="alert alert-primary alert-dismissible fade show mt-2">
        <strong>Note</strong>  Image size must be width 1400px and height 550px                
                    and Image size should be less than 2 MB.
                    ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
    </div>





    <div class="row">
        <div class="col-sm-2 control-label">
            Slider Type
        </div>
        <div class="col-sm-4">
            <asp:DropDownList ID="ddl_type" runat="server" CssClass="form-control"
                AutoPostBack="true" OnSelectedIndexChanged="ddl_type_SelectedIndexChanged">
                <asp:ListItem Value="1">Main Slider</asp:ListItem>
               <%-- <asp:ListItem Value="2">Offer Slider</asp:ListItem>--%>
            </asp:DropDownList>

        </div>
        <div class="clearfix"></div>
        <div class="col-sm-2 control-label">
            Select Slider Image
        </div>

        <div class="col-sm-4">
            <div class="input-group">
                <div class="form-file">

                    <asp:FileUpload ID="FileSliderImage" runat="server" CssClass="form-file-input form-control" onchange="previewImage();" /><br />
                    <asp:RequiredFieldValidator ID="rfvFileSliderImage" runat="server" ForeColor="Red"
                        SetFocusOnError="true" ControlToValidate="FileSliderImage" Display="Dynamic"
                        ErrorMessage="Please Select Slider Image." ValidationGroup="pp"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revFileSliderImage" runat="server" ValidationExpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"
                        SetFocusOnError="true" ControlToValidate="FileSliderImage" ErrorMessage="Only .jpg/.jpeg/.gif/.png file types are allowed."
                        ForeColor="Red" Display="Dynamic" ValidationGroup="pp"></asp:RegularExpressionValidator>
                </div>
            </div>

        </div>
        <div class="col-sm-2 control-label">
            Add URL
        </div>
        <div class="col-sm-4">
            <div class="input-group">
                <div class="form-file">
                    <asp:TextBox runat="server" ID="txt_url" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="col-sm-4">
            <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-primary"
                OnClientClick="return validateAndConfirm('Do you really want to upload this Slider Image?');"
                ValidationGroup="pp" OnClick="btnUpload_Click" />
        </div>

        <div class="clearfix">
        </div>

        <div class="col-md-12">
            <center>
                <asp:Image ID="ImgFileSliderImage" runat="server" CssClass="img-responsive img-rounded" />
            </center>
        </div>
    </div>

    <div class="clearfix">
    </div>
    <div class="table-responsive">
        <asp:DataList ID="dlSliderImage" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
            RepeatLayout="Table" Width="100%">
            <ItemTemplate>
                <div style="padding: 10px">
                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("id") %>' Visible="false"></asp:Label>
                    <a href='<%# Eval("img","~/images/SliderImage/{0}") %>' data-fancybox="gallery">
                        <asp:Image ID="SliderImage" runat="server" ImageUrl='<%# Eval("img","~/images/SliderImage/{0}") %>'
                            CssClass="img-responsive img-thumbnail" />
                    </a>
                    <br />
                    Slider Type: <%# Eval("IsMain") %>
                    <br />

                    <asp:LinkButton ID="lnkDel" runat="server" Text="Delete" OnClick="lnkDel_Click" CssClass="btn btn-danger btn-sm"
                        OnClientClick="return ConfirmDelete();"></asp:LinkButton>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
    <div class="clearfix"></div>
    <%-- First Banner --%>
    <hr />
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-sm-12">
        <div class="alert alert-primary alert-dismissible fade show mt-2">
        <strong>Note</strong>  Image size must be width 1600px and height 700px                
                    and Image size should be less than 2 MB.
                    ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
    </div>
            </div>
    <div class="col-sm-2 control-label">
        Select Banner Image 1
    </div>
    <div class="col-sm-4">
        <div class="input-group">
            <div class="form-file">
                <asp:FileUpload ID="Upload_Img1" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.gif" />
            </div>
        </div>
    </div>
  
    <div class="col-sm-4">
        <asp:Button ID="btn_update" runat="server" Text="Update" OnClick="btn_update_Click"
            CssClass="btn btn-primary" />
    </div>
        </div>
    <div class="table-responsive">
        <div style="padding: 10px">
            <%-- <asp:Image runat="server" ID="Image1"  Width="200px" Height="150px" />--%>
            <div class="col-sm-6" id="div_Img1" runat="server"></div>
            <br />
            <asp:Button ID="btn_delete" runat="server" Text="Delete" OnClick="btn_delete_Click"
                CssClass="btn btn-danger" />


        </div>

    </div>
    <hr />
    <div class="row d-none">
        
    <div class="col-sm-2 control-label">
        Add Offer Title
    </div>
     <div class="col-sm-4">
    <asp:TextBox ID="txt_Offer" TextMode="MultiLine" CssClass="form-file-input form-control" runat="server">  
    </asp:TextBox>
         </div>
   <%-- <script type="text/javascript" lang="javascript">
        CKEDITOR.replace('<%=txt_Offer.ClientID%>');
    </script>--%>
    <div class="col-sm-4">
        <asp:Button ID="btn_update_offer" runat="server" Text="Update Offer" OnClick="btn_update_offer_Click"
            CssClass="btn btn-primary" />
    </div>
  </div>
    <%-- Second Banner --%>
    <%--<hr />--%>
    <div class="clearfix"></div>
    <div class="row">
       <div class="col-sm-12">
        <div class="alert alert-primary alert-dismissible fade show mt-2">
        <strong>Note</strong>  Image size must be width 1600px and height 700px                
                    and Image size should be less than 2 MB.
                    ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
    </div>
           </div>
    <div class="col-sm-3 control-label">
        Select Client Testimonials Background 
    </div>
    <div class="col-sm-4">
        <div class="input-group">
            <div class="form-file">
                <asp:FileUpload ID="Upload_Img2" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.gif" />
            </div>
        </div>
    </div>
   
    <div class="col-sm-4">
        <asp:Button ID="btn_update2" runat="server" Text="Update" OnClick="btn_update2_Click"
            CssClass="btn btn-primary" />
    </div>
        </div>
    <div class="table-responsive">
        <div style="padding: 10px">
            <%-- <asp:Image runat="server" ID="Image2"   Width="200px" Height="150px"/>--%>
            <div class="col-sm-4" id="div_Img2" runat="server"></div>

            <br />
            <asp:Button ID="btn_delete2" runat="server" Text="Delete" OnClick="btn_delete2_Click"
                CssClass="btn btn-danger" />

        </div>

    </div>
    <hr />
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-sm-12">
        <div class="alert alert-primary alert-dismissible fade show mt-2">
        <strong>Note</strong>  Image size must be width 420px and height 500px                
                    and Image size should be less than 2 MB.
                    ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
    </div>
            </div>
    <%-- Third Banner --%>
    <div class="col-sm-2 control-label">
        Select Banner Image 1
    </div>
    <div class="col-sm-4">
        <div class="input-group">
            <div class="form-file">
                <asp:FileUpload ID="Upload_Img3" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.gif" />
            </div>
        </div>
    </div>
        <div class="col-sm-2 control-label">
       Add URL
    </div>
        <div class="col-sm-4">
        <div class="input-group">
            <div class="form-file">
                <asp:TextBox runat="server" ID="txt_url_3" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
   
    <div class="col-sm-4">
        <asp:Button ID="btn_update3" runat="server" Text="Update" OnClick="btn3_update_Click"
            CssClass="btn btn-primary" />
    </div>
        </div>
    <div class="table-responsive">
        <div style="padding: 10px">
            <%-- <asp:Image runat="server" ID="Image1"  Width="200px" Height="150px" />--%>
            <div class="col-sm-4" id="div_Img3" runat="server"></div>
            <br />
            <asp:Button ID="btn_delete3" runat="server" Text="Delete" OnClick="btn3_delete_Click"
                CssClass="btn btn-danger" />


        </div>

    </div>
    <hr />
    <div class="clearfix"></div>
    <%-- Fourth Banner --%>
    <div class="row">
        <div class="col-sm-12">
        <div class="alert alert-primary alert-dismissible fade show mt-2">
        <strong>Note</strong>  Image size must be width 420px and height 500px                
                    and Image size should be less than 2 MB.
                    ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
    </div>
            </div>
    <div class="col-sm-2 control-label">
        Select Banner Image 2
    </div>
    <div class="col-sm-4">
        <div class="input-group">
            <div class="form-file">
                <asp:FileUpload ID="Upload_Img4" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.gif" />
            </div>
        </div>
    </div>
         <div class="col-sm-2 control-label">
       Add URL
    </div>
    <div class="col-sm-4">
        <div class="input-group">
            <div class="form-file">
                <asp:TextBox runat="server" ID="txt_url_4" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <asp:Button ID="btn_update4" runat="server" Text="Update" OnClick="btn4_update_Click"
            CssClass="btn btn-primary" />
    </div>
        </div>
    <div class="table-responsive">
        <div style="padding: 10px">
            <%-- <asp:Image runat="server" ID="Image1"  Width="200px" Height="150px" />--%>
            <div class="col-sm-4" id="div_Img4" runat="server"></div>
            <br />
            <asp:Button ID="btn_delete4" runat="server" Text="Delete" OnClick="btn4_delete_Click"
                CssClass="btn btn-danger" />


        </div>

    </div>
    <hr />
    <div class="clearfix"></div>
   <div class="row">
       <div class="col-sm-12">
        <div class="alert alert-primary alert-dismissible fade show mt-2">
        <strong>Note</strong>  Image size must be width 420px and height 500px                
                    and Image size should be less than 2 MB.
                    ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
    </div>
            </div>
    <div class="col-sm-2 control-label">
        Select Banner Image 3
    </div>
    <div class="col-sm-4">
        <div class="input-group">
            <div class="form-file">
                <asp:FileUpload ID="Upload_Img5" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.gif" />
            </div>
        </div>
    </div>
        <div class="col-sm-2 control-label">
       Add URL
    </div>
    <div class="col-sm-4">
        <div class="input-group">
            <div class="form-file">
                <asp:TextBox runat="server" ID="txt_url_5" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <asp:Button ID="btn_update5" runat="server" Text="Update" OnClick="btn5_update_Click"
            CssClass="btn btn-primary" />
    </div>
       </div>
    <div class="table-responsive">
        <div style="padding: 10px">
            <%-- <asp:Image runat="server" ID="Image1"  Width="200px" Height="150px" />--%>
            <div class="col-sm-4" id="div_Img5" runat="server"></div>
            <br />
            <asp:Button ID="btn_delete5" runat="server" Text="Delete" OnClick="btn5_delete_Click"
                CssClass="btn btn-danger" />


        </div>

    </div>

    <div class="clearfix"></div>

    <style>
        .form-control {
            margin: 0.4em 0 !important;
        }
    </style>
</asp:Content>
