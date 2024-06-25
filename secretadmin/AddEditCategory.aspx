<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/secretadmin/MasterPage.master"
    CodeFile="AddEditCategory.aspx.cs" Inherits="d2000admin_AddEditCategory" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Add / Edit Category</h4>
    <hr />
    <div class="row">
        <div class="col-sm-2 control-label">Category</div>
        <div class="col-sm-4">
            <asp:TextBox ID="txtCategoryName" runat="server" MaxLength="50" CssClass="form-control" onkeypress="return Alphanumeric(event,this);"></asp:TextBox>
        </div>
        <div class="col-sm-4"></div>
        <div class="col-sm-2"><a href="CategoryList.aspx" class="btn btn-link">Category List</a> </div>
        <div class="clearfix"></div>

        <div class="col-sm-2 control-label">Dispaly Priority</div>
        <div class="col-sm-4">
            <asp:TextBox ID="txt_priority" runat="server" MaxLength="2" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="clearfix"></div>


        <div class="col-sm-6 alert alert-secondary alert-dismissible fade show">
            <strong>Note!</strong> Banner Image size must be width 1350 px and height 350 px.
        </div>
        <div class="clearfix"></div>

        <div class="col-sm-2 control-label">Category Image</div>
        <div class="col-sm-3">
            <asp:FileUpload ID="fu_CatImg" CssClass="form-file-input form-control" runat="server" accept=".png,.jpg,.jpeg" />
        </div>
        <div class="col-sm-4">
            <div id="div_CatImg" runat="server"></div>
        </div>
        <div class="clearfix"></div>

        <div class="col-sm-6 alert alert-secondary alert-dismissible fade show">
            <strong>Note!</strong> Icon Image size must be width 40 px and height 40 px.
        </div>
        <div class="clearfix"></div>

        <div class="col-sm-2 control-label">Icon Image</div>
        <div class="col-sm-3">
            <asp:FileUpload ID="fu_IconImg" CssClass="form-file-input form-control" runat="server" accept=".png" />
        </div>
        <div class="col-sm-4">
            <div id="div_IconImg" runat="server"></div>
        </div>

        <div class="clearfix"></div>

        <div class="col-sm-2 control-label"></div>
        <div class="col-sm-3">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
        </div>

        <div class="clearfix"></div>
    </div>

 
   <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
     <script type="text/javascript">
         $(function () {

            $("[id*=fu_CatImg]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=div_CatImg.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:75px;width:120px");
                                img.attr("src", e.target.result);
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#<%=fu_CatImg.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });


            $("[id*=fu_IconImg]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=div_IconImg.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:75px;width:120px");
                                img.attr("src", e.target.result);
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#<%=fu_IconImg.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });



             function Alphanumeric(e, t) {
                 try {
                     if (window.event) { var charCode = window.event.keyCode; }
                     else if (e) { var charCode = e.which; }
                     else { return true; }
                     if (charCode = 32 || (charCode >= 48 && charCode <= 57) || (charCode >= 65 && charCode <= 90)
                         || (charCode >= 97 && charCode <= 122)) {
                         return true;
                     }
                     return false;
                 }
                 catch (err) { alert(err.Description); }
             }

         });
          
     </script>
   
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script> 

</asp:Content>
