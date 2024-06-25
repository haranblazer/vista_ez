<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="DeletedMessages.aspx.cs" Inherits="user_DeletedMessages" Title="Deleted Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Deleted Messages</h4>
     <div class="row">
                    <div class="col-md-12"  id="Tr11" runat="server" style="color: #3333CC; font-size: small"> <i><b>...last 30 days deleted messages</b></i> </div>
     <div class="clearfix"> </div>

     <div class="form-group" id="Tr1" runat="server"> 
    
     <div class="col-md-3"> <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search message by User Id "></asp:TextBox> </div>
     </div>

      <div class="clearfix"> </div>

       <div class="form-group" id="Div1" runat="server"> 
    
     <div class="col-md-3">  <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                    ValidationGroup="Search" CssClass="btn btn-primary" /> </div>

    <div class="col-md-6">    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtSearch"
                    ErrorMessage="Please enter DID / User Id !" Font-Names="Arial" Font-Size="10pt"
                    ForeColor="#C00000" ValidationGroup="Search" Display="Dynamic"></asp:RequiredFieldValidator>  </div>

     </div>
                </div>

  
    
<hr />
      <div class="table-responsive">
    <table style="width: 100%; padding: 10px;">
        
        <tr runat="server" id="search" style="font-size: 10pt">
            <td class="message_bg">
                <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/user/images/inbox.gif" />
                <asp:LinkButton ID="LinkButton1" Font-Bold="true" runat="server" OnClick="lnkbtnMessageBox_Click"
                    CssClass="txt message_link">InBox</asp:LinkButton>
                &nbsp; &nbsp;<asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/user/images/new_msgs.gif" />
                <asp:LinkButton class="head" ID="lnkbtnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnReadMessages_Click"
                    CssClass=" txt message_link">Read Messages</asp:LinkButton>
                &nbsp;<asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/user/images/new_msgs.gif" />
                <asp:LinkButton ID="lnkbtnUnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnUnReadMessages_Click"
                    CssClass="txt message_link">Un-Read Messages</asp:LinkButton>
                &nbsp;
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/inbox.gif" Visible="false" />
                <asp:LinkButton ID="LinkButton2" Font-Bold="true" runat="server" CssClass="txt message_link"
                    OnClick="lnkbtnSentMessages_Click1" Visible="false">Sent Messages</asp:LinkButton>
                <asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/user/images/trash.gif"
                    Visible="false" />
                <asp:LinkButton ID="lnkbtnDeletedMessages" Font-Bold="true" runat="server" OnClick="lnkbtnDeletedMessages_Click"
                    CssClass="txt message_link" Visible="false">Deleted Messages</asp:LinkButton>
            </td>
        </tr>
        <tr id="Tr2" runat="server">
            <td style="text-align: left">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Size="10pt"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="True"
                    EmptyDataText="Message not found." CssClass="paging_gridview" PageSize="25" Width="100%"
                    OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound"
                    OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnfldMessageId" runat="server" Value='<%# Eval("MessageId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" /></ItemTemplate>
                        </asp:TemplateField>
                        <%--  <asp:BoundField DataField="SenderDID" HeaderText="DID" />--%>
                        <asp:BoundField DataField="SenderId" HeaderText="User Id" />
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnSenderName" Enabled="false" Font-Underline="false" Text='<%# Eval("SenderName") %>'
                                    CommandName="SenderName" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" /></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnSubject" Enabled="false" Font-Underline="false" Text='<%# Eval("MsgSubject") %>'
                                    CommandName="Subject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" /></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnDOE" Enabled="false" Font-Underline="false" Text='<%# Eval("doe") %>'
                                    CommandName="doe" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" /></ItemTemplate>
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
   
    </div>
</asp:Content>
