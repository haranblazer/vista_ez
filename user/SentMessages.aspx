<%@ Page Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="SentMessages.aspx.cs"
    Inherits="user_SentMessages" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Sent Messages</h4>					
				</div>
    <div id="Tr11" runat="server">
                        <span style="color: #3333CC; font-size: small">
                            <i><b>...last 30 days deleted messages</b></i>
                        </span>
                    </div>

                    <div id="Tr1" runat="server" class="row mt-2">
                        
                           
                                <div class="col-md-3 control-label">Search message by subject</div>
                        <div class="col-md-4">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" pattern="^[a-zA-Z0-9\s]+$" title="Search Creteria contain letters and numbers with space or without space."
                                    required="required"></asp:TextBox></div>
                               <div class="col-md-2"> <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                                    ValidationGroup="Search" CssClass="btn btn-primary" /></div>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtSearch"
                    ErrorMessage="Please Enter Subject Of The Message !" Font-Names="Arial" Font-Size="10pt"
                    ForeColor="#C00000" ValidationGroup="Search" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                       
                    </div>
                    <div runat="server" id="search" style="font-size: 10pt">
                       
                            <ul>
                                <li>
                                    <asp:LinkButton ID="LinkButton1" Font-Bold="true" runat="server" OnClick="lnkbtnMessageBox_Click"
                                        CssClass="message_link">InBox</asp:LinkButton></li>
                            </ul>
                      
                    </div>
                    <div id="Tr2" runat="server">
                       
                            <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Size="10pt"></asp:Label>
                      
                    </div>
                    <div class="table-responsive">
                       
                            <asp:GridView ID="GridView1" EmptyDataText="message not found." runat="server" AutoGenerateColumns="False"
                                AllowPaging="True" CssClass="table table-striped table-hover display dataTable nowrap cell-border" PageSize="25" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
                                OnRowCommand="GridView1_RowCommand" GridLines="Horizontal">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnfldMessageId" runat="server" Value='<%# Eval("MessageId") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnReceiverName" Font-Underline="false" Text='<%# Eval("ReceiverId") %>'
                                                CommandName="ReceiverName" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
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
                   
           
</asp:Content>
