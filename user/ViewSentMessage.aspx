<%@ Page Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="ViewSentMessage.aspx.cs"
    Inherits="user_ViewSentMessage" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="site-content">
        <div class="panel panel-default">
            <table style="width: 100%; font-size: 11pt" cellspacing="0">
                <tr>
                    <td colspan="2">
                        <table style="width: 100%;" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lnkbtnBack" Font-Bold="true" runat="server" OnClick="lnkbtnBack_Click">Back </asp:LinkButton>
                                </td>
                                <td>
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
                    <td>
                        Sender:
                    </td>
                    <td>
                        <asp:Label ID="lblName" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Sender Id</b>
                    </td>
                    <td>
                        <asp:Label ID="lblSenderId" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Mobile Number:
                    </td>
                    <td>
                        <asp:Label ID="lblMobileNo" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Subject</b>
                    </td>
                    <td>
                        <asp:Label ID="lblSubject" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
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
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Size="10pt"></asp:Label>
                    </td>
                </tr>
                <tr style="height: 400px">
                    <td style="width: 118px; vertical-align: text-top;">
                        &nbsp;
                    </td>
                    <td style="vertical-align: text-top;">
                        <asp:TextBox ID="txtMessage" runat="server" Height="300px" Width="600px" BackColor="#FAF8CC"
                            BorderStyle="None" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 118px; vertical-align: text-top; height: 101px;">
                    </td>
                    <td style="height: 101px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMessage"
                            ErrorMessage="Please Enter Message!" ValidationGroup="sm"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" Width="230px"
                            TargetControlID="RequiredFieldValidator1" runat="server" />
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
