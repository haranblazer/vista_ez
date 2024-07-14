<%@ Page Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="DeletedMessages.aspx.cs"
    Inherits="user_DeletedMessages" Title="Deleted Messages" %>

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

                            // frm.elements[i+1].parentNode.parentNode.style.backgroundColor = "#FAF8CC";

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
                            // frm.elements[i].parentNode.parentNode.style.backgroundColor = "white"; 
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
        <h4 class="fs-20 font-w600  me-auto">Deleted Message
        </h4>
    </div>
    <div id="Tr11" runat="server">
        <i><b>...last 30 days deleted messages</b></i>
    </div>
    <br />
    <div id="Tr1" runat="server" class="row">
        <div class="col-md-3 control-label">
            Search message by subject 
        </div>
        <div class="col-md-3">
            <asp:TextBox ID="txtSearch" runat="server" pattern="^[a-zA-Z0-9\s]+$" cssclass="form-control" title="Search Creteria contain letters and numbers with space or without space."
                required="required">
            </asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                ValidationGroup="Search" cssclass="btn btn-primary" />
        </div>
        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtSearch"
                    ErrorMessage="Please Enter Subject Of The Message !" Font-Names="Arial" Font-Size="10pt"
                    ForeColor="#C00000" ValidationGroup="Search" Display="Dynamic"></asp:RequiredFieldValidator>--%>
    </div>
    <br />
    <div runat="server" id="search" style="font-size: 10pt">

        <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/user/images/inbox.gif" />
        <asp:LinkButton ID="LinkButton1" Font-Bold="true" runat="server" OnClick="lnkbtnMessageBox_Click"
            CssClass="message_link">
            InBox</asp:LinkButton>
        &nbsp; &nbsp;<asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/user/images/new_msgs.gif" />
        <asp:LinkButton ID="lnkbtnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnReadMessages_Click"
            CssClass="message_link">
            Read Messages</asp:LinkButton>
        &nbsp;<asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/user/images/new_msgs.gif" />
        <asp:LinkButton ID="lnkbtnUnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnUnReadMessages_Click"
            CssClass="message_link">
            Un-Read Messages</asp:LinkButton>
        &nbsp;
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/inbox.gif" />
        <asp:LinkButton ID="LinkButton2" Font-Bold="true" runat="server" CssClass="message_link"
            OnClick="lnkbtnSentMessages_Click1">
            Sent Messages</asp:LinkButton>
        &nbsp;<asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/user/images/trash.gif" />
        <asp:LinkButton ID="lnkbtnDeletedMessages" Font-Bold="true" runat="server" OnClick="lnkbtnDeletedMessages_Click"
            CssClass="message_link">
            Deleted Messages</asp:LinkButton>

    </div>
    <div id="Tr2" runat="server">
        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Size="10pt"></asp:Label>
    </div>
    <br />
    <div class="table-responsive">
        <asp:GridView ID="GridView1" EmptyDataText="message not found." runat="server" AutoGenerateColumns="False"
            AllowPaging="True" CssClass="table table-striped table-hover display dataTable nowrap cell-border" PageSize="25" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
            OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" GridLines="Horizontal"
            Font-Size="11pt">
            <columns>
                <asp:TemplateField>
                    <itemtemplate>
                        <asp:HiddenField ID="hdnfldMessageId" runat="server" Value='<%# Eval("MessageId") %>' />
                    </itemtemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                    <itemtemplate>
                        <asp:Image ID="imgStatus" runat="server" />
                    </itemtemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                    <itemtemplate>
                        <asp:LinkButton ID="lnkbtnSenderName" Enabled="false" Font-Underline="false" Text='<%# Eval("SenderId") %>'
                            CommandName="SenderName" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            runat="server" />
                    </itemtemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-HorizontalAlign="Left">
                    <itemtemplate>
                        <asp:LinkButton ID="lnkbtnSubject" Enabled="false" Font-Underline="false" Text='<%# Eval("MsgSubject") %>'
                            CommandName="Subject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            runat="server" />
                    </itemtemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-HorizontalAlign="Left">
                    <itemtemplate>
                        <asp:LinkButton ID="lnkbtnDOE" Enabled="false" Font-Underline="false" Text='<%# Eval("doe") %>'
                            CommandName="doe" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            runat="server" />
                    </itemtemplate>
                </asp:TemplateField>
            </columns>
        </asp:GridView>
    </div>
</asp:Content>
