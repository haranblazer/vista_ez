<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="adminpayout2.aspx.cs" Inherits="admin_adminpayout2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="head">
        <i class="fa fa-list"></i>Payment Reports</h2>
    <div class="panel panel-default">
        <br />
        <div class="col-md-12">
            <div class="form-group">
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Payout_Fillter" runat="server" CssClass="form-control">
                        <asp:ListItem Selected="True" Value="1">Dispatch & Release</asp:ListItem>
                        <asp:ListItem Value="0">Hold Payout</asp:ListItem>
                        <asp:ListItem Value="2">Release</asp:ListItem>
                        <asp:ListItem Value="-1">All Payout</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtUerid" runat="server" Placeholder="Search by userid..." CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-sm-1">
                    <asp:Button ID="btn_Search" runat="server" Text="Search" CssClass="btn btn-success"
                        Style="margin: 0 0 20px 0" OnClick="btn_Search_Click" />
                </div>
                <div class="col-sm-3">
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Placeholder="Send Remark to Members"
                        CssClass="form-control"></asp:TextBox>
                </div>
                  <div class="col-sm-2">
                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Submit / Modify Remark"
                        CssClass="btn btn-success" Style="margin: 0 0 20px 0" />
                </div>
                <div class="col-sm-2">
                  <asp:Button ID="Button3" runat="server" Text="Add User in This Payout" CssClass="btn btn-success"
                    OnClick="Button3_Click" />
                </div>
            </div>
          
            <hr />
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
                            <div class="col-md-12 text-left">
                                <p>
                                    <span class="label label-default " style="background-color: #fff; color: Black;">Dispatched
                                        Payout</span> <span style="background-color: #ffebea; color: Black;" class="label label-default ">
                                            Hold Payout</span> <span class="label label" style="background-color: #e2fbd7; color: Black;">
                                                Release Payout </span>
                                </p>
                            </div>
                            <asp:Label ID="Label3" runat="server" Font-Bold="True"></asp:Label>&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="GridView1" DataKeyNames="appmstid,paymenttrandraftno,remarks" runat="server"
                                AutoGenerateColumns="False" PageSize="2000" AllowPaging="True" CssClass="table table-striped table-hover mygrid"
                                OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging"
                                OnRowDataBound="GridView1_RowDataBound">
                                <Columns>
                                    <asp:HyperLinkField HeaderText="User Id" DataNavigateUrlFields="appmstid,paymenttrandraftid"
                                        DataNavigateUrlFormatString="modyfypayment.aspx?n={0}&amp;n1={1}" DataTextField="appmstid" />
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="name" HeaderText="Name" />
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="Totalearning" HeaderText="Total Income" />
                                    <%-- <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                DataField="paymentdisplay" HeaderText="Payment Display" />--%>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        HeaderText="Transaction No.">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hnd_IsPaid" runat="server" Value='<%#Eval("Ispaid") %>' />
                                            <asp:HiddenField ID="hnd_Iselegible" runat="server" Value='<%#Eval("iselegible") %>' />
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
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblpmid" runat="server" Text='<%# Eval("paymenttrandraftid") %>'></asp:Label>
                                            <%--<asp:Label ID="lbl_IsPaid" runat="server" Text='<%# Eval("Ispaid") %>'></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="PayMode" ReadOnly="True" HeaderText="Pay Mode" />
                                    <asp:TemplateField HeaderText="Payment Display">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkPD" runat="server" Text='<%# Eval("paymentdisplay") %>' CommandName="SH"
                                                CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'></asp:LinkButton>
                                            <asp:Label ID="lblPayoutno" runat="server" Text='<%# Eval("payoutno") %>' Visible="false"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--
                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                DataField="paymenttrandraftid" HeaderText="payment Draft Id " />--%>
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
                <br />
                <br />
            </div>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>
