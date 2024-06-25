<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="edit.aspx.cs" Inherits="admin_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>


    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js?v=0.1" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtDOB.ClientID%>').datepick({
                dateFormat: 'dd/mm/yyyy',
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:-18',
            });
        });
    </script>
   
    
    <script src="../user/Crop/jquery.min.js"></script>
    <script src="../user/Crop/bootstrap.min.js"></script>
    <link href="../user/Crop/cropper.min.css" rel="Stylesheet" />
    <script src="../user/Crop/cropper.min.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(function () {
            $.noConflict(true);

            //var $ele = $('#<%=imgUpload.ClientID%>');
           <%-- var $ele1 = $('#<%=imgUpload1.ClientID%>');
            var $ele2 = $('#<%=imgUpload2.ClientID%>');
            var $ele3 = $('#<%=imgUpload3.ClientID%>');--%>
        });



        function ShowImagePreview(input, tag) {

            var fileName = input.files[0].name;
            var tag = tag;
            var validExtensions = ['jpg', 'png', 'jpeg'];
            var fileName = input.files[0].name;
            var fileNameExt = fileName.substr(fileName.lastIndexOf('.') + 1);
            if ($.inArray(fileNameExt, validExtensions) == -1) {

                input.type = ''
                input.type = 'file'
               <%-- switch (tag) {
                    case 0:
                        $('#<%=imgUpload.ClientID%>').css('display', 'none');
                        $('#<%=lblMsg.ClientID%>').html("Only these file types are accepted : " + validExtensions.join(', '));
                        break;
                    case 1:
                        $('#<%=imgUpload1.ClientID%>').css('display', 'none');
                        $('#<%=lblMsg1.ClientID%>').html("Only these file types are accepted : " + validExtensions.join(', '));
                        break;
                    case 2:
                        $('#<%=imgUpload2.ClientID%>').css('display', 'none');
                        $('#<%=lblMsg2.ClientID%>').html("Only these file types are accepted : " + validExtensions.join(', '));
                        break;
                    case 3:
                        $('#<%=imgUpload3.ClientID%>').css('display', 'none');
                        $('#<%=lblMsg2.ClientID%>').html("Only these file types are accepted : " + validExtensions.join(', '));
                        break;
                    default:
                        $('#<%=lblMsg.ClientID%>').append("Only these file types are accepted : " + validExtensions.join(', '));
                }
                $('#<%=Button1.ClientID%>').css('display', 'none');
                $('#<%=btnInsert.ClientID%>').css('display', 'none');
                $('#<%=Button6.ClientID%>').css('display', 'none');--%>
            }
            else {
                if (input.files && input.files[0] && tag === 0) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=approveRejectimg.ClientID%>').css('display', 'none');
                        $('#<%=imgUpload.ClientID%>').attr('src', e.target.result);

                        var tempFileData = e.target.result;
                        var image = $('#imgUpload')[0];
                        var $ele = $('#<%=imgUpload.ClientID%>');
                        $('#<%=Button1.ClientID%>').css("display", "block");
                        /* $('#divPreview1').css("display", "block");*/
                        $ele.cropper({
                            /*preview: "#divPreview1",*/
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
                    $ele.rotate(-90);
                }
                else {
                    if (input.files && input.files[0] && tag === 1) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#<%=imgUpload1.ClientID%>').attr('src', e.target.result);

                            //var tempFileData = e.target.result;
                            //var image = $('#imgUpload1')[0];
                            var $ele1 = $('#<%=imgUpload1.ClientID%>');
                            $('#<%=btnInsert.ClientID%>').css("display", "block");
                            /* $('#divPreviewbank').css("display", "block");*/
                            $ele1.cropper({
                                /* preview: "#divPreviewbank",*/
                                imageSmoothingEnabled: false,
                                imageSmoothingQuality: 'high',
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
                    else {
                        if (input.files && input.files[0] && tag === 2) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                $('#<%=imgUpload2.ClientID%>').attr('src', e.target.result);
                                $('#<%=lblMsg2.ClientID%>').hide();
                                //var tempFileData = e.target.result;
                                //var image = $('#imgUpload2')[0];
                                var $ele2 = $('#<%=imgUpload2.ClientID%>');
                                /* $('#divPreview3').css("display", "block");*/
                                $ele2.cropper({
                                    /* preview: "#divPreview3",*/
                                    imageSmoothingEnabled: false,
                                    imageSmoothingQuality: 'high',
                                    rotatable: true,
                                    crop: function (c) {
                                        $('#<%=X2.ClientID%>').val(parseInt(c.detail.x));
                                        $('#<%=Y2.ClientID%>').val(parseInt(c.detail.y));
                                        $('#<%=W2.ClientID%>').val(parseInt(c.detail.width));
                                        $('#<%=H2.ClientID%>').val(parseInt(c.detail.height));

                                    }
                                })
                            }
                            reader.readAsDataURL(input.files[0]);

                        }
                        else {
                            if (input.files && input.files[0] && tag === 3) {
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    $('#<%=imgUpload3.ClientID%>').attr('src', e.target.result);
                                    $('#<%=lblMsg2.ClientID%>').hide();
                                    //var tempFileData = e.target.result;
                                    //var image = $('#imgUpload3')[0];
                                    var $ele3 = $('#<%=imgUpload3.ClientID%>');
                                    $('#<%=Button6.ClientID%>').css("display", "block");
                                    /* $('#divPreview4').css("display", "block");*/
                                    $ele3.cropper({
                                        /* preview: "#divPreview4",*/
                                        imageSmoothingEnabled: false,
                                        imageSmoothingQuality: 'high',
                                        rotatable: true,
                                        crop: function (c) {
                                            $('#<%=X3.ClientID%>').val(parseInt(c.detail.x));
                                            $('#<%=Y3.ClientID%>').val(parseInt(c.detail.y));
                                            $('#<%=W3.ClientID%>').val(parseInt(c.detail.width));
                                            $('#<%=H3.ClientID%>').val(parseInt(c.detail.height));
                                        }
                                    })
                                }
                                reader.readAsDataURL(input.files[0]);
                            }
                        }
                    }
                }
            }
        }



        <%--function ShowImagePreview(input, tag) {
            var fileName = input.files[0].name;
            var tag = tag;
            var validExtensions = ['jpg', 'png', 'jpeg'];
            var fileName = input.files[0].name;
            var fileNameExt = fileName.substr(fileName.lastIndexOf('.') + 1);
            if ($.inArray(fileNameExt, validExtensions) == -1) {
                input.type = ''
                input.type = 'file'
                }
            else {
                if (input.files && input.files[0] && tag === 0) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=approveRejectimg.ClientID%>').css('display', 'none');
                        $('#<%=imgUpload.ClientID%>').attr('src', e.target.result);
                        $('#<%=lblMsg.ClientID%>').hide();
                        var $ele = $('#<%=imgUpload.ClientID%>');
                        $('#<%=Button1.ClientID%>').css("display", "block");
                        $ele.cropper({
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
                    $ele.ro$ele(-90);
                }
                else {
                    if (input.files && input.files[0] && tag === 1) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#<%=imgUpload1.ClientID%>').attr('src', e.target.result);
                            var $ele1 = $('#<%=imgUpload1.ClientID%>');
                            $('#<%=btnInsert.ClientID%>').css("display", "block");
                            $ele1.cropper({
                                imageSmoothingEnabled: false,
                                imageSmoothingQuality: 'high',
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
                    else {
                        if (input.files && input.files[0] && tag === 2) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                $('#<%=imgUpload2.ClientID%>').attr('src', e.target.result);
                                var $ele2 = $('#<%=imgUpload2.ClientID%>');
                                $ele2.cropper({
                                    imageSmoothingEnabled: false,
                                    imageSmoothingQuality: 'high',
                                    rotatable: true,
                                    crop: function (c) {
                                        $('#<%=X2.ClientID%>').val(parseInt(c.detail.x));
                                        $('#<%=Y2.ClientID%>').val(parseInt(c.detail.y));
                                        $('#<%=W2.ClientID%>').val(parseInt(c.detail.width));
                                        $('#<%=H2.ClientID%>').val(parseInt(c.detail.height));
                                    }
                                })
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                        else {
                            if (input.files && input.files[0] && tag === 3) {
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    $('#<%=imgUpload3.ClientID%>').attr('src', e.target.result);
                                    var $ele3 = $('#<%=imgUpload3.ClientID%>');
                                    $('#<%=Button6.ClientID%>').css("display", "block");
                                    $ele3.cropper({
                                        imageSmoothingEnabled: false,
                                        imageSmoothingQuality: 'high',
                                        rotatable: true,
                                        crop: function (c) {
                                            $('#<%=X3.ClientID%>').val(parseInt(c.detail.x));
                                            $('#<%=Y3.ClientID%>').val(parseInt(c.detail.y));
                                            $('#<%=W3.ClientID%>').val(parseInt(c.detail.width));
                                            $('#<%=H3.ClientID%>').val(parseInt(c.detail.height));
                                        }
                                    })
                                }
                                reader.readAsDataURL(input.files[0]);
                            }
                        }
                    }
                }
            }
        } --%>

        function rotate(tag) {
           <%-- if (tag === 0) {
                $('#<%=imgUpload2.ClientID%>').cropper('rotate', -90);
            }
            else {
                $('#<%=imgUpload3.ClientID%>').cropper('rotate', -90);
            }--%>
        }
    </script>
    <style>
        .coin-tabs .nav-tabs .nav-item .nav-link {
            border: 0;
            border-radius: 0rem;
            font-size: 1rem;
            padding: 0.5rem 1rem;
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
            border: 1px solid #fe6a00;
            margin-right: 5px;
        }

        .fade {
            transition: opacity .2s linear;
        }
    </style>


    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Edit Registration
            Information</h4>
    </div>
    <asp:Label ID="lblMessage" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>

    <div class="" id="user-activity1">
        <div class="card-header border-0 p-0 pb-4">
            <div class="card-action coin-tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active " data-bs-toggle="tab" href="#personal_details" role="tab" aria-selected="true">Personal Details</a>
                    </li>
                   <%-- <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#nominee_details " role="tab" aria-selected="false">Nominee Details </a>
                    </li>--%>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#pan_details" role="tab" aria-selected="false">Pan Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#bank_details" role="tab" aria-selected="false">Bank Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#aadhar_details" role="tab" aria-selected="false">Aadhar Details</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane d-block">
                    <div class="row">
                        <div class="col-sm-1 control-label">
                            <label>UserId</label>
                        </div>
                        <div class="col-sm-4">
                            <asp:Label ID="lblid" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                        <div class="col-sm-2 control-label text-center">
                            User Name 
                        </div>
                        <div class="col-sm-4">
                            <asp:Label ID="lbl_username" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade active show" id="personal_details">
                    <div class="panel-heading">
                        <h3 class="panel-title"><font style=""><strong>&nbsp;Sponsor Details (Step -1)</strong> </font></h3>
                    </div>
                    <div class="row">
                        <div class="col-md-6 row">
                            <div class="col-sm-3 control-label">
                                <label class="txt">Sponsor Id</label>
                            </div>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtSPID" runat="server" Enabled="False" MaxLength="20" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group row">
                                <div class="col-sm-2 control-label">
                                    <label>Status </label>
                                    <asp:Label ID="lblIndicator" runat="server" Height="15px" Width="15px"></asp:Label>
                                </div>
                                <div class="col-sm-8 control-label">
                                    <asp:RadioButtonList ID="rbtnlstActivate" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="1">Active</asp:ListItem>
                                        <asp:ListItem Value="0">Inactive</asp:ListItem>
                                        <asp:ListItem Value="2">Blocked</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font style=""><strong>&nbsp;Personal Details (Step -2)</strong></font></h3>
                    </div>
                    <div class="row">
                        <div class="col-md-6 card-group-row row">
    <div class="col-md-3 control-label">
        Name<span style="color: Red">*</span>
    </div>
    <div class="col-md-8">
       <asp:DropDownList style="display: none;" ID="DropDownList1" runat="server" CssClass="form-control">
       <asp:ListItem Value="Mr.">Mr.</asp:ListItem>
       <asp:ListItem Value="Mrs.">Mrs.</asp:ListItem>
       <asp:ListItem Value="Ms.">Ms.</asp:ListItem>
       <asp:ListItem Value="Dr.">Dr.</asp:ListItem>
       <asp:ListItem Value="Md.">Md.</asp:ListItem>
       <asp:ListItem Value="M/S">M/S</asp:ListItem>
   </asp:DropDownList>
        <asp:TextBox ID="txtfname" MaxLength="50" Rows="50" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
</div>
                       <%-- <div class="col-md-6 card-group-row row">
                            <div class="col-sm-3 control-label">
                                <label>Title/ Name </label>
                            </div>
                            <div class="col-sm-9">
                                <div class="d-flex">
                                    <div class="col-sm-2 col-xs-4" style="margin-right: 0px; padding-right: 0px">
                                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="Mr.">Mr.</asp:ListItem>
                                            <asp:ListItem Value="Mrs.">Mrs.</asp:ListItem>
                                            <asp:ListItem Value="Ms.">Ms.</asp:ListItem>
                                            <asp:ListItem Value="Dr.">Dr.</asp:ListItem>
                                            <asp:ListItem Value="Md.">Md.</asp:ListItem>
                                            <asp:ListItem Value="M/S">M/S</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-9" style="margin-left: 0px; padding-left: 0px">
                                        <asp:TextBox ID="txtfname" runat="server" MaxLength="50" Rows="50" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                        <div class="col-md-6 card-group-row row" style="display: none">
                            <div class="col-sm-3 control-label">
                                Father/Husband's
                            </div>
                            <div class="col-sm-9">
                                <div class="d-flex">
                                    <div class="col-sm-2 col-xs-4">
                                        <asp:DropDownList ID="ddlGtitle" runat="server" CssClass="form-control" Style="max-width: 100%;">
                                            <asp:ListItem>S/O</asp:ListItem>
                                            <asp:ListItem>D/O</asp:ListItem>
                                            <asp:ListItem>W/O</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtGName" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-sm-3 control-label">
                                <label class="txt">Gender<span style="color: Red">*</span></label>
                            </div>
                            <div class="col-md-8 control-label">
                                <asp:RadioButtonList ID="RdoGenderNew" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem class="txt" Selected="True" Value="0">Male</asp:ListItem>
                                    <asp:ListItem class="txt" Value="1">Female</asp:ListItem>
                                    <asp:ListItem class="txt" Value="2">Others</asp:ListItem>
                                </asp:RadioButtonList>                                                      
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Date Of Birth <span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Mobile<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtMobile" runat="server" onkeypress="return onlyNumbers(event,this);" MaxLength="10" CssClass="form-control"
                                    ToolTip="Mobile no. should be 10 digits!"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Email
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                City<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                District<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:UpdatePanel ID="UpdateDistrictPanel" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" TabIndex="7">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlState" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                State<span style="colorzZZ: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" Enabled="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Address<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" ValidationGroup="v"
                                    CssClass="form-control" onkeypress="return CheckPassword();" MaxLength="400" Height="50px"></asp:TextBox>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Pin Code<span style="color: Red">*</span>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtpincode" runat="server" ValidationGroup="v" CssClass="form-control"
                                   onkeypress="return onlyNumbers(event,this);" ToolTip="Please Enter  Number Only!" MaxLength="6"></asp:TextBox><br />
                            </div>
                        </div>
                          <div class="col-md-6 card-group-row row">
      <div class="col-md-3 control-label">
          Password<span style="color: Red">*</span>
      </div>
      <div class="col-md-8">
          <asp:TextBox ID="txt_Pswrd" runat="server" ValidationGroup="v" CssClass="form-control"></asp:TextBox><br />
      </div>
  </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Nominee Details (Step -3) </strong>
                        </font></h3>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">                                
                                    Nominee Name
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtnomniName" runat="server" CssClass="form-control"
                                    MaxLength="30" placeholder="Enter Nominee Name"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6 card-group-row row">
                            <div class="col-md-3 control-label">
                                Relation
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtrelation" runat="server" CssClass="form-control" MaxLength="30"
                                    placeholder="Enter Nominee Relation"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12 card-group-row" style="margin: 0px;">
                            <div class="col-md-9"></div>
                            <div class="col-md-3">
                                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-12" style="display: none">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtGName"
                                Display="None" ErrorMessage="Please Enter Guardian's Name !" Font-Bold="False"
                                ForeColor="#C00000" Style="position: static" ValidationGroup="cp" Width="181px"
                                Enabled="False">Please Enter Guardian's Name !</asp:RequiredFieldValidator><br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtGName"
                                Display="None" ErrorMessage="Father/Husband's Name COntains Alphabetic Value!"
                                Font-Bold="False" ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[A-Za-z. ]*"
                                ValidationGroup="cp" Width="434px" Enabled="False"></asp:RegularExpressionValidator><br />
                            <br />
                            <asp:RequiredFieldValidator ID="addExp" runat="server" ControlToValidate="txtAddress"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Address !" ForeColor="#C00000"
                                ValidationGroup="cp">Please Enter Address !</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server"
                                SetFocusOnError="true" ControlToValidate="txtAddress" Display="None" ErrorMessage="Maximum 400 Characters Are Allowed ! "
                                ForeColor="#C00000" ValidationExpression="^[\s\S]{0,400}$" ValidationGroup="cp"></asp:RegularExpressionValidator><br />
                            <asp:RequiredFieldValidator ID="RfvState" runat="server" ControlToValidate="ddlState"
                                Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000" InitialValue="0"
                                ValidationGroup="cp" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                                Display="None" ErrorMessage="Please Enter city!" ForeColor="#C00000" ValidationGroup="cp"
                                SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtpincode"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Pincode !" ForeColor="#C00000"
                                Style="left: 0px; position: relative" ValidationGroup="cp">Please Enter Pincode !</asp:RequiredFieldValidator><br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtpincode"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter 6 Digits valid Pin Code"
                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[1-8][0-9]{5}$" ValidationGroup="cp"
                                Width="298px"></asp:RegularExpressionValidator><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMobile"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter 10 Digits Mobile No !"
                                ForeColor="#C00000" ValidationGroup="cp"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtMobile"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter 10 Digits Valid Mobile No."
                                ForeColor="#C00000" ToolTip="NJ" ValidationExpression="^[6789][0-9]{9}$" ValidationGroup="cp"
                                Width="248px"></asp:RegularExpressionValidator><br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtEmail"
                                Display="None" ErrorMessage="Please Enter E-Mail Address In Correct Format As 'abc@xyz.com' !"
                                ForeColor="#C00000" Style="position: static" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ValidationGroup="cp">Please Enter E-Mail Id In Correct Format As 'abc@xyz.com' !</asp:RegularExpressionValidator><br />

                            <asp:ValidationSummary ID="ValidationSmry" runat="server" ShowMessageBox="true" ShowSummary="false"
                                ValidationGroup="cp" HeaderText="Please check the following..."></asp:ValidationSummary>
                        </div>
                    </div>
                </div>
               <%-- <div class="tab-pane fade" id="nominee_details">
                </div>--%>
                <div class="tab-pane fade" id="pan_details">
                    <%-- pan card details--%>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;PAN Details </strong>
                        </font></h3>
                    </div>
                    <asp:Panel ID="Panel2" runat="server">
                        <div class="form-group row">
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4">
                                    <label class="control-label" style="text-align: justify">
                                        Enter PAN No:<span style="color: Red">*</span></label>
                                </div>
                                <div class="col-md-10">
                                    <asp:TextBox ID="txtPANDetails" runat="server" CssClass="form-control" placeholder="Enter PAN Number" MaxLength="10"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Select Image File : 
                                </div>
                                <div class="col-md-10">
                                    <div class="input-group">
                                        <div class="form-file">
                                            <asp:FileUpload ID="FU1" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg" onchange="ShowImagePreview(this,0);" />
                                            <input id="X" runat="server" type="hidden" />
                                            <input id="Y" runat="server" type="hidden" />
                                            <input id="W" runat="server" type="hidden" />
                                            <input id="H" runat="server" type="hidden" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <br />
                            <div class="col-md-6 card-group-row" style="margin: 0px; width: 480px; height: 300px;">
                                <asp:Image ID="imgUpload" runat="server" Width="450px" Height="267px" />
                            </div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-2">
                                    <img alt="" src="" runat="server" class="igte_rPayNet_ButtonImg" id="approveRejectimg" style="width: 100px; height: 100px;" />
                                </div>
                                <div class="col-md-3">
                                    <button type="button" id="btnreject" runat="server" style="width: max-content; display: none;" class="btn btn-danger" onclick="btnRejectKYC_Click('1');">Reject Pan</button>
                                </div>
                                <div class="col-md-3">
                                    <input type="button" id="btn_Pan_A" runat="server" onclick="javascript:btnApproveKYC_Click(1);" value="Approved" class="btn btn-success" style="display: none;" />
                                </div>
                                <div class="col-md-4">
                                    <button runat="server" id="Button1" onclientclick="return ValidateFile()" title="Crop & Save" class="btn btn-success"
                                        validationgroup="vv" style="display: none;" onserverclick="Button1_Click">
                                        <i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp;Crop & Submit
                                    </button>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </asp:Panel>
                    <%--pan card details end--%>
                </div>
                <div class="tab-pane fade" id="bank_details">

                    <%--Bank details --%>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Bank Details </strong>
                        </font></h3>
                    </div>
                    <asp:Panel ID="Panel1" runat="server">
                        <div class="form-group row">
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Upload Cancel Cheque
                                </div>
                                <div class="col-md-10">
                                    <div class="input-group">
                                        <div class="form-file">
                                            <asp:FileUpload ID="fileCancelCq" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg" onchange="ShowImagePreview(this,1);" />
                                            <input id="X1" runat="server" type="hidden" />
                                            <input id="Y1" runat="server" type="hidden" />
                                            <input id="W1" runat="server" type="hidden" />
                                            <input id="H1" runat="server" type="hidden" />
                                            <input id="R" runat="server" type="hidden" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Select Bank
                                </div>
                                <div class="col-md-10">
                                    <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlBankName"
                                        Display="None" ErrorMessage="Please Select Bank Name." ValidationGroup="aa" InitialValue=""
                                        SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    A/C Type
                                </div>
                                <div class="col-md-10">
                                    <asp:DropDownList ID="ddlAcType" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                                        <asp:ListItem Value="SAVING A/C">SAVING A/C</asp:ListItem>
                                        <asp:ListItem Value="CURRENT A/C">CURRENT A/C</asp:ListItem>
                                        <asp:ListItem Value="CC A/C">CC A/C</asp:ListItem>
                                        <asp:ListItem Value="OD A/C">OD A/C</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlAcType"
                                        InitialValue="" SetFocusOnError="true" Display="None" ErrorMessage="Please Select  A/C Type."
                                        ValidationGroup="aa"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    A/C No.
                                </div>
                                <div class="col-md-10">
                                    <div class="tooltiptest">
                                        <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtAccNo"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Please Enter A/C Number."
                                            ValidationGroup="aa"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revACNo" runat="server" Display="None" ForeColor="Red"
                                            ValidationGroup="aa" ValidationExpression="^#?[0-9]*$" SetFocusOnError="true"
                                            ErrorMessage="Account Number Contains Numeric Value Without Space." ControlToValidate="txtAccNo"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Branch
                                </div>
                                <div class="col-md-10">
                                    <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtbranch"
                                        SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Branch." ValidationGroup="aa"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-sm-4 control-label">
                                    IFS Code
                                </div>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtifs" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtifs"
                                        SetFocusOnError="true" Display="None" ErrorMessage="Please Enter IFS Code." ValidationGroup="aa">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revIFSCode" runat="server" Display="None" ForeColor="Red"
                                        ValidationGroup="aa" ValidationExpression="^[A-Z]{4}0[A-Z0-9]{6}$" SetFocusOnError="true"
                                        ErrorMessage="IFS Code Contains AlphaNumeric Value Without Space." ControlToValidate="txtifs"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="clearfix"></div>


                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-sm-4">
                                    <button runat="server" id="btnInsert" onclientclick="return ValidateFile()" title="Crop & Save" class="btn btn-success"
                                        validationgroup="aa" style="display: none;" onserverclick="btnInsert_Click">
                                        Crop & Submit</button>

                                </div>
                                <div class="col-sm-4">
                                    <button type="button" id="btnreject1" runat="server" value class="btn btn-danger" style="width: max-content; display: none;" onclick="btnRejectKYC_Click('2');">Reject Bank</button>
                                </div>
                                <div class="col-sm-4">
                                    <input type="button" id="btn_BANK_A" runat="server" onclick="javascript:btnApproveKYC_Click(2);" value="Approved" class="btn btn-success" />
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <br />

                            <div class="col-md-9 card-group-row" style="margin: 0px; min-height: 300px;">
                                <asp:Image ID="imgUpload1" runat="server" Style="width: 100%" />
                            </div>
                            <div class="col-md-3 card-group-row" style="margin: 0px;">
                                <div class="col-sm-2">
                                    <img alt="" src="" runat="server" class="igte_rPayNet_ButtonImg" id="approveRejectImg1" style="width: 100px; height: 100px;" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <%-- bank details end--%>
                </div>
                <div class="tab-pane fade" id="aadhar_details">

                    <%--Aadhar Details start--%>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font><i class="fa fa-id-badge" aria-hidden="true"></i><strong>&nbsp;Address Details </strong>
                        </font></h3>
                    </div>

                    <div class="alert alert-primary alert-dismissible fade show">
                        <strong>&nbsp;Note:</strong> Please upload front as well as back image of Address Proof.
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close"></button>
                    </div>
                    <asp:Panel ID="Panel3" runat="server">
                        <div class="form-group row">

                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Address Proof ID:
                                </div>
                                <div class="col-md-10">
                                    <asp:TextBox ID="txtAadharNo" runat="server" CssClass="form-control" MaxLength="20"
                                        placeholder="Please Enter Aadhar Number"></asp:TextBox>
                                    <asp:Label ID="lblMsg2" runat="server" ForeColor="Red" />
                                </div>
                            </div>
                            <div class="clearfix"></div>


                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Upload front image   
                                </div>
                                <div class="col-md-10">
                                    <div class="input-group">
                                        <div class="form-file">
                                            <asp:FileUpload ID="FU2" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg" onchange="ShowImagePreview(this,2);" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4 control-label">
                                    Upload back image    
                                </div>
                                <div class="col-md-10">
                                    <div class="input-group">
                                        <div class="form-file">
                                            <asp:FileUpload ID="FU3" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg" onchange="ShowImagePreview(this,3);" />
                                            <input id="X2" runat="server" type="hidden" />
                                            <input id="Y2" runat="server" type="hidden" />
                                            <input id="W2" runat="server" type="hidden" />
                                            <input id="H2" runat="server" type="hidden" />

                                            <input id="X3" runat="server" type="hidden" />
                                            <input id="Y3" runat="server" type="hidden" />
                                            <input id="W3" runat="server" type="hidden" />
                                            <input id="H3" runat="server" type="hidden" />
                                            <input id="R1" runat="server" type="hidden" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <br />
                            <div class="col-md-6 card-group-row" style="margin: 0px; height: 350px;">
                                <asp:Image ID="imgUpload2" runat="server" Width="450px" Height="286px" />
                            </div>
                            <div class="col-md-6 card-group-row" style="margin: 0px; height: 350px;">
                                <asp:Image ID="imgUpload3" runat="server" Width="450px" Height="286px" />
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-4">
                                    <button type="button" id="btnreject2" runat="server" class="btn btn-danger" style="width: max-content; display: none;" onclick="btnRejectKYC_Click('3');">Remove Address Proof</button>
                                </div>
                                <div class="col-md-4">
                                    <input type="button" id="btn_AADHAR_A" runat="server" onclick="javascript:btnApproveKYC_Click(3);" value="Approved" class="btn btn-success" />
                                </div>
                                <div class="col-md-4">
                                    <button runat="server" id="Button6" title="Submit" class="btn btn-success"
                                        validationgroup="vv" style="display: none;" onserverclick="Button6_click">
                                        <i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp;Crop & Submit
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 card-group-row" style="margin: 0px;">
                                <div class="col-md-2">
                                    <img alt="" src="" runat="server" class="igte_rPayNet_ButtonImg" id="approveRejectImg2" style="width: 100px; height: 100px;" />
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </asp:Panel>
                    <div class="panel-heading">
                        <h3 class="panel-title"><font style=""><strong>Remove KYC  &nbsp;<strong>Note:</strong> This action will Remove KYC details of user.</strong> </font></h3>
                    </div>
                    <div class="col-sm-3 center-block">
                        <asp:Button ID="kycRej" runat="server" Text="Remove Pan, Bank & Aadhar KYC" CssClass="btn btn-danger" OnClick="AllKYC_Reject" OnClientClick="return confirm('Are you sure you want to delete the current KYC Details?')" />
                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>
    </div>
</div>

    <script type="text/javascript">
        $(function () {
            $('#<%=txtAddress.ClientID%>').keypress(function (e) {
      if (e.which == 92) { return false; }
      });

              $('#<%=txtEmail.ClientID %>').keypress(function (e) {

                  if ((e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122) || (e.which >= 48 && e.which <= 57) || (e.which == 46) || (e.which == 64) || (e.which == 95)) { return true; } else { return false; }

              });

          });
        function btnApproveKYC_Click(id) {
            if (!confirm('Are you sure you want to approved.!!')) {
                return false;
            }
            if (id == '1' || id == '2' || id == '3') {
                regno = $('#<%=lblid.ClientID%>').html();
                name = $('#<%=txtfname.ClientID%>').html();
                mobile = $('#<%=txtMobile.ClientID%>').html();
                $.ajax({
                    type: "POST",
                    url: 'edit.aspx/btnApproveKYC_Click',
                    data: '{kycid: "' + id + '",regno: "' + regno + '",name: "' + name + '",mobile: "' + mobile + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (id == '1') {
                            $("#DivPA").css("display", "none");
                            $('#<%=txtPANDetails.ClientID%>').removeAttr('readonly');
                            $('body').css('overflow', 'auto');
                            $('.modal-backdrop.in').hide();
                        }
                        else if (id == '2') {
                            $("#DivBA").css("display", "none");
                            $('#<%=txtbranch.ClientID%>').removeAttr('disabled');
                            $('#<%=txtifs.ClientID%>').removeAttr('disabled');
                            $('#<%=txtAccNo.ClientID%>').removeAttr('disabled');
                            $('#<%=ddlBankName.ClientID%>').removeAttr('disabled');
                            $('#<%=ddlAcType.ClientID%>').removeAttr('disabled');
                            $('body').css('overflow', 'auto');
                            $('.modal-backdrop.in').hide();
                        }
                        else if (id == '3') {
                            $("#DivAa").css("display", "none");
                            $("#myModal").css("display", "none");
                            $('#<%=txtAadharNo.ClientID%>').removeAttr('disabled');
                            $('body').css('overflow', 'auto');
                            $('.modal-backdrop.in').hide();
                        }
                        window.location = window.location.href;
                    },
                    error: function (response) {
                        $('.modal-backdrop.in').css("opacity", 0);
                    }
                });
            }
        }


        /*--------------------------*/

        function btnRejectKYC_Click(id) {
            if (!confirm('Are you sure you want to Reject.!!')) {
                return false;
            }
            var Userid = $('#<%=lblid.ClientID%>').text();
            if ($('#<%=imgUpload.ClientID%>').attr('src') != '' || $('#<%=imgUpload1.ClientID%>').attr('src') != '' || $('#<%=imgUpload2.ClientID%>').attr('src') != '') {
                if (id == '1' || id == '2' || id == '3') {
                    $.ajax({
                        type: "POST",
                        url: 'edit.aspx/UpdateReject',
                        data: '{kycid: "' + id + '", Userid: "' + Userid + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (id == '1') {
                                $('#<%=txtPANDetails.ClientID%>').val('');
                                $('#<%=FU1.ClientID%>').removeAttr('disabled');
                                $('#<%=imgUpload.ClientID%>').attr("src", "");
                                $('#<%=approveRejectimg.ClientID%>').attr("src", "../images/pendingStamp.png");
                                $('#<%=btnreject.ClientID%>').css('display', 'none');
                                $('#<%=btn_Pan_A.ClientID%>').css('display', 'none');
                                $('body').css('overflow', 'auto');
                            }
                            else if (id == '2') {
                                $('#<%=txtbranch.ClientID%>').val('');
                                $('#<%=txtifs.ClientID%>').val('');
                                $('#<%=txtAccNo.ClientID%>').val('');
                                $('#<%=ddlBankName.ClientID%>').val('');
                                $('#<%=ddlAcType.ClientID%>').val('');
                                $('#<%=fileCancelCq.ClientID%>').removeAttr('disabled');
                                $('#<%=imgUpload1.ClientID%>').attr("src", "");
                                $('#<%=approveRejectImg1.ClientID%>').attr("src", "../images/pendingStamp.png");
                                $('#<%=btnreject1.ClientID%>').css('display', 'none');
                                $('#<%=btn_BANK_A.ClientID%>').css('display', 'none');
                                $('body').css('overflow', 'auto');
                            }
                            else if (id == '3') {
                                $('#<%=txtAadharNo.ClientID%>').val('');
                                $('#<%=FU2.ClientID%>').removeAttr('disabled');
                                $('#<%=FU3.ClientID%>').removeAttr('disabled');
                                $('#<%=imgUpload2.ClientID%>').attr("src", "");
                                $('#<%=imgUpload3.ClientID%>').attr("src", "");
                                $('#<%=approveRejectImg2.ClientID%>').attr("src", "../images/pendingStamp.png");
                                $('#<%=btnreject2.ClientID%>').css('display', 'none');
                                $('#<%=btn_AADHAR_A.ClientID%>').css('display', 'none');
                                $('body').css('overflow', 'auto');
                            }
                            window.location = window.location.href;
                        },
                        error: function (response) {
                            alert("Server error. Time out.!!");

                        }
                    });
                }

            }
        }


       

        function onlyNumbers(e, t) {

            if (window.event) { var charCode = window.event.keyCode; }

            else if (e) { var charCode = e.which; }

            else { return true; }

            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }

            return true;

        }



    </script>
     
    <style>
        .form-group {
            margin-bottom: 0px;
        }

        .panel-default > .panel-heading {
            border-color: #e5e5e5;
            color: #fff;
        }


        #Div2:before {
            content: '';
            display: inline-block;
            height: 35%;
            vertical-align: middle;
        }

        #Div2-dialog {
            display: inline-block;
            vertical-align: middle;
        }

        #Div2 #Div2-content {
            padding: 20px 20px 20px 20px;
            -webkit-animation-name: modal-animation;
            -webkit-animation-duration: 0.5s;
            animation-name: modal-animation;
            animation-duration: 0.5s;
        }

        #Div1:before {
            content: '';
            display: inline-block;
            height: 55%;
            vertical-align: middle;
        }

        #Div1-dialog {
            display: inline-block;
            vertical-align: middle;
        }

        #Div1 #Div1-content {
            padding: 20px 20px 20px 20px;
            -webkit-animation-name: modal-animation;
            -webkit-animation-duration: 0.5s;
            animation-name: modal-animation;
            animation-duration: 0.5s;
        }

        [dir=ltr] .modal-backdrop {
            position: relative;
        }
        /* Styling modal */
        #myModal:before {
            content: '';
            display: inline-block;
            height: 80%;
            vertical-align: middle;
        }

        #myModal-dialog {
            display: inline-block;
            vertical-align: middle;
        }

        #myModal #myModal-content {
            padding: 20px 20px 20px 20px;
            -webkit-animation-name: modal-animation;
            -webkit-animation-duration: 0.5s;
            animation-name: modal-animation;
            animation-duration: 0.5s;
        }

        @-webkit-keyframes modal-animation {
            from {
                top: -100px;
                opacity: 0;
            }

            to {
                top: 0px;
                opacity: 1;
            }
        }

        @keyframes modal-animation {
            from {
                top: -100px;
                opacity: 0;
            }

            to {
                top: 0px;
                opacity: 1;
            }
        }

        .panel-heading {
            font-size: 24px;
            padding: 7px;
            background: #fcddc3;
            color: #fff;
            margin: 10px 0;
        }

        h3.panel-title {
            color: #444;
            margin: 0px;
        }
    </style>
</asp:Content>

