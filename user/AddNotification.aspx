<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="AddNotification.aspx.cs" Inherits="User_AddNotification"
    EnableEventValidation="false" ValidateRequest="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="https://cdn.ckeditor.com/4.5.6/standard/ckeditor.js"></script>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script src="//cdn.ckeditor.com/4.15.0/standard/ckeditor.js"></script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>



    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Add Notification </h4>
    </div>

    <div class="form-group row">
        <div class="row">
            <div class="col-sm-10"></div>

            <div class="col-sm-2 col-xs-3 text-right pull-right">
                <a href="NotificationList.aspx" class="btn btn-primary">Notification List</a>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="form-group" style="padding-top: 7px;">
            <div class="col-sm-12" style="padding-top: 7px;">
                <asp:TextBox ID="txtDescription1" runat="server" placeholder="Description" TextMode="MultiLine"
                    CssClass="form-control" Rows="3"></asp:TextBox>

                <script type="text/javascript" lang="javascript">
                    CKEDITOR.replace('<%=txtDescription1.ClientID%>');
                </script>
            </div>

            <div class="col-sm-6" style="padding-top: 7px; display: none;">
                <asp:FileUpload ID="fuUpload" runat="server" multiple="multiple" CssClass="btn btn-default" accept=".png,.jpg,.jpeg,.gif" />
                <div id="dvPreview" runat="server"></div>
            </div>
        </div>
        <div class="row" style="padding-top: 7px;">
            <div class="col-sm-10" style="padding-top: 7px;">

                <asp:CheckBoxList ID="chk_Rank" runat="server" RepeatDirection="Vertical">
                </asp:CheckBoxList>
            </div>
            <div class="col-sm-2" style="padding-top: 7px;">
                <asp:Button ID="btn_Submit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btn_Submit_Click"></asp:Button>
            </div>
        </div>

    </div>

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">


        $(function () {



            $("[id*=fuUpload]").change(function () {

                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=dvPreview.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:150px;width: 120px");
                                img.attr("src", e.target.result);
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#<%=fuUpload.ClientID%>').val('');
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

