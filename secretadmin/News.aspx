<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
   EnableEventValidation="false" ValidateRequest="false" CodeFile="News.aspx.cs" Inherits="admin_News" %>

<%@ Register Assembly="RichTextEditor" Namespace="AjaxControls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <script type="text/javascript">
        $(function () {
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

        });   
    </script>--%>
    <script type="text/javascript">
        function CheckUploadFile() {
            var file = document.querySelector('#<%=imgUpload.ClientID %>').files[0];
            if (file.size > 512000) {
                alert("File size must be less than 500 KB. Please reduce your file size then upload.");
                var uploadControl = document.getElementById('<%=imgUpload.ClientID%>');
                uploadControl.value = "";
                return false;
                file.focus();
            }
            else {

                return true;
            }
        }
    </script>
    <script type="text/javascript">

        function Validate() {

            var title = document.getElementById('<%=txttitle.ClientID%>');
            var msg = document.getElementById('<%=txtMsg.ClientID %>');
            if (title.value == "" && msg.value == "") {
                alert("Both fields title and message are required.");
                title.focus();
                return false;
            }
            if (title.value == "") {
                alert("Please Provide Title.");
                title.focus();
                return false;
            }
            if (msg.value == "") {
                alert("Please Enter Your Message.");
                msg.focus();
                return false;
            }

            return true;
        }
    </script>
   <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add News</h4>					
				</div>

     
 
 
    <asp:Panel ID="pnlNews" runat="server" DefaultButton="Button1">
        
        <%--<div class="form-group">
              <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">--%>
        <%--End Date :    
             </label>        
            <div class="col-sm-3">
            <asp:TextBox ID="txtDate" runat="server" ToolTip="dd/mm/yyyy" CssClass="form-control"></asp:TextBox>
                    &nbsp; &nbsp;<asp:Label ID="lblMsg" runat="server" ForeColor="#C00000"></asp:Label>
            </div>
            </div>
             <div class="clearfix"></div><br />--%>
        

        
    
            <div class="col-sm-2 control-label">
                Title:<span style="color: Red">*</span>
            </div>
            <div class="col-sm-4">
                <asp:TextBox ID="txttitle" runat="server" CssClass="form-control" placeholder="Enter News Title"></asp:TextBox>
            </div>
     
        <div class="clearfix">
        </div>
     
      
            <div  class="col-sm-2 control-label">
                Type Of News :<span style="color: Red">*</span>
            </div>
            <div class="col-sm-4">
                <asp:DropDownList ID="ddlNewsType" runat="server" CssClass="form-control">
                    <asp:ListItem Value="N">Associate NEWS</asp:ListItem>
                    <asp:ListItem Value="FN">Franchise NEWS</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="clearfix">
            </div>
          
          
                <div class="col-sm-2 control-label">
                    Upload Image :<span style="color: Red">*</span>
                </div>
                <div class="col-sm-4">
                    <asp:FileUpload ID="imgUpload" runat="server" onchange="CheckUploadFile();" />

                   
                   
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="imgUpload"
                        ErrorMessage="Please Select Image"></asp:RequiredFieldValidator>
                     <div class="alert alert-primary alert-dismissible fade show mt-2">									
									<strong>Note</strong> file size must be
                        less than 500 KB and file types must be .jpg/.jpeg/.png/.gif.
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
								</div>
                </div>
          
          
           
                <div class="col-sm-2 control-label">
                    Message :<span style="color: Red">*</span>
                </div>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtMsg" runat="server" TextMode="MultiLine" Columns="60" Rows="5"
                        CssClass="form-control" placeholder="Type Your Message"></asp:TextBox>
                </div>
           
         
                <div class="col-sm-4">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" CssClass="btn btn-primary"
                        ValidationGroup="Save" OnClientClick="return Validate();" />
                </div>
            </div>
        </div>
        <table style="width: 100%;">
            <tr>
                <td>
                </td>
                <td colspan="2">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txttitle"
                        Display="None" ErrorMessage="Please enter title!" SetFocusOnError="true" ValidationGroup="Save"></asp:RequiredFieldValidator>
                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDate"
                        Display="None" ErrorMessage="Please enter  date!" ValidationGroup="Save"></asp:RequiredFieldValidator>--%>
                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                        ControlToValidate="txtDate" Display="none" ErrorMessage="Please enter date in dd/mm/yyyy format!"
                        Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*" ValidationGroup="Save"></asp:RegularExpressionValidator>--%>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
                        ShowSummary="false" ValidationGroup="Save" />
                </td>
            </tr>
        </table>
    </asp:Panel>
   
   
</asp:Content>
