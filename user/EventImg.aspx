<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="EventImg.aspx.cs" Inherits="User_EventImg" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Add Events Images</h4>
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-sm-2">
            Event Type
        </div>
        <div class="col-sm-4">
            <asp:Label ID="lbl_EventType" runat="server"></asp:Label>
        </div>
        <br />
        <div class="clearfix"></div>
        <br />
        <div class="col-sm-2">
            Select Image 1
        </div>
        <div class="col-sm-4">
            <asp:FileUpload ID="FU_Img1" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
        </div>
        <div class="col-sm-4">
            <div id="dvPreview1" runat="server"></div>
        </div>

        <div class="clearfix"></div>
        <div class="col-sm-2">
            Select Image 2
        </div>
        <div class="col-sm-4">
            <asp:FileUpload ID="FU_Img2" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
        </div>
        <div class="col-sm-4">
            <div id="dvPreview2" runat="server"></div>
        </div>


        <div class="clearfix"></div>
        <div class="col-sm-2">
            Select Image 3
        </div>
        <div class="col-sm-4">
            <asp:FileUpload ID="FU_Img3" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
        </div>
        <div class="col-sm-4">
            <div id="dvPreview3" runat="server"></div>
        </div>


        <div class="clearfix"></div>
        <div class="col-sm-2">
            Select Image 4
        </div>
        <div class="col-sm-4">
            <asp:FileUpload ID="FU_Img4" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
        </div>
        <div class="col-sm-4">
            <div id="dvPreview4" runat="server"></div>
        </div>

        <div class="clearfix"></div>
        <div class="col-sm-2">
            Select Image 5
        </div>
        <div class="col-sm-4">
            <asp:FileUpload ID="FU_Img5" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
        </div>
        <div class="col-sm-4">
            <div id="dvPreview5" runat="server"></div>
        </div>


        <div class="clearfix"></div>
        <div class="col-sm-2">
        </div>
        <div class="col-sm-4">
            <asp:Button ID="btn_Submit" runat="server" CssClass="btn btn-success"
                OnClick="btn_Submit_Click" Text="Submit" />
        </div>


    </div>
    <div class="clearfix"></div>
    <asp:HiddenField ID="hnd_Img1" runat="server" Value="" />
    <asp:HiddenField ID="hnd_Img2" runat="server" Value="" />
    <asp:HiddenField ID="hnd_Img3" runat="server" Value="" />
    <asp:HiddenField ID="hnd_Img4" runat="server" Value="" />
    <asp:HiddenField ID="hnd_Img5" runat="server" Value="" />

    <script src="../Grid_js_css/jquery-3.5.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {

            $("[id*=FU_Img1]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview1 = $('#<%=dvPreview1.ClientID%>');
                    dvPreview1.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:112px;width: 105px");
                                img.attr("src", e.target.result);
                                dvPreview1.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview1.html("");
                            $('#<%=FU_Img1.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=FU_Img2]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview2 = $('#<%=dvPreview2.ClientID%>');
                    dvPreview2.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:112px;width: 105px");
                                img.attr("src", e.target.result);
                                dvPreview2.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview2.html("");
                            $('#<%=FU_Img2.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=FU_Img3]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview3 = $('#<%=dvPreview3.ClientID%>');
                    dvPreview3.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:112px;width: 105px");
                                img.attr("src", e.target.result);
                                dvPreview3.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview3.html("");
                            $('#<%=FU_Img3.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=FU_Img4]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview4 = $('#<%=dvPreview4.ClientID%>');
                    dvPreview4.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:112px;width: 105px");
                                img.attr("src", e.target.result);
                                dvPreview4.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview4.html("");
                            $('#<%=FU_Img4.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=FU_Img5]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview5 = $('#<%=dvPreview5.ClientID%>');
                    dvPreview5.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:112px;width: 105px");
                                img.attr("src", e.target.result);
                                dvPreview5.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview5.html("");
                            $('#<%=FU_Img5.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });

        });
    </script>



</asp:Content>

