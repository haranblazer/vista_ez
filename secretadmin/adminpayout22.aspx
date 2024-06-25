<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="adminpayout22.aspx.cs" Inherits="secretadmin_adminpayout22" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding-top: 10px;">
        <h2 class="head">
            Payment Reports</h2>
    </div>
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="control-label">
            Send Remark to Members</label>
        <div class="clearfix">
        </div>
        <div class="col-sm-3">
            <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-2">
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Submit / Modify Remark"
                CssClass="btn btn-success" Style="margin: 0 0 20px 0" />
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="table-responsive" style="border: none">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Font-Bold="true"></asp:Label>
                    &nbsp;
                    <asp:Label ID="Label1" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 700px; height: 25px; text-align: right" runat="server" id="msg">
                    <span>No of Records :</span><asp:Label ID="Label3" runat="server" Font-Bold="True"></asp:Label>&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="GridView1" DataKeyNames="appmstid,paymenttrandraftno,remarks" runat="server"
                        AutoGenerateColumns="False" PageSize="25" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging1"
                        CssClass="table table-striped table-hover mygrid" 
                        OnRowDataBound="GridView1_RowDataBound" onrowcommand="GridView1_RowCommand">
                        <Columns>
                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                DataField="appmstid" ReadOnly="True" HeaderText="user ID" />
                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                DataField="name" HeaderText="Name" />
                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                DataField="Totalearning" HeaderText="Total Income" />
                            <%--  <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                DataField="paymentdisplay" HeaderText="Payment Display" />--%>
                            <asp:TemplateField HeaderText="Payment Display">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkPD" runat="server" Text='<%# Eval("paymentdisplay") %>' CommandName="SH"
                                        CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'></asp:LinkButton>
                                    <asp:Label ID="lblPayoutno" runat="server" Text='<%# Eval("payoutno") %>' Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                HeaderText="Transaction No.">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtdraftno" runat="server" CssClass="form-control" Text='<%# Eval("paymenttrandraftno")%>'
                                        Style="max-width: 220px; min-width: 180px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtcomment" runat="server" CssClass="form-control" Text='<%# Eval("remarks") %>'
                                        Style="max-width: 220px; min-width: 180px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:HyperLinkField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                HeaderText="Modify" DataNavigateUrlFields="appmstid,paymenttrandraftid" DataNavigateUrlFormatString="modyfyrepayment.aspx?n={0}&amp;n1={1}"
                                Text="Modify" />
                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                DataField="paymenttrandraftid" HeaderText="payment Draft Id " />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Update" CssClass="btn btn-success" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
