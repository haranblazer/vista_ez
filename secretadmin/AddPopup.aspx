<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="AddPopup.aspx.cs" Inherits="secretadmin_AddPopup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtEndDate.ClientID %>').datepick({ dateFormat: 'dd/mm/yyyy', minDate: 0 });
        });

    </script>
    <script type="text/javascript">
        function previewFile() {
            var preview = document.querySelector('#<%=PreviewImg.ClientID %>');
            var file = document.querySelector('#<%=FilePopupImg.ClientID %>').files[0];
            var reader = new FileReader();
            reader.onloadend = function () {
                preview.src = reader.result;
            }
            if (file.size > 1000000) {

                preview.src = "";
                alert("File size should be less than 1 MB.");
                var uploadControl = document.getElementById('<%=FilePopupImg.ClientID%>');
                uploadControl.value = "";
                return false;
                file.focus();
            }
            else {
                reader.readAsDataURL(file);
                return true;
            }

        }

    </script>
    <script type="text/javascript">
        function ConfirmDelete() {
            if (confirm("Are you sure want to delete this image?")) {
                return true;
            }
            return false;
        }

    </script>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Add Popup Image  </h4>
    </div>

    <div class="alert alert-primary alert-dismissible fade show">

        <strong>Note:</strong> File size must be less
                than 1 MB.&nbsp;File types must be .jpg/.jpeg/.png/.gif.&nbsp;Image Size must be
                width 720px and height 580px.
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
    </div>



    <div class="form-group">
        <div class="col-md-2">
            End Date:<span style="color: Red"><strong>*</strong></span>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" MaxLength="10"
                placeholder="DD/MM/YYYY"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ControlToValidate="txtEndDate"
                SetFocusOnError="true" Display="None" ErrorMessage="Please Select End Date!"
                ValidationGroup="pp" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>

        <div class="col-md-2 control-label">
            Upload Image:<span style="color: Red"><strong>*</strong></span>
        </div>
        <div class="col-md-4">
            <div class="input-group">
                <div class="form-file">
                    <asp:FileUpload ID="FilePopupImg" runat="server" CssClass="form-file-input form-control" onchange="previewFile();" />
                    <asp:Image ID="PreviewImg" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvPopupImg" runat="server" ControlToValidate="FilePopupImg"
                        SetFocusOnError="true" Display="None" ErrorMessage="Please Choose Image!" ValidationGroup="pp"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPopupImg" runat="server" ControlToValidate="FilePopupImg"
                        SetFocusOnError="true" ValidationExpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"
                        Display="None" ErrorMessage="Only .jpg/.jpeg/.gif/.png file types are allowed."
                        ValidationGroup="pp" ForeColor="Red"></asp:RegularExpressionValidator>

                </div>
            </div>
        </div>

        <div class="col-md-2 control-label">
            Select Type:<span style="color: Red"><strong>*</strong></span>
        </div>
        <div class="col-md-4">
            <div class="input-group">
                <div class="form-file">
                    <asp:DropDownList ID="ddl_SelectType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="ALL" Selected="True">ALL</asp:ListItem>
                        <asp:ListItem Value="W">Welcome</asp:ListItem>
                        <%--<asp:ListItem Value="A">Associate </asp:ListItem>--%>
                       <%-- <asp:ListItem Value="F">Francises</asp:ListItem>--%>
                       <%-- <asp:ListItem Value="W_A">Welcome & Associate</asp:ListItem>--%>
                       <%-- <asp:ListItem Value="W_F">Welcome & Francises </asp:ListItem>
                        <asp:ListItem Value="A_F">Associate & Francises</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>
            </div>
        </div>






        <div class="col-md-4 ">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary"
                ValidationGroup="pp" OnClick="btnSubmit_Click" />
            <asp:ValidationSummary ID="ValidationPopup" runat="server" ShowMessageBox="true"
                ShowSummary="false" ValidationGroup="pp" HeaderText="Please check the following..." />
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />

    <div class="table-responsive">
        <asp:DataList ID="DataPopupImg" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
            Width="100%">
            <ItemTemplate>
                <asp:Label ID="lblID" runat="server" Text='<%# Eval("ImgId") %>' Visible="false"></asp:Label>

                
            <b>  <%# Eval("SelectType") %> <br /></b> 

                <a href=' <%# Eval("ImageName","../images/PopupImage/{0}") %>' data-fancybox="gallery">
                    <asp:Image ID="ImgPopup" runat="server" CssClass="img-responsive img-rounded" ImageUrl=' <%# Eval("ImageName","../images/PopupImage/{0}") %>'
                        Width="320px" Height="240px" />
                </a>
                <asp:LinkButton ID="lnkDel" runat="server" Text="Delete" CssClass="btn btn-primary btn-xs"
                    OnClientClick="return ConfirmDelete();" OnClick="lnkDel_Click"></asp:LinkButton>
            </ItemTemplate>
        </asp:DataList>
    </div>
    </div>
    <div class="clearfix"></div>
    </div>
    
</asp:Content>

