<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="AddAchiever.aspx.cs" Inherits="admin_AddAchiever" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
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

        function ConfirmDelete() {
            if (confirm("Are you sure want to delete this record?")) {
                return true;
            }
            return false;
        }
 
    </script>
    <script type="text/javascript" charset="utf-8">

        function ConfirmMsg() {
            if (confirm("Are you sure to perform this action?")) {
                return true;
            }
            return false;
        }

    </script>
    <script language="javascript" type="text/javascript">
        function CallVal(txt) {
            ServerSendValue(txt.value, "ctx");
        }
        function ServerResult(arg) {

            if (arg == "You cannot leave blank field here !") {
                document.getElementById("lblUser.ClientID").style.color = "Red";
                document.getElementById("lblUser.ClientID").innerHTML = arg;
            }
            else {
                document.getElementById("<%=lblUser.ClientID%>").style.color = "darkblue";
                document.getElementById("<%=lblUser.ClientID%>").innerHTML = arg;
            }
        }
        function ClientErrorCallback() {
        }
    </script>
    
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add Achiever</h4>					
				</div>
  
       
     
    
    
   
        <div class="col-md-2 ">
            User Id:<span style="color: Red">*</span>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtUserId" runat="server" onchange="return CallVal(this);" CausesValidation="True"
                placeholder="Enter User ID" CssClass="form-control" MaxLength="15"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
            <br />
            <asp:RequiredFieldValidator ID="rfvtxtid" runat="server" ErrorMessage="Please Enter User Id."
                SetFocusOnError="true" Display="None" ControlToValidate="txtUserId" ValidationGroup="a"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revUId" runat="server" Display="None" SetFocusOnError="true"
                ForeColor="Red" ValidationGroup="a" ErrorMessage="Only alphanumeric values are allowed without space."
                ValidationExpression="^[a-zA-Z0-9]*$" ControlToValidate="txtUserId"></asp:RegularExpressionValidator>
        </div>
  
 
   
        <div class="col-md-2">
            Description:<span style="color: Red">*</span>
         
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Columns="50" Rows="5"
                placeholder="Type Your Description" CssClass="form-control" ClientIDMode="Static" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" SetFocusOnError="true"
                ErrorMessage="Please Enter Description" Display="None" ControlToValidate="txtMessage"
                ValidationGroup="a" ForeColor="Red"></asp:RequiredFieldValidator>
            <label id="lblCharLeft">
            </label>
        </div>
 
        <div class="col-md-2 control-label">
                    Upload Image :<span style="color: Red">*</span>
        </div>
        <div class="col-md-4">
            <asp:FileUpload ID="imgUpload" runat="server" onchange="CheckUploadFile();" />
             <div class="clearfix"></div>
                     <br />
            

            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" SetFocusOnError="true" ErrorMessage="Please Upload Picture"
                ControlToValidate="imgUpload" runat="server" Display="None" ForeColor="Red" ValidationGroup="a" />
            <asp:RegularExpressionValidator ID="revImg" runat="server" SetFocusOnError="true"
                ErrorMessage="Only .jpg/.jpeg/.png/.gif file types are allowed." Display="None"
                ValidationGroup="a" ControlToValidate="imgUpload" ValidationExpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N|d|D)(g|G|f|F))$"></asp:RegularExpressionValidator>

            <div class="alert alert-primary alert-dismissible fade show mt-2">									
									<strong>Note</strong> file size must be
                        less than 500 KB and file types must be .jpg/.jpeg/.png/.gif.
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
								</div>
        </div>
    
    
        <div class="col-md-4 ">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" CssClass="btn btn-primary"
                ValidationGroup="a" Style="margin-bottom: 10px" />
        </div>
   
   
        <div class="col-md-3">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
                ValidationGroup="a" ShowSummary="false" />
        </div>
  
    <hr />
    <div class="table-responsive">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowPaging="true"
            EmptyDataText="Record Not Found." CssClass="table table-striped table-hover"
            PageSize="25" OnPageIndexChanging="GridView1_PageIndexChanging" DataKeyNames="NewsMstId"
            OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ID" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("NewsMstId") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="newsmsttitle" HeaderText="Title" />
                <asp:BoundField DataField="newsmstdiscription" HeaderText="Description" />
                <asp:TemplateField HeaderText="Photo">
                    <ItemTemplate>
                        <a href="<%# Eval("Photo","../KYC/News/{0}") %>" data-fancybox="gallery">
                            <asp:Image ID="HImage" runat="server" Width="140px" Height="80px" CssClass="img-responsive img-rounded"
                                ImageUrl='<%# Eval("Photo","../KYC/News/{0}") %>' />
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="currentrecord" HeaderText="Status" Visible="false" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Image ID="imgStatus" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkActive" runat="server" OnClientClick="return ConfirmMsg();"
                            CommandArgument="<%# ((GridViewRow) Container).RowIndex %>">Activate</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDelete" runat="server" OnClientClick="return ConfirmDelete();"
                            CssClass="btn btn-danger btn-xs" OnClick="lnkDelete_Click"><i class="fa fa-trash"></i>&nbsp;Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
   
   
    <script language="javascript" type="text/javascript">
        var maxLength = 200;

        $(document).ready(function () {
            $("#lblCharLeft").text(maxLength + " characters left");
        });


        $('#<%=txtMessage.ClientID %>').keyup(function () {
            var text = $(this).val();
            var textLength = text.length;
            if (textLength > maxLength) {
                $(this).val(text.substring(0, (maxLength)));
                alert("Sorry, you only " + maxLength + " characters are allowed");
            }
            else {
                $("#lblCharLeft").text((maxLength - textLength) + " characters left.");
            }
        });
    </script>
</asp:Content>
