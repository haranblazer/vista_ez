<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="ViewAddEditImage.aspx.cs" Inherits="admin_ViewAddEditImage" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--  <script type="text/javascript">
        function myFunction() {
            var x = document.getElementById("myFile").multiple;
            document.getElementById("demo").innerHTML = x;
        }
    </script>--%>
    <script type="text/javascript">
        function DeleteImage() {
            if (confirm("Are you sure want to delete this image?") == true) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
    <h2 class="head">
        <i class="fa fa-image"></i>&nbsp;View/Add/Edit Image
        <asp:Label ID="lblGalleryTitle" runat="server" Font-Bold="True"></asp:Label>
    </h2>
    <div class="panel panel-default">
        <div id="Table1" runat="server">
            <div class="col-sm-12">
                <asp:Image ID="img" runat="server" />
            </div>
            <label class="col-sm-2">
                Image Title</label>
            <div class="col-sm-6">
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox></div>
            <label class="col-sm-6">
                <asp:FileUpload ID="imgUpload" runat="server" multiple="multiple" CssClass="btn btn-default" /></label>
            <div class="col-sm-12">
                <span id="msg" style="font-weight: bold"><span style="color: Red">Note:</span> 
                     <a href="image-size.aspx" target="_blank"> Image Setting</a></span></div>
            <div class="col-sm-2">
                <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-success" OnClick="btnAdd_Click"
                    ValidationGroup="cs" />
            </div>
           
            <div class="col-sm-2 col-xs-6">
                <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-success" OnClick="btnEdit_Click"
                    ValidationGroup="cs" /></div>
            <div class="col-sm-2">
                <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel Edit" CssClass="btn btn-success"
                    OnClick="btnCancelEdit_Click" /></div>
            <div class="col-sm-12">
                <asp:RequiredFieldValidator ID="rfvImagUpload" runat="server" ErrorMessage="Please select an image."
                    ForeColor="Red" SetFocusOnError="true" ControlToValidate="imgUpload" ValidationGroup="cs"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revfileUpload" runat="server" ValidationExpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"
                    ForeColor="Red" SetFocusOnError="true" ControlToValidate="imgUpload" ErrorMessage="Only .jpg/.jpeg/.gif/.png file types are allowed."
                    ValidationGroup="cs"></asp:RegularExpressionValidator>
            </div>
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="false" Font-Names="Arial"></asp:Label></div>
            <div class="col-sm-2">
                <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" CssClass="form-control"
                    OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                    <asp:ListItem Value="0">Active</asp:ListItem>
                    <asp:ListItem Value="1">In Active</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-2">
                <asp:Label ID="lblMessage" runat="server" ForeColor="#C00000" Font-Bold="False" Font-Names="Arial"></asp:Label></div>
            <div class="col-sm-12">
                <asp:DataList ID="dtlst" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                    OnEditCommand="dtlst_EditCommand" RepeatLayout="Table" Width="100%" OnItemCommand="dtlst_ItemCommand">
                    <ItemTemplate>
                        <div>
                            <table cellspacing="0" style="text-align: center; width: 100%;">
                                <tr>
                                    <td style="text-align: center;">
                                        <asp:ImageButton ID="ibtnProductImage" Width="100px" Height="100px" ImageUrl='<%# "~/images/GalleryImages/"+ Eval("ImageName")%>'
                                            CommandName="edit" CommandArgument='<%#Eval("ImageId") %>' runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkbtnEdit" runat="server" CommandArgument='<%#Eval("ImageId") %>'
                                            CommandName="Edit" Text="Edit" />
                                        &nbsp;
                                        <asp:LinkButton ID="lnkbtnStatus" runat="server" CommandArgument='<%#Eval("ImageId") %>'
                                            CommandName="Edit" Text='<%#DataBinder.Eval(Container.DataItem,"sts") %>' />
                                        &nbsp;<asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#Eval("ImageId") %>'
                                            CommandName="Del" OnClientClick="return DeleteImage();" Text="Delete"></asp:LinkButton>
                                    </td>
                                </tr>
                                
                            </table>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <table style="width: 100%;">
                <tr>
                    <td style="text-align: center">
                        <table cellspacing="0" style="width: 100%; text-align: center;">
                            <tr>
                                <td style="text-align: left">
                                    <br />
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" ValidationGroup="cs" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>
