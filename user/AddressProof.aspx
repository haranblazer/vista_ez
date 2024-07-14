<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="AddressProof.aspx.cs" Inherits="user_AddressProof" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="assets/css/cropper.min.css" rel="Stylesheet" />
<script src="assets/js/cropper.min.js" type="text/javascript"></script>
<script>

    $(document).ready(function () {
        $(".alert-success").fadeTo(2000, 500).slideUp(500, function () {
            $(".alert-success").slideUp(500);
        });
        $(".alert-danger").fadeTo(2000, 500).slideUp(500, function () {
            $(".alert-danger").slideUp(500);
        });
    });
       
    </script>
 <script type="text/javascript">
     var attachments = {};
     $(function () {
        
//         var $ele = $('#<%=imgUpload2.ClientID%>');
//         var $ele1 = $('#<%=imgUpload3.ClientID%>');
     })
     function ShowImagePreview(input, tag) {
         $.noConflict(true);
         var fileName = input.files[0].name;
         var tag = tag;
         var validExtensions = ['jpg', 'png', 'jpeg'];
         var fileName = input.files[0].name;
         var fileNameExt = fileName.substr(fileName.lastIndexOf('.') + 1);
         if ($.inArray(fileNameExt, validExtensions) == -1) {
             input.type = ''
             input.type = 'file'
             switch (tag) {
                 case 0:
                     $('#<%=imgUpload2.ClientID%>').css('display', 'none');
                     break;
                 case 1:
                     $('#<%=imgUpload3.ClientID%>').css('display', 'none');
                     $('#<%=lblMsg.ClientID%>').html("");
                     break;
                 default:
                     $('#<%=lblMsg.ClientID%>').append("Only these file types are accepted : " + validExtensions.join(', '));
             }
             $('#<%=lblMsg.ClientID%>').append("Only these file types are accepted : " + validExtensions.join(', '));
             $('#<%=btnSubmit.ClientID%>').css('display', 'none');
         }
         else {
             if (input.files && input.files[0] && tag === 0) {
                 var reader = new FileReader();
                 reader.onload = function (e) {
                     $('#<%=imgUpload2.ClientID%>').attr('src', e.target.result);
                     $('#<%=lblMsg.ClientID%>').hide();
                     var tempFileData = e.target.result;
                     var image = $('#imgUpload2')[0];
                     var $ele = $('#<%=imgUpload2.ClientID%>');
                     $('#<%=btnSubmit.ClientID%>').css("display", "block");
                     var $ele = $('#<%=imgUpload2.ClientID%>');
                     var $ele1 = $('#<%=imgUpload3.ClientID%>');
                     $ele.cropper({
                         aspectRatio: 16 / 9,
                         preview: "#divPreview1",
                         rotatable: true,
                         crop: function (c) {
                             $('#<%=X.ClientID%>').val(parseInt(c.detail.x));
                             $('#<%=Y.ClientID%>').val(parseInt(c.detail.y));
                             $('#<%=W.ClientID%>').val(parseInt(c.detail.width));
                             $('#<%=H.ClientID%>').val(parseInt(c.detail.height));
                             $('#<%=R.ClientID%>').val(parseInt(c.detail.rotate));
                         }
                     })
                 }
                 reader.readAsDataURL(input.files[0]);
             }
             else {
                 if (input.files && input.files[0] && tag === 1) {
                     var reader = new FileReader();
                     reader.onload = function (e) {
                         $('#<%=imgUpload3.ClientID%>').attr('src', e.target.result);
                         $('#<%=lblMsg.ClientID%>').hide();
                         var tempFileData = e.target.result;
                         var image = $('#imgUpload3')[0];
                         var $ele1 = $('#<%=imgUpload3.ClientID%>');
                         $ele1.cropper({
                             aspectRatio: 16 / 9,
                             preview: "#divPreview2",
                             rotatable: true,
                             crop: function (c) {
                                 $('#<%=X1.ClientID%>').val(parseInt(c.detail.x));
                                 $('#<%=Y1.ClientID%>').val(parseInt(c.detail.y));
                                 $('#<%=W1.ClientID%>').val(parseInt(c.detail.width));
                                 $('#<%=H1.ClientID%>').val(parseInt(c.detail.height));
                                 $('#<%=R1.ClientID%>').val(parseInt(c.detail.rotate));
                             }
                         })
                     }
                     reader.readAsDataURL(input.files[0]);
                 }
             }
         }
     }

     function rotate(tag) {
         if (tag === 0) {
             $('#<%=imgUpload2.ClientID%>').cropper('rotate', -90);
         }
         else {
             $('#<%=imgUpload3.ClientID%>').cropper('rotate', -90);
         }

     }
 
         
    </script>
    <style>
        [dir=ltr] .modal-backdrop {
    position: relative;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid page__heading-container">
        <div class="page__heading d-flex align-items-center">
            <div class="flex">
                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <%--<li class="breadcrumb-item"><a href="#"> My Business</a></li>--%>
                                        <li class="breadcrumb-item active" aria-current="page">Upload Aadhar Card</li>
                                    </ol>
                                </nav>
                <h1 class="m-0">
                    Upload Aadhar Card</h1>
            </div>
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
    </div>
    <div class="container-fluid page__container">
    <div class="panel card card-body" ID="panbody" runat="server">
    <div class="col-sm-4 text-center" id="confirm" runat="server">
       </div>
     <div class="panel panel-default">
            <div class="panel-heading" style="background:#315787; border-radius: 4px; color: #fff;
                padding: 10px; font-size: 16px">
             </i>&nbsp;Note:</strong> Please upload front as well as back image of aadhar card.<br />
        </div>
    </div>
    <div class="site-content">
         <div class="col-sm-4 text-center" id="Div1" runat="server">
       </div>
        <div class="panel card card-body">
            <div class="container">
        <div class="row"> 
            <div class="col-sm-12">
                <div class="col-sm-4">
                    Upload front image
                </div>
                <div class="col-sm-8 card-group-row">
                    <asp:FileUpload ID="FU2" runat="server" onchange="ShowImagePreview(this,0);" /><br  class="hidden-lg"/>
                    <div class="col-sm-6">
                     <asp:Image ID="imgUpload2" runat="server" style="width:100%"/>
                     </div><br  class="hidden-lg"/>
                    <div class="col-sm-2">
                                    <div id="divPreview1" style="width:200px;height:200px;overflow:hidden;margin:0 auto;text-align:center;" ></div>
                     </div>
                </div>
                
            </div>
            </div>
            <div class="row" style="margin-top:30px;">
            <div class="col-sm-12">
                 <div class="col-sm-4">
                    Upload back image
                </div>
                <div class="col-sm-8 card-group-row" >
                    <asp:FileUpload ID="FU3" runat="server" onchange="ShowImagePreview(this,1);" /><br  class="hidden-lg"/>
                    <div class="col-sm-6">
                    <asp:Image ID="imgUpload3" runat="server" style="width:100%"/><br  class="hidden-lg"/>
                     </div>
                    <div class="col-sm-2">
                         <div id="div2" style="width:200px;height:200px;overflow:hidden;margin:0 auto;text-align:center;" ></div>
                     </div>
                </div>
            </div>
       </div>
      </div>
              <div class="clearfix">
    </div>
                 <div class="col-sm-3"> 
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
                             <input ID="X" runat="server" type="hidden"/>
                             <input ID="Y" runat="server" type="hidden"/>
                             <input ID="W" runat="server" type="hidden"/>
                             <input ID="H" runat="server" type="hidden"/>
                             <input id="R" runat="server" type="hidden" />
                             <input ID="X1" runat="server" type="hidden"/>
                             <input ID="Y1" runat="server" type="hidden"/>
                             <input ID="W1" runat="server" type="hidden"/>
                             <input ID="H1" runat="server" type="hidden"/>
                             <input id="R1" runat="server" type="hidden" />
                        </div>
             <div class="col-sm-1">
                               <button type="button" id="btnreject" runat="server"  class="btn btn-danger" data-toggle="modal" data-target="#myModal" >Reject</button>
                    </div>
          <div class="col-sm-3">
                        <button runat="server" id="btnSubmit" title="Submit" class="btn btn-success" onserverclick="btnSubmit_Click"
                            validationgroup="vv" style="display:none;">
                            <i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp;Submit
                        </button>
                    </div>
    <div class="clearfix">
    </div>
    </div>
         <!-- Modal of reject -->
                            <div id="myModal" class="modal fade" role="dialog">
                              <div class="modal-dialog">

                                <!-- Modal content-->
                                <div class="modal-content">
                                  <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Rejecting cropped image</h4>
                                  </div>
                                  <div class="modal-body">
                                    <p>Are you sure you want to delete the current images !</p>
                                  </div>
                                  <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal">
                                                            No</button>
                                     <asp:button ID="Button1" runat="server"  text="Yes"  style="background-color:crimson; color: white;"  OnClick="btnReject_Click" />
                                  </div>
                                </div>

                              </div>
                            </div>
   </div>
    </div>
    </div>
    </div>
</asp:Content>
