<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="Messages.aspx.cs" Inherits="user_Messages" Title="Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <script language="javascript" type="text/javascript">
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

                                frm.elements[i + 1].parentNode.parentNode.style.backgroundColor = "#FAF8CC";

                            }

                        }
                        else {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[i].checked = false;
                                frm.elements[i].parentNode.parentNode.style.backgroundColor = "white";
                            }
                        }
                    }
                    else if (ValId.indexOf('deleteRec') != -1) {
                        // Check if any of the checkboxes are not checked, and then uncheck top select all checkbox
                        if (frm.elements[i].checked == false) {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[1].checked = false;
                                frm.elements[i].parentNode.parentNode.style.backgroundColor = "white";
                            }
                        }
                        else if (frm.elements[i].checked == true) {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[1].checked = true;
                                frm.elements[i].parentNode.parentNode.style.backgroundColor = "#FAF8CC";
                            }
                        }
                    }
                } // if
            } // for
        } // function
    </script>
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Message Box</h4>
  <div class="row">
                   <div class="col-md-3">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Style="clear: both;"
                placeholder="Search Message By User Id"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvSearch" runat="server" ControlToValidate="txtSearch"
                ErrorMessage="Please Enter User Id !" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000"
                ValidationGroup="Search" Display="Dynamic"></asp:RequiredFieldValidator>           
        </div>
        <div class="col-md-2">
            <button id="btnSearch" runat="server" validationgroup="Search" class="btn btn-primary"
                title="Search" onserverclick="btnSearch_Click">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>
                </div>
    <hr />
      
  
    <table style="width: 100%" id="Tblid1" runat="server" visible="true">
        <tr runat="server">
            <td>
                <asp:HiddenField ID="hidid" runat="server" />
            </td>
        </tr>
        <tr runat="server" id="search">
            <td>
                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/user/images/sent_items.gif"
                    Visible="false" />
                <asp:LinkButton ID="lnkbtnCompose" Font-Bold="true" runat="server" OnClick="lnkbtnCompose_Click"
                    CssClass="message_link" Visible="false">Compose</asp:LinkButton>
                <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/user/images/inbox.gif"
                    OnClick="ImageButton5_Click" />
                <asp:LinkButton ID="lnkbtnMessageBox" Font-Bold="true" runat="server" OnClick="lnkbtnMessageBox_Click"
                    CssClass="message_link">InBox</asp:LinkButton>
                <asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/user/images/new_msgs.gif"
                    OnClick="ImageButton6_Click" />
                &nbsp;<asp:LinkButton ID="lnkbtnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnReadMessages_Click"
                    CssClass="message_link">Read Messages</asp:LinkButton>
                <asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/user/images/new_msgs.gif"
                    OnClick="ImageButton6_Click" />
                <asp:LinkButton ID="lnkbtnUnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnUnReadMessages_Click"
                    CssClass="message_link">Unread Messages</asp:LinkButton>
                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/user/images/inbox.gif"
                    OnClick="ImageButton5_Click" Visible="false" />
                <asp:LinkButton ID="LinkButton2" Font-Bold="true" runat="server" CssClass="message_link"
                    OnClick="lnkbtnSentMessages_Click1" Visible="true">Sent Messages</asp:LinkButton>
                &nbsp;<asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/user/images/trash.gif"
                    OnClick="ImageButton4_Click" Visible="false" />
                <asp:LinkButton ID="lnkbtnDeletedMessages" Font-Bold="true" runat="server" OnClick="lnkbtnDeletedMessages_Click"
                    CssClass="message_link" Visible="false">Deleted Messages</asp:LinkButton>&nbsp;
                <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/user/images/trash.gif"
                    OnClick="ImageButton4_Click" />
                <asp:LinkButton ID="lnkbtnDelete" Font-Bold="true" runat="server" OnClick="lnkbtnDelete_Click"
                    CssClass="message_link">Delete</asp:LinkButton>
            </td>
        </tr>
        <tr id="Tr1" runat="server">
            <td style="text-align: left">
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" DataKeyNames="MessageId" CssClass="table table-striped table-hover" EmptyDataText="Message not found."
                    runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="25" Width="100%"
                    OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
                    OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="deleteRec" OnClick="return check_uncheck(this);" runat="server" />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CheckAll" TextAlign="Left" runat="server" OnClick="return check_uncheck(this); " />
                            </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnfldMessageId" runat="server" Value='<%# Eval("MessageId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="SenderId" HeaderText="User Id" />
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnSenderName" Font-Underline="false" Text='<%# Eval("SenderName") %>'
                                    CommandName="SenderName" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnSubject" Font-Underline="false" Text='<%# Eval("MsgSubject") %>'
                                    CommandName="Subject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnDOE" Font-Underline="false" Text='<%# Eval("doe") %>' CommandName="doe"
                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" runat="server" /></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="text-align: center">
            </td>
        </tr>
    </table>
    <table style="width: 100%; font-size: 11pt" cellspacing="0" id="Tblid2" runat="server"
        visible="false">
        <tr>
            <td style="height: 25px; width: 35px;">
                &nbsp;
            </td>
            <td colspan="2" style="height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
                &nbsp;
            </td>
            <td colspan="2">
                <table style="width: 100%;" cellspacing="0">
                    <tr>
                        <td style="width: 753px">
                            <asp:LinkButton ID="lnkbtnBack" runat="server" ForeColor="Blue" OnClick="lnkbtnBack_Click">Back </asp:LinkButton>
                        </td>
                        <td style="width: 258px; text-align: right">
                            <asp:Label ID="lblDate" runat="server" Font-Bold="True"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
            </td>
            <td style="width: 118px">
                Sender:
            </td>
            <td>
                <asp:Label ID="lblName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
                &nbsp;
            </td>
            <td style="width: 118px">
                <b>Sender Id</b>
            </td>
            <td>
                <asp:Label ID="lblSenderId" runat="server" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
                &nbsp;
            </td>
            <td style="width: 118px">
                Last answered by :
            </td>
            <td>
                <asp:Label ID="lblReceiver" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
                &nbsp;
            </td>
            <td style="width: 118px">
                E-Mail Id
            </td>
            <td>
                <asp:Label ID="lblEMailId" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
                &nbsp;
            </td>
            <td style="width: 118px">
                Mobile Number:
            </td>
            <td>
                <asp:Label ID="lblMobileNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
                &nbsp;
            </td>
            <td>
                <b>Subject</b>
            </td>
            <td>
                <asp:Label ID="lblSubject" runat="server" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:LinkButton ID="lnkbtnReply" runat="server" Font-Bold="True" Font-Size="Small"
                    ForeColor="Blue" OnClick="lnkbtnReply_Click">Reply</asp:LinkButton><asp:LinkButton
                        ID="lnkbtnSend" runat="server" Font-Bold="True" Font-Size="Small" OnClick="lnkbtnSend_Click"
                        ValidationGroup="sm">Send</asp:LinkButton>&nbsp;&nbsp;<asp:LinkButton ID="lnkbtnCancel"
                            runat="server" Font-Bold="True" Font-Size="Small" OnClick="lnkbtnCancel_Click">Cancel</asp:LinkButton>
            </td>
        </tr>
        <tr runat="server" id="trIP">
            <td style="width: 35px">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                your IP
                <asp:Label ID="lblIP" runat="server" Font-Size="Small"></asp:Label>
                is being registered...
            </td>
        </tr>
        <tr>
            <td style="width: 35px">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Size="10pt"></asp:Label>
            </td>
        </tr>
        <tr style="height: 400px">
            <td style="width: 35px; vertical-align: text-top;">
                &nbsp;
            </td>
            <td style="width: 118px; vertical-align: text-top;">
                &nbsp;
            </td>
            <td style="vertical-align: text-top;">
                <asp:TextBox ID="txtMessage" runat="server" Height="500px" Width="899px" BackColor="#FAF8CC"
                    BorderStyle="None" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 35px; vertical-align: text-top; height: 101px;">
                &nbsp;
            </td>
            <td style="width: 118px; vertical-align: text-top; height: 101px;">
            </td>
            <td style="height: 101px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="None"
                    ControlToValidate="txtMessage" ErrorMessage="Please enter message!" ValidationGroup="sm"></asp:RequiredFieldValidator>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="sm"
                    ShowMessageBox="true" ShowSummary="false" />
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
  
</asp:Content>
