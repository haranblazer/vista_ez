<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="UserSalary.aspx.cs" Inherits="secretadmin_UserSalary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="c1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <style type="text/css">
        .tableBackground
        {
            background-color: silver;
            opacity: 0.7;
            z-index: 100000;
        }
    </style>
  <h2 class="head">
            <i class="fa fa-money" aria-hidden="true"></i>
 Salary</h2>


    <div class="">
    </div>
    <br />
    <div class="table-responsive">
        <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
            AutoGenerateColumns="false" DataKeyNames="regno" PageSize="50" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
            OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="SrNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="UserID" DataField="regno" />
                <asp:BoundField HeaderText="Name" DataField="fname" />
                <asp:TemplateField HeaderText="Sr. Executive">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk1" Text='<%#Eval("r1") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="r1" runat="server" Style="text-align: center" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Team Leader">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk2" Text='<%#Eval("r2") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="r2" runat="server" Style="text-align: center" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Manager">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk3" Text='<%#Eval("r3") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="r3" runat="server" Style="text-align: center" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Area Manager">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk4" Text='<%#Eval("r4") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="r4" runat="server" Style="text-align: center" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Asst General Manager">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk5" Text='<%#Eval("r5") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="r5" runat="server" Style="text-align: center" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Manager">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk6" Text='<%#Eval("r6") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="r6" runat="server" Style="text-align: center" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Business Head">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk7" Text='<%#Eval("r7") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="r7" runat="server" Style="text-align: center" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <br />
    <c1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="modelPopup"
        RepositionMode="RepositionOnWindowScroll" PopupControlID="updatePanel" CancelControlID="btnCancel"
        BackgroundCssClass="tableBackground">
    </c1:ModalPopupExtender>
    <asp:Panel ID="updatePanel" runat="server" BackColor="White" Width="80%" Style="display: none">
        <div>
            <asp:Button ID="modelPopup" runat="server" Style="display: none" />
            <table width="100%" cellspacing="4">
                <tr style="background-color: #33CC66">
                    <td align="center">
                        Salary Details
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView AllowPaging="true" ID="GridView2" runat="server" CssClass="table table-striped table-hover mygrd"
                            AutoGenerateColumns="false" DataKeyNames="regno" PageSize="50" Width="100%" OnPageIndexChanging="GridView2_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="SrNo.">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="regno" HeaderText="User ID" />
                                <asp:BoundField DataField="fname" HeaderText=" UserName" />
                                <asp:BoundField DataField="designation" HeaderText="Designation" />
                                <asp:BoundField DataField="amount" HeaderText="Amount" />
                                <asp:BoundField DataField="doe" HeaderText="Doe" />
                                <asp:BoundField DataField="status" HeaderText="Status" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnCancel" runat="server" Text="Close" CssClass="btn btn-success" />
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
</asp:Content>
