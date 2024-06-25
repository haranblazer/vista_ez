<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="WithDrawlRequest.aspx.cs" Inherits="admin_WithDrawlRequest"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromdate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtTodate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>

    <style type="text/css">
        #tooltip {
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
    <asp:ScriptManager ID="ScriptManager1"
        runat="server" />
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Cash withdraw request</h4>
    <div class="row">
        <div class="col-md-2 col-xs-9">
            <asp:TextBox ID="txtFromdate" runat="server" CausesValidation="True" CssClass="form-control"
                ToolTip="dd/mm/yyyy" ValidationGroup="a"></asp:TextBox>
        </div>

        <div class="col-md-2 col-xs-9 downlist">
            <asp:TextBox ID="txtTodate" runat="server" CausesValidation="True" CssClass="form-control"
                ToolTip="dd/mm/yyyy" ValidationGroup="a"></asp:TextBox>
        </div>

        <div class="col-md-2 col-xs-9 downlist">
            <asp:DropDownList ID="ddlReqType" runat="server" CausesValidation="True" CssClass="form-control"
                ValidationGroup="a">
                <asp:ListItem Value="1" runat="server">User</asp:ListItem>
                <%-- <asp:ListItem Value="2" runat="server">Franchise</asp:ListItem>--%>
            </asp:DropDownList>
        </div>

        <div class="col-md-1">
            <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" OnClick="Button1_Click"
                Text="Show" ValidationGroup="tv" />
        </div>


        <div class="col-md-2 col-xs-9">
            <asp:TextBox ID="txtChqNo" runat="server" CausesValidation="True" CssClass="form-control"
                ToolTip="Cheque No." ValidationGroup="a" placeholder="Enter Cheque No"></asp:TextBox>
        </div>

        <div class="col-md-2 col-xs-9">
            <asp:TextBox ID="txtRmk" runat="server" CausesValidation="True" CssClass="form-control"
                ToolTip="Remarks" ValidationGroup="a" placeholder="Enter Remarks"></asp:TextBox>
        </div>
        <div class="col-md-2 pull-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />&nbsp;
                        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />&nbsp;
                        <asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif" OnClick="imgbtnPdf_Click" />

            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFromdate"
                ErrorMessage="From date require." SetFocusOnError="True" ValidationGroup="a"></asp:RequiredFieldValidator>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTodate"
                Display="Dynamic" ErrorMessage="To date require." ValidationGroup="a"></asp:RequiredFieldValidator>

        </div>
    </div>

    <hr />
    <%--  <div class="col-md-2">
                        <asp:CheckBox ID="chkSelAll" runat="server" Text="Select All" OnCheckedChanged="chkSelAll_CheckedChanged">
                        </asp:CheckBox>
                    </div>--%>


    <%-- <div>
                <div class="form-group">
                    <div class="col-md-2">
                        <asp:Label ID="LblTotalRecord" runat="server" Font-Bold="True"></asp:Label>
                    </div>
                    <div class="col-md-2">
                        <asp:Label ID="LblAmount" runat="server" Font-Bold="True"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />--%>

    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class=" table-responsive">
                <asp:GridView ID="GridView1" DataKeyNames="withdrawid" EmptyDataText="No data found."
                    runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-striped table-hover" ShowFooter="true"
                    OnPageIndexChanging="dglst_PageIndexChanging" PageSize="50" Font-Size="9pt" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <%--  <asp:TemplateField HeaderText="" ItemStyle-Width="150px">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="CheckBox1" onclick="Checkall(this)" runat="server" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelOne" runat="server"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                            <FooterTemplate>Total:</FooterTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="userid" HeaderText="UserId" />
                        <asp:BoundField DataField="fname" HeaderText="Name" />
                        <asp:BoundField DataField="wamount" HeaderText="Withdrawal Amount" />
                        <asp:BoundField DataField="handling" HeaderText="Admin Charges" />
                        <asp:BoundField DataField="dispatch" HeaderText="Net Amount" />
                        <asp:BoundField DataField="RequestType" HeaderText="Request Type" />

                        <%--<asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink3" ToolTip='<%#Eval("payDetail") %>' runat="server" CssClass="tooltip">
                                                  <b> Payment</b> 
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Cheque No." ItemStyle-Width="110px">
                            <ItemTemplate>
                                <asp:TextBox ID="txtChq" runat="server" MaxLength="20" Text='<%# Eval("chequeno")%>' Width="110px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remarks" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <asp:TextBox ID="txtRem" runat="server" MaxLength="20" Text='<%# Eval("Remarks")%>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" CommandName="Aprove" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                    runat="server" TabIndex="1" Text="Approve" OnClientClick="return confirm('Are you sure to approve the user?')"></asp:LinkButton>
                                <br />
                                <asp:LinkButton ID="LinkButton2" CommandName="Reject" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                    TabIndex="2" runat="server" Text="Reject" OnClientClick="return confirm('Are you sure to reject the user?')"
                                    Style="color: red"></asp:LinkButton>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="doe" HeaderText="Request Date" />
                        <asp:BoundField DataField="BankName" HeaderText="Bank Name" />
                        <asp:BoundField DataField="Branch" HeaderText="Branch" />
                        <asp:BoundField DataField="AccountNo" HeaderText="A/c No." />
                        <asp:BoundField DataField="IFSCode" HeaderText="IFSCode" />

                    </Columns>
                    <HeaderStyle Font-Size="9pt" />
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.6').show();
        });
    </script>

</asp:Content>
