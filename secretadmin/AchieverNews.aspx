<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="AchieverNews.aspx.cs" Inherits="secretadmin_AchieverNews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function previewFile() {
            var preview = document.querySelector('#<%=imgAchiever.ClientID %>');
            var file = document.querySelector('#<%=FileUpload.ClientID %>').files[0];

            var reader = new FileReader();
            reader.onloadend = function () {
                if (preview)
                    preview.src = reader.result;

            }

            if (file.size > 204800) {

                alert("File size must be less than equal to 200 KB.");
                var imgup = document.getElementById('<%=FileUpload.ClientID%>');
                imgup.value = "";
                return false;
                file.focus();


            }
            else {
                reader.readAsDataURL(file);
                return true;
            }
        }
    </script>
    <div id="title" class="b2">
        <h2>
            Achiever Photo</h2>
        <hr />
    </div>
    <div class="clearfix">
        <asp:ValidationSummary ID="Valsmry" runat="server" ShowMessageBox="true" HeaderText="Please check the following errors:-"
            ShowSummary="false" ValidationGroup="aa" />
    </div>
    <div class=" form-group">
        <label for="lblName" class="col-sm-2 control-label">
            Name:
        </label>
        <div class="col-sm-3">
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Please enter your name."
                ValidationGroup="aa" ControlToValidate="txtName" SetFocusOnError="true" Display="None"
                ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class=" form-group">
        <label for="lblUploadImage" class="col-sm-2 control-label">
            Upload Image:
        </label>
        <div class="col-sm-3">
            <asp:FileUpload ID="FileUpload" runat="server" onchange="previewFile();" />
            <asp:RequiredFieldValidator ID="rfvFileUp" runat="server" ErrorMessage="Please select an image."
                ValidationGroup="aa" ControlToValidate="FileUpload" SetFocusOnError="true" Display="None"
                ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revImg" runat="server" SetFocusOnError="true"
                ForeColor="Red" ErrorMessage="Only .jpg/.jpeg/.png/.gif file types are allowed."
                Display="None" ValidationGroup="aa" ControlToValidate="FileUpload" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpg|.JPG|.jpeg|.JPEG|.gif|.GIF|.png|.PNG)$"></asp:RegularExpressionValidator>
            <asp:Image ID="imgAchiever" runat="server" Width="80px" Height="80px" style="margin-top:10px" CssClass="img-responsive img-rounded" />
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div class=" form-group">
        <label for="lblDesc" class="col-sm-2 control-label">
            Description:
        </label>
        <div class="col-sm-3">
            <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Columns="50" Rows="5"
                CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ControlToValidate="txtDesc"
                SetFocusOnError="true" ForeColor="Red" ErrorMessage="Please enter description."
                ValidationGroup="aa" Display="None"></asp:RequiredFieldValidator>
            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" Style="float: right;
                margin-top: 15px" ValidationGroup="aa" OnClick="btnSave_Click" />
        </div>
    </div>
</asp:Content>
