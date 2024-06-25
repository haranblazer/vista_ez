<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="SentMessages.aspx.cs" Inherits="user_SentMessages" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Sent Messages</h4>
<div class="row">
                    <div class="col-md-12"  id="Tr11" runat="server" style="color: #3333CC; font-size: small;"> <i><b>...last 30 days deleted messages</b></i> </div>

       
         <div class="col-md-3">  <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search message by User Id"></asp:TextBox> </div>

         <div class="col-md-3">  <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                    ValidationGroup="Search" CssClass="btn btn-primary" /> </div>
                </div>
                
        <div class="col-md-3">  <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtSearch"
                    ErrorMessage="Please enter DID / User Id !" Font-Names="Arial" Font-Size="10pt"
                    ForeColor="#C00000" ValidationGroup="Search" Display="Dynamic"></asp:RequiredFieldValidator> </div>
 <div class="col-md-12">    <asp:LinkButton class="subhead" ID="LinkButton1" runat="server" OnClick="lnkbtnMessageBox_Click"
                   >InBox</asp:LinkButton> </div>
            </div>
    
  <hr />


  <div class="table-responsive">
    <table style="width: 100%; padding: 10px;" id="Tblid1" runat="server" visible="true">
  
        <tr id="Tr2" runat="server">
            <td style="text-align: left">
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" EmptyDataText="Message not found." CssClass="table table-striped table-hover"
                    runat="server" AutoGenerateColumns="False" AllowPaging="false" PageSize="25"
                    Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                       <%-- <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnfldMessageId" runat="server" Value='<%# Eval("MessageId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <%--  <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="DID">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnDID" Font-Underline="false" Text='<%# Eval("ReceiverDID") %>'
                                    CommandName="DID" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" /></ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Receiver Id">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnId" Font-Underline="false" Text='<%# Eval("ReceiverId") %>'
                                    CommandName="Id" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" /></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Receiver Name">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnReceiverName" Font-Underline="false" Text='<%# Eval("ReceiverName") %>'
                                    CommandName="ReceiverName" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" Style="text-transform: uppercase" /></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Subject">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnSubject" Font-Underline="false" Text='<%# Eval("MsgSubject") %>'
                                    CommandName="Subject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" Style="text-transform: uppercase" /></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Date">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnDOE" Font-Underline="false" Text='<%# Eval("doe") %>' CommandName="doe"
                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" runat="server" Style="text-transform: uppercase" /></ItemTemplate>
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
     <div class="clearfix"> </div> <br />
     <div class="table-responsive">
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
                            <asp:LinkButton ID="lnkbtnBack" Font-Bold="true" runat="server" 
                            OnClick="lnkbtnBack_Click">Back </asp:LinkButton>
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
        <tr id="Tr3" runat="server" visible="false">
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
                <b>Sender</b>
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
                <b>Sent To</b>
            </td>
            <td>
                <asp:Label ID="lblSentTo" runat="server" Font-Bold="True"></asp:Label>
                <asp:Label ID="lblSentToName" runat="server" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr id="Tr4" runat="server" visible="false">
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
        <tr id="Tr5" runat="server" visible="false">
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
                    OnClick="lnkbtnReply_Click">Reply</asp:LinkButton><asp:LinkButton ID="lnkbtnSend"
                        runat="server" Font-Bold="True" Font-Size="Small" OnClick="lnkbtnSend_Click"
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
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                 ControlToValidate="txtMessage" ErrorMessage="Please Enter Message!" ValidationGroup="sm"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" Width="230px"
                    TargetControlID="RequiredFieldValidator1" runat="server" />
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
    </div>
  
</asp:Content>
