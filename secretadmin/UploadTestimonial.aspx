<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="UploadTestimonial.aspx.cs" Inherits="secretadmin_UploadTestimonial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function validateAndConfirm(message) {
            var validated = Page_ClientValidate('pp');
            if (validated) {
                return confirm(message);
            }
        }

    </script>
    <script type="text/javascript">
        function previewImage() {
            var preview = document.querySelector('#<%=ImgTestimonial.ClientID %>');
            var Image = document.querySelector('#<%=FileTestimonial.ClientID %>').files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;

            }

            if (Image.size > 512000) {
                preview.src = "";
                alert("File size must be less than 500 KB. Please reduce your file size then upload.");
                var uploadControl = document.getElementById('<%=FileTestimonial.ClientID%>');
                uploadControl.value = "";
                return false;
                file.focus();


            }
            else {
                reader.readAsDataURL(Image);
                return false;

            }
        }
    </script>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Testimonial Upload</h4>
    </div>




    <div class="form-group">
       

        <div class="alert alert-primary alert-dismissible fade show mt-2">
            <strong>Note</strong>  Image size must be width 100px and height 100px.
                    ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
        </button>
        </div>
        <div class="row">
        <div class="col-sm-2 control-label">
            Select Your Image:<span style="color: Red">*</span>
        </div>
        <div class="col-sm-4">
            <div class="input-group">
                <div class="form-file">
                    <asp:FileUpload ID="FileTestimonial" runat="server" CssClass="form-file-input form-control" onchange="previewImage();" />
                    <asp:RequiredFieldValidator ID="rfvTestimonial" runat="server" ForeColor="Red" SetFocusOnError="true"
                        ControlToValidate="FileTestimonial" Display="None" ErrorMessage="Please Select Your Image."
                        ValidationGroup="pp"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revTestimonial" runat="server" ValidationExpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"
                        SetFocusOnError="true" ControlToValidate="FileTestimonial" ErrorMessage="Only .jpg/.jpeg/.gif/.png file types are allowed."
                        ForeColor="Red" Display="None" ValidationGroup="pp"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>
            </div>
        <div class="row">
         <div class="col-sm-2 control-label">
            Enter Name:<span style="color: Red">*</span>
        </div>
        <div class="col-sm-4">
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="50" placeholder="Enter Your Name"></asp:TextBox>
            <label id="lblNameLeft">
            </label>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ForeColor="Red" SetFocusOnError="true"
                ControlToValidate="txtName" Display="None" ErrorMessage="Please Enter Your Name."
                ValidationGroup="pp"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revName" runat="server" ForeColor="Red" SetFocusOnError="true"
                ControlToValidate="txtName" Display="None" ErrorMessage="Name contains alphabetic value."
                ValidationExpression="^[a-zA-Z\s]*$" ValidationGroup="pp"></asp:RegularExpressionValidator>
        </div>
            </div>
        <div class="row">
        <div class="col-sm-2 control-label">
            Enter Description:<span style="color: Red">*</span>
        </div>
        <div class="col-sm-4">
            <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" TextMode="MultiLine"
                MaxLength="250" placeholder="Enter Description" Height="150px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ForeColor="Red" SetFocusOnError="true"
                ControlToValidate="txtDesc" Display="None" ErrorMessage="Please Enter Description."
                ValidationGroup="pp"></asp:RequiredFieldValidator>
            <label id="lblCharLeft">
            </label>
            </div>
            <script language="javascript" type="text/javascript">
                var maxLength = 250;
                $(document).ready(function () {
                    $("#lblCharLeft").text(maxLength + " characters left.");
                });


                $('#<%=txtDesc.ClientID %>').keyup(function () {
                    var text = $(this).val();
                    var textLength = text.length;
                    if (textLength > maxLength) {
                        $(this).val(text.substring(0, (maxLength)));
                        alert("Only " + maxLength + " characters are allowed.");
                    }
                    else {
                        $("#lblCharLeft").text((maxLength - textLength) + " characters left.");
                    }
                });
            </script>
        </div>




        <div class="col-sm-4">
            <asp:Button ID="btnUpload" runat="server" Text="Submit" CssClass="btn btn-primary"
                OnClientClick="return validateAndConfirm('Do you really want to submit?');" ValidationGroup="pp"
                OnClick="btnUpload_Click" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
                ShowSummary="false" ValidationGroup="pp" HeaderText="Please correct the following errors..." />
        </div>

        <div class="clearfix">
        </div>


        <div class="col-md-12">
            <center>
                <asp:Image ID="ImgTestimonial" runat="server" CssClass="img-responsive img-rounded" />
            </center>
        </div>
    </div>

    <hr />
    <div class="table-responsive">
        <asp:GridView ID="GRDTestimonial" runat="server" Width="100%" AutoGenerateColumns="false"
            CssClass="table table-hover mygrd" AllowPaging="true" PageSize="25">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("id") %>' Visible="false"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <%# Eval("Desc") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="testimonialimg" runat="server" Height="100px" ImageUrl='<%# Eval("image") %>'
                            Width="100px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="doe" HeaderText="Uploaded Date" />
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnDel" runat="server" Text="Delete" CssClass="btn btn-danger"
                            OnClientClick="return confirm('Are you sure to delete this testimonial?')"
                            OnClick="btnDel_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <div class="clearfix"></div>
    </div>
</asp:Content>
