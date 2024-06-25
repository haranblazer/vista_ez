<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="DocApprovelList.aspx.cs" Inherits="admin_DocApprovelList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="title" class="b2">
        <h2>
            Doc Approvel List</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <table style="width: 100%;">
        <tr>
            <td style="text-align: center">
                <asp:Label ID="lbl_msg" runat="server" ForeColor="Red" EnableViewState="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <link rel="stylesheet" href="../legal/dg-picture-zoom.css">

                <script type="text/javascript" src="../legal/mootools-1.2.4-core-yc.js"></script>

                <script type="text/javascript" src="../legal/mootools-more.js"></script>

                <script type="text/javascript" src="../legal/dg-picture-zoom.js"></script>

                <script type="text/javascript" src="../legal/dg-picture-zoom-autoload.js"></script>

                <asp:GridView ID="StartGrid" runat="server" AutoGenerateColumns="false" CssClass="mygrd"
                    OnRowCommand="StartGrid_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="User Name">
                            <ItemTemplate>
                                <asp:Label ID="lbl_userName" Text='<%# Eval("appmstRegNo") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pan No">
                            <ItemTemplate>
                                <asp:TextBox ID="txt_PanNo" runat="server" Text='<%# Eval("panno")%>' MaxLength="10"
                                    Width="150px" CssClass="txtBox"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pan Image" ItemStyle-Width="70px">
                            <ItemTemplate>
                                <asp:Image ID="Img_IDP" runat="server" class="dg-picture-zoom" ImageUrl='<%# "../idProof/" + Eval("IDP") + "?url=../idProof/" + Eval("IDP")%>'
                                    ToolTip="ID Card Photo" Width="70px" Height="60px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="IDP Image" ItemStyle-Width="70px">
                            <ItemTemplate>
                                <asp:Image ID="Img_Pan" runat="server" class="dg-picture-zoom" ImageUrl='<%# "../panCard/" + Eval("PAN") + "?url=../panCard/" + Eval("PAN")%>'
                                    ToolTip="Pan Card photo" Width="70px" Height="60px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Option">
                            <ItemTemplate>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:LinkButton ID="lnlbtn_approve" runat="server" Text="Approv" CommandName="Approved"
                                    CommandArgument='<%#Eval("appmstRegNo") %>' Font-Bold="true" ForeColor="DarkCyan"
                                    ToolTip="Approve"></asp:LinkButton>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:LinkButton ID="lnlbtn_Reject" runat="server" Text="Reject" CommandName="Reject"
                                    CommandArgument='<%#Eval("appmstRegNo") %>' Font-Bold="true" ForeColor="DarkRed"
                                    ToolTip="Reject"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
