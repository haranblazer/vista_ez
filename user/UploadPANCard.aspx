<%@ Page Title="Upload PAN Card" Language="C#" MasterPageFile="~/user/user.master"
    AutoEventWireup="true" CodeFile="UploadPANCard.aspx.cs" Inherits="user_UploadPANCard" %>

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



    function ShowImagePreview(input) {
        $.noConflict(true);
        $('#<%=btnSubmit.ClientID%>').css('display', 'block');
        $('#<%=imgUpload.ClientID%>').css('display', 'block');

        var validExtensions = ['jpg', 'png', 'jpeg'];
        var fileName = input.files[0].name;
        var fileNameExt = fileName.substr(fileName.lastIndexOf('.') + 1);
        if ($.inArray(fileNameExt, validExtensions) == -1) {
            input.type = ''
            input.type = 'file'
            $('#<%=imgUpload.ClientID%>').css('display', 'none');
            $('#<%=lblMsg.ClientID%>').append("Only these file types are accepted : " + validExtensions.join(', '));
            $('#<%=btnSubmit.ClientID%>').css('display', 'none');
        }
        else {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgUpload.ClientID%>').attr('src', e.target.result);
                    $('#<%=lblMsg.ClientID%>').hide();
                    var tempFileData = e.target.result;
                    var image = $('#imgUpload')[0];
                    attachments[e.name] = {};
                    attachments[e.name]["content_type"] = tempFileData.split(",")[0].split(":")[1].split(";")[0];
                    attachments[e.name]["data"] = tempFileData.split(",")[1];

                    var $ele = $('#<%=imgUpload.ClientID%>');
                    $ele.cropper({
                        aspectRatio: 16 / 9,
                        preview: "#divPreview",
                        crop: function (c) {
                            $('#<%=X.ClientID%>').val(parseInt(c.detail.x));
                            $('#<%=Y.ClientID%>').val(parseInt(c.detail.y));
                            $('#<%=W.ClientID%>').val(parseInt(c.detail.width));
                            $('#<%=H.ClientID%>').val(parseInt(c.detail.height));
                        }
                    })

                }
                reader.readAsDataURL(input.files[0]);
            }
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
                                        <li class="breadcrumb-item active" aria-current="page">Upload PAN Card</li>
                                    </ol>
                                </nav>
                <h1 class="m-0">
                    Upload PAN Card</h1>
            </div>
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
    </div>
    <div class="container-fluid page__container">
    <div class="panel card card-body" ID="panbody" runat="server">
    <div class="col-sm-4 text-center" id="confirm" runat="server">
       </div>
    <div class="form-group">
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtPANDetails" runat="server" CssClass="form-control" placeholder="Enter PAN Number"
                            MaxLength="10"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPanNo" runat="server" ForeColor="Red" SetFocusOnError="true"
                            ControlToValidate="txtPANDetails" Display="Dynamic" ErrorMessage="Please Enter PAN Number."
                            ValidationGroup="vv"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revPanNo" runat="server" SetFocusOnError="true"
                            ErrorMessage="Please Enter Valid PAN Number." ControlToValidate="txtPANDetails"
                            ForeColor="Red" ValidationExpression="^[a-zA-Z]{5}\d{4}[a-zA-Z]$" ValidationGroup="vv"></asp:RegularExpressionValidator>
                    </div>
                    <div class="clearfix"></div>                                   
                       
                         <div class="col-sm-12">  
                            	 Click to upload images
                             </div>
                    <div class="clearfix"></div> 
                    <div class="card-group-row">  
                     <div class="col-sm-2">     
                             
                            Select Image File : 
                      </div>
                         <div class="col-sm-3"> 
                     
                            <asp:FileUpload ID="FU1" runat="server" onchange="ShowImagePreview(this);" />
                      </div>
                      
                     <%--<div class="col-sm-3"> 
                            <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click"  />
                    </div>--%>
                        <div class="col-sm-3"> 
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
                              <input ID="X" runat="server" type="hidden"/>
                             <input ID="Y" runat="server" type="hidden"/>
                             <input ID="W" runat="server" type="hidden"/>
                             <input ID="H" runat="server" type="hidden"/>
                        </div>
                          <div class="col-sm-1">
                               <button type="button" id="btnreject" runat="server" value class="btn btn-danger" data-toggle="modal" data-target="#myModal" >Reject</button>
                    </div>
                    
                        <div class="clearfix">
                        </div>
                        <br />
                    <div class="col-sm-3">
                        <button runat="server" id="btnSubmit" onclientclick="return ValidateFile()" title="Crop & Save" class="btn btn-success" onserverclick="btnSubmit_Click"
                            validationgroup="vv" >
                            <i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp;Crop & Submit
                        </button>
                    </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <br />
                    <div class="col-sm-12">
                         
                            <!-- Modal of reject -->
                            <div id="myModal" class="modal fade" role="dialog">
                              <div class="modal-dialog">

                                <!-- Modal content-->
                                <div class="modal-content">
                                  <div class="modal-header">
                                  <h4 class="modal-title" style="color:White">Rejecting cropped image</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                  </div>
                                  <div class="modal-body">
                                    <p>Are you sure you want to delete the current image !</p>
                                  </div>
                                  <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal">
                                                            No</button>
                                     <asp:button ID="Button1" runat="server"  text="Yes"  style="background-color:crimson; color: white;"  OnClick="btnReject_Click"  />
                                  </div>
                                </div>

                              </div>
                            </div>
                            <div class="col-sm-12 card-group-row">
                            <div class="col-sm-6" >
                            <asp:Image ID="imgUpload" runat="server" style="width:100%"/>
                             </div>
                                <div class="col-sm-6">
                                    <div id="divPreview" style="width:200px;height:200px;overflow:hidden;margin:0 auto;text-align:center;" ></div>
                                </div>
                          </div>
                    
                     </div>
                </div>
    </div>
    </div>
    </div>
</asp:Content>
