<%@ Page Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="Messages.aspx.cs"
    Inherits="user_Messages" Title="Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
<!--

        function check_uncheck(Val) {
            var ValChecked = Val.checked;
            var ValId = Val.id;
            var frm = document.forms[0];
            // Loop through all elements
            for (i = 0; i < frm.length; i++) {
                // Look for Header Template's Checkbox
                //As we have not other control other than checkbox we just check following statement
                if (this != null) {
                    if (ValId.indexOf('CheckAll') != -1) {
                        // Check if main checkbox is checked,
                        // then select or deselect datagrid checkboxes
                        if (ValChecked) {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[i].checked = true;

                                //frm.elements[i+1].parentNode.parentNode.style.backgroundColor = "#FAF8CC";

                            }

                        }
                        else {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[i].checked = false;
                                // frm.elements[i].parentNode.parentNode.style.backgroundColor = "white";         
                            }
                        }
                    }
                    else if (ValId.indexOf('deleteRec') != -1) {
                        // Check if any of the checkboxes are not checked, and then uncheck top select all checkbox
                        if (frm.elements[i].checked == false) {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[1].checked = false;
                                //frm.elements[i].parentNode.parentNode.style.backgroundColor = "white"; 
                            }
                        }
                        else if (frm.elements[i].checked == true) {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[1].checked = true;
                                // frm.elements[i].parentNode.parentNode.style.backgroundColor = "#FAF8CC"; 
                            }
                        }
                    }
                } // if
            } // for
        } // function


 
    </script>

      <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Raise Tickets Box
