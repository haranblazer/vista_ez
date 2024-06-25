<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="BeforPayout.aspx.cs" Inherits="winneradmin_BeforPayout" Title="Tentative Payout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <script>

        $(document).ready(function () {

            var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
            $('#<%=txtSearch.ClientID %>').autocomplete(dataUserID);
        });

    </script>
    <div id="title" class="b2">
        <h2>Tentative Payout</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>


    <table>

        <tr>
            <td>&nbsp;</td>
            <td>
                <table>
                    <tr>
                        <td style="width: 378px">
                            <asp:Panel ID="pnlDateRange" runat="server" DefaultButton="Button2">
                                From :
                        <asp:TextBox ID="txtFromDate" runat="server" Width="90px" TabIndex="1"></asp:TextBox>
                                To :
                        <asp:TextBox ID="txtToDate" runat="server" Width="90px" TabIndex="2"></asp:TextBox>

                                <asp:Button ID="Button2" OnClick="Button1_Click" runat="server" Text="Show List"
                                    ValidationGroup="Show" CssClass="btn" TabIndex="3"></asp:Button>
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:Panel ID="pnlUtility" runat="server" DefaultButton="btnSearch">
                                Search&nbsp;   
                                <asp:TextBox ID="txtSearch" runat="server" Width="105px" TabIndex="4"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" ValidationGroup="s"
                                    CssClass="btn" OnClick="btnSearch_Click" TabIndex="5"></asp:Button>

                                <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="50">50</asp:ListItem>
                                    <asp:ListItem Value="100">100</asp:ListItem>
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                                    OnClick="ibtnExcelExport_Click" />
                                <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
                                <asp:ImageButton ID="ibtnPDFExport" runat="server"
                                    ImageUrl="images/pdf.gif" OnClick="ibtnPDFExport_Click" />
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <strong><span style="font-size: 10pt; font-family: Arial">
                                <asp:Label ID="lblcount" runat="server" Font-Bold="True" ForeColor="#000000"></asp:Label>
                                Total Matching Income:</span>
                                <asp:Label ID="lblBinary" runat="server" Text="0" Font-Names="Arial"
                                    Font-Size="Small"></asp:Label>&nbsp;<span style="font-size: 10pt; font-family: Arial"><%-- &nbsp;&nbsp;,Total Matching Bounus:--%>
                                    </span>
                                <asp:Label ID="lblDirect" runat="server" Text="0" Font-Names="Arial"
                                    Font-Size="Small" Visible="false"></asp:Label><span style="font-size: 10pt; font-family: Arial">
                                        <%-- &nbsp;&nbsp;,Total Repurchase Income:--%></span>
                                <asp:Label ID="lblC" runat="server" Text="0" Font-Names="Arial" Visible="false"
                                    Font-Size="Small"></asp:Label>&nbsp;,<span
                                        style="font-size: 10pt; font-family: Arial; width: 100px;"><%--<asp:Label
                                            ID="lblR" runat="server" Text="" Font-Names="Arial"
                                            Font-Size="Small"></asp:Label>,--%>&nbsp;&nbsp;Total Income 
                :</span><asp:Label ID="lblAmt" runat="server" Text="0" Font-Names="Arial"
                    Font-Size="Small"></asp:Label>
                            </strong>&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="GridView1" CssClass="mygrd" runat="server"
                        EmptyDataText="Record not found." AutoGenerateColumns="False" CellPadding="4"
                        ForeColor="#333333" GridLines="None" PageSize="50" Width="900px"
                        AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging"
                        OnDataBound="GridView1_DataBound" OnRowDataBound="GridView1_RowDataBound" ShowFooter="true">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="appmstregno" HeaderText="User Id" />
                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="Name" HeaderText="Name" />
                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="AppMstMobile" HeaderText="Mobile No" />
                            <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="panno" HeaderText="Pan No." />


                            <asp:TemplateField HeaderText="Matching Income" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblBinaryAmount" Text='<%#Bind("binaryincome")%>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblBinarytotal" Font-Bold="true" runat="server"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                          <asp:TemplateField HeaderText="Repurchase Income" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblDirectAmount" Text="0" runat="server"></asp:Label></ItemTemplate>
                            </asp:TemplateField>


                           <%--     <asp:TemplateField HeaderText="Repurchase Income" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblCAmount" Text='<%#Bind("cincome")%>' runat="server"></asp:Label></ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblCAmounttotal" Font-Bold="true" runat="server"></asp:Label></FooterTemplate>
                            </asp:TemplateField>


                         <asp:TemplateField HeaderText="Reward Income" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblRAmount" Text='<%#Bind("rincome")%>' runat="server"></asp:Label></ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblRAmounttotal" Font-Bold="true" runat="server"></asp:Label></FooterTemplate>
                            </asp:TemplateField>--%>
                        </Columns>

                        <FooterStyle />
                        <RowStyle />
                        <EditRowStyle />
                        <SelectedRowStyle />
                        <PagerStyle />
                        <HeaderStyle />
                        <AlternatingRowStyle />
                    </asp:GridView>
                </asp:Panel>
            </td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please enter date in dd/mm/yy format!"
                    ControlToValidate="txtFromDate" Font-Bold="False" ForeColor="#C00000" ValidationGroup="Show"
                    Display="None"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                        ControlToValidate="txtFromDate" ErrorMessage="Please enter date in dd/mm/yy format!"
                        Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*"
                        Display="none" ValidationGroup="Show"></asp:RegularExpressionValidator>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtToDate"
                    ErrorMessage="Please enter date in dd/mm/yy format!" Font-Bold="False"
                    ForeColor="#C00000" ValidationGroup="Show" Display="None"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                        ControlToValidate="txtToDate" ErrorMessage="Please enter date in dd/mm/yy format!"
                        Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*"
                        Display="none" ValidationGroup="Show"></asp:RegularExpressionValidator>
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Show" Width="220px" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtSearch"
                    Display="None" ErrorMessage="Please enter user id!" ForeColor="#C00000" ValidationGroup="s"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtSearch"
                    Display="None" ErrorMessage="Only alpha numeric value without space is allowed!"
                    ForeColor="#C00000" ValidationGroup="s" ValidationExpression="^[a-zA-Z0-9]*"></asp:RegularExpressionValidator>
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="s"
                    ShowMessageBox="true" ShowSummary="false" />


            </td>
            <td>&nbsp;</td>
        </tr>
    </table>

    <div id="divUserID" style="display: none;" runat="server">
    </div>
</asp:Content>

