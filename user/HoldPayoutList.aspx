<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="user.master"
    CodeFile="HoldPayoutList.aspx.cs" Inherits="admin_PaidList" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <div class="site-content">
   <div class="panel-heading">
        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Hold Payout List</h2></div>
    <div class="panel panel-default">
        <br />
          <div id="MainContent_UpdatePanel1">
                    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <div class="col-sm-2">
                    <div class="input-group">
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="From"
                            ToolTip="dd/mm/yyyy"></asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                    <div class="clearfix">
                    </div>
                    <br />
                </div>
                <div class="col-sm-2">
                    <div class="input-group">
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="To"
                            ToolTip="dd/mm/yyyy"></asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                    <div class="clearfix">
                    </div>
                    <br />
                </div>
             <%--   <div class="col-sm-2">
                    <asp:TextBox ID="txtid" runat="server" ValidationGroup="p" CssClass="form-control"
                        placeholder="Search By User Id" ToolTip="Search By User Id"></asp:TextBox>
                    <div class="clearfix">
                    </div>
                    <br />
                </div>--%>
                <div class="col-sm-2">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="margin-left: 0px"
                        Width="70px" Text="Submit" />
                    <div class="clearfix">
                    </div>
                    <br />
                </div>
                <div>
                    <label for="MainContent_txtPassword" class="col-sm-1 control-label">
                        Page Size:</label>
                    <div class="col-sm-1">
                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged"
                            CssClass="form-control" Width="70px">
                            <asp:ListItem Value="25">25</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>
                            <asp:ListItem Value="All">All</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
            </div>
         
            <div class="col-sm-2 pull-right">
                <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                    Width="25px" />
                <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                    Style="margin-left: 0px" Width="26px" />
                <%--<asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="~/admin/images/pdf.gif"
                        OnClick="imgbtnpdf_Click" />--%>
            </div>
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="center" style="height: 50px; text-align: left" valign="middle">
                        <asp:Label ID="Label2" runat="server" Font-Bold="true" ForeColor="Green" />
                    </td>
                </tr>
                <tr>
                    <td align="center" style="text-align: center;" valign="top">
                    </td>
                </tr>
            </table>
            <div class="table-responsive">
                <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="dglst" runat="server" AllowPaging="True" CssClass="table table-striped table-hover"
                        Font-Names="Arial" Font-Size="Small" ForeColor="#333333" CellPadding="4" CellSpacing="1"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" PageSize="50"
                        Width="100%" EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red"
                        AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging" OnRowDataBound="dglst_RowDataBound"
                        OnRowCommand="dglst_RowCommand" OnRowCreated="dglst_RowCreated" ShowFooter="true">
                        <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %></ItemTemplate>
                                <ItemStyle Font-Bold="True" Height="20px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="userid"></asp:BoundField>
                            <asp:BoundField DataField="name"></asp:BoundField>
                            <asp:BoundField DataField="Amount" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                            </asp:BoundField>
                            <asp:BoundField DataField="Direct" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                            </asp:BoundField>
                            <asp:BoundField DataField="Binary" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                            </asp:BoundField>
                            <asp:BoundField DataField="LDLGold" HeaderText="Gold" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LDLDiamond" HeaderText="Diamond" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LDLEmperor" HeaderText="Emperor" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LDLCrown" HeaderText="Crown" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LtheLDLGold" HeaderText="Gold" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LtheLDLDiamond" HeaderText="Diamond" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LtheLDLEmperor" HeaderText="Emperor" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LtheLDLCrown" HeaderText="Crown" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
            <div class="clearfix">
            </div>
            <br />
        </div>
        </div></div>
        <div class="clearfix">
        </div>
    </div>
    </div>
</asp:Content>
