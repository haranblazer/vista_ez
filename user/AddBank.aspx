<%@ Page Title="Bank Details" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="AddBank.aspx.cs" Inherits="user_AddBank" %>

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
//        $.noConflict(true);
       
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
                        aspectRatio: 16 / 9,
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

    function rotate() {
        $('#<%=imgUpload1.ClientID%>').cropper('rotate', -90);
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
                                        <li class="breadcrumb-item active" aria-current="page">Add Bank Details</li>
                                    </ol>
                </nav>
                <h1 class="m-0">
                    Add Bank Details</h1>
            </div>
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
    </div>
    <div class="container-fluid page__container">

    <div class="col-sm-4 text-center" id="confirm" runat="server">
       </div>

    <div class="panel card card-body">
            <div class="panel-heading" style="background: #315787; border-radius: 4px; color: #fff;
                padding: 10px; font-size: 16px">
                <i class="fa fa-university" aria-hidden="true"></i>&nbsp;Add Bank Details
            </div>
             <div class="panel-body">
                 <asp:Panel ID="Panel1" runat="server">
                     <div class="form-group">
                     <br />
                         <div class=" card-group-row">
                         <div class="col-sm-3">
                              Upload Cancel Cheque
                         </div>
                         <div class="col-md-4">
                            <asp:FileUpload ID="fileCancelCq" runat="server" onchange="CheckUploadFile(this);" />
                            <br />
                        </div>
                          <div class="col-sm-4"> 
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
                              <input ID="X" runat="server" type="hidden"/>
                             <input ID="Y" runat="server" type="hidden"/>
                             <input ID="W" runat="server" type="hidden"/>
                             <input ID="H" runat="server" type="hidden"/>
                             <input id="R" runat="server" type="hidden" />
                        </div> 
                             </div> 
                             <br />
                             <div class="card-group-row">
                          <div class="col-md-2">
                            Select Bank
                        </div>
                         <div class="col-md-4">
                            <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlBankName"
                                Display="None" ErrorMessage="Please Select Bank Name." ValidationGroup="aa" InitialValue="0"
                                SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </div>
                        
                       
                             <div class="col-md-2">
                            A/C Type
                        </div>
                             <div class="col-md-4">
                            <asp:DropDownList ID="ddlAcType" runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                                <asp:ListItem>SAVING A/C</asp:ListItem>
                                <asp:ListItem>CURRENT A/C</asp:ListItem>
                                <asp:ListItem>CC A/C</asp:ListItem>
                                <asp:ListItem>OD A/C</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlAcType"
                                InitialValue="0" SetFocusOnError="true" Display="None" ErrorMessage="Please Select  A/C Type."
                                ValidationGroup="aa"></asp:RequiredFieldValidator>
                        </div>
                            <div class="col-md-2">
                            A/C No.
                        </div>
                              <div class="col-md-4">
                            <div class="tooltiptest">
                                <span class="tooltiptext">Note: Put # before A/C No. for Excel Download Purpose.</span>
                                <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAccNo"
                                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter A/C Number."
                                    ValidationGroup="aa"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revACNo" runat="server" Display="None" ForeColor="Red"
                                    ValidationGroup="aa" ValidationExpression="^#?[0-9]*$" SetFocusOnError="true"
                                    ErrorMessage="Account Number Contains Numeric Value Without Space." ControlToValidate="txtAccNo"></asp:RegularExpressionValidator>
                           <br />
                            </div>
                        </div>
                                 <div class="col-md-2">
                                    Branch
                                </div>
                           <div class="col-md-4">
                            <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtbranch"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter  Branch." ValidationGroup="aa"></asp:RequiredFieldValidator>
                         <br />
                        </div>
                       
                      
                          <div class="col-sm-2">
                            IFS Code
                        </div>
                             <div class="col-sm-4">
                            <asp:TextBox ID="txtifs" runat="server" CssClass="form-control"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtifs"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter IFS Code." ValidationGroup="aa"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revIFSCode" runat="server" Display="None" ForeColor="Red"
                                ValidationGroup="aa" ValidationExpression="^[a-zA-Z0-9]*$" SetFocusOnError="true"
                                ErrorMessage="IFS Code Contains AlphaNumeric Value Without Space." ControlToValidate="txtifs"></asp:RegularExpressionValidator>
                        </div>
                       
                         </div>
                         
                             <div class="col-sm-2">
                             </div>
                             <div class="col-md-4">
                                  <asp:Button ID="btnInsert" runat="server" CssClass="btn btn-success"  onclick="btnInsert_Click"
                                Text="Crop & Submit" ValidationGroup="aa" style="display:none"/>&nbsp;
                                 <button type="button" id="btnreject" runat="server" value class="btn btn-danger" data-toggle="modal" data-target="#myModal" >Reject</button>
                            <%--<input id="btnBack" type="button" value="<< Back" class="btn btn-success" onclick="javascript:window.history.back();" />--%>
                             </div>
                             <div class="clearfix">
                             </div>
                         <div class="col-sm-12 card-group-row">
                             <div class="col-sm-6">
                                  <asp:Image ID="imgUpload1" runat="server" style="width:100%"/>
                             </div>
                             <div class="col-md-4">
                                  <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                ShowSummary="False" ValidationGroup="aa" />
                                  <%--<asp:button ID="rotateImg" CssClass="btn btn-default"  runat="server" text="Rotate 90" OnClientClick="rotate();return false" style="display:none;" />--%>
                                      <div id="divPreview" style="width:200px;height:200px;overflow:hidden;margin:0 auto;text-align:center;" ></div>
                             </div>
                         </div>
                     </div>
                      <div id="myModal" class="modal fade" role="dialog">
                              <div class="modal-dialog">

                                <!-- Modal content-->
                                <div class="modal-content">
                                  <div class="modal-header">
                                  <h4 class="modal-title">Rejecting cropped image</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                  </div>
                                  <div class="modal-body">
                                    <p>Are you sure you want to delete the current image !</p>
                                  </div>
                                  <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal">
                                                            No</button>
                                     <asp:button ID="Button1" runat="server"  text="Yes"  style="background-color:crimson; color: white;"  OnClick="btnReject_Click" />
                                  </div>
                                </div>

                              </div>
                            </div>
                     </asp:Panel>
                 </div>
            </div>
    </div>
    </div>
</asp:Content>