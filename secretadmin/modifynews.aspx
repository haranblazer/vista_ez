<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    ValidateRequest="false" CodeFile="modifynews.aspx.cs" Inherits="admin_modifynews1" %>

<%@ Register Assembly="RichTextEditor" Namespace="AjaxControls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function CheckUploadFile() {
            var file = document.querySelector('#<%=FileUpload1.ClientID %>').files[0];
            if (file.size > 512000) {
                alert("File size must be less than 500 KB. Please reduce your file size then upload.");
                var uploadControl = document.getElementById('<%=FileUpload1.ClientID%>');
                uploadControl.value = "";
                return false;
                file.focus();
            }
            else { 
                return true;
            }
        }
    </script>
    <div style="padding: 15px 0px 0px 15px;">
        <h2 class="head">
            Modify News</h2>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <asp:Panel ID="Panel1" runat="server" DefaultButton="Button1">
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-sm-2">
                <label>
                    Title:
                </label>
            </div>
            <div class="col-sm-4">
                <asp:TextBox ID="txttitle" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:Label>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-sm-2">
                <label>
                    Previous Image
                </label>
            </div>
            <div class="col-sm-4">
                <asp:Image ID="Image1" runat="server" Width="100px" Height="100px" CssClass="img-responsive img-thumbnail" />
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-sm-2">
                <label>
                    Upload New Image
                </label>
            </div>
            <div class="col-sm-4">
                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="btn btn-default" onchange="CheckUploadFile();" /><br />
                <div class="alert alert-info alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert">
                            X</button>
                        <strong><i class="fa fa-hand-o-right"></i>&nbsp;Note:</strong> file size must be
                        less than 500 KB and file types must be .jpg/.jpeg/.png/.gif.
         </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-sm-2">
                <label>
                    Message:
                </label>
            </div>
            <div class="col-sm-4">
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Columns="30" Rows="5"
                    CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-sm-2">
            </div>
            <div class="col-sm-4">
                <asp:Button ID="Button1" ValidationGroup="Save" runat="server" OnClick="Button1_Click"
                    Text="Save" CssClass="btn btn-success" />
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <div class="col-sm-6">
               <%-- <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate"
                    SetFocusOnError="true" Display="None" ErrorMessage="Please enter date!" ValidationGroup="Save"></asp:RequiredFieldValidator>--%>
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txttitle"
                    SetFocusOnError="true" Display="None" ErrorMessage="Please enter title!" ValidationGroup="Save"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revImg" runat="server" SetFocusOnError="true"
                    ControlToValidate="FileUpload1" Display="none" ErrorMessage="Only .jpg/.jpeg/gif/.png file types are allowed."
                    Font-Bold="False" ForeColor="#C00000" ValidationExpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$" ValidationGroup="Save"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage"
                    SetFocusOnError="true" Display="None" ErrorMessage="Please enter message." ValidationGroup="Save"></asp:RequiredFieldValidator>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                    SetFocusOnError="true" ControlToValidate="txtDate" Display="none" ErrorMessage="Please enter date in dd/mm/yyyy format!"
                    Font-Bold="False" ForeColor="#C00000" ValidationExpression="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    ValidationGroup="Save"></asp:RegularExpressionValidator>--%>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" HeaderText="Please check the following..."
                    ShowSummary="false" ValidationGroup="Save" />
            </div>
        </div>
    </asp:Panel>
</asp:Content>