</h4>					
				</div>
  
  
            <div runat="server">
                                <asp:HiddenField ID="hidid" runat="server" />
                                <div>
                                    <div class="row ">
                                        <div class="col-md-3 control-label">
                                            Search message by subject
                                        </div>
                                        <div class="col-md-3 " style="padding-bottom: 15px;">
                                            <asp:TextBox ID="txtSearch" runat="server" pattern="^[a-zA-Z0-9\s]+$" title="Search Creteria contain letters and numbers with space or without space."
                                                required="required" CssClass="form-control"></asp:TextBox>
                                        </div>
                                   
                                        <div class="col-md-3 btn1">
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                                                ValidationGroup="Search" CssClass="btn btn-primary" />
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix">
                                </div>
                                <div class="col-md-12" runat="server" id="search">
                                    <%--<button type="button" class="btn btn-primary">Compose <span class="btn-icon-end"><i class="fa fa-edit"></i></span>
                                </button>
                                       <button type="button" class="btn btn-primary">InBox<span class="btn-icon-end"><i class="fa fa-inbox"></i></span>
                                </button>
                                     <button type="button" class="btn btn-primary">Read Messages<span class="btn-icon-end"><i class="fa fa-envelope-open"></i></span>
                                </button>
                                    <button type="button" class="btn btn-primary">Un-Read Messages<span class="btn-icon-end"><i class="fa fa-envelope"></i></span>
                                </button>
                                      <button type="button" class="btn btn-primary">Sent Messages<span class="btn-icon-end"><i class="fa fa-paper-plane"></i></span>
                                </button>
                                    <button type="button" class="btn btn-danger">Deleted Messages<span class="btn-icon-end"><i class="fa fa-trash"></i></span>
                                </button>
                                      <button type="button" class="btn btn-danger">Deleted<span class="btn-icon-end"><i class="fa fa-trash"></i></span>
                                </button>--%>
                               <%-- <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/user/images/sent_items.gif" />--%>
                              <asp:LinkButton ID="lnkbtnCompose" Font-Bold="true" runat="server" OnClick="lnkbtnCompose_Click"
                                    CssClass="btn btn-primary">Compose <span class="btn-icon-end"><i class="fa fa-edit"></i></span> </asp:LinkButton>
                                <%--<asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/user/images/inbox.gif"
                                    OnClick="ImageButton5_Click" />--%>
                                <asp:LinkButton ID="lnkbtnMessageBox" Font-Bold="true" runat="server" OnClick="lnkbtnMessageBox_Click"
                                    CssClass="btn btn-primary">InBox<span class="btn-icon-end"><i class="fa fa-inbox"></i></span> </asp:LinkButton>
                               <%-- <asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/user/images/new_msgs.gif"
                                    OnClick="ImageButton6_Click" />--%>
                                &nbsp;<asp:LinkButton ID="lnkbtnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnReadMessages_Click"
                                    CssClass="btn btn-primary">Read Messages<span class="btn-icon-end"><i class="fa fa-envelope-open"></i></span> </asp:LinkButton><%--<asp:ImageButton ID="ImageButton6"
                                        runat="server" ImageUrl="~/user/images/new_msgs.gif" OnClick="ImageButton6_Click" />--%>
                                <asp:LinkButton ID="lnkbtnUnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnUnReadMessages_Click"
                                    CssClass="btn btn-primary">Un-Read Messages<span class="btn-icon-end"><i class="fa fa-envelope"></i></span></asp:LinkButton>
                                <%--<asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="images/inbox.gif" OnClick="ImageButton5_Click" />--%>
                                <asp:LinkButton ID="LinkButton2" Font-Bold="true" runat="server" CssClass="btn btn-primary"
                                    OnClick="lnkbtnSentMessages_Click1">Sent Messages<span class="btn-icon-end"><i class="fa fa-paper-plane"></i></span></asp:LinkButton>
                                &nbsp;<%--<asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/user/images/trash.gif"
                                    OnClick="ImageButton4_Click" />--%>
                                <asp:LinkButton ID="lnkbtnDeletedMessages" Font-Bold="true" runat="server" OnClick="lnkbtnDeletedMessages_Click"
                                    CssClass="btn btn-danger">Deleted Messages<span class="btn-icon-end"><i class="fa fa-trash"></i></span> </asp:LinkButton>&nbsp;
                                <%--<asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/user/images/trash.gif"
                                    OnClick="ImageButton4_Click" />--%>
                                <asp:LinkButton ID="lnkbtnDelete" Font-Bold="true" runat="server" OnClick="lnkbtnDelete_Click"
                                    CssClass="btn btn-danger">Delete<span class="btn-icon-end"><i class="fa fa-trash"></i></span> </asp:LinkButton>
                                <p>
                                    &nbsp;</p>
                            </div>

                            
                      
                            <div class="col-md-12" id="Tr1" runat="server">
                                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Size="10pt"></asp:Label>
                            </div>
                            <div class="table-responsive">
                                <div class="col-md-12 ">
                                    <asp:GridView ID="GridView1" DataKeyNames="MessageId" EmptyDataText="Message not found."
                                        runat="server" AutoGenerateColumns="False" AllowPaging="True" CssClass="table table-striped table-hover display dataTable nowrap cell-border"
                                        PageSize="25" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
                                        GridLines="Horizontal" OnRowDataBound="GridView1_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" >
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="deleteRec" OnClick="return check_uncheck(this);" runat="server" />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="CheckAll" TextAlign="Left" runat="server" OnClick="return check_uncheck(this); " />
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnfldMessageId" runat="server" Value='<%# Eval("MessageId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgStatus" runat="server" /></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnSenderName" Font-Underline="false" Text='<%# Eval("SenderId") %>'
                                                        CommandName="SenderName" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                        runat="server" /></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnSubject" Font-Underline="false" Text='<%# Eval("MsgSubject") %>'
                                                        CommandName="Subject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                        runat="server" /></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnDOE" Font-Underline="false" Text='<%# Eval("doe") %>' CommandName="doe"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" runat="server" /></ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                              
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtSearch"
                    ErrorMessage="Please Enter Subject Of The Message !" Font-Names="Arial" Font-Size="10pt"
                    ForeColor="#C00000" ValidationGroup="Search" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>

                         
   <style>
   th {
    text-align: left;
}
  </style>
   

</asp:Content>
