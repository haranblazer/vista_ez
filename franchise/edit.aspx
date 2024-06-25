<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="edit.aspx.cs" Inherits="admin_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script language="javascript" type="text/javascript">
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function GetUserName() {

            var FranType = $('#<%=ddltype.ClientID%>').val();
            var fMappingId = $('#<%=txt_fMappingId.ClientID%>').val();

            if (FranType == "0") {
                $('#lbl_fMappingId').text("Please Select Franchise Type.!!");
                return false;
            }
            if (fMappingId == "") {
                $('#lbl_fMappingId').text("Please Enter Franchise Mapping Id.!!");
                return false;
            }
            $('#lbl_fMappingId').text("");
            $.ajax({
                type: "POST",
                url: 'edit.aspx/GetUser',
                data: '{fMappingId: "' + fMappingId + '", FranType: "' + FranType + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#lbl_fMappingId').text(data.d.UserName);
                        $('#lbl_fMappingId').css('color', 'Blue');
                    }
                    else {
                        $('#<%=txt_fMappingId.ClientID%>').val('');
                        $('#lbl_fMappingId').text(data.d.Error);
                        $('#lbl_fMappingId').css('color', 'red');
                    }
                },
                error: function (response) {
                    $('#lbl_fMappingId').text("Server error. Time out.!!");
                    $('#lbl_fMappingId').css('color', 'red');
                }
            });
        }
    </script>



    <script type="text/javascript">
        //var attachments = {};
        //var pdfjsLib = window['pdfjs-dist/build/pdf'];
        // The workerSrc property shall be specified.
        //pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://mozilla.github.io/pdf.js/build/pdf.worker.js';

       <%-- $(function () {
            $("#<%=btnSubmit.ClientID%>").show();
           

            $("#<%=FileUploadDoc.ClientID%>").on("changes", function (e) {
                $("#<%=btnGst.ClientID%>").show();
                var file = e.target.files[0]
                if (file.type == "application/pdf") {
                    var fileReader = new FileReader();
                    fileReader.onload = function () {
                        var pdfData = new Uint8Array(this.result);
                        // Using DocumentInitParameters object to load binary data.
                        var loadingTask = pdfjsLib.getDocument({ data: pdfData });
                        loadingTask.promise.then(function (pdf) {
                            console.log('PDF loaded');

                            // Fetch the first page
                            var pageNumber = 1;
                            pdf.getPage(pageNumber).then(function (page) {
                                console.log('Page loaded');

                                var scale = 1.5;
                                var viewport = page.getViewport({ scale: scale });

                                // Prepare canvas using PDF page dimensions
                                var canvas = $("#pdfViewer")[0];
                                var context = canvas.getContext('2d');
                                canvas.height = viewport.height;
                                canvas.width = viewport.width;

                                // Render PDF page into canvas context
                                var renderContext = {
                                    canvasContext: context,
                                    viewport: viewport
                                };
                                var renderTask = page.render(renderContext);
                                renderTask.promise.then(function () {
                                    console.log('Page rendered');
                                });
                            });
                        }, function (reason) {
                            // PDF loading error
                            console.error(reason);
                        });
                    };
                    fileReader.readAsArrayBuffer(file);
                }
            });
            ///////   

        })--%>






        // show img
      <%--  function ShowImagePreview(input, tag) {
            var fileName = input.files[0].name;
            var tag = tag;
            var validExtensions = ['jpg', 'png', 'jpeg'];
            var fileName = input.files[0].name;
            var fileNameExt = fileName.substr(fileName.lastIndexOf('.') + 1);
            if ($.inArray(fileNameExt, validExtensions) == -1) {
                debugger;
                input.type = ''
                input.type = 'file'
                $('#<%=Button1.ClientID%>').css('display', 'none');
                $('#<%=btnInsert.ClientID%>').css('display', 'none');
            } else {

                if (input.files && input.files[0] && tag === 0) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=approveRejectimg.ClientID%>').css('display', 'none');
                        $('#<%=imgUpload.ClientID%>').attr('src', e.target.result);
                        $('#<%=lblMsg.ClientID%>').hide();
                        //var tempFileData = e.target.result;
                        //var image = $('#imgUpload')[0];
                        var $ele = $('#<%=FileUpload1.ClientID%>');
                        $('#<%=Button1.ClientID%>').css("display", "block");
                        $ele.cropper({
                            aspectRatio: 16 / 9,
                            preview: "#divPreview1", 
                            imageSmoothingEnabled: false,
                            imageSmoothingQuality: 'high', 
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

                if (input.files && input.files[0] && tag === 1) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=imgUpload1.ClientID%>').attr('src', e.target.result);
                        $('#<%=lblMsg1.ClientID%>').hide();
                        var tempFileData = e.target.result;
                        var image = $('#imgUpload1')[0];
                        var $ele1 = $('#<%=imgUpload1.ClientID%>');
                        $('#<%=btnInsert.ClientID%>').css("display", "block");
                        $ele1.cropper({
                            aspectRatio: 16 / 9,
                            preview: "#divPreviewbank",
                            rotatable: true,
                            crop: function (c) {
                                $('#<%=X1.ClientID%>').val(parseInt(c.detail.x));
                                    $('#<%=Y1.ClientID%>').val(parseInt(c.detail.y));
                                    $('#<%=W1.ClientID%>').val(parseInt(c.detail.width));
                                    $('#<%=H1.ClientID%>').val(parseInt(c.detail.height));
                                }
                            })
                    }
                    reader.readAsDataURL(input.files[0]);
                }


                if (input.files && input.files[0] && tag === 2) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        //$('#<%=FileUploadDoc.ClientID%>').attr('src', e.target.result);
                        $('#<%=Img_GST.ClientID%>').attr('src', e.target.result);

                        var $ele1 = $('#<%=FileUploadDoc.ClientID%>');
                        $ele1.cropper({
                            aspectRatio: 16 / 9,
                            //preview: "#divPreviewGST",
                            rotatable: true,
                            crop: function (c) {
                                $('#<%=XG1.ClientID%>').val(parseInt(c.detail.x));
                                $('#<%=XG2.ClientID%>').val(parseInt(c.detail.y));
                                $('#<%=XG3.ClientID%>').val(parseInt(c.detail.width));
                                $('#<%=XG4.ClientID%>').val(parseInt(c.detail.height));
                            }
                        })
                    }
                    reader.readAsDataURL(input.files[0]);
                }


                if (input.files && input.files[0] && tag === 3) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=FU_AadharFront.ClientID%>').attr('src', e.target.result);
                        $('#<%=imgUploadAadharFront.ClientID%>').attr('src', e.target.result);

                        var $ele1 = $('#<%=FU_AadharFront.ClientID%>');
                        $ele1.cropper({
                            aspectRatio: 16 / 9,
                            //preview: "#divPreviewGST",
                            rotatable: true,
                            crop: function (c) {
                                $('#<%=AF1.ClientID%>').val(parseInt(c.detail.x));
                                $('#<%=AF2.ClientID%>').val(parseInt(c.detail.y));
                                $('#<%=AF3.ClientID%>').val(parseInt(c.detail.width));
                                $('#<%=AF4.ClientID%>').val(parseInt(c.detail.height));
                            }
                        })
                     }
                     reader.readAsDataURL(input.files[0]);
                }

               

                if (input.files && input.files[0] && tag === 4) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=FU_AadharBack.ClientID%>').attr('src', e.target.result);
                        $('#<%=imgUploadAadharBack.ClientID%>').attr('src', e.target.result);

                        var $ele1 = $('#<%=FU_AadharBack.ClientID%>');
                        $ele1.cropper({
                            aspectRatio: 16 / 9,
                            //preview: "#divPreviewGST",
                            rotatable: true,
                            crop: function (c) {
                                $('#<%=AB1.ClientID%>').val(parseInt(c.detail.x));
                                $('#<%=AB2.ClientID%>').val(parseInt(c.detail.y));
                                $('#<%=AB3.ClientID%>').val(parseInt(c.detail.width));
                                $('#<%=AB4.ClientID%>').val(parseInt(c.detail.height));
                            }
                        })
                     }
                     reader.readAsDataURL(input.files[0]);
                 }


            }

        }--%>

    </script>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Change Your Profile</h4>
    </div>
    <div class="panel panel-default">
        <div class="col-md-12">
            <div class="clearfix">
            </div>
            <div class="">
                <div class="row">
                    <div class="col-md-12">
                        <asp:Panel ID="PnlConfirmation" DefaultButton="btnConfirm" runat="server" Visible="false"
                            Style="background-color: rgb(239,249,200); color: black; border-radius: 5px;">
                            <div class="Title">
                                <h2 class="head">Confirmation</h2>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-2">
                                    Franchise Type :
                                </div>
                                <div class="col-sm-4 ">
                                    <asp:Label class="txt2" ID="lblFranType" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>

                            <div class="form-group" style="display: none;">
                                <div class="col-sm-2">
                                    Franchise Sponsor Id :
                                </div>
                                <div class="col-sm-4">
                                    <asp:Label class="txt2" ID="lblFranSponId" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>

                            <div class="form-group" style="display: none;">
                                <div class="col-sm-2">
                                    Sponsor Name :
                                </div>
                                <div class="col-sm-4">
                                    <asp:Label class="txt2" ID="lblFranSponName" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-2">
                                    Franchise Name :
                                </div>
                                <div class="col-sm-4">
                                    <asp:Label class="txt2" ID="lblFranName" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-2">
                                    Mobile No :
                                </div>
                                <div class="col-sm-4">
                                    <asp:Label class="txt2" ID="lblMobileNo" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-2">
                                    Email Id :
                                </div>
                                <div class="col-sm-4">
                                    <asp:Label class="txt2" ID="lblEmail" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-2">
                                    Franchise Id :
                                </div>
                                <div class="col-sm-4">
                                    <asp:Label ID="lblFID" Style="display: none;" runat="server"></asp:Label>
                                    <asp:Label class="txt2" ID="lblUserID" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-2">
                                    Password :
                                </div>
                                <div class="col-sm-4">
                                    <asp:Label class="txt2" ID="lblpassword" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>

                            <div class="form-group">
                                <div class="col-sm-2">
                                </div>
                                <div class="col-sm-4 ">
                                    <asp:Button ID="btnConfirm" runat="server" CausesValidation="true" CssClass="btn btn-success"
                                        Text="Confirm" OnClick="btnConfirm_Click" />
                                    &nbsp;
                                    <asp:Button ID="btnEdit" runat="server" CausesValidation="true" CssClass="btn btn-success"
                                        Text="Edit" OnClick="btnEdit_Click" />
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>

                        </asp:Panel>
                    </div>
                </div>
            </div>



            <asp:Panel ID="CreateFran" DefaultButton="btnSubmit" runat="server">
                <div style="padding-top: 0px;">
                    <div class="IP_Addres">
                        <%-- Your current IP address --%>
                        <h2 class="head">
                            <i class="fa fa-podcast" aria-hidden="true"></i>&nbsp;Edit Franchise</h2>
                    </div>
                    <div class="clearfix">
                    </div>

                    <div class="col-sm-12" style="margin: 0px; padding: 0px;">
                        <div class="form-horizontal" style="margin: 0px; padding: 0px;">
                            <div class="">
                                <div class="panel-body">
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2  control-label" style="text-align: left">
                                            Franchise Type:</label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddltype" runat="server" TabIndex="1" CssClass="form-control" Enabled="false">
                                            </asp:DropDownList>

                                        </div>

                                        <label class="col-sm-2 control-label" style="text-align: left">
                                            Franchise Mapping Id:
                                        </label>
                                        <div class="col-sm-4">

                                            <asp:TextBox ID="txt_fMappingId" runat="server" MaxLength="20" CssClass="form-control"
                                                placeholder="Enter Franchise Mapping Id" onchange="GetUserName();" Enabled="false"></asp:TextBox>
                                            <span id="lbl_fMappingId"></span>

                                        </div>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="form-horizontal">
                            <div class="">
                                <h2 class="head" style="margin-top: -5px;">
                                    <i class="fa fa-address-book-o" aria-hidden="true"></i>&nbsp;Franchise Personal
                                    Details
                                </h2>
                                <div class="panel-body">
                                    <div class="clearfix">
                                    </div>

                                    <div class="form-group row">

                                        <label class="col-sm-2 control-label" style="text-align: left;">
                                            Contact Person:
                                        </label>
                                        <div class="col-sm-4">
                                            <asp:UpdatePanel ID="UpdatePanelFran" runat="server">
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="txtsponsorid" EventName="TextChanged" />
                                                </Triggers>
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtContactPerson" runat="server" TabIndex="10" CssClass="form-control"
                                                        placeholder="Enter Contact Person Name" Enabled="false"></asp:TextBox>
                                                    <asp:TextBox ID="txtsponsorid" runat="server" MaxLength="10" TabIndex="2" CssClass="form-control" Style="display: none;"
                                                        placeholder="Enter Franchise Sponsor ID" AutoPostBack="true" OnTextChanged="txtsponsorid_TextChanged" Enabled="false"></asp:TextBox>
                                                    <asp:Label ID="lblFranSpon" runat="server"></asp:Label>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>



                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Franchise Name:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4 col-xs-9" style="padding-bottom: 15px;">
                                            <asp:TextBox ID="txtName" class="searchbox" runat="server" TabIndex="3" CssClass="form-control"
                                                placeholder="Enter Your Name" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Mobile No:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" TabIndex="4" CssClass="form-control"
                                                placeholder="Enter 10 Digits Mobile No" Enabled="false"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            E-Mail Id:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4" style="padding-bottom: 15px;">
                                            <asp:TextBox ID="txtEMailId" runat="server" TabIndex="5" CssClass="form-control"
                                                placeholder="Enter E-mail Id" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-xs-3 control-label"
                                            style="text-align: left">
                                            Address:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4" style="padding-bottom: 15px;">
                                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" TabIndex="8" CssClass="form-control"
                                                placeholder="Enter Address" Enabled="false"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            State:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" TabIndex="6"
                                                OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" Enabled="false">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            District:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4" style="padding-bottom: 15px;">
                                            <asp:UpdatePanel ID="UpdateDistrictPanel" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" TabIndex="7" Enabled="false">
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlState" EventName="SelectedIndexChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            City:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtCity" runat="server" TabIndex="8" CssClass="form-control" placeholder="Enter City" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Pin Code:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtPinCode" runat="server" MaxLength="6" TabIndex="9" CssClass="form-control"
                                                placeholder="Enter Pin Code" Enabled="false"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            CIN No:</label>
                                        <div class="col-sm-4 ">
                                            <asp:TextBox ID="txtCinNo" class="searchbox" runat="server" TabIndex="13" CssClass="form-control"
                                                placeholder="Enter CIN No" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row" style="display: none;">


                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Sample Allowed:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4 col-xs-9 control-label">
                                            <asp:RadioButtonList ID="rblsampleal" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>

                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">

                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                        </label>
                                        <div class="col-sm-4" style="padding-bottom: 15px;">
                                        </div>

                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group" style="display: none;">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Franchise Limit:<span style="color: Red">*</span>
                                        </label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtflimit" class="searchbox" runat="server" TabIndex="14" CssClass="form-control"
                                                onKeyPress="return onlyNumbers(this);" placeholder="Enter Franchise limit" MaxLength="7" Enabled="false">0</asp:TextBox>
                                        </div>
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Franchise Commission:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtfcom" class="searchbox" runat="server" TabIndex="14" CssClass="form-control"
                                                onKeyPress="return onlyNumbers(this);" placeholder="Enter Franchise commission"
                                                MaxLength="2" Enabled="false">0</asp:TextBox>
                                            <label class="col-sm-5  control-label"
                                                style="text-align: left">
                                                <span style="color: Red">* Up to 99 %</span></label>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                </div>
                            </div>
                        </div>



                        <%--******************Bank details--%>
                        <div class="clearfix"></div>
                        <div class="form-horizontal">
                            <div class="">
                                <div class="head">
                                    <i class="fa fa-university"></i>&nbsp;Bank Details
                                </div>
                                <div class="panel-body">
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Bank Name:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlbankname" runat="server" CausesValidation="True" CssClass="form-control"
                                                ValidationGroup="C" Enabled="false">
                                            </asp:DropDownList>
                                        </div>
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            Branch:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtbranch" runat="server" CausesValidation="True" CssClass="form-control"
                                                placeholder="Branch" MaxLength="50" ValidationGroup="C" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label"
                                            style="text-align: left">
                                            A/C:<span style="color: Red">*</span></label>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtaccountno" runat="server" ValidationGroup="C" CssClass="form-control"
                                                placeholder="Account Number" MaxLength="20" CausesValidation="True" Enabled="false"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" SetFocusOnError="true"
                                                ErrorMessage="please Enter Account No Maximum 20 Alphanumeric Values are allowed in Account Number"
                                                Display="None" ValidationExpression="^[a-zA-Z0-9]{1,20}$" ControlToValidate="txtaccountno"
                                                ForeColor="#CC0000" ValidationGroup="cp"> please Enter Account No Maximum 20 Alphanumeric values are allowed in Account Number</asp:RegularExpressionValidator>
                                        </div>
                                        <label class="col-sm-2 col-xs-3 control-label"
                                            style="text-align: left">
                                            A/C Type:<span style="color: Red">*</span></label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlactype" runat="server" CssClass="form-control" Enabled="false">
                                                <asp:ListItem>CURRENT A/C</asp:ListItem>
                                                <asp:ListItem>SAVING A/C</asp:ListItem>
                                                <asp:ListItem>OD A/C</asp:ListItem>
                                                <asp:ListItem>CC A/C</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-xs-3 control-label"
                                            style="text-align: left">
                                            IFSC:<span style="color: Red">*</span></label>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtifsc" runat="server" CssClass="form-control" CausesValidation="True"
                                                placeholder="IFSC Code" MaxLength="11" Enabled="false"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator22" runat="server"
                                                SetFocusOnError="true" ControlToValidate="txtifsc" Display="None" ValidationGroup="C"
                                                ErrorMessage="please Enter IFS code  11 Characters Alpha Numeric Value  Allowed!"
                                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[A-Za-z0-9]{1,11}$">
                                            </asp:RegularExpressionValidator>
                                        </div>

                                        <div class="col-sm-2 text-center">
                                            <input type="file" id="img_Bank" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Bank();" style="display: none;" />
                                            <label id="uploadimg_Bank" runat="server" for="img_Bank" title="Bank" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>

                                        </div>
                                        <div class="col-sm-3">


                                            <div id="lbl_BankImg" runat="server"></div>
                                        </div>

                                        <div class="col-sm-1">
                                            <input type="button" id="btn_BANK_R" runat="server" onclick="UpdateReject('BANK')" value="Reject" class="btn btn-danger" />
                                            <div id="div_Bank_Appv_Reject" runat="server" />
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>



                    <%--******************PAN details--%>
                    <div class="form-horizontal">
                        <div class="">
                            <div class="head">
                                <i class="fa fa-university"></i>&nbsp;Pan Details
                            </div>

                            <div class="form-group row" style="padding-top: 10px;">
                                <div class="col-md-2">
                                    <label class="control-label" style="text-align: justify">
                                        PAN No:<span style="color: Red">*</span></label>
                                </div>
                                <div class="col-md-4">
                                    <asp:TextBox ID="txtPanNo" runat="server" CssClass="form-control" placeholder="Enter PAN Number" MaxLength="10" Enabled="false"></asp:TextBox>
                                    <input type="file" id="img_Pan" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Pan();" style="display: none;" />
                                </div>

                                <div class="col-md-2 text-center">

                                    <label id="uploadimg_Pan" runat="server" for="img_Pan" title="Pan Card" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                                </div>
                                <div class="col-sm-3">
                                    <div id="lbl_PanImg" runat="server"></div>
                                </div>
                                <div class="col-md-1">
                                    <input type="button" id="btn_Pan_R" runat="server" onclick="UpdateReject('PAN')" value="Reject" class="btn btn-danger" />

                                    <div id="div_Pan_Appv_Reject" runat="server" />
                                </div>

                            </div>

                        </div>
                    </div>

                </div></asp:Panel>
        </div>
        <div class="clearfix">
        </div>
        <br />



        <%--Aadhar Details start--%>

        <div class="form-horizontal">
            <div class="">
                <div class="head">
                    <i class="fa fa-university"></i>&nbsp;Address Details
                </div>


                <%--  <div class="alert alert-primary alert-dismissible fade show">
                    <strong>&nbsp;Note:</strong> Please upload front as well as back image of Address Proof.
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close"></button>
                </div>--%>


                <div class="form-group row" style="padding-top: 10px;">

                    <div class="col-sm-2 control-label">
                        Address Proof ID:
                    </div>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtAadharNo" runat="server" CssClass="form-control" MaxLength="20" placeholder="Please Enter Aadhar Number" Enabled="false"></asp:TextBox>
                    </div>


                </div>


                <div class="form-group row" style="padding-top: 10px;">
                    <div class="col-sm-2 control-label text-center">
                        <label for="img_Aadhar_Front" runat="server" title="Aadhar Card Front" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                        <div classp="clearfix"></div>
                        Upload front image   
                        <input type="file" id="img_Aadhar_Front" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Aadhar_Front();" style="display: none;"/>
                    </div>

                    <div class="col-sm-4">
                        <div id="lbl_AadharFrontImg" runat="server"></div>
                    </div>


                    <div class="col-sm-2 control-label text-center">
                        <input type="file" id="img_Aadhar_Back" accept=".png,.jpg,.jpeg,.gif" onchange="javascript:Upload_Aadhar_Back();" style="display: none;"  />
                        <label id="uploadimg_Aadhar" runat="server" for="img_Aadhar_Back" title="Aadhar Card Back" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                        <div class="clearfix"></div>
                        Upload back image    
                    </div>

                    <div class="col-sm-3">
                        <div id="lbl_AadharBackImg" runat="server"></div>
                    </div>


                    <div class="col-sm-1">
                        <input type="button" id="btn_AADHAR_R" runat="server" onclick="UpdateReject('AADHAR')" value="Reject" class="btn btn-danger" />
                    </div>
                    <div class="col-sm-3">
                        <div id="div_Aadhar_Appv_Reject" runat="server" />
                    </div>
                    <br />
                </div>

                <div class="clearfix">
                </div>

            </div>
        </div>




        <%--Payment Slip--%>

        <div class="form-horizontal">
            <div class="">
                <div class="head">
                    <i class="fa fa-university"></i>&nbsp;Payment Slip
                </div>
                <div class="form-group row" style="padding-top: 10px;">

                    <div class="col-sm-2 control-label">
                    </div>

                    <div class="col-sm-3">
                        <div id="lbl_Slipimg" runat="server"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <%--******************GST details--%>
        <div class="form-horizontal">
            <div class="">
                <div class="head">
                    <i class="fa fa-university"></i>&nbsp;GST Details
                </div>
                <div class="form-group row" style="padding-top: 10px;">
                    <label class="col-sm-2 control-label"
                        style="text-align: left">
                        GST No:
                    </label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtGSTNo" runat="server" TabIndex="14" CssClass="form-control"
                            placeholder="Enter GST No" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <input type="file" id="img_Gst" accept=".pdf" onchange="javascript:Upload_GST();" style="display: none;"  />
                        <label id="uploadimg_GST" runat="server" for="img_Gst" title="GST" style="width: 150px;"><i class="fa fa-upload btn btn-success" aria-hidden="true"></i></label>
                    </div>
                    <div class="col-sm-3">
                        <div id="lbl_GSTImg" runat="server"></div>
                    </div>
                    <div class="col-sm-1">
                        <input type="button" id="btn_GST_R" runat="server" onclick="UpdateReject('GST')" value="Reject" class="btn btn-danger" />
                        <div id="div_Gst_Appv_Reject" runat="server" />
                    </div>
                </div>
                <div class="form-group row" style="padding-top: 10px;">
                    <label class="col-sm-2 control-label">
                        Upload date:
                    </label>
                    <div class="col-sm-4 control-label">
                        <span id="lbl_GST_upload_date" runat="server"></span>
                    </div>
                    <div class="col-sm-2 control-label">
                        Approved date:
                    </div>

                    <div class="col-sm-4 control-label">
                        <span id="lbl_GST_approve_date" runat="server"></span>
                    </div>
                </div>


                <div class="clearfix"></div>
                <hr />
                <div class="form-group" id="div_gst_decl" runat="server" visible="false">

                    <div class="col-sm-12">
                        <div style="border: 1px solid #f5f5f5">
                            <p><strong><span id="lbl_CompanyName" runat="server"></span></strong></p>
                            <p><strong>CIN:</strong> <span id="lbl_CompanyCIN" runat="server"></span></p>
                            <p>
                                <strong>Regd Address:</strong> <span id="lbl_CompanyAddress" runat="server"></span>
                            </p>

                            <p><strong>Subject:</strong> Declaration for not obtaining registration under Central Goods and Services Tax Act, 2017, State Goods and Services Tax Act and Union Territory Goods and Services Tax Act</p>

                            <p>Dear Sir,</p>
                            <p>This is to inform you that the value of our aggregate turnover comprising of supply of goods or services or both in a financial year does not exceed Rupees Twenty lakhs.</p>
                            <p>In lieu of the same, we are not liable for obtaining registration under the aforesaid GST Laws.</p>
                            <p>We provide our consent that in case our total turnover exceeds INR 20 lakhs in a financial year, we will obtain registration under GST Law and will promptly communicate you with the relevant details including GSTIN.</p>
                            <p><strong><span id="lbl_CompanyName1" runat="server"></span></strong>shall have the right to recover all losses of tax along with consequential interest and penalty suffered by it due to incorrect declaration made in this regard.</p>

                            <p>Thank you</p>
                            <p>Franchise Name – <span id="lbl_GST_FranName" runat="server"></span></p>

                            <p>Signature and Seal – <span id="lbl_GST_Datetime" runat="server"></span></p>

                            <asp:Button ID="btn_gst_decl_Accept" runat="server" Text="Accept" CssClass="btn btn-success pull-right" OnClick="btn_gst_decl_Accept_Click" Enabled="false" />
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>

            </div>
        </div>


        <div class="clearfix">
        </div>
        <div class="form-horizontal">
            <div class="">
                <h2 class="head" style="margin-top: -5px;">
                    <i class="fa fa-lock" aria-hidden="true"></i>&nbsp;Security Details</h2>
                <div class="panel-body">
                    <div class="clearfix">
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label" style="text-align: left">
                            Password:<span style="color: Red">*</span>
                        </label>
                        <div class="col-sm-4" style="padding-bottom: 15px;">
                            <asp:TextBox ID="txtPassword" class="searchbox" runat="server" TabIndex="15"
                                placeholder="Enter Password" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label"
                            style="text-align: left">
                            Confirm Password:<span style="color: Red">*</span></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtConfirmPassword" class="searchbox" runat="server" TabIndex="16" CssClass="form-control"
                                placeholder="Enter Confirm Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-2 ">
                            Enter OTP
                        </div>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtotp" runat="server" MaxLength="10" Style="background-color: transparent;" CssClass="form-control"
                                placeholder="Plz. Enter OTP" Visible="false"></asp:TextBox>
                            <span id="otp_successMsg"></span>
                        </div>
                        <div class="col-sm-6 " id="div_Otp">
                            <a id="btn_otp" href="#/" cssclass="btn btn-success" onclick="GetOTP()">Generate OTP</a>

                            <asp:Button ID="Button2" runat="server" OnClick="btnSubmit_Click" Text="Submit" CssClass="btn btn-primary" />
                        </div>
                        <div class="col-sm-2 ">
                            <a id="vOTP" style="display: none;" class="btn btn-outline-info" onclick="GetOTPverified()">Verify OTP</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>




        <!----End------------------->
        <div class="clearfix"></div>
        <br />
        <div class="col-sm-2 col-xs-3">
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit Details"
                ValidationGroup="C" CssClass="btn btn-success" TabIndex="17" />
            <br />
            <asp:Label ID="lbl_Msg" runat="server" ForeColor="Red"></asp:Label>
        </div>

        <asp:RequiredFieldValidator ID="fnamExp" runat="server" SetFocusOnError="true" ControlToValidate="txtName"
            Display="None" ErrorMessage="Please enter name !" Font-Bold="False" ForeColor="#C00000"
            Style="z-index: 100; left: 20px; position: relative; top: 0px; width: 95px;"
            ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="addExp0" runat="server" ControlToValidate="txtMobileNo"
            SetFocusOnError="true" Display="None" ErrorMessage="Please enter mobile no!"
            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server"
            SetFocusOnError="true" ControlToValidate="txtMobileNo" Display="None" ErrorMessage="Please enter valid mobile number !"
            ForeColor="#C00000" ValidationExpression="^[6-9][0-9]{9}$" ValidationGroup="C"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEMailId"
            SetFocusOnError="true" Display="None" ErrorMessage="Please enter email id!" ForeColor="#C00000"
            ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEMailId"
            SetFocusOnError="true" Display="None" ValidationGroup="C" ErrorMessage="Email should be like abc@xyz.com !"
            ForeColor="#C00000" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlState"
            SetFocusOnError="true" Display="None" ErrorMessage="Please Select State" ForeColor="#C00000"
            ValidationGroup="C" InitialValue="0"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlDistrict"
            SetFocusOnError="true" Display="None" ErrorMessage="Please Select District."
            ForeColor="#C00000" ValidationGroup="C" InitialValue="0"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="cityExp" runat="server" ControlToValidate="txtCity"
            SetFocusOnError="true" Display="None" ErrorMessage="Please enter city !" ForeColor="#C00000"
            ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator19" runat="server"
            SetFocusOnError="true" ControlToValidate="txtCity" Display="None" ErrorMessage="Only alphabets are allowed in city"
            ValidationExpression="^[a-zA-Z][a-zA-Z\s]*$" ValidationGroup="C"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="addExp" runat="server" ControlToValidate="txtAddress"
            SetFocusOnError="true" Display="None" ErrorMessage="Please enter address!" ForeColor="#C00000"
            ValidationGroup="C"></asp:RequiredFieldValidator>
        &nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" SetFocusOnError="true" runat="server"
                            ControlToValidate="txtPinCode" Display="None" ErrorMessage="Please enter pin code!"
                            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator16" SetFocusOnError="true"
            runat="server" ControlToValidate="txtPinCode" Display="None" ErrorMessage="Please enter numeric 6 digit valid pin code !"
            ForeColor="#C00000" ValidationExpression="^[1-8][0-9]{5}$" ValidationGroup="C"></asp:RegularExpressionValidator>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                         
        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
            SetFocusOnError="true" ControlToValidate="txtPanNo" Display="None" ErrorMessage="Please enter valid PAN No.!"
            ForeColor="#C00000" ValidationExpression="[A-Z]{5}[0-9]{4}[A-Z]{1}"
            ValidationGroup="C"></asp:RegularExpressionValidator>

        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" InitialValue="0"
            ErrorMessage="Please Seelct Bank" ControlToValidate="ddlbankname" SetFocusOnError="true"
            Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Enter Bank Brach Name"
            ControlToValidate="txtbranch" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter A/c No."
            ControlToValidate="txtaccountno" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Please Enter IFSC Code"
            ControlToValidate="txtifsc" SetFocusOnError="true" Display="None" ValidationGroup="C"></asp:RequiredFieldValidator>

        <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtConfirmPassword"
            SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Password !"
            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="rfvConfirmpwd" runat="server" ControlToValidate="txtPassword"
            SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Confirm Password !"
            ForeColor="#C00000" ValidationGroup="C"></asp:RequiredFieldValidator>
        <%-- <asp:RegularExpressionValidator ID="revConfirmPass" SetFocusOnError="true" runat="server"
            ControlToValidate="txtPassword" Display="None" ErrorMessage="Password should be minimum of 6 characters mix of alphanumeric!"
            ForeColor="#C00000" ValidationExpression="^[A-Za-z0-9]{6,16}$" ValidationGroup="C"></asp:RegularExpressionValidator>--%>
        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword"
            ControlToValidate="txtConfirmPassword" ErrorMessage="Password Mismatch !" Font-Bold="True"
            ForeColor="#C00000" Style="left: 0px; position: relative" ValidationGroup="C"
            Display="None" SetFocusOnError="True"></asp:CompareValidator>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            HeaderText="Please check the following..." ShowSummary="False" ValidationGroup="C"
            Width="209px" />
    </div>
   
    </div>
    <div class="clearfix"></div>




    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>



    <script type="text/javascript">
        var pageUrl = "edit.aspx";
        $(function () {

            $("[id*=img_Pan]").change(function () {
               
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=lbl_PanImg.ClientID%>'); //  $('#lbl_PanImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="150px" height="100px"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Pan').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Bank]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=lbl_BankImg.ClientID%>'); //$('#lbl_BankImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="150px" height="100px"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Bank').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Aadhar_Front]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=lbl_AadharFrontImg.ClientID%>'); // $('#lbl_AadharFrontImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="150px" height="100px"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Aadhar_Front').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Aadhar_Back]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=lbl_AadharBackImg.ClientID%>');  //$('#lbl_AadharBackImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <img src="' + e.target.result + '" width="150px" height="100px"> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Aadhar_Back').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=img_Gst]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=lbl_GSTImg.ClientID%>');  //$('#lbl_GSTImg');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp|.pdf)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $('<a href="' + e.target.result + '"  data-fancybox="gallery"> <i class="fa fa-eye btn btn-primary"></i> </a>');
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#img_Gst').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });

        });


        function Upload_Pan() {
         

            var fileUpload = $("#img_Pan").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FPan" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Pan = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{flag: "PAN", ImgName: "' + ImgName_Pan + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#<%=btn_Pan_R.ClientID%>').css('display', 'block');
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });


                    },
                    error: function (err) { }
                });
            }
        }




        function Upload_Bank() {

            var fileUpload = $("#img_Bank").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FBank" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Bank = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{flag: "BANK", ImgName: "' + ImgName_Bank + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#<%=btn_BANK_R.ClientID%>').css('display', 'block');
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });
                    },
                    error: function (err) { }
                });
            }
        }


        function Upload_Aadhar_Front() {

            var fileUpload = $("#img_Aadhar_Front").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FAadhar_Front" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Aadhar_Front = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{flag: "AADHARFRONT", ImgName: "' + ImgName_Aadhar_Front + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#<%=btn_AADHAR_R.ClientID%>').css('display', 'block');
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });

                    },
                    error: function (err) { }
                });
            }
        }

        function Upload_Aadhar_Back() {

            var fileUpload = $("#img_Aadhar_Back").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FAadhar_Back" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    ImgName_Aadhar_Back = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{flag: "AADHARBACK", ImgName: "' + ImgName_Aadhar_Back + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    $('#<%=btn_AADHAR_R.ClientID%>').css('display', 'block');
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });

                    },
                    error: function (err) { }
                });
            }
        }

        function Upload_GST() {

            var fileUpload = $("#img_Gst").get(0);
            var files = fileUpload.files;
            if (files != null) {
                var data = new FormData();
                var random = Math.floor(100000 + Math.random() * 9000000);
                random = "FGST" + random;
                for (var i = 0; i < files.length; i++) {
                    var ext = files[i].name.split(".");
                    ext = ext[ext.length - 1].toLowerCase();

                    data.append(random + '.' + ext, files[i]);
                    GST_img = random + '.' + ext;
                }
                var _URL = window.URL || window.webkitURL;
                $.ajax({
                    url: "../FranchiseHandler.ashx",
                    type: "POST",
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (result) {

                        $.ajax({
                            type: "POST",
                            url: pageUrl + '/UpdateImage',
                            data: '{flag: "GST", ImgName: "' + GST_img + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == '1') {
                                    window.location = "edit.aspx";
                                    //$('#<%=btn_GST_R.ClientID%>').css('display', 'block');
                                } else {
                                    alert(data.d);
                                    return
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });

                    },
                    error: function (err) { }
                });
            }
        }




        function UpdateReject(flag) {
            if (!confirm('Are you sure you want to Reject.!!')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateReject',
                data: '{flag: "' + flag + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "SessionOut") {
                        window.location = "Logout.aspx";
                    }
                    else if (data.d == "1") {
                        window.location = "edit.aspx";

                    } else {
                        alert(data.d.Error);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }





    </script>



    <script type="text/javascript">
        /*--------------------------*/
        $(function () {
            if ($('#<%=hnd_OTPVFYD.ClientID%>').val() == "1") {
                $('#div_Otp').hide();
                $('#otp_successMsg').html('<div class="alert alert-success" role="alert">OTP Verified.</div >');
            }
        });

        <%--function btnRejectKYC_Click(id) {

            if ($('#<%=imgUpload.ClientID%>').attr('src') != '' || $('#<%=imgUpload1.ClientID%>').attr('src') != '' || $('#<%=ltEmbed.ClientID%>').attr('src') != '') {
                if (id == '1' || id == '2' || id == '3') {
                    $.ajax({
                        type: "POST",
                        url: 'edit.aspx/btnRejectKYC_Click',
                        data: '{kycid: "' + id + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            console.log("data");
                            $('#lblmsg').text(data.d);
                            if (id == '1') {
                                $("#Div2").css("display", "none");
                                $('#<%=txtPanNo.ClientID%>').removeAttr('readonly');
                                $('#<%=FileUpload1.ClientID%>').removeAttr('disabled');
                                $('#<%=imgUpload.ClientID%>').attr("src", "");
                                $('#<%=approveRejectimg.ClientID%>').attr("src", "../images/pendingStamp.png");
                                $('#<%=btnreject.ClientID%>').css('display', 'none');
                                $('.modal-backdrop').css("display", "none");
                                $('body').css('overflow', 'auto');
                            }

                            if (id == '2') {
                                $("#Div1").css("display", "none");
                                $('#<%=txtbranch.ClientID%>').removeAttr('disabled');
                                $('#<%=txtifsc.ClientID%>').removeAttr('disabled');
                                $('#<%=txtaccountno.ClientID%>').removeAttr('disabled');
                                $('#<%=ddlbankname.ClientID%>').removeAttr('disabled');
                                $('#<%=ddlactype.ClientID%>').removeAttr('disabled');
                                $('#<%=fileCancelCq.ClientID%>').removeAttr('disabled');
                                $('#<%=imgUpload1.ClientID%>').attr("src", "");
                                $('#<%=approveRejectImg1.ClientID%>').attr("src", "../images/pendingStamp.png");
                                $('#<%=btnreject1.ClientID%>').css('display', 'none');
                                $('.modal-backdrop').css("display", "none");
                                $('body').css('overflow', 'auto');
                            }

                            if (id == '3') {
                                $("#Div3").css("display", "none");
                                
                                $('#<%=approveRejectImage2.ClientID%>').attr("src", "../images/pendingStamp.png");
                                $('#<%=btnrejectPdf.ClientID%>').css('display', 'none');
                                $('.modal-backdrop').css("display", "none");
                                $('body').css('overflow', 'auto');
                                setTimeout("location.reload(true);", 5000);
                            }

                        },
                        error: function (response) {
                            $('#lblmsg').text("Server error. Time out.!!");

                        }
                    });
                }

            }
        }--%>

        /*--------------------------*/



        function GetOTP() {

            $.ajax({
                type: "POST",
                url: 'edit.aspx/generateOTP',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '0') {
                        $('#btn_otp').html('Re-Generate OTP');
                        $('#vOTP').show();
                    }
                },
                error: function (response) { }
            });
        }



        function GetOTPverified() {

            var telno = $('#<%=txtMobileNo.ClientID %>').val();
            var OTP = $('#<%=txtotp.ClientID %>').val().trim();
            $("#<%=(btnSubmit.ClientID)%>").show();
            $.ajax({
                type: "POST",
                url: 'edit.aspx/verifyOTP',
                contentType: "application/json; charset=utf-8",
                data: '{telno: "' + telno + '", txtotp: "' + OTP + '"}',
                dataType: "json",
                success: function (data) {
                    if (data.d == '0') {
                        $("#<%=(btnSubmit.ClientID)%>").show();
                        $('#vOTP').hide();
                        $('#btn_otp').hide();
                    }
                    else {
                        alert(data.d);
                    }
                },
                error: function (response) { }
            });
        }



    </script>
    <style>
        p {
            line-height: 1;
        }

        .style2 {
            width: 238px;
            height: 188px;
        }

        .style6 {
            height: 188px;
        }

        .style7 {
            color: #FF0066;
        }

        .style8 {
            color: #FF3300;
        }

        .style9 {
            color: #FF0000;
        }

        .panel-body {
            padding: 5px;
        }

        .head {
            font-size: 13px;
            padding: 7px;
            background: #d0d6ff;
            color: #000;
            margin-bottom: 0;
        }

        .panel-default {
            border-color: #ffffff;
        }

        .pull-right {
            float: right !important;
        }

        .pull-left {
            float: left !important;
        }
    </style>
    <asp:HiddenField ID="hnd_OTPVFYD" runat="server" Value="0" />


</asp:Content>
