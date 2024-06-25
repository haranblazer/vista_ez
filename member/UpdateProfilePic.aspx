<%@ Page Title="" Language="C#" MasterPageFile="~/member/member.master" AutoEventWireup="true" 
    CodeFile="UpdateProfilePic.aspx.cs" Inherits="member_UpdateProfilePic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script src="Crop/jquery.min.js" type="text/javascript"></script>
    <script src="Crop/bootstrap.min.js" type="text/javascript"></script>
    <link href="Crop/cropper.min.css" rel="Stylesheet" />
    <script src="Crop/cropper.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            $(".alert-success").fadeTo(2000, 500).slideUp(500, function () {
                $(".alert-success").slideUp(500);
            });
            $(".alert-danger").fadeTo(2000, 500).slideUp(500, function () {
                $(".alert-danger").slideUp(500);
            });
        });



        var attachments = {};
        $(function () {
            $.noConflict(true);

            var $ele = $('#<%=imgUpload1.ClientID%>');
        })
        function CheckUploadFile(input) {
            $('#<%=btnInsert.ClientID%>').css('display', 'block');
            $('#<%=imgUpload1.ClientID%>').css('display', 'block');
            $('#<%=btnInsert.ClientID%>').css('display', 'block');
            var validExtensions = ['jpg', 'png', 'jpeg'];
            var fileName = input.files[0].name;
            var fileNameExt = fileName.substr(fileName.lastIndexOf('.') + 1);
            if ($.inArray(fileNameExt, validExtensions) == -1) {
                input.type = ''
                input.type = 'file'
                $('#<%=imgUpload1.ClientID%>').css('display', 'none');
                $('#<%=lblMsg.ClientID%>').append("Only these file types are accepted : " + validExtensions.join(', '));
                $('#<%=btnInsert.ClientID%>').css('display', 'none');
            }
            else {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=imgUpload1.ClientID%>').attr('src', e.target.result);
                        $('#<%=lblMsg.ClientID%>').hide();
                        var tempFileData = e.target.result;
                        var image = $('#imgUpload1')[0];
                        attachments[e.name] = {};
                        attachments[e.name]["content_type"] = tempFileData.split(",")[0].split(":")[1].split(";")[0];
                        attachments[e.name]["data"] = tempFileData.split(",")[1];
                        var $ele = $('#<%=imgUpload1.ClientID%>');
                        $ele.cropper({
                            aspectRatio: 16 / 16,
                            preview: "#divPreview",
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
            }
        }
    </script>


    <style>
        [dir=ltr] .modal-backdrop {
            position: relative;
        }

        .modal-body {
            max-height: calc(100vh - 200px);
            overflow-y: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Update Profile Picture</h4>
    </div>

    <div class="col-sm-4 text-center" id="confirm" runat="server">
    </div>

    <div class="col-md-4">
        <asp:FileUpload ID="picup" runat="server" onchange="CheckUploadFile(this);" />
        <br />
    </div>

    <div class="col-sm-4">
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
        <input id="X" runat="server" type="hidden" />
        <input id="Y" runat="server" type="hidden" />
        <input id="W" runat="server" type="hidden" />
        <input id="H" runat="server" type="hidden" />
        <input id="R" runat="server" type="hidden" />
    </div>

    <div class="col-sm-12 card-group-row">
        <div class="col-sm-6">
            <asp:Button ID="btnInsert" runat="server" CssClass="btn btn-success" Text="Crop & Submit" ValidationGroup="aa" Style="display: none" OnClientClick="return ValidateFile()" OnClick="btnSubmit_Click" />&nbsp;
        </div>
        <div class="col-sm-6">
            <button type="button" id="Button1" runat="server" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#myModal">Reject</button>
        </div>
    </div>
    <div class="col-sm-12 card-group-row">
        <div class="col-sm-2">
            <asp:Image ID="imgUpload1" runat="server" Style="width: 100%" />
        </div>
        <div class="col-md-4">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="aa" />
            <%--<asp:button ID="rotateImg" CssClass="btn btn-default"  runat="server" text="Rotate 90" OnClientClick="rotate();return false" style="display:none;" />--%>
            <div id="divPreview" style="width: 100px; height: 100px; overflow: hidden; margin: 0 auto; text-align: center;"></div>
        </div>
    </div>
    <br />

    <div id="myModal" class="modal fade" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" style="color: White;">Rejecting cropped image</h4>
                    <button type="button" class="close" data-dismiss="modal" style="color: White;">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the current image !</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        No</button>
                    <asp:Button ID="btnreject" runat="server" Text="Yes" Style="background-color: crimson; color: white;" OnClick="btnReject_Click" />
                </div>
            </div>
        </div>
    </div>


</asp:Content>

