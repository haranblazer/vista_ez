<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="UploadBrandImage.aspx.cs" Inherits="secretadmin_UploadBrandImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
      <h4 class="fs-20 font-w600  me-auto">Upload Brand Image</h4>
  </div>


  <div class="alert alert-primary alert-dismissible fade show mt-2">
      <strong>Note</strong>  Image size must be width 300px and height 180px                
                  and Image size should be less than 2 MB.
                  ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
							<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                  </button>
  </div>
    <div class="row">
                <div class="col-sm-1 control-label">
    Title
</div>
<div class="col-sm-2">
    <div class="input-group">
        <div class="form-file">
            <asp:TextBox runat="server" ID="txt_title" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
</div>

 <div class="col-sm-1 control-label">
      Image
 </div>

 <div class="col-sm-3">
     <div class="input-group">
         <div class="form-file">

             <asp:FileUpload ID="FileSliderImage" accept=".png,.jpg,.jpeg,.gif" runat="server" CssClass="form-file-input form-control" onchange="previewImage();" /><br />
            <%-- <asp:RequiredFieldValidator ID="rfvFileSliderImage" runat="server" ForeColor="Red"
                 SetFocusOnError="true" ControlToValidate="FileSliderImage" Display="Dynamic"
                 ErrorMessage="Please Select Slider Image." ValidationGroup="pp"></asp:RequiredFieldValidator>--%>
             <asp:RegularExpressionValidator ID="revFileSliderImage" runat="server" ValidationExpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"
                 SetFocusOnError="true" ControlToValidate="FileSliderImage" ErrorMessage="Only .jpg/.jpeg/.gif/.png file types are allowed."
                 ForeColor="Red" Display="Dynamic" ValidationGroup="pp"></asp:RegularExpressionValidator>
         </div>
     </div>

 </div>
        <div class="col-sm-2 control-label">
            Priority No.
        </div>
         <div class="col-sm-1">
             <asp:TextBox runat="server" ID="txt_PNo" onkeypress="return onlyNumbers(event,this);" CssClass="form-control"></asp:TextBox>
         </div>
         <div class="col-sm-1">
     <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-primary"
         OnClientClick="return validateAndConfirm('Do you really want to upload this Slider Image?');"
         ValidationGroup="pp" OnClick="btnUpload_Click" />
 </div></div>
           <div class="col-md-12">
       <center>
           <asp:Image ID="ImgFileSliderImage" runat="server" CssClass="img-responsive img-rounded" />
       </center>
   </div>

        
       <div class="table-responsive">
       <asp:DataList ID="dlSliderImage" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
           RepeatLayout="Table" Width="100%">
           <ItemTemplate>
               <div style="padding: 10px">
                   <asp:Label ID="lblID" runat="server" Text='<%# Eval("bid") %>' Visible="false"></asp:Label>
                   <a href='<%# Eval("img","../images/brand_logo/{0}") %>' data-fancybox="gallery">
                       <asp:Image ID="SliderImage" runat="server" ImageUrl='<%# Eval("img","~/images/brand_logo/{0}") %>'
                           CssClass="img-responsive img-thumbnail" />
                   </a>
                  <br />
                    <div class="row">
                          
                      
                <div class="col-6 control-label text-center">
                    <asp:CheckBox ID="chk_Status" OnCheckedChanged="chk_Status_CheckedChanged" AutoPostBack="true"  runat="server" />
                    <span> &nbsp 
                        Priority No.<span> <%# Eval("PriorityNo") %></span>

                    </span></div>
                      <%--      <div class="col-2"> 
                        <asp:Label ID="txt_P_No" CssClass="control-label" runat="server" Text='<%# Eval("PriorityNo") %>'></asp:Label></div>--%>
                    <%--<asp:TextBox runat="server" ID="txt_P_No" 
                        Text='<%# Eval("PriorityNo") %>' CssClass="form-control"></asp:TextBox></div>--%>
                        <div class="col-2">
                   <asp:LinkButton ID="lnkDel" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"
                      onclick="lnkDel_Click" OnClientClick="return ConfirmDelete();"></asp:LinkButton></div>
                         <div class="col-1"></div>
                         <div class="col-2">
     <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CssClass="btn btn-primary"
     OnClick="lnkEdit_Click"></asp:LinkButton>
 </div>
                    </div>
                   </div>
                   
               </div>
           </ItemTemplate>
       </asp:DataList>
   </div>
    <asp:HiddenField runat="server" ID="hdn_Id" />
     <script type="text/javascript">
          function previewImage() {
         $('#<%=ImgFileSliderImage.ClientID%>').css("height", "200px").css("width", "300px");

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
     <%--    function previewImage() {
             debugger;
             var preview = document.querySelector('#<%=ImgFileSliderImage.ClientID %>');
             var fileInput = document.querySelector('#<%=FileSliderImage.ClientID %>');
             var image = fileInput.files[0];

             if (image) {
                 var reader = new FileReader();

                 reader.onloadend = function () {
                     preview.src = reader.result;

                     // Ensure square aspect ratio
                     var dim = Math.min(preview.clientWidth, preview.clientHeight);
                     preview.style.width = dim + 'px';
                     preview.style.height = dim + 'px';
                 };

                 reader.readAsDataURL(image);
             } else {
                 // Handle case where no image is selected
                 preview.src = ""; // Clear the preview
             }
         }--%>

         function onlyNumbers(e, t) {
             if (window.event) { var charCode = window.event.keyCode; }
             else if (e) { var charCode = e.which; }
             else { return true; }
             if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
             return true;
         }
     </script>
    
</asp:Content>

