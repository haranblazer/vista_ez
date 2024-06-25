<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="UpdateprofilePic.aspx.cs" Inherits="User_UpdateprofilePic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <link href="assets/css/cropper.min.css" rel="Stylesheet" />
    <script src="assets/js/cropper.min.js" type="text/javascript"></script>
    <script> var $JD = $.noConflict(true); </script>
    <script>
        var attachments = {};
        $JD(function () {
            $JD(".alert-success").fadeTo(2000, 500).slideUp(500, function () {
                $JD(".alert-success").slideUp(500);
            });
            $JD(".alert-danger").fadeTo(2000, 500).slideUp(500, function () {
                $JD(".alert-danger").slideUp(500);
            });

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

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Update Profile Picture</h4>
    </div>

    <div class="col-sm-4 text-center" id="confirm" runat="server">
    </div>

   <%-- <div class="col-sm-12">
        <span style="color: Red">Note:&nbsp; Image size should be less than 500 KB. <br />
         (Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank" style="color:blue;">Tinypng.com</a>)
         </span>
    </div>--%>
    <br />
    <div class="col-md-4">
        <asp:FileUpload ID="picup" runat="server" onchange="CheckUploadFile(this);" accept=".png,.jpg,.jpeg,.gif" />
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
            <asp:Button ID="btnInsert" runat="server" CssClass="btn btn-success" Text="Submit" ValidationGroup="aa" Style="display: none" OnClientClick="return ValidateFile()" OnClick="btnSubmit_Click" />&nbsp;
        </div>
        <div class="col-sm-6">
            <%--<button type="button" id="Button1" runat="server" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#myModal">Reject</button>--%>
            <asp:Button ID="btnreject" runat="server" Text="Reject" class="btn btn-danger" 
                 OnClientClick="return confirm('Are you sure you want to delete the current image?')" OnClick="btnReject_Click" />

        </div>
    </div>
    <div class="col-sm-12 card-group-row">
        <div class="col-sm-2">
            <asp:Image ID="imgUpload1" runat="server" Style="width: 100%" />
        </div>
        <div class="col-md-4">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="aa" />
            <div id="divPreview" style="width: 100px; height: 100px; overflow: hidden; margin: 0 auto; text-align: center;"></div>
        </div>
    </div>
    <br />

    <%--   <div id="myModal" class="modal fade" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document"> 
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
                   
                </div>
            </div>
        </div>
    </div>--%>
</asp:Content>

