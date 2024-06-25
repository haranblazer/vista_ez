<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="PinRequestReport.aspx.cs" Inherits="user_PinRequestReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        function printpage() {
            window.print()
        }
    </script>
    <script language="javascript" src="jquery.js" type="text/javascript"></script>
    <script language="javascript" src="main.js" type="text/javascript"></script>
    <script lang="javascript" src="../js/main.js" type="text/javascript"></script>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromdate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtTodate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });   
    </script>
    <style type="text/css">
        #tooltip
        {
            position: absolute;
            border: 2px solid red;
            background-color: #FFFFE1;
            padding: 2px 5px;
            text-align: left;
            font-family: arial;
            font-size: 12px;
            color: #000000;
            display: none;
            width: auto;
            height: auto;
        }
    </style>
    <div id="title" class="b2">
        <h2>
            Recharge Funds/ Wallet Request List</h2>
    </div>
    <table style="width: 100%">
        <tr>
            <td style="width: 150px">
                Request From :
            </td>
            <td>
                <asp:TextBox ID="txtFromdate" runat="server" CausesValidation="True" ToolTip="dd/mm/yyyy"
                    ValidationGroup="a" Width="175px"></asp:TextBox>
                &nbsp;&nbsp; To:&nbsp;&nbsp;<asp:TextBox ID="txtTodate" runat="server" CausesValidation="True"
                    ToolTip="dd/mm/yyyy" ValidationGroup="a" Width="180px"></asp:TextBox><asp:Button
                        ID="Button1" runat="server" CssClass="btn" OnClick="Button1_Click" Text="SHOW"
                        ValidationGroup="tv" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFromdate"
                    ErrorMessage="From date require." SetFocusOnError="True" ValidationGroup="a"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTodate"
                    Display="Dynamic" ErrorMessage="To date require." ValidationGroup="a"></asp:RequiredFieldValidator>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LblTotalRecord" runat="server" Font-Bold="True" EnableViewState="False"
                    Font-Size="Larger"></asp:Label>
                <asp:Label ID="LblAmount" runat="server" Font-Bold="True" EnableViewState="False"
                    Font-Size="Larger"></asp:Label>
                &nbsp;
            </td>
            <td width="200">
                <div class="btn-toolbar" style="float: right;">
                    <div class="btn-group dropup">
                        <asp:LinkButton ID="LinkButton1" OnClick="imgbtnWord_Click" CssClass="btn" runat="server"><i class="icol-page-white-word"></i> Word Export</asp:LinkButton>
                        <asp:LinkButton ID="LinkButton2" OnClick="imgbtnExcel_Click" CssClass="btn" runat="server"><i class="icol-page-white-excel"></i> Excel Export</asp:LinkButton>
                        <asp:LinkButton ID="LinkButton3" OnClick="imgbtnPdf_Click" CssClass="btn" runat="server"><i class="icol-doc-pdf"></i> PDF Export</asp:LinkButton>
                        <a href="javascript:void" onclick="printpage()" class="btn"><i class="icol-printer">
                        </i>Print</a>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <table style="width: 100%;">
        <tr>
            <td style="text-align: center">
                <asp:GridView ID="GridView1" DataKeyNames="srno" EmptyDataText="No data found." runat="server"
                    AllowPaging="True" AutoGenerateColumns="False" CssClass="mygrd" Width="100%"
                    OnPageIndexChanging="dglst_PageIndexChanging" PageSize="50" Font-Size="9pt" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="userid" HeaderText="UserId" />
                        <asp:BoundField DataField="fname" HeaderText="Name" />
                        <asp:BoundField DataField="pname" HeaderText="Product Name" />
                        <asp:BoundField DataField="amt" HeaderText="Amount" />
                        <asp:BoundField DataField="noofpin" HeaderText="Total Pins" />
                        <asp:BoundField DataField="redate" HeaderText="Request Date" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkbtnView" ToolTip='<%#Eval("payDetail") %>' Text="Payment Details"
                                    CssClass="tooltip" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server">Payment</asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="LinkButton1" CommandName="Aprove" CommandArgument='<%#Eval("srno") %>'
                                                runat="server" TabIndex="1" Text="Approve" OnClientClick="return confirm('Are you sure to approve the user?')"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="LinkButton2" CommandName="Reject" CommandArgument='<%#Eval("srno") %>'
                                                TabIndex="2" runat="server" Text="Reject" OnClientClick="return confirm('Are you sure to reject the user?')"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--   <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnPayment" CommandName="EditPayment" Visible='<%#Eval("visible") %>'
                                    Text="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
