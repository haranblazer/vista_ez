<%@ Page Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="ViewMessage.aspx.cs"
    Inherits="user_ViewMessage" Title="View Message" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="site-content">
        <div class="panel panel-default">
            <asp:LinkButton ID="lnkbtnBack" Font-Bold="true" runat="server" ForeColor="Blue"
                OnClick="lnkbtnBack_Click">Back </asp:LinkButton>
            <asp:Label ID="lblDate" runat="server" Font-Bold="True"></asp:Label>


            <div class="row">
                <div class="col-md-2"><b>Sender:</b></div>
                <div class="col-md-2">
                    <asp:Label ID="lblName" runat="server"></asp:Label></div>
            </div>
            <div runat="server" visible="false">
                <div class="col-md-2">
                    <b>Sender Id</b>
                </div>
                <div class="col-md-2">
                    <asp:Label ID="lblSenderId" runat="server" Font-Bold="True"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">
                    <b>E-Mail Id:</b>
                </div>
                <div class="col-md-2">
                    <asp:Label ID="lblEMailId" runat="server"></asp:Label>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-2">
                    <b>Mobile Number:</b>
                </div>
                <div class="col-md-2">
                    <asp:Label ID="lblMobileNo" runat="server"></asp:Label>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-2">
                    <b>Subject : </b>
                </div>
                <div class="col-md-2">
                    <asp:Label ID="lblSubject" runat="server" Font-Bold="True"></asp:Label>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-4">
                    <asp:LinkButton ID="lnkbtnReply" runat="server" CssClass="btn btn-primary" OnClick="lnkbtnReply_Click">Reply<span class="btn-icon-end"><i class="fa fa-reply"></i></span> </asp:LinkButton>
                    <asp:LinkButton
                        ID="lnkbtnSend" runat="server" Font-Bold="True" Font-Size="Small" OnClick="lnkbtnSend_Click"
                        ValidationGroup="sm">Send</asp:LinkButton>&nbsp;&nbsp;<asp:LinkButton ID="lnkbtnCancel"
                            runat="server" Font-Bold="True" Font-Size="Small" OnClick="lnkbtnCancel_Click">Cancel</asp:LinkButton>
                </div>
            </div>
            <div class="row" runat="server" id="trIP">
                <div class="col-md-12">
                    your IP
                        <asp:Label ID="lblIP" runat="server" Font-Size="Small"></asp:Label>
                    is being registered...
                </div>
            </div>
            <div class="col-md-6">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Size="10pt"></asp:Label>
                <asp:TextBox ID="txtMessage" CssClass="form-control" runat="server" Height="250px"
                    TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMessage"
                    ErrorMessage="Please enter message!" ValidationGroup="sm" Display="None"></asp:RequiredFieldValidator>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="sm" />
            </div>
        </div>
    </div>
</asp:Content>