<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="AddProductBanner.aspx.cs" Inherits="secretadmin_AddProductBanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
      <div class="row"></div>
     <div class="col-sm-2 control-label">
      Select Slider Image
  </div>

  <div class="col-sm-4">
      <div class="input-group">
          <div class="form-file">

              <%--<asp:FileUpload ID="FileSliderImage" runat="server" CssClass="form-file-input form-control" onchange="previewImage();" /><br />
              <asp:RequiredFieldValidator ID="rfvFileSliderImage" runat="server" ForeColor="Red"
                  SetFocusOnError="true" ControlToValidate="FileSliderImage" Display="Dynamic"
                  ErrorMessage="Please Select Slider Image." ValidationGroup="pp"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="revFileSliderImage" runat="server" ValidationExpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"
                  SetFocusOnError="true" ControlToValidate="FileSliderImage" ErrorMessage="Only .jpg/.jpeg/.gif/.png file types are allowed."
                  ForeColor="Red" Display="Dynamic" ValidationGroup="pp"></asp:RegularExpressionValidator>--%>
                <input type="file" id="img_banner" accept=".png,.jpg,.jpeg,.gif" onchange="previewImage()" style="display: none;" />
  <label for="img_banner" class="btn btn-default"><i class="fa fa-upload" aria-hidden="true"></i></label>
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
     <%-- <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-primary"
          OnClientClick="return validateAndConfirm('Do you really want to upload this Slider Image?');"
          ValidationGroup="pp" OnClick="btnUpload_Click" />--%>
       <input type="button" id="btn_submit" value="Submit" onclick="Upload_Banner();" class="btn btn-success" />
  </div>
     <div class="col-md-12">
     <center>
         <asp:Image ID="ImgFileSliderImage" runat="server" CssClass="img-responsive img-rounded" />
     </center>
 </div>
    <asp:HiddenField runat="server" ID="hdn_pid" />
    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("AddProductBanner.aspx")%>';

        function previewImage() {
            var preview = document.querySelector('#<%=ImgFileSliderImage.ClientID %>');
            var Image = document.querySelector('#img_banner').files[0];
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
        async function Upload_Banner() {
           
            let Id = $('#<%=hdn_pid.ClientID%>').val();
            var URL = $('#<%=txt_url.ClientID%>').val();
            var fileUpload = $("#img_banner").get(0);
            
            var files = fileUpload.files;
            var height = $('#<%=ImgFileSliderImage.ClientID%>').height();
            var width = $('#<%=ImgFileSliderImage.ClientID%>').width();
            let ImgName = "";

           
              
            if (files != null) {

                if (height != 550 && width != 1400) {
                    alert("Image size must be width 1400px and height 550px!!");
                    return false;
                }
                else {
                    var data = new FormData();
                    var random = "ProdBanr" + Math.floor(100000 + Math.random() * 99999999);
                    for (var i = 0; i < files.length; i++) {
                        var ext = files[i].name.split(".");
                        ext = ext[ext.length - 1].toLowerCase();
                        data.append(random + '.' + ext, files[i]);
                        ImgName = random + '.' + ext;
                    }
                }
                    $.ajax({
                        type: "POST",
                        url: 'AddProductBanner.aspx/Upload_Banner',
                        data: '{ Id: "' + Id + '", ImgName: "' + ImgName + '",URL: "' + URL + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {

                            var _URL = window.URL || window.webkitURL;
                            $.ajax({
                                url: "../Upload_Pan.ashx",
                                type: "POST",
                                data: data,
                                async: "false",
                                contentType: false,
                                processData: false,
                                success: function (result) {
                                    alert("Product Banner Uploaded Successfully.");
                                },
                                error: function (err) { return 0; }
                            });
                        },
                        failure: function (response) { alert(response.d); }
                    });
                }
      else {
          alert('Please Select Banner Image.');
          return false;
      }
  }
    </script>

     <div class="table-responsive">
     <asp:DataList ID="dlSliderImage" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
         RepeatLayout="Table" Width="100%">
         <ItemTemplate>
             <div style="padding: 10px">
                 <asp:Label ID="lblID" runat="server" Text='<%# Eval("srno") %>' Visible="false"></asp:Label>
                 <a href='<%# Eval("BanrImg","~/Productimage/{0}") %>' data-fancybox="gallery">
                     <asp:Image ID="SliderImage" runat="server" ImageUrl='<%# Eval("BanrImg","~/Productimage/{0}") %>'
                         CssClass="img-responsive img-thumbnail" />
                 </a>
                

                 <asp:LinkButton ID="lnkDel" runat="server" Text="Delete" OnClick="lnkDel_Click" CssClass="btn btn-danger btn-sm"
                     OnClientClick="return ConfirmDelete();"></asp:LinkButton>
             </div>
         </ItemTemplate>
     </asp:DataList>
 </div>
</asp:Content>

